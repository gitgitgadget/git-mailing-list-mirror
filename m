Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09261C432BE
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 23:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E154661132
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 23:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242122AbhHEXD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 19:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242095AbhHEXDy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 19:03:54 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C92C061799
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 16:03:38 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id z24so8043246qkz.7
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 16:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rNX0DZVEAScxqTdGrimMW7a1Q0qrHrNZqW+/ePMwGBo=;
        b=EIyDAjwc9SZiqgcHsC9myIrihfGgQo4rtHw5eBfNJ96yK49hp5RkH6JO/ERKT/+9MR
         Z1/9DYl0uX3qTEW6N222MrBJ5u87bAE00rtLYij8Jp0RZ5MUxWYbQ8P8ngpC3YdawjW8
         DsFUOQQ9jZz+1aTiIDBJ8xJA0YDHB9XFkBYoiJ86OdcYGpWZ4/YhC7YhnEgkKjHCHPvD
         J0wehMBQfsmfChfXaothFboRcPjYqkccgAaUvbxV9l8pVCrqFLAVGz0ddIOe/tOjn7WA
         jUBH0Y0viEx6znGV4jXxmkWzQlk70jMBiLzMXk8G4EEDZj7HhHiDSQ5WaJyza8fWLZk4
         y+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rNX0DZVEAScxqTdGrimMW7a1Q0qrHrNZqW+/ePMwGBo=;
        b=YUUgjBRpnwNhHa2OgmKMeDkPfPKfTBCJ/Ch1Pg1LdyQd0d72hkDKgHMRWTJxlmYjoD
         y6MmaQhQqs4jJmwP7iU5/tRvfH0lEiI06AtEfkd+8f3+9uyUJ5qmbUQVqe9ZXJET0olS
         X5d8BZ/C6WyfGw1DK81LlZu5i3ZjmUTd2V2qjAx+GQbOOY0ndDlFdWAuwe/MQGMdFAvI
         BHB5VmSlPkaK3Vj0fex1+jTCoakqQrJb9oFgDb0xanXc8cYoFtuqNkeOyQfk1Nw0uZTw
         /zmRqUgGcxmJHbvSXnZF3R1IMwdQVDNURpp8kVhOxR3kBl/CQ9+uH6WeldjqvGHgwmlL
         weLQ==
X-Gm-Message-State: AOAM533OKLewK9hMCCDWG15dgq3j9kP6cgLiXE1zpIgszNUjq51Kotuk
        iyPrXH4jgSmTISbnT0F8tCW8q2d7bvI=
X-Google-Smtp-Source: ABdhPJxZCEOtmvhvU8jLmnWJvE60YxH4mHQ4DRkvnwLY1j8h99btaCjsByAxBfxtiZNzDa+hTyEf+g==
X-Received: by 2002:a05:620a:7e4:: with SMTP id k4mr7302723qkk.328.1628204617790;
        Thu, 05 Aug 2021 16:03:37 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id i4sm3567820qka.130.2021.08.05.16.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 16:03:37 -0700 (PDT)
From:   Ben Boeckel <mathstuf@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/4] advice: remove static global variables for advice tracking
Date:   Thu,  5 Aug 2021 19:03:21 -0400
Message-Id: <20210805230321.532218-5-mathstuf@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210805230321.532218-1-mathstuf@gmail.com>
References: <20210731022504.1912702-1-mathstuf@gmail.com>
 <20210805230321.532218-1-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of the preferences are now tracked as part of the `advice_setting`
array and all consumers of the global variables have been removed, so
the parallel tracking through `advice_config` is no longer necessary.

This concludes the move from the old advice API to the new one
introduced via c4a09cc9ccb (Merge branch 'hw/advise-ng', 2020-03-25).

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 advice.c | 77 --------------------------------------------------------
 advice.h | 31 -----------------------
 2 files changed, 108 deletions(-)

diff --git a/advice.c b/advice.c
index ee4edc5e28..6ba47f3f5e 100644
--- a/advice.c
+++ b/advice.c
@@ -4,37 +4,6 @@
 #include "help.h"
 #include "string-list.h"
 
-int advice_fetch_show_forced_updates = 1;
-int advice_push_update_rejected = 1;
-int advice_push_non_ff_current = 1;
-int advice_push_non_ff_matching = 1;
-int advice_push_already_exists = 1;
-int advice_push_fetch_first = 1;
-int advice_push_needs_force = 1;
-int advice_push_unqualified_ref_name = 1;
-int advice_push_ref_needs_update = 1;
-int advice_status_hints = 1;
-int advice_status_u_option = 1;
-int advice_status_ahead_behind_warning = 1;
-int advice_commit_before_merge = 1;
-int advice_reset_quiet_warning = 1;
-int advice_resolve_conflict = 1;
-int advice_sequencer_in_use = 1;
-int advice_implicit_identity = 1;
-int advice_detached_head = 1;
-int advice_set_upstream_failure = 1;
-int advice_object_name_warning = 1;
-int advice_amworkdir = 1;
-int advice_rm_hints = 1;
-int advice_add_embedded_repo = 1;
-int advice_ignored_hook = 1;
-int advice_waiting_for_editor = 1;
-int advice_graft_file_deprecated = 1;
-int advice_checkout_ambiguous_remote_branch_name = 1;
-int advice_submodule_alternate_error_strategy_die = 1;
-int advice_add_ignored_file = 1;
-int advice_add_empty_pathspec = 1;
-
 static int advice_use_color = -1;
 static char advice_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
