Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A97C6FD1F
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 05:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjCSFzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 01:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCSFzU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 01:55:20 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A75D1E9C2
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 22:55:17 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id q16so387513lfe.10
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 22:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679205315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHmuLge1YtXxRfXWedSekLLfpFm91/wbxUH0sfhCyJc=;
        b=mBw/5CFSmHcgcdOkyeUNinL3xdVR551k1CGVRHlS+vNljYLP127WEfMKDk55CpDv19
         jBPSGuY4GebSMkVt++zG1ZPE0dihaXwaYZVQrwWRLyu0EyjMuvRAjAvOiBQiDtl9aHlr
         EbaMK0HruTXdzvhtO+17gAyqdhWAQYmJe0A5KjRJpJd/l6arEF3SLkcq3QrMfTCdmsPw
         jtbng5gsApQ31NIS0tqnHC7Xf5sh+EYKqj95ARljpvG6ZGjhKeLHzIo+ARu7dZ5gVJvL
         X9EE8yEm3JzzqcIk2FkkfGBSVVdniYAukS6chUKf/J/w7U8nTyBOmWBy9DedQv0vrNaM
         YrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679205315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHmuLge1YtXxRfXWedSekLLfpFm91/wbxUH0sfhCyJc=;
        b=z10sx+zTODagABk8HUnEoqz/qEdWeYCW/UVUf/eB1bevyJNPuSbK3CzbvrZHLQu16t
         TYAIJHmBZxyWxK3VmRZ8tYGvzTu0MeMyrnZP4YdyWlxXJmo/X1Kd7qOa8RUlPrmfosk9
         c1fUEf+cna8o1UXHr+e2euHH8tuuRPCT08lLndj2AAM9IojInf3GGPMeZpTOqxRDzwWe
         EUrotdPypClL+EGqmQ7cO4YTsNDhy5wS3mzKQ4xRz6W9VDs4NwUoJ056a+g3VCnr5hvX
         EIO4Xbt/QtXkftZufISi0UnKUPKLaqucs9YqB/nqwOUdQFcGrKb/7o50oX9VvuL+up6b
         3fSA==
X-Gm-Message-State: AO0yUKUurSLAupPnolZ85fKAqrwoyPiLzCjyovVC/zaEkXknIkddfUel
        UkvigmLAgZYcGTCJL6yMAMhOkJX6qOCoK/zaB/E=
X-Google-Smtp-Source: AK7set9xBqXNpR7NWFyFSiweWPDJQA9yusQbwSVIkE3ERoHH3+hYBSiMCJ6+jc3FMn+KbzdIur9EL6h1fY7mdJogSNY=
X-Received: by 2002:ac2:5a42:0:b0:4e9:a3b7:2369 with SMTP id
 r2-20020ac25a42000000b004e9a3b72369mr726229lfn.7.1679205315646; Sat, 18 Mar
 2023 22:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <patch-02.17-1b1fc5d41f5-20230317T152724Z-avarab@gmail.com>
