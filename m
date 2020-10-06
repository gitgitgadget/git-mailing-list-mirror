Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC62C4363D
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 12:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE71206BE
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 12:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZZkoe2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgJFMN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 08:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgJFMNx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 08:13:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09E6C061755
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 05:13:52 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z1so13188999wrt.3
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 05:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=65H4TZRoR5vqAcoAffNeIlvf3geOav4t52X6FGC6zsM=;
        b=SZZkoe2Fdcl/hAZbRl4ETc9TQy/tYt3p2BL+1IOSAdjh9DlmnOrqNGcMYAQ/uy7q/q
         jwx54X6Ma1DPDW73DfH6bXVGC22XyztfJX3Vifst4ToLZ9Ctij8kJ7bxMIIsZsay4viK
         gZgCZpss9tktFsZ0IY5jrLM+NyOTNl+QLVdAnxpYFNm7Ef0Q+zQXWmNiWvRYjp691YFV
         UfjLAnzjmPH1ZMeHIv5906VxYZwq/ERVIzHTIavskd6GSKXCKwmeVp3/KkSg+0/IW8AI
         oJjeO2RkxW2nusNBxFpwnkUzMElkixXSdE7M9nVmuv51Qrltl5oi0vZPWo5HwpuCfDbn
         Db7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=65H4TZRoR5vqAcoAffNeIlvf3geOav4t52X6FGC6zsM=;
        b=QUfPqaNz8VaXQfhGfIj2867ew4BSGMWbEMHy9XRWh8RMlazulPm1gkXaCGFCMMEoIW
         3cMCywzwkI8RQxRN4wZAl/M/HBo7KUVtCuojRY1aQM0Wv6xnNDDuVvjt2aOeLKrCbO+K
         SljQXlpko3uV6AOLXZANR5zYspLF3UcUDC6tsp0qykr+LiL+2fGoPjEmZk/5WbCFlA5M
         m3JqYPWTdifDDapRgHxHkGD1zZcTXz+aR0WKuufwEMDJpxlkpj+ONYFTpif1RPzLu8iq
         eKANFKVbIMNash9beJkzrXr8Z9OtTp/8c4H1fYqgd4ydiTkMZGBMF4hjCRNJ2VpsPVgG
         +47w==
X-Gm-Message-State: AOAM532W2nt7T/T2gMfJ5MmF5A6UeYLG/MnW7aB0gO6rfRnG+24OX0b/
        TfG7srqDiLkcssw7ySf3th+AEjnyPuU=
X-Google-Smtp-Source: ABdhPJz6ffVj3vCdiOflvqr7jWJU3e+6klgnlEj9AVhwp9Zo0IJiHG51C0jcPlFNgJimnS58XkcXuA==
X-Received: by 2002:adf:c5d0:: with SMTP id v16mr4558083wrg.76.1601986431316;
        Tue, 06 Oct 2020 05:13:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t6sm4949627wre.30.2020.10.06.05.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 05:13:50 -0700 (PDT)
Message-Id: <pull.865.git.git.1601986430388.gitgitgadget@gmail.com>
From:   "Konrad Borowski via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Oct 2020 12:13:50 +0000
Subject: [PATCH] userdiff: support Rust macros
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Konrad Borowski <github@borowski.pw>,
        Konrad Borowski <konrad@borowski.pw>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Konrad Borowski <konrad@borowski.pw>

This adds a support for macro_rules! keyword which declares
a macro. It also includes a test case.

Signed-off-by: Konrad Borowski <konrad@borowski.pw>
---
    userdiff: support Rust macros

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-865%2Fxfix%2Fuserdiff-macro-rules-rust-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-865/xfix/userdiff-macro-rules-rust-v1
Pull-Request: https://github.com/git/git/pull/865

 t/t4018/rust-macro-rules | 6 ++++++
 userdiff.c               | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)
 create mode 100644 t/t4018/rust-macro-rules

diff --git a/t/t4018/rust-macro-rules b/t/t4018/rust-macro-rules
new file mode 100644
index 0000000000..ec610c5b62
--- /dev/null
+++ b/t/t4018/rust-macro-rules
@@ -0,0 +1,6 @@
+macro_rules! RIGHT {
+    () => {
+        // a comment
+        let x = ChangeMe;
+    };
+}
diff --git a/userdiff.c b/userdiff.c
index fde02f225b..f13a913697 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -165,7 +165,7 @@ PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
 	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
 PATTERNS("rust",
-	 "^[\t ]*((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl)[< \t]+[^;]*)$",
+	 "^[\t ]*(((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl)[< \t]+|macro_rules[\t ]*!)[^;]*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"

base-commit: d98273ba77e1ab9ec755576bc86c716a97bf59d7
-- 
gitgitgadget
