Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E1FC47089
	for <git@archiver.kernel.org>; Fri, 28 May 2021 03:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C9D613D8
	for <git@archiver.kernel.org>; Fri, 28 May 2021 03:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbhE1DHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 23:07:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53142 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbhE1DHl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 23:07:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 814FD143268;
        Thu, 27 May 2021 23:06:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dB+wjnwQYnxR3Ycj3xcIQhaTd1KfNyiSwPcGIS
        zoVkA=; b=NijcDlr/WVDaV2UPSNPsG+UWKETf7XEk3jxs2nGqbXKgGGNEw2XN7P
        MNV0+YKM3TBs4iZW7bBkFa7awZyJMrDyEInEQIbJ2smblJbYAdLHugnFjfN9BuTv
        1f/DbTRSORFzDqnVy4wHt3VxdAM9uRVl6s60fcp8BLbFgtNzhMcgg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 796F1143267;
        Thu, 27 May 2021 23:06:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C629A143266;
        Thu, 27 May 2021 23:06:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 2/2] [GSOC] ref-filter: add %(header) atom
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
        <aa6d73f3e526f416ee1e4e332e9ca3119efba0e8.1622126603.git.gitgitgadget@gmail.com>
Date:   Fri, 28 May 2021 12:06:02 +0900
In-Reply-To: <aa6d73f3e526f416ee1e4e332e9ca3119efba0e8.1622126603.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Thu, 27 May 2021 14:43:22
        +0000")
Message-ID: <xmqqwnrj7e1x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3F30384-BF61-11EB-B4BD-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Add new formatting option `%(header)`, which will print the
> the structured header part of the raw object data.
>
> In the storage layout of an object: blob and tree only
> contains raw data; commit and tag raw data contains two part:
> header and contents. The header of tag contains "object OOO",
> "type TTT", "tag AAA", "tagger GGG"; The header of commit
> contains "tree RRR", "parent PPP", "author UUU", "committer CCC".
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  Documentation/git-for-each-ref.txt |  7 +++++
>  ref-filter.c                       | 26 +++++++++++++++++
>  t/t6300-for-each-ref.sh            | 45 ++++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+)

While having this may not be wrong, I am not sure who needs it.  Is
your "cat-file --batch" topic needs this new atom?
