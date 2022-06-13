Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9853EC43334
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 21:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351551AbiFMVRQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 17:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352251AbiFMVQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 17:16:58 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5F01277C
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 13:59:11 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E0931A7C9F;
        Mon, 13 Jun 2022 16:59:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4mG/8EVSuZ/NsV/2YD+ikwFyjZ9ECqc7Sj/QAR
        05HkI=; b=NCZFl7EuYjMcqZb0HSBKJQO0GNZMjGj41gROB0fPoONPs+jLTwOC/e
        RMjDQzG0pNBf8OIzSscQ0xSoCRKXRG+zTgqw81XX7+4fVFRC+Vm46VtsdUKSH6wm
        wT+lIdZh+ksruxmYsMJ5YEgLlmIh9vxw6Y6EHhywZYfA7JNb6N9UQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 660391A7C9E;
        Mon, 13 Jun 2022 16:59:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0D9A11A7C99;
        Mon, 13 Jun 2022 16:59:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 5/5] bitmap: add trace2 outputs during open "bitmap"
 file
References: <cover.1655018322.git.dyroneteng@gmail.com>
        <e118758d1dada378d65d58579cc1372fa547d720.1655018322.git.dyroneteng@gmail.com>
Date:   Mon, 13 Jun 2022 13:59:05 -0700
In-Reply-To: <e118758d1dada378d65d58579cc1372fa547d720.1655018322.git.dyroneteng@gmail.com>
        (Teng Long's message of "Sun, 12 Jun 2022 15:44:20 +0800")
Message-ID: <xmqq5yl45lgm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA24ABD2-EB5B-11EC-A1F0-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 5654eb7b8d..ced5993560 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -312,9 +312,11 @@ char *pack_bitmap_filename(struct packed_git *p)
>  static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>  			      struct multi_pack_index *midx)
>  {
> +	int fd;
>  	struct stat st;
>  	char *bitmap_name = midx_bitmap_filename(midx);
> -	int fd = git_open(bitmap_name);
> +	trace2_data_string("midx", the_repository, "path", bitmap_name);
> +	fd = git_open(bitmap_name);
>  
>  	free(bitmap_name);

The patch adds new statements at a wrong place.  The block of
declarations and the first statement in the block were separated by
a blank line, but they no longer are.

These things tend to show up in merges quite clearly.  They do not
cause more unnecessary conflicts but can make resolution more error
prone.

Thanks.
