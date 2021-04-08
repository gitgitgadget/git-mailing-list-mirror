Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60681C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 09:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FB6761151
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 09:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhDHJQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 05:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhDHJQR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 05:16:17 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B637BC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 02:16:03 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so2809525pjh.1
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 02:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dAgoPK6a5aGKr37dySENAl2ZggrMxXnF1+QRYgDxNeU=;
        b=n5bP0980QZbQl796vKWrHyYoJqYfZfvIYc8JnrCwCYEN8lPDyTwyW4Xr/ecgWgpnGr
         nPopw7Eo5lJdadJotFdvF9mM8Xt2xV6RhzejxiIw24Ohmlbgx3hchnVaAdDwAMlphdhZ
         rgmDiBRDSeiClxKrFRfe5yk+wURQqlzBNsGpJysmcY9k28mquuDhHsSpmPOcBtciqg3j
         ELHA9UeOBj3AHayTjBsRELw8uA/n5EnI9JQBgVdlpwtWQHnOE9sQlF1JDqM8FhepVFV0
         Hkhiu5XqgAUhPZbtCojNSZRM9hjzHTt77arc4S3xuFqCp9wqxviO/RFPVhCIEZg3wjSD
         XTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dAgoPK6a5aGKr37dySENAl2ZggrMxXnF1+QRYgDxNeU=;
        b=IzVvexY50mwEiI2dbiijr6f0xpayIGdDN6H/LfesgPfNUkc5PW3HU8d1yNNrVHau+B
         2b44XKP/LxCexZ68ErGrF/FTIG8W6O4kNB3Pf4vcnCyOgdf6YuMOOp7unl3dODMexbJe
         5MADTua6XP8N+Y5imr4+Jt/zkk26R2/S8bjKIVOx06ygmYvDHES5IuDvCztF0lbPW5Rz
         0zAk0pyK/vfzF4qYFUrzqtzQwPHWKy7qDOAkDyu1FILb/O74QKBXkaYjekNpoTrMNIqx
         GAab/u1L8w3WXDjE1IJkBo57mL1UX3xRfgGVuAG645H8ESQdXKCVI6EZOhOf2+U7CuwW
         4eeQ==
X-Gm-Message-State: AOAM530JP4H/zFX9xcqPpaRhCBAiFIjnJIAarK7g4gyJr1SEehtgpcgT
        nfsYU0z7eqzpQdFGto/+BYpaXq/hWk6Yrw==
X-Google-Smtp-Source: ABdhPJzBrNAwQMpQ2r9ltJp5nvmmzRu4Eo7Nwu/hV5hroyH2hpFFJ/GlCM3frocA+qY9UCVnlpJYKw==
X-Received: by 2002:a17:90a:4498:: with SMTP id t24mr7430005pjg.78.1617873362918;
        Thu, 08 Apr 2021 02:16:02 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.107.157])
        by smtp.gmail.com with ESMTPSA id p5sm23323094pfq.56.2021.04.08.02.16.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Apr 2021 02:16:02 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>
Subject: [GSoC][PATCH v3 1/1] userdiff: add support for Scheme
Date:   Thu,  8 Apr 2021 14:44:43 +0530
Message-Id: <20210408091442.22740-2-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210403131612.97194-1-raykar.ath@gmail.com>
References: <20210403131612.97194-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a diff driver for Scheme-like languages which recognizes top level
and local `define` forms, whether it is a function definition, binding,
syntax definition or a user-defined `define-xyzzy` form.

Also supports R6RS `library` forms, `module` forms along with class and
struct declarations used in Racket (PLT Scheme).

Alternate "def" syntax such as those in Gerbil Scheme are also
supported, like defstruct, defsyntax and so on.

The rationale for picking `define` forms for the hunk headers is because
it is usually the only significant form for defining the structure of
the program, and it is a common pattern for schemers to have local
function definitions to hide their visibility, so it is not only the top
level `define`'s that are of interest. Schemers also extend the language
with macros to provide their own define forms (for example, something
like a `define-test-suite`) which is also captured in the hunk header.

Since it is common practice to extend syntax with variants of a form
like `module+`, `class*` etc, those have been supported as well.

The word regex is a best-effort attempt to conform to R7RS[1] valid
identifiers, symbols and numbers.

