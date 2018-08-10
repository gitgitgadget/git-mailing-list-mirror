Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 784B51F405
	for <e@80x24.org>; Fri, 10 Aug 2018 16:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbeHJTXS (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 15:23:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46079 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbeHJTXS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 15:23:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id f12-v6so8831827wrv.12
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 09:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3iotGxgF1Xyj8nOid2xMoCznHVviMLEYAjmlCGOeEDI=;
        b=HjnzNzpRHBUsxO20FUit079gLRgXgrPV06cwAbEmGoub/DKgrpv2gjwsMlUB3BoKjW
         jaj9DEYNyO9TfwzHqqjtzh87B7R04RDoO0pCfecxkDvZoYdX0bH6+I2SE58pPmBfLM3Z
         5BPK/F7AfcKcHdx1h/Xm4TetywHT3wK//IVvyWG/l8tpXwKcGKe3wyq+GfpF1fM/D5IH
         cKXEtXUSi5SR2tUUtUbRU0WK6pH+msDrUKpbGen92kRt1rWbOWxxOJABDP7hIFhqd9xv
         sSY0QUF0o0ambL8eDKGCW4SiDsDh5SfkD1iHtxLRBIjQ84xmpPeAsTnVfO0o/RXdHble
         1x9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3iotGxgF1Xyj8nOid2xMoCznHVviMLEYAjmlCGOeEDI=;
        b=LXxc28SUj7r986zkLYAVc2Yzx0OZnyf3r/Y3nSPcaM/dLi8uKXEba6Yup/hDZ/6H7s
         cTTjv4UBcSRXT7rN5NsA9KgBijeZbXjtKxK6SgiQxYpVSibSIF5Px14JQcbvL7dM/NHp
         oYxoVP/OwdmVeeUzZ4ewMLJcPD2FlBK6vFZtWSBtlvM8tYyHL23wvtXZTsVhA7Q1Djan
         moSecbYuPseAcBSrHEHry+DfHDJdrDq5SpC+xNlSTCyxU1Y/z2wMUOUCpF6yx96ZTkhO
         D7CZStm0PytfZkQxatLyPyDcXtg7zhj5IACkx3bpo40rPUxifVRxTIV36+YrfrNxlE5L
         o0rw==
X-Gm-Message-State: AOUpUlGSnSO7C3CUAL/DaSNOuPCnNv4fmk4W4cXif2ri6H2PdgSyDxGQ
        4hf/OjC/UOSBYulKpBCHKmfvvoFZ
X-Google-Smtp-Source: AA+uWPyf6coEC3pbC7Y0Z0uxwiqbiAigwqsuuKhwKJNR3ezEsVLkwlAtV2oJnxyi76DmUzV8HUzg3g==
X-Received: by 2002:adf:f210:: with SMTP id p16-v6mr4779534wro.184.1533919957511;
        Fri, 10 Aug 2018 09:52:37 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-25-156.w86-222.abo.wanadoo.fr. [86.222.24.156])
        by smtp.googlemail.com with ESMTPSA id i125-v6sm3108302wmd.23.2018.08.10.09.52.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 09:52:36 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v6 14/20] rebase -i: rewrite the rest of init_revisions_and_shortrevisions() in C
Date:   Fri, 10 Aug 2018 18:51:41 +0200
Message-Id: <20180810165147.4779-15-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810165147.4779-1-alban.gruin@gmail.com>
References: <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180810165147.4779-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites the part of init_revisions_and_shortrevisions() needed by
`--complete-action` (which initialize $shortrevisions) from shell to C.

When `upstream` is empty, it means that the user launched a `rebase
--root`, and `onto` contains the ID of an empty commit.  As a range
between an empty commit and `head` is not really meaningful, `onto` is
not used to initialize `shortrevisions` in this case.

