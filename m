Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A322C2D0F8
	for <git@archiver.kernel.org>; Tue, 12 May 2020 21:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00AC320659
	for <git@archiver.kernel.org>; Tue, 12 May 2020 21:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="e5l8SW9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbgELVQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 17:16:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58872 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgELVQh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 17:16:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD76F5AAC0;
        Tue, 12 May 2020 17:16:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=czcIbV5s3vPY2eO6+Zm5oKIKv3U=; b=e5l8SW
        9ZaRbHKHA8wAsPqu+MnyPThP1JFMhcPcBfQPAbkVDGvpirNETCfS7ffz3KBgSvxU
        6obSVPa5jKx1tDhHZF2AHw/TjhWXK6koIX5Ei6+4dkDV38ZhkhWboKgtLP1fWcYD
        RxjAzFvdCwbw0hLnGkbj/vkmmlW6Gy9Rfs8bg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ajSDnfwxN2iKKJLbxLQyZt9rNwNkSby9
        QygFIBSKOnv6X4+QWi25cZ9O3Kyw0vjpfM4X1LFN9mSKAvpuaS55hNbgCtfhoGXq
        NIamwyVbmaBiMHlg2NX0WC1W1YlJoCT+ee178ZXxV0Zep7h67YIVO8opSw5JAmmo
        XD3mmcmvljg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A49955AABF;
        Tue, 12 May 2020 17:16:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.99.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DDC315AABE;
        Tue, 12 May 2020 17:16:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH v2 08/11] cmake: added checks for struct stat and libiconv
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
        <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
        <f496cd7d8aa12047db7f6c0212fbcb2497469785.1589302255.git.gitgitgadget@gmail.com>
Date:   Tue, 12 May 2020 14:16:34 -0700
In-Reply-To: <f496cd7d8aa12047db7f6c0212fbcb2497469785.1589302255.git.gitgitgadget@gmail.com>
        (Sibi Siddharthan via GitGitGadget's message of "Tue, 12 May 2020
        16:50:51 +0000")
Message-ID: <xmqqblmsc0r1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBF07958-9495-11EA-8026-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> Subject: Re: [PATCH v2 08/11] cmake: added checks for struct stat and libiconv

s/added/add/; give a command to the codebase to "be like so", or a
command to whoever is typing changes to the editor to "make this
happen".

> The CMake script now checks whether st_blocks is a member of struct stat
> and set the compile definition NO_ST_BLOCKS_IN_STRUCT_STAT accordingly.

	Teach the CMake script to check ...

> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index 4353080b708..975791c8b89 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -22,6 +22,7 @@ project(git
>  include(CheckTypeSize)
>  include(CheckCSourceRuns)
>  include(CheckCSourceCompiles)
> +include(CheckCSourceRuns)
> ...
> +#check for st_blocks in struct stat
> +check_struct_has_member("struct stat" st_blocks "sys/stat.h" STRUCT_STAT_HAS_ST_BLOCKS)
> +if(NOT STRUCT_STAT_HAS_ST_BLOCKS)
> +	add_compile_definitions(NO_ST_BLOCKS_IN_STRUCT_STAT)
> +endif()

All of these compatibility stuff makes sense, but how do we decide
where to draw the line between the checks we saw added in [01/11]
and the checks added here?  It feels pretty arbitrary to me and if
that is the case, perhaps we want to move all the "add checks" to a
commit separate from [01/11] (whose primary purpose is to add the
basic rules without these build tweaks in the file at the final
place)?

