Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 434241F424
	for <e@80x24.org>; Tue, 19 Dec 2017 00:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966065AbdLSA3v (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 19:29:51 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46494 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934385AbdLSA3m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 19:29:42 -0500
Received: by mail-pg0-f65.google.com with SMTP id b11so9842534pgu.13
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 16:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=/E3ZLD6ZzIzBiYu/5xhSUDnJcZbk24ORSoevmQfnsyQ=;
        b=YBiALlJxOLGUrHY+EsD13vxp4nyy8H4JMa2+ghG6/1Hfxj9ZepUmR/vqDzv3G2foen
         3TiP74RBw+NuyntrtfBEbpqXifC/LiFUFrbc9zCncunLDEMok60dZodtjHc8HEWGsuEr
         Mh//60mcNdaEqosjo1iXBofLJkmUWICnJ6iEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/E3ZLD6ZzIzBiYu/5xhSUDnJcZbk24ORSoevmQfnsyQ=;
        b=MqBILN+YLX4hqBGmWj87eyAfwD7+uUc3EX6XwxycV7e8f/X8PQZk3/02MgR/T1fxOi
         Dq9rBWUl/B+oR9FTqwz/iFAa9LuWPuGI3EZ10cU4eQ0VDNFIgul1SuD4BldQOLzTqT86
         86EIhFShuzwkCxlJPeoaim75NONX4wxIFhqsdw3tIjldouvdXV3Ojdb5Pr89NrBDz+Ya
         jgId3165HD/8UJz+qmpdXxxg/kAk0ZV5MgHuZVwvcUgjdMXbJIPqF8B0Wk7nmKJAO/SJ
         StMwgzz+VPBmE9jO/QEpFNO6L7iDaKbboMISF4SvCC/Q2YrOLgxHKRiXT2py08PDyrxD
         QlGQ==
X-Gm-Message-State: AKGB3mJXhztkx8t7o/+vq/Ti/Di+q5Kgv1HLNn1oaZS98/4A3s8pD1IX
        rtyaqEeeuj9ELX3+W79l8wbZZVaSu/s=
X-Google-Smtp-Source: ACJfBouG67F7DBaOE4n3hiMqSbGptgdpg9gcorbO3ktUqLv/7sa9Yi1EmQu/u21EmHnfEh7gyb9vMQ==
X-Received: by 10.99.108.70 with SMTP id h67mr1274782pgc.218.1513643380744;
        Mon, 18 Dec 2017 16:29:40 -0800 (PST)
Received: from alexmv-linux.corp.dropbox.com (v160-sfo11-br01.corp.dropbox.com. [205.189.0.163])
        by smtp.gmail.com with ESMTPSA id b10sm26056581pfj.20.2017.12.18.16.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Dec 2017 16:29:39 -0800 (PST)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH 6/6] fsmonitor: Use fsmonitor data in `git diff`
Date:   Mon, 18 Dec 2017 16:28:58 -0800
Message-Id: <564465f82fc637c10af1fa6531a143a029555580.1513642743.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.1.626.gc4617b774
In-Reply-To: <20171219002858.22214-1-alexmv@dropbox.com>
References: <20171219002858.22214-1-alexmv@dropbox.com>
In-Reply-To: <95804e03dec9bd9d1a28ab92ed4356c37950468f.1513642743.git.alexmv@dropbox.com>
References: <95804e03dec9bd9d1a28ab92ed4356c37950468f.1513642743.git.alexmv@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With fsmonitor enabled, the first call to match_stat_with_submodule
calls refresh_fsmonitor, incurring the overhead of reading the list of
updated files -- but run_diff_files does not respect the
CE_FSMONITOR_VALID flag.

Make use of the fsmonitor extension to skip lstat() calls on files
that fsmonitor judged as unmodified.  Skip use of the fsmonitor
extension when called by "add", as the format_callback in such cases
expects to be called even when the file is believed to be "up to date"
with the index.

Notably, this change improves performance of the git shell prompt when
GIT_PS1_SHOWDIRTYSTATE is set.

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
---
 builtin/add.c | 2 +-
 diff-lib.c    | 6 ++++++
 diff.h        | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index bf01d89e2..bba20b46e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -119,7 +119,7 @@ int add_files_to_cache(const char *prefix,
 	rev.diffopt.format_callback_data = &data;
 	rev.diffopt.flags.override_submodule_config = 1;
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
-	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
+	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED | DIFF_SKIP_FSMONITOR);
 	clear_pathspec(&rev.prune_data);
 	return !!data.add_errors;
 }
diff --git a/diff-lib.c b/diff-lib.c
index 8104603a3..13ff00d81 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -95,6 +95,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 
 	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
 
+	if (!(option & DIFF_SKIP_FSMONITOR))
+		refresh_fsmonitor(&the_index);
+
 	if (diff_unmerged_stage < 0)
 		diff_unmerged_stage = 2;
 	entries = active_nr;
@@ -197,6 +200,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		if (ce_uptodate(ce) || ce_skip_worktree(ce))
 			continue;
 
+		if (ce->ce_flags & CE_FSMONITOR_VALID && !(option & DIFF_SKIP_FSMONITOR))
+			continue;
+
 		/* If CE_VALID is set, don't look at workdir for file removal */
 		if (ce->ce_flags & CE_VALID) {
 			changed = 0;
diff --git a/diff.h b/diff.h
index 36a09624f..1060bc495 100644
--- a/diff.h
+++ b/diff.h
@@ -395,6 +395,8 @@ extern const char *diff_aligned_abbrev(const struct object_id *sha1, int);
 #define DIFF_SILENT_ON_REMOVED 01
 /* report racily-clean paths as modified */
 #define DIFF_RACY_IS_MODIFIED 02
+/* skip loading the fsmonitor data */
+#define DIFF_SKIP_FSMONITOR 04
 extern int run_diff_files(struct rev_info *revs, unsigned int option);
 extern int run_diff_index(struct rev_info *revs, int cached);
 
-- 
2.15.1.626.gc4617b774

