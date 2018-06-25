Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F9E61F516
	for <e@80x24.org>; Mon, 25 Jun 2018 14:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934521AbeFYOfr (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 10:35:47 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35766 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934471AbeFYOfm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 10:35:42 -0400
Received: by mail-qk0-f196.google.com with SMTP id u21-v6so2002710qku.2
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 07:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XeZIxxHffNFtGWR0PWPbz0in1gNcZE6UmK2aIFBbT/s=;
        b=JkzBBTnsZcQnSPDIaTP09p2DAGBBFMci8UJjwvc0kRhnQGz4OWXcyoyLqrp+WR/POx
         qdiMiqLsTmZ4FQ2KAfLo0Na/iSUFGb/06+SdU4PZJAcfo3v16cFFca2W3vmtsz/IzuYZ
         Qi99HdygS6hDLXK22ODgyJn40GEVQbg6fumo1G6DHfkp7ZqcjYXftewG+yNtLdFcfCv3
         S6DTQB5kS3Gk8xIKifsqCBNVQrpT1ji3qFtVUU7azbnELHcvUkhenvBwMm8Uu3lJdXfR
         IEq9jBPpe9qZSBJOz7Qprv2IpqDQcZPbQPLW3xUW10QUvhgw74+FfrmV4ifaxQmZCYGK
         +vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XeZIxxHffNFtGWR0PWPbz0in1gNcZE6UmK2aIFBbT/s=;
        b=UVRJLqm98MILk2lRx95UVotufSsovfGO4wawY4R7g2HB9Cv2PNL2N0gvM8Lhr5cCDf
         YN+6K0qFspFSVeV2vDOdQ7YzmnsqVv2/T7zd/KAhxDl6JYJf2upKgxvJlSybvCydYKOF
         HvxHM7R8C8EMv5wYoe8FrOp9THsnv1/u0HtW1yk6sA677LF/q1FgZn3kRada50UID8Yz
         nFVN5UdQO+dyp9jkheihRzoPVunsscfdWkuTjZVpdRFC10OMRw9ANW034fGkk6vM5d6C
         0Ehazw0e+m8lypBa2pjQOGcWKIlJk4ccHM67AQB8kMMsQRsEpliiFvu9CR4D8fIdsxFG
         DZKA==
X-Gm-Message-State: APt69E1d1MKUp3lsoJ5vv1B2HnPbPsR2noyHqlw8F0GauUxsRX79/kF/
        8gl5dQdxvdW7XweMEaTipQ9xF9Qr
X-Google-Smtp-Source: AAOMgpcgusS9D8PGO7IMClM676GMVMHbXcAoJwXOTj6UMoausLNr8vPnsp9haXa6p1DG1qZ9k0s1IA==
X-Received: by 2002:ae9:dd06:: with SMTP id r6-v6mr10620312qkf.417.1529937341341;
        Mon, 25 Jun 2018 07:35:41 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id w46-v6sm12821713qtw.55.2018.06.25.07.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 07:35:40 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 24/24] midx: clear midx on repack
Date:   Mon, 25 Jun 2018 10:34:34 -0400
Message-Id: <20180625143434.89044-25-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180625143434.89044-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180625143434.89044-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a 'git repack' command replaces existing packfiles, then we must
clear the existing multi-pack-index before moving the packfiles it
references.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/repack.c | 8 ++++++++
 midx.c           | 8 ++++++++
 midx.h           | 1 +
 3 files changed, 17 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index 6c636e159e..66a7d8e8ea 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -8,6 +8,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "argv-array.h"
+#include "midx.h"
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
@@ -174,6 +175,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int no_update_server_info = 0;
 	int quiet = 0;
 	int local = 0;
+	int midx_cleared = 0;
 
 	struct option builtin_repack_options[] = {
 		OPT_BIT('a', NULL, &pack_everything,
@@ -340,6 +342,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 
+			if (!midx_cleared) {
+				/* if we move a packfile, it will invalidated the midx */
+				clear_midx_file(get_object_directory());
+				midx_cleared = 1;
+			}
+
 			fname_old = mkpathdup("%s/old-%s%s", packdir,
 						item->string, exts[ext].name);
 			if (file_exists(fname_old))
diff --git a/midx.c b/midx.c
index 02cbfc5bd5..ef9fb38610 100644
--- a/midx.c
+++ b/midx.c
@@ -890,3 +890,11 @@ int write_midx_file(const char *object_dir)
 	FREE_AND_NULL(pack_perm);
 	return 0;
 }
+
+void clear_midx_file(const char *object_dir)
+{
+	char *midx = get_midx_filename(object_dir);
+
+	if (remove_path(midx))
+		die(_("failed to clear multi-pack-index at %s"), midx);
+}
diff --git a/midx.h b/midx.h
index 5faffb7bc6..5a42cbed1d 100644
--- a/midx.h
+++ b/midx.h
@@ -15,5 +15,6 @@ int midx_contains_pack(struct multi_pack_index *m, const char *idx_name);
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir);
 
 int write_midx_file(const char *object_dir);
+void clear_midx_file(const char *object_dir);
 
 #endif
-- 
2.18.0.24.g1b579a2ee9

