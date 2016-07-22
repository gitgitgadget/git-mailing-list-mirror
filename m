Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B075E203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 15:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbcGVPtS (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 11:49:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36004 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbcGVPtR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 11:49:17 -0400
Received: by mail-wm0-f67.google.com with SMTP id x83so6676207wma.3
        for <git@vger.kernel.org>; Fri, 22 Jul 2016 08:49:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T3IIC9ACy5basMH+TZ1OJDx4DN/px07VsOEdd9q2T5o=;
        b=wT2eV+7A18st9ORcJsKfD7qZVm8W5XR9c6L4aK1pXAB/qBCDXOsgGCxIr28WX29RZb
         DRMDS17tB9qudGEjVIeqkzOfPzQIMI2EJrxH5STmhPNwnmXu0+Unp4MEbKynOQd+yqJn
         lyScsTydRhFh3bpTBKstomlN+oQ7PUXJTl3qeR07x4h2aao+WOpH+oBV1puhXxamZOQg
         Oy/P1uS9PyRk97gyMgYx4U/t60oli4tqfawFNfSYXVwuXluDnS6K94gna5V3hFe24zS5
         s5KoRHyDJRjTtd7fU8xXSZaBZ8iXULU+Einjh7KwPsU5d6RNoUEi93LXSP9ZZ7TRGoa5
         NOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T3IIC9ACy5basMH+TZ1OJDx4DN/px07VsOEdd9q2T5o=;
        b=ICxnbf4I5JdRb8XHpAabuM19JVosiFUXeQlY8+jXr/5pSwV8bH+oHZpFdeJ3b6rmcY
         tpe70IvVDZPdgtrhUkHyX8uhmkD+t4XFo/AWcgEmITLSBJFaEuxfxA2vL4UwwOi9eP7o
         Z++7vL17FRP3o1xEWmZ4tOQOVDlTRaZ0zisFftBCPVOM1NYnlRMa+aonNdof3nqsfIdB
         R4E5c5pF5NYJcvrmWQaJiy8OgfstVqCAHKblXcZUp+sef3JNUaOm6C7AkDkMPqkq7vl/
         7Iehge6Qm1hE7ya4ftwlIg8ui0EEk7cIZa5gaU8ScMuwsw1SDkx90430h53Sh8i0UJTu
         1d5g==
X-Gm-Message-State: AEkoouuAdxBUmnj8ggpRNiX5ex6r8G9qJq6Chs78QYn7P8Tnggrjg42iYtA5++/WBhQSDg==
X-Received: by 10.194.235.69 with SMTP id uk5mr1781803wjc.53.1469202555412;
        Fri, 22 Jul 2016 08:49:15 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id e10sm1507963wjc.21.2016.07.22.08.49.10
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 22 Jul 2016 08:49:11 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	peff@peff.net, jnareb@gmail.com, tboegi@web.de,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1 2/3] convert: modernize tests
Date:	Fri, 22 Jul 2016 17:48:59 +0200
Message-Id: <20160722154900.19477-3-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160722154900.19477-1-larsxschneider@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Use `test_config` to set the config, check that files are empty with
`test_must_be_empty`, compare files with `test_cmp`, and remove spaces
after ">".

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t0021-conversion.sh | 62 +++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 7bac2bc..a05a8d2 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -13,8 +13,8 @@ EOF
 chmod +x rot13.sh
 
 test_expect_success setup '
