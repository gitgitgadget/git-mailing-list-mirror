Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864D1C5519F
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 21:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 436882242C
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 21:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGMI0mIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgKNVSL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 16:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgKNVSL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 16:18:11 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149A5C0613D1
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 13:18:11 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u12so6992771wrt.0
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 13:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=5chmW2QIHUxbRHInjDcbWYUpA/m1Qk+EHtO8/zrhsO0=;
        b=WGMI0mIGzCgydUk3NtBQpmyY1vkfhst8VbfLh5WIOexaBgLe04v43O8Gp+rI3/s9q7
         dlEkzDbZGCiFghXucD8GCFdryiDRSUGOSn5EYDywD9Gkw6LZj+hUsKpvHKkjVRG4D1cB
         LXy1TcdP6SrcXeOth7MRDf2lLAxhG5Ldy5/M7IQUFR+cuiNVXGdTL8ws6Yb3fMi8a4yR
         DbHwceS0ZNvCpWSxq3atYAcuGeaOXEYzjBzAJEJC3h7o3/obYQLEjzHegUUeJes0iEow
         z1UFRBEf4HaZEjWTiC3DviI89pPWtP2emMHAFAXLCl126BD5yN/5tmvTDNHVZKUM5c90
         C/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5chmW2QIHUxbRHInjDcbWYUpA/m1Qk+EHtO8/zrhsO0=;
        b=Wu0W6thq9m/MrHODTBLMTu8TbKorqnVtIKO3guF22MngzHTaBo/eovKRpiZXRR/yFY
         rmX0GXN0pdZOeErfQh6m4ifSb9fxog3KtBXhUBhoh4kNtOvxOKeweR9pHE04fwBE+uwP
         eJH4oprRxvSnZ+x4rlSAYXacNrQ4LxI5Tc17KZCvYxzrTquY+lSffZ/Q49FhozGjesuZ
         ZUxmY4O/aQpCSceQGt+S0dbr4MKoDGoDZcmHxlWwQjXSuH4s8MoXOURnm5wPk+35ekkB
         cReVQqLGcqIsmQPYn83CFWiuzwzhQ/SqSbI0u2v4mnlAhEs9aBJOHn+agXapjByj0LX5
         hAng==
X-Gm-Message-State: AOAM530IEVHGQUczgjd9jn9xBoRvrkCaL807kKEQkEbGTR4zTkee/Qhx
        +RCezlWtKhFa3xjFUuYjb+0YGvSj1Mc=
X-Google-Smtp-Source: ABdhPJwfouGXidc2Z+7IbZPHxu6Na05/sv2V4yeMY5nOYhAInD8cMLABvgRSq3vjhr8OWtVMNZxhcg==
X-Received: by 2002:adf:f9c4:: with SMTP id w4mr11441988wrr.64.1605388688791;
        Sat, 14 Nov 2020 13:18:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12sm16139122wrw.28.2020.11.14.13.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 13:18:08 -0800 (PST)
Message-Id: <pull.915.git.git.1605388687554.gitgitgadget@gmail.com>
From:   "Javier Spagnoletti via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 14 Nov 2020 21:18:07 +0000
Subject: [PATCH] userdiff: php: Improved tests catching "abstract" and "final"
 functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Javier Spagnoletti <phansys@gmail.com>,
        Javier Spagnoletti <phansys@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Javier Spagnoletti <phansys@gmail.com>

Since the original tests cases were using other detectable keywords (like
"public" or "protected"), they are able to pass even if the keywords
intended to be covered are not present.

Signed-off-by: Javier Spagnoletti <phansys@gmail.com>
---
    userdiff: php: Improved test cases used to catch "abstract" and "final"
    functions
    
    Since the original tests cases were using other detectable keywords
    (like "public" or "protected"), they are able to pass even if the
    keywords intended to be covered are not present. In the case of the test
    for "abstract" keyword, the method's body was removed in the fixture,
    since PHP doesn't allow an abstract method to have a body.
    
    Signed-off-by: Javier Spagnoletti phansys@gmail.com [phansys@gmail.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-915%2Fphansys%2Fpr_864-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-915/phansys/pr_864-v1
Pull-Request: https://github.com/git/git/pull/915

 t/t4018/php-abstract-method | 5 ++++-
 t/t4018/php-final-method    | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t4018/php-abstract-method b/t/t4018/php-abstract-method
index ce215df75a..14d77e6c15 100644
--- a/t/t4018/php-abstract-method
+++ b/t/t4018/php-abstract-method
@@ -1,7 +1,10 @@
 abstract class Klass
 {
-    abstract public function RIGHT(): ?string
+    abstract function RIGHT(): ?string
     {
+        // PHP doesn't allow abstract methods to have a body,
+        // but this is here just for diff ckeck purposes.
+
         return 'ChangeMe';
     }
 }
diff --git a/t/t4018/php-final-method b/t/t4018/php-final-method
index 537fb8ad9a..f7dd2dec17 100644
--- a/t/t4018/php-final-method
+++ b/t/t4018/php-final-method
@@ -1,6 +1,6 @@
 class Klass
 {
-    final public function RIGHT(): string
+    final function RIGHT(): string
     {
         return 'ChangeMe';
     }

base-commit: e31aba42fb12bdeb0f850829e008e1e3f43af500
-- 
gitgitgadget
