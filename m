Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09CED1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 12:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933356AbeGJMRh (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 08:17:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43246 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933352AbeGJMRc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 08:17:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id b15-v6so14387253wrv.10
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 05:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cRnS45WBJP3F2kKbmILbjR3K94V30M1HAtBKNdEtCNs=;
        b=HNVlS2mC8LYIRFfB8nvUn2uNMkFQ9cjHIuZ1Z5YA1Y6wqK4QUaauY868fLGmmyAwpv
         g8vDoyR0qYEQLImIw8/J1gyui/954cBu0PyjWFr+aWd7gUlkcD5FAEY+QsRCQzrZpnBF
         4kQCv5dC1ZQAsOxFXWz8MIZZSxCpYLcfA0pKJQz9GGrt2zXJ6beBlxzdKrtRBKF2lWec
         y+cjMg+IA8XKZZt8c9jROaP+ft4llw1nnHmEWnawZ5VHYzzylTlQzMuQMcJmshfCZ2OH
         6/UaikgUOtQdq3W39eTDCB+tySzy/c2kwW2cNX8Oyt0Iat7zbXUIgL593q0wshvMSMTt
         NKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cRnS45WBJP3F2kKbmILbjR3K94V30M1HAtBKNdEtCNs=;
        b=q27Npt8sVN9m991li5QynJ+3/7AI4KOa7FvCyY4vYJxJLoCrvOFaz+irnwTsk02ESG
         pdo7MtzXC8tatRAa0qBoa/Dy+DPp36sw0z+xwwfcdokKqOUZ4JTjnksjr/9TRqWhZHKV
         lQvjW2/4jeQbBILSs4BL8g8A01QdedtJAyvGs9ONDeIMZRlZNPBgujNfhu2he6mE/ffr
         5X8y6Ifi/UnVfYrFZTmfqJNl0z/eFjicPBcuso1+tFXLIA8BpTgS+VLh2RXKO3IRgiuT
         NO3XbW3pFNI33ISQwFVxMTQx7NrArPcicCJ4tnw7V+noFTYJMg+fvchRnhYJ7woHW6Lr
         3mUQ==
X-Gm-Message-State: APt69E2gbcunuCOhEEcfqLJf6ZYQY1k57vinFLfw0Q90THQLeQHjSXZ5
        33e5I653tYx6sA78tUFPg6yccIP5
X-Google-Smtp-Source: AAOMgpdN0fFNB6mZqYhlJoks/7xdr02hQWQ4D4dyUIvLu9CN1x0MbZfqoAMAbMtXgSSV6iJhe5tfpg==
X-Received: by 2002:a5d:4091:: with SMTP id o17-v6mr16120467wrp.133.1531225051298;
        Tue, 10 Jul 2018 05:17:31 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-239-37.w90-38.abo.wanadoo.fr. [90.38.238.37])
        by smtp.googlemail.com with ESMTPSA id t10-v6sm28244334wre.95.2018.07.10.05.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 05:17:30 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v3 12/13] rebase -i: implement the logic to initialize the variable $revision in C
Date:   Tue, 10 Jul 2018 14:15:56 +0200
Message-Id: <20180710121557.6698-13-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710121557.6698-1-alban.gruin@gmail.com>
References: <20180702105717.26386-1-alban.gruin@gmail.com>
 <20180710121557.6698-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites the part of init_revisions_and_shortrevisions() needed by
`--make-script` from shell to C.  The new version is called
get_revision_ranges(), and is a static function inside of
rebase--helper.c.

Unlike init_revisions_and_shortrevisions(), get_revision_ranges()
doesn’t write $squash_onto to the state directory, it’s done by the
handler of `--make-script` instead.

Finally, this drops the $revision argument passed to `--make-script` in
git-rebase--interactive.sh, and rebase--helper is changed accordingly.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--helper.c   | 56 ++++++++++++++++++++++++++++++++++++--
 git-rebase--interactive.sh |  4 ++-
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 8ab808da4..5845f80de 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -4,6 +4,25 @@
 #include "parse-options.h"
 #include "sequencer.h"
 #include "rebase-interactive.h"
