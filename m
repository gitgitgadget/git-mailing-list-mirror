Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72E451F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeIZEoc (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:44:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36045 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbeIZEoa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:44:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id f4-v6so200766edq.3
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cxPcb7E/udRc8Kanr0MZhQ2pNHj3YeYyatVYRdoZRBs=;
        b=uG3ERwruPKqUsAoGImW8GPJ6WW6J8sSJJOW7d6jt04c2O4rD7p2Juo+0+46jY9Ud/V
         g88ersyOkSZWcvshU91BewRDNB9/vFX3ds1cvZB0i9WoSeebeZpY0N9UenkSpX8fmqTa
         gDSh+7cMqhngbM0kM3IeNHPls38QSGZkMm1EDThOQXs/D4CKOOP8WliyfrbaWbmwdsCt
         RdI2pOsuHnPJbXh2RkYRjqtK1oJS7MjcmhnRa+dXMGqBkhDxeSwibhTu+R7AxRBT0OQb
         m/loerRBNY1gJy3RJEkBgx/fdi9n69yUHEJ9GU4q+AABMaXg8KcTtY2cabkkD8ouQkG1
         N+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cxPcb7E/udRc8Kanr0MZhQ2pNHj3YeYyatVYRdoZRBs=;
        b=dsWFEnuDiLWMqXihkCVICEblNK8IsUd57viZjj1wScF/I8Qdw3d7n1BMjnlVNbi8D9
         OwlbdfCdakl+J1FRRRJPbWUUB2XjjfmCwiKuU3O6dRmgCvuffyZhj1DUDMo6+PNBDbkd
         m3uHW4mQjgnVP4ODmq0WppMHEhd2Nl2Un+l/tFEtBqz95Fre9QoK9+ARtLdz9tB3yxph
         Gy4oGbC8iXgtOt8IUXhKLK0VU9c5VT+KCEpkU7VrboWlopMtRKyATBmjmoJlZjyYRIfx
         6iaDkKY9u5Hjr+Lho7o/8AxcxOUIkbjJ1L3c7BKjm9IdcnR7M+VjbufRMa+o5aF82jf1
         SjLw==
X-Gm-Message-State: ABuFfojRzsyDJQK+SG8ymFGaJ9vghp9PSpD21zCzBeK9gYlvjv5dTXbO
        x5EMtdB5pQLKQNRu0DUF1C8x6HWV
X-Google-Smtp-Source: ACcGV63H/thGSil+LIZozhWM2TSK4KurcLsrJcZHkmVtXU0GqPfrV5kJh3DKJk/F36f3fTXBUsoy2A==
X-Received: by 2002:a50:8ea1:: with SMTP id w30-v6mr4756844edw.197.1537914883412;
        Tue, 25 Sep 2018 15:34:43 -0700 (PDT)
Received: from localhost.localdomain ([92.55.154.13])
        by smtp.gmail.com with ESMTPSA id o37-v6sm33553edo.71.2018.09.25.15.34.42
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:34:42 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v9 20/21] stash: optimize `get_untracked_files()` and `check_changes()`
Date:   Wed, 26 Sep 2018 01:33:36 +0300
Message-Id: <c5d7df39656c3404a2469bdb9e7a09fad46d3227.1537913094.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g1fb9f40d88.dirty
In-Reply-To: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
References: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commits introduces a optimization by avoiding calling the
same functions again. For example, `git stash push -u`
would call at some points the following functions:

 * `check_changes()` (inside `do_push_stash()`)
 * `do_create_stash()`, which calls: `check_changes()` and
`get_untracked_files()`

Note that `check_changes()` also calls `get_untracked_files()`.
So, `check_changes()` is called 2 times and `get_untracked_files()`
3 times.

The old function `check_changes()` now consists of two functions:
`get_untracked_files()` and `check_changes_tracked_files()`.

These are the call chains for `push` and `create`:

 * `push_stash()` -> `do_push_stash()` -> `do_create_stash()`

 * `create_stash()` -> `do_create_stash()`

To prevent calling the same functions over and over again,
`check_changes()` inside `do_create_stash()` is now placed
in the caller functions (`create_stash()` and `do_push_stash()`).
This way `check_changes()` and `get_untracked files()` are called
only one time.

