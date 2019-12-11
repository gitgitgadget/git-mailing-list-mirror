Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35954C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 22:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C793021556
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 22:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TBPjmyVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLKWmb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:42:31 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64539 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfLKWmb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 17:42:31 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4BA0A95881;
        Wed, 11 Dec 2019 17:42:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P4DpcGUhCXTgYjaolw5YTs5//Ck=; b=TBPjmy
        VpnCf7P39JTKb35iykg2EwjQE+d/f21EMSyhMO0V7YnrGsA3AiA6QT7QUsMNchMY
        m1VfwCakT7/4UDCStaIhIMFPEpRAkLh+Eu6fJUTVyywjwcSWILot5cMGeEiJa5n7
        /B2AyKJvP7Cv5FjD3zuIxHiDTnz04rxQ444H0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YYi5ISAA2EVzEKZxXJApsCFliC494YmT
        RgJ3j+u353PQnzhZ6/09aA3ioy/UgpeJ5oc64FxxWUc8NUCutOHSt5Vx4qia70B4
        850nXJNPpm4tDwbt2nPqZ3elyfH7dr5Cyv26H/7V6rbGI2gIH8ajukfT6crMfhKn
        4cr7zlHTBh4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 43E0D95880;
        Wed, 11 Dec 2019 17:42:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5D98D9587D;
        Wed, 11 Dec 2019 17:42:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r?= =?utf-8?Q?=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 0/6] configuration-based hook management
References: <20191210023335.49987-1-emilyshaffer@google.com>
Date:   Wed, 11 Dec 2019 14:42:24 -0800
In-Reply-To: <20191210023335.49987-1-emilyshaffer@google.com> (Emily Shaffer's
        message of "Mon, 9 Dec 2019 18:33:29 -0800")
Message-ID: <xmqqo8wemqlr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8141B3BA-1C67-11EA-AC81-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> An implementation of the first piece of the proposal given in
> lore.kernel.org/git/20191116011125.GG22855@google.com.
>
> Teaches a new command, 'git hook', which will someday include 'git hook
> --add ...', 'git hook --edit ...', and maybe more. For now, just teach
> it how to check the config files with 'git hook --list ...'.
>
> The hooks-to-run list is collected in a new library, hook.o, which can
> someday reimplement find_hook() or otherwise be invoked to run all hooks
> for a given hookname (e.g. "pre-commit").

Nice to see the endgame vision upfront.

A few things that I'd like to see in the endgame that you did not
mention here are:

 - We may probably not want to have an authoritative "these are the
   hooks Git runs" catalog, so it would be great if the resulting
   system can operate without one.

 - There are at least two kinds of hooks wrt the style of input they
   take.  Some take their input on their command line, which makes
   it quite easy to run multiple of them in a row.  Others take
   their input from their standard input stream, which probably
   means that there needs a cache of the input stream to feed to
   each such hook script (unless Git process itself is generating
   the stream to drive the hook, in which case we could run the
   generation of the stream multiple times) if we want to run
   multiple of them.  

   . With the design goal of *not* having an authoritiative catalog,
     we'd probably need some way to annotate each entry in the [hook]
     configuration which kind of invication the hook program wants.

   . There may be more than the above two styles.  The system should
     be designed to be extensible to accomodate yet more.


Thanks.
