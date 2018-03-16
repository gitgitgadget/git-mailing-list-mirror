Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FECE1FAE5
	for <e@80x24.org>; Fri, 16 Mar 2018 18:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbeCPScw (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 14:32:52 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33344 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752284AbeCPSct (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 14:32:49 -0400
Received: by mail-lf0-f65.google.com with SMTP id x205-v6so16756731lfa.0
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Lsdzb7g2t6Xz6GFw0t791o/NlTec2GUvRN8aaabOGg=;
        b=P8ixOfGYx6YTZ8pAAN+gFc3/9qYj6OAkZkwfhrd5RqsHVJzyIth0H6PohL5S8reHxz
         /sJ2stRVu+lUAXFd38mAGIqCA8k+W6CNiqTio9B8LML2ifJoAMXUagHkEF6IP9n3hG7e
         wGRxgWexGrE3r00NXS6+4yR9GdRa3rGiSryEitFOXo3sIkVHbVapp9gtIkckb7AMT/Qb
         ArKvbWTRpyCCYULlgaONJrAP0Oi4/kWEXhhAD4I140cSj5hFhLnQ13vBk5qSxcJGsErn
         AdSAfjMYyssgI5V0g2fQwUZu8Qjx4ARz9P799NI/BXu06iT98pdLJcGLHh6ISAHPu/+l
         EWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Lsdzb7g2t6Xz6GFw0t791o/NlTec2GUvRN8aaabOGg=;
        b=mSbudYc+JRCdBajKZzcbhyyLVNxVUsEHpKJuMs6TOr79BJCXwHXChKK51TIM970O8E
         eB33Tmwr+CV5g+qNalWYmUVDHYvUzcBbhOVG43kyW60QcPs3EUD6i+TT9KeTjBw0FKsA
         Ovyp8pndO/9SRK1sVpAymFaiB5qABOpLQE4vpAE8j18HDIKS0132D2kqlLv44KgCTz27
         H31RkGPDquqD1oWqFlTplqVc9+V6GzqEZO5JGPP+dHVlN3W8YMNk3iAqAVdQkyMT+w7z
         niV/Ttq2CJI0iKk0iGHcZOiAUZJcyIGt4zYykL1YlikySZNgtyihuXSNas2bOt9KYrif
         ztYQ==
X-Gm-Message-State: AElRT7FJxu5SmsY/6+6xZ0Rn3+02BPTD2FdDpsctLAK5sDYf1BWRjMit
        mThqGX7k7O59KQ5/8YSaCW+fcw==
X-Google-Smtp-Source: AG47ELtVg9ilR/4/i9+u9roOWXlPI4ZLe+DI5FDc01cT0qOEb2bX7Ii0qr5FH5d2gjpTaoNL/yVqZg==
X-Received: by 2002:a19:5c84:: with SMTP id u4-v6mr2076351lfi.14.1521225167392;
        Fri, 16 Mar 2018 11:32:47 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j199-v6sm1033275lfe.53.2018.03.16.11.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Mar 2018 11:32:46 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v4 04/11] pack-objects: use bitfield for object_entry::depth
Date:   Fri, 16 Mar 2018 19:31:53 +0100
Message-Id: <20180316183200.31014-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180316183200.31014-1-pclouds@gmail.com>
References: <20180308114232.10508-1-pclouds@gmail.com>
 <20180316183200.31014-1-pclouds@gmail.com>
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
index 09f8b4ef3e..668eaf8cd7 100644
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
index 2bb1732098..50908d1f2d 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -2,6 +2,7 @@
 #define PACK_OBJECTS_H
 
 #define OE_DFS_STATE_BITS	2
+#define OE_DEPTH_BITS		12
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -88,9 +89,7 @@ struct object_entry {
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
2.16.2.903.gd04caf5039

