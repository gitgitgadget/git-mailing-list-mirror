Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265CEC433DB
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 17:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A1F619BA
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 17:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhC0Rk4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 13:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhC0Rkh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 13:40:37 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7859BC0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 10:40:37 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y2so2430642plg.5
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 10:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GZfZmN7sV8qVqb16Z857vnnxLRoq/f8xdeCst0XD72g=;
        b=malfMfI7LVrXcjNRRIq1hZd4m1nZjLRMPwibRoMO+1oYkOS98zR0R/5piwNaTYlDIv
         3DBpQnkkgLoX33IqFJsKxjq7BLoa5ELzyJcVJiFGS9zCOB0/Rv2eVlyPSd2qlDvk+QU4
         yHHGOEXV2ODJQldW6jXVstf1taeQdepqS5C7jV/1efYgmaIo0qPAUGzZOw8bUKpwTj1R
         o+tvrcAedPBDyX5yXMnRFO/mMoYq7pU4WF1yyXZRhvC1a0I/wpbKiX9mGnPrsg/9l41d
         bjQMJrQb+rch4iArvqADBQz+8H3SyKIKQFYfHerWONWXHBUNVgATEkPIwtAopnoUUFjz
         PMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GZfZmN7sV8qVqb16Z857vnnxLRoq/f8xdeCst0XD72g=;
        b=Iu97FB0efFrzxyfO69ZG7KgQmRuOj1PzFLdIC+n81S8hviXeuBQ8goTORQTW9Lhf8t
         jlqVyNpa30N9BuAhp7nUETBnEMYq8uS3SVLHB3B0VFTle2dkF08XJ60MXGxclgYe1dqO
         scXLHWh25Fq4ZmAdrPODmsd6K7tbG3ZjbeptFruU1bWp28isLNRm7vpfIme9GNbjkhUj
         sbX/hk57YhyHNI3uzbZ3YScJLCKv1fhAVEmbFiuaII/M8JiJcgp/RmHp5OmZsPa0SZ1C
         Xu9nra3l7SfaFjNXzqclpDDtxpAefbx26SEIC7KtI4dUd+wArXBnZr6ZU3E+rZpwggpw
         ooow==
X-Gm-Message-State: AOAM532I0sRJJWzaRmgg6YEMIGtOFMEf1+F+DHhMMZKQh9lWh1S4rqQ0
        kRtwOaaTvlczGRHRs/856pFoN5WKpJUB2g==
X-Google-Smtp-Source: ABdhPJwWTZCKuNcGxS9VkNEZXiYOfb+f8R2DIz1/QL/xNgrLudkxMxSvhkiOGrKI2ZgtEu3ftyZ4uA==
X-Received: by 2002:a17:90a:6be4:: with SMTP id w91mr20345088pjj.68.1616866835392;
        Sat, 27 Mar 2021 10:40:35 -0700 (PDT)
Received: from Atharvas-Air.Dlink ([119.82.121.20])
        by smtp.gmail.com with ESMTPSA id s28sm13116782pfd.155.2021.03.27.10.40.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Mar 2021 10:40:35 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>
Subject: [GSOC][PATCH] userdiff: add support for Scheme
Date:   Sat, 27 Mar 2021 23:09:38 +0530
Message-Id: <20210327173938.59391-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a diff driver for Scheme (R5RS and R6RS) which
recognizes top level and local `define` forms,
whether it is a function definition, binding, syntax
definition or a user-defined `define-xyzzy` form.

The rationale for picking `define` forms for the
hunk headers is because it is usually the only
significant form for defining the structure of the
program, and it is a common pattern for schemers to
have local function definitions to hide their
visibility, so it is not only the top level
`define`'s that are of interest. Schemers also
extend the language with macros to provide their
own define forms (for example, something like a
`define-test-suite`) which is also captured in the
hunk header.

The word regex is a best-effort attempt to conform
to R6RS[1] valid identifiers, symbols and numbers.

