Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138C1C433FE
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 019376120D
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhJDCAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 22:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbhJDCAT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 22:00:19 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ADBC0613EC
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 18:58:31 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m22so22373416wrb.0
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 18:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+/D3A1XDpemrxg+52RCGlQ/4BirZwPqERG6Ya9OYdU0=;
        b=ANuaq+esNS30v6yT/VPnprUQA2w3LrIsaF0z85+OoA7505A52amj+Ejo1KFVprKM8a
         Mkg1c6mQD7W3wbvmBbezAWpXho8VfiWEUq5+wBEnZH/83o73iKRY52g+gmwnZ7/u//ll
         7gRTBGGiAYhfVIjsT6FfpMBL+Tf1fSw0ua/Wl3ZDzBQ9iuHyQ1IQeC+S7fB3hISM8M3a
         tR2umptG8P9c3w9r5neZn7/je/1h0TcLi1uuH5bo11Oh2s1f9c86NGsEmpWpz9XjsN4C
         goXeyzCjYqDgWbZNIK9f44fXHKO0rE69Dqe1R315ul8lt1xrKfs6f0MgL17+KEyF2N8y
         3NuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+/D3A1XDpemrxg+52RCGlQ/4BirZwPqERG6Ya9OYdU0=;
        b=wpC9g28v/sR+SgSz1wJcxNF4XwhY1pQinnCVbaNWhj8zdDqdT5CIf3h5K+2Pvhwq5G
         yyRqk8AqACs+YS12Yan/p+k5YbQibgxXH21oo/LXCYSSQ/cGLwHLFlbOQkW1eBsBmqyz
         YhZeUVGr9rFe+1H/8yRG0W+8GvySxrCDtk3+AyfRC0O3lrtgRqdHO+Oz2/p1OZChyNJh
         OpuwtWJA3AWbfHty2jPCiwpnb590M/1LnVlym+zJcbvTteIUzBHYkFZ6Zrz2I73XGbuD
         x66qF6Y9oIG0x57y+XUHt6l7K/+UW/C8K+6nWioVDhXGkifZM6yx0AdLvc+GVvf+8kas
         3WoA==
X-Gm-Message-State: AOAM532R1VYwBkz2ZaJU2lKvSPyB983jExO2LbXrx5ajSlRxi+x5VY0i
        T2xcwGKybZFvDKhErTFrhhL/UnzlstXBOw==
X-Google-Smtp-Source: ABdhPJyzj/JU5A3R9bu1lcaG5iZ5XJsPZRxIx6h2u7J3XUGxI8oDBcdl8bU/38VP2dVvWi05pY09zA==
X-Received: by 2002:a05:6000:1544:: with SMTP id 4mr11367161wry.370.1633312709574;
        Sun, 03 Oct 2021 18:58:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y23sm15349355wmi.16.2021.10.03.18.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 18:58:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Boeckel <mathstuf@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Heba Waly <heba.waly@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] advice API: revamp the API, again
Date:   Mon,  4 Oct 2021 03:58:23 +0200
Message-Id: <patch-4.5-25f6f5cd018-20211004T015432Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g7bcfc82b295
In-Reply-To: <cover-0.5-00000000000-20211004T015432Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20211004T015432Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow-up b3b18d16213 (advice: revamp advise API, 2020-03-02) and
revamp the declaration of the advice variables to:

 * Make it trivial to grep for them, by giving them the "advice."
   prefix explicitly, which also saves us from stripping it off
   during config parsing.

 * All of the advice is enabled by default, so we can do this more
   succinctly by having a "disabled" slot, instead of "enabled", and
   then rely on the compiler to implicitly zero out the struct.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 advice.c | 81 +++++++++++++++++++++++++++-----------------------------
 1 file changed, 39 insertions(+), 42 deletions(-)

