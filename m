Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C9411F42D
	for <e@80x24.org>; Sat, 26 May 2018 12:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031592AbeEZMJC (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 08:09:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52049 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031444AbeEZMI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 08:08:56 -0400
Received: by mail-wm0-f67.google.com with SMTP id j4-v6so20757946wme.1
        for <git@vger.kernel.org>; Sat, 26 May 2018 05:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OT4MTk6jBHIVmMPONZuvqeL5IK/RiGtzE74fDJ7bVxo=;
        b=XA1zXs10L4AfJ1Jrw1qKv2hyzf9XgqrYEkoKgQvOx8CL5G/9PT6ChinWfXKiR9r2TZ
         N5xF32lhC2KwyJ4G3Y5ZxHYEw8G/8jd9h3Hr0mqFjdvEYoOcqpwwvppuzXF1fZ2VTWm6
         jEGAXOvudSGnODg0xOyQw0ZLsAIy+S4Pu7ElmKFZBGP61+1ugxNuofeoMjcmRhGNplr9
         eiZfpRTWLPVzTZMitTwNs4TmvspwaZIYyNPdZqt491S1JEllLQJJdz1ARSHE9rJ5ZPuz
         PrBnjrnqHJzeAilW73+ubB5GNrdpJdmXi+4QGmMtGWf/KBTXybQl15ZOdjB2T9YcrGJW
         Z42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OT4MTk6jBHIVmMPONZuvqeL5IK/RiGtzE74fDJ7bVxo=;
        b=nQ4yvThhXJqfA6FXbhHX2H3mIa/aRqSIrj6VYVEGf9h54Hc8fujmnHnaOWGihQTh8G
         MpvberzSfcNUSsYL8etSkl8Ave0My5C65kTD5PF/uI90rdUafx/Pz8GXVepx4u78eet8
         RWwvZD4a9HzmV5nSEzXzJzx9EzURiCcqgwcHqVVFRomeE6pF43I1YjsilaPXGeErIqPy
         LwWC4Ly6qZBNKToO8ofNpvUQsyEy3CvoWOAGfHOgYez/FWg3YfSWPqIjHAiPeVcINg8Q
         FvTh51MDqcvTgbONAJrzZYn0ToSOCawufnfsRtXFXfZIxhxzwM3GKLgRpkQXuJYLpNHe
         bOig==
X-Gm-Message-State: ALKqPwf9StDrtP1uOpR+yYDtv8s9NVm/x7nf06ksbAZZRbxs3qA9LTi7
        DCjQEe55HyPb0Zlkg7j3GjU=
X-Google-Smtp-Source: ADUXVKJB+1gQyWWsY0rP9+IQUzXSArn/VrhC9u5W9em8uo8Zd+kZNpGolg2J4NYzS1aQaZjdtGlrHQ==
X-Received: by 2002:a2e:8759:: with SMTP id q25-v6mr4031929ljj.66.1527336534792;
        Sat, 26 May 2018 05:08:54 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r81-v6sm4789574lja.36.2018.05.26.05.08.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 May 2018 05:08:53 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 4/4] apply: add --intent-to-add
Date:   Sat, 26 May 2018 14:08:46 +0200
Message-Id: <20180526120846.23663-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180526120846.23663-1-pclouds@gmail.com>
References: <20180513175438.32152-1-pclouds@gmail.com>
 <20180526120846.23663-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to 'git reset -N', this option makes 'git apply' automatically
mark new files as intent-to-add so they are visible in the following
'git diff' command and could also be committed with 'git commit -a'.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-apply.txt | 10 +++++++++-
 apply.c                     | 19 ++++++++++++-------
 apply.h                     |  1 +
 t/t2203-add-intent.sh       | 13 +++++++++++++
 4 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 4ebc3d3271..e3b966c656 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -9,7 +9,7 @@ git-apply - Apply a patch to files and/or to the index
 SYNOPSIS
 --------
 [verse]
-'git apply' [--stat] [--numstat] [--summary] [--check] [--index] [--3way]
+'git apply' [--stat] [--numstat] [--summary] [--check] [--index | --intent-to-add] [--3way]
 	  [--apply] [--no-add] [--build-fake-ancestor=<file>] [-R | --reverse]
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
 	  [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
@@ -74,6 +74,14 @@ OPTIONS
 	cached data, apply the patch, and store the result in the index
 	without using the working tree. This implies `--index`.
 
+--intent-to-add::
+	When applying the patch only to the working tree, mark new
+	files to be added to the index later (see `--intent-to-add`
+	option in linkgit:git-add[1]). This option is ignored unless
+	running in a Git repository and `--index` is not specified.
+	Note that `--index` could be implied by other options such
+	as `--cached` or `--3way`.
+
 -3::
 --3way::
 	When the patch does not apply cleanly, fall back on 3-way merge if
diff --git a/apply.c b/apply.c
index 7e5792c996..899c5cc0ac 100644
--- a/apply.c
+++ b/apply.c
@@ -141,6 +141,8 @@ int check_apply_state(struct apply_state *state, int force_apply)
 			return error(_("--cached outside a repository"));
 		state->check_index = 1;
 	}
