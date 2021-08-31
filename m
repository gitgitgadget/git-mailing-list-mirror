Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11D3C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 06:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A902560462
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 06:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239603AbhHaGC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 02:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238470AbhHaGCX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 02:02:23 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34017C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 23:01:28 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o39-20020a05600c512700b002e74638b567so1503861wms.2
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 23:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=fLdUWFIUqcAzNRZnomLFkqun7sZ6/IHEQwAB/zmYz5I=;
        b=nGrlCkjgJoeEHs0gYelEzCVvnkQCM7UpH1QqPERxfRMwW/jHAV7KOdJqwSG+uprrv+
         /IgQMbGs/T0PRuszZ8XNqljTH7H7YStTaqqtrhVA7ASDR42y1Gbm4+FFsegMpZ0/UdpU
         KWDnEf96p6LCsOengjA46ygrQ+eHCdpreEVlRUwna90ZDJsZjoWprQD8zcE9xXarHYPx
         ldyCWwK3ms1d9yV3HlHjhbB72Yo991GhXqVBLMwLzJjhdFX0hAPTAG8v+6Qd0FJASeGB
         ytacI+E9HZwDQIOiIEYF1wL8iy/DLd/Rmk0CmRmQSSjrze7J7jhfPCpViVQiNFTp+H5Q
         0RVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fLdUWFIUqcAzNRZnomLFkqun7sZ6/IHEQwAB/zmYz5I=;
        b=Mu5gQJhq7MJR9vx3MZG/vvfs6YjNMZzifBxkQb/oGAJKIB86d/tLSrP+bi6+usgOVA
         5jHrudA6RGl7PSW2KZV1LFxCZuUC41fU71r/ZtPT3Bh1njiOurK6mD+o9Sg8Yd3Tvx6Q
         lspEGPIj7RKn6v4Y/q5JEtVH+FC1J6cyWoGV00Mtyc8tn7esV5aqOCK7Ex12OvUEBfYi
         OJz6ZGxAja2hmbe7zX1HsXK2dH9Ycj0qgFuEhSt2YClyJAdvigFbkAhQEBCySIP/lD3O
         +J6gu1iX44wUA6khAGqytHvi5f07BiLWZv1o6JZmvd1GkMmDJbq/+xt4MKLnXJ9FZ/JY
         v+UQ==
X-Gm-Message-State: AOAM530sDC3YPEsFwaeV4DfhbWBuAuEzy0qw54cmbDD6Fxww80tdV5qV
        DDHQxei/tbG+30RtOqdqUFD3+mJW98A=
X-Google-Smtp-Source: ABdhPJwt7iVBJNcOFLLjHsp58plkwI/Y17Ii0TBG2qxU6f9e/QtmzDxxMQn5Et/44mdU+p5Z4Fi/eA==
X-Received: by 2002:a1c:f214:: with SMTP id s20mr2344486wmc.14.1630389686891;
        Mon, 30 Aug 2021 23:01:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a129sm1611270wme.14.2021.08.30.23.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 23:01:26 -0700 (PDT)
Message-Id: <pull.1082.git.git.1630389685997.gitgitgadget@gmail.com>
From:   "USAMI Kenta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Aug 2021 06:01:25 +0000
Subject: [PATCH] userdiff: support enum keyword in PHP hunk header
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     USAMI Kenta <tadsan@zonu.me>, USAMI Kenta <tadsan@zonu.me>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: USAMI Kenta <tadsan@zonu.me>

"enum" keyword will be introduced in PHP 8.1.
https://wiki.php.net/rfc/enumerations

Signed-off-by: USAMI Kenta <tadsan@zonu.me>
---
    userdiff: support enum keyword in PHP hunk header
    
    "enum" keyword will be introduced in PHP 8.1.
    https://wiki.php.net/rfc/enumerations

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1082%2Fzonuexe%2Ffeature%2Fuserdiff-php-enum-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1082/zonuexe/feature/userdiff-php-enum-v1
Pull-Request: https://github.com/git/git/pull/1082

 t/t4018/php-enum | 4 ++++
 userdiff.c       | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)
 create mode 100644 t/t4018/php-enum

diff --git a/t/t4018/php-enum b/t/t4018/php-enum
new file mode 100644
index 00000000000..91a69c1a2bc
--- /dev/null
+++ b/t/t4018/php-enum
@@ -0,0 +1,4 @@
+enum RIGHT: string
+{
+    case Foo = 'ChangeMe';
+}
diff --git a/userdiff.c b/userdiff.c
index d9b2ba752f0..d9ec484d535 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -214,7 +214,7 @@ PATTERNS("perl",
 	 "|<<|<>|<=>|>>"),
 PATTERNS("php",
 	 "^[\t ]*(((public|protected|private|static|abstract|final)[\t ]+)*function.*)$\n"
-	 "^[\t ]*((((final|abstract)[\t ]+)?class|interface|trait).*)$",
+	 "^[\t ]*((((final|abstract)[\t ]+)?class|enum|interface|trait).*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+"

base-commit: c4203212e360b25a1c69467b5a8437d45a373cac
-- 
gitgitgadget
