Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96AF11F462
	for <e@80x24.org>; Sun,  9 Jun 2019 22:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbfFIWoY (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 18:44:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37598 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729777AbfFIWoW (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 9 Jun 2019 18:44:22 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1504:7263:609b:f73f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3B5BE61B3F;
        Sun,  9 Jun 2019 22:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1560120261;
        bh=M0MQpkFrfaSOrgT/0PAL3clo9+uKbC69veH6kSfTa3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=q0qGGEIJABwgCMcnPQxMI5NSRvTWNvOUrJYfyXlqdka6pKd4RZIG/W1qjGYTDn/IE
         dxKh8bkejPOGI5Rst9Z3Mmg9WifVebE+OzKJAHd51mcpAoCy+aiTUxVHVcKJ9gwIaV
         AvyMY/rRqPnGL2m4gls+0zgSHulEfg+XY7VklhybYZsg+402GlnOlcD/bF/k3Hcsvg
         5qwk1F3AIGG3684UIA7LYWwHxkYZ3xR2cWdhYNVfjeEGoAUC/1/j/ApSLsUWVGbkho
         0Yqw/wcG7/WvPnYddOzTL2WZ36RicWjtqV4+mJdOT45U0p7fbs+2xyGkbs4ea38AuR
         emv/4XLnTNQNTu/kbeqpDE25TdXi3ec/Faa/yOSBncLTpXD4xsKQIGYWgDYL/sGnZ7
         2vvNGqDomG239uRKQJg5LOyYaH+vdu21+BNHlt50+Ss8sZRR/klSpbB64meiGCsy0+
         V3oP+laS55N+BDPwoOrLKLUal2EiAa8pakc61PL7V3XN2dgI0qw
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 08/10] t1007: remove SHA1 prerequisites
Date:   Sun,  9 Jun 2019 22:43:58 +0000
Message-Id: <20190609224400.41557-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2
In-Reply-To: <20190609224400.41557-1-sandals@crustytoothpaste.net>
References: <20190609224400.41557-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update this test to use test_oid_cache to specify the object IDs for
both SHA-1 and SHA-256.  Since this test now works with both algorithms,
remove the SHA1 prerequisite.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1007-hash-object.sh | 58 +++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 7099d33508..64b340f227 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -9,22 +9,19 @@ echo_without_newline() {
 }
 
 test_blob_does_not_exist() {
-	test_expect_success SHA1 'blob does not exist in database' "
+	test_expect_success 'blob does not exist in database' "
 		test_must_fail git cat-file blob $1
 	"
 }
 
 test_blob_exists() {
-	test_expect_success SHA1 'blob exists in database' "
+	test_expect_success 'blob exists in database' "
 		git cat-file blob $1
 	"
 }
 
 hello_content="Hello World"
-hello_sha1=5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689
-
 example_content="This is an example"
-example_sha1=ddd3f836d3e3fbb7ae289aa9ae83536f76956399
 
 setup_repo() {
 	echo_without_newline "$hello_content" > hello
@@ -44,7 +41,16 @@ pop_repo() {
 	rm -rf $test_repo
 }
 
-setup_repo
+test_expect_success 'setup' '
+	setup_repo &&
+	test_oid_cache <<-EOF
+	hello sha1:5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689
+	hello sha256:1e3b6c04d2eeb2b3e45c8a330445404c0b7cc7b257e2b097167d26f5230090c4
+
+	example sha1:ddd3f836d3e3fbb7ae289aa9ae83536f76956399
+	example sha256:b44fe1fe65589848253737db859bd490453510719d7424daab03daf0767b85ae
+	EOF
+'
 
 # Argument checking
 
@@ -73,23 +79,23 @@ test_expect_success "Can't use --path with --no-filters" '
 
 push_repo
 
-test_expect_success SHA1 'hash a file' '
-	test $hello_sha1 = $(git hash-object hello)
+test_expect_success 'hash a file' '
+	test "$(test_oid hello)" = $(git hash-object hello)
 '
 
-test_blob_does_not_exist $hello_sha1
+test_blob_does_not_exist "$(test_oid hello)"
 
-test_expect_success SHA1 'hash from stdin' '
-	test $example_sha1 = $(git hash-object --stdin < example)
+test_expect_success 'hash from stdin' '
+	test "$(test_oid example)" = $(git hash-object --stdin < example)
 '
 
-test_blob_does_not_exist $example_sha1
+test_blob_does_not_exist "$(test_oid example)"
 
-test_expect_success SHA1 'hash a file and write to database' '
-	test $hello_sha1 = $(git hash-object -w hello)
+test_expect_success 'hash a file and write to database' '
+	test "$(test_oid hello)" = $(git hash-object -w hello)
 '
 
-test_blob_exists $hello_sha1
+test_blob_exists "$(test_oid hello)"
 
 test_expect_success 'git hash-object --stdin file1 <file0 first operates on file0, then file1' '
 	echo foo > file1 &&
@@ -161,11 +167,11 @@ pop_repo
 for args in "-w --stdin" "--stdin -w"; do
 	push_repo
 
-	test_expect_success SHA1 "hash from stdin and write to database ($args)" '
-		test $example_sha1 = $(git hash-object $args < example)
+	test_expect_success "hash from stdin and write to database ($args)" '
+		test "$(test_oid example)" = $(git hash-object $args < example)
 	'
 
-	test_blob_exists $example_sha1
+	test_blob_exists "$(test_oid example)"
 
 	pop_repo
 done
@@ -173,22 +179,22 @@ done
 filenames="hello
 example"
 
-sha1s="$hello_sha1
-$example_sha1"
+oids="$(test_oid hello)
+$(test_oid example)"
 
-test_expect_success SHA1 "hash two files with names on stdin" '
-	test "$sha1s" = "$(echo_without_newline "$filenames" | git hash-object --stdin-paths)"
+test_expect_success "hash two files with names on stdin" '
+	test "$oids" = "$(echo_without_newline "$filenames" | git hash-object --stdin-paths)"
 '
 
 for args in "-w --stdin-paths" "--stdin-paths -w"; do
 	push_repo
 
-	test_expect_success SHA1 "hash two files with names on stdin and write to database ($args)" '
-		test "$sha1s" = "$(echo_without_newline "$filenames" | git hash-object $args)"
+	test_expect_success "hash two files with names on stdin and write to database ($args)" '
+		test "$oids" = "$(echo_without_newline "$filenames" | git hash-object $args)"
 	'
 
-	test_blob_exists $hello_sha1
-	test_blob_exists $example_sha1
+	test_blob_exists "$(test_oid hello)"
+	test_blob_exists "$(test_oid example)"
 
 	pop_repo
 done
