Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E4BA1F453
	for <e@80x24.org>; Mon,  1 Oct 2018 15:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbeJAW3c (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 18:29:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41026 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJAW3c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 18:29:32 -0400
Received: by mail-io1-f65.google.com with SMTP id q4-v6so9809122iob.8
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 08:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r75pmSrArYEAY6fQgWujWCMuS/J0KozDzySa5r6jtgs=;
        b=QJKKcl4SZQHxmJlxgM74A3c3tHJ9Qc97NzbzIoeyfhNBWe/9Vjqipxuo8Jq5V1yq+b
         9OTu+QQYCDSXZERuU6m/76CO/120ynHFK+RSZmaoUb105Rv5zTRvivn1p1vGqK9v8NaC
         mcxr+ItbNRFJofnN9qvDm3otS8kRhrquSWuIpeByn9TJcQfIBk2KrxXs7zDrdil4LgaG
         R3vGIH+VD/A0YyErVplp2dBBbCj+h+tMLmQC7jZNVZn4bICNJkOHspJScPcshr7fmfkk
         Zx4ljkpUpq0ekV1bjW/fwXM1890F3LSJG3TO1lHUSLRrD0rgkjp26GM1KCsRN4stKD5X
         mqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r75pmSrArYEAY6fQgWujWCMuS/J0KozDzySa5r6jtgs=;
        b=hALebjPk0Az16LdoCrbDzGdmKz8PSAdpjErBFLVH9mFpP74cKKsSset988xQLO9chA
         qw0/QAZiK8DtWymzb+pBapq3lwpm/xMHzKh+Gu0RUKREl2Txq3VtsZ3RZ3xi4tJldVkO
         5o594ooJZyHGgHpmt6nPuLj4UqCu+xw3zYgQQxJ/6qIgafAFdf/LSO51x3bRVD4g/Yp7
         pMLP1a37LeeJpSFJJlZwEOdNHDvaHtiOImTBpv5Ll/PwxsJIJ7bU3c5ZuE1oP4wBl8xH
         cpv/8kGRyVyimJG5nUvyjujLcVXoIfOfStpuuT4sIJsjGFtX0aaHKeuWYFKD54ewbhLY
         mGKw==
X-Gm-Message-State: ABuFfojQlr1YCXCu0gNkNu+02sxjjV66YcX0a4dQlIOyv4aNGdMR2yQd
        APvbjfn/gPhrtnA9ivJt9y/ReT3G4HogLPR3MGM=
X-Google-Smtp-Source: ACcGV63LpKawBrQtVcw7rdxdc4uVLAISV4zERXoYqc65wES0sppwd9+1QQdaBczvVr4yXI4pR7NOy5Ur5UPiVi13SMQ=
X-Received: by 2002:a6b:9885:: with SMTP id a127-v6mr6954473ioe.282.1538409065905;
 Mon, 01 Oct 2018 08:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181001134556.33232-1-peartben@gmail.com> <20181001134556.33232-6-peartben@gmail.com>
In-Reply-To: <20181001134556.33232-6-peartben@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 1 Oct 2018 17:50:39 +0200
Message-ID: <CACsJy8A2+P6RM5OOhke=Ptc2iPB81fGu0BF-Ven9am_UEThB8A@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] read-cache: load cache extensions on a worker thread
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 1, 2018 at 3:46 PM Ben Peart <peartben@gmail.com> wrote:
> @@ -1890,6 +1891,46 @@ static size_t estimate_cache_size(size_t ondisk_size, unsigned int entries)
>  static size_t read_eoie_extension(const char *mmap, size_t mmap_size);
>  static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context, size_t offset);
>
> +struct load_index_extensions
> +{
> +#ifndef NO_PTHREADS
> +       pthread_t pthread;
> +#endif
> +       struct index_state *istate;
> +       const char *mmap;
> +       size_t mmap_size;
> +       unsigned long src_offset;
> +};
> +
> +static void *load_index_extensions(void *_data)
> +{
> +       struct load_index_extensions *p = _data;
> +       unsigned long src_offset = p->src_offset;
> +
> +       while (src_offset <= p->mmap_size - the_hash_algo->rawsz - 8) {
> +               /* After an array of active_nr index entries,
> +                * there can be arbitrary number of extended
> +                * sections, each of which is prefixed with
> +                * extension name (4-byte) and section length
> +                * in 4-byte network byte order.
> +                */
> +               uint32_t extsize;
> +               memcpy(&extsize, p->mmap + src_offset + 4, 4);
> +               extsize = ntohl(extsize);

This could be get_be32() so that the next person will not need to do
another cleanup patch.

> +               if (read_index_extension(p->istate,
> +                       p->mmap + src_offset,
> +                       p->mmap + src_offset + 8,
> +                       extsize) < 0) {

This alignment is misleading because the conditions are aligned with
the code block below. If you can't align it with the '(', then just
add another tab.

> +                       munmap((void *)p->mmap, p->mmap_size);

This made me pause for a bit since we should not need to cast back to
void *. It turns out you need this because mmap pointer is const. But
you don't even need to munmap here. We're dying, the OS will clean
everything up.

> +                       die(_("index file corrupt"));
> +               }
> +               src_offset += 8;
> +               src_offset += extsize;
> +       }
> +
> +       return NULL;
> +}
-- 
Duy
