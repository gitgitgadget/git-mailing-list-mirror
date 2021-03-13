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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F269CC433DB
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 20:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C120364DF3
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 20:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbhCMU1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 15:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbhCMU0e (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 15:26:34 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B11C061574
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 12:26:33 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so17844385wml.2
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 12:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=clYpGUjj+W9ExmyIaaMSjd2i/MeH6VtDHsdZ5Kjp8f0=;
        b=ltZeoVfF4glTnLwWtjjUH6tQRmkhN4YpmTqf1pUIpmdsAWqNUbiPFrAT7QDx1yRTD+
         EBWj0IM7IgtpuMEGBwEgO0JTSHxovgmgsZRW1ZO5yse6pQHKQar+KYxCMENNMaG5sVPQ
         DG3VvVRvsANqg6HKdlHT190mYppZfug/307hnmQzUYNCBtKCge8uD5ljke2NAYvFVStX
         eRNZrYmK4yGErlkzeQZ5b74zvxR7/2XEoEHF3EUzZLSq0nZfxG3acpV1F/MHMyemzjDB
         IohmAXuKzYCKgoalGICheBJrcLHjCwmS8nrSt0orupyVmY2bEUFFUTpgin92c8ScpTAp
         unoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=clYpGUjj+W9ExmyIaaMSjd2i/MeH6VtDHsdZ5Kjp8f0=;
        b=c/dLis+qJBmQS9304CCkBBF7jnxhnKlwDSvx1heiohrnhIPTUIIfvY024puc68FZYp
         w5ZPzgH1d2e9AbP5YniEZTvhtUqslW5/0Us88DMW4kvLUZ+/2UUfxSJ3mvAzcodfj6cO
         x9QmtiilWv+3G7w0RXFOuig0k6/djrPgD0pfZOon3xrShKWd1Zsf346+g3Ik4LvkMdQd
         gDI6DDqknc3dWLfz1AxXM2fxQ4xdhrDFDwqmWafH2MSfaAo939w64bcAcdfXJQqWSdfm
         XzcMdoV6wbSmymo3ygj8DiR985ehrCvqFpT2GpKKCRMfcU8e2ooec75U4PkfddEPbYbd
         zlCQ==
X-Gm-Message-State: AOAM530Ra3SrmoI5qOuSbuKBu/v9fkLOoNh7q+FmbbtK8LH/65OszOBM
        nBCyh1teyYLDUaMg/I8WE6TzcfhpCKc=
X-Google-Smtp-Source: ABdhPJxGfA52v/SK6HBs6UgKzBIZlqQl63M4shEDHxdg4L4NwNvJWEwmseEAaZShCUCxbS7yLVS0fA==
X-Received: by 2002:a1c:bd55:: with SMTP id n82mr18765865wmf.3.1615667192547;
        Sat, 13 Mar 2021 12:26:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t188sm8220656wma.25.2021.03.13.12.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 12:26:32 -0800 (PST)
Message-Id: <pull.902.git.1615667191368.gitgitgadget@gmail.com>
From:   "Nazarii Bardiuk via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Mar 2021 20:26:30 +0000
Subject: [PATCH] userdiff: support Clojure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nazarii Bardiuk <nazarii@bardiuk.com>,
        Nazarii Bardiuk <nazarii@bardiuk.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nazarii Bardiuk <nazarii@bardiuk.com>

Add support for Clojure[1]. Include test cases for the xfuncname pattern
(t4018) and update documentation.

The xfuncname pattern matches any top level form except a line comment.

The word_regex has been constructed based on Reader documentation[2].

[1]: https://clojure.org
[2]: https://clojure.org/reference/reader

Signed-off-by: Nazarii Bardiuk <nazarii@bardiuk.com>
---
    userdiff: support Clojure
    
    Add support for Clojure1 [https://clojure.org]. Include test cases for
    the xfuncname pattern (t4018) and update documentation.
    
    The xfuncname pattern matches any top level form except a line comment.
    
    The word_regex has been constructed based on Reader documentation2
    [https://clojure.org/reference/reader].
    
    Signed-off-by: Nazarii Bardiuk nazarii@bardiuk.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-902%2Fnbardiuk%2Fuserdiff-clojure-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-902/nbardiuk/userdiff-clojure-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/902

 Documentation/gitattributes.txt |  2 ++
 t/t4018-diff-funcname.sh        |  1 +
 t/t4018/clojure-comment         |  8 ++++++++
 t/t4018/clojure-function        |  6 ++++++
 t/t4018/clojure-ns              | 10 ++++++++++
 t/t4018/clojure-reader-comment  |  5 +++++
 userdiff.c                      | 11 +++++++++++
 7 files changed, 43 insertions(+)
 create mode 100644 t/t4018/clojure-comment
 create mode 100644 t/t4018/clojure-function
 create mode 100644 t/t4018/clojure-ns
 create mode 100644 t/t4018/clojure-reader-comment

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index e84e104f9325..a7734d413758 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -807,6 +807,8 @@ patterns are available:
 
 - `bibtex` suitable for files with BibTeX coded references.
 
+- `clojure` suitable for source code in the Clojure language.
+
 - `cpp` suitable for source code in the C and C++ languages.
 
 - `csharp` suitable for source code in the C# language.
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 9675bc17db27..f126a349aa24 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -29,6 +29,7 @@ diffpatterns="
 	ada
 	bash
 	bibtex
+	clojure
 	cpp
 	csharp
 	css
diff --git a/t/t4018/clojure-comment b/t/t4018/clojure-comment
new file mode 100644
index 000000000000..5e20f41b554e
--- /dev/null
+++ b/t/t4018/clojure-comment
@@ -0,0 +1,8 @@
+(comment ;; RIGHT rich comment
+
+
+;; ignore comment
+
+
+    (do-something "ChangeMe"))
+
diff --git a/t/t4018/clojure-function b/t/t4018/clojure-function
new file mode 100644
index 000000000000..347790fd37f7
--- /dev/null
+++ b/t/t4018/clojure-function
@@ -0,0 +1,6 @@
+(defn RIGHT
+  []
+; ignore comment
+
+  (ChangeMe))
+
diff --git a/t/t4018/clojure-ns b/t/t4018/clojure-ns
new file mode 100644
index 000000000000..e3e2e5f4c986
--- /dev/null
+++ b/t/t4018/clojure-ns
@@ -0,0 +1,10 @@
+(ns RIGHT
+
+;; ignore comment
+
+  (:require [some.lib :refer [
+
+
+                              ChangeMe
+
+                              ]))
diff --git a/t/t4018/clojure-reader-comment b/t/t4018/clojure-reader-comment
new file mode 100644
index 000000000000..f17e51074558
--- /dev/null
+++ b/t/t4018/clojure-reader-comment
@@ -0,0 +1,5 @@
+#_((def commented-RIGHT-definition
+
+; ignore comment
+
+     ChangeMe))
diff --git a/userdiff.c b/userdiff.c
index 3f81a2261c5e..887264081e3c 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -44,6 +44,17 @@ PATTERNS("bash",
 	 /* -- */
 	 /* Characters not in the default $IFS value */
 	 "[^ \t]+"),
+PATTERNS("clojure",
+	 /* Ignore comments */
+	 "!^;.*\n"
+	 /* Top level forms */
+	 "^[^ \t].*$",
+	 /* Atoms, Keywords, Symbols */
+	 "[#@:]?[^0-9][a-zA-Z0-9*+!-_'?<>=/.]+"
+	 /* Numbers */
+	 "|[-]?[0-9a-fA-Frxb/MN]+"
+	 /* Characters */
+	 "|[\\0-9a-fA-F]+"),
 PATTERNS("dts",
 	 "!;\n"
 	 "!=\n"

base-commit: 13d7ab6b5d7929825b626f050b62a11241ea4945
-- 
gitgitgadget
