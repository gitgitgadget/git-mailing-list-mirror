Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51A1D1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 18:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbeGaTmO (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:42:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33726 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731652AbeGaTmN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:42:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id g6-v6so17589075wrp.0
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 11:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=96US57dc/Op0fajaYAZIghgeo61UM26EVWzJ+HtD/2Y=;
        b=foymBTtldB9Tbs6zNVaWfKt1tkjoaBQPoi7FDMrpvSPsR8UMdnqNaaO7Rq0HZ48arZ
         gQUGotAv9czcfw5MxDTmPn9qtzyblUFQFjU1NBzg6D3BnVnjV/6b0hRdjA/hHWUtqUzI
         2ppk/wvafAbfIMZWygMwo6Uro4haG3AMrRmEjbtjNWPmQTm+L2ptS9mKLGbk3IG28btp
         G24MHAb/eDasaLlvT8HqztO/bgIn84K8MsDfE66S/g4RmGqz102xd4t1dYCtE2mlUKit
         HKxICUQPFQ2Kn59IJVnPmc91UZANJnwMCoDzt9gaoLNAhNUB/X0GuyAK7OuAgGtuVKi0
         kMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=96US57dc/Op0fajaYAZIghgeo61UM26EVWzJ+HtD/2Y=;
        b=OthmTDqR3qgYtfBIMwXqzzbiOBmQQuT/qhW4XbhRfHc9vzg8arS2whpJg0NP+086It
         QygAa7olm1zrDnDmaONVrDFPD+OCPzI40w2fdW5j5sXxq+SZ38ydJU2QuhE4OHFJvtW+
         anulsubbWyS31FVlFOGE/c3bRJ+4IgE9y+o1R767YTLU5DT7kg7h10Jitg5eP+PgvSY4
         BXqRt1sqI0NQP8JMLSWz02QlSH4MxaAM3cQiMMbMIjhmGeuiDsepe82F95q+txc3Ep4h
         2Ol31JY7cCVg1V2r0KEWbEqVeMmAyfA02GHUfJ+oLKG9uN7IbTRP2+YZB18qxDzvJ5fW
         2pKg==
X-Gm-Message-State: AOUpUlHny+/5bBiC4OlPgoX31FpJ/G+Kncp5RRbGVJ4bbBz46Nf0N6as
        0e7RLv71GxXgqKLz3MY77VxjGBD9
X-Google-Smtp-Source: AAOMgpc5Yw+FyCjlZRc+vtH2/lkTtoU40Tn8aLG9LFoftILyLrO9HfdlfNQEDP9C+eu+IQSISZdOtA==
X-Received: by 2002:adf:df07:: with SMTP id y7-v6mr20598086wrl.117.1533060045383;
        Tue, 31 Jul 2018 11:00:45 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-67-118.w92-136.abo.wanadoo.fr. [92.136.29.118])
        by smtp.googlemail.com with ESMTPSA id l10-v6sm20756602wrv.23.2018.07.31.11.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 11:00:44 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v5 16/20] rebase -i: rewrite init_basic_state() in C
Date:   Tue, 31 Jul 2018 19:59:59 +0200
Message-Id: <20180731180003.5421-17-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731180003.5421-1-alban.gruin@gmail.com>
References: <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180731180003.5421-1-alban.gruin@gmail.com>
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
No changes since v4.

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

