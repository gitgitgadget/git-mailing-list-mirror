Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D58C433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 04:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD9320709
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 04:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbhA0D7C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhA0DAh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 22:00:37 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91236C06121C
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 18:42:54 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id a1so404533qvd.13
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 18:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QLTUDRwvr2CqNV0q6eIbF7KrynCgeH/2oCz+0rfsx00=;
        b=iELHnlA24pD097mXjPp2NPv8GQOESW0e3VAHoM48rRjI5gA5DsI2fk1ccfCu4sglYW
         YoEEKVW2XCAVGVjcE/tdQrIrQElm6NXUhBfBsI1NIASoctpsRKQhkqB9MLeHNEwrJQ2B
         md9IuewlIeNm+5yGLHgGG0BO0If8OcPJ8rJ9JEnuX2KZXSohwvWb1QSHLxwamew0qwF+
         vcyD+uY9TiMoVetwThAKPQDZnK2sJ5Q+b6KzN4vlxaw+wttx43ROdX4zR8AYUVD+AoSd
         zVi4bqtyC1JNuZozySD23RVyCIGrWsblStUoNzRhCayks4/Mk+Hczes/c9B9u//+tPQy
         BMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QLTUDRwvr2CqNV0q6eIbF7KrynCgeH/2oCz+0rfsx00=;
        b=MEdmYKc0YJUrvLAKrAN3H0gpL7Ff0fAWNLVqjuOGIlPtJjHacoYxoi6AwxsBnSFIES
         cHiqX2H3NkWt1NNT+6I8r4PAAXdcZzJ/pFoNPs97pUpzMdvCXvIG66aXwtBh3s/K4nhb
         NxRzn6D/2FZ1tffDmG3wiv5RRN5I4MCj0BvQpIepuvG2QcSQT6QMKVhjZdbiIu/FoTup
         NSh9E9i4Z65eux9EqKZmlp+KMPNp7KuccVnwB2fV2seBafsbrx42uCRsmKP65ZNJ/qnb
         GL0wsk0tR7ziWtvj1ricqKZgvKIjXrRrAg5nIErDQaHD/hnDOTOzIUvBsX4aVIMrZABK
         K4zg==
X-Gm-Message-State: AOAM531bV6TSJH0mr2xnqsJNtg8ZbyloKJqFcFgg0CfA2kGvDGLGkzxq
        eDF07eRqgTdhIUMx7zLkKSri0Q==
X-Google-Smtp-Source: ABdhPJyFu5Y8mFQ4uTt/mfC08JGWZkPHGChtEdZ7CUzoahYXOOmVJ+ehvgzu9JCc3fZMxUenzkdXxg==
X-Received: by 2002:a0c:c489:: with SMTP id u9mr8687919qvi.31.1611715373079;
        Tue, 26 Jan 2021 18:42:53 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5cad:8534:72d4:8c70])
        by smtp.gmail.com with ESMTPSA id v7sm448575qto.30.2021.01.26.18.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 18:42:52 -0800 (PST)
Date:   Tue, 26 Jan 2021 21:42:50 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        l.s.r@web.de, szeder.dev@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 02/17] chunk-format: create chunk format write API
Message-ID: <YBDTKqiCEkWmxEFr@nand.local>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
 <9bd273f8c94fdb0c3adf8aedef3480ff5f4232b8.1611676886.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9bd273f8c94fdb0c3adf8aedef3480ff5f4232b8.1611676886.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 26, 2021 at 04:01:11PM +0000, Derrick Stolee via GitGitGadget wrote:
> +/*
> + * When writing a chunk-based file format, collect the chunks in
> + * an array of chunk_info structs. The size stores the _expected_
> + * amount of data that will be written by write_fn.
> + */
> +struct chunk_info {
> +	uint32_t id;
> +	uint64_t size;

Hmm. Would we not want an off_t to indicate the size here?

I wondered briefly if we even needed a size field at all, since calling
write_fn would tell us the number of bytes written. But I suppose you
want to know ahead of time so that you can write the file in one pass
(beginning with the table of contents, which certainly needs to know the
size).

> +	/* Trailing entry marks the end of the chunks */
> +	hashwrite_be32(cf->f, 0);
> +	hashwrite_be64(cf->f, cur_offset);
> +
> +	for (i = 0; i < cf->chunks_nr; i++) {
> +		uint64_t start_offset = cf->f->total + cf->f->offset;
> +		int result = cf->chunks[i].write_fn(cf->f, data);
> +
> +		if (result)
> +			return result;
> +
> +		if (cf->f->total + cf->f->offset != start_offset + cf->chunks[i].size)

I don't think this is a practical concern, but a malicious caller could
overflow this by passing a bogus "size" parameter. Maybe:

    uint64_t end_offset = ...;

    if (end_offset - start_offset != cf->chunks[i].size)
      BUG(...)

?

> diff --git a/chunk-format.h b/chunk-format.h
> new file mode 100644
> index 00000000000..bfaed672813
> --- /dev/null
> +++ b/chunk-format.h
> @@ -0,0 +1,20 @@
> +#ifndef CHUNK_FORMAT_H
> +#define CHUNK_FORMAT_H
> +
> +#include "git-compat-util.h"
> +
> +struct hashfile;
> +struct chunkfile;
> +
> +struct chunkfile *init_chunkfile(struct hashfile *f);
> +void free_chunkfile(struct chunkfile *cf);
> +int get_num_chunks(struct chunkfile *cf);
> +typedef int (*chunk_write_fn)(struct hashfile *f,
> +			      void *data);
> +void add_chunk(struct chunkfile *cf,
> +	       uint64_t id,
> +	       chunk_write_fn fn,
> +	       size_t size);
> +int write_chunkfile(struct chunkfile *cf, void *data);

Very clean API.

Thanks,
Taylor
