Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583F5C433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 04:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358563AbiFPEFd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 00:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346612AbiFPEFb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 00:05:31 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE471424B3
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 21:05:26 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 93C941AAB5F;
        Thu, 16 Jun 2022 00:05:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xHHm3rKYjNyZaepluPkGbx2kEbq07R5suFp2ta
        501Kc=; b=MR7M4hv609JaVK1ijurTBG0lO9sH/7YaXnIpJLYytHTw+tYtSkenkJ
        aI+Flsjr5mHl02SrK2u3rhQBtOsr/VnWca07j18JnIdLrKkSS9hJHm0UQ28hL7/N
        Bz+JlKFqKp0TGV/oOdokI0Qo+Nd5YCLOZBfwV32ANO9Yb36H+QbfM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C4DA1AAB5E;
        Thu, 16 Jun 2022 00:05:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 34C841AAB5A;
        Thu, 16 Jun 2022 00:05:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/11] Coverity fixes
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 21:05:21 -0700
In-Reply-To: <pull.1264.git.1655336146.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 15 Jun 2022 23:35:34
        +0000")
Message-ID: <xmqqo7ytxnge.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8AF3E87A-ED29-11EC-8532-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> The release window is a fine time to concentrate on bug fixes,

Well, it certainly is better than random shiny new features or
refactoring for the sake of refactoring, but finding and fixing a
bug that has been with us since forever without anybody noticing is
not all that ultra-urgent, either ;-)

It is a good time to concentrate on finding and fixing regressions.

> and Coverity
> can help identify bugs. These are only a couple of fixes, Coverity reported
> many more, but most of the reports seemed either bogus or harmless (such as
> resource leaks in test helpers).

Thanks.

>
> Johannes Schindelin (11):
>   mingw: avoid accessing uninitialized memory in `is_executable()`
>   fsmonitor: avoid memory leak in `fsm_settings__get_incompatible_msg()`
>   submodule--helper: avoid memory leak in `update_submodule()`
>   get_oid_with_context_1(): avoid use-after-free
>   submodule-config: avoid memory leak
>   pack-redundant: avoid using uninitialized memory
>   submodule--helper: avoid memory leak when fetching submodules
>   read_index_from(): avoid memory leak
>   pack-mtimes: avoid closing a bogus file descriptor
>   relative_url(): fix incorrect condition
>   bug_fl(): add missing `va_end()` call
>
>  builtin/pack-redundant.c    | 1 +
>  builtin/submodule--helper.c | 3 +++
>  fsmonitor-settings.c        | 8 ++++++--
>  object-name.c               | 6 ++++--
>  pack-mtimes.c               | 3 ++-
>  read-cache.c                | 6 +++---
>  remote.c                    | 2 +-
>  run-command.c               | 2 +-
>  submodule-config.c          | 8 ++++----
>  usage.c                     | 1 +
>  10 files changed, 26 insertions(+), 14 deletions(-)
>
>
> base-commit: 8168d5e9c23ed44ae3d604f392320d66556453c9
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1264%2Fdscho%2Fcoverity-fixes-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1264/dscho/coverity-fixes-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1264
