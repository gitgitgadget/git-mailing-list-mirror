Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6573EC11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 13:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41DAD61425
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 13:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhGBNgW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 09:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhGBNgW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 09:36:22 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8785C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 06:33:49 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id n25so13248892edw.9
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 06:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=viffqq3N/WBQKks46FIii09h1P4gqZYXq8l8N5CG6Fs=;
        b=EsxPlLsXbEXwJTeNLV6LncNfJ05SJbrrcW4pfLFZJPsKD5uyc/fRbqL00gXgd035W/
         A1w1X+v4Z6e4ug+9xl+b5+8950l+rMKY/mpO8WRjXSqUjUmrLjpQlBxRka3rioFBCTJG
         8kQilcA4QcdDo6pzumP/HxtDa6JaJjFYuVVttZwoRhKoryHBVXXgd4NbdGdkPpncWN3y
         F6YnSVdkIMfOTnvkaU8AdrAgOvn6xhNNufm9k7gXifHh+wYtboCiTGqTn+xNXChQxGML
         MJbVoWCaGWdywd2kADhZlXd6qElXfZOMseZf+G/dyGWJoFTK7ew148jya7tPgUqIFFmv
         HUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=viffqq3N/WBQKks46FIii09h1P4gqZYXq8l8N5CG6Fs=;
        b=sFiw3B2vxNpQc2ZTP/Hgw3ftD2KkkJ0g5+y94HV7dT1kM1/OrxI2sMfZ70+KjUq/sG
         vZOzSDC7A3YcvNdeLC6PAvolzOeXTIhsZfuX4VLNpbN1eUr8Uxi/JHBzIWdA/GsK8rcx
         y3AhWkvKpYAacrcDtXvoVQDWWRoNABAFxSPkb5ljE/4R2x2a5p59Wy/dKKyXoUSKB5l5
         M+IGx5ZL4lCdfcvGsZOIEX5X5N2j9KiaS+RNpiz4r6l6Y3W9ozkAn3avWYDt/CwX6acz
         qV3kpyf992wawFLY96LkQoKWwc5VnfbY8cD+shzp7uD+Onq2DrYQdniqZzj3D5CzU0tP
         X6/g==
X-Gm-Message-State: AOAM532ryXv36DzmiIGXLh2hOZGJwLdWoitg+H30TNzZDB9bhFAAtvj1
        SQh5sWIGy09ESVF6407HpGzOLORgLiBYaA==
X-Google-Smtp-Source: ABdhPJzAzjn8JdTd14WNjqwrDRcDcHCfxChut7kZzO7QLxsQAke1iJE9T8EuvNFjfJqEv+zoquYO3w==
X-Received: by 2002:a05:6402:40cc:: with SMTP id z12mr6802911edb.113.1625232828056;
        Fri, 02 Jul 2021 06:33:48 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u4sm1038810eje.81.2021.07.02.06.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 06:33:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 08/15] [GSOC] ref-filter: add cat_file_mode in struct
 ref_format
Date:   Fri, 02 Jul 2021 15:32:38 +0200
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
 <9568baf5dddcc0637c15f698aea24d230c4d01b2.1625155693.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <9568baf5dddcc0637c15f698aea24d230c4d01b2.1625155693.git.gitgitgadget@gmail.com>
Message-ID: <87czs0alhg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, ZheNing Hu via GitGitGadget wrote:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Add `cat_file_mode` member in struct `ref_format`, when
> `cat-file --batch` use ref-filter logic later, it can help
> us reject atoms in verify_ref_format() which cat-file cannot
> use, e.g. `%(refname)`, `%(push)`, `%(upstream)`...
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Hariom Verma <hariom18599@gmail.com>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  ref-filter.c | 11 +++++++++--
>  ref-filter.h |  1 +
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 731e596eaa6..45122959eef 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1021,8 +1021,15 @@ int verify_ref_format(struct ref_format *format)
>  		if (at < 0)
>  			die("%s", err.buf);
>  
> -		if (used_atom[at].atom_type == ATOM_REST)
> -			die("this command reject atom %%(%.*s)", (int)(ep - sp - 2), sp + 2);
> +		if ((!format->cat_file_mode && used_atom[at].atom_type == ATOM_REST) ||
> +		    (format->cat_file_mode && (used_atom[at].atom_type == ATOM_FLAG ||
> +					       used_atom[at].atom_type == ATOM_HEAD ||
> +					       used_atom[at].atom_type == ATOM_PUSH ||
> +					       used_atom[at].atom_type == ATOM_REFNAME ||
> +					       used_atom[at].atom_type == ATOM_SYMREF ||
> +					       used_atom[at].atom_type == ATOM_UPSTREAM ||
> +					       used_atom[at].atom_type == ATOM_WORKTREEPATH)))
> +			die(_("this command reject atom %%(%.*s)"), (int)(ep - sp - 2), sp + 2);

Maybe it was brought up already, but those ATOM_* are mostly continuous
where they're declared, Maybe worth making it so having a comment like:

    /* These need to be in order, used in verify_ref_format */

And then just doing:

    used_atom[at].atom_type >= FIRST_OF_THOSE &&
    used_atom[at].atom_type >= LAST_OF_THOSE

Maybe it's too magical and peeking under the hood of an enum...