In-Reply-To: <patch-02.17-1b1fc5d41f5-20230317T152724Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 18 Mar 2023 22:55:03 -0700
Message-ID: <CABPp-BHaxgJthO3ww+-kJZvwU8i8kqTSFn0dwx6X8OYcQhPf_A@mail.gmail.com>
Subject: Re: [PATCH 02/17] cocci: fix incorrect & verbose "the_repository" rules
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2023 at 8:53=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
<avarab@gmail.com> wrote:
>
> When these rules started being added in [1] they didn't use a ";"
> after the ")", and would thus catch uses of these macros within
> expressions. But as of [2] the new additions were broken in that
> they'd only match a subset of the users of these macros.
>
> Rather than narrowly fixing that, let's have these use the much less
> verbose pattern introduced in my recent [3]: There's no need to
> exhaustively enumerate arguments if we use the "..." syntax. This
> means that we can fold all of these different rules into one.
>
> 1. afd69dcc219 (object-store: prepare read_object_file to deal with
>    any repo, 2018-11-13)
> 2. 21a9651ba3f (commit-reach: prepare get_merge_bases to handle any
>    repo, 2018-11-13)
> 3. 0e6550a2c63 (cocci: add a index-compatibility.pending.cocci,
>    2022-11-19)
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  .../coccinelle/the_repository.pending.cocci   | 160 +++++-------------
>  1 file changed, 46 insertions(+), 114 deletions(-)
>
> diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/co=
ccinelle/the_repository.pending.cocci
> index 23b97536da5..99e192736ee 100644
> --- a/contrib/coccinelle/the_repository.pending.cocci
> +++ b/contrib/coccinelle/the_repository.pending.cocci
> @@ -3,118 +3,50 @@
>  // our code base.
>
>  @@
> -expression E;
> -expression F;
> -expression G;
>  @@
> -- read_object_file(
> -+ repo_read_object_file(the_repository,
> -  E, F, G)
> -
> -@@
> -expression E;
> -@@
> -- has_object_file(
> -+ repo_has_object_file(the_repository,
> -  E)
> -
> -@@
> -expression E;
> -@@
> -- has_object_file_with_flags(
> -+ repo_has_object_file_with_flags(the_repository,
> -  E)
> -
> -@@
> -expression E;
> -expression F;
> -expression G;
> -@@
> -- parse_commit_internal(
> -+ repo_parse_commit_internal(the_repository,
> -  E, F, G)
> -
> -@@
> -expression E;
> -@@
> -- parse_commit(
> -+ repo_parse_commit(the_repository,
> -  E)
> -
> -@@
> -expression E;
> -expression F;
> -@@
> -- get_merge_bases(
> -+ repo_get_merge_bases(the_repository,
> -  E, F);
> -
> -@@
> -expression E;
> -expression F;
> -expression G;
> -@@
> -- get_merge_bases_many(
> -+ repo_get_merge_bases_many(the_repository,
> -  E, F, G);
> -
> -@@
> -expression E;
> -expression F;
> -expression G;
> -@@
> -- get_merge_bases_many_dirty(
> -+ repo_get_merge_bases_many_dirty(the_repository,
> -  E, F, G);
> -
> -@@
> -expression E;
> -expression F;
> -@@
> -- in_merge_bases(
> -+ repo_in_merge_bases(the_repository,
> -  E, F);
> -
> -@@
> -expression E;
> -expression F;
> -expression G;
> -@@
> -- in_merge_bases_many(
> -+ repo_in_merge_bases_many(the_repository,
> -  E, F, G);
> -
> -@@
> -expression E;
> -expression F;
> -@@
> -- get_commit_buffer(
> -+ repo_get_commit_buffer(the_repository,
> -  E, F);
> -
> -@@
> -expression E;
> -expression F;
> -@@
> -- unuse_commit_buffer(
> -+ repo_unuse_commit_buffer(the_repository,
> -  E, F);
> -
> -@@
> -expression E;
> -expression F;
> -expression G;
> -@@
> -- logmsg_reencode(
> -+ repo_logmsg_reencode(the_repository,
> -  E, F, G);
> -
> -@@
> -expression E;
> -expression F;
> -expression G;
> -expression H;
> -@@
> -- format_commit_message(
> -+ repo_format_commit_message(the_repository,
> -  E, F, G, H);
> +(
> +- read_object_file
> ++ repo_read_object_file
> +|
> +- has_object_file
> ++ repo_has_object_file
> +|
> +- has_object_file_with_flags
> ++ repo_has_object_file_with_flags
> +|
> +- parse_commit_internal
> ++ repo_parse_commit_internal
> +|
> +- parse_commit
> ++ repo_parse_commit
> +|
> +- get_merge_bases
> ++ repo_get_merge_bases
> +|
> +- get_merge_bases_many
> ++ repo_get_merge_bases_many
> +|
> +- get_merge_bases_many_dirty
> ++ repo_get_merge_bases_many_dirty
> +|
> +- in_merge_bases
> ++ repo_in_merge_bases
> +|
> +- in_merge_bases_many
> ++ repo_in_merge_bases_many
> +|
> +- get_commit_buffer
> ++ repo_get_commit_buffer
> +|
> +- unuse_commit_buffer
> ++ repo_unuse_commit_buffer
> +|
> +- logmsg_reencode
> ++ repo_logmsg_reencode
> +|
> +- format_commit_message
> ++ repo_format_commit_message
> +)
> +  (
> ++ the_repository,
> +  ...)
> --
> 2.40.0.rc1.1034.g5867a1b10c5

I know virtually nothing about cocci, but the commit message explains
well enough that it's clear what you're doing and what's happening.
:-)
