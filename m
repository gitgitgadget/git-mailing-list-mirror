Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57DBC71153
	for <git@archiver.kernel.org>; Mon,  4 Sep 2023 20:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbjIDU7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Sep 2023 16:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjIDU73 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2023 16:59:29 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8809B1AB
        for <git@vger.kernel.org>; Mon,  4 Sep 2023 13:59:25 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401b393ddd2so18067475e9.0
        for <git@vger.kernel.org>; Mon, 04 Sep 2023 13:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693861164; x=1694465964; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=135WBxx9tCt1INlqNFulgRiqKdeEhwTuJAMMr2x4+dY=;
        b=sM4XsGeoHRF3bPtp6uoUf/Iy9cCY4Dh/6/cgt2GYjJ0Rg3wK8CeWo4kscJ4943mVI4
         jG8Gi5nJ+1x34AT6aono+Lfhc4NCg0sPRXdohyGpFqknuEJEHLvA7bqF0swO0+P7xBd2
         x0xRK3GByiwUfihyv586JKl92rPOR+uEyni24vF3F+rGWm+cb8zNvLLDLchccvUBVkoG
         CHge2lQRWhiTwxzaZ/v1Yns3gIQorxOFjXDTuThR60gWG7W72JyPkqnoYfkW35XVl0cb
         ZIiALNEdgp40g0ZqpRoWeq1Hiy9pwRqIucOkV1KoJ4c06JeT+yxF10qrZV/wNspCwy9+
         4SNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693861164; x=1694465964;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=135WBxx9tCt1INlqNFulgRiqKdeEhwTuJAMMr2x4+dY=;
        b=Re2LbFTN343OS0Yp9uuV2DgLGcTOJellKE0d37BlvT1hmYJd1wmeMC8ADAvFx2XX5U
         /D0MWgMuIZYhZGTPJgF2WSNNeX5y80cbSiF7o9A+ZgYfq6UA+SPrOW/LgCrC6+4aIwVt
         6aMTF5IYZrIzp7UEkaGI6gD4OadZKmODNrmjDV4UHCky5/TUm+GEowqDqsawH6ESNuXI
         phvfxZl94LI/0SPK06Y06MkaSDhkLJ139wKHv7Vb6CcN670jbn+HdDCr7Y+i5Bl7YGqu
         24ZDClpIraK5E8uW7b6zvgfO6T+fdpqDlhRmFo5uUY7Bdw3GwxygTGmmTItkWzOHT5hp
         RR5A==
X-Gm-Message-State: AOJu0YwdM54kMyVt5HrdgmUonyVYsGRQFgiLZD6aP0xJixDnkzKUKQrT
        PDk83bDN3nXZ3DTzSWM/gYRTfwwX+vY=
X-Google-Smtp-Source: AGHT+IHE/GbCxvRNaToODfpvi+M7BLgG1BbzeEJuiizN4WLzk2MX5J1zh+3DzoX4eNiv8fOds6YTAg==
X-Received: by 2002:adf:ed48:0:b0:316:ff0e:81b6 with SMTP id u8-20020adfed48000000b00316ff0e81b6mr7811583wro.32.1693861163624;
        Mon, 04 Sep 2023 13:59:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16-20020adfe9d0000000b00317e77106dbsm15389788wrn.48.2023.09.04.13.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 13:59:23 -0700 (PDT)
Message-ID: <pull.1570.git.git.1693861162353.gitgitgadget@gmail.com>
From:   "Konstantin Pereiaslov via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Sep 2023 20:59:22 +0000
Subject: [PATCH] advice: improve hint for diverging branches.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Konstantin Pereiaslov <perk11@perk11.info>,
        Konstantin Pereiaslov <perk11@perk11.info>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Konstantin Pereiaslov <perk11@perk11.info>

Added a description of what the offered options will do and for pull
also offered a 3rd option during a pull - a hard reset.
This option should be helpful for the new users that accidentally
committed into the wrong branch which is a scenario I saw very
often.

The resulting tooltip looks like this for pull:

hint: Diverging branches can't be fast-forwarded.
Consider the following options:
hint:
hint: To merge remote changes into your branch:
hint:   git merge --no-ff
hint:
hint: To apply your changes on top of remote changes:
hint:   git rebase
hint:
hint: To discard your local changes and apply the remote changes:
hint:   git reset --hard refs/remotes/upstream/branch-name
hint:
hint: Disable this message with "git config advice.diverging false"

There is some danger because it's semi-destructive, but so are
other options offered if user doesn't know the commands to
revert back. Additionally, I think "To discard your local changes"
wording describes the danger clearly enough.

And for merge I improved the wording and added a description of what
the commands do:

hint: Diverging branches can't be fast-forwarded.
hint: Consider the following options:
hint:
hint: To merge changes into your branch:
hint:   git merge --no-ff
hint:
hint: To apply your changes on top:
hint:   git rebase
hint:
hint: Disable this message with "git config advice.diverging false"

Signed-off-by: Konstantin Pereiaslov <perk11@perk11.info>
---
    Improve hint for diverging branches.
    
    I have seen a lot of developers not know what to do when they try to do
    a git pull on a master branch with the intention of updating that branch
    to the latest version, but see an error about branches diverging because
    they accidentally committed their changes to that branch. They then
    spend their time resolving conflicts and still not getting the intended
    result. The suggestion to do a hard reset should be something that helps
    in this situation.
    
    I'm not sure if a new config option needs to be created as technically
    these are two different advice now. I'm also not sure if "refs/remotes"
    part of the refspec is necessary, that is what I found the functions in
    pull.c are returning. I think "upstream/branch-name" should be the same
    thing, but kept it as is ( git reset --hard
    refs/remotes/upstream/branch-name) for now. Please feel free to chime
    in.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1570%2Fperk11%2Fdiverging-advice-improvements-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1570/perk11/diverging-advice-improvements-v1
