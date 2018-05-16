Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00AEB1F406
	for <e@80x24.org>; Wed, 16 May 2018 01:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbeEPB6z (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 21:58:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47432 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752289AbeEPB6w (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 May 2018 21:58:52 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D8A0C6074A;
        Wed, 16 May 2018 01:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526435930;
        bh=00NHiwA3V9AXjQzL1ROJt/TPi54L+pcIN8x/QSEaIH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=JyKY4ynh+CUQ7XVA3kJ0dy5VIyVYCCI+lA1/05LtNfPgfxEpe3rTqWA0Xaov3hJdq
         mb7/mKZQDuuePlDPAG+4Na4+w9PE9CJIDPBWhOwx6NfTXAuk8CbLVnQtOWj5nP9AG0
         wvHMwNnANlzTiJvD6b7APKXvm3w5KslLz11nKsguQjZVByrG1vdxzZo0rpVtd7GQY1
         avJvuL5+/e41OTqR1wH4BzFwgjebBdRXkwGBybHxbvDePin9hobpHKee/OhBhV2q+p
         ayGAmJ6NY9MoWZni2PhbwAFtv8RWH9AzHLawPxlNqeJIAptHwKZa9uSl+8EMuVVBAK
         u57epRQcMTBlWuMB3rTuzUHVsXpp/3e61i2mAtynYTGHAgg6QwbJoc4ojZCom4P/bF
         zeVHq5iMPchRCZDzDsv+tWVIPC1v5rNWEG6zRflDzkwxpyKOmLzKC+HDs+/pfYbHxR
         gzaE+9tDbsX50915iesgm/0+1zJsPiHv5f5M8himNUzM9IJNkda
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 14/28] t3905: abstract away SHA-1-specific constants
Date:   Wed, 16 May 2018 01:56:16 +0000
Message-Id: <20180516015630.661349-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180516015630.661349-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for blobs instead of using
hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3905-stash-include-untracked.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 3ea5b9bb3f..597b0637d1 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -35,24 +35,26 @@ test_expect_success 'stash save --include-untracked cleaned the untracked files'
 	test_cmp expect actual
 '
 
+tracked=$(git rev-parse --short $(echo 1 | git hash-object --stdin))
+untracked=$(git rev-parse --short $(echo untracked | git hash-object --stdin))
 cat > expect.diff <<EOF
 diff --git a/HEAD b/HEAD
 new file mode 100644
-index 0000000..d00491f
+index 0000000..$tracked
 --- /dev/null
 +++ b/HEAD
 @@ -0,0 +1 @@
 +1
 diff --git a/file2 b/file2
 new file mode 100644
-index 0000000..d00491f
+index 0000000..$tracked
 --- /dev/null
 +++ b/file2
 @@ -0,0 +1 @@
 +1
 diff --git a/untracked/untracked b/untracked/untracked
 new file mode 100644
-index 0000000..5a72eb2
+index 0000000..$untracked
 --- /dev/null
 +++ b/untracked/untracked
 @@ -0,0 +1 @@
@@ -109,10 +111,11 @@ test_expect_success 'stash save -u dirty index' '
 	git stash -u
 '
 
+blob=$(git rev-parse --short $(echo 4 | git hash-object --stdin))
 cat > expect <<EOF
 diff --git a/file3 b/file3
 new file mode 100644
-index 0000000..b8626c4
+index 0000000..$blob
 --- /dev/null
 +++ b/file3
 @@ -0,0 +1 @@