@@ -62,45 +31,6 @@ static const char *advise_get_color(enum color_advice ix)
 	return "";
 }
 
-static struct {
-	const char *name;
-	int *preference;
-} advice_config[] = {
-	{ "fetchShowForcedUpdates", &advice_fetch_show_forced_updates },
-	{ "pushUpdateRejected", &advice_push_update_rejected },
-	{ "pushNonFFCurrent", &advice_push_non_ff_current },
-	{ "pushNonFFMatching", &advice_push_non_ff_matching },
-	{ "pushAlreadyExists", &advice_push_already_exists },
-	{ "pushFetchFirst", &advice_push_fetch_first },
-	{ "pushNeedsForce", &advice_push_needs_force },
-	{ "pushUnqualifiedRefName", &advice_push_unqualified_ref_name },
-	{ "pushRefNeedsUpdate", &advice_push_ref_needs_update },
-	{ "statusHints", &advice_status_hints },
-	{ "statusUoption", &advice_status_u_option },
-	{ "statusAheadBehindWarning", &advice_status_ahead_behind_warning },
-	{ "commitBeforeMerge", &advice_commit_before_merge },
-	{ "resetQuiet", &advice_reset_quiet_warning },
-	{ "resolveConflict", &advice_resolve_conflict },
-	{ "sequencerInUse", &advice_sequencer_in_use },
-	{ "implicitIdentity", &advice_implicit_identity },
-	{ "detachedHead", &advice_detached_head },
-	{ "setUpstreamFailure", &advice_set_upstream_failure },
-	{ "objectNameWarning", &advice_object_name_warning },
-	{ "amWorkDir", &advice_amworkdir },
-	{ "rmHints", &advice_rm_hints },
-	{ "addEmbeddedRepo", &advice_add_embedded_repo },
-	{ "ignoredHook", &advice_ignored_hook },
-	{ "waitingForEditor", &advice_waiting_for_editor },
-	{ "graftFileDeprecated", &advice_graft_file_deprecated },
-	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remote_branch_name },
-	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
-	{ "addIgnoredFile", &advice_add_ignored_file },
-	{ "addEmptyPathspec", &advice_add_empty_pathspec },
-
-	/* make this an alias for backward compatibility */
-	{ "pushNonFastForward", &advice_push_update_rejected }
-};
-
 static struct {
 	const char *key;
 	int enabled;
@@ -228,13 +158,6 @@ int git_default_advice_config(const char *var, const char *value)
 	if (!skip_prefix(var, "advice.", &k))
 		return 0;
 
-	for (i = 0; i < ARRAY_SIZE(advice_config); i++) {
-		if (strcasecmp(k, advice_config[i].name))
-			continue;
-		*advice_config[i].preference = git_config_bool(var, value);
-		break;
-	}
-
 	for (i = 0; i < ARRAY_SIZE(advice_setting); i++) {
 		if (strcasecmp(k, advice_setting[i].key))
 			continue;
diff --git a/advice.h b/advice.h
index 101c4054b7..17ee5d3633 100644
--- a/advice.h
+++ b/advice.h
@@ -5,37 +5,6 @@
 
 struct string_list;
 
-extern int advice_fetch_show_forced_updates;
-extern int advice_push_update_rejected;
-extern int advice_push_non_ff_current;
-extern int advice_push_non_ff_matching;
-extern int advice_push_already_exists;
-extern int advice_push_fetch_first;
-extern int advice_push_needs_force;
-extern int advice_push_unqualified_ref_name;
-extern int advice_push_ref_needs_update;
-extern int advice_status_hints;
-extern int advice_status_u_option;
-extern int advice_status_ahead_behind_warning;
-extern int advice_commit_before_merge;
-extern int advice_reset_quiet_warning;
-extern int advice_resolve_conflict;
-extern int advice_sequencer_in_use;
-extern int advice_implicit_identity;
-extern int advice_detached_head;
-extern int advice_set_upstream_failure;
-extern int advice_object_name_warning;
-extern int advice_amworkdir;
-extern int advice_rm_hints;
-extern int advice_add_embedded_repo;
-extern int advice_ignored_hook;
-extern int advice_waiting_for_editor;
-extern int advice_graft_file_deprecated;
-extern int advice_checkout_ambiguous_remote_branch_name;
-extern int advice_submodule_alternate_error_strategy_die;
-extern int advice_add_ignored_file;
-extern int advice_add_empty_pathspec;
-
 /*
  * To add a new advice, you need to:
  * Define a new advice_type.
-- 
2.31.1

