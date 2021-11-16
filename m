Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD8FC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 19:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6E1F61AF7
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 19:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbhKPTFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 14:05:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62268 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239514AbhKPTFI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 14:05:08 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F50AFA784;
        Tue, 16 Nov 2021 14:02:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5FkYV1ThXdGg88p9pV127KHUz8ueusW95Nwzeb
        4kdxI=; b=Ogpt2V9XxFFCA84tyJDJywUuLD4Vc0qLzDrrIQSK3lIjpMQCtn340n
        yTTp16rZgb/W5BYq1M7vH/6YnosxpH3AdiaRarBR/XvlLCG2FA/ZjLPX364dXYbA
        vkqgyVry23Q491GJw2VPKdvtKLOUeImVOTZrZewdnqJ8PGNp5Y+is=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 76108FA783;
        Tue, 16 Nov 2021 14:02:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C04FCFA782;
        Tue, 16 Nov 2021 14:02:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] Add a test balloon for C99
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
        <xmqqy25pj43a.fsf@gitster.g>
        <YZLh/1xkxRGDn76u@camp.crustytoothpaste.net>
Date:   Tue, 16 Nov 2021 11:02:08 -0800
In-Reply-To: <YZLh/1xkxRGDn76u@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Mon, 15 Nov 2021 22:41:03 +0000")
Message-ID: <xmqqpmqzapqn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B333458A-470F-11EC-AA46-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2021-11-15 at 07:00:25, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> 
>> > Even for users who would like to target an older version of Windows,
>> > such as the no longer supported Windows 7, GCC and Clang are available.
>> > The LLVM suite, including Clang, is available pre-compiled for download
>> > free of charge.  Using a different compiler is specifically proposed by
>> > Microsoft staff[1] as a solution for users who wish to build modern
>> > programs for MSVC versions which do not support modern C.
>> >
>> > As such, we can assume that Git can be safely compiled with C99 or C11
>> > support on all operating systems which receive security support, and
>> > even some which do not.  Our CI confirms that this series passes all
>> > tests.  Let's introduce a test balloon which checks for this support and
>> > fails with an error message if it is absent.
>> 
>> I do not have much against adopting nicer C99 language features in
>> principle, but I hope that we are not becoming too Linux centric
>> with "other than Linux, as long as Windows is OK in some form,
>> everything is peachy" mentality.
>
> It's definitely not my goal to exclude Windows here.  I'm pretty sure
> every major Unix platform will handle this fine, and an up to date
> MSVC will also handle this fine.
>
> Because compiling Git for Windows is a lot of work (not due to any
> failing of that project or its members, just the fact that it requires a
> lot of components to be assembled, including a full POSIX environment),
> it's not very likely we're going to see a lot of people doing it, since
> almost all Windows users are going to be using the regular releases.
> It's also likely that they're going to be using some automated CI system
> which will likely support a recent version of the compiler.
>
> However, we have in the past heard screaming from people who want to
> support old versions of Windows, so my point here is that there are
> options if they can't use MSVC for any reason and those options are
> easy, accessible, and free of charge.  I should point out that we
> already require people on non-Linux Unix systems to install GNU make and
> possibly also a shell (if theirs doesn't support the local keyword), so
> installing suitable tooling to build Git isn't without precedent.

Windows does not need me to worry about them---they can fend for
themselves.  I cannot tell if the original discussion behind the
patch considered the current situation in non-mac BSD land (which I
am not familiar with), or even less common platforms like NonStop.
