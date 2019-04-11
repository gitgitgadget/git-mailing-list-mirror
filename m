Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83EF420248
	for <e@80x24.org>; Thu, 11 Apr 2019 13:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfDKNNa (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 09:13:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40820 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfDKNNa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 09:13:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so3507430pgl.7
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 06:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eU5CzKeV2P/7D1BjErnd7o8fTCWZOdmGJJ2Yxp8Wcsw=;
        b=lz9JK6Sr6Ou9hVXJBBCnUJQw+GGiGD7dz1ZYBYIi8F+YZTlJxEJkA64YMYME+gNpSp
         lrqY60vlYMHVv0cgGcIRclusgqmMzVsDpMcKPYtp/CwKx1Y77cfvzzhM1G2IpEmS2hWW
         Sj0342khd29fvK4vdWfjG+RDVJQ9EYxmttTcNAIBEYmHDsvsL6dFPky524B8nqA9AUGj
         toHFFtWNBjJg6uKhmZYgJbyGA+htt2NhklcLoISG4u7GpXO4uw+CRDZ9BUJqZAZ0DIyh
         nN0hgqHjQvqi1vLjOxhygZZIuYJFWC98fx5mE2oxqxw6Ha5r0dhhwYH7xKhUIh13Pnqu
         7F1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eU5CzKeV2P/7D1BjErnd7o8fTCWZOdmGJJ2Yxp8Wcsw=;
        b=UJT/3lMtREyWTYEjigNtO2L4HvgLfELWeweNjH9n4E8o+M8BFPyNp40FtcpsnV2ei6
         GkkNRebqvZ7xL75UMQHP0slM//09luP7MgnRAvmYtbe2CPAvKdhPvHxVnCW30WorHXpV
         ZACZ3SkRve0QisHj14EeraI59H4Onvo9vxcPjSZfIilAvkx5XYBGYAzS/u+At2sn8jC+
         mutODinZ6PDT/JK/JCz13mC7oqbT1zjnUPpYREOFjqJ85Gqm6MxbXwjWHLuUIX9qYjJU
         Hhmcvc6Ylawwh+Q7dYEmliOQ9VeEyIx7RNZajPchDfb638R88jXUzk/ch9zwE9RntCpz
         c1kg==
X-Gm-Message-State: APjAAAVx5aNKsupRBWciJ9FJ2W4mEkQHs/jktenLA3D/MDxkaJ+lvtRL
        BeS01I/fQ+a8QtP9I2ZFY74=
X-Google-Smtp-Source: APXvYqzaEi89ooJckZ9J3TAjcWskmrBkggZi0SmsKybn6aLqqLKoDFHFbTZNzqFfl/PhCPiLOJs3jA==
X-Received: by 2002:a63:c746:: with SMTP id v6mr46017601pgg.401.1554988409569;
        Thu, 11 Apr 2019 06:13:29 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id z8sm47673834pgz.3.2019.04.11.06.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 06:13:28 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 11 Apr 2019 20:13:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, rybak.a.v@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        jacob.keller@gmail.com
Subject: [PATCH v2 09/16] restore: replace --force with --ignore-unmerged
Date:   Thu, 11 Apr 2019 20:12:11 +0700
Message-Id: <20190411131218.19195-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190411131218.19195-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
 <20190411131218.19195-1-pclouds@gmail.com>
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
2.21.0.682.g30d2204636

