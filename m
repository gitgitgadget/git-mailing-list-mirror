Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 222AD1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732467AbeGLTvr (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:51:47 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36258 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732460AbeGLTvq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:51:46 -0400
Received: by mail-qt0-f193.google.com with SMTP id f1-v6so25170004qti.3
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uQufzFoWJkMNGAA8+mMwOK3FWkWI2TF96soL345caWM=;
        b=l1mSzPQLPOfMtZbbPIS5odE09tGqQRfnuNeFwoo8rYr91jygODCdJwnjj2EuMWLNKB
         vgPsreeo1y1CiNG4FDE64/8aHteMkyjrxeH/cqAaUg5FeUx+AU22N3NDQWO0PY7XRzCm
         1X9wBc7uVJdcpM/zpRG2nDHO9kG+bWtsm/9NIWeIT8Kjvxdc9edmnqh2Nhmr+Y0iS9yV
         92Kw3bg2I+D5kWelxnBcPhbC8FmsOx1ovQUyyZpwvv1B4CFWHns8ILhh2cD4E+3W65tw
         jjHj+92n3Sqb5BDM/ronihXgtVUT/sgCKcuwwGcYUvAKnIZCQ32brac4rvNa8v2V3Jgx
         V+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uQufzFoWJkMNGAA8+mMwOK3FWkWI2TF96soL345caWM=;
        b=GyeLpaHIzRuh66GnG2syJacpxjguZodWDJWFEtEXkdWYHAiJREytPdNmq5+Qxs9poJ
         w0uQX6uoNuS0sS8mWD0En7e+ttsWP2qAYLs2Fq7logW9UQguzokn5arL+k+i8lpeitux
         d/o0InQTZ+psq+pZ+faM/10boTgYw40NaL8N8zjlVvQQVOOGsHgSS9t++D0ram9aA6Dr
         wpBB2Y4qWSehlbXgFZOiD85FivSaRjmxAKk3H0xthTYi2Zl3wd1QsdGBhcbVGW8vSzsE
         sBtHe4YlH85zg6t0sd9m9/8CVI1xnEN7v9iLyCals4C/m+ZBXAwCK4GdWJEEGmO29ffn
         Bnqg==
X-Gm-Message-State: AOUpUlEYEM/E3cVnnQ68zP6/Vo95+jp2S/OTUQitkmlYRp5H0Vfluvgn
        XIqihpiPo1BLBsYAlXtR+tkvpwWWyjE=
X-Google-Smtp-Source: AAOMgpfD4aQgVYcdactZyzs9tHx/m3BDOFuha3F6g5iIybdtq8PQ1/h769/YyDtvZHLBQz4LzkqNsA==
X-Received: by 2002:a0c:d4a9:: with SMTP id u38-v6mr3923275qvh.112.1531424446241;
        Thu, 12 Jul 2018 12:40:46 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id j5-v6sm14247756qte.57.2018.07.12.12.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 12:40:45 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, dstolee@microsoft.com
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v4 23/23] midx: clear midx on repack
Date:   Thu, 12 Jul 2018 15:39:40 -0400
Message-Id: <20180712193940.21065-24-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180712193940.21065-1-dstolee@microsoft.com>
References: <20180706005321.124643-1-dstolee@microsoft.com>
 <20180712193940.21065-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a 'git repack' command replaces existing packfiles, then we must
clear the existing multi-pack-index before moving the packfiles it
references.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/repack.c            |  9 +++++++++
 midx.c                      | 12 ++++++++++++
 midx.h                      |  1 +
 t/t5319-multi-pack-index.sh |  9 +++++++++
 4 files changed, 31 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index 6c636e159e..7f7cdc8b17 100644
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
@@ -333,6 +335,13 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	for_each_string_list_item(item, &names) {
 		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
 			char *fname, *fname_old;
+
+			if (!midx_cleared) {
+				/* if we move a packfile, it will invalidated the midx */
+				clear_midx_file(get_object_directory());
+				midx_cleared = 1;
+			}
+
 			fname = mkpathdup("%s/pack-%s%s", packdir,
 						item->string, exts[ext].name);
 			if (!file_exists(fname)) {
diff --git a/midx.c b/midx.c
index bf2334acc6..19b7df338e 100644
--- a/midx.c
+++ b/midx.c
@@ -904,3 +904,15 @@ int write_midx_file(const char *object_dir)
 	free(midx_name);
 	return 0;
 }
+
+void clear_midx_file(const char *object_dir)
+{
+	char *midx = get_midx_filename(object_dir);
+
+	if (remove_path(midx)) {
+		UNLEAK(midx);
+		die(_("failed to clear multi-pack-index at %s"), midx);
+	}
+
+	free(midx);
+}
diff --git a/midx.h b/midx.h
index d4cde99473..e3b07f1586 100644
--- a/midx.h
+++ b/midx.h
@@ -39,5 +39,6 @@ int midx_contains_pack(struct multi_pack_index *m, const char *idx_name);
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir);
 
 int write_midx_file(const char *object_dir);
+void clear_midx_file(const char *object_dir);
 
 #endif
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 601e28a2f0..5ad6614465 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -141,6 +141,15 @@ test_expect_success 'write midx with twelve packs' '
 
 compare_results_with_midx "twelve packs"
 
+test_expect_success 'repack removes multi-pack-index' '
+	test_path_is_file $objdir/pack/multi-pack-index &&
+	git repack -adf &&
+	test_path_is_missing $objdir/pack/multi-pack-index
+'
+
+compare_results_with_midx "after repack"
+
+
 # usage: corrupt_data <file> <pos> [<data>]
 corrupt_data () {
 	file=$1
-- 
2.18.0.118.gd4f65b8d14

