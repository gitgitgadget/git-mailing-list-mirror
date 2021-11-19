Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3A9C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 12:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B01D61AFB
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 12:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbhKSMtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 07:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbhKSMtk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 07:49:40 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02250C061757
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 04:46:38 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id c4so17947062wrd.9
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 04:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8eOwOTlHoGfLMEgheBYSa+0yJBVxZVqLvoNBgpbMPUY=;
        b=T0AFvQFpucorMyN71V1Hw3SeNXQyn8uHtiom5ROGxh1M2UNMMuG8ehsgKLZU+a+yGi
         psjEgxKtbQ6sBRPDWky4ylHwxVTPFcOi5YwimUnk1T3HWDWu/8sag7xpPDSNW2ynJ0qq
         FITh8KohbZRXYn9hZGYsFZrmplfvGUtSBGHfjBeETVJ3SKxucj6qTV4FNb83ZM9Eh4MR
         u3D8X9TCxN5GmJDnZV8E9jGQ2LVxVORUIZ/MpgEFxs3reDRZ1u0FwNQ8A8BHLLM6+oep
         jO9LxNqS1QMra971n+mMX8iXoMmV+p64+/OKFzLVEOAWnMheOOCOorx2nPC1pj6yeV4x
         lrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8eOwOTlHoGfLMEgheBYSa+0yJBVxZVqLvoNBgpbMPUY=;
        b=apmSz+26Ua4WmpxD45um8pk05ThgDEr6AFpe/q6GBQJHlMpNtRLi3Aqp/Bhm0M6Izt
         084EOjTA0GTFLKu3aNchJemWxDwLMd1+XsCUDZCCBn//MFZdQxewzZVyzzNXxN4MgHKr
         cStNlC2KJep9qATe4JPw5XDihy6I4mFAEgQwOj7T+ACUuFvgNeRStCNYvRvOBPIihIp+
         Hckk66VHLXc9Ie24K/Wht47XqFpewek4f0quOnYgJBDoEVi3nhmjRAwdL7cWidPrIQpS
         lLOOz85Wty0Zjyzoa7+NbUSCIT+iHMTWsrWSxocXT8qxlrENpFoJOaXy0Bw3xQEq4bHO
         WSPA==
X-Gm-Message-State: AOAM532RLwBEI7QwwXfugIFBfKhgi6EoYSIwSTfLOQMVE10S5gG84Wc+
        9RLU0tsIrJ7A9q8YHioUvSR+fxv6keIBrA==
X-Google-Smtp-Source: ABdhPJxHk9EeCMT02gM/OZsvDGhb+H/R+5VKVkregP1uJvPMkg8Zz7ECqBtj1zek9e/Nh90wbHCDEg==
X-Received: by 2002:a5d:40cf:: with SMTP id b15mr6979571wrq.161.1637325996301;
        Fri, 19 Nov 2021 04:46:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w7sm2857567wru.51.2021.11.19.04.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 04:46:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/6] strbuf: remove unused istarts_with() function
Date:   Fri, 19 Nov 2021 13:46:25 +0100
Message-Id: <patch-5.6-642eec3d77c-20211119T124420Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.817.gb03b3d32691
In-Reply-To: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function was added in 66b8af3e124 (strbuf: add a case insensitive
starts_with(), 2018-03-09) for use with code added in
2f0c4a362c5 (utf8: teach same_encoding() alternative UTF encoding
names, 2018-04-15).

That use got rewritten in ed283588330 (convert: use skip_iprefix() in
validate_encoding(), 2019-11-08) to use skip_iprefix() instead.

It's arguably slightly odd to have a skip_prefix() and iskip_prefix(),
but not both variants when it comes to starts_with(), but this is easy
enough to resurrect should we ever need it, so let's drop it for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-compat-util.h | 1 -
 strbuf.c          | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index d70ce142861..7117024a28b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -512,7 +512,6 @@ report_fn get_warn_routine(void);
 void set_die_is_recursing_routine(int (*routine)(void));
 
 int starts_with(const char *str, const char *prefix);
-int istarts_with(const char *str, const char *prefix);
 
 /*
  * If the string "str" begins with the string found in "prefix", return 1.
diff --git a/strbuf.c b/strbuf.c
index b22e9816559..1b52e3c8250 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -12,15 +12,6 @@ int starts_with(const char *str, const char *prefix)
 			return 0;
 }
 
-int istarts_with(const char *str, const char *prefix)
-{
-	for (; ; str++, prefix++)
-		if (!*prefix)
-			return 1;
-		else if (tolower(*str) != tolower(*prefix))
-			return 0;
-}
-
 int skip_to_optional_arg_default(const char *str, const char *prefix,
 				 const char **arg, const char *def)
 {
-- 
2.34.0.817.gb03b3d32691

