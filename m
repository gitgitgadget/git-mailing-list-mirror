Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE949C433E7
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 08:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69CBC21734
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 08:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ1CqMe+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgJHIgI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 04:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgJHIgI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 04:36:08 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35BDC061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 01:36:07 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e2so5619948wme.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 01:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IWnCQTnlannAWz1QBaVvxc8CeZ5wxR9quqzJmRYf6c0=;
        b=dJ1CqMe+Spf/fiJ4va8bxbNcMqTbxIXSpIwWgXxvRqwf/D9oU0UZQmw5moxS6ecgL4
         wdWyJtI7ZsRkEZq7FRblwyzq9alprIPykBD5Ojy3RiWQetQrpvuwQs/p+oYzusn1SyE4
         Oi5pIeDMveiMKRcmwxGV7HRbvEFoG7Jwv71RTCfUFs9XhAX/T26l4OHz2tWSSF4YCAqH
         Bt5NraZJ1NSSyCqYldvHPaJMZ26hqbkpTPgYbQ6aG05A7t9EMlOwd1owcOfLwUzVVBJD
         GOa7sM99NZYzhuhtEXiHiFKkwofmzB7I71BeOimaJ8siVLuQx2+iEYh2tv9ugAqT+Hlm
         HKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IWnCQTnlannAWz1QBaVvxc8CeZ5wxR9quqzJmRYf6c0=;
        b=mv/oOuLYR5rd5zNtk7p7qAsDRgXqjUgVOaDd4dk3ik8BweKlo2+U4b6MzzGneV9t3G
         XdmtWU+dMm4wUeNGXU5SVin+/APw5rwO8129yXGWjZjn+4wLVMA0GbS9+ve+L0C/e9pV
         ss0/rTzXwxUCyNGSPY4ef0gMaxr4x5rwlMSPprtc+vs35PahecD/9an/wOV3fq5BKJq3
         Vfmf/ngLl3a2hrbsBNoE+XmCLXFIn3Su++jlcXd07QNRD7jsESGlAGLElGWECuSDkzlU
         8wEY+zpQu2zGI6iGPFo2cBMnsvOcw7EZGgWPuXKjfo4EbvaElzUV6PYp2zzl4rMoePNH
         gmYQ==
X-Gm-Message-State: AOAM530rlN0gyBveO7/znrt/soTgNvgIlsuWEwVue5btFcT7h9Gn57px
        AMEo+3UNN4/0offM7ho8wYmjXcAhxRI=
X-Google-Smtp-Source: ABdhPJxZKWl2Pht+t0+Lq8Iozul42vcvCcc9n8xAzrMprbfo7A7ePV7VffzI+AOtu9w+OtXkHVjPjw==
X-Received: by 2002:a1c:df08:: with SMTP id w8mr7552894wmg.93.1602146166124;
        Thu, 08 Oct 2020 01:36:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15sm6261882wrv.94.2020.10.08.01.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 01:36:05 -0700 (PDT)
Message-Id: <pull.866.v2.git.git.1602146164799.gitgitgadget@gmail.com>
In-Reply-To: <pull.866.git.git.1602062726316.gitgitgadget@gmail.com>
References: <pull.866.git.git.1602062726316.gitgitgadget@gmail.com>
From:   "Sohom Datta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 08 Oct 2020 08:36:04 +0000
Subject: [PATCH v2] userdiff: expand detected chunk headers for css
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Sohom Datta <sohom.datta@learner.manipal.edu>,
        Sohom <sohom.datta@learner.manipal.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sohom <sohom.datta@learner.manipal.edu>

The regex used for the CSS builtin diff driver in git is only
able to show chunk headers for lines that start with a number,
a letter or an underscore.

However, the regex fails to detect classes (starts with a .), ids
(starts with a #), :root and attribute-value based selectors (for
example [class*="col-"]), as well as @based block-level statements
like @page,@keyframes and @media since all of them, start with a
special character.

Allow the selectors and block level statements to begin with these
special characters.

Signed-off-by: Sohom Datta <sohom.datta@learner.manipal.edu>
---
    userdiff: Expand detected chunk headers for css
    
    Changes since v1
    
     * Updated commit message as suggested by Johannes Sixt and Junio C
       Hamano
     * Simplified the regex as suggested by Junio C Hamano

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-866%2Fsohomdatta1%2Fcss-userdiff-fix-test-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-866/sohomdatta1/css-userdiff-fix-test-v2
Pull-Request: https://github.com/git/git/pull/866

Range-diff vs v1:

 1:  ca178c0cda ! 1:  a76703d4ac userdiff: expand detected chunk headers for css
     @@ Metadata
       ## Commit message ##
          userdiff: expand detected chunk headers for css
      
     -    Added support for classes, ids, :root selectors
     -    as well as @-based statements (ex: @page, @media
     -    and @keyframes ).
     +    The regex used for the CSS builtin diff driver in git is only
     +    able to show chunk headers for lines that start with a number,
     +    a letter or an underscore.
      
     -    Also added tests for the same.
     +    However, the regex fails to detect classes (starts with a .), ids
     +    (starts with a #), :root and attribute-value based selectors (for
     +    example [class*="col-"]), as well as @based block-level statements
     +    like @page,@keyframes and @media since all of them, start with a
     +    special character.
     +
     +    Allow the selectors and block level statements to begin with these
     +    special characters.
      
          Signed-off-by: Sohom Datta <sohom.datta@learner.manipal.edu>
      
     @@ userdiff.c: PATTERNS("csharp",
       IPATTERN("css",
       	 "![:;][[:space:]]*$\n"
      -	 "^[_a-z0-9].*$",
     -+	 "^(([_a-z0-9]|[:[@.#][_a-z0-9]).*)$",
     ++	 "^[:[@.#]?[_a-z0-9].*$",
       	 /* -- */
       	 /*
       	  * This regex comes from W3C CSS specs. Should theoretically also


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
index fde02f225b..f6a4b0fb2e 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -200,7 +200,7 @@ PATTERNS("csharp",
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
 IPATTERN("css",
 	 "![:;][[:space:]]*$\n"
-	 "^[_a-z0-9].*$",
+	 "^[:[@.#]?[_a-z0-9].*$",
 	 /* -- */
 	 /*
 	  * This regex comes from W3C CSS specs. Should theoretically also

base-commit: d98273ba77e1ab9ec755576bc86c716a97bf59d7
-- 
gitgitgadget
