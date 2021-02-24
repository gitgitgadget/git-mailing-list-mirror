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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D1CC433E6
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D8B64F03
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbhBXTya (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbhBXTxc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:53:32 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCB4C06121D
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:06 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id w7so2795943wmb.5
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/UQOkgSV7OPMPxjT6137j242ZmqWH5XPLBxYUF7iDnU=;
        b=THdio5u+f2nBwY1cFUW8dexGTLqGyVMuQBY34ioX8gg04Q9BT87cyQjqsaW5a1fYXH
         cMx7uvL3Mdie8XlmE/4HToVj65IlvcKi9AwUZnVVbfEIH3bToD5Ilm96i0Z8m9DjXhTy
         icCuR6suPhd/68CdtZRCdjUpcfwg0OorGTT8DpInEO825YD/mQKQ7IDTmZ4wi7U84EMC
         cLp0F6vrY6RdsIz+c80Tk40UrjoH3i9pu1xdFEveUuvVzAR/o5iMyULplP7gL0v1owpJ
         7znVGPv/MvAG1XWiCY0UE3w9ZIJvN6yn15GFlgbjMML1zUHoNT7utCizAQtQxwygI5rc
         OAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/UQOkgSV7OPMPxjT6137j242ZmqWH5XPLBxYUF7iDnU=;
        b=J1yz7J6ZYInUvTzVHHIcgXoSp5HfB2wqGRK6jmX8mj8Tdg4dH/JYdjQ65N4A+GCNWV
         6+9vUU0xCgt4CuKWB3Z2sJJij918XnvtGKaJhRL24MH2LO7heV8GRsZBRyekpsdjJ+nd
         C+MnhErwHhbU7S52+nkx3q7D+zvy99d4QAPaVV8C8Pku25CDlu3n5y/R6JmVNNM+8VRn
         C6oqBnMFvgEFmeAP6BjQ16G+pqE1m1JZ7j26PLZZv85BAGVZlquzW4ixGSvReER7zK0L
         OANkp1DCJwjpTe0BE9+Y5JqF0YF0HRRYABo1nJIWGXeSW+nm2FpbYqxpYTQQz9uR8F4W
         GqiA==
X-Gm-Message-State: AOAM533dcRmoxkOn98VMyZ0Yq70inHupSeVypZGRoJsM/JU2OZZJmaDq
        WUJ2LuoUgwNGd5M1Rujb/7b5rVAScq0QwA==
X-Google-Smtp-Source: ABdhPJyAEez0OwjUqvU4fzbFIf/hZI3bjEnrL7oGhz1cD0akFH0tfWa3YESbQdY4dgHjKgOtEwPlQA==
X-Received: by 2002:a1c:cc14:: with SMTP id h20mr5236252wmb.14.1614196325111;
        Wed, 24 Feb 2021 11:52:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 15/35] userdiff tests: add a test with multiple tests in a LANG file
Date:   Wed, 24 Feb 2021 20:51:09 +0100
Message-Id: <20210224195129.4004-16-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Demonstrate that we can now have tests with multiple tests in a given
LANG file. This is useful to show rules that don't match, follow-up
commits will add some tests like that.

Let's move the "golang" test, which I'm going to be modifying soon
over to to this new convention.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh        |  2 +-
 t/t4018/README                  |  8 +++++++
 t/t4018/golang                  | 39 +++++++++++++++++++++++++++++++++
 t/t4018/golang-complex-function |  9 --------
 t/t4018/golang-func             |  5 -----
 t/t4018/golang-interface        |  5 -----
 t/t4018/golang-long-func        |  6 -----
 t/t4018/golang-struct           |  5 -----
 8 files changed, 48 insertions(+), 31 deletions(-)
 create mode 100644 t/t4018/golang
 delete mode 100644 t/t4018/golang-complex-function
 delete mode 100644 t/t4018/golang-func
 delete mode 100644 t/t4018/golang-interface
 delete mode 100644 t/t4018/golang-long-func
 delete mode 100644 t/t4018/golang-struct

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 6fd3dce1364..7fc4291f4be 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -67,7 +67,7 @@ test_expect_success 'last regexp must not be negated' '
 test_expect_success 'setup hunk header tests' '
 	for i in $diffpatterns
 	do
-		echo "$i-* diff=$i"
+		echo "$i* diff=$i"
 	done > .gitattributes &&
 
 	cp -R "$TEST_DIRECTORY"/t4018 . &&
