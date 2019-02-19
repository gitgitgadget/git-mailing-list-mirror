Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2F671F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbfBSAF7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:05:59 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34706 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732210AbfBSAF4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:05:56 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9687D61091;
        Tue, 19 Feb 2019 00:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534754;
        bh=S3KW5x+fS0rx13YokGb60mxm/GLtK6/vIeK8YZj5WFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=AfH4vjb+iI4g+SLX6OaCVC50MgTHTTW09DjFh7MaI/yTSfDmsqtd4jkDbOpzX8mEt
         Czi1P93Zf/QKjTHRFReC7DFWoFvn+h4Ho74cauh/jldFeqgmOouC9nu1ub5lC+A3sh
         FiU3XFuocJSXp5l9MH4wB/Wv4VFULBNRrpHA7z/TNbboc//YTg8j3eGD369F2f6aqA
         ORQbuFHCtgSk9TGP+qEDxFxtCwJ/jGS6qgxp1iK9LKhPAPbEcxqG2bGW2RWhVFIrBP
         JoCn4W9G5bJGbW2ncDujCcUJjYSjkjGEwKkY0oznfomUPEAJ8xhECE4+UVdAphMsi3
         ma3R+S/eCMoHTs58nsE405PhkGmtB2XZUqNbys1jCY9Gb5rgaawR+NChSq7WCwsYaF
         pnT5S/3aNCIjTQtNwCbcdZ4No0LaaNjngNpg4KK0gKLwYGGcsoM7gRbmJowdKf2Hen
         VryjfY3IQNOZQO4tCfQskulKYlfYFgEBcg4vJCP/3vqMMPnDCyP
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 15/35] fast-import: replace sha1_to_hex
Date:   Tue, 19 Feb 2019 00:05:06 +0000
Message-Id: <20190219000526.476553-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190219000526.476553-1-sandals@crustytoothpaste.net>
References: <20190219000526.476553-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the uses of sha1_to_hex in this function with hash_to_hex to
allow the use of SHA-256 as well.  Rename a variable since it is no
longer limited to SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fast-import.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 464db71c75..35ba2629b5 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2955,7 +2955,7 @@ static struct object_entry *parse_treeish_dataref(const char **p)
 	return e;
 }
 
-static void print_ls(int mode, const unsigned char *sha1, const char *path)
+static void print_ls(int mode, const unsigned char *hash, const char *path)
 {
 	static struct strbuf line = STRBUF_INIT;
 
@@ -2975,7 +2975,7 @@ static void print_ls(int mode, const unsigned char *sha1, const char *path)
 		/* mode SP type SP object_name TAB path LF */
 		strbuf_reset(&line);
 		strbuf_addf(&line, "%06o %s %s\t",
-				mode & ~NO_DELTA, type, sha1_to_hex(sha1));
+				mode & ~NO_DELTA, type, hash_to_hex(hash));
 		quote_c_style(path, &line, NULL, 0);
 		strbuf_addch(&line, '\n');
 	}
