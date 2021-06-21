Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA93C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 20:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3D7611C1
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 20:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhFUUd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFUUd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 16:33:56 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD8AC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 13:31:40 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so19076239otl.3
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 13:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jJqAItPOCsVXkUxRlBRkYszcUQumON76Hj/QyuX2N3o=;
        b=Ho4ZoHoV6pEI8Y27uBaKu8cLpCJGrsc7pTpMPKh9V8JpbArK7X3ryL+7X8FHWtn4WO
         RHT0BwBqocHyLcD6p+tMWozjmqz3CUqTrp2AsppYzMNcL9M8wlsHGWWKpXFv+xMuJVfO
         vhZMj1fqZNNwhHFsKh9y6eykzhYl9CvszYqIRHQbyPjs7OkbcaqdB2GrYArLMmBz8Zc7
         +xXVKXc/7GMQrQCsVoUzE/z4C8MHWHSfxCdBGl0Yg9UCI721Av9AT0H+y161kikjx+9v
         24Se8mMZmhDNTcal1ear8nyk32ZMTFfFkbquDFHJNGfPsee2ZRtP8Y55S5S3F4fQ40Jy
         t5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jJqAItPOCsVXkUxRlBRkYszcUQumON76Hj/QyuX2N3o=;
        b=T4AY7f1DK9se3GFwOwWmdFFSVt9AUY4kaRweVooFwZq2skRIEOCfw6k1B8ZdGSCKma
         ks8lQZI+Tm8bnfYiRXwnGcdRD/dwx8E7psU8PvnEz9kuC6bafrp2MY6VNlB7orOQcr7H
         omq8S74+8w5uXk0iwoyJ0kyuAH7ojMjBY9ZsbiZYa2GPjqx/a2+GrOsC55Z0Kzq/4yIr
         3E3q0fGnP50/Z/iBa2R6TJB7b7IWwsCTdJXO9hp7cUWSV8IjURmQ43dbJjkj++HyVOnv
         0BwqeqS5/ZYKe2TFZEDDRx8trTlIW74ARL4+5hXttBMQPxxYAAzE+tELUwR+AsWV/STx
         SURw==
X-Gm-Message-State: AOAM5336D5TcYPOuo0ELf1Tz7evrZFXJ70yWgxftCsfMkarM44VaCVwf
        FPCtwmurZSRFMhA24JJf/tOyWj/1WUys/GMG3En6sOajkb4=
X-Google-Smtp-Source: ABdhPJyTZyx2PbOkIz9W5DxlWExS9SbU6qDSk70oYnM6/m+1paRKW5GMFBDXZRPkL+vGQgu/ouHiypE2GriNDzo/wZ4=
X-Received: by 2002:a05:6830:18fc:: with SMTP id d28mr265846otf.162.1624307499888;
 Mon, 21 Jun 2021 13:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210620151204.19260-1-andrzej@ahunt.org> <20210620151204.19260-9-andrzej@ahunt.org>
In-Reply-To: <20210620151204.19260-9-andrzej@ahunt.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Jun 2021 13:31:28 -0700
Message-ID: <CABPp-BE=1bNxm9eVUBaCwDqXrFCXccWJ2yHftvCUQ+4Rr8seYw@mail.gmail.com>
Subject: Re: [PATCH 08/12] convert: release strbuf to avoid leak
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 20, 2021 at 8:15 AM <andrzej@ahunt.org> wrote:
>
> From: Andrzej Hunt <ajrhunt@google.com>
>
> apply_multi_file_filter and async_query_available_blobs both query
> subprocess output using subprocess_read_status, which writes data into
> the identically named filter_status strbuf. We add a strbuf_release to
> avoid leaking their contents.
>
> Leak output seen when running t0021 with LSAN:
>
> Direct leak of 24 byte(s) in 1 object(s) allocated from:
>     #0 0x49ab49 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
>     #1 0xa8c2b5 in xrealloc wrapper.c:126:8
>     #2 0x9ff99d in strbuf_grow strbuf.c:98:2
>     #3 0x9ff99d in strbuf_addbuf strbuf.c:304:2
>     #4 0xa101d6 in subprocess_read_status sub-process.c:45:5
>     #5 0x77793c in apply_multi_file_filter convert.c:886:8
>     #6 0x77793c in apply_filter convert.c:1042:10
>     #7 0x77a0b5 in convert_to_git_filter_fd convert.c:1492:7
>     #8 0x8b48cd in index_stream_convert_blob object-file.c:2156:2
>     #9 0x8b48cd in index_fd object-file.c:2248:9
>     #10 0x597411 in hash_fd builtin/hash-object.c:43:9
>     #11 0x596be1 in hash_object builtin/hash-object.c:59:2
>     #12 0x596be1 in cmd_hash_object builtin/hash-object.c:153:3
>     #13 0x4ce83e in run_builtin git.c:475:11
>     #14 0x4ccafe in handle_builtin git.c:729:3
>     #15 0x4cb01c in run_argv git.c:818:4
>     #16 0x4cb01c in cmd_main git.c:949:19
>     #17 0x6bdc2d in main common-main.c:52:11
>     #18 0x7f42acf79349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>
> SUMMARY: AddressSanitizer: 24 byte(s) leaked in 1 allocation(s).
>
> Direct leak of 120 byte(s) in 5 object(s) allocated from:
>     #0 0x49ab49 in realloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
>     #1 0xa8c295 in xrealloc wrapper.c:126:8
>     #2 0x9ff97d in strbuf_grow strbuf.c:98:2
>     #3 0x9ff97d in strbuf_addbuf strbuf.c:304:2
>     #4 0xa101b6 in subprocess_read_status sub-process.c:45:5
>     #5 0x775c73 in async_query_available_blobs convert.c:960:8
>     #6 0x80029d in finish_delayed_checkout entry.c:183:9
>     #7 0xa65d1e in check_updates unpack-trees.c:493:10
>     #8 0xa5f469 in unpack_trees unpack-trees.c:1747:8
>     #9 0x525971 in checkout builtin/clone.c:815:6
>     #10 0x525971 in cmd_clone builtin/clone.c:1409:8
>     #11 0x4ce83e in run_builtin git.c:475:11
>     #12 0x4ccafe in handle_builtin git.c:729:3
>     #13 0x4cb01c in run_argv git.c:818:4
>     #14 0x4cb01c in cmd_main git.c:949:19
>     #15 0x6bdc2d in main common-main.c:52:11
>     #16 0x7fa253fce349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>
> SUMMARY: AddressSanitizer: 120 byte(s) leaked in 5 allocation(s).
>
> Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
> ---
>  convert.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/convert.c b/convert.c
> index fd9c84b025..0d6fb3410a 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -916,6 +916,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
>         else
>                 strbuf_swap(dst, &nbuf);
>         strbuf_release(&nbuf);
> +       strbuf_release(&filter_status);
>         return !err;
>  }
>
> @@ -966,6 +967,7 @@ int async_query_available_blobs(const char *cmd, struct string_list *available_p
>
>         if (err)
>                 handle_filter_error(&filter_status, entry, 0);
> +       strbuf_release(&filter_status);
>         return !err;
>  }
>
> --
> 2.26.2

Makes sense; a `git grep -e STRBUF_INIT -e strbuf_release -e
strbuf_init convert.c` does a fairly good job of highlighting that
these appear to be the only two strbuf leaks in this file.
