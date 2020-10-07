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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B552CC4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 18:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ECE921707
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 18:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tY+roTfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgJGSH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 14:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgJGSH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 14:07:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07B9C061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 11:07:55 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e17so3288442wru.12
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 11:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PkURvJ+OXakhaMBj28RwNBlwxjYwGZw5di6CFjkeNns=;
        b=tY+roTfNGy5SvSP86I/pPqtcPgMUAy+lJ0ZovHcQtdvCpL8+zZoLFShhX0i6USHFqp
         AQS3yGWxV8dEuPjpbY5EfpkVz8w2FAdnvta7EmQkS7fh0wMfGS9V7JP9bnSeaLmOqNeT
         DWlF4fSG/wkHFVOkWj/JBTg9G29rnWjTxEwxAtvyakNSqSUmY9sBeyxImh47mD6TwUHd
         gIY496HUBmgWw5MqcZ1Tu4FRi7yKiZnHFolZeezin9on8FsZcIpTs1thOOW0xD4c/Fzd
         lLDy0xqvARNYxBMpJS0t15vHtasaeQe0mitAQ7GMpmjzrx4RyVsN74e4I6xl1jcXUTNA
         x97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PkURvJ+OXakhaMBj28RwNBlwxjYwGZw5di6CFjkeNns=;
        b=a5mIco4CmF3MQGFYsKz9yYMuOeo86aS+XzK2FrALgU+2bdh/9eOBLVnTl9/t/ZFOEF
         EPUe3/sbyMmZcDYumM/vFF4mmJOK2GsTseNDJ/46EftMtgQCtLpj2EX/iy4FDobm1zrJ
         d2dinlV9WdpmjQlt7Fm0gJUVcRDbeBcz3TGiUq4stLX7LuGtEhkBeRX97NAcYH5rdF5d
         US4kjzWFq6lDo4rJ4bXwpacJFE6c/iqp1Z8BUgy4sG2NWTNmx+I1wDXNjwB7HsLnhZ0a
         J+QBqzJqxEvE8k/OvFE7qspTvIjUsGOIHyEZQOZEG9uCG1MG7oBvDSDGm2+Kg5itVMxN
         yqUw==
X-Gm-Message-State: AOAM532/mvLLayd+mTvR5W1BaoOPmkgcnTW80BSWS7dYKZ1T/v0rnW5e
        zqY3mo0TVNaTJzcZ+hci4uJVV1ssKjY=
X-Google-Smtp-Source: ABdhPJyPoX9IMGh55D9/5bh9nfOJNDEBKMUWPXtzJOGGHrcMCOFvgy4iliK40aGkLL09aEjs0EJ+yA==
X-Received: by 2002:adf:9d81:: with SMTP id p1mr4707273wre.13.1602094074056;
        Wed, 07 Oct 2020 11:07:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h1sm3546502wrx.33.2020.10.07.11.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 11:07:51 -0700 (PDT)
Message-Id: <pull.864.v3.git.git.1602094069865.gitgitgadget@gmail.com>
In-Reply-To: <pull.864.v2.git.git.1602041898670.gitgitgadget@gmail.com>
References: <pull.864.v2.git.git.1602041898670.gitgitgadget@gmail.com>
From:   "Javier Spagnoletti via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Oct 2020 18:07:49 +0000
Subject: [PATCH v3] userdiff: php: Add "final" and "abstract" to the list of
 function modifiers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Javier Spagnoletti <phansys@gmail.com>,
        Javier Spagnoletti <phansys@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Javier Spagnoletti <phansys@gmail.com>

PHP allows some function modifiers that are not recognized in our current hunk header pattern

       final public function foo() { }
       abstract protected function bar() { }

Some context about the PHP semantics:

In PHP a class can be declared as abstract and final, while methods can be declared as final,
static and abstract, along with its visibility (public, protected and private).
Regarding classes, an abstract class can not be declared as final.
For the methods, from a strict syntax perspective, the order of the modifiers is irrelevant.

For more information, see:

* https://www.php.net/manual/en/language.oop5.abstract.php#example-213;
* https://www.php.net/manual/en/language.oop5.final.php#language.oop5.traits.static.ex1.

