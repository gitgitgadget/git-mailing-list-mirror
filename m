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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C59C4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 03:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D010208C3
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 03:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qp6lVvSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgJGDiW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 23:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgJGDiW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 23:38:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE5EC061755
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 20:38:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e18so445143wrw.9
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 20:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oklf9iDwLKAZ5HkFn5tCh8cKsJ1REjKjnvsrUNcCuU8=;
        b=qp6lVvSG+8F9x26bBPTTJ+sg5C/kQqEGQg9juwB3xLAa6+EfV1s7xwVaFF7SHEbFds
         628DOFep0+YuHbA6lnKW3LoaLfKdIOidNlJHePyXLXA5KwcEDzN3nDWKxdDi5A0FgbHR
         RMzkyblqbPumfwwuKGl1uLwUt8Cvl1oGQzdZ8h6tRG3+wgMElWsJjUzwi4qjcI5Dt4jT
         3CAeihTZEKNfi1B7DE/dVIBgEQntlcs04fgx63ZVM1zt/x/36vvZw2KI2c/Uj6tKhyRK
         4QvmgpYuKYGwoyf1Yxrv7kmICNcZsCztNHPFZNqKMDqVuKr8FHdBd8zid6XFjSNRlDbT
         2RDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oklf9iDwLKAZ5HkFn5tCh8cKsJ1REjKjnvsrUNcCuU8=;
        b=IeMqY9ycZ4/CDK8j/BeOVDUXIuLP6VHhmbobc2nnfqbV3V0jXJP0fbOcHuwvLexHvB
         JwnHaa4MMVgmkRc/p9jw0EyF7gt4AG7LgVxfsaRCn8MxtJpIuMIZ1NZMTEsaJZhWYeO8
         ceWD+D0VSTvP5Wkgk4PUOhqh2yS32PV1hmIJGBVZ5EJLQGL9bOOJtRarhVxlfq3W4MvF
         /QgwqPk/RyjKtwl+lqgiIruY442IR89PFT3XGQboUv3thm1/eeM7IZGPiVtk1vaN4oh8
         pFXw0mJXaLtxd0xMj6HbtyKrr1D8kn+kuFIfT59hI28tzIVAhu58IkedG2QNjw78YmpN
         F0zg==
X-Gm-Message-State: AOAM531D9fqE57TEhJzU3wb5XqgUWxOyMrFhySLfsqvtL0vtIZpkHrEB
        TyBDDh7nimSSzb6uH3OBlSVeq+2V7mg=
X-Google-Smtp-Source: ABdhPJzmS3Z4ybBxgIpefQiYpdB4lJYR0eatQv+cFHnypgRcM1Vu4HJcipc+j5OcR2CaxDWAYo3oUQ==
X-Received: by 2002:a05:6000:104c:: with SMTP id c12mr980268wrx.133.1602041900727;
        Tue, 06 Oct 2020 20:38:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w11sm904790wrs.26.2020.10.06.20.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 20:38:19 -0700 (PDT)
Message-Id: <pull.864.v2.git.git.1602041898670.gitgitgadget@gmail.com>
In-Reply-To: <pull.864.git.git.1601980656554.gitgitgadget@gmail.com>
References: <pull.864.git.git.1601980656554.gitgitgadget@gmail.com>
From:   "Javier Spagnoletti via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Oct 2020 03:38:18 +0000
Subject: [PATCH v2] Improve diff pattern for PHP files
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

Add "final" and "abstract" to the list of function modifiers.

Signed-off-by: Javier Spagnoletti <phansys@gmail.com>
---
    Improve diff pattern for PHP files
    
    PHP allows some function modifiers that are not recognized in our
    current hunk header pattern
    
       final public function foo() { }
       abstract protected function bar() { }
    
    Add "final" and "abstract" to the list of function modifiers. See:
    
     * https://www.php.net/manual/en/language.oop5.abstract.php#example-213;
     * https://www.php.net/manual/en/language.oop5.final.php#language.oop5.traits.static.ex1
       .
    
    Signed-off-by: Javier Spagnoletti phansys@gmail.com [phansys@gmail.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-864%2Fphansys%2Fuserdiff_php-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-864/phansys/userdiff_php-v2
Pull-Request: https://github.com/git/git/pull/864

Range-diff vs v1:

 1:  aa65d43a40 ! 1:  4cb59950ff Improve diff pattern for PHP files
     @@ Metadata
       ## Commit message ##
          Improve diff pattern for PHP files
      
     -    Improve the output diff readability for php files by taking into account some missing function modifiers.
     +    PHP allows some function modifiers that are not recognized in our current hunk header pattern
     +
     +           final public function foo() { }
     +           abstract protected function bar() { }
     +
     +    Add "final" and "abstract" to the list of function modifiers.
      
          Signed-off-by: Javier Spagnoletti <phansys@gmail.com>
      
     + ## t/t4018/php-abstract-method (new) ##
     +@@
     ++abstract class Klass
     ++{
     ++    abstract public function RIGHT(): ?string
     ++    {
     ++        return 'ChangeMe';
     ++    }
     ++}
     +
     + ## t/t4018/php-final-method (new) ##
     +@@
     ++class Klass
     ++{
     ++    final public function RIGHT(): string
     ++    {
     ++        return 'ChangeMe';
     ++    }
     ++}
     +
       ## userdiff.c ##
      @@ userdiff.c: PATTERNS("perl",
       	 "|=~|!~"


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
