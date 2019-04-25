Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D71B01F453
	for <e@80x24.org>; Thu, 25 Apr 2019 09:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfDYJq4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 05:46:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35572 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbfDYJq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 05:46:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id t21so10896305pfh.2
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 02:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q/d6s2TGTki/R7NwZKOPWT1X285IpwlPBpOqHfKJOJQ=;
        b=rNzrk2UdkuJNicDk+3l0BZ6Zn5T3+AlcsukbpwxdrZxZ2oa8Cn6FDDyJxLKN+VslI/
         QtqpqrpHML7PgvQr2T/SwcS0yGYCr/wAMXxDzZhJiqjGb5sk2KhxiUIz3Nth5xBQZA/z
         0SwCxIt9bktdSMYyugAf/3bwsZVx3+AvAUuz/zj4Gb8bYkzoOnInAipZ51YLbuzhVydK
         LmrWCjEsg+6SXiKyvYdf2tmHqHJCs3Rk+ZdDxR44h0iffxanqaqIPQzwcbMbIkP9hiUD
         rFcuZY6PO77hwicrhyfFdwjsyjDsHv/0UiTUIGvKhw2t7H5NbOKdrlaSXQ3/emAc9H+Z
         /20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/d6s2TGTki/R7NwZKOPWT1X285IpwlPBpOqHfKJOJQ=;
        b=boc24lMfxkD0NY5lRtj7fxXgeE5VOzxDBYR8XhQ9OWtXPiy5WENEVLXVcIX+8djk08
         BXDBjPALKjdHU+dwavxiUOtagZdb7OoPndYuGQLvXc9JFZo2amZvD9VHwmm6/i7sTjY3
         kp5g9FVCI6RdNdQ0bPVvhQ1wesoy0WrxzOPJ3kTJrVgg/iiQ9WkNyGMuTLFd+leQH9UN
         bBoCRLOnjzCpAeACYVxCcXkajcDmj1gfYXgvH2b3sB7TnYyzMLKkppOei1M6chckxkES
         iUI153aEdgYX9Z8COKfgICKQZ1EfXp5QwtN/4VGUgRrR9sASzBtDhAdNaL4ZY05eArk7
         ggmA==
X-Gm-Message-State: APjAAAXoK6R8EkzhlEohnTg1IokLmejV1K1YljZ9cYo6dE0E1M/6k4bu
        di03+W2sQl8Sv2K+Ggr4iWY=
X-Google-Smtp-Source: APXvYqxQwFbmM3PST6ggLW+xU/mevClYSmQfCljvMAKU80ws90acW2jsKBOv8uqVfbkE/ChDRGE/Gg==
X-Received: by 2002:aa7:83d1:: with SMTP id j17mr39237307pfn.78.1556185615482;
        Thu, 25 Apr 2019 02:46:55 -0700 (PDT)
Received: from ash ([115.73.128.9])
        by smtp.gmail.com with ESMTPSA id j62sm39600214pfg.6.2019.04.25.02.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:46:54 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 25 Apr 2019 16:46:50 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        jacob.keller@gmail.com, newren@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v3 09/16] restore: replace --force with --ignore-unmerged
Date:   Thu, 25 Apr 2019 16:45:53 +0700
Message-Id: <20190425094600.15673-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.854.ge34a79f761
In-Reply-To: <20190425094600.15673-1-pclouds@gmail.com>
References: <20190411131218.19195-1-pclouds@gmail.com>
 <20190425094600.15673-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use a more specific option name to express its purpose. --force may come
back as an alias of --ignore-unmerged and possibly more. But since this
is a destructive operation, I don't see why we need to "force" anything
more. We already don't hold back.

When 'checkout --force' or 'restore --ignore-unmerged' is used, we may
also print warnings about unmerged entries being ignore. Since this is
not exactly warning (people tell us to do so), more informational, let
it be suppressed if --quiet is given. This is a behavior change for
git-checkout.