The corresponding arguments passed to `--complete-action` are then
dropped, and init_revisions_and_shortrevisions() is stripped from
git-rebase--interactive.sh

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v5.

 builtin/rebase--helper.c   | 40 ++++++++++++++++++++++++++++++++------
 git-rebase--interactive.sh | 27 ++++---------------------
 2 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index acc71a6f99..0716bbfd78 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -10,7 +10,7 @@ static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
 
 static int get_revision_ranges(const char *upstream, const char *onto,
 			       const char **head_hash,
-			       char **revisions)
+			       char **revisions, char **shortrevisions)
 {
 	const char *base_rev = upstream ? upstream : onto;
 	struct object_id orig_head;
@@ -19,7 +19,25 @@ static int get_revision_ranges(const char *upstream, const char *onto,
 		return error(_("no HEAD?"));
 
 	*head_hash = find_unique_abbrev(&orig_head, GIT_MAX_HEXSZ);
-	*revisions = xstrfmt("%s...%s", base_rev, *head_hash);
+
+	if (revisions)
+		*revisions = xstrfmt("%s...%s", base_rev, *head_hash);
+	if (shortrevisions) {
+		const char *shorthead;
+
+		shorthead = find_unique_abbrev(&orig_head, DEFAULT_ABBREV);
+
+		if (upstream) {
+			const char *shortrev;
+			struct object_id rev_oid;
+
+			get_oid(base_rev, &rev_oid);
+			shortrev = find_unique_abbrev(&rev_oid, DEFAULT_ABBREV);
+
+			*shortrevisions = xstrfmt("%s..%s", shortrev, shorthead);
+		} else
+			*shortrevisions = xstrdup(shorthead);
+	}
 
 	return 0;
 }
@@ -116,7 +134,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		if (!upstream && squash_onto)
 			write_file(path_squash_onto(), "%s\n", squash_onto);
 
-		ret = get_revision_ranges(upstream, onto, &head_hash, &revisions);
+		ret = get_revision_ranges(upstream, onto, &head_hash, &revisions, NULL);
 		if (ret)
 			return ret;
 
@@ -145,9 +163,19 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!edit_todo_list(flags);
 	if (command == PREPARE_BRANCH && argc == 2)
 		return !!prepare_branch_to_be_rebased(&opts, argv[1]);
-	if (command == COMPLETE_ACTION && argc == 6)
-		return !!complete_action(&opts, flags, argv[1], argv[2], argv[3],
-					 argv[4], argv[5], autosquash);
+	if (command == COMPLETE_ACTION && argc == 3) {
+		char *shortrevisions = NULL;
+
+		ret = get_revision_ranges(upstream, onto, &head_hash, NULL, &shortrevisions);
+		if (ret)
+			return ret;
+
+		ret = complete_action(&opts, flags, shortrevisions, argv[1], onto,
+				      head_hash, argv[2], autosquash);
+
+		free(shortrevisions);
+		return !!ret;
+	}
 
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 4ca47aed1e..08e9a21c2f 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -60,23 +60,6 @@ init_basic_state () {
 	write_basic_state
 }
 
-init_revisions_and_shortrevisions () {
-	shorthead=$(git rev-parse --short $orig_head)
-	shortonto=$(git rev-parse --short $onto)
-	if test -z "$rebase_root"
-		# this is now equivalent to ! -z "$upstream"
-	then
-		shortupstream=$(git rev-parse --short $upstream)
-		revisions=$upstream...$orig_head
-		shortrevisions=$shortupstream..$shorthead
-	else
-		revisions=$onto...$orig_head
-		shortrevisions=$shorthead
-		test -z "$squash_onto" ||
-		echo "$squash_onto" >"$state_dir"/squash-onto
-	fi
-}
-
 git_rebase__interactive () {
 	initiate_action "$action"
 	ret=$?
@@ -87,8 +70,6 @@ git_rebase__interactive () {
 	git rebase--helper --prepare-branch "$switch_to" ${verbose:+--verbose}
 	init_basic_state
 
-	init_revisions_and_shortrevisions
-
 	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
 		${rebase_merges:+--rebase-merges} \
 		${rebase_cousins:+--rebase-cousins} \
@@ -97,8 +78,8 @@ git_rebase__interactive () {
 		${restrict_revision:+--restrict-revision ^"$restrict_revision"} >"$todo" ||
 	die "$(gettext "Could not generate todo list")"
 
-	exec git rebase--helper --complete-action "$shortrevisions" "$onto_name" \
-		"$shortonto" "$orig_head" "$cmd" $allow_empty_message \
-		${autosquash:+--autosquash} ${keep_empty:+--keep-empty} \
-		${verbose:+--verbose} ${force_rebase:+--no-ff}
+	exec git rebase--helper --complete-action "$onto_name" "$cmd" \
+		$allow_empty_message ${autosquash:+--autosquash} ${verbose:+--verbose} \
+		${keep_empty:+--keep-empty} ${force_rebase:+--no-ff} \
+		${upstream:+--upstream "$upstream"} ${onto:+--onto "$onto"}
 }
-- 
2.18.0

