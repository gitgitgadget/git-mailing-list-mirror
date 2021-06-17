Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=AC_HTML_NONSENSE_TAGS,
	BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39320C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 21:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 041E86100B
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 21:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhFQVnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 17:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhFQVnz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 17:43:55 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CBEC061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 14:41:47 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso7635546otj.4
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 14:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=d0YqEyPizEuiXHN/mki7gKAYVMTIocNNXQPMiiPPorE=;
        b=flCVXkrOqca3D97Hz3UPyWBPuescV5HmAwe2x16qQ0/wqPxZ5wn7JXH9dLzSOg2D/R
         vPITpCmEPDDgbjBYv4c9sNx0R26TDYIlh+pZJgRwdaVkINiqgq35zxplpxksN6fR34Z2
         re6f58ewfzN6O/av2+TEFSiskWSYcb8CZb3dpsimwUreG+iHW8Exn2m29KP8eC3lFGhO
         v1kWRoIjTa3UCvUPXZ8/SNdZC2O7GOGPBb/5lXCWwqAWaSf878jFeRTAPw8kFQT+mzoH
         Oj0XkKCMc5KUVvcuAWzDbw6QQvI04wdvhWOeKZBqj0yY7ojXILJVOTQPemh4RBDTrNlE
         COMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=d0YqEyPizEuiXHN/mki7gKAYVMTIocNNXQPMiiPPorE=;
        b=TCtjlf2yZxanTX1spW6efC+70Qgws4b5NkadqDIZNPK3AFSzC6JwZFFU9o+sD8wpTq
         qziTFEcd7rYswyierKHXXa0Ok/Vpo66fqqzBYJhFiyfFiLKyNU8Eq3RWjPMwDt2pFc1w
         fnClB2Legto9y3a8tYtoRjh2FnPjv6hGAX4D0M062zOb+hbXHifCMAP/upFX10Z0H6rT
         FJA0vOlNTeYPpjEt2IZ0ZNoI69k8J4zG3K22fYzi635vrFbjou29ibH2mZjmdD1m3l9m
         Ar8O5s+rKV1fr9MTdD09uM9Lx94reuNc9m/JbekRL+udAicfW8wAisxvLnOukFj1bcVQ
         8W+A==
X-Gm-Message-State: AOAM5332mbT0g1JhX64VQEwU9ZCf+R1DSsu+YdOEeg+sTUkDZBo73yUm
        aia9SU8UwGfseDC1OCxmLR0=
X-Google-Smtp-Source: ABdhPJzKCsyw/CJQL2PUYfizFhd4XaoV6gptPEuIlbH/fQ3YtNLxhEetmul8L5QwWXxDrtEXkIQxDg==
X-Received: by 2002:a05:6830:161a:: with SMTP id g26mr6500177otr.62.1623966106366;
        Thu, 17 Jun 2021 14:41:46 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id r12sm560071otc.38.2021.06.17.14.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:41:46 -0700 (PDT)
Date:   Thu, 17 Jun 2021 16:41:44 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60cbc198d0552_1299208e8@natae.notmuch>
In-Reply-To: <patch-3.4-937e728f7f-20210617T105245Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210614T171626Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210617T105245Z-avarab@gmail.com>
 <patch-3.4-937e728f7f-20210617T105245Z-avarab@gmail.com>
Subject: RE: [PATCH v2 3/4] show-branch: don't <COLOR></RESET> for space
 characters
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Change the colored output introduced in ab07ba2a24 (show-branch: color
> the commit status signs, 2009-04-22) to not color and reset each
> individual space character we use for padding. The intent is to color
> just the "!", "+" etc. characters.

Obviously a fix, but perhaps show the current behavior:

<RED>+<RESET><GREEN> <RESET><YELLOW> <RESET><BLUE> <RESET><MAGENTA> <RESE=
T><CYAN> <RESET><BOLD;RED> <RESET><BOLD;GREEN> <RESET><BOLD;YELLOW> <RESE=
T><BOLD;BLUE> <RESET> [branch1] branch1

Versus:

<RED>+<RESET>          [branch1] branch1

> In theory this breaks things for anyone who's relying on the exact
> colored output of show-branch, in practice I'd think anyone parsing it
> isn't actively turning on the colored output.

Please let's limit our worries to real users. Few people use
`git show-branch`, even less would rely on parsing its bogus output.

> --- a/builtin/show-branch.c
> +++ b/builtin/show-branch.c
> @@ -939,9 +939,12 @@ int cmd_show_branch(int ac, const char **av, const=
 char *prefix)
>  					mark =3D '*';
>  				else
>  					mark =3D '+';
> -				printf("%s%c%s",
> -				       get_color_code(i),
> -				       mark, get_color_reset_code());
> +				if (mark =3D=3D ' ')
> +					putchar(mark);
> +				else
> +					printf("%s%c%s",
> +					       get_color_code(i),
> +					       mark, get_color_reset_code());

Very simple and obvious improvement.

Cheers.

-- =

Felipe Contreras=
