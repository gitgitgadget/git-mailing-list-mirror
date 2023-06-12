Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690B3C7EE2E
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 18:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbjFLSAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 14:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjFLSAL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 14:00:11 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807DA170C
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 11:00:10 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b3a6fc8067so14337505ad.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 11:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686592810; x=1689184810;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9wIG0iEXL6duALEuMaW15SELXf1RedXKamWG6MX3Hg=;
        b=F+22IvJB93ETZ2J2pYBfBGWLqeLWZF78lwxmrKBd3RQodXqGvP2L3nGCrBmZOWhC6W
         n+8s7hbHtcldUeLvgx6HYLIn6+4u/k9UCD07yjXUvGBujCaOLklc6kWuDzuBef7Z89Y/
         ctzYxGUQRST9nb4wbsOfX0kM0yaYYV5UYZTxNIfNa6gNE9N70wHco9x7vX7keM5mCUHP
         4taJ6N/GSeFkzbQBbLUgRwmnk1iZ8TNZgURSLjwNgebXzZbmgJndkFLZkytkFI96fPcp
         GdlytX/hdUgv24/5mkWzD9Ogil5udP468Ape74++UdUcuyJSAZkB42Mf5sp8qO55CCKY
         iYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686592810; x=1689184810;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9wIG0iEXL6duALEuMaW15SELXf1RedXKamWG6MX3Hg=;
        b=HiXVqloQ8KBHO0e/aWs/8jHont5b9maX2RJlNfvGTNLiqMeJ5pwHr4ypQVQBeOQgTg
         nY1wUSUw1FRWPqFzk6L7nr+iq/op83r0no2nTDrn20SQ0rcQznpiVX+bbOJo4jp1JEjW
         2z1YJK2NnMFpheKMDVzYjXPZT8lQhaSsaYBZwcZnoay+MYTynVUbkIgCgrurXIBqvXSf
         vey0X3cNhNVSr84hedzSGiC0j+ph4oKJLSsfPQLHZrm1MkgYf3Q1E9qFmhzhJ9BZ0WQp
         8IHtW1jdWCWut074Cg0+X7wHDLTnJFxByLpA8MwbwpYcskgczLA9TD0lkHDQUVfRC2PR
         EOKg==
X-Gm-Message-State: AC+VfDy9Z/bWTooWIpTkLj1BIURsMAx1V6PaS+YzWxMDb2zDG1ohPCxw
        /p1swb9JkO/PXpr0WKkMeJc=
X-Google-Smtp-Source: ACHHUZ5Vw8MOB1KHrtATBChRMCArAJUznF+3wUitANNxTX66cNAdyJZultF91pzP+bV6peXznyFmfQ==
X-Received: by 2002:a17:902:f68a:b0:1ac:8062:4f31 with SMTP id l10-20020a170902f68a00b001ac80624f31mr8777399plg.37.1686592809872;
        Mon, 12 Jun 2023 11:00:09 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id f16-20020a170902ce9000b001a52c38350fsm8541562plg.169.2023.06.12.11.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:00:09 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Alejandro_R_Sede=C3=B1o?= <asedeno@google.com>
Cc:     asedeno@mit.edu, git@vger.kernel.org, newren@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH] statinfo.h: move DTYPE defines from dir.h
References: <xmqqilc571hf.fsf@gitster.g>
        <20230606205935.3183276-1-asedeno@google.com>
Date:   Mon, 12 Jun 2023 11:00:09 -0700
In-Reply-To: <20230606205935.3183276-1-asedeno@google.com> ("Alejandro R
        =?utf-8?Q?Sede=C3=B1o=22's?= message of "Tue, 6 Jun 2023 16:59:35 -0400")
Message-ID: <xmqqzg54a7di.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alejandro R Sedeño" <asedeno@google.com> writes:

> From: Alejandro R. Sedeño <asedeno@mit.edu>
>
> 592fc5b3 (dir.h: move DTYPE defines from cache.h, 2023-04-22) moved
> DTYPE macros from cache.h to dir.h, but they are still used by cache.h
> to implement ce_to_dtype(); cache.h cannot include dir.h because that
> would cause name-hash.c to have two different and conflicting
> definitions of `struct dir_entry`. (That should be separately fixed.)
>
> Both dir.h and cache.h include statinfo.h, and this seems a reasonable
> place for these definitions.
>
> This change fixes a broken build issue on old SunOS.
>
> Signed-off-by: Alejandro R. Sedeño <asedeno@mit.edu>
> Signed-off-by: Alejandro R Sedeño <asedeno@google.com>
> ---
>  dir.h      | 14 --------------
>  statinfo.h | 14 ++++++++++++++
>  2 files changed, 14 insertions(+), 14 deletions(-)

Thanks.  Looking great.

> diff --git a/dir.h b/dir.h
> index 79b85a01ee..d65a40126c 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -641,18 +641,4 @@ static inline int starts_with_dot_dot_slash_native(const char *const path)
>  	return path_match_flags(path, what | PATH_MATCH_NATIVE);
>  }
>  
> -#if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
> -#define DTYPE(de)	((de)->d_type)
> -#else
> -#undef DT_UNKNOWN
> -#undef DT_DIR
> -#undef DT_REG
> -#undef DT_LNK
> -#define DT_UNKNOWN	0
> -#define DT_DIR		1
> -#define DT_REG		2
> -#define DT_LNK		3
> -#define DTYPE(de)	DT_UNKNOWN
> -#endif
> -
>  #endif
> diff --git a/statinfo.h b/statinfo.h
> index e49e3054ea..fe8df633a4 100644
> --- a/statinfo.h
> +++ b/statinfo.h
> @@ -21,4 +21,18 @@ struct stat_data {
>  	unsigned int sd_size;
>  };
>  
> +#if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
> +#define DTYPE(de)	((de)->d_type)
> +#else
> +#undef DT_UNKNOWN
> +#undef DT_DIR
> +#undef DT_REG
> +#undef DT_LNK
> +#define DT_UNKNOWN	0
> +#define DT_DIR		1
> +#define DT_REG		2
> +#define DT_LNK		3
> +#define DTYPE(de)	DT_UNKNOWN
> +#endif
> +
>  #endif
