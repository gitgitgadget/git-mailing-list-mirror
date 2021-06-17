Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C11C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 20:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8665E613D6
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 20:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhFQUHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 16:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhFQUHB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 16:07:01 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632C7C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 13:04:42 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id t140so7898669oih.0
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 13:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=7LWvCxqug0kw5Htjzd0i5FGP5/cDRcf+MZ2WkPnn60o=;
        b=jnRz431Hrkq+cAJjRJcldw3RSzGhzApBZjCTJdapxLTocuvAAyIHp1/9bxZA76g5nf
         YKdlBnWrmgpMPzho+EjKEZ4QDgptGHITjFxqrtqdTv408yHLq00SBux3KvTqU1IF5mhL
         76qraKCBymW4LZjq20E7bxsLo3Df3iyDSNns3RiS6aUCqQQqo67WAozJJs8xi2GjKtvl
         HMierYMQFEGAmLIxvyZmVy/HZ+eyzUxp/xAPyYbjo6TxG94ypzkdIYVXsOIDFW9C7zJi
         oZQkFfujpb85hR0GUKmuV1dZA9C4Ba0k6FJDAhH3HJgOaOvD2AKm8d2QN/nKnyM5nuAA
         2GMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=7LWvCxqug0kw5Htjzd0i5FGP5/cDRcf+MZ2WkPnn60o=;
        b=cbtRM6ylQvksvA5rCTx6S+OPnzkmLRUWS/PsToi7lfEBM0FqdZzr8f0sIjQShfCSLG
         iAFWnlmG28bPHtoacpIwQbnmSXxUqg4rJCqfw0Trd81zxNj32QPArL8H11NqvQlo6fX1
         fN/4YX/VCxUKAboZoQ3ctS2utHJ87FB8H/vSQdUmBsnqJczh229pEnF8rpC3H2gdpIO6
         ty/p/dDBmSoLNS/X7C9WhM/U810UkYfNQvZTn8UV0lC+BnM1qU4uHTh4RfbI9tVI1Omh
         gempbxbf2iIMaRrJnX6LnJa3NJJJ6MlY00d7+Q06dAiNT5VNxQWDisyMnNVzayN8/cQr
         KiHg==
X-Gm-Message-State: AOAM533KMOvoTEXO+N7v8OQD/4rTOLvJpZ1etCBffL4SDLpRP6T7WIEa
        DgkJ//RWNgYCfJu9FvAqX/w=
X-Google-Smtp-Source: ABdhPJxvqk0nMzEyHVKEM7GFEGc3W4Gxb+0C0IyHDLouufqdJ91CYJivGzwo0i8azM7YRteydfeaAg==
X-Received: by 2002:aca:dac5:: with SMTP id r188mr12202805oig.100.1623960281788;
        Thu, 17 Jun 2021 13:04:41 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id c12sm1356782oov.11.2021.06.17.13.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 13:04:41 -0700 (PDT)
Date:   Thu, 17 Jun 2021 15:04:39 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60cbaad7c4cee_9bf208a6@natae.notmuch>
In-Reply-To: <patch-1.3-27c94247f8-20210617T095827Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210617T095827Z-avarab@gmail.com>
 <patch-1.3-27c94247f8-20210617T095827Z-avarab@gmail.com>
Subject: RE: [PATCH 1/3] Makefile: mark "check" target as .PHONY
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> --- a/Makefile
> +++ b/Makefile
> @@ -2910,6 +2910,7 @@ hdr-check: $(HCO)
>  style:
>  	git clang-format --style file --diff --extensions c,h
>  =

> +.PHONY: check
>  check: config-list.h command-list.h
>  	@if sparse; \
>  	then \

Obviously correct.

-- =

Felipe Contreras=