+	if (state->ita_only && (state->check_index || is_not_gitdir))
+		state->ita_only = 0;
 	if (state->check_index)
 		state->unsafe_paths = 0;
 
@@ -4242,7 +4244,7 @@ static void patch_stats(struct apply_state *state, struct patch *patch)
 
 static int remove_file(struct apply_state *state, struct patch *patch, int rmdir_empty)
 {
-	if (state->update_index) {
+	if (state->update_index && !state->ita_only) {
 		if (remove_file_from_cache(patch->old_name) < 0)
 			return error(_("unable to remove %s from index"), patch->old_name);
 	}
@@ -4265,15 +4267,15 @@ static int add_index_file(struct apply_state *state,
 	int namelen = strlen(path);
 	unsigned ce_size = cache_entry_size(namelen);
 
-	if (!state->update_index)
-		return 0;
-
 	ce = xcalloc(1, ce_size);
 	memcpy(ce->name, path, namelen);
 	ce->ce_mode = create_ce_mode(mode);
 	ce->ce_flags = create_ce_flags(0);
 	ce->ce_namelen = namelen;
-	if (S_ISGITLINK(mode)) {
+	if (state->ita_only) {
+		ce->ce_flags |= CE_INTENT_TO_ADD;
+		set_object_name_for_intent_to_add_entry(ce);
+	} else if (S_ISGITLINK(mode)) {
 		const char *s;
 
 		if (!skip_prefix(buf, "Subproject commit ", &s) ||
@@ -4465,8 +4467,9 @@ static int create_file(struct apply_state *state, struct patch *patch)
 
 	if (patch->conflicted_threeway)
 		return add_conflicted_stages_file(state, patch);
-	else
+	else if (state->update_index)
 		return add_index_file(state, path, mode, buf, size);
+	return 0;
 }
 
 /* phase zero is to remove, phase one is to create */
@@ -4686,7 +4689,7 @@ static int apply_patch(struct apply_state *state,
 	if (state->whitespace_error && (state->ws_error_action == die_on_ws_error))
 		state->apply = 0;
 
-	state->update_index = state->check_index && state->apply;
+	state->update_index = (state->check_index || state->ita_only) && state->apply;
 	if (state->update_index && !is_lock_file_locked(&state->lock_file)) {
 		if (state->index_file)
 			hold_lock_file_for_update(&state->lock_file,
@@ -4941,6 +4944,8 @@ int apply_parse_options(int argc, const char **argv,
 			N_("instead of applying the patch, see if the patch is applicable")),
 		OPT_BOOL(0, "index", &state->check_index,
 			N_("make sure the patch is applicable to the current index")),
+		OPT_BOOL('N', "intent-to-add", &state->ita_only,
+			N_("mark new files with `git add --intent-to-add`")),
 		OPT_BOOL(0, "cached", &state->cached,
 			N_("apply a patch without touching the working tree")),
 		OPT_BOOL_F(0, "unsafe-paths", &state->unsafe_paths,
diff --git a/apply.h b/apply.h
index dc4a019057..b80d8ba736 100644
--- a/apply.h
+++ b/apply.h
@@ -45,6 +45,7 @@ struct apply_state {
 	int check; /* preimage must match working tree, don't actually apply */
 	int check_index; /* preimage must match the indexed version */
 	int update_index; /* check_index && apply */
+	int ita_only;	  /* add intent-to-add entries to the index */
 
 	/* These control cosmetic aspect of the output */
 	int diffstat; /* just show a diffstat, and don't actually apply */
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 546fead6ad..0891827863 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -245,6 +245,7 @@ test_expect_success 'diff-files/diff-cached shows ita as new/not-new files' '
 	test_cmp expected2 actual2
 '
 
+
 test_expect_success '"diff HEAD" includes ita as new files' '
 	git reset --hard &&
 	echo new >new-ita &&
@@ -262,4 +263,16 @@ test_expect_success '"diff HEAD" includes ita as new files' '
 	test_cmp expected actual
 '
 
+test_expect_success 'apply --intent-to-add' '
+	git reset --hard &&
+	echo new >new-ita &&
+	git add -N new-ita &&
+	git diff >expected &&
+	grep "new file" expected &&
+	git reset --hard &&
+	git apply --intent-to-add expected &&
+	git diff >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.17.0.705.g3525833791