-	git config filter.rot13.smudge ./rot13.sh &&
-	git config filter.rot13.clean ./rot13.sh &&
+	test_config filter.rot13.smudge ./rot13.sh &&
+	test_config filter.rot13.clean ./rot13.sh &&
 
 	{
 	    echo "*.t filter=rot13"
@@ -38,8 +38,8 @@ script='s/^\$Id: \([0-9a-f]*\) \$/\1/p'
 
 test_expect_success check '
 
-	cmp test.o test &&
-	cmp test.o test.t &&
+	test_cmp test.o test &&
+	test_cmp test.o test.t &&
 
 	# ident should be stripped in the repository
 	git diff --raw --exit-code :test :test.i &&
@@ -47,10 +47,10 @@ test_expect_success check '
 	embedded=$(sed -ne "$script" test.i) &&
 	test "z$id" = "z$embedded" &&
 
-	git cat-file blob :test.t > test.r &&
+	git cat-file blob :test.t >test.r &&
 
-	./rot13.sh < test.o > test.t &&
-	cmp test.r test.t
+	./rot13.sh < test.o >test.t &&
+	test_cmp test.r test.t
 '
 
 # If an expanded ident ever gets into the repository, we want to make sure that
@@ -130,7 +130,7 @@ test_expect_success 'filter shell-escaped filenames' '
 
 	# delete the files and check them out again, using a smudge filter
 	# that will count the args and echo the command-line back to us
-	git config filter.argc.smudge "sh ./argc.sh %f" &&
+	test_config filter.argc.smudge "sh ./argc.sh %f" &&
 	rm "$normal" "$special" &&
 	git checkout -- "$normal" "$special" &&
 
@@ -141,7 +141,7 @@ test_expect_success 'filter shell-escaped filenames' '
 	test_cmp expect "$special" &&
 
 	# do the same thing, but with more args in the filter expression
-	git config filter.argc.smudge "sh ./argc.sh %f --my-extra-arg" &&
+	test_config filter.argc.smudge "sh ./argc.sh %f --my-extra-arg" &&
 	rm "$normal" "$special" &&
 	git checkout -- "$normal" "$special" &&
 
@@ -154,9 +154,9 @@ test_expect_success 'filter shell-escaped filenames' '
 '
 
 test_expect_success 'required filter should filter data' '
-	git config filter.required.smudge ./rot13.sh &&
-	git config filter.required.clean ./rot13.sh &&
-	git config filter.required.required true &&
+	test_config filter.required.smudge ./rot13.sh &&
+	test_config filter.required.clean ./rot13.sh &&
+	test_config filter.required.required true &&
 
 	echo "*.r filter=required" >.gitattributes &&
 
@@ -165,17 +165,17 @@ test_expect_success 'required filter should filter data' '
 
 	rm -f test.r &&
 	git checkout -- test.r &&
-	cmp test.o test.r &&
+	test_cmp test.o test.r &&
 
 	./rot13.sh <test.o >expected &&
 	git cat-file blob :test.r >actual &&
-	cmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'required filter smudge failure' '
-	git config filter.failsmudge.smudge false &&
-	git config filter.failsmudge.clean cat &&
-	git config filter.failsmudge.required true &&
+	test_config filter.failsmudge.smudge false &&
+	test_config filter.failsmudge.clean cat &&
+	test_config filter.failsmudge.required true &&
 
 	echo "*.fs filter=failsmudge" >.gitattributes &&
 
@@ -186,9 +186,9 @@ test_expect_success 'required filter smudge failure' '
 '
 
 test_expect_success 'required filter clean failure' '
-	git config filter.failclean.smudge cat &&
-	git config filter.failclean.clean false &&
-	git config filter.failclean.required true &&
+	test_config filter.failclean.smudge cat &&
+	test_config filter.failclean.clean false &&
+	test_config filter.failclean.required true &&
 
 	echo "*.fc filter=failclean" >.gitattributes &&
 
@@ -197,8 +197,8 @@ test_expect_success 'required filter clean failure' '
 '
 
 test_expect_success 'filtering large input to small output should use little memory' '
-	git config filter.devnull.clean "cat >/dev/null" &&
-	git config filter.devnull.required true &&
+	test_config filter.devnull.clean "cat >/dev/null" &&
+	test_config filter.devnull.required true &&
 	for i in $(test_seq 1 30); do printf "%1048576d" 1; done >30MB &&
 	echo "30MB filter=devnull" >.gitattributes &&
 	GIT_MMAP_LIMIT=1m GIT_ALLOC_LIMIT=1m git add 30MB
@@ -207,7 +207,7 @@ test_expect_success 'filtering large input to small output should use little mem
 test_expect_success 'filter that does not read is fine' '
 	test-genrandom foo $((128 * 1024 + 1)) >big &&
 	echo "big filter=epipe" >.gitattributes &&
-	git config filter.epipe.clean "echo xyzzy" &&
+	test_config filter.epipe.clean "echo xyzzy" &&
 	git add big &&
 	git cat-file blob :big >actual &&
 	echo xyzzy >expect &&
@@ -215,20 +215,20 @@ test_expect_success 'filter that does not read is fine' '
 '
 
 test_expect_success EXPENSIVE 'filter large file' '
-	git config filter.largefile.smudge cat &&
-	git config filter.largefile.clean cat &&
+	test_config filter.largefile.smudge cat &&
+	test_config filter.largefile.clean cat &&
 	for i in $(test_seq 1 2048); do printf "%1048576d" 1; done >2GB &&
 	echo "2GB filter=largefile" >.gitattributes &&
 	git add 2GB 2>err &&
-	! test -s err &&
+	test_must_be_empty err &&
 	rm -f 2GB &&
 	git checkout -- 2GB 2>err &&
-	! test -s err
+	test_must_be_empty err
 '
 
 test_expect_success "filter: clean empty file" '
-	git config filter.in-repo-header.clean  "echo cleaned && cat" &&
-	git config filter.in-repo-header.smudge "sed 1d" &&
+	test_config filter.in-repo-header.clean  "echo cleaned && cat" &&
+	test_config filter.in-repo-header.smudge "sed 1d" &&
 
 	echo "empty-in-worktree    filter=in-repo-header" >>.gitattributes &&
 	>empty-in-worktree &&
@@ -240,8 +240,8 @@ test_expect_success "filter: clean empty file" '
 '
 
 test_expect_success "filter: smudge empty file" '
-	git config filter.empty-in-repo.clean "cat >/dev/null" &&
-	git config filter.empty-in-repo.smudge "echo smudged && cat" &&
+	test_config filter.empty-in-repo.clean "cat >/dev/null" &&
+	test_config filter.empty-in-repo.smudge "echo smudged && cat" &&
 
 	echo "empty-in-repo filter=empty-in-repo" >>.gitattributes &&
 	echo dead data walking >empty-in-repo &&
-- 
2.9.0

