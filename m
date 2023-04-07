Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D48EC76196
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 22:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjDGWSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 18:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjDGWSb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 18:18:31 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1DAAF2F
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 15:18:29 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a273b3b466so250155ad.1
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 15:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680905908;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i7iDacbyCYu2iwOL67sesqIh2NZc2mavzafP0TkS/4I=;
        b=j2N9rocOmh42YnnBEjzHkh0XWZ85Vxm8LCWn3G50AN1aWWe6oEpbmXj8sCN7TmOGp8
         jtPvRkageuF8fFh5/uAu1OKLv7h+Hax2Ar+X7tWmw5Ya0XZXJGyC6WAVSV3Wsw7ZOjeu
         1kNHs4PQfDYFfyQQQL/1xkUin8GErQDMfjh55aNdXGViV66LehCelSk2X78lEce4PQUe
         QWQNLVUWTmJ0LFkpTRtY6jC5rvYRGdVw8gWh6cSIg/82trfxjnQQre7V8IiZweb7quy6
         lPMhyrnnnhhLrzro8qfjZzZ/dCdNxiLX/KFzbm3Gbr397aaX6kacCaJz8DecMNMHdJDD
         Gf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680905908;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7iDacbyCYu2iwOL67sesqIh2NZc2mavzafP0TkS/4I=;
        b=y59zc+WD2Bi1OcE8hfUgjhT4FwDd95xKO0+ji7QW9dpo7TJmzows/wmu6NYY7HPEXH
         GK6PbEbYnHCA28TMYRi3VTPDZNdHa72Nde4HL6FZHxQigmFeMSuShJ5hIfDjuu7bbzHO
         JTj54PznraHGMlk6aTPvueRTz06qH0dz1sDzyCN2MYRQXjvK59/A/FuHUZzFW04hzu2W
         rymsOnw0RQ1vZu+Y+zyPg1eZJPU87huimj+spBrOShWWQ37c+dYd4sHKU8nnuHVcRAM7
         1L5soC0U22f5FvjMEo4V6kfczRZG94nAG/H+EnC0CBTXh/wj35np/C2kNZC/vLXDlDyG
         Vq2g==
X-Gm-Message-State: AAQBX9eaIvpgiDpMAMYGNIBzYAZlHXxazNJt8fd5owGNdNra5Mh51TYh
        SrOLZ/HYSkqxEG304IfWnQlh1oqtu+SGMkY1y2mdp/dK
