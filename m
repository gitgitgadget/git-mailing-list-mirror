Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967FBC433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 05:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74C61611CB
	for <git@archiver.kernel.org>; Mon,  3 May 2021 05:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhECFhE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 01:37:04 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51047 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhECFhD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 01:37:03 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C95E114A34;
        Mon,  3 May 2021 01:36:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zol+zPUHdbNnRlIMYc3LTC3gQHZcs9ddESYBRs
        2Me7I=; b=tkf3XBPaA3ssCGXtGNEPFApDoG0d6oooq9hnNvpFajuYYvfI690PzM
        0vvx9u6dRvUzdPgjYm3sG1dUq7ssDyzj7Ea2zC9NfvUa3vHb8FwcX+IVXNjtYaHv
        RKm7K9S6Ub5QZsbxe3f6Wp8gCqA04jc9LfefsZ8hfHks1D75emB4I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 35D62114A33;
        Mon,  3 May 2021 01:36:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 799EF114A2E;
        Mon,  3 May 2021 01:36:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/9] leftover bits from symlinked gitattributes, etc topics
References: <YI12hK4X/gfl3u29@coredump.intra.peff.net>
Date:   Mon, 03 May 2021 14:36:06 +0900
In-Reply-To: <YI12hK4X/gfl3u29@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 1 May 2021 11:40:52 -0400")
Message-ID: <xmqqfsz48jll.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 763CB686-ABD1-11EB-8BCE-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> A while back, I had a topic[1] that treated symlinked .gitattributes
> (and .gitignore and .mailmap) the same as .gitmodules: forbidding them
> in the index, complaining about them via fsck, etc.
>
> In the end, we decided not to do that[2], and instead just open the
> files with O_NOFOLLOW instead. As I said in that thread, we could
> salvage some of the cleanups, fsck checks, and docs from the original
> topic. So here that is. (The new topic is in master but not yet
> released; so while this is not strictly a bug-fix for an existing topic,
> it would be good to get especially the doc improvements into the same
> release).

Thanks.


> [1] https://lore.kernel.org/git/20201005071751.GA2290770@coredump.intra.peff.net/
> [2] https://lore.kernel.org/git/YDiWs6yyv3U9YvC2@coredump.intra.peff.net/
>
> The patches are:
>
>   [1/9]: t7415: remove out-dated comment about translation
>   [2/9]: fsck_tree(): fix shadowed variable
>   [3/9]: fsck_tree(): wrap some long lines
>
>     These three are really independent fixes and cleanups, that could be
>     taken separately.
>
>   [4/9]: t7415: rename to expand scope
>   [5/9]: t7450: test verify_path() handling of gitmodules
>   [6/9]: t7450: test .gitmodules symlink matching against obscured names
>
>     These three are just cleaning up and improving the tests for the
>     existing handling of the .gitmodules symlinks.
>
>   [7/9]: t0060: test ntfs/hfs-obscured dotfiles
>   [8/9]: fsck: warn about symlinked dotfiles we'll open with O_NOFOLLOW
>
>     These two extend fsck checks (warnings, not errors) to the new
>     files. I think this is an improvement, but I could be persuaded
>     otherwise (and these two could be dropped independent of the rest).
>
>   [9/9]: docs: document symlink restrictions for dot-files
>
>     And this covers documentation for all of the files (including
>     .gitmodules).
>
>  Documentation/gitattributes.txt               |   7 ++
>  Documentation/gitignore.txt                   |   5 +
>  Documentation/gitmailmap.txt                  |   7 ++
>  Documentation/gitmodules.txt                  |   8 ++
>  cache.h                                       |   1 +
>  fsck.c                                        |  84 ++++++++++---
>  fsck.h                                        |   3 +
>  path.c                                        |   5 +
>  t/helper/test-path-utils.c                    |  46 +++++--
>  t/t0060-path-utils.sh                         |  30 +++++
>  ...ule-names.sh => t7450-bad-git-dotfiles.sh} | 116 +++++++++++++-----
>  utf8.c                                        |   5 +
>  utf8.h                                        |   1 +
>  13 files changed, 257 insertions(+), 61 deletions(-)
>  rename t/{t7415-submodule-names.sh => t7450-bad-git-dotfiles.sh} (70%)
>
> -Peff
