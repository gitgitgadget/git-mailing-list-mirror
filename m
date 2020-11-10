Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B320BC388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 17:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5027420781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 17:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KbQiK2vt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbgKJRau (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 12:30:50 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52399 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgKJRat (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 12:30:49 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B085105B7E;
        Tue, 10 Nov 2020 12:30:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ADCgzt7GQ0ZbEfWg3469ZFZWaaw=; b=KbQiK2
        vt3hkXZb20zc5Cv146xsHbHo96pWHp3kDdYF62MN+uvKRSFnW384Io7yA/siFYKV
        DGbGDuGSraNtNYYgCYCM5Mw90jWyDU6gUN8LNtr9Ked4imWC63da8zV925/X0Qhi
        UAu/DBcXkgxjZn+Kk5TeYd5YXkDCa/DxOTtyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YmE2rLserJ+eZ6pmvigF6gccYUD67NrC
        81Xi71AbOWZ7H3sruij3v772gz+aU3nxcTjef6407lw/JWX58nkuBKXC19pObipH
        bTbccDsK7lLP6KnP32I0IZMr1CfNIGZJja3pwsmb9f+VPJr4O3l4XIr5vU8plRnD
        1R3cURnxYPU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 03251105B7C;
        Tue, 10 Nov 2020 12:30:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 450ED105B7B;
        Tue, 10 Nov 2020 12:30:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Daniel Gurney <dgurney99@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2] compat/bswap.h: simplify MSVC endianness detection
References: <20201107234751.10661-1-dgurney99@gmail.com>
        <20201108095739.23144-1-dgurney99@gmail.com>
        <20201110003127.GA1268480@coredump.intra.peff.net>
        <20201110023620.GH6252@camp.crustytoothpaste.net>
        <xmqqft5h92fm.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2011101500370.18437@tvgsbejvaqbjf.bet>
        <f41271c0-973d-ee3f-9535-d7fbc5b073cf@gmail.com>
        <nycvar.QRO.7.76.6.2011101643460.18437@tvgsbejvaqbjf.bet>
        <xmqqy2j96sd4.fsf@gitster.c.googlers.com>
Date:   Tue, 10 Nov 2020 09:30:43 -0800
In-Reply-To: <xmqqy2j96sd4.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 10 Nov 2020 09:20:39 -0800")
Message-ID: <xmqqtutx6rwc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76EA76FC-237A-11EB-B082-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> As a maintainer, I am less concerned about the "result today" than I am
>> about keeping things easy and effortless to maintain. One of your patches
>> accomplishes that. The other one made it into `next`:
>> https://github.com/git/git/commit/91a67b86f77
>
> I do not think reverting it and requeuing
>
> https://lore.kernel.org/git/20201107221916.1428757-1-dgurney99@gmail.com/
>
> would help future folks why we ignore _MSC_VER as any sign usable to
> detect endianness, so I'd prefer to see a patch *on top* of 1af265f0
> (compat/bswap.h: simplify MSVC endianness detection, 2020-11-08),
> which is 91a67b86f77^2, that explains why we prefer to list archs
> explicitly in its log message, which would be the primary value of
> that commit.
>
> Something along this line, perhaps?
>
> -- >8 --
>
> Subject: compat/bswap.h: do not assume MSVC is little-endian only
>
> Earlier, with 1af265f0 (compat/bswap.h: simplify MSVC endianness
> detection, 2020-11-08), we tried to simplify endianness detection
> used in compat/bswap.h by assuming that any version Git compiled by
> MSVC (detected by _MSC_VER preprocessor macro) is meant to run on
> little endian boxes, as the versions of old MSVC that support m68k
> and MIPS do not support some C99 features used in the codebase
> anyway.
>
> While it might hold true that modern versions of Windows are all
> little-endian, MSVC is and/or can be ported to build for big-endian
> boxes, so tying _MSC_VER with endianness is a bit too restrictive.
>
> Let's go back to the old way to use _MSC_VER to learn what
> preprocessor macros compiler uses to tell us which arch we are
> building for, and list these arches that are little-endian
> explicitly.
>
> ... signed-off-by from you and helped-by from others ...
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>     diffstat
>     patch

Daniel's patch adds _M_ARM64 to the list, but do we need to do
anything further to tell the endian on such a bi-endian arch, or
does MSVC only support little-endian for that architecture?  

Just double-checking as the "confusion" that started this thread
came from an assumption that MSVC == Windows == big-endian, and you
told us MSVC != Windows.  Now the patch assumes ARM64-on-MSVC is
little-endian only and we want to make sure that assumption is true.

And perhaps it is worth documenting in the log, perhaps

	... that are little-endian explicitly.  Note that ARM64 is
	bi-endian in nature but we treat it little-endian as MSVC
	does not treat the arch as bi-endian.

or something like that at the end (I do not know what MSVC actually
does---just illustrating the level of details I expect in the
explanation).

Thanks.