X-Google-Smtp-Source: AKy350bPRftJa1w/NbzsCGRJgzRPsxAalv4kv6LMxu5wVyl8tN+p1OAVSdRY7jNy0MKjrTdkya32mA==
X-Received: by 2002:a17:902:d88e:b0:191:4367:7fde with SMTP id b14-20020a170902d88e00b0019143677fdemr90313plz.0.1680905907740;
        Fri, 07 Apr 2023 15:18:27 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:202:3cbf:c928:3960:94f5])
        by smtp.gmail.com with ESMTPSA id s4-20020a170902988400b0019cd1ee1523sm3389594plp.30.2023.04.07.15.18.26
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 15:18:27 -0700 (PDT)
Date:   Fri, 7 Apr 2023 15:18:22 -0700
From:   Emily Shaffer <nasamuffin@google.com>
To:     git@vger.kernel.org
Subject: [PATCH] usage: clarify --recurse-submodules as a boolean
Message-ID: <ZDCWrl4GhgYKYFYG@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git switch` `git checkout`, `git reset`, and `git read-tree` allow a user to choose to
recurse into submodules. All three of these commands' short usage seems
to indicate that `--recurse-submodules` should take an argument. In
practice, though, all three of these commands parse through the same
callback path:

  option_parse_recurse_submodules_worktree_updater(...) checks for
  set/unset, or passes off to...
  parse_update_recurse_submodules_arg(...), which is a straight handoff
  to...
  parse_update_recurse(...), which only accepts true or false.

So ultimately, it can only be true or false, unlike `git push
--recurse-submodules=<enum>`. A user could provide
`--recurse-submodules=true`, but we don't typically suggest that for
boolean arguments.
(Documentation/git-(switch|checkout|reset|read-tree).txt suggests
--[no-]recurse-submodules, too.)

In fact, these three commands are the only ones that use this codepath -
so there's not any reason for it to be so meandering.  It's not possible
to stop using these as a callback entirely, though, because
option_parse_recurse_submodules_worktree_updater() modifies global state
in submodule.c.

Clarify the usage so these commands don't pretend to accept a string
argument. Also, simplify
option_parse_recurse_submodules_worktree_updater() and remove the
now-unused parse_update_recurse_submodules_arg() and
parse_update_recurse() calls.

Signed-off-by: Emily Shaffer <nasamuffin@google.com>

---
 builtin/checkout.c  |  6 +++---
 builtin/read-tree.c |  6 +++---
 builtin/reset.c     |  4 ++--
 submodule-config.c  | 20 --------------------
 submodule-config.h  |  1 -
 submodule.c         |  4 ----
 6 files changed, 8 insertions(+), 33 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 38a8cd6a96..b80ad37fc1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1587,9 +1587,9 @@ static struct option *add_common_options(struct checkout_opts *opts,
 {
 	struct option options[] = {
 		OPT__QUIET(&opts->quiet, N_("suppress progress reporting")),
-		OPT_CALLBACK_F(0, "recurse-submodules", NULL,
-			    "checkout", "control recursive updating of submodules",
-			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater),
+		OPT_CALLBACK_F(0, "recurse-submodules", NULL, NULL,
+			    "control recursive updating of submodules",
+			    PARSE_OPT_NOARG, option_parse_recurse_submodules_worktree_updater),
 		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
 		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
 		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 600d4f748f..2afb0b24a2 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -149,9 +149,9 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 			 N_("skip applying sparse checkout filter")),
 		OPT_BOOL(0, "debug-unpack", &opts.internal.debug_unpack,
 			 N_("debug unpack-trees")),
-		OPT_CALLBACK_F(0, "recurse-submodules", NULL,
-			    "checkout", "control recursive updating of submodules",
-			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater),
+		OPT_CALLBACK_F(0, "recurse-submodules", NULL, NULL,
+			    "control recursive updating of submodules",
+			    PARSE_OPT_NOARG, option_parse_recurse_submodules_worktree_updater),
 		OPT__QUIET(&opts.quiet, N_("suppress feedback messages")),
 		OPT_END()
 	};
diff --git a/builtin/reset.c b/builtin/reset.c
index 0ed329236c..cdf6ea6df9 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -340,8 +340,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT(0, "keep", &reset_type,
 				N_("reset HEAD but keep local changes"), KEEP),
 		OPT_CALLBACK_F(0, "recurse-submodules", NULL,
-			    "reset", "control recursive updating of submodules",
-			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater),
+			    NULL, "control recursive updating of submodules",
+			    PARSE_OPT_NOARG, option_parse_recurse_submodules_worktree_updater),
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
 		OPT_BOOL('N', "intent-to-add", &intent_to_add,
 				N_("record only the fact that removed paths will be added later")),
diff --git a/submodule-config.c b/submodule-config.c
index ecf0fcf007..9ef0bdc207 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -338,26 +338,6 @@ int option_fetch_parse_recurse_submodules(const struct option *opt,
 	return 0;
 }
 
-static int parse_update_recurse(const char *opt, const char *arg,
-				int die_on_error)
-{
-	switch (git_parse_maybe_bool(arg)) {
-	case 1:
-		return RECURSE_SUBMODULES_ON;
-	case 0:
-		return RECURSE_SUBMODULES_OFF;
-	default:
-		if (die_on_error)
-			die("bad %s argument: %s", opt, arg);
-		return RECURSE_SUBMODULES_ERROR;
-	}
-}
-
-int parse_update_recurse_submodules_arg(const char *opt, const char *arg)
-{
-	return parse_update_recurse(opt, arg, 1);
-}
-
 static int parse_push_recurse(const char *opt, const char *arg,
 			       int die_on_error)
 {
diff --git a/submodule-config.h b/submodule-config.h
index c2045875bb..fda6ad0162 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -55,7 +55,6 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 struct option;
 int option_fetch_parse_recurse_submodules(const struct option *opt,
 					  const char *arg, int unset);
-int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
 int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
 void repo_read_gitmodules(struct repository *repo, int skip_if_read);
 void gitmodules_config_oid(const struct object_id *commit_oid);
diff --git a/submodule.c b/submodule.c
index 94644fac0a..fe456c24c9 100644
--- a/submodule.c
+++ b/submodule.c
@@ -236,10 +236,6 @@ int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
 		config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
 		return 0;
 	}
-	if (arg)
-		config_update_recurse_submodules =
-			parse_update_recurse_submodules_arg(opt->long_name,
-							    arg);
 	else
 		config_update_recurse_submodules = RECURSE_SUBMODULES_ON;
 
-- 
2.40.0.577.gac1e443424-goog

