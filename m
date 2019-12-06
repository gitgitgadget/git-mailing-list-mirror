Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8E1C2BD09
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 16:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F07206DF
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 16:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMwTdq7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfLFQIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:08:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46141 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfLFQIg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 11:08:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so8277459wrl.13
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 08:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=gxbWZ+1ZWkEp150t9d3q1/aGZxiFuyXJ5oXrQYsQaIs=;
        b=HMwTdq7Vv51j7Ssge5GkqQPsCDvB6LG6pxMjtWiw4Faqqrp0HvSdLiJ5J3t3SEatE+
         IW2MTPZX2evR/++VJeJ/lSOWEuadg2y6O8n7UEsrL8jqvtpvkMrjfEdeustZfflRknkA
         PIJllwCZyZLW7N7zr1sCwAOjP4hZ7fCDT4G1ELorBsvKhbP6KF/ox8HiOfSnnXz6+yix
         MTtDmThqFxYc8yhWxbT9GN+0z3xAzkcVJaJjPN636Czw4RdYg6plxaaCeJZ/45G4WL8B
         lTM6jKCNzpXqrRD+rV5Pequm5VVhnpiBIca/6zUqumtBuk8ny0oBWivuzP+s7e2DAUXU
         epdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=gxbWZ+1ZWkEp150t9d3q1/aGZxiFuyXJ5oXrQYsQaIs=;
        b=M4r99KVf9fRDDStJwwjZnutPjK2luGlcME9L3nRVBmmFSBY1okxmgA4vPcu+3ieffd
         hGCryElGcbaB2OW+VEKawos6GLWGd3GwM5gHvrQMOao0E5sfEKjr5nbx1kk6t7yqPtpk
         ORhtpcJLBnFmirRIrJJqH5chc5QlMPoiJJvSWZ6GHS2llgbXeyvNnP5G19g+gsv2c5WA
         JajhTbsRT/rPBY6devmzEKxd12l7ZB60EkAhU/6iFa0Jr2549deuabhF6LQ3JS0ccvpb
         D2PcrnoaZiIP2Z85L5Pp/mrS7av4/k0py9zNWWK8/5UKbylNc7nmxd44opTEsQLi+zs1
         LDbw==
X-Gm-Message-State: APjAAAU9Ov9NtoT51YS2uhE08X6rhBGExs87TCOGT+y4HLtN5+5PWxQY
        v06n0Wouggb4IvD+99rcLY2ofJab
X-Google-Smtp-Source: APXvYqzQaLScLrPSuesrlng+yADA3QNToV9+aqBq7WoW5r7N5ujYYKbAAj73uQfInlpdZ9EFuXf06A==
X-Received: by 2002:a5d:53d1:: with SMTP id a17mr15961434wrw.327.1575648514932;
        Fri, 06 Dec 2019 08:08:34 -0800 (PST)
Received: from localhost.localdomain (host-92-22-0-192.as13285.net. [92.22.0.192])
        by smtp.gmail.com with ESMTPSA id q15sm16649799wrr.11.2019.12.06.08.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 08:08:34 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 5/9] commit: use enum value for multiple cherry-picks
Date:   Fri,  6 Dec 2019 16:06:10 +0000
Message-Id: <20191206160614.631724-6-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191206160614.631724-1-phillip.wood123@gmail.com>
References: <pull.417.git.1571787022.gitgitgadget@gmail.com>
 <20191206160614.631724-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add FROM_CHERRY_PICK_MULTI for a sequence of cherry-picks rather than
using a separate variable.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/commit.c | 25 +++++++++++--------------
 wt-status.h      |  9 ++++++++-
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d85e0ad560..3b463522be 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -122,7 +122,6 @@ static enum commit_msg_cleanup_mode cleanup_mode;
 static const char *cleanup_arg;
 
 static enum commit_whence whence;
-static int sequencer_in_use;
 static int use_editor = 1, include_status = 1;
 static int have_option_m;
 static struct strbuf message = STRBUF_INIT;
