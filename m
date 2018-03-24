Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF4B41FAE2
	for <e@80x24.org>; Sat, 24 Mar 2018 06:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751777AbeCXGeW (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 02:34:22 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45057 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbeCXGeM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 02:34:12 -0400
Received: by mail-lf0-f67.google.com with SMTP id l4-v6so16932307lfg.12
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 23:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x0HlUkIbhXxhdyUpXfN2LDMc7FHQH3g5yvkX25DRE3E=;
        b=LhD2+5XoGWp3cNAfYsc/9IXpc7boH95ZN8SFFvmxFVe3EgwYV2wr4lOhQprC4PYTmP
         Z/vgn51C4qxSMwiMTjFWiB40JlY0gz63n60bVuIacEpfyjrnyJ46ZClL0SGyzHNyUL2Y
         GRZ7ShE4ADdyFrVjaSgdaSfUrINwVf+Y9chSjTXmXg7jFo0SEaN+p33L+riIiw7T4sJb
         O8hLuHoTLAt35ZtATsqkYuFZY3DPk3e3ZHpAr3CoGUc8QCHoJcF0NC91oibDl+CNFnmK
         91k6ZwB91i5nUB9FI55Fv6F7NbwrE0ajlSqwBuH1pXtPO6okkeWeESYZZxYccrxG2yai
         5ohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x0HlUkIbhXxhdyUpXfN2LDMc7FHQH3g5yvkX25DRE3E=;
        b=j066B4WFYyDAp1MqEyKPx8defQDYQ0PJlQ+ejKX5Y76PFyyo95Ecr1/bjXTd0CV7iD
         yx5ipU9EwmofddDJ6sFmK3v2NS60Yk/0hnE3caJo7Oo1SuG9w5L8/U6rJkJkNrBxmzld
         fEjeETO3F9gxyoMSDEQrrD5DmHrUZXPJKSkhlleliUXUOkDkNY1SjODD7WCDYB8XDxme
         TTW740JOyypTToZ3C0MRfk+0iiT5UCI7wGR805E676EOxGWyWoeqm1/vGj2hS8JgJJig
         xd9YpzZA4mdc3NYqBLm15KlGsNWCNVmcobFFkQcLOabzILDbO7qHYJjmKsXjCBZ9VvI4
         LkEQ==
X-Gm-Message-State: AElRT7FyL9WhUcRI9cNsaUA1gpb8pttmzWIh+qtKPDttXrdPy77Dcfy8
        Ydf0PdCCCCVzjRkJKDiMmvw=
X-Google-Smtp-Source: AG47ELtaNyMgyZ1X/F4KZ3YVz2m9txs8kSnpuBw5Qmyl1+WThP1E1AnAe9yr4A4hTon/dwb2wxYxRw==
X-Received: by 2002:a19:8d93:: with SMTP id p141-v6mr21049540lfd.24.1521873251112;
        Fri, 23 Mar 2018 23:34:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h8sm2251703lja.41.2018.03.23.23.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 23:34:10 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v7 04/13] pack-objects: use bitfield for object_entry::depth
Date:   Sat, 24 Mar 2018 07:33:44 +0100
Message-Id: <20180324063353.24722-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324063353.24722-1-pclouds@gmail.com>
References: <20180318142526.9378-1-pclouds@gmail.com>
 <20180324063353.24722-1-pclouds@gmail.com>
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
index 83f8154865..205e1f646c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3068,6 +3068,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (pack_to_stdout != !base_name || argc)
 		usage_with_options(pack_usage, pack_objects_options);
 
+	if (depth >= (1 << OE_DEPTH_BITS))
+		die(_("delta chain depth %d is greater than maximum limit %d"),
+		    depth, (1 << OE_DEPTH_BITS) - 1);
+
 	argv_array_push(&rp, "pack-objects");
 	if (thin) {
 		use_internal_rev_list = 1;
diff --git a/pack-objects.h b/pack-objects.h
index 8507e1b869..59407aae3c 100644
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
2.17.0.rc0.348.gd5a49e0b6f

