Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83A3F1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 19:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeJCB5C (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 21:57:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40154 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeJCB5C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 21:57:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id j62-v6so3102380edd.7
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 12:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXZaT0QihoqLJwKkFPJnOFqmmSqovXckPcgahT7bO4c=;
        b=Km5XgZ6NQUbVh7CrGP95BVIZJQ+ieKhUfC/24udKObMtOPb6rNySddG+x6aPQHBcFp
         hAvbIFbSP29oouoIT9Xz6EnbiH9ZRL6I8nQcFL1PeLgpQEYMgfq8zYSEACYR5pFOnIDK
         mrHYUcP+ahOcRTbZfAsydRmj7FS8LeIvMBnhQpEpVSTroiBLuFmxlsznbd5ZYsb7+z6M
         SPdIcamW7QNoIJDQK41CDYnLfCEx1GJcJ59MdztG/sv9S683YeN9I0zl6Pa7g6g/xEqa
         cfgTgKOAlYj4tGWtTVZbanM+nFULk0M2mJwOne8XqMPMhjBUQydX1Sxxwru53FowtqmJ
         es6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXZaT0QihoqLJwKkFPJnOFqmmSqovXckPcgahT7bO4c=;
        b=Srcv7z9ESbCBv+zvbaG6xrTe3GSaLfiTO6t8kfVxxIZY2UBLa+GeVxvWEQOJncaIAS
         JieSL2EY0DJHWnwozc5x1KktpIOLLAMqlSmVjfFOaR0QU+JG39X7epnvXPXcv4w12nii
         B1zDREmsZNCX3qE6YZWrmxKym2wOd0UciYkkmpcbK632metrKYEYYVmS/kQGIGcgPYfq
         qZjIX+jhaNMO58BfEuM2obHkZw63w/izYGkscUUWdem8djcQh5IQu/I4PBRVQrMDO3QJ
         1q9dHAaiQBePxzt9yw9EdaTaqguHwYz7+Pup3l7t1s+kPRi/vMUpS2TrXOI0Vx9UC03G
         aWVQ==
X-Gm-Message-State: ABuFfoghLK79r8qkgRctXtEVcXRhOJims1JFeEcUy87/aq1cPm+rfMz6
        UD/KXt0dnxqFtc0EXXLCIIf9+23JEZCnFsC4OC2KDA==
X-Google-Smtp-Source: ACcGV60tvRUH0N19mxjQNH+frwunpmL9UBZzk16SdlVYzjr1t1z+lgpZVztMkrxrQrjyoCq4fSaC1rXxcGp3TZWTcio=
X-Received: by 2002:a50:9931:: with SMTP id k46-v6mr25588534edb.85.1538507529816;
 Tue, 02 Oct 2018 12:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181002175514.31495-1-phillip.wood@talktalk.net> <20181002175514.31495-5-phillip.wood@talktalk.net>
In-Reply-To: <20181002175514.31495-5-phillip.wood@talktalk.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 2 Oct 2018 12:11:58 -0700
Message-ID: <CAGZ79kZDEeBZbTC=yb3CcJz54GM4jn_669H3T1fiNXs9Oob7aA@mail.gmail.com>
Subject: Re: [PATCH 5/5] diff --color-moved: fix a memory leak
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 2, 2018 at 10:55 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Free the hashmap items as well as the hashmap itself. This was found
> with asan.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  diff.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 4464feacf8..94cc1b5592 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -5770,8 +5770,8 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
>                         if (o->color_moved == COLOR_MOVED_ZEBRA_DIM)
>                                 dim_moved_lines(o);
>
> -                       hashmap_free(&add_lines, 0);
> -                       hashmap_free(&del_lines, 0);
> +                       hashmap_free(&add_lines, 1);
> +                       hashmap_free(&del_lines, 1);

And this is sufficient as the entries themselves are
moved_entry, which only contain pointers (to
o->emitted_symbols), which are freed later.
There is nothing in there that needs extra free-ing.

Thanks,
Stefan