diff --git a/advice.c b/advice.c
index b395bc7d187..f7cedac7549 100644
--- a/advice.c
+++ b/advice.c
@@ -33,46 +33,46 @@ static const char *advise_get_color(enum color_advice ix)
 
 static struct {
 	const char *key;
-	int enabled;
+	int disabled;
 } advice_setting[] = {
-	[ADVICE_ADD_EMBEDDED_REPO]			= { "addEmbeddedRepo", 1 },
-	[ADVICE_ADD_EMPTY_PATHSPEC]			= { "addEmptyPathspec", 1 },
-	[ADVICE_ADD_IGNORED_FILE]			= { "addIgnoredFile", 1 },
-	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir", 1 },
-	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName", 1 },
-	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge", 1 },
-	[ADVICE_DETACHED_HEAD]				= { "detachedHead", 1 },
-	[ADVICE_FETCH_SHOW_FORCED_UPDATES]		= { "fetchShowForcedUpdates", 1 },
-	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated", 1 },
-	[ADVICE_IGNORED_HOOK]				= { "ignoredHook", 1 },
-	[ADVICE_IMPLICIT_IDENTITY]			= { "implicitIdentity", 1 },
-	[ADVICE_NESTED_TAG]				= { "nestedTag", 1 },
-	[ADVICE_OBJECT_NAME_WARNING]			= { "objectNameWarning", 1 },
-	[ADVICE_PUSH_ALREADY_EXISTS]			= { "pushAlreadyExists", 1 },
-	[ADVICE_PUSH_FETCH_FIRST]			= { "pushFetchFirst", 1 },
-	[ADVICE_PUSH_NEEDS_FORCE]			= { "pushNeedsForce", 1 },
-	[ADVICE_PUSH_REF_NEEDS_UPDATE]			= { "pushRefNeedsUpdate", 1 },
-	[ADVICE_PUSH_NON_FF_CURRENT]			= { "pushNonFFCurrent", 1 },
-	[ADVICE_PUSH_NON_FF_MATCHING]			= { "pushNonFFMatching", 1 },
-	[ADVICE_PUSH_UNQUALIFIED_REF_NAME]		= { "pushUnqualifiedRefName", 1 },
-	[ADVICE_PUSH_UPDATE_REJECTED]			= { "pushUpdateRejected", 1 },
-	[ADVICE_RESET_QUIET_WARNING]			= { "resetQuiet", 1 },
-	[ADVICE_RESOLVE_CONFLICT]			= { "resolveConflict", 1 },
-	[ADVICE_RM_HINTS]				= { "rmHints", 1 },
-	[ADVICE_SEQUENCER_IN_USE]			= { "sequencerInUse", 1 },
-	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure", 1 },
-	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks", 1 },
-	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "statusAheadBehindWarning", 1 },
-	[ADVICE_STATUS_HINTS]				= { "statusHints", 1 },
-	[ADVICE_STATUS_U_OPTION]			= { "statusUoption", 1 },
-	[ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = { "submoduleAlternateErrorStrategyDie", 1 },
-	[ADVICE_UPDATE_SPARSE_PATH]			= { "updateSparsePath", 1 },
-	[ADVICE_WAITING_FOR_EDITOR]			= { "waitingForEditor", 1 },
+	[ADVICE_ADD_EMBEDDED_REPO]			= { "advice.addEmbeddedRepo" },
+	[ADVICE_ADD_EMPTY_PATHSPEC]			= { "advice.addEmptyPathspec" },
+	[ADVICE_ADD_IGNORED_FILE]			= { "advice.addIgnoredFile" },
+	[ADVICE_AM_WORK_DIR] 				= { "advice.amWorkDir" },
+	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "advice.checkoutAmbiguousRemoteBranchName" },
+	[ADVICE_COMMIT_BEFORE_MERGE]			= { "advice.commitBeforeMerge" },
+	[ADVICE_DETACHED_HEAD]				= { "advice.detachedHead" },
+	[ADVICE_FETCH_SHOW_FORCED_UPDATES]		= { "advice.fetchShowForcedUpdates" },
+	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "advice.graftFileDeprecated" },
+	[ADVICE_IGNORED_HOOK]				= { "advice.ignoredHook" },
+	[ADVICE_IMPLICIT_IDENTITY]			= { "advice.implicitIdentity" },
+	[ADVICE_NESTED_TAG]				= { "advice.nestedTag" },
+	[ADVICE_OBJECT_NAME_WARNING]			= { "advice.objectNameWarning" },
+	[ADVICE_PUSH_ALREADY_EXISTS]			= { "advice.pushAlreadyExists" },
+	[ADVICE_PUSH_FETCH_FIRST]			= { "advice.pushFetchFirst" },
+	[ADVICE_PUSH_NEEDS_FORCE]			= { "advice.pushNeedsForce" },
+	[ADVICE_PUSH_REF_NEEDS_UPDATE]			= { "advice.pushRefNeedsUpdate" },
+	[ADVICE_PUSH_NON_FF_CURRENT]			= { "advice.pushNonFFCurrent" },
+	[ADVICE_PUSH_NON_FF_MATCHING]			= { "advice.pushNonFFMatching" },
+	[ADVICE_PUSH_UNQUALIFIED_REF_NAME]		= { "advice.pushUnqualifiedRefName" },
+	[ADVICE_PUSH_UPDATE_REJECTED]			= { "advice.pushUpdateRejected" },
+	[ADVICE_RESET_QUIET_WARNING]			= { "advice.resetQuiet" },
+	[ADVICE_RESOLVE_CONFLICT]			= { "advice.resolveConflict" },
+	[ADVICE_RM_HINTS]				= { "advice.rmHints" },
+	[ADVICE_SEQUENCER_IN_USE]			= { "advice.sequencerInUse" },
+	[ADVICE_SET_UPSTREAM_FAILURE]			= { "advice.setUpstreamFailure" },
+	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "advice.skippedCherryPicks" },
+	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "advice.statusAheadBehindWarning" },
+	[ADVICE_STATUS_HINTS]				= { "advice.statusHints" },
+	[ADVICE_STATUS_U_OPTION]			= { "advice.statusUoption" },
+	[ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = { "advice.submoduleAlternateErrorStrategyDie" },
+	[ADVICE_UPDATE_SPARSE_PATH]			= { "advice.updateSparsePath" },
+	[ADVICE_WAITING_FOR_EDITOR]			= { "advice.waitingForEditor" },
 };
 
 static const char turn_off_instructions[] =
 N_("\n"
-   "Disable this message with \"git config advice.%s false\"");
+   "Disable this message with \"git config %s false\"");
 
 static void vadvise(const char *advice, int display_instructions,
 		    const char *key, va_list params)
