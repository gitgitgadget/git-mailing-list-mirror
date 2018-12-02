Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60EEF211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 19:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbeLBThM (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 14:37:12 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54629 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbeLBThM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 14:37:12 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4E6F919161;
        Sun,  2 Dec 2018 14:37:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n10yyl6+XYcxJTeuYSyTjTN5Ev4=; b=sMOeRq
        HItJAkuh5/QepnkooWyLTP41zst+vs//NIVZiIvF4xcm6eM7huKKI4ug1Q1Av50q
        EZjfQt3sLM2esvbkJ8opCBuE5tIe0Mtc3CDqEc8K30lIERUJFJSr/sn7BXEurj5/
        sx3LLABdss04BBMIS2D5IS9KmWgZJ86+uTwxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TSFhj3DyLuCuHBgEQYFaBKs/6aKjYzzF
        8zC/kDetKBptHWYFpOMH9BdM9RsnrKFHeLZzCDyPOJ8vx8k+vCUhe2EOqUrAfO9I
        DfWlgsAZzsmKoJkKu1abexBvzTdYgTg9T85/D6WqJl2hr5J40eAG8ccYaru0NQG/
        Gfou5SPCd1M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 487A019160;
        Sun,  2 Dec 2018 14:37:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5B3F51915E;
        Sun,  2 Dec 2018 14:37:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     =?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?= 
        <avarab@gmail.com>,
        "'Cameron Boehmer'" <cameron.boehmer@gmail.com>,
        <git@vger.kernel.org>
Subject: Re: [RFC] git clean --local
References: <CAM+q9MeVS1e11vzu+-RP-i5NhSsnRz=x21q3gcGy8L62yceiMw@mail.gmail.com>
        <87woosukkm.fsf@evledraar.gmail.com>
        <004101d48a65$afb0da40$0f128ec0$@nexbridge.com>
Date:   Mon, 03 Dec 2018 04:37:03 +0900
In-Reply-To: <004101d48a65$afb0da40$0f128ec0$@nexbridge.com> (Randall
        S. Becker's message of "Sun, 2 Dec 2018 12:37:18 -0500")
Message-ID: <xmqqk1kriuu8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A61FD6C8-F669-11E8-9B24-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:


> Would something like git clean --exclude=file-pattern work as a
> compromise notion? Files matching the pattern would not be cleaned
> regardless of .gitignore or their potential preciousness status
> long-term. Multiple repetitions of the --exclude option might be
> supportable. I could see that being somewhat useful in scripting.

I think "git clean" already takes "-e", but I am not sure if it is
meant to do what you wrote above.

If "git clean" takes a pathspec, perhaps you can give a negative
pathspec to exclude whatever you do not want to get cleaned,
something like

	git clean '*.o' ':!precious.o'

to say "presious.o is ignored (hence normally expendable), but I do
not want to clean it with this invocation of 'git clean'"?
