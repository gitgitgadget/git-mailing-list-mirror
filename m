Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 027A41F597
	for <e@80x24.org>; Tue, 24 Jul 2018 16:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388607AbeGXRlw (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 13:41:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39962 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388350AbeGXRlw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 13:41:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id t6-v6so4770393wrn.7
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 09:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y77x8+sFXKKOBGtcnauGAqg40vDC0z4t8VPS70exjKY=;
        b=Z1s36csCNsjKVptDqJyWJduw/LF2ImqHsNuJkbT6CRpVcXzlMI96xcPho6i8RzMZqz
         hTWTxualtfCg5ZTQyjWWwKslSijm7XiNKgnECVLfGIGvoN5sygbBwRNqaldDLwnCrWRN
         CF0K/dzlBw6w3KcOTS2J6qDfCx1gjWAAyabu13gdqLlUn+EK7/aqLLsd+SUz3WKG+13n
         X1QQBqUOdUhZkEkbiobXSZlyZpo4Q/T2zg1MIovknfuNLjzvnh8O2NYYBcSDo/V5bHD+
         qfe1IbmNnrpfOtsYWwN5062bBxUBOIgWNQvC72WMo7Pb6AGiJ8vNxNSL8z0Xa4neo5iy
         94dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y77x8+sFXKKOBGtcnauGAqg40vDC0z4t8VPS70exjKY=;
        b=RH1t+YyDypIPQzPiMn/MpJvbD+naFJvmXWg+UTrIICMPdQns8v1PypgJHXGxddTPIV
         9QedUkr7WlS8CxOYn9thzuLBUSc4RmLgRL01Tki0FuzxjeOenot0luWudA3TxLCmfcx2
         kirfsMlQm0B7DGH9U8W+AWDyjmfgelsuBgxhW5yrdSpuRGzFUaK3MDURXgK/nKNhxFtf
         pCRrMHlCocdw384/1lSk68AYvtg/Xs0e9dnj5MMHeVtbVbzS5otG2Dh637aGUkhHUC/w
         96EAdK1NZ5UdH7i/Yihle1pwRpcBt3I2KcKf4JjASOCLxPabZCWLA5mMVoSa6cxh8xl3
         UghA==
X-Gm-Message-State: AOUpUlG0FfE+HhHAngrbeu9ULG7/VUdXlkwNCK3sLyUtmsyWOuRLzMv5
        /Mv5GchRGB8TeQ5FvD8ygEPF99pK
X-Google-Smtp-Source: AAOMgpdt7jNlVfKukv741einBJBfufD96PSuDribhzgmOi9dEaV/S+a8j5EUUwMoRU7w8bvt3QWr9Q==
X-Received: by 2002:a5d:40c4:: with SMTP id b4-v6mr11062873wrq.133.1532450072819;
        Tue, 24 Jul 2018 09:34:32 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-75-221.w92-156.abo.wanadoo.fr. [92.156.127.221])
        by smtp.googlemail.com with ESMTPSA id x124-v6sm1899091wmg.38.2018.07.24.09.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 09:34:31 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v4 14/20] rebase -i: rewrite the rest of init_revisions_and_shortrevisions() in C
Date:   Tue, 24 Jul 2018 18:32:15 +0200
Message-Id: <20180724163221.15201-15-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724163221.15201-1-alban.gruin@gmail.com>
References: <20180710121557.6698-1-alban.gruin@gmail.com>
 <20180724163221.15201-1-alban.gruin@gmail.com>
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
 builtin/rebase--helper.c   | 40 ++++++++++++++++++++++++++++++++------
 git-rebase--interactive.sh | 27 ++++---------------------
 2 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 15fa556f65..c4a4c5cfbb 100644
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

