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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE33C4332D
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B709164DDA
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhBOPsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 10:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhBOPph (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:45:37 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84112C061221
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:56 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m1so9746466wml.2
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kk/Wc9ycvNNYYEvR8p1m5HEQ3LwZdHEoFNNmjMdkBSs=;
        b=fouEtGv7mIw6HMBTkhEcHsd5RXqyImsN8z1zEEe24jdv5BfVHKKwukaZ3G6upX36an
         5GtUjaWnQtAFTWKvBTGalgwVyCZ3Reas8N/oIAgygfWCYe861XGBVc2fGFd8u4lhWI5O
         OWZAx/AHLrCuyadERSRgdPtYb36j0ch6IeFwWK5HlquXw9d8qU2+FHoue0CJLbIeifq9
         Wh8/ikBQEjDkiSqKIJgiHONQeZ18PEPsq3OfOqsuIPfgrD2O31QsrSWPu3QD+WngOozg
         3pIgoMHG04C44hS5Pu+gi5eanJBvS4byBh8SFjeB3M862eRCS7px2kul/CQTg1lYUcam
         G3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kk/Wc9ycvNNYYEvR8p1m5HEQ3LwZdHEoFNNmjMdkBSs=;
        b=IhQfUgzQoPVA4RPzUWdBRiZd6ZnU+FXQPUUflai/mYQURmdolYgm+he7Bizc+9hbPj
         1Uyre5mdCZmVoCDK1yL5hELtWsxZTET3eFV70cPIhYzJtu7r3YIHsdjsmtXo+Kq5XHjm
         Rhk0UZpBubWQA+kVgLh/KTqVGRx8rHIW3pAdXNqtgJqZzZ7D0s2iDTFIFq70e41PkiDI
         L/uBCj3wSfiz+ipgl1OvFJSZ8+ll6EIOq6EzV3DsRL9uY2wbnorsUlxyaWdcghXHlWfc
         Nq8Gi8+U0NOOY4xTQOKZzD5DhCRX7zjmUYMZfW2YcrekAjDJRRAmpOu2m4xmLmjMJqTi
         n7og==
X-Gm-Message-State: AOAM532AQozY4UVzNxY8/f1jc9IV2SpC4wxoHTyoY3FvA6/Tcv88cQ6z
        ZyLYroszysi+qYL676kcUCX5hVXg+bcN3w==
X-Google-Smtp-Source: ABdhPJzEI646dtfyo1mIvOytO64HgVuA5gp/j2fKUZNKGCubXHLF83JBRbwWr7Pe6oKEfD3OoOLJPQ==
X-Received: by 2002:a1c:8096:: with SMTP id b144mr15235303wmd.169.1613403894960;
        Mon, 15 Feb 2021 07:44:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:44:54 -0800 (PST)
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
Subject: [PATCH v2 11/27] blame tests: simplify userdiff driver test
Date:   Mon, 15 Feb 2021 16:44:11 +0100
Message-Id: <20210215154427.32693-12-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify the test added in 9466e3809d (blame: enable funcname blaming
with userdiff driver, 2020-11-01) to use the --author support recently
added in 999cfc4f45 (test-lib functions: add --author support to
test_commit, 2021-01-12).

We also did not need the full fortran-external-function content, let's
cut it down to just the important parts, and further modify it to
demonstrate that the fortran-specific userdiff function is in effect
by adding "WRONG" lines surrounding the "RIGHT" one.

The test also left behind a .gitattributes files, let's clean it up
with "test_when_finished".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/annotate-tests.sh | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 04a2c58594..4a86e0f349 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -479,32 +479,26 @@ test_expect_success 'blame -L ^:RE (absolute: end-of-file)' '
 	check_count -f hello.c -L$n -L^:ma.. F 4 G 1 H 1
 '
 
-test_expect_success 'setup -L :funcname with userdiff driver' '
-	echo "fortran-* diff=fortran" >.gitattributes &&
-	fortran_file=fortran-external-function &&
-	cat >$fortran_file <<-\EOF &&
+test_expect_success 'blame -L :funcname with userdiff driver' '
+	cat >file.template <<-\EOF &&
+	def WRONG begin end
 	function RIGHT(a, b) result(c)
+	int WRONG(void) {}
 
 	integer, intent(in) :: ChangeMe
-	integer, intent(in) :: b
-	integer, intent(out) :: c
-
-	c = a+b
-
-	end function RIGHT
 	EOF
-	git add "$fortran_file" &&
-	GIT_AUTHOR_NAME="A" GIT_AUTHOR_EMAIL="A@test.git" \
-	git commit -m "add fortran file" &&
-	sed -e "s/ChangeMe/IWasChanged/" <"$fortran_file" >"$fortran_file".tmp &&
-	mv "$fortran_file".tmp "$fortran_file" &&
-	git add "$fortran_file" &&
-	GIT_AUTHOR_NAME="B" GIT_AUTHOR_EMAIL="B@test.git" \
-	git commit -m "change fortran file"
-'
 
-test_expect_success 'blame -L :funcname with userdiff driver' '
-	check_count -f fortran-external-function -L:RIGHT A 7 B 1
+	fortran_file=file.f03 &&
+	test_when_finished "rm .gitattributes" &&
+	echo "$fortran_file diff=fortran" >.gitattributes &&
+
+	test_commit --author "A <A@test.git>" \
+		"add" $fortran_file \
+		"$(cat file.template)" &&
+	test_commit --author "B <B@test.git>" \
+		"change" $fortran_file \
+		"$(cat file.template | sed -e s/ChangeMe/IWasChanged/)" &&
+	check_count -f $fortran_file -L:RIGHT A 3 B 1
 '
 
 test_expect_success 'setup incremental' '
-- 
2.30.0.284.gd98b1dd5eaa7