https://public-inbox.org/git/20180818223329.GJ11326@hank.intra.tgummerer.com/

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash.c | 51 ++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index fc4a2050b1..43d0de1f13 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -875,19 +875,18 @@ static int get_untracked_files(struct pathspec ps, int include_untracked,
 }
 
 /*
- * The return value of `check_changes()` can be:
+ * The return value of `check_changes_tracked_files()` can be:
  *
  * < 0 if there was an error
  * = 0 if there are no changes.
  * > 0 if there are changes.
  */
-static int check_changes(struct pathspec ps, int include_untracked)
+
+static int check_changes_tracked_files(struct pathspec ps)
 {
 	int result;
-	int ret = 0;
 	struct rev_info rev;
 	struct object_id dummy;
-	struct strbuf out = STRBUF_INIT;
 
 	/* No initial commit. */
 	if (get_oid("HEAD", &dummy))
@@ -915,14 +914,26 @@ static int check_changes(struct pathspec ps, int include_untracked)
 	if (diff_result_code(&rev.diffopt, result))
 		return 1;
 
+	return 0;
+}
+
+/*
+ * The function will fill `untracked_files` with the names of untracked files
+ * It will return 1 if there were any changes and 0 if there were not.
+ */
+
+static int check_changes(struct pathspec ps, int include_untracked,
+			 struct strbuf *untracked_files)
+{
+	int ret = 0;
+	if (check_changes_tracked_files(ps))
+		ret = 1;
+
 	if (include_untracked && get_untracked_files(ps, include_untracked,
-						     &out)) {
-		strbuf_release(&out);
-		return 1;
-	}
+						     untracked_files))
+		ret = 1;
 
-	strbuf_release(&out);
-	return 0;
+	return ret;
 }
 
 static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
@@ -1131,7 +1142,7 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
 		head_commit = lookup_commit(the_repository, &info->b_commit);
 	}
 
-	if (!check_changes(ps, include_untracked)) {
+	if (!check_changes(ps, include_untracked, &untracked_files)) {
 		ret = 1;
 		*stash_msg = NULL;
 		goto done;
@@ -1157,8 +1168,7 @@ static int do_create_stash(struct pathspec ps, char **stash_msg,
 		goto done;
 	}
 
-	if (include_untracked && get_untracked_files(ps, include_untracked,
-						     &untracked_files)) {
+	if (include_untracked) {
 		if (save_untracked_files(info, &msg, untracked_files)) {
 			if (!quiet)
 				fprintf_ln(stderr, _("Cannot save the untracked files"));
@@ -1234,18 +1244,14 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 					     ++argv, ' ');
 
 	memset(&ps, 0, sizeof(ps));
-	ret = do_create_stash(ps, &stash_msg, 0, 0, &info, NULL, 0);
+	if (!check_changes_tracked_files(ps))
+		return 0;
 
-	if (!ret)
+	if (!(ret = do_create_stash(ps, &stash_msg, 0, 0, &info, NULL, 0)))
 		printf_ln("%s", oid_to_hex(&info.w_commit));
 
 	strbuf_release(&stash_msg_buf);
-
-	/*
-	 * ret can be 1 if there were no changes. In this case, we should
-	 * not error out.
-	 */
-	return ret < 0;
+	return ret;
 }
 
 static int do_push_stash(struct pathspec ps, char *stash_msg, int quiet,
@@ -1254,6 +1260,7 @@ static int do_push_stash(struct pathspec ps, char *stash_msg, int quiet,
 	int ret = 0;
 	struct stash_info info;
 	struct strbuf patch = STRBUF_INIT;
+	struct strbuf untracked_files = STRBUF_INIT;
 
 	if (patch_mode && keep_index == -1)
 		keep_index = 1;
@@ -1289,7 +1296,7 @@ static int do_push_stash(struct pathspec ps, char *stash_msg, int quiet,
 		goto done;
 	}
 
-	if (!check_changes(ps, include_untracked)) {
+	if (!check_changes(ps, include_untracked, &untracked_files)) {
 		stash_msg = NULL;
 		if (!quiet)
 			printf_ln(_("No local changes to save"));
-- 
2.19.0.rc0.23.g1fb9f40d88

