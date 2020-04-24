Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27028C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 20:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E65822166E
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 20:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nbo5OqkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgDXUCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:02:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64552 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729404AbgDXUCg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 16:02:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8A0756924;
        Fri, 24 Apr 2020 16:02:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EylXeWk6CJm5+rvcONVRjalAbTk=; b=nbo5Oq
        kA+2fOhTUnRFElUt/o75rxEl3Xted48XUnXLPESTVkNnEkSrJ+byUeL0cEl/+dm3
        FxWjlIYzXGKKYNAu6GLmp0xPPyNPHOct/d6HK2wf3hq2dzHKQp2NoSY0DjL86DBv
        KCpUEaqTcaTv4xJ0ZBzN8AsV9J6KqjH/TVWz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a0F/j6yxbZGrVktVyBiPOjXiQToEAJ61
        yUKHFv+Q1QAa0eCf7swAD5PIVyhiiU0DM+LpqI5NNmzAv7/CDOIvHLos1BDNrp7c
        fVxNzV+1ymoo1Rc8Me9qy21po4ZhEb6NWsbEJlnk8Gyc6WYpoRZ0pn7r87RxHToT
        bU3IgdXRjeQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF31656923;
        Fri, 24 Apr 2020 16:02:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4FBEE56922;
        Fri, 24 Apr 2020 16:02:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        szeder.dev@gmail.com, dstolee@microsoft.com
Subject: Re: [PATCH 4/4] commit-graph: close descriptors after mmap
References: <cover.1587677671.git.me@ttaylorr.com>
        <e05db264cb50760cab222157b436e82adeaeadc8.1587677671.git.me@ttaylorr.com>
        <xmqq368tg8po.fsf@gitster.c.googlers.com>
        <2232c379-d0ec-0b52-96b4-379438642785@gmail.com>
Date:   Fri, 24 Apr 2020 13:02:32 -0700
In-Reply-To: <2232c379-d0ec-0b52-96b4-379438642785@gmail.com> (Derrick
        Stolee's message of "Fri, 24 Apr 2020 09:17:16 -0400")
Message-ID: <xmqqmu70d547.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 891D72A4-8666-11EA-87A5-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
> Date: Fri, 24 Apr 2020 13:11:13 +0000
> Subject: [PATCH] multi-pack-index: close file descriptor after mmap
>
> We recently discovered that the commit-graph was not closing its
> file descriptor after memory-mapping the file contents. After this
> mmap() succeeds, there is no need to keep the file descriptor open.
> In fact, there is signficant reason to close it so we do not run
> out of descriptors.

The above is sufficient a justification.  Let's leave the remaining
two paragraphs under three-dashes.

> This is entirely my fault for not knowing that we can have an open
> mmap while also closing the descriptor. Some could blame this on
> being a new contributor when the series was first submitted, but
> even years later this is still new information to me.
>
> That made me realize that I used the same pattern when opening a
> multi-pack-index. Since this file is not (yet) incremental, there
> will be at most one descriptor open for this reason. It is still
> worth fixing, especially if we extend the format to be incremental
> like the commit-graph.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  midx.c | 4 +---
>  midx.h | 2 --
>  2 files changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/midx.c b/midx.c
> index 1527e464a7..60d30e873b 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -72,9 +72,9 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
>  	FREE_AND_NULL(midx_name);
>  
>  	midx_map = xmmap(NULL, midx_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +	close(fd);
>  
>  	FLEX_ALLOC_STR(m, object_dir, object_dir);
> -	m->fd = fd;
>  	m->data = midx_map;
>  	m->data_len = midx_size;
>  	m->local = local;
> @@ -190,8 +190,6 @@ void close_midx(struct multi_pack_index *m)
>  		return;
>  
>  	munmap((unsigned char *)m->data, m->data_len);
> -	close(m->fd);
> -	m->fd = -1;
>  
>  	for (i = 0; i < m->num_packs; i++) {
>  		if (m->packs[i])
> diff --git a/midx.h b/midx.h
> index e6fa356b5c..b18cf53bc4 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -12,8 +12,6 @@ struct repository;
>  struct multi_pack_index {
>  	struct multi_pack_index *next;
>  
> -	int fd;
> -
>  	const unsigned char *data;
>  	size_t data_len;