This commit adds "final" and "abstract" to the list of function modifiers.

Signed-off-by: Javier Spagnoletti <phansys@gmail.com>
---
    userdiff: php: Add "final" and "abstract" to the list of function
    modifiers
    
    PHP allows some function modifiers that are not recognized in our
    current hunk header pattern
    
       final public function foo() { }
       abstract protected function bar() { }
    
    Some context about the PHP semantics:
    
    In PHP a class can be declared as abstract and final, while methods can
    be declared as final, static and abstract, along with its visibility
    (public, protected and private). Regarding classes, an abstract class
    can not be declared as final. For the methods, from a strict syntax
    perspective, the order of the modifiers is irrelevant.
    
    For more information, see:
    
     * https://www.php.net/manual/en/language.oop5.abstract.php#example-213;
     * https://www.php.net/manual/en/language.oop5.final.php#language.oop5.traits.static.ex1
       .
    
    This commit adds "final" and "abstract" to the list of function
    modifiers.
    
    Signed-off-by: Javier Spagnoletti phansys@gmail.com [phansys@gmail.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-864%2Fphansys%2Fuserdiff_php-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-864/phansys/userdiff_php-v3
Pull-Request: https://github.com/git/git/pull/864

Range-diff vs v2:

 1:  4cb59950ff ! 1:  43acd70aba Improve diff pattern for PHP files
     @@ Metadata
      Author: Javier Spagnoletti <phansys@gmail.com>
      
       ## Commit message ##
     -    Improve diff pattern for PHP files
     +    userdiff: php: Add "final" and "abstract" to the list of function modifiers
      
          PHP allows some function modifiers that are not recognized in our current hunk header pattern
      
                 final public function foo() { }
                 abstract protected function bar() { }
      
     -    Add "final" and "abstract" to the list of function modifiers.
     +    Some context about the PHP semantics:
     +
     +    In PHP a class can be declared as abstract and final, while methods can be declared as final,
     +    static and abstract, along with its visibility (public, protected and private).
     +    Regarding classes, an abstract class can not be declared as final.
     +    For the methods, from a strict syntax perspective, the order of the modifiers is irrelevant.
     +
     +    For more information, see:
     +
     +    * https://www.php.net/manual/en/language.oop5.abstract.php#example-213;
     +    * https://www.php.net/manual/en/language.oop5.final.php#language.oop5.traits.static.ex1.
     +
     +    This commit adds "final" and "abstract" to the list of function modifiers.
      
          Signed-off-by: Javier Spagnoletti <phansys@gmail.com>
      


 t/t4018/php-abstract-method | 7 +++++++
 t/t4018/php-final-method    | 7 +++++++
 userdiff.c                  | 2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)
 create mode 100644 t/t4018/php-abstract-method
 create mode 100644 t/t4018/php-final-method

diff --git a/t/t4018/php-abstract-method b/t/t4018/php-abstract-method
new file mode 100644
index 0000000000..ce215df75a
--- /dev/null
+++ b/t/t4018/php-abstract-method
@@ -0,0 +1,7 @@
+abstract class Klass
+{
+    abstract public function RIGHT(): ?string
+    {
+        return 'ChangeMe';
+    }
+}
diff --git a/t/t4018/php-final-method b/t/t4018/php-final-method
new file mode 100644
index 0000000000..537fb8ad9a
--- /dev/null
+++ b/t/t4018/php-final-method
@@ -0,0 +1,7 @@
+class Klass
+{
+    final public function RIGHT(): string
+    {
+        return 'ChangeMe';
+    }
+}
diff --git a/userdiff.c b/userdiff.c
index 1df884ef0b..a99d84a7e3 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -143,7 +143,7 @@ PATTERNS("perl",
 	 "|=~|!~"
 	 "|<<|<>|<=>|>>"),
 PATTERNS("php",
-	 "^[\t ]*(((public|protected|private|static)[\t ]+)*function.*)$\n"
+	 "^[\t ]*(((public|protected|private|static|abstract|final)[\t ]+)*function.*)$\n"
 	 "^[\t ]*((((final|abstract)[\t ]+)?class|interface|trait).*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"

base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
-- 
gitgitgadget
