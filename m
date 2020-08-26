Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21729C433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 16:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E29A42080C
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 16:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iz0bbv4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgHZQae (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:30:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64864 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgHZQaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 12:30:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9802BE6A3D;
        Wed, 26 Aug 2020 12:30:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o7gmf5Ifc1IowIYCc20O3vRlVKY=; b=iz0bbv
        4BD/3fv0PZC8IxZo0C0ywGDKhXP9ayPnKFzn8B/djrwAqHHrykLrzuV+Xc9gRlZr
        2mI+txlfkmdgZOm5DVoqOmhuNJ6seZIS2t6lP2Kv8SiLsOvwcobPKlP/APY4UjzI
        4lzeie2kkJS1vCinXwzpClmRAxVBWhp77XA9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wVHYb7/vP8sSUSKTdF6QTvpzQGDjY5qm
        LCz9go0Vr30yY6Vlt4UvmFyIFoDJDImvmbYFXlkGF3pyMrhPN3yrOJ8ZuTljW2Ml
        r2ZVgetMUtj8L0LTNMNGpTsnCWSfNLasvZ3vJIN6AZu8hh/m6Rwo1t012RAPVs85
        t6+LMMf7ZqQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9103AE6A3C;
        Wed, 26 Aug 2020 12:30:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D71F5E6A3B;
        Wed, 26 Aug 2020 12:30:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 3/3] git: catch an attempt to run "git-foo"
References: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>
        <20200826011718.3186597-1-gitster@pobox.com>
        <20200826011718.3186597-4-gitster@pobox.com>
        <nycvar.QRO.7.76.6.2008261004120.56@tvgsbejvaqbjf.bet>
Date:   Wed, 26 Aug 2020 09:30:11 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2008261004120.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 26 Aug 2020 10:06:20 +0200 (CEST)")
Message-ID: <xmqqh7spwess.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A70C5A4-E7B9-11EA-8421-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Tue, 25 Aug 2020, Junio C Hamano wrote:
>
>> If we were to propose removing "git-foo" binaries from the
>> filesystem for built-in commands, we should first see if there are
>> users who will be affected by such a move.  When cmd_main() detects
>> we were called not as "git", but as "git-foo", give an error message
>> to ask the user to let us know and stop our removal plan, unless we
>> are running a selected few programs that MUST be callable in the
>> dashed form (e.g. "git-upload-pack").
>>
>> Those who are always using "git foo" form will not be affected, but
>> those who trusted the promise we made to them 12 years ago that by
>> prepending the output of $(git --exec-path) to the list of
>> directories on their $PATH, they can safely keep writing
>> "git-cat-file" will be negatively affected as all their scripts
>> assuming the promise will be kept are now broken.
>
> It might be a good idea to also instrument the existing scripts, to show
> the same warning unless they were called through the `git` binary.
>
> _If_ we were to do this ;-)

Sure.  

I am not the advocate for removing builtins from on-disk, though.
The burden of proof... ;-)


