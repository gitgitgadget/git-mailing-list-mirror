Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DF571F45C
	for <e@80x24.org>; Tue, 28 Aug 2018 12:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeH1QCw (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 12:02:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33024 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbeH1QCw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 12:02:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id i134-v6so1743441wmf.0
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 05:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JFefcuFhUPtFBbkjZxAZDBjeOx5Tutl2tiUL5usaapE=;
        b=kTFhDnMLbd6faPyghZ3Jbnaf4W8sO7+HokhnTVRQO0z8D37HpOK97qMBcqz4IZP9Eq
         hfUI4xCU8D2hw1By0YnX/PVZ3wdKZVP0BoXxGPapSH7mI9WsbsclnXgkBhYzvqzK+Ftk
         Hbw3zYvv7BOeYrFiuOxwXG8PAN+Kwc3YiAcwibTraoVHgjxPAaXGpV2It4te1tYTJFul
         eSZi2RFegWz8D620YInBmO50E0ypS/D9DzB+dowgz77AC8w05WPXBKDbCYndGzd5DC9/
         3yPIVsTwzyF5FIN7qcxxg7PzvCM6yHHsvLcjmBxp7woT+Uc1mP4BHqw1BxGiwtx9RRK3
         6sAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JFefcuFhUPtFBbkjZxAZDBjeOx5Tutl2tiUL5usaapE=;
        b=VUpOfSR9GcLtrawss6Ix3jORswgydwMmQx4F6HHKc1eY5cT23zwW8vzjEYQzsPqk4u
         sWfrvcbGBlsnK5Y4lnKvHU1GrJaZnZzGsSEzSrKrLy7xIZitsP8uuVGydUBoFIZ3cfHj
         kkO7UC3TeOnF19hScorivHmUCr7airR4ji30yBbs13zr0/yUW5nV+E52DVz/gnxKvyW6
         l5cAsNp9rUZ4qfHcGvO2VQhqa4X+LNWNt60G/OiawhgLkrFqBKNQouh+XmqCY5rG8b34
         dUTpde49ifrFMfdxJgeL8IC78iKPacgQvjmqZC+D09+8DBR9wwEeIxr9Kle6nvm/++iC
         W7RQ==
X-Gm-Message-State: APzg51CZeOuSO4AY8VASKE0SK9RMMUWeI/Jo5aWmNDmetg1vvQRnN3JF
        8bU/S2OfA4bHmz9LcAMhQXcngrXN
X-Google-Smtp-Source: ANB0VdbUkGFvaKziJ+cphxjIM3TMZd/tpAKffcs0hhaoATUzDlCblOJAot9yY/qf/EGRABxv/zocug==
X-Received: by 2002:a1c:8c49:: with SMTP id o70-v6mr1128014wmd.11.1535458288442;
        Tue, 28 Aug 2018 05:11:28 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-33-140.w86-221.abo.wanadoo.fr. [86.221.112.140])
        by smtp.googlemail.com with ESMTPSA id y206-v6sm1702790wmg.14.2018.08.28.05.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 05:11:27 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v7 16/20] rebase -i: rewrite init_basic_state() in C
Date:   Tue, 28 Aug 2018 14:10:41 +0200
Message-Id: <20180828121045.14933-17-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828121045.14933-1-alban.gruin@gmail.com>
References: <20180810165147.4779-1-alban.gruin@gmail.com>
 <20180828121045.14933-1-alban.gruin@gmail.com>
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
No changes since v6.

 builtin/rebase--helper.c   | 23 ++++++++++++++++++++++-
 git-rebase--interactive.sh |  9 ---------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 63c5086e42..f8128037d3 100644
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

