Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15AE8208E9
	for <e@80x24.org>; Sun,  5 Aug 2018 17:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbeHETbI (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 15:31:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37817 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeHETbH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 15:31:07 -0400
Received: by mail-wm0-f66.google.com with SMTP id n11-v6so11775628wmc.2
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 10:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QZau/M0R+BLIRKXinvIbFQ8zgfzwOSW/V4VFlwji630=;
        b=fiUQXtsetWlsYFgGOhnDxS82/0jNfu3y0YIkjc8gJRj/j8NNExE/tWWsR+Wc4lzhq8
         ckS1aPgEVQR1Bwy1WMrqssyNMyZAZrprim+pRTAr4Rf+qF9tp1XTVL8tdqu5UW6XANfj
         0IuvfShvAOlJzGOhm01uVlYee34lx6zMHVxXzB62Li0Xyg7khti/SnJ8P+5PVHpVnxQj
         xWgi3jCoJ975J2ZzCPwUW+IX/m6mv6WBdC/FeDEbJ46xw+SstfyRp/o8IVLWAKq1CDNd
         loYEjmtzYIzbFOMy1Ai+92S9ni2kn+2m5v+l2nqMqO4zykQ3UGnEknwqx93G+zlIk2tQ
         iv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QZau/M0R+BLIRKXinvIbFQ8zgfzwOSW/V4VFlwji630=;
        b=pi9zyq4ybMFq0Vns/lJ2izC4miHH5vboJPcqoy/FDEg3EDveNaAPGAm+7uyea52ZR+
         09xt8ElfzAJNgxewFiEQ52nxBNcDisiNFYlNK43cIbK+zkjOKBbZo/4w9j3EuNzRTkS3
         +2a1UqPuf/LtzCdrrmvAhbZAjxFeAEvAcoJGVMASutXgm0Tp3Qoc67zDC9wyJ9YNRGjK
         9zg+SggdHeuG34at3z33i42F/TKmmMibhbj1xxX17NES8l0kKdYj3qvTiQDHiobbeJqO
         OirOzjBLpn1SSnD0zR+zDz746SD/JiUiDMSOUuns7KrdOv6gjIXfMQ3wD9yhydjnPpdS
         TQhQ==
X-Gm-Message-State: AOUpUlFD4Yz8HW7sz0LlIltCBa9hWSmD5nBqNk2kiguLDHjZpbM8/EVX
        0uirnhuUaG7c+STjAKpk+7euji96
X-Google-Smtp-Source: AAOMgpdnV37P6F1EwikBKp0omNqYrukvjb5/5GRDXeu/hjGTxa8gTXZAiL5Mar8zR+CooALwtxh7lw==
X-Received: by 2002:a1c:ec9d:: with SMTP id h29-v6mr10169789wmi.94.1533489948835;
        Sun, 05 Aug 2018 10:25:48 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id x62-v6sm7523228wmg.1.2018.08.05.10.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 10:25:48 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 4/6] repack: add delta-islands support
Date:   Sun,  5 Aug 2018 19:25:23 +0200
Message-Id: <20180805172525.15278-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.327.ga7d188ab43
In-Reply-To: <20180805172525.15278-1-chriscool@tuxfamily.org>
References: <20180805172525.15278-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Implement simple support for --delta-islands option and
repack.useDeltaIslands config variable in git repack.

This allows users to setup delta islands in their config and
get the benefit of less disk usage while cloning and fetching
is still quite fast and not much more CPU intensive.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt     | 4 ++++
 Documentation/git-repack.txt | 5 +++++
 builtin/repack.c             | 9 +++++++++
 3 files changed, 18 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b74a1f60f4..c41febc373 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3102,6 +3102,10 @@ repack.packKeptObjects::
 	index is being written (either via `--write-bitmap-index` or
 	`repack.writeBitmaps`).
 
+repack.useDeltaIslands::
+	If set to true, makes `git repack` act as if `--delta-islands`
+	was passed. Defaults to `false`.
+
 repack.writeBitmaps::
 	When true, git will write a bitmap index when packing all
 	objects to disk (e.g., when `git repack -a` is run).  This
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index d90e7907f4..a8b2d4722f 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -155,6 +155,11 @@ depth is 4095.
 	being removed. In addition, any unreachable loose objects will
 	be packed (and their loose counterparts removed).
 
+-i::
+--delta-islands::
+	Pass the `--delta-islands` option to `git-pack-objects`, see
+	linkgit:git-pack-objects[1].
+
 Configuration
 -------------
 
diff --git a/builtin/repack.c b/builtin/repack.c
index 6c636e159e..5ab9ee69e4 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -12,6 +12,7 @@
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
 static int write_bitmaps;
+static int use_delta_islands;
 static char *packdir, *packtmp;
 
 static const char *const git_repack_usage[] = {
@@ -40,6 +41,10 @@ static int repack_config(const char *var, const char *value, void *cb)
 		write_bitmaps = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "repack.usedeltaislands")) {
+		use_delta_islands = git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value, cb);
 }
 
@@ -194,6 +199,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("pass --local to git-pack-objects")),
 		OPT_BOOL('b', "write-bitmap-index", &write_bitmaps,
 				N_("write bitmap index")),
+		OPT_BOOL('i', "delta-islands", &use_delta_islands,
+				N_("pass --delta-islands to git-pack-objects")),
 		OPT_STRING(0, "unpack-unreachable", &unpack_unreachable, N_("approxidate"),
 				N_("with -A, do not loosen objects older than this")),
 		OPT_BOOL('k', "keep-unreachable", &keep_unreachable,
@@ -267,6 +274,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		argv_array_pushf(&cmd.args, "--no-reuse-object");
 	if (write_bitmaps)
 		argv_array_push(&cmd.args, "--write-bitmap-index");
+	if (use_delta_islands)
+		argv_array_push(&cmd.args, "--delta-islands");
 
 	if (pack_everything & ALL_INTO_ONE) {
 		get_non_kept_pack_filenames(&existing_packs, &keep_pack_list);
-- 
2.18.0.327.ga7d188ab43

