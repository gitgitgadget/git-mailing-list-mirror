Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DA2EB64DD
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 22:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjGYWuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 18:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjGYWt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 18:49:59 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3AD6A52
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 15:46:35 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-579de633419so69838817b3.3
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 15:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690325148; x=1690929948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GhBXPN46MsDrkFEM3NiVI+FxxeOLLEax7NEFxVuKye0=;
        b=S3AYP49eqafxa9YLEim8mEI4CuYScd7Y+ksuRLdqUCYaiWeIH/UrI3v6Ad0HA700vK
         gDEXdo2c0Z3/u04+yI5NSa/GTevpGDXEz1fE0h4EKSU573DDqSvsqmNayJ3rL+S3txSL
         fb+ja491265KZSCnufOoP6yCKxMbSaXQL/kCTdTaKzgeOWa9KjWFk+iWV29HhUR2t/EU
         mehd8RQwCJBNmuWMWmDQS83jV8mk9v4QVwqHAxhFOdIAUClZFqS21h1V8bsrbqWTxfJJ
         GnxMYtFd1qSgCoKvoVor0kVtFvBlxLwyeQJD7mqFWho5Agae9uR1K4dT1m0oCEdKk95j
         8uJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690325148; x=1690929948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhBXPN46MsDrkFEM3NiVI+FxxeOLLEax7NEFxVuKye0=;
        b=AQ86EuwUk5RXuVF0Ky4vKLtmKHoUw8Ek4CvjGiyncTvlNux8K+DD8FhMhxZJErMEbb
         /hK4XxYw41+1why+y1EdIJiMA3rwHSrXYiOf3qgTu+TjatTiPpD+P7CKWjb1QeU7wDS5
         m2NdAZVCnV7w/3xIsTri/Kzj5dDoAIgxfeBkI57DUoDs92DH/3gZBXuQP8JxRDRMylpK
         But4gW3YgPyIOepPob+UP/Tc2PmbRsdMyyj+8I7x731h0QQAlOrsePvDi8Wb4PRUsv85
         I+76E+zV0I7UT03WpKlVXaFQqXa5LmpwLJbZYdMjxULsBpmmjTy96N08ZUFWyDgMmxpO
         mcOg==
X-Gm-Message-State: ABy/qLaKcCEHAIDiwCHKTKHps27OBb4k/uZYieZyyYOOBBidipYhImyZ
        IUVrxhsOxrOUf3321sK92618Rg==
X-Google-Smtp-Source: APBJJlEdMGqcDt9i9+ASJ7KXMEP3rPLg0D9rcro6yPgA6yvPUmkDs6SoGTC2RMuVMQTuUDlfXLYlPQ==
X-Received: by 2002:a81:6dd5:0:b0:570:899f:3a52 with SMTP id i204-20020a816dd5000000b00570899f3a52mr514578ywc.35.1690325148103;
        Tue, 25 Jul 2023 15:45:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k133-20020a816f8b000000b0058383efdf1asm3805949ywc.46.2023.07.25.15.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 15:45:47 -0700 (PDT)
Date:   Tue, 25 Jul 2023 18:45:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 3/8] repack: refactor finishing pack-objects command
Message-ID: <ZMBQmrMo+1hDIJwW@nand.local>
References: <20230705060812.2865188-1-christian.couder@gmail.com>
 <20230724085909.3831831-1-christian.couder@gmail.com>
 <20230724085909.3831831-4-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230724085909.3831831-4-christian.couder@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2023 at 10:59:04AM +0200, Christian Couder wrote:
> Create a new finish_pack_objects_cmd() to refactor duplicated code
> that handles reading the packfile names from the output of a
> `git pack-objects` command and putting it into a string_list, as well as
> calling finish_command().
>
> While at it, beautify a code comment a bit in the new function.

Everything here looks good to me. Thanks for cleaning this up into its
own function and DRY-ing things up a little bit.

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org
> ---
>  builtin/repack.c | 70 +++++++++++++++++++++++-------------------------
>  1 file changed, 33 insertions(+), 37 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index aea5ca9d44..96af2d1caf 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -696,6 +696,36 @@ static void remove_redundant_bitmaps(struct string_list *include,
>  	strbuf_release(&path);
>  }
>
> +static int finish_pack_objects_cmd(struct child_process *cmd,
> +				   struct string_list *names,
> +				   int local)

I'm glad to see "local" in the arguments list ;-). I think that the
implementation came out nice and clean here.

Thanks,
Taylor
