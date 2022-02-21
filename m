Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ED0C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 16:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379870AbiBUQF6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 11:05:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379856AbiBUQF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 11:05:56 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CDE1098
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 08:05:32 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so11497351wmq.3
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 08:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gQv7O8/MeAyzqm5fw1MCFm4QeOnFNoPc4HbCltvnlbQ=;
        b=b+Le0tVFrt7gSSKYbHKtpI2F/18GsfVh1tdcLabBhn9lOF2lPlBt/mEZVU5ucNh6oX
         tpQip+4zAloIezerMCjaZBitoPwiSc1w6wzC7gtHN2YrZZUvFYcabundQtSSXvyikRut
         J8E4oxZ/GP2vSAKwftWXzRIrMu7YEk07uAgDbyv+9/lnY1FWNHEssPqRO5J94DHDypox
         CaATyVOoFVwbj55IVf8kuc73cYkH+J6kY8/vCZS5IgujfxWX7rrNVn0hduJIrt5dZNbe
         i1qb5sx83aCot6rxAtEili+n7HUBsKf8SjwbDEeyMQRr5gbSti+lK0/T0PPM0oi0kkwU
         raaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gQv7O8/MeAyzqm5fw1MCFm4QeOnFNoPc4HbCltvnlbQ=;
        b=mwKGAir7iWCqtmZYgYQGLQgO/hb0Uge7tOgaPrYM16dcE4XT2i0QpsK7MSbwfNyfzF
         RjC16scvCZS5BioQFO8dzKAkZ5cjH2RZWpQqEOrEo7xgZybyOdeqibqVyaJ/j08/KlEX
         8Jq0iambGhKOPJhfyW2yjv+Yb7wxd4ZSbRkckVxZfTqvEtOGeRFUakYMSwlTu6bveyqZ
         Fp5JYlLQ/4OZDKsT4e4AlQ7E20tWe3555dARfqFweXxZ8Yc0E75ZF0ZreceqpGCZkil4
         R8td3r8zMJDh5w0IHuxMQXF+wQPWoacrKX9By4Mg/cZDYkTNrftPqhFphg2ccpU/w+oU
         ktOg==
X-Gm-Message-State: AOAM531IJN1xbUQEhbeZ7oUrk5Dw6b+GUiknke5puxP8GOwTX4X/tsqS
        12A0nXK2WI9C/CaoisvRjWKzi1WhQPBSOg==
X-Google-Smtp-Source: ABdhPJxKS0Ix1bZFo5elIUa8nI2c/IU+tqg8rYSgcVDSNJPcBFSmMdDJxa6Bif8m/CvLSfCH9jHOSA==
X-Received: by 2002:a05:600c:a53:b0:37d:46cd:bbb3 with SMTP id c19-20020a05600c0a5300b0037d46cdbbb3mr18696562wmq.122.1645459531208;
        Mon, 21 Feb 2022 08:05:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r14sm25284207wrz.84.2022.02.21.08.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 08:05:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/2] git-compat-util.h: clarify GCC v.s. C99-specific in comment
Date:   Mon, 21 Feb 2022 17:05:26 +0100
Message-Id: <patch-v4-1.2-1a15fe4fd74-20220221T160440Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-v4-0.2-00000000000-20220221T160440Z-avarab@gmail.com>
References: <cover-v3-0.3-00000000000-20220219T103752Z-avarab@gmail.com> <cover-v4-0.2-00000000000-20220221T160440Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a comment added in e208f9cc757 (make error()'s constant return
value more visible, 2012-12-15). It's not correct that this is GCC-ism
anymore, it's code that uses standard C99 features.

The comment being changed here pre-dates the HAVE_VARIADIC_MACROS
define, which we got in e05bed960d3 (trace: add 'file:line' to all
trace output, 2014-07-12).

The original implementation of an error() macro) in e208f9cc757 used a
GCC-ism with the paste operator (see the commit message for mention of
it), but that was dropped later by 9798f7e5f9 (Use __VA_ARGS__ for all
of error's arguments, 2013-02-08), giving us the C99-portable version
we have now.

While we could remove the __GNUC__ define here, it might cause issues
for other compilers or static analysis systems, so let's not. See
87fe5df365 (inline constant return from error() function, 2014-05-06)
for one such issue.

See also e05bed960d3 (trace: add 'file:line' to all trace output,
2014-07-12) for another comment about GNUC's handling of __VA_ARGS__.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-compat-util.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 876907b9df4..2d9b75a021a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -534,9 +534,7 @@ void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 /*
  * Let callers be aware of the constant return value; this can help
  * gcc with -Wuninitialized analysis. We restrict this trick to gcc, though,
- * because some compilers may not support variadic macros. Since we're only
- * trying to help gcc, anyway, it's OK; other compilers will fall back to
- * using the function as usual.
+ * because other compilers may be confused by this.
  */
 #if defined(__GNUC__)
 static inline int const_error(void)
-- 
2.35.1.1132.ga1fe46f8690