+#include "argv-array.h"
+
+static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
+
+static int get_revision_ranges(const char *upstream, const char *onto,
+			       const char **head_hash,
+			       char **revisions)
+{
+	const char *base_rev = upstream ? upstream : onto;
+	struct object_id orig_head;
+
+	if (get_oid("HEAD", &orig_head))
+		return error(_("no HEAD?"));
+
+	*head_hash = find_unique_abbrev(&orig_head, GIT_MAX_HEXSZ);
+	*revisions = xstrfmt("%s...%s", base_rev, *head_hash);
+
+	return 0;
+}
 
 static const char * const builtin_rebase_helper_usage[] = {
 	N_("git rebase--helper [<options>]"),
@@ -15,7 +34,9 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, verbose = 0,
 		autosquash = 0;
-	int abbreviate_commands = 0, rebase_cousins = -1;
+	int abbreviate_commands = 0, rebase_cousins = -1, ret;
+	const char *head_hash = NULL, *onto = NULL, *restrict_revisions = NULL,
+		*squash_onto = NULL, *upstream = NULL;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, CHECK_TODO_LIST, REARRANGE_SQUASH,
 		ADD_EXEC, EDIT_TODO, PREPARE_BRANCH, COMPLETE_ACTION
@@ -50,6 +71,13 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			    N_("prepare the branch to be rebased"), PREPARE_BRANCH),
 		OPT_CMDMODE(0, "complete-action", &command,
 			    N_("complete the action"), COMPLETE_ACTION),
+		OPT_STRING(0, "onto", &onto, N_("onto"), N_("onto")),
+		OPT_STRING(0, "restrict-revision", &restrict_revisions,
+			   N_("restrict-revision"), N_("restrict revision")),
+		OPT_STRING(0, "squash-onto", &squash_onto, N_("squash-onto"),
+			   N_("squash onto")),
+		OPT_STRING(0, "upstream", &upstream, N_("upstream"),
+			   N_("the upstream commit")),
 		OPT_END()
 	};
 
@@ -77,8 +105,30 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!sequencer_continue(&opts);
 	if (command == ABORT && argc == 1)
 		return !!sequencer_remove_state(&opts);
-	if (command == MAKE_SCRIPT && argc > 1)
-		return !!sequencer_make_script(stdout, argc, argv, flags);
+	if (command == MAKE_SCRIPT && (argc == 1 || argc == 2)) {
+		char *revisions = NULL;
+		struct argv_array make_script_args = ARGV_ARRAY_INIT;
+
+		if (!upstream && squash_onto)
+			write_file(path_squash_onto(), "%s\n", squash_onto);
+
+		ret = get_revision_ranges(upstream, onto, &head_hash, &revisions);
+		if (ret)
+			return ret;
+
+		argv_array_pushl(&make_script_args, "", revisions, NULL);
+		if (argc == 2)
+			argv_array_push(&make_script_args, restrict_revisions);
+
+		ret = !!sequencer_make_script(stdout,
+					      make_script_args.argc, make_script_args.argv,
+					      flags);
+
+		free(revisions);
+		argv_array_clear(&make_script_args);
+
+		return ret;
+	}
 	if (command == CHECK_TODO_LIST && argc == 1)
 		return !!check_todo_list();
 	if (command == REARRANGE_SQUASH && argc == 1)
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0d66c0f8b..4ca47aed1 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -92,7 +92,9 @@ git_rebase__interactive () {
 	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
 		${rebase_merges:+--rebase-merges} \
 		${rebase_cousins:+--rebase-cousins} \
-		$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
+		${upstream:+--upstream "$upstream"} ${onto:+--onto "$onto"} \
+		${squash_onto:+--squash-onto "$squash_onto"} \
+		${restrict_revision:+--restrict-revision ^"$restrict_revision"} >"$todo" ||
 	die "$(gettext "Could not generate todo list")"
 
 	exec git rebase--helper --complete-action "$shortrevisions" "$onto_name" \
-- 
2.18.0

