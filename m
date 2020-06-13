Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004E8C433E0
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 18:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F8520789
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 18:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="se2WLYJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgFMSuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 14:50:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50784 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgFMSuB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 14:50:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 605B4D85D1;
        Sat, 13 Jun 2020 14:49:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FBC7Fcq/qBGvgIEfZl4MLNLPKFA=; b=se2WLY
        J4SNJPXwGyCeb6vtEbsCkw3cbjlQJwKQsmEYWec2giL79dEZpD/Z0ab/Sfb5lZ4o
        3ZyQBXLm+/Ek8CmwvHBF/IXaPzXG0iBe1dR/RNERzcro5QNjHZTEedq+SV1M39+D
        SI+myRGj0bjVHvH/I5s1OH4qcOsrg6DjSrhJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O01hRZEvqoEb7sWxUhRWdTc4n0Deo23w
        wxI0DHFHR3aRi9aQ4wTMMeNP/N64HUAyJhIxbnwBgf98gsLbSzow6YwcRscoD7Lo
        L+v+PYs8jjsIj3EebrbAsSJaX0IbTMS92NYQL0lPmOOzIZAzW4KGBLntaDEgEblj
        24d7cxemf3o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57BF0D85CF;
        Sat, 13 Jun 2020 14:49:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9E87AD85CD;
        Sat, 13 Jun 2020 14:49:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, Matt Rogers <mattr94@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com, Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH 8/9] fast-export: respect the possibly-overridden default branch name
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com>
        <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com>
        <20200610233912.GU6569@camp.crustytoothpaste.net>
        <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com>
        <xmqq3672cgw8.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006111559300.56@tvgsbejvaqbjf.bet>
        <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006121451100.56@tvgsbejvaqbjf.bet>
        <xmqqy2os2u55.fsf@gitster.c.googlers.com>
        <405521ec-aed7-ff76-5b48-70e9d11018e6@kdbg.org>
        <xmqqv9jvylt7.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006131645380.56@tvgsbejvaqbjf.bet>
Date:   Sat, 13 Jun 2020 11:49:53 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2006131645380.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sat, 13 Jun 2020 16:47:59 +0200 (CEST)")
Message-ID: <xmqqeeqiztpq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC6453D8-ADA6-11EA-9951-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> A corrected code should return a hardwired constant 'main' (it
>> probably gets behind a C preprocessor macro, but the point is that
>> we do not want end-user customization) for the reason stated in that
>> message.
>
> I like `ref0` better, for two reasons:
>
> - it is more consistent to just have all anonymized branches be named
>   `ref<N>`, and
>
> - using `main` both for an original `main` and an original `master` can be
>   a bit confusing, as the reader might assume that this branch name (as it
>   does not follow the `ref<N>` convention) was _not_ anonymized, when it
>   very well might have been.

A pro for keeping a hardcoded 'master' is that it is compatible with
the current world order, and flipping it to hardcoded 'main' upon
transition is just to use the moral equivalent, so we do not need to
immediately have to change anything.  The _new_ consistency across
ref<N> does feel attractive, but because it is new, there always is
a pushback not to "fix" what is not broken.

I am personally OK either way.  

By the way, we'd need to devise a transition plan for switching the
default branch name (i.e. the name used for the primary branch in a
newly created repository unless the user configures it to some other
value) to 'main' (oh, I just found one reason why I will not want to
use that name in my project(s)---it is too close to 'maint').  

It might roughly go like:

 1. We introduce core.defaultBranchName; when it is not set, its
    value defaults to 'master' in the 1st phase of the transition.
    "git init" and "git clone" however issue a warning that says
    "unless you configure core.defaultBranchName, we use 'master'
    for now for backward compatibility but we will start using
    'main' in three major releases of Git in the future".  These
    commands use the default branch name when creating a new
    repository in the 1st phase, and set core.primaryBranchName to
    that name in the resulting repository.

    This is to encourage early adopters to set it to 'maint'^W'main'
    (eek, see, I again made that typo), while allowing those who
    have toolset that depends more heavily on the current default
    branch name than other people to set it to 'master' for
    stability.

    In the 1st phase, a few commands that care about what the
    primary branch is in a repository (i.e. fmt-merge-msg and
    fast-export are the two we have identified so far) pay attention
    to the core.primaryBranchName configuration, and default to
    'master' if the configuration does not exist.  

    These commands issue a warning that says "unless you configure
    core.primaryBranchName in the repository, we use 'master' for
    now but we will start using 'main' in three major releases of
    Git in the future".

    The above two warning messages will be squelched once the user
    sets respective configuration variable.

 2. We flip the default for the two variables from 'master' to
    'main' in three major releases of Git (i.e. 24-30 weeks from the
    1st phase).  The two warning messages added for the 1st phase
    will be reworded for the updated default.  We no longer need to
    say "in three major releases" in there.

 3. After long time passes, remove the warning.

