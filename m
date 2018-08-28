Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8418B1F459
	for <e@80x24.org>; Tue, 28 Aug 2018 12:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbeH1QCt (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 12:02:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42872 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeH1QCt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 12:02:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id v17-v6so1348170wrr.9
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 05:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vznnz5D7n8IbSYHjibZemm2oY5Ezy4DJnuhAbU00TEs=;
        b=LQ2NVjHugWizQoJ/aTW9fS+TEaej2yOp0gEth83QH+evhP5tmbuU6sd0H7laTQrP7s
         mzwcHwyEZ7wwbQ8N5T652qhoreiBg9UYvanBqE2MNOu74WMGuccyER4pOAhr0TNy5ocX
         i8Z5/l16JFw2ebc1JP/NIJNhez6PQtZnlAVhHgv+B48+kJ9fKI9SBOV8AB/rNh0i8Rgr
         mQ5dr7FBuWOhxd8wVe4W9ixV5b93T1G1t6lbPNUYRNN3uLapi8+qPIo0Kf/Bw2LLEKYS
         0i0Yt3/CLJq6nQOC9hQxfAgSnl+yCK17wIeuMkCANLBKk3WOtsRNtQipF/whxCL/dEZI
         Qfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vznnz5D7n8IbSYHjibZemm2oY5Ezy4DJnuhAbU00TEs=;
        b=HNP1k8IV2uD25iBLZIG0TkMlOP1HhFCkUNYB/WQzA08G5T1hQlpucqrRxiEJbOu5gd
         T0SSrvy1karsAVIPwtSQHU8eaOG09GUIouAGuWCs73x7vLLFX89RFv/xYmGMNDL+ypCN
         IF6s/HziRC3Cy+NzfuZINIzEQjpn7hownchN0DsieHpP1Sljpaeiut9o/a3nf32O28kF
         eDdB8RFAl2FgPmTCMhRQKEYq+rz3D5hXSM+DKv2DyKZORobCgGXTutmD+f81DAHaSwDO
         yUo7tJgPWUdzqIFrW6aDV5wC202VEiPs09venmhFJGpawJzowcODCKcblXSaQ39/3gsg
         bo+Q==
X-Gm-Message-State: APzg51DenibAmwPFJ6BerN6OyUyOj7XjhuJME+Nt4IgVPMRRjUI0T3Am
        SrGfxP7k7/oYOmGdtwWKFY3LtjpA
X-Google-Smtp-Source: ANB0VdaGsVjUbPoxiQaYRmC2OVpqDQGGfsEDIVHU2dtgSD0u8KxqGuuaK3kvn2/vkRGI8Q4mx6BVmQ==
X-Received: by 2002:adf:92c2:: with SMTP id 60-v6mr973140wrn.153.1535458285161;
        Tue, 28 Aug 2018 05:11:25 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-33-140.w86-221.abo.wanadoo.fr. [86.221.112.140])
        by smtp.googlemail.com with ESMTPSA id y206-v6sm1702790wmg.14.2018.08.28.05.11.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 05:11:23 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v7 14/20] rebase -i: rewrite the rest of init_revisions_and_shortrevisions() in C
Date:   Tue, 28 Aug 2018 14:10:39 +0200
Message-Id: <20180828121045.14933-15-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828121045.14933-1-alban.gruin@gmail.com>
References: <20180810165147.4779-1-alban.gruin@gmail.com>
 <20180828121045.14933-1-alban.gruin@gmail.com>
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
No changes since v6.

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