[1] https://small.r7rs.org/attachment/r7rs.pdf (section 2.1)

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 Documentation/gitattributes.txt    |  2 ++
 t/t4018-diff-funcname.sh           |  1 +
 t/t4018/scheme-class               |  7 +++++++
 t/t4018/scheme-def                 |  4 ++++
 t/t4018/scheme-def-variant         |  4 ++++
 t/t4018/scheme-define-slash-public |  7 +++++++
 t/t4018/scheme-define-syntax       |  8 ++++++++
 t/t4018/scheme-define-variant      |  4 ++++
 t/t4018/scheme-library             | 11 +++++++++++
 t/t4018/scheme-local-define        |  4 ++++
 t/t4018/scheme-module              |  6 ++++++
 t/t4018/scheme-top-level-define    |  4 ++++
 t/t4018/scheme-user-defined-define |  6 ++++++
 t/t4034-diff-words.sh              |  1 +
 t/t4034/scheme/expect              | 11 +++++++++++
 t/t4034/scheme/post                |  6 ++++++
 t/t4034/scheme/pre                 |  6 ++++++
 userdiff.c                         |  9 +++++++++
 18 files changed, 101 insertions(+)
 create mode 100644 t/t4018/scheme-class
 create mode 100644 t/t4018/scheme-def
 create mode 100644 t/t4018/scheme-def-variant
 create mode 100644 t/t4018/scheme-define-slash-public
 create mode 100644 t/t4018/scheme-define-syntax
 create mode 100644 t/t4018/scheme-define-variant
 create mode 100644 t/t4018/scheme-library
 create mode 100644 t/t4018/scheme-local-define
 create mode 100644 t/t4018/scheme-module
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
diff --git a/t/t4018/scheme-class b/t/t4018/scheme-class
new file mode 100644
index 0000000000..e5e07b43fb
--- /dev/null
+++ b/t/t4018/scheme-class
@@ -0,0 +1,7 @@
+(define book-class%
+  (class* () object% RIGHT
+    (field (pages 5))
+    (field (ChangeMe 5))
+    (define/public (letters)
+      (* pages 500))
+    (super-new)))
diff --git a/t/t4018/scheme-def b/t/t4018/scheme-def
new file mode 100644
index 0000000000..1e2673da96
--- /dev/null
+++ b/t/t4018/scheme-def
@@ -0,0 +1,4 @@
+(def (some-func x y z) RIGHT
+  (let ((a x)
+        (b y))
+        (ChangeMe a b)))
diff --git a/t/t4018/scheme-def-variant b/t/t4018/scheme-def-variant
new file mode 100644
index 0000000000..d857a61d64
--- /dev/null
+++ b/t/t4018/scheme-def-variant
@@ -0,0 +1,4 @@
+(defmethod {print point} RIGHT
+  (lambda (self)
+    (with ((point x y) self)
+      (printf "{ChangeMe x:~a y:~a}~n" x y))))
diff --git a/t/t4018/scheme-define-slash-public b/t/t4018/scheme-define-slash-public
new file mode 100644
index 0000000000..39a93a1600
--- /dev/null
+++ b/t/t4018/scheme-define-slash-public
@@ -0,0 +1,7 @@
+(define bar-class%
+  (class object%
+    (field (info 5))
+    (define/public (foo) RIGHT
+      (+ info 42)
+      (* info ChangeMe))
+    (super-new)))
diff --git a/t/t4018/scheme-define-syntax b/t/t4018/scheme-define-syntax
new file mode 100644
index 0000000000..7d5e99e0fc
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
+           (run-suite 'suite-name tests)))))))
diff --git a/t/t4018/scheme-define-variant b/t/t4018/scheme-define-variant
new file mode 100644
index 0000000000..911708854d
--- /dev/null
+++ b/t/t4018/scheme-define-variant
@@ -0,0 +1,4 @@
+(define* (some-func x y z) RIGHT
+  (let ((a x)
+        (b y))
+        (ChangeMe a b)))
diff --git a/t/t4018/scheme-library b/t/t4018/scheme-library
new file mode 100644
index 0000000000..82ea3df510
--- /dev/null
+++ b/t/t4018/scheme-library
@@ -0,0 +1,11 @@
+(library (my-helpers id-stuff) RIGHT
+  (export find-dup)
+  (import (ChangeMe))
+  (define (find-dup l)
+    (and (pair? l)
+         (let loop ((rest (cdr l)))
+           (cond
+            [(null? rest) (find-dup (cdr l))]
+            [(bound-identifier=? (car l) (car rest))
+             (car rest)]
+            [else (loop (cdr rest))])))))
diff --git a/t/t4018/scheme-local-define b/t/t4018/scheme-local-define
new file mode 100644
index 0000000000..bc6d8aebbe
--- /dev/null
+++ b/t/t4018/scheme-local-define
@@ -0,0 +1,4 @@
+(define (higher-order)
+  (define local-function RIGHT
+    (lambda (x)
+     (car "this is" "ChangeMe"))))
diff --git a/t/t4018/scheme-module b/t/t4018/scheme-module
new file mode 100644
index 0000000000..edfae0ebf7
--- /dev/null
+++ b/t/t4018/scheme-module
@@ -0,0 +1,6 @@
+(module A RIGHT
+  (export with-display-exception)
+  (extern (display-exception display-exception ChangeMe))
+  (def (with-display-exception thunk)
+    (with-catch (lambda (e) (display-exception e (current-error-port)) e)
+      thunk)))
diff --git a/t/t4018/scheme-top-level-define b/t/t4018/scheme-top-level-define
new file mode 100644
index 0000000000..624743c22b
--- /dev/null
+++ b/t/t4018/scheme-top-level-define
@@ -0,0 +1,4 @@
+(define (some-func x y z) RIGHT
+  (let ((a x)
+        (b y))
+        (ChangeMe a b)))
diff --git a/t/t4018/scheme-user-defined-define b/t/t4018/scheme-user-defined-define
new file mode 100644
index 0000000000..35fe7cc9bf
--- /dev/null
+++ b/t/t4018/scheme-user-defined-define
@@ -0,0 +1,6 @@
+(define-test-suite record\ case-tests RIGHT
+  (record-case-1 (lambda (fail)
+                   (let ((a (make-foo 1 2)))
+                     (record-case a
+                       ((bar x) (ChangeMe))
+                       ((foo a b) (+ a b)))))))
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
index 0000000000..496cd5de8c
--- /dev/null
+++ b/t/t4034/scheme/expect
@@ -0,0 +1,11 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 74b6605..63b6ac4 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,6 +1,6 @@<RESET>
+(define (<RED>myfunc a b<RESET><GREEN>my-func first second<RESET>)
+  ; This is a <RED>really<RESET><GREEN>(moderately)<RESET> cool function.
+  (<RED>this\place<RESET><GREEN>that\place<RESET> (+ 3 4))
+  (define <RED>some-text<RESET><GREEN>|a greeting|<RESET> "hello")
+  (let ((c (<RED>+ a b<RESET><GREEN>add1 first<RESET>)))
+    (format "one more than the total is %d" (<RED>add1<RESET><GREEN>+<RESET> c <GREEN>second<RESET>))))
diff --git a/t/t4034/scheme/post b/t/t4034/scheme/post
new file mode 100644
index 0000000000..63b6ac4f87
--- /dev/null
+++ b/t/t4034/scheme/post
@@ -0,0 +1,6 @@
+(define (my-func first second)
+  ; This is a (moderately) cool function.
+  (that\place (+ 3 4))
+  (define |a greeting| "hello")
+  (let ((c (add1 first)))
+    (format "one more than the total is %d" (+ c second))))
diff --git a/t/t4034/scheme/pre b/t/t4034/scheme/pre
new file mode 100644
index 0000000000..74b6605357
--- /dev/null
+++ b/t/t4034/scheme/pre
@@ -0,0 +1,6 @@
+(define (myfunc a b)
+  ; This is a really cool function.
+  (this\place (+ 3 4))
+  (define some-text "hello")
+  (let ((c (+ a b)))
+    (format "one more than the total is %d" (add1 c))))
diff --git a/userdiff.c b/userdiff.c
index 3f81a2261c..3897317aff 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -191,6 +191,15 @@ PATTERNS("rust",
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"
 	 "|[-+*\\/<>%&^|=!:]=|<<=?|>>=?|&&|\\|\\||->|=>|\\.{2}=|\\.{3}|::"),
+PATTERNS("scheme",
+	 "^[\t ]*(\\(((define|def(struct|syntax|class|method|rules|record|proto|alias)?)[-*/ \t]|(library|module|struct|class)[*+ \t]).*)$",
+	 /*
+	  * R7RS valid identifiers include any sequence enclosed
+	  * within vertical lines having no backslashes
+	  */
+	 "\\|([^\\\\]*)\\|"
+	 /* All other words should be delimited by spaces or parentheses */
+	 "|([^][)(}{[ \t])+"),
 PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
 	 "[={}\"]|[^={}\" \t]+"),
 PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
-- 
2.31.1

