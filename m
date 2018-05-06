Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61C0E200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeEFXTH (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:19:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41204 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752030AbeEFXS6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 19:18:58 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F041D60761;
        Sun,  6 May 2018 23:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525648735;
        bh=vqhEDAX66enHXwvH4Dbb71ck/56wkA9xwXomvQggeF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=qCkCjDU3QNDGrT10JE4EJ3gQO1ZwrX2O765UFFiAOxKtj0DZUMW4xbVmqsAzI8jIq
         SXj5xrTwMpm1ev57/bblSZaXfUUQAYZ/P4Af3G72M5RADQdiHe/o46kmGBmvoJVFiS
         puWYHPVncC8sPYoNNzhuwmJe0X8fB9ORCtTAh6cqvGz/twd2syqa7v22AGQQbcmkiN
         ytCRPYXk21WWIXVtqyZKRA91jXrSshbP8NiuRTrekVYNnqbJEjCvLnP489GNsMe8o2
         wJwRgBJBtFiEBsH2KCTz0+pard6kKuEj3ZekrH7QWGWvyNbemj2lf40JzaX9r9taQ+
         TH8ecdDI3LVBnVTsy24seqiYKdHDWwWjKiCMNnyRMK54JxA3inovS/nuhmfYMU4yKp
         ECeOtKpi6zYWUpro0VBgiURqKQW+2prZrmonMvuYk8ex7DV1TpgjaDXtQUke3NqXqa
         XNlGCgyCvajEX5Ax+MwjneJoYpx393xEhybtYbSlRE+goiXsapp
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 22/28] t4030: abstract away SHA-1-specific constants
Date:   Sun,  6 May 2018 23:17:46 +0000
Message-Id: <20180506231752.975110-23-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180506231752.975110-1-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for blobs instead of using
hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4030-diff-textconv.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index aad6c7f78d..4cb9f0e523 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -148,7 +148,8 @@ test_expect_success 'diffstat does not run textconv' '
 # restore working setup
 echo file diff=foo >.gitattributes
 
-cat >expect.typechange <<'EOF'
+symlink=$(git rev-parse --short $(printf frotz | git hash-object --stdin))
+cat >expect.typechange <<EOF
 --- a/file
 +++ /dev/null
 @@ -1,2 +0,0 @@
@@ -156,7 +157,7 @@ cat >expect.typechange <<'EOF'
 -1
 diff --git a/file b/file
 new file mode 120000
-index 0000000..67be421
+index 0000000..$symlink
 --- /dev/null
 +++ b/file
 @@ -0,0 +1 @@