@@ -112,7 +112,7 @@ void advise(const char *advice, ...)
 
 int advice_enabled(enum advice_type type)
 {
-	return advice_setting[type].enabled;
+	return !advice_setting[type].disabled;
 }
 
 void advise_if_enabled(enum advice_type type, const char *advice, ...)
@@ -129,7 +129,7 @@ void advise_if_enabled(enum advice_type type, const char *advice, ...)
 
 int git_default_advice_config(const char *var, const char *value)
 {
-	const char *k, *slot_name;
+	const char *slot_name;
 	int i;
 
 	if (!strcmp(var, "color.advice")) {
@@ -146,13 +146,10 @@ int git_default_advice_config(const char *var, const char *value)
 		return color_parse(value, advice_colors[slot]);
 	}
 
-	if (!skip_prefix(var, "advice.", &k))
-		return 0;
-
 	for (i = 0; i < ARRAY_SIZE(advice_setting); i++) {
-		if (strcasecmp(k, advice_setting[i].key))
+		if (strcasecmp(var, advice_setting[i].key))
 			continue;
-		advice_setting[i].enabled = git_config_bool(var, value);
+		advice_setting[i].disabled = !git_config_bool(var, value);
 		return 0;
 	}
 
-- 
2.33.0.1404.g7bcfc82b295