[1] http://www.r6rs.org/final/html/r6rs/r6rs-Z-H-7.html#node_chap_4

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---

Hi, first-time contributor here, I wanted to have a go at this as
a microproject.

A few things I had to consider:
 - Going through the mailing list, there have already been two other
   patches that are for lispy languages that have taken slightly
   different approaches: Elisp[1] and Clojure[2]. Would it make any
   sense to have a single userdiff driver for lisp that just captures
   all top level forms in the hunk? I personally felt it's better to
   differentiate the drivers for each language, as they have different
   constructs.

 - It was hard to decide exactly which forms should appear on the hunk
   headers. Having programmed in a Scheme before, I went with the forms I
   would have liked to see when looking at git diffs, which would be the
   nearest `define` along with `define-syntax` and other define forms that
   are created as user-defined macros. I am willing to ask around in
   certain active scheme communities for some kind of consensus, but there
   is no single large consolidated group of schemers (the closest is
   probably comp.lang.scheme?).

 - By best-effort attempt at the wordregex, I mean that it is a little
   more permissive than it has to be, as it accepts a few words that are
   technically invalid in Scheme.
   Making it handle all cases like numbers and identifiers with separate
   regexen would be greatly complicated (Eg: #x#e10.2f3 is a valid number
   but #x#f10.2e3 is not; 10t1 is a valid identifier, but 10s1 is a number
   -- my wordregex just clubs all of these into a generic 'word match' which
   trades of granularity for simplicity, and it usually does the right thing).

[1] http://public-inbox.org/git/20210213192447.6114-1-git@adamspiers.org/
[2] http://public-inbox.org/git/pull.902.git.1615667191368.gitgitgadget@gmail.com/

 Documentation/gitattributes.txt    | 2 ++
 t/t4018-diff-funcname.sh           | 1 +
 t/t4018/scheme-define-syntax       | 8 ++++++++
 t/t4018/scheme-local-define        | 4 ++++
 t/t4018/scheme-top-level-define    | 4 ++++
 t/t4018/scheme-user-defined-define | 6 ++++++
 t/t4034-diff-words.sh              | 1 +
 t/t4034/scheme/expect              | 9 +++++++++
 t/t4034/scheme/post                | 4 ++++
 t/t4034/scheme/pre                 | 4 ++++
 userdiff.c                         | 8 ++++++++
 11 files changed, 51 insertions(+)
 create mode 100644 t/t4018/scheme-define-syntax
 create mode 100644 t/t4018/scheme-local-define
 create mode 100644 t/t4018/scheme-top-level-define
 create mode 100644 t/t4018/scheme-user-defined-define
 create mode 100644 t/t4034/scheme/expect
 create mode 100644 t/t4034/scheme/post
 create mode 100644 t/t4034/scheme/pre

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 0a60472bb5..cfcfa800c2 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -845,6 +845,8 @@ patterns are available:
 
 - `rust` suitable for source code in the Rust language.
 
+- `scheme` suitable for source code in the Scheme language.
+
 - `tex` suitable for source code for LaTeX documents.
 
 
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 9675bc17db..823ea96acb 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -48,6 +48,7 @@ diffpatterns="
 	python
 	ruby
 	rust
+	scheme
 	tex
 	custom1
 	custom2
