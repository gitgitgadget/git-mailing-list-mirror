Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02B101FAE7
	for <e@80x24.org>; Sat, 17 Mar 2018 14:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbeCQOK4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 10:10:56 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39361 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752827AbeCQOKw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 10:10:52 -0400
Received: by mail-lf0-f66.google.com with SMTP id f75-v6so19319677lfg.6
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 07:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aeBHqENIqO8iOx5T01NgBPmfQUSq7/hHedNV63l6UiI=;
        b=LVI1K8DHkpFgkJAH1yDwhrX2l6SGjQpe46kTn2B7g7U5cEx/7sWG4EVpLLwU/ScEzq
         e6cdRpIJ/lB4ZYcgb0yqmP7jzsIXuj9nMmAm0ack+JyPQpxr3T/RuCYmEQ7/aUuEW68u
         4O/RbzAR2z2Bm5Jb/nEZfFcDMlkilHshvkI0Xp68b5m7oOvFTDgEVpZBEeDblq2N92TR
         xyq5Om3Yd7356r6VX5vCML4DE9C/HvfYfjRZixOTBW3s+7DxkkfGecCKDzUGixie6NKf
         Jcf5gEUF07UANBmISEFLxR5jRN6wBaSVY13WNaj4KqD3BI2hgC+1hRPydcQUKE0fRyUJ
         jj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aeBHqENIqO8iOx5T01NgBPmfQUSq7/hHedNV63l6UiI=;
        b=Za39xWMF5AwqCBcd11qqHw7zD4pt4DG/1CvufNsgAGwbloEt8pK2f4X+8nr6SXllwW
         Hx/b0ndRd9Ieb09vkZIQ0Mm8ru05OXXmlbtGx8yNK22n4+CFsehrEmpbi3RX4KMnCH29
         YiyKesu/B+Lkx4yYzx009d0BFVj7tq5lCcoRYSrhs1x2Kf+rZkktLwltqNA7Ka8nAtD1
         yeu05vpXpoRqjg5/zif15gRBTd4BiHxzr3DdxvarTrcUXjt0L6N/u2UHdmntKaSJN/Rc
         rKZZaIfGFa3pLUx8fH+Yp7sCuQbBeECELLzyja8blhlqbaW7u3AY9Qal8sPp41NSSstm
         cp1g==
X-Gm-Message-State: AElRT7Hy/FSa1PcvqflGkElyetsLkvcTiG4C0maQ5h3BXjWAmOZwiB34
        OrZts03h47hXpFlKjEdfRs4=
X-Google-Smtp-Source: AG47ELts4ieh3R6bMz3mxopnOlX4YZ46BBJM24PvHhG8jB2PYDjqVjkcxdc6zmdqRbX5sDK52VcVPQ==
X-Received: by 10.46.21.86 with SMTP id 22mr3721312ljv.24.1521295850825;
        Sat, 17 Mar 2018 07:10:50 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f7-v6sm625648lfb.2.2018.03.17.07.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 07:10:50 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v5 04/11] pack-objects: use bitfield for object_entry::depth
Date:   Sat, 17 Mar 2018 15:10:26 +0100
Message-Id: <20180317141033.21545-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.347.gf9cf61673a
In-Reply-To: <20180317141033.21545-1-pclouds@gmail.com>
References: <20180316183200.31014-1-pclouds@gmail.com>
 <20180317141033.21545-1-pclouds@gmail.com>
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
 builtin/pack-objects.c             | 4 ++++
 pack-objects.h                     | 5 ++---
 5 files changed, 13 insertions(+), 5 deletions(-)

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
index 83f8154865..829c80ffcc 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3068,6 +3068,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (pack_to_stdout != !base_name || argc)
 		usage_with_options(pack_usage, pack_objects_options);
 
+	if (depth >= (1 << OE_DEPTH_BITS))
+		die(_("delta chain depth %d is greater than maximum limit %d"),
+		    depth, (1 << OE_DEPTH_BITS));
+
 	argv_array_push(&rp, "pack-objects");
 	if (thin) {
 		use_internal_rev_list = 1;
diff --git a/pack-objects.h b/pack-objects.h
index 4c6b73a4d6..a4d8d29c04 100644
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
2.17.0.rc0.347.gf9cf61673a

