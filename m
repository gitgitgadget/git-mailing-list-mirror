Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EDDC4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 21:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D76E20732
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 21:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503525AbgLNVZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 16:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388054AbgLNVZm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 16:25:42 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166F3C0613D3
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 13:25:02 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id j21so1707365oou.11
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 13:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=uvnzVynpkzrrrX4wno0hFsaIV11+mtRR/pbBrrDdazs=;
        b=DjOihn7PywfCVkYMo4mXCgOTPtRrX7qz/kEJ6tONVdNu0yBP++Yn+hXu4eLJRs238W
         0LhmocKg2bt/mpLOn+7xCPftqJqrf24ZHb/Xe6V8Sd2+Z6rm1t86br/oMYDOdXSLTo56
         i17jPzKyawhqZQT/W/56s+kqch6FlWSIUGU4XRx+9v3Htp22sEltd1I3eM4EDNk/c/us
         fYoa85YAYEO+mPxX60hUPHvccFYneHXj4rntkvdY3z6K3LRYCeO0Sm7vMjlTAGlJimyn
         xqjnG1HI38otjFKVVoa035VIgrIiS0z4qjld4GgnZcEQhmqJFZvkTdFoEO8pDTeTqL2J
         6JOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=uvnzVynpkzrrrX4wno0hFsaIV11+mtRR/pbBrrDdazs=;
        b=SmakHNW/cnZIycRLvmvz+XAynnr13ZxMFxlqjxL1CAscv3WOoYGsULVXbIj0QgD89w
         hWTXQ9eJDbugYor9XWeUbeDgGBIkoRsvo3Zlt0usaiGmvq4tBmxrL5ijdPd3fv6hPhX5
         V7ZLzqoMghE0lML3/nNfrxxPKQ0Ytu3XTLKDc62mc7Ho0nQLNswyra7PiIFbCKt/7xDQ
         qh4K5iVB4cl5g1BRTESaeto6K95VMmSHznTjd2PyQTG0q5Q+RgTmK/AMxY9O79GEP2su
         M9AjitcSKwSlTvnxOf8f4mk6LqKRcqYWpPPLiw1Og8cyuQ1bgW6D2JC4Eu98MPaXCOLr
         7zdA==
X-Gm-Message-State: AOAM530y0LoEgwPdevH6jRyxPxR70ubQLCgQ+wS2j4rJ6GIltH4XHVIn
        zoQ/ohPkm8sbKVP5rtBeOcQxOMGPWJosjw==
X-Google-Smtp-Source: ABdhPJxQqJ3fQr3hm3xf+gRThLf7W7ZM4fIylShzIfTG6ctqxO/xCAq2Ggwjd84wzaP8p4KWWpyM1Q==
X-Received: by 2002:a4a:aac4:: with SMTP id e4mr20467844oon.2.1607981100788;
        Mon, 14 Dec 2020 13:25:00 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id v4sm4619266otk.50.2020.12.14.13.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 13:25:00 -0800 (PST)
Date:   Mon, 14 Dec 2020 15:24:58 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <5fd7d82a9b6ab_d44af208bb@natae.notmuch>
In-Reply-To: <20201214202647.3340193-6-gitster@pobox.com>
References: <20201214202647.3340193-1-gitster@pobox.com>
 <20201214202647.3340193-6-gitster@pobox.com>
Subject: RE: [PATCH v7 5/5] pull: display default warning only when non-ff
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> @@ -1044,7 +1045,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  	if (opt_rebase && merge_heads.nr > 1)
>  		die(_("Cannot rebase onto multiple branches."));
>  
> -	if (rebase_unspecified && !opt_ff) {
> +	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
> +
> +	if (rebase_unspecified && !opt_ff && !can_ff) {
>  		if (opt_verbosity >= 0)
>  			show_advice_pull_non_ff();
>  	}

I strongly predict the conditionals will end up looking similar to:

  if (!can_ff) {
          if (rebase_unspecified && !opt_ff && opt_verbosity >= 0)
                  show_advice_pull_non_ff();
  }

But OK.

-- 
Felipe Contreras