diff --git a/t/t4018/README b/t/t4018/README
index 54ae735d5f8..a3220dd6374 100644
--- a/t/t4018/README
+++ b/t/t4018/README
@@ -41,6 +41,9 @@ below) are:
 Create test cases called "LANG-whatever" in this directory, where
 "whatever" is a brief description of the test.
 
+You can also stick all the tests into one "LANG" file. See "t4018
+description" below.
+
 Any line starting with "t4018" is a control line for the test:
 
  - The "t4018 header:" line above specifies what text must appear in
@@ -48,6 +51,11 @@ Any line starting with "t4018" is a control line for the test:
    the line for ease of not having to hardcode the line numbers and
    offsets.
 
+ - The "t4018 description:" line above the test is a convention to add
+   a human-readable description for the test. Unlike in the case of
+   the LANG.sh test cases these descriptions don't make it to
+   "test_expect_success", and won't be seen in the test output.
+
 In many of the test cases the header line includes the token "RIGHT",
 this used to be part of the test syntax, but isn't anymore. Now we
 care about the "t4018 header:" line, not whatever line contains a
diff --git a/t/t4018/golang b/t/t4018/golang
new file mode 100644
index 00000000000..000e66b1c7b
--- /dev/null
+++ b/t/t4018/golang
@@ -0,0 +1,39 @@
+t4018 description: complex function
+t4018 header: func (t *Test) RIGHT(a Type) (Type, error) {
+type Test struct {
+	a Type
+}
+
+func (t *Test) RIGHT(a Type) (Type, error) {
+	t.a = a
+	return ChangeMe, nil
+}
+
+t4018 description: func
+t4018 header: func RIGHT() {
+func RIGHT() {
+	a := 5
+	b := ChangeMe
+}
+
+t4018 description: interface
+t4018 header: type RIGHT interface {
+type RIGHT interface {
+	a() Type
+	b() ChangeMe
+}
+
+t4018 description: long func
+t4018 header: func RIGHT(aVeryVeryVeryLongVariableName AVeryVeryVeryLongType,
+func RIGHT(aVeryVeryVeryLongVariableName AVeryVeryVeryLongType,
+	anotherLongVariableName AnotherLongType) {
+	a := 5
+	b := ChangeMe
+}
+
+t4018 description: struct
+t4018 header: type RIGHT struct {
+type RIGHT struct {
+	a Type
+	b ChangeMe
+}
diff --git a/t/t4018/golang-complex-function b/t/t4018/golang-complex-function
deleted file mode 100644
index 0574ba912e6..00000000000
--- a/t/t4018/golang-complex-function
+++ /dev/null
@@ -1,9 +0,0 @@
-t4018 header: func (t *Test) RIGHT(a Type) (Type, error) {
-type Test struct {
-	a Type
-}
-
-func (t *Test) RIGHT(a Type) (Type, error) {
-	t.a = a
-	return ChangeMe, nil
-}
diff --git a/t/t4018/golang-func b/t/t4018/golang-func
deleted file mode 100644
index 0472cfd9798..00000000000
--- a/t/t4018/golang-func
+++ /dev/null
@@ -1,5 +0,0 @@
-t4018 header: func RIGHT() {
-func RIGHT() {
-	a := 5
-	b := ChangeMe
-}
diff --git a/t/t4018/golang-interface b/t/t4018/golang-interface
deleted file mode 100644
index 3160a1d4524..00000000000
--- a/t/t4018/golang-interface
+++ /dev/null
@@ -1,5 +0,0 @@
-t4018 header: type RIGHT interface {
-type RIGHT interface {
-	a() Type
-	b() ChangeMe
-}
diff --git a/t/t4018/golang-long-func b/t/t4018/golang-long-func
deleted file mode 100644
index de83aaafca5..00000000000
--- a/t/t4018/golang-long-func
+++ /dev/null
@@ -1,6 +0,0 @@
-t4018 header: func RIGHT(aVeryVeryVeryLongVariableName AVeryVeryVeryLongType,
-func RIGHT(aVeryVeryVeryLongVariableName AVeryVeryVeryLongType,
-	anotherLongVariableName AnotherLongType) {
-	a := 5
-	b := ChangeMe
-}
diff --git a/t/t4018/golang-struct b/t/t4018/golang-struct
deleted file mode 100644
index fc8022537b2..00000000000
--- a/t/t4018/golang-struct
+++ /dev/null
@@ -1,5 +0,0 @@
-t4018 header: type RIGHT struct {
-type RIGHT struct {
-	a Type
-	b ChangeMe
-}
-- 
2.30.0.284.gd98b1dd5eaa7

