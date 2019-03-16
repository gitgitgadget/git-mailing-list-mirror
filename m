Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E87A120248
	for <e@80x24.org>; Sat, 16 Mar 2019 20:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfCPUFS (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 16:05:18 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.57]:38811 "EHLO mta1.cl.cam.ac.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbfCPUFR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 16:05:17 -0400
Received: from methi.cl.cam.ac.uk ([2001:630:212:238:fa32:e4ff:fe88:56f3])
        by mta1.cl.cam.ac.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <nwf20@cl.cam.ac.uk>)
        id 1h5FYQ-00055x-CL; Sat, 16 Mar 2019 20:05:14 +0000
Received: from nwf20 by methi.cl.cam.ac.uk with local (Exim 4.90_1)
        (envelope-from <nwf20@cl.cam.ac.uk>)
        id 1h5FYa-0003ix-5J; Sat, 16 Mar 2019 20:05:24 +0000
From:   Nathaniel Filardo <nwf20@cl.cam.ac.uk>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Nathaniel Filardo <nwf20@cl.cam.ac.uk>
Subject: [PATCHv2 5/5] builtin/gc: add --assume-pack-keep-transitive
Date:   Sat, 16 Mar 2019 20:05:20 +0000
Message-Id: <20190316200520.14260-6-nwf20@cl.cam.ac.uk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190316200520.14260-1-nwf20@cl.cam.ac.uk>
References: <20190316200520.14260-1-nwf20@cl.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just pass it on down to builtin/repack.

Signed-off-by: Nathaniel Filardo <nwf20@cl.cam.ac.uk>
---
 Documentation/git-gc.txt | 5 +++++
 builtin/gc.c             | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index a7c1b0f60e..7115564f7d 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -96,6 +96,11 @@ be performed as well.
 	`.keep` files are consolidated into a single pack. When this
 	option is used, `gc.bigPackThreshold` is ignored.
 
+--assume-pack-keep-transitive::
+	Pass the `--assume-pack-keep-transitive` option to `git-repack`;
+	see linkgit:git-repack[1].
+
+
 CONFIGURATION
 -------------
 
diff --git a/builtin/gc.c b/builtin/gc.c
index 020f725acc..b0c160abec 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -504,6 +504,7 @@ static void gc_before_repack(void)
 int cmd_gc(int argc, const char **argv, const char *prefix)
 {
 	int aggressive = 0;
+	int assume_pack_keep_transitive = 0;
 	int auto_gc = 0;
 	int quiet = 0;
 	int force = 0;
@@ -526,6 +527,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "keep-largest-pack", &keep_base_pack,
 			 N_("repack all other packs except the largest pack")),
+		OPT_BOOL(0, "assume-pack-keep-transitive", &assume_pack_keep_transitive,
+			 N_("assume kept packs reference only kept packs")),
 		OPT_END()
 	};
 
@@ -564,6 +567,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	}
 	if (quiet)
 		argv_array_push(&repack, "-q");
+	if (assume_pack_keep_transitive)
+		argv_array_push(&repack, "--assume-pack-keep-transitive");
 
 	if (auto_gc) {
 		/*
-- 
2.17.1