PS. The diff looks a bit iffy since --force is moved to
add_common_switch_branch_options() (i.e. for switching). But
git-checkout is also doing switching and inherits this --force.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 09a03f1ff8..824ab65886 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -68,6 +68,8 @@ struct checkout_opts {
 	int empty_pathspec_ok;
 	int checkout_index;
 	int checkout_worktree;
+	const char *ignore_unmerged_opt;
+	int ignore_unmerged;
 
 	const char *new_branch;
 	const char *new_branch_force;
@@ -409,8 +411,9 @@ static int checkout_paths(const struct checkout_opts *opts,
 	if (opts->new_branch_log)
 		die(_("'%s' cannot be used with updating paths"), "-l");
 
-	if (opts->force && opts->patch_mode)
-		die(_("'%s' cannot be used with updating paths"), "-f");
+	if (opts->ignore_unmerged && opts->patch_mode)
+		die(_("'%s' cannot be used with updating paths"),
+		    opts->ignore_unmerged_opt);
 
 	if (opts->force_detach)
 		die(_("'%s' cannot be used with updating paths"), "--detach");
@@ -418,8 +421,9 @@ static int checkout_paths(const struct checkout_opts *opts,
 	if (opts->merge && opts->patch_mode)
 		die(_("'%s' cannot be used with %s"), "--merge", "--patch");
 
-	if (opts->force && opts->merge)
-		die(_("'%s' cannot be used with %s"), "-f", "-m");
+	if (opts->ignore_unmerged && opts->merge)
+		die(_("'%s' cannot be used with %s"),
+		    opts->ignore_unmerged_opt, "-m");
 
 	if (opts->new_branch)
 		die(_("Cannot update paths and switch to branch '%s' at the same time."),
@@ -495,8 +499,9 @@ static int checkout_paths(const struct checkout_opts *opts,
 		if (ce->ce_flags & CE_MATCHED) {
 			if (!ce_stage(ce))
 				continue;
-			if (opts->force) {
-				warning(_("path '%s' is unmerged"), ce->name);
+			if (opts->ignore_unmerged) {
+				if (!opts->quiet)
+					warning(_("path '%s' is unmerged"), ce->name);
 			} else if (opts->writeout_stage) {
 				errs |= check_stage(opts->writeout_stage, ce, pos, opts->overlay_mode);
 			} else if (opts->merge) {
@@ -1414,8 +1419,6 @@ static struct option *add_common_options(struct checkout_opts *opts,
 			    "checkout", "control recursive updating of submodules",
 			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
 		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
-		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifications)"),
-			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
 		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
 			   N_("conflict style (merge or diff3)")),
@@ -1433,6 +1436,8 @@ static struct option *add_common_switch_branch_options(
 		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at named commit")),
 		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
+		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifications)"),
+			   PARSE_OPT_NOCOMPLETE),
 		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
 		OPT_BOOL_F(0, "overwrite-ignore", &opts->overwrite_ignore,
 			   N_("update ignored files (default)"),
@@ -1502,8 +1507,11 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		opts->merge = 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", opts->conflict_style, NULL);
 	}
-	if (opts->force)
+	if (opts->force) {
 		opts->discard_changes = 1;
+		opts->ignore_unmerged_opt = "--force";
+		opts->ignore_unmerged = 1;
+	}
 
 	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
 		die(_("-b, -B and --orphan are mutually exclusive"));
@@ -1750,6 +1758,8 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 			   N_("restore the index")),
 		OPT_BOOL('W', "worktree", &opts.checkout_worktree,
 			   N_("restore the working tree (default)")),
+		OPT_BOOL(0, "ignore-unmerged", &opts.ignore_unmerged,
+			 N_("ignore unmerged entries")),
 		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode")),
 		OPT_END()
 	};
@@ -1762,6 +1772,7 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	opts.overlay_mode = 0;
 	opts.checkout_index = -1;    /* default off */
 	opts.checkout_worktree = -2; /* default on */
+	opts.ignore_unmerged_opt = "--ignore-unmerged";
 
 	options = parse_options_dup(restore_options);
 	options = add_common_options(&opts, options);
-- 
2.21.0.854.ge34a79f761