diff --git a/t/t4018/scheme-define-syntax b/t/t4018/scheme-define-syntax
new file mode 100644
index 0000000000..603b99cea4
--- /dev/null
+++ b/t/t4018/scheme-define-syntax
@@ -0,0 +1,8 @@
+(define-syntax define-test-suite RIGHT
+  (syntax-rules ()
+    ((_ suite-name (name test) ChangeMe ...)
+     (define suite-name
+       (let ((tests
+              `((name . ,test) ...)))
+         (lambda ()
+           (ChangeMe 'suite-name tests)))))))
\ No newline at end of file
diff --git a/t/t4018/scheme-local-define b/t/t4018/scheme-local-define
new file mode 100644
index 0000000000..90e75dcce8
--- /dev/null
+++ b/t/t4018/scheme-local-define
@@ -0,0 +1,4 @@
+(define (higher-order)
+  (define local-function RIGHT
+    (lambda (x)
+     (car "this is" "ChangeMe"))))
\ No newline at end of file
diff --git a/t/t4018/scheme-top-level-define b/t/t4018/scheme-top-level-define
new file mode 100644
index 0000000000..03acdc628d
--- /dev/null
+++ b/t/t4018/scheme-top-level-define
@@ -0,0 +1,4 @@
+(define (some-func x y z) RIGHT
+  (let ((a x)
+        (b y))
+        (ChangeMe a b)))
\ No newline at end of file
diff --git a/t/t4018/scheme-user-defined-define b/t/t4018/scheme-user-defined-define
new file mode 100644
index 0000000000..401093bac3
--- /dev/null
+++ b/t/t4018/scheme-user-defined-define
@@ -0,0 +1,6 @@
+(define-test-suite record-case-tests RIGHT
+  (record-case-1 (lambda (fail)
+                   (let ((a (make-foo 1 2)))
+                     (record-case a
+                       ((bar x) (ChangeMe))
+                       ((foo a b) (+ a b)))))))
\ No newline at end of file
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 56f1e62a97..ee7721ab91 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -325,6 +325,7 @@ test_language_driver perl
 test_language_driver php
 test_language_driver python
 test_language_driver ruby
+test_language_driver scheme
 test_language_driver tex
 
 test_expect_success 'word-diff with diff.sbe' '
diff --git a/t/t4034/scheme/expect b/t/t4034/scheme/expect
new file mode 100644
index 0000000000..eed21e803c
--- /dev/null
+++ b/t/t4034/scheme/expect
@@ -0,0 +1,9 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 6a5efba..7c4a6b4 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,4 +1,4 @@<RESET>
+(define (<RED>myfunc a b<RESET><GREEN>my-func first second<RESET>)
+  ; This is a <RED>really<RESET><GREEN>(moderately)<RESET> cool function.
+  (let ((c (<RED>+ a b<RESET><GREEN>add1 first<RESET>)))
+    (format "one more than the total is %d" (<RED>add1<RESET><GREEN>+<RESET> c <GREEN>second<RESET>))))
diff --git a/t/t4034/scheme/post b/t/t4034/scheme/post
new file mode 100644
index 0000000000..7c4a6b4f3d
--- /dev/null
+++ b/t/t4034/scheme/post
@@ -0,0 +1,4 @@
+(define (my-func first second)
+  ; This is a (moderately) cool function.
+  (let ((c (add1 first)))
+    (format "one more than the total is %d" (+ c second))))
\ No newline at end of file
diff --git a/t/t4034/scheme/pre b/t/t4034/scheme/pre
new file mode 100644
index 0000000000..6a5efbae61
--- /dev/null
+++ b/t/t4034/scheme/pre
@@ -0,0 +1,4 @@
+(define (myfunc a b)
+  ; This is a really cool function.
+  (let ((c (+ a b)))
+    (format "one more than the total is %d" (add1 c))))
\ No newline at end of file
diff --git a/userdiff.c b/userdiff.c
index 3f81a2261c..c51a8c98ba 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -191,6 +191,14 @@ PATTERNS("rust",
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"
 	 "|[-+*\\/<>%&^|=!:]=|<<=?|>>=?|&&|\\|\\||->|=>|\\.{2}=|\\.{3}|::"),
+PATTERNS("scheme",
+         "^[\t ]*(\\(define-?.*)$",
+         /* 
+          * Scheme allows symbol names to have any character,
+          * as long as it is not a form of a parenthesis.
+          * The spaces must be escaped.
+          */
+         "(\\.|[^][)(\\}\\{ ])+"),
 PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
 	 "[={}\"]|[^={}\" \t]+"),
 PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
-- 
2.31.0

