Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 641671F597
	for <e@80x24.org>; Tue, 24 Jul 2018 16:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388628AbeGXRlz (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 13:41:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37516 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388350AbeGXRly (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 13:41:54 -0400
Received: by mail-wm0-f66.google.com with SMTP id n11-v6so3170534wmc.2
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 09:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1aOkrH29bJP/E3Jo6RpeKjlQyVhkBQDWjTBnVKDERgM=;
        b=Rakp+SpbzwGmBy4IFlnuXsMz/hGnyObUSS6sUd0ZuPJBy/c+T1YKc2d0uHQFBEIcB2
         B/3S1g1N9iJTTzyy6PqxhIYV1bR5vC5HxOZLQEcn87KjfKZ5j1npB5P3KRf27wXyPLwg
         8o68H3RIZl3c9Yryp/s1g4SNlUwcyi7CPU3LbozXidXckKmVhKPG7/PyRwRseLuQ9nsq
         IQ4xFryaqXJJEfCLkBbDzrnDJzO013/KkAkl/jF0jhWatj98xjm3dCc+jCFqs9YPWXnl
         8wyHdlZQUwgnYxbkN8awIqPHImGa0a2dcGlaGBoZbHZvwS+GilRWfjh5SV3XDH5S4yPn
         2z7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1aOkrH29bJP/E3Jo6RpeKjlQyVhkBQDWjTBnVKDERgM=;
        b=e75OCd9ogsV7DY5ttVEex+4YfSM47gG+4u1jtT+RowEtzmTd+yfWzU0woMrr/op15i
         fORNN8mjY5Z+5YxqnDtoldYfM+/JJYmKO0XzvqLbX/pY/fkfN0+YWZdgaXAi2I+QBDj8
         SRQ3LqO5G6J1cQ0mSI3bX1RZfqQMBYK2nrH6j+8pow7KQ1jaIQs2f+xAprcU8baxbfYy
         qTpDNDjIsj1hwzZWiyIN1+faWlM5KZPTmP63QJpUh/xo4zkE0ZfppOs22OrjMhQqazbY
         G+kWk4WvHEqAm0y85Z5DpB0Li9VSrreymXAXitjvVPqMvzcMQPIkY5CKE2b04pZgKbwH
         lluA==
X-Gm-Message-State: AOUpUlFrOtv5tdCBpM/hTk0oMjIkeq4DOO3yUWoKKmzR2Z7KgtvW7Poa
        HZ3Otu+rNSBM3mGLhMxOKPAroZqj
X-Google-Smtp-Source: AAOMgpchmamwscrgdwKulPxGK2e19ftIZzrCoM1YVcTJnBYqob4jHhvwyoF3oS9QuOo/fojaHzIqNg==
X-Received: by 2002:a1c:3662:: with SMTP id d95-v6mr2289765wma.147.1532450076109;
        Tue, 24 Jul 2018 09:34:36 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-75-221.w92-156.abo.wanadoo.fr. [92.156.127.221])
        by smtp.googlemail.com with ESMTPSA id x124-v6sm1899091wmg.38.2018.07.24.09.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 09:34:35 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v4 16/20] rebase -i: rewrite init_basic_state() in C
Date:   Tue, 24 Jul 2018 18:32:17 +0200
Message-Id: <20180724163221.15201-17-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724163221.15201-1-alban.gruin@gmail.com>
References: <20180710121557.6698-1-alban.gruin@gmail.com>
 <20180724163221.15201-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites init_basic_state() from shell to C.  The call to
write_basic_state() in cmd_rebase__helper() is replaced by a call to the
new function.

The shell version is then stripped from git-rebase--interactive.sh.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--helper.c   | 23 ++++++++++++++++++++++-
 git-rebase--interactive.sh |  9 ---------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 06fe3c018b..ac21e8e06e 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -5,10 +5,13 @@
 #include "sequencer.h"
 #include "rebase-interactive.h"
 #include "argv-array.h"
+#include "refs.h"
 #include "rerere.h"
 #include "alias.h"
 
+static GIT_PATH_FUNC(path_state_dir, "rebase-merge/")
 static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
+static GIT_PATH_FUNC(path_interactive, "rebase-merge/interactive")
 
 static int get_revision_ranges(const char *upstream, const char *onto,
 			       const char **head_hash,
@@ -44,6 +47,24 @@ static int get_revision_ranges(const char *upstream, const char *onto,
 	return 0;
 }
 
+static int init_basic_state(struct replay_opts *opts, const char *head_name,
+			    const char *onto, const char *orig_head)
+{
+	FILE *interactive;
+
+	if (!is_directory(path_state_dir()) && mkdir_in_gitdir(path_state_dir()))
+		return error_errno(_("could not create temporary %s"), path_state_dir());
+
+	delete_reflog("REBASE_HEAD");
+
+	interactive = fopen(path_interactive(), "w");
+	if (!interactive)
+		return error_errno(_("could not mark as interactive"));
+	fclose(interactive);
+
+	return write_basic_state(opts, head_name, onto, orig_head);
+}
+
 static const char * const builtin_rebase_helper_usage[] = {
 	N_("git rebase--helper [<options>]"),
 	NULL
@@ -198,7 +219,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		if (ret)
 			return ret;
 
-		return !!write_basic_state(&opts, head_name, onto, head_hash);
+		return !!init_basic_state(&opts, head_name, onto, head_hash);
 	}
 
 	usage_with_options(builtin_rebase_helper_usage, options);
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6367da66e2..761be95ed1 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -51,14 +51,6 @@ initiate_action () {
 	esac
 }
 
-init_basic_state () {
-	orig_head=$(git rev-parse --verify HEAD) || die "$(gettext "No HEAD?")"
-	mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
-	rm -f "$(git rev-parse --git-path REBASE_HEAD)"
-
-	: > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
-}
-
 git_rebase__interactive () {
 	initiate_action "$action"
 	ret=$?
@@ -67,7 +59,6 @@ git_rebase__interactive () {
 	fi
 
 	git rebase--helper --prepare-branch "$switch_to" ${verbose:+--verbose}
-	init_basic_state
 
 	git rebase--helper --init-basic-state ${upstream:+--upstream "$upstream"} \
 		${onto:+--onto "$onto"} ${head_name:+--head-name "$head_name"} \
-- 
2.18.0

