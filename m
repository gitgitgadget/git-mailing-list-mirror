Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCBBB1FEB3
	for <e@80x24.org>; Tue, 10 Jan 2017 01:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032135AbdAJBp4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 20:45:56 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33638 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936775AbdAJBpy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 20:45:54 -0500
Received: by mail-pf0-f181.google.com with SMTP id y143so16258176pfb.0
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 17:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GbEV3uJOsEjCfv1WPTp+Vx+t8oECnj2+TQggeWN3iVI=;
        b=GugjJkm/fVdgn9ZcloS2cCLpJBaR2XI5FLv6RGDQQf2YeUbehzKGj+64vnd2/t+NBL
         bbXnlWr6cdY01MI1BG5mQk5NBEDPQWiM/aKvuxB5ODBC9yuIacfCDrah3+YacPMW4C6G
         Dok+pk5eM+n8c8u5bMcGWkKtT95yDuxD1I3t4XPTCMyayLCIn6DZjRnWmWMPdJdWjs+h
         dhC3Ah7ZH3k4Bt86nZcricDebY4dWO/9BRP8H+BpCQMqoVBDQ1eKWKBdtJPySDxfveDT
         jZx9z7R3zlKopBKVT+SAoe5ym0hZ7Moxvbb6eOxaRAHkyJMZ2EAKTmh5y010d56j/O9U
         X79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GbEV3uJOsEjCfv1WPTp+Vx+t8oECnj2+TQggeWN3iVI=;
        b=hwyNltMCyWBkw7pZsv32NB1VLxxXNOu6J02bpSyf8HPb5mcxbDoluS68QLWTDXhg+i
         pEcXkUy/c9qF3IMGUNiQ/o+ibcSZoW//BfYBfLuvy5zBpUA11mpTqJQ2Zd9iMEaJlZgq
         CFK81vfuPnzylj3MZAxJl5HrJhPv+VZb5TanORQGvIMFPAbwovlX/hsIXCdSexWlWDCC
         iPRPgc7QDtDfrrcqsMh1oosCevPQear7X9s0BLTo7W90+XBL1MGJHRKuSu/X3ORbY4QJ
         MyIQBH+6E+s5pqWBCw3XyR3x2oOJhG2IS8ZDGOlGsrm655nPa2pyOcCbQFptoF3lDXzs
         l0rQ==
X-Gm-Message-State: AIkVDXLMYsshnnl6OpV+qaoe8HkGOxsA2eT+ZsYdpYLWjqxreynFZ/RyEFfEqcBf5alk4E2l
X-Received: by 10.99.38.3 with SMTP id m3mr871429pgm.113.1484012753576;
        Mon, 09 Jan 2017 17:45:53 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1e2:be00:4066:92e5])
        by smtp.gmail.com with ESMTPSA id d124sm379980pga.30.2017.01.09.17.45.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Jan 2017 17:45:53 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, novalis@novalis.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/4] read-tree: use OPT_BOOL instead of OPT_SET_INT
Date:   Mon,  9 Jan 2017 17:45:39 -0800
Message-Id: <20170110014542.19352-2-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.30.g7c4be45.dirty
In-Reply-To: <20170110014542.19352-1-sbeller@google.com>
References: <20170110014542.19352-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All occurrences of OPT_SET_INT were setting the value to 1;
internally OPT_BOOL is just that.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/read-tree.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index fa6edb35b2..8ba64bc785 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -109,34 +109,34 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		{ OPTION_CALLBACK, 0, "index-output", NULL, N_("file"),
 		  N_("write resulting index to <file>"),
 		  PARSE_OPT_NONEG, index_output_cb },
-		OPT_SET_INT(0, "empty", &read_empty,
-			    N_("only empty the index"), 1),
+		OPT_BOOL(0, "empty", &read_empty,
+			    N_("only empty the index")),
 		OPT__VERBOSE(&opts.verbose_update, N_("be verbose")),
 		OPT_GROUP(N_("Merging")),
-		OPT_SET_INT('m', NULL, &opts.merge,
-			    N_("perform a merge in addition to a read"), 1),
-		OPT_SET_INT(0, "trivial", &opts.trivial_merges_only,
-			    N_("3-way merge if no file level merging required"), 1),
-		OPT_SET_INT(0, "aggressive", &opts.aggressive,
-			    N_("3-way merge in presence of adds and removes"), 1),
-		OPT_SET_INT(0, "reset", &opts.reset,
-			    N_("same as -m, but discard unmerged entries"), 1),
+		OPT_BOOL('m', NULL, &opts.merge,
+			 N_("perform a merge in addition to a read")),
+		OPT_BOOL(0, "trivial", &opts.trivial_merges_only,
+			 N_("3-way merge if no file level merging required")),
+		OPT_BOOL(0, "aggressive", &opts.aggressive,
+			 N_("3-way merge in presence of adds and removes")),
+		OPT_BOOL(0, "reset", &opts.reset,
+			 N_("same as -m, but discard unmerged entries")),
 		{ OPTION_STRING, 0, "prefix", &opts.prefix, N_("<subdirectory>/"),
 		  N_("read the tree into the index under <subdirectory>/"),
 		  PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP },
-		OPT_SET_INT('u', NULL, &opts.update,
-			    N_("update working tree with merge result"), 1),
+		OPT_BOOL('u', NULL, &opts.update,
+			 N_("update working tree with merge result")),
 		{ OPTION_CALLBACK, 0, "exclude-per-directory", &opts,
 		  N_("gitignore"),
 		  N_("allow explicitly ignored files to be overwritten"),
 		  PARSE_OPT_NONEG, exclude_per_directory_cb },
-		OPT_SET_INT('i', NULL, &opts.index_only,
-			    N_("don't check the working tree after merging"), 1),
+		OPT_BOOL('i', NULL, &opts.index_only,
+			 N_("don't check the working tree after merging")),
 		OPT__DRY_RUN(&opts.dry_run, N_("don't update the index or the work tree")),
-		OPT_SET_INT(0, "no-sparse-checkout", &opts.skip_sparse_checkout,
-			    N_("skip applying sparse checkout filter"), 1),
-		OPT_SET_INT(0, "debug-unpack", &opts.debug_unpack,
-			    N_("debug unpack-trees"), 1),
+		OPT_BOOL(0, "no-sparse-checkout", &opts.skip_sparse_checkout,
+			 N_("skip applying sparse checkout filter")),
+		OPT_BOOL(0, "debug-unpack", &opts.debug_unpack,
+			 N_("debug unpack-trees")),
 		OPT_END()
 	};
 
-- 
2.11.0.rc2.30.g7c4be45.dirty