@@ -179,11 +178,9 @@ static void determine_whence(struct wt_status *s)
 {
 	if (file_exists(git_path_merge_head(the_repository)))
 		whence = FROM_MERGE;
-	else if (file_exists(git_path_cherry_pick_head(the_repository))) {
-		whence = FROM_CHERRY_PICK;
-		if (file_exists(git_path_seq_dir()))
-			sequencer_in_use = 1;
-	}
+	else if (file_exists(git_path_cherry_pick_head(the_repository)))
+		whence = file_exists(git_path_seq_dir()) ?
+			FROM_CHERRY_PICK_MULTI : FROM_CHERRY_PICK_SINGLE;
 	else
 		whence = FROM_COMMIT;
 	if (s)
@@ -453,7 +450,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	if (whence != FROM_COMMIT) {
 		if (whence == FROM_MERGE)
 			die(_("cannot do a partial commit during a merge."));
-		else if (whence == FROM_CHERRY_PICK)
+		else if (is_from_cherry_pick(whence))
 			die(_("cannot do a partial commit during a cherry-pick."));
 	}
 
@@ -771,7 +768,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	 */
 	else if (whence == FROM_MERGE)
 		hook_arg1 = "merge";
-	else if (whence == FROM_CHERRY_PICK) {
+	else if (is_from_cherry_pick(whence)) {
 		hook_arg1 = "commit";
 		hook_arg2 = "CHERRY_PICK_HEAD";
 	}
@@ -948,9 +945,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		run_status(stdout, index_file, prefix, 0, s);
 		if (amend)
 			fputs(_(empty_amend_advice), stderr);
-		else if (whence == FROM_CHERRY_PICK) {
+		else if (is_from_cherry_pick(whence)) {
 			fputs(_(empty_cherry_pick_advice), stderr);
-			if (!sequencer_in_use)
+			if (whence == FROM_CHERRY_PICK_SINGLE)
 				fputs(_(empty_cherry_pick_advice_single), stderr);
 			else
 				fputs(_(empty_cherry_pick_advice_multi), stderr);
@@ -1143,7 +1140,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (amend && whence != FROM_COMMIT) {
 		if (whence == FROM_MERGE)
 			die(_("You are in the middle of a merge -- cannot amend."));
-		else if (whence == FROM_CHERRY_PICK)
+		else if (is_from_cherry_pick(whence))
 			die(_("You are in the middle of a cherry-pick -- cannot amend."));
 	}
 	if (fixup_message && squash_message)
@@ -1166,7 +1163,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		use_message = edit_message;
 	if (amend && !use_message && !fixup_message)
 		use_message = "HEAD";
-	if (!use_message && whence != FROM_CHERRY_PICK && renew_authorship)
+	if (!use_message && !is_from_cherry_pick(whence) && renew_authorship)
 		die(_("--reset-author can be used only with -C, -c or --amend."));
 	if (use_message) {
 		use_message_buffer = read_commit_message(use_message);
@@ -1175,7 +1172,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 			author_message_buffer = use_message_buffer;
 		}
 	}
-	if (whence == FROM_CHERRY_PICK && !renew_authorship) {
+	if (is_from_cherry_pick(whence) && !renew_authorship) {
 		author_message = "CHERRY_PICK_HEAD";
 		author_message_buffer = read_commit_message(author_message);
 	}
@@ -1589,7 +1586,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 			reduce_heads_replace(&parents);
 	} else {
 		if (!reflog_msg)
-			reflog_msg = (whence == FROM_CHERRY_PICK)
+			reflog_msg = is_from_cherry_pick(whence)
 					? "commit (cherry-pick)"
 					: "commit";
 		commit_list_insert(current_head, &parents);
diff --git a/wt-status.h b/wt-status.h
index 64f1ddc9fd..0098fdb0b5 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -39,9 +39,16 @@ enum show_ignored_type {
 enum commit_whence {
 	FROM_COMMIT,     /* normal */
 	FROM_MERGE,      /* commit came from merge */
-	FROM_CHERRY_PICK /* commit came from cherry-pick */
+	FROM_CHERRY_PICK_SINGLE, /* commit came from cherry-pick */
+	FROM_CHERRY_PICK_MULTI /* commit came from a sequence of cherry-picks */
 };
 
+static inline int is_from_cherry_pick(enum commit_whence whence)
+{
+	return whence == FROM_CHERRY_PICK_SINGLE ||
+		whence == FROM_CHERRY_PICK_MULTI;
+}
+
 struct wt_status_change_data {
 	int worktree_status;
 	int index_status;
-- 
2.24.0

