Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A31DC4708E
	for <git@archiver.kernel.org>; Sat, 29 May 2021 05:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D8EC61004
	for <git@archiver.kernel.org>; Sat, 29 May 2021 05:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhE2FkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 01:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhE2FkX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 01:40:23 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AE9C061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 22:38:46 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q16so2616906pls.6
        for <git@vger.kernel.org>; Fri, 28 May 2021 22:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=42D/0mPSpm744Fr6+x5reflbTzOlJFokS/dyhHFPiV8=;
        b=sYOV8640tv1mkLVtPDPLdrwjlaiPgOY+53qt/RyIRLIEPFCxCSo7MlyF4JkDp11frJ
         B1iYex5Rau/1ib6JoumXK9Xu3cKaTs0wihfOtwDlXNH+ppIiqLDR6X/sMEdZHYGJkZnA
         /TDO91aHuk98KDsTaJl1QVqSqz3t0v5J33ZgeJUvSD4qoZpQewCdJZVCaNhQrGGQ7DJv
         MhUlovrBj3Syqwfznbx2dZIfVHwOXbkRjJHRiGkPc/t9LSWIFFwBEjylzBmJ04d3JFtB
         0kpyxaEnDkEzYBtVI9NIG8YZpRhLlg0WfTDksATY1vIYmEz10V0sal1m4Fxlf72Toxk9
         +WWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=42D/0mPSpm744Fr6+x5reflbTzOlJFokS/dyhHFPiV8=;
        b=mBmpGzjZeEgwnOxrknX61psWuhIYw42x7Z/5S9H6f3iXjFoMFTqj6r9VeWIfim5UFX
         hdE6fMu++SpiFwGrH1YeDKVly8lJ+cokHNtZc9s3DbpncgMsSoXTdyfQg9k3EFCTqTDy
         H2jZAg+uOhy6SV4PqkOBXaDKld3FRMHR537FxBhnQinQyMJp/c3QTS5orGrvCKIxAxEp
         LoexoY/XCkJ4IyPZgY9IkS68L3xc0RnAYM4VOOuJY8O1AOkmR5P1dpHJT8ecuWYAH991
         gkmSYUpCneWcFs9EgJwUkqHv5CKucsC9PetCFrIYTjdZ6e3BASuFfySpEGq3oDlBF7vu
         SXPQ==
X-Gm-Message-State: AOAM530IE0xo4dPMlveRQNGopM4OCWXI7Hccmmr6MSqtsGs72wTqhJ77
        /nsF+ecGc8vkdxPtswWQXH8=
X-Google-Smtp-Source: ABdhPJxnWwldFT9zIIi6Ni5rUN6Aep4MC9BKWZtr/r4P+A44/75Iagje4P8z6OOSgxBp6Qiyskg5bQ==
X-Received: by 2002:a17:90a:e611:: with SMTP id j17mr8439212pjy.69.1622266726207;
        Fri, 28 May 2021 22:38:46 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-65.three.co.id. [180.214.232.65])
        by smtp.gmail.com with ESMTPSA id hk15sm5469022pjb.53.2021.05.28.22.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 22:38:45 -0700 (PDT)
Subject: Re: [PATCH 11/11] doc: push: explain default=simple correctly
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
References: <20210528201014.2175179-1-felipe.contreras@gmail.com>
 <20210528201014.2175179-12-felipe.contreras@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <540e249f-6bf9-0e4f-51db-20ce3ef8e5bf@gmail.com>
Date:   Sat, 29 May 2021 12:38:41 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210528201014.2175179-12-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/05/21 03.10, Felipe Contreras wrote:
> diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
> index f2667b2689..632033638c 100644
> --- a/Documentation/config/push.txt
> +++ b/Documentation/config/push.txt
> @@ -24,15 +24,14 @@ push.default::
>   
>   * `tracking` - This is a deprecated synonym for `upstream`.
>   
> -* `simple` - in centralized workflow, work like `upstream` with an
> -  added safety to refuse to push if the upstream branch's name is
> -  different from the local one.
> +* `simple` - pushes the current branch with the same name on the remote.
>   +
> -When pushing to a remote that is different from the remote you normally
> -pull from, work as `current`.  This is the safest option and is suited
> -for beginners.
> +If you are working on a centralized workflow (pushing to the same repository you
> +pull from, which is typically `origin`), then you need to configure an upstream
> +branch with the same name.
>   +
> -This mode has become the default in Git 2.0.
> +This mode is the default since Git 2.0, and is the safest option suited for
> +beginners.
>   
>   * `matching` - push all branches having the same name on both ends.
>     This makes the repository you are pushing to remember the set of
> 

Grammar looks OK.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
