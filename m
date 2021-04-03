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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0488BC433ED
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 13:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9AA61352
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 13:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhDCNRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 09:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhDCNRh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 09:17:37 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A7DC0613E6
        for <git@vger.kernel.org>; Sat,  3 Apr 2021 06:17:32 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s21so3911748pjq.1
        for <git@vger.kernel.org>; Sat, 03 Apr 2021 06:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aYB/l4fzmNxc2PkZMYFvDxN1DoiYsCIy5kFl+4ShFW4=;
        b=dwks30PNaXJg4wvIs5v7s6ESjRrt3l6QTRb3G6/kA3Cqgk4B8jvOHc0mXElmOEf5A2
         DK5pxnPr0bfXvqm8fKip/DdtnfmFpQumJhGCbz11E581AWL2bC2fHmmIUYGCcamgRPmx
         CME+xlnWzphyHYyI3u9kmJCAPkrjAUXLduY8mBr4qZMiSOJMoDRnviQTfwTrS8H7ULxd
         HJC7ONkoMW2jqRD8w8zBDTZjtjY1avnlsuPZ1q1U1EQF41W77Kv+2oBqGBe70QTDFKqU
         ety5gbqF/f8v26FbollRS/PZ/yzjm6PBBnq90a8VzGseH4ERemV5HMaAQYNaIMKw1HQR
         16lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aYB/l4fzmNxc2PkZMYFvDxN1DoiYsCIy5kFl+4ShFW4=;
        b=oYxWaGYcrDlVr8r9RHMYMgyQYbMB7/TPnbMs0djZQr8A9cfc9d1z+cRARJdDY0H7An
         cd5H3HH1Kk599XpMCtL4erTWST/nxDetJBqdclmz4QHoBQJwO/Cn9fAZh9OftcuLEiV/
         ppM6kWc6exz5uT5ASBlOdCjT4RAi8LVfa9aPbLCF9oTzBS+CwQ58CQNqKgllOJ3f7uTw
         7vC73zJ/5HZzV8xPnz7zZU3lwD0VnCAR2fN5TVvZSB4mU6REqJHbjlkGuEANmAfw1Nx/
         wyxr6gDiXXg47AA7Y8VIyxpMfPaP7q/fA8Q+pcSi/JDolDKNI3uO8aHXdcmOzsVDwi0c
         2i/Q==
X-Gm-Message-State: AOAM531Bv7aBB/q2HGSAmZaJ1AyTInlyXM5sExJUFEDWIikSV9I94c1h
        SS9m/XKWUf+xr4nlFMNgLPnuYtaoR/buJA==
X-Google-Smtp-Source: ABdhPJzZDSUKkGYZCGIdtQlWy2AJZ5Py8yl6//JGiaPIEcg7wH0w2Zv+bWs4r3DOChtZrE6AmPNwPQ==
X-Received: by 2002:a17:902:e98c:b029:e5:defc:ccf8 with SMTP id f12-20020a170902e98cb02900e5defcccf8mr16674080plb.20.1617455852206;
        Sat, 03 Apr 2021 06:17:32 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.20])
        by smtp.gmail.com with ESMTPSA id j21sm10059939pfc.114.2021.04.03.06.17.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Apr 2021 06:17:31 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>
Subject: [GSoC][PATCH v2 1/1] userdiff: add support for scheme
Date:   Sat,  3 Apr 2021 18:46:12 +0530
Message-Id: <20210403131612.97194-2-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210403131612.97194-1-raykar.ath@gmail.com>
References: <20210327173938.59391-1-raykar.ath@gmail.com>
 <20210403131612.97194-1-raykar.ath@gmail.com>
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

The word regex is a best-effort attempt to conform to R6RS[1] valid
identifiers, symbols and numbers.

[1] http://www.r6rs.org/final/html/r6rs/r6rs-Z-H-7.html#node_chap_4

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
 t/t4034/scheme/expect              | 10 ++++++++++
 t/t4034/scheme/post                |  5 +++++
 t/t4034/scheme/pre                 |  5 +++++
 userdiff.c                         |  4 ++++
 18 files changed, 93 insertions(+)
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
index 0000000000..d9bb82225b
--- /dev/null
+++ b/t/t4034/scheme/expect
@@ -0,0 +1,10 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index cb56df5..09d9506 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,5 +1,5 @@<RESET>
+(define (<RED>myfunc a b<RESET><GREEN>my-func first second<RESET>)
+  ; This is a <RED>really<RESET><GREEN>(moderately)<RESET> cool function.
+  (<RED>this\place<RESET><GREEN>that\place<RESET> (+ 3 4))
+  (let ((c (<RED>+ a b<RESET><GREEN>add1 first<RESET>)))
+    (format "one more than the total is %d" (<RED>add1<RESET><GREEN>+<RESET> c <GREEN>second<RESET>))))
diff --git a/t/t4034/scheme/post b/t/t4034/scheme/post
new file mode 100644
index 0000000000..06bf0b34f9
--- /dev/null
+++ b/t/t4034/scheme/post
@@ -0,0 +1,5 @@
+(define (my-func first second)
+  ; This is a (moderately) cool function.
+  (that\place (+ 3 4))
+  (let ((c (add1 first)))
+    (format "one more than the total is %d" (+ c second))))
diff --git a/t/t4034/scheme/pre b/t/t4034/scheme/pre
new file mode 100644
index 0000000000..270a2d0cc5
--- /dev/null
+++ b/t/t4034/scheme/pre
@@ -0,0 +1,5 @@
+(define (myfunc a b)
+  ; This is a really cool function.
+  (this\place (+ 3 4))
+  (let ((c (+ a b)))
+    (format "one more than the total is %d" (add1 c))))
diff --git a/userdiff.c b/userdiff.c
index 3f81a2261c..ac1999bbc5 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -191,6 +191,10 @@ PATTERNS("rust",
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"
 	 "|[-+*\\/<>%&^|=!:]=|<<=?|>>=?|&&|\\|\\||->|=>|\\.{2}=|\\.{3}|::"),
+PATTERNS("scheme",
+	 "^[\t ]*(\\(((define|def(struct|syntax|class|method|rules|record|proto|alias)?)[-*/ \t]|(library|module|struct|class)[*+ \t]).*)$",
+	 /* All words should be delimited by spaces or parentheses */
+	 "([^][)(}{[ \t])+"),
 PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
 	 "[={}\"]|[^={}\" \t]+"),
 PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
-- 
2.31.1

