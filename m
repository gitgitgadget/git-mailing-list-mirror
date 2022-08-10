Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B06C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 17:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbiHJRtF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 13:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbiHJRsh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 13:48:37 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9B88FD56
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 10:48:20 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8C03131BC8;
        Wed, 10 Aug 2022 13:48:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F9V+6Gil8T+Ux43gW8cLi5LoWYFcaypAq4L13g
        U+ZeY=; b=bf4yEIQQXl2iYbRXZ/X8lKlfXRrJd56Ynjf5sYvjAe4QQy+OsgKXGU
        J1+P6Pcl7tla6zUPI57nnNI2MeRGSPCWEVpxOnU5MfyzJ9b7bIj3RUGAtWnscz3Z
        /SH0jgVtYRWi7KlbJrCLqATCC21ccMaMVaVkPS5UCbfWpwTVi0cns=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D02E9131BC7;
        Wed, 10 Aug 2022 13:48:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 451D8131BC4;
        Wed, 10 Aug 2022 13:48:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/5] cmake: align CTest definition with Git's CI runs
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
        <9cf14984c0a71b1ccdff7db0699571bf5af1209b.1660143750.git.gitgitgadget@gmail.com>
Date:   Wed, 10 Aug 2022 10:48:16 -0700
In-Reply-To: <9cf14984c0a71b1ccdff7db0699571bf5af1209b.1660143750.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 10 Aug 2022
        15:02:26 +0000")
Message-ID: <xmqqczd8m1lr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D813D22-18D4-11ED-BDD9-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> While at it, enable the command trace via `-x` and verbose output via
> `-v`, otherwise it would be near impossible to diagnose any problems.

This sounds like a completely unrelated change.  Do the tests behave
so differently here, compared to how they are run in t/Makefile,
where -vx is not the default?

The only plausible reason I can think of that this change "while at
it" is justifiable as part of the other change is if this is only
ever used in the CI environment and no interactive human would be
sitting in front of the session that runs tests here.  If that is
the case, I do agree it would make sense, since it would be much
less convenient to go back to a failing test and rerun it with -v
or -x or whatever.  But that needs to be explained in the proposed
log message.

Thanks.


> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/buildsystems/CMakeLists.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 1b23f2440d8..4aee1e24342 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -1088,7 +1088,7 @@ file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
>  #test
>  foreach(tsh ${test_scipts})
>  	add_test(NAME ${tsh}
> -		COMMAND ${SH_EXE} ${tsh}
> +		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
>  		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
>  endforeach()
