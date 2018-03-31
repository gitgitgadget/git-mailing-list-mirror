Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8D581F424
	for <e@80x24.org>; Sat, 31 Mar 2018 10:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753096AbeCaKDb (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 06:03:31 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39303 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753057AbeCaKD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 06:03:28 -0400
Received: by mail-lf0-f65.google.com with SMTP id p142-v6so15134001lfd.6
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 03:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2QG9ompxrvz0Xqb3ebIbhgMS5mxX6vVV0DXoNV2K/VI=;
        b=LvIo0NJRs9GAB3H1jmi5etCQXRvszO9TERG2ACnS/8SdiNyRbkaAEScK0Cd9CLnlSI
         maDtCDki9hqRJP+b6WQ4RS4dCwoSgrGi6za857Cu2mLtk/O6wQ+IcZHeuD6vyhJ1N8UM
         NM2OLJFChWDuKSbVLLvFxkVtZQB1stikBF6693pOAWJwEWy5C41ijp/8eWKmYDXAVZMW
         HQ348d8OBTV4ZpgUt1PzGu6mUQxjhsM8FgP8kU49xm2bf5AHXs5Ouh9hcGaxeRVnFXaD
         H7J17dBQZhGxTThgdD25qOfgJZG17NjeYQE7oOahwbl+zMYHs65P/dEcaH+tOU1Nud5f
         rCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2QG9ompxrvz0Xqb3ebIbhgMS5mxX6vVV0DXoNV2K/VI=;
        b=TCzdMnEk5JWpe6dgyzSwXmRCudxznH8sS6j6gB6IWbWw7bjnb7+ODckL5MzjsQkZ4l
         WhH7NC1b642MONnt12uixN/vRJ3cEsUAkPiq+1CXV/MRX68X/vG2LhoH54Qsu4QXpwdC
         r/31WOdT7XBWVyX+EAZVilBgvoN6RCi+CyvyNUNNIB5Nk3bjQtSPfM1T84iz+Y4fCixO
         7t2E0euTUcjYYQtBbzaDTq3+3zLsf0xILjboHsJqrpB2SVLpUGG3WBnQZqidvrLg/i88
         NM1wphlsPk2tzeNPQBJMh8AVEazmCpK043uHBguAf5pJmca7DrvLQ1flDRihQM7c1c/L
         XUkA==
X-Gm-Message-State: AElRT7HCmLvhSpfPnCjWGpm+BUpjecLmtK4q2KyAX88LH8rCI5kK8r7e
        fJ1SzKhB2qbUIRr5raxlqHmgtQ==
X-Google-Smtp-Source: AIpwx493VjLsVpuD24mV0QGpOM4q7ngPZGUyJ3IGWnB8jFWdVRc3Yev/E6hieOuQ8QnavxIaaOVM6g==
X-Received: by 10.46.158.130 with SMTP id f2mr1490389ljk.3.1522490607092;
        Sat, 31 Mar 2018 03:03:27 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id a1sm1799175ljj.90.2018.03.31.03.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Mar 2018 03:03:26 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v8 05/15] pack-objects: use bitfield for object_entry::depth
Date:   Sat, 31 Mar 2018 12:03:01 +0200
Message-Id: <20180331100311.32373-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc2.515.g4feb9b7923
In-Reply-To: <20180331100311.32373-1-pclouds@gmail.com>
References: <20180324063353.24722-1-pclouds@gmail.com>
 <20180331100311.32373-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Because of struct packing from now on we can only handle max depth
4095 (or even lower when new booleans are added in this struct). This
should be ok since long delta chain will cause significant slow down
anyway.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt           | 1 +
 Documentation/git-pack-objects.txt | 4 +++-
 Documentation/git-repack.txt       | 4 +++-
 builtin/pack-objects.c             | 6 ++++++
 pack-objects.h                     | 5 ++---
 5 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f57e9cf10c..9bd3f5a789 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2412,6 +2412,7 @@ pack.window::
 pack.depth::
 	The maximum delta depth used by linkgit:git-pack-objects[1] when no
 	maximum depth is given on the command line. Defaults to 50.
+	Maximum value is 4095.
 
 pack.windowMemory::
 	The maximum size of memory that is consumed by each thread
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 81bc490ac5..3503c9e3e6 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -96,7 +96,9 @@ base-name::
 	it too deep affects the performance on the unpacker
 	side, because delta data needs to be applied that many
 	times to get to the necessary object.
-	The default value for --window is 10 and --depth is 50.
++
+The default value for --window is 10 and --depth is 50. The maximum
+depth is 4095.
 
 --window-memory=<n>::
 	This option provides an additional limit on top of `--window`;
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index ae750e9e11..25c83c4927 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -90,7 +90,9 @@ other objects in that pack they already have locally.
 	space. `--depth` limits the maximum delta depth; making it too deep
 	affects the performance on the unpacker side, because delta data needs
 	to be applied that many times to get to the necessary object.
-	The default value for --window is 10 and --depth is 50.
++
+The default value for --window is 10 and --depth is 50. The maximum
+depth is 4095.
 
 --threads=<n>::
 	This option is passed through to `git pack-objects`.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ebb6e034cb..2ce05626d2 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3068,6 +3068,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (pack_to_stdout != !base_name || argc)
 		usage_with_options(pack_usage, pack_objects_options);
 
+	if (depth >= (1 << OE_DEPTH_BITS)) {
+		warning(_("delta chain depth %d is too deep, forcing %d"),
+			depth, (1 << OE_DEPTH_BITS) - 1);
+		depth = (1 << OE_DEPTH_BITS) - 1;
+	}
+
 	argv_array_push(&rp, "pack-objects");
 	if (thin) {
 		use_internal_rev_list = 1;
diff --git a/pack-objects.h b/pack-objects.h
index 080ef62d31..cdce1648de 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -2,6 +2,7 @@
 #define PACK_OBJECTS_H
 
 #define OE_DFS_STATE_BITS	2
+#define OE_DEPTH_BITS		12
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -89,9 +90,7 @@ struct object_entry {
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
 	unsigned dfs_state:OE_DFS_STATE_BITS;
-
-	int depth;
-
+	unsigned depth:OE_DEPTH_BITS;
 };
 
 struct packing_data {
-- 
2.17.0.rc2.515.g4feb9b7923