Pull-Request: https://github.com/git/git/pull/1570

 Documentation/config/advice.txt |  3 ++-
 advice.c                        | 27 +++++++++++++++++++++++----
 advice.h                        |  3 ++-
 builtin/merge.c                 |  2 +-
 builtin/pull.c                  | 20 ++++++++++++++++++--
 5 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index c548a91e676..f3daa232ace 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -137,7 +137,8 @@ advice.*::
 		is asked to update index entries outside the current sparse
 		checkout.
 	diverging::
-		Advice shown when a fast-forward is not possible.
+		Advice shown when a fast-forward is not possible during merge
+		or pull operation.
 	worktreeAddOrphan::
 		Advice shown when a user tries to create a worktree from an
 		invalid reference, to instruct how to create a new orphan
diff --git a/advice.c b/advice.c
index 50c79443ba7..8fc4fb19932 100644
--- a/advice.c
+++ b/advice.c
@@ -220,19 +220,38 @@ void NORETURN die_conclude_merge(void)
 	die(_("Exiting because of unfinished merge."));
 }
 
-void NORETURN die_ff_impossible(void)
+void NORETURN die_ff_impossible_during_merge(void)
 {
 	advise_if_enabled(ADVICE_DIVERGING,
-		_("Diverging branches can't be fast-forwarded, you need to either:\n"
+		_("Diverging branches can't be fast-forwarded.\n"
+		"Consider the following options:\n"
 		"\n"
+		"To merge changes into your branch:\n"
 		"\tgit merge --no-ff\n"
 		"\n"
-		"or:\n"
-		"\n"
+		"To apply your changes on top:\n"
 		"\tgit rebase\n"));
 	die(_("Not possible to fast-forward, aborting."));
 }
 
+void NORETURN die_ff_impossible_during_pull(const char *upstream_branch_spec)
+{
+	advise_if_enabled(ADVICE_DIVERGING,
+			  _("Diverging branches can't be fast-forwarded. "
+			    "Consider the following options:\n"
+			    "\n"
+			    "To merge remote changes into your branch:\n"
+			    "\tgit merge --no-ff\n"
+			    "\n"
+			    "To apply your changes on top of remote changes:\n"
+			    "\tgit rebase\n"
+			    "\n"
+			    "To discard your local changes and apply the remote changes:\n"
+			    "\tgit reset --hard %s\n"), upstream_branch_spec);
+	die(_("Not possible to fast-forward, aborting."));
+}
+
+
 void advise_on_updating_sparse_paths(struct string_list *pathspec_list)
 {
 	struct string_list_item *item;
diff --git a/advice.h b/advice.h
index 2affbe14261..f87369a5471 100644
--- a/advice.h
+++ b/advice.h
@@ -71,7 +71,8 @@ void advise_if_enabled(enum advice_type type, const char *advice, ...);
 int error_resolve_conflict(const char *me);
 void NORETURN die_resolve_conflict(const char *me);
 void NORETURN die_conclude_merge(void);
-void NORETURN die_ff_impossible(void);
+void NORETURN die_ff_impossible_during_merge(void);
+void NORETURN die_ff_impossible_during_pull(const char *upstream_branch_spec);
 void advise_on_updating_sparse_paths(struct string_list *pathspec_list);
 void detach_advice(const char *new_name);
 void advise_on_moving_dirty_path(struct string_list *pathspec_list);
diff --git a/builtin/merge.c b/builtin/merge.c
index de68910177f..8358f137f1d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1675,7 +1675,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	}
 
 	if (fast_forward == FF_ONLY)
-		die_ff_impossible();
+		die_ff_impossible_during_merge();
 
 	if (autostash)
 		create_autostash(the_repository,
diff --git a/builtin/pull.c b/builtin/pull.c
index be2b2c9ebc9..51d30e6f918 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -765,6 +765,20 @@ static const char *get_tracking_branch(const char *remote, const char *refspec)
 	refspec_item_clear(&spec);
 	return merge_branch;
 }
+/**
+ * Returns the branch the pull is performed from.
+ * If remote is NULL or refspec is NULL, configured upstream remote of the
+ * current branch is used.
+ * If refspec is NULL, the current upstream branch is used.
+ */
+static const char *get_pull_branch(const char *remote, const char *refspec)
+{
+	if (refspec == NULL || remote == NULL) {
+		return get_upstream_branch(remote);
+	}
+
+	return get_tracking_branch(remote, refspec);
+}
 
 /**
  * Given the repo and refspecs, sets fork_point to the point at which the
@@ -1112,8 +1126,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	/* ff-only takes precedence over rebase */
 	if (opt_ff && !strcmp(opt_ff, "--ff-only")) {
-		if (divergent)
-			die_ff_impossible();
+		if (divergent) {
+			const char* pull_branch_spec = get_pull_branch(repo, *refspecs);
+			die_ff_impossible_during_pull(pull_branch_spec);
+		}
 		opt_rebase = REBASE_FALSE;
 	}
 	/* If no action specified and we can't fast forward, then warn. */

base-commit: d814540bb75bbd2257f9a6bf59661a84fe8cf3cf
-- 
gitgitgadget
