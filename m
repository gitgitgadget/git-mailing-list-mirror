Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40414C4363D
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 09:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1AE220872
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 09:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bV/v5S16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgJGJZa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 05:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgJGJZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 05:25:29 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56980C061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 02:25:29 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h7so1320225wre.4
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 02:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=I7VXybb0qwKBFZy7vF9j6DhV9lnXXH+rzMqtzYeGSIg=;
        b=bV/v5S16TyhEWJhDS74UExp0Dcd5L4RslzHzO48btGj6EGBtF22/qVyPAR1K1Pk3WR
         cb9m16sqLQgOuUuPm7xO6QIOuuY2Iu2YRdpcgAnD0NKcBr8AZWyBESq9SkNYP3DWGRyI
         hG7zfHjUHK6NRHN6nPxZMlJ5A9q0ZZyKIqLSJaeVtRBBCUv0ee0YUI+JMwA+Rt4ZD+wr
         IBcBn4jyehXzW86BNGJ8+0oaLCnJjxt0tuSMJ5RV5+KmVIFnWIbGu3O5HW94gyiZFcDV
         32sWs+SGrUop33nlYCre1cUy3TsYcXRLIkWoC0SDae3EVXDTI2yMyzmv4VZzNhCBEcwG
         LN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I7VXybb0qwKBFZy7vF9j6DhV9lnXXH+rzMqtzYeGSIg=;
        b=i7ns8YACF9GXa48ensr8vRafKhyEDXVNey5vVIL+vcNmmPUHJgYhSg9ZezhT6hCQQR
         xKNLbe0ph/jqJD7ZKFgt9yeNRCavFqE/9oWBi5CC8wZU2UcTiAHv7cZuX3RrGgE74Zj3
         F+xrs5LHYS1ka4mjTDIHpifxEUjTQEHLwoKb106Pz7WGinjfR5p4BMgvNSRTz0hVrl21
         e4skr11N1bkH+l1gSTi9vEZz/fzQb0Uv/p3onNU8eoGnkXUfHjpb1jPNV1jgv42n41y/
         DbCMR7YrODGgMIHb46rAh0U7Xvw649reXZW8xY75JBbvqaEbNTj9tBq8A0MvPfYZUCQN
         8dlA==
X-Gm-Message-State: AOAM532lm/l0fy9SKxJfWYwYdUScUlrTyLbQV2nW699ycZ0MAZNjvmEm
        tSju/BaDUOH4505WIpOVI9XyZ3djDq0=
X-Google-Smtp-Source: ABdhPJyz6fF/sB5VR0p6fT3H4DRyEtRcO2+sOcnwheI0ws5hYQDWyNLBknAL1f0LtiKAtAeCTvzXUA==
X-Received: by 2002:adf:8141:: with SMTP id 59mr2611789wrm.132.1602062727763;
        Wed, 07 Oct 2020 02:25:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm2120539wme.3.2020.10.07.02.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 02:25:27 -0700 (PDT)
Message-Id: <pull.866.git.git.1602062726316.gitgitgadget@gmail.com>
From:   "Sohom Datta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Oct 2020 09:25:26 +0000
Subject: [PATCH] userdiff: expand detected chunk headers for css
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sohom Datta <sohom.datta@learner.manipal.edu>,
        Sohom <sohom.datta@learner.manipal.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sohom <sohom.datta@learner.manipal.edu>

Added support for classes, ids, :root selectors
as well as @-based statements (ex: @page, @media
and @keyframes ).

Also added tests for the same.

Signed-off-by: Sohom Datta <sohom.datta@learner.manipal.edu>
---
    userdiff: Expand detected chunk headers for css
    
    Currently, the regex used for the CSS builtin diff driver in git is only
    able to show chunk headers for lines that start with a number, a letter
    or an underscore.
    
    However, the regex fails to detect classes (starts with a .), ids
    (starts with a #), :root and attribute-value based selectors (for
    example [class*="col-"]), as well as @based block-level statements like 
    @page,@keyframes and @media since all of them, start with a special
    character.
    
    I've modified the chunk header CSS regex so that it is able to detect
    the statements above and add them to the chunk header.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-866%2Fsohomdatta1%2Fcss-userdiff-fix-test-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-866/sohomdatta1/css-userdiff-fix-test-v1
Pull-Request: https://github.com/git/git/pull/866

 t/t4018/css-attribute-value-selector |  4 ++++
 t/t4018/css-block-level-@-statements | 10 ++++++++++
 t/t4018/css-class-selector           |  4 ++++
 t/t4018/css-id-selector              |  4 ++++
 t/t4018/css-root-selector            |  4 ++++
 userdiff.c                           |  2 +-
 6 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 t/t4018/css-attribute-value-selector
 create mode 100644 t/t4018/css-block-level-@-statements
 create mode 100644 t/t4018/css-class-selector
 create mode 100644 t/t4018/css-id-selector
 create mode 100644 t/t4018/css-root-selector

diff --git a/t/t4018/css-attribute-value-selector b/t/t4018/css-attribute-value-selector
new file mode 100644
index 0000000000..918256b20c
--- /dev/null
+++ b/t/t4018/css-attribute-value-selector
@@ -0,0 +1,4 @@
+[class*="RIGHT"] {
+    background : #000;
+    border : 10px ChangeMe #C6C6C6;
+}
diff --git a/t/t4018/css-block-level-@-statements b/t/t4018/css-block-level-@-statements
new file mode 100644
index 0000000000..d6755f2f3d
--- /dev/null
+++ b/t/t4018/css-block-level-@-statements
@@ -0,0 +1,10 @@
+@keyframes RIGHT {
+    from {
+        background : #000;
+        border : 10px ChangeMe #C6C6C6;
+    }
+    to {
+        background : #fff;
+        border : 10px solid #C6C6C6;
+    }
+}
diff --git a/t/t4018/css-class-selector b/t/t4018/css-class-selector
new file mode 100644
index 0000000000..f790a0062f
--- /dev/null
+++ b/t/t4018/css-class-selector
@@ -0,0 +1,4 @@
+.RIGHT {
+    background : #000;
+    border : 10px ChangeMe #C6C6C6;
+}
diff --git a/t/t4018/css-id-selector b/t/t4018/css-id-selector
new file mode 100644
index 0000000000..17c5111052
--- /dev/null
+++ b/t/t4018/css-id-selector
@@ -0,0 +1,4 @@
+#RIGHT {
+    background : #000;
+    border : 10px ChangeMe #C6C6C6;
+}
diff --git a/t/t4018/css-root-selector b/t/t4018/css-root-selector
new file mode 100644
index 0000000000..22b958e369
--- /dev/null
+++ b/t/t4018/css-root-selector
@@ -0,0 +1,4 @@
+:RIGHT {
+    background : #000;
+    border : 10px ChangeMe #C6C6C6;
+}
diff --git a/userdiff.c b/userdiff.c
index fde02f225b..49c9771891 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -200,7 +200,7 @@ PATTERNS("csharp",
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
 IPATTERN("css",
 	 "![:;][[:space:]]*$\n"
-	 "^[_a-z0-9].*$",
+	 "^(([_a-z0-9]|[:[@.#][_a-z0-9]).*)$",
 	 /* -- */
 	 /*
 	  * This regex comes from W3C CSS specs. Should theoretically also

base-commit: d98273ba77e1ab9ec755576bc86c716a97bf59d7
-- 
gitgitgadget
