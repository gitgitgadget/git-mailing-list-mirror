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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360A0C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 19:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1980C60FE7
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 19:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243378AbhHFTNj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 15:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhHFTNj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 15:13:39 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566B6C0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 12:13:22 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b11so12345491wrx.6
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 12:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kPytfpQ/LlIAvB5JwL3ZpmnW+hltaKPzGMt91Nlj0Wg=;
        b=I3xpoSMTyLmtpj5FKFI4qFasJWel1ARRspFBcNhurar8ScwLyp9Sg62pVGEKTIuS1L
         Mm6jAuUF6auC0rBcGrPecPdjWke5c7sqNqhAcEFNYKMjyxp/Ah7qBNKA/SeGI9jRBW6D
         pSkUYmPJOsTOKw3+NYbgX87huiTkHTluCBhXVtu0GxEf6cpPxP/u4qs3cu4cwCyDAlys
         KXBPHNYCocZWz3k7SUjBBRA3eT8QsGCpWNBp5abXcvIqC/UPA3oyQcBN+W0pKxH92R4Q
         SSuayvCg+ikFkW845zoDFE2lvQ6FJbLgRWxTmddMUlUWlMxJCDY/syEnNl/vevmNh9LT
         Au9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kPytfpQ/LlIAvB5JwL3ZpmnW+hltaKPzGMt91Nlj0Wg=;
        b=iFN675E21noV6IM5Kxvr0CRK9CsKK81W53enWE/2CgzMA9tyhL+SreRonmMeKVk69l
         CVACI0UjTkeg/s9E55rgOsHAbE1V23Y18HyFO+f28ypLNdm9o1KDsIN+5AZZZUKPv4Ih
         JdfHiU+oIZOpWhni1hqefDmav93GLPsMiijeUEEigH78o0iypYTQVZwVfZ2Tm+ZmAp+z
         pRxjY3Gb44ZP9K4OrIdm6vBzLzWvZ2nB1lm5fl7V5NYC8SszDmcGg1CMdnYGHEnsg3JO
         uIATi743v1kg28dLC9lEWo4hX2vxpBnj2okk/c0B1mq1XgERFsUIjkNLUVRpPPwrXn9E
         Xb3g==
X-Gm-Message-State: AOAM53058YJYwoW+C5PCLKf6gN4IWBam+Knz1Je2r1FtgEzzowtXTjb0
        t6L1OXbGRr0Ra1OdzBl4Lgp4iX962GI=
X-Google-Smtp-Source: ABdhPJzkRMuI/prPoOIypo1VTqQA52alrF4EF7mlW7fLyc/nsmAR3GX8pdOdIdX+QRCnlcMswZHhGA==
X-Received: by 2002:adf:e68d:: with SMTP id r13mr12373263wrm.393.1628277200460;
        Fri, 06 Aug 2021 12:13:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r12sm11039849wrn.31.2021.08.06.12.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 12:13:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v3 0/4] advice: remove usage of `advice_*` global variables
Date:   Fri,  6 Aug 2021 21:13:14 +0200
Message-Id: <RFC-cover-v3-0.4-0000000000-20210806T191231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.680.gf07173a897a
In-Reply-To: <20210805230321.532218-1-mathstuf@gmail.com>
References: <20210805230321.532218-1-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While reviewing
https://lore.kernel.org/git/20210805230321.532218-1-mathstuf@gmail.com/
today I started fixing it up locally. So in liue of inline commentary
here's the fixups I had.

There's mid-series breakages in the v2, because two variables are
moved over to the new API, with their users left at the old API until
the end. This fixes that up by migrating most of the variables, and
then incrementally dealing with the two remaining cases.

In one case we don't want to emit a warning twice, so a scope-local
static variable seems better than the new advice_set(), and in the
case of the graft advise() it seemed better to keep it global, but
move it over to commit.[ch].

We thus do away entirely with the need for the new advice_s

Ben Boeckel (2):
  advice: add enum variants for missing advice variables
  advice: remove read uses of most global `advice_` variables

Ævar Arnfjörð Bjarmason (2):
  advice: remove use of global advice_add_embedded_repo
  advice: move advice.graftFileDeprecated squashing to commit.[ch]

 advice.c                    | 83 ++-----------------------------------
 advice.h                    | 33 +--------------
 branch.c                    |  2 +-
 builtin/add.c               | 11 ++---
 builtin/am.c                |  2 +-
 builtin/checkout.c          |  6 +--
 builtin/clone.c             |  2 +-
 builtin/commit.c            |  4 +-
 builtin/fetch.c             |  2 +-
 builtin/merge.c             |  4 +-
 builtin/push.c              | 12 +++---
 builtin/replace.c           |  2 +-
 builtin/reset.c             |  2 +-
 builtin/rm.c                |  2 +-
 builtin/submodule--helper.c |  2 +-
 commit.c                    |  4 +-
 commit.h                    |  1 +
 editor.c                    |  2 +-
 notes-merge.c               |  2 +-
 object-name.c               |  2 +-
 remote.c                    | 12 +++---
 run-command.c               |  2 +-
 sequencer.c                 |  8 ++--
 unpack-trees.c              | 18 ++++----
 wt-status.c                 |  6 +--
 25 files changed, 63 insertions(+), 163 deletions(-)

Range-diff against v2:
1:  97743eb4dc ! 1:  5f934bb083 advice: add enum variants for missing advice variables
    @@ Commit message
         `advice_setting`.
     
         Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## advice.c ##
     @@ advice.c: static struct {
2:  bc6311304a ! 2:  eefcafcf8f advice: remove read uses of global `advice_` variables
    @@ Metadata
     Author: Ben Boeckel <mathstuf@gmail.com>
     
      ## Commit message ##
    -    advice: remove read uses of global `advice_` variables
    +    advice: remove read uses of most global `advice_` variables
     
         In c4a09cc9ccb (Merge branch 'hw/advise-ng', 2020-03-25), a new API for
         accessing advice variables was introduced and deprecated `advice_config`
         in favor of a new array, `advice_setting`.
     
    -    This patch ports all uses which read the status of the global `advice_`
    -    variables over to the new `advice_enabled` API.
    +    This patch ports all but two uses which read the status of the global
    +    `advice_` variables over to the new `advice_enabled` API. We'll deal
    +    with advice_add_embedded_repo and advice_graft_file_deprecated
    +    seperately.
     
         Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## advice.c ##
    +@@
    + #include "help.h"
    + #include "string-list.h"
    + 
    +-int advice_fetch_show_forced_updates = 1;
    +-int advice_push_update_rejected = 1;
    +-int advice_push_non_ff_current = 1;
    +-int advice_push_non_ff_matching = 1;
    +-int advice_push_already_exists = 1;
    +-int advice_push_fetch_first = 1;
    +-int advice_push_needs_force = 1;
    +-int advice_push_unqualified_ref_name = 1;
    +-int advice_push_ref_needs_update = 1;
    +-int advice_status_hints = 1;
    +-int advice_status_u_option = 1;
    +-int advice_status_ahead_behind_warning = 1;
    +-int advice_commit_before_merge = 1;
    +-int advice_reset_quiet_warning = 1;
    +-int advice_resolve_conflict = 1;
    +-int advice_sequencer_in_use = 1;
    +-int advice_implicit_identity = 1;
    +-int advice_detached_head = 1;
    +-int advice_set_upstream_failure = 1;
    +-int advice_object_name_warning = 1;
    +-int advice_amworkdir = 1;
    +-int advice_rm_hints = 1;
    + int advice_add_embedded_repo = 1;
    +-int advice_ignored_hook = 1;
    +-int advice_waiting_for_editor = 1;
    + int advice_graft_file_deprecated = 1;
    +-int advice_checkout_ambiguous_remote_branch_name = 1;
    +-int advice_submodule_alternate_error_strategy_die = 1;
    +-int advice_add_ignored_file = 1;
    +-int advice_add_empty_pathspec = 1;
    + 
    + static int advice_use_color = -1;
    + static char advice_colors[][COLOR_MAXLEN] = {
    +@@ advice.c: static struct {
    + 	const char *name;
    + 	int *preference;
    + } advice_config[] = {
    +-	{ "fetchShowForcedUpdates", &advice_fetch_show_forced_updates },
    +-	{ "pushUpdateRejected", &advice_push_update_rejected },
    +-	{ "pushNonFFCurrent", &advice_push_non_ff_current },
    +-	{ "pushNonFFMatching", &advice_push_non_ff_matching },
    +-	{ "pushAlreadyExists", &advice_push_already_exists },
    +-	{ "pushFetchFirst", &advice_push_fetch_first },
    +-	{ "pushNeedsForce", &advice_push_needs_force },
    +-	{ "pushUnqualifiedRefName", &advice_push_unqualified_ref_name },
    +-	{ "pushRefNeedsUpdate", &advice_push_ref_needs_update },
    +-	{ "statusHints", &advice_status_hints },
    +-	{ "statusUoption", &advice_status_u_option },
    +-	{ "statusAheadBehindWarning", &advice_status_ahead_behind_warning },
    +-	{ "commitBeforeMerge", &advice_commit_before_merge },
    +-	{ "resetQuiet", &advice_reset_quiet_warning },
    +-	{ "resolveConflict", &advice_resolve_conflict },
    +-	{ "sequencerInUse", &advice_sequencer_in_use },
    +-	{ "implicitIdentity", &advice_implicit_identity },
    +-	{ "detachedHead", &advice_detached_head },
    +-	{ "setUpstreamFailure", &advice_set_upstream_failure },
    +-	{ "objectNameWarning", &advice_object_name_warning },
    +-	{ "amWorkDir", &advice_amworkdir },
    +-	{ "rmHints", &advice_rm_hints },
    + 	{ "addEmbeddedRepo", &advice_add_embedded_repo },
    +-	{ "ignoredHook", &advice_ignored_hook },
    +-	{ "waitingForEditor", &advice_waiting_for_editor },
    + 	{ "graftFileDeprecated", &advice_graft_file_deprecated },
    +-	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remote_branch_name },
    +-	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
    +-	{ "addIgnoredFile", &advice_add_ignored_file },
    +-	{ "addEmptyPathspec", &advice_add_empty_pathspec },
    +-
    +-	/* make this an alias for backward compatibility */
    +-	{ "pushNonFastForward", &advice_push_update_rejected }
    + };
    + 
    + static struct {
     @@ advice.c: int error_resolve_conflict(const char *me)
      		error(_("It is not possible to %s because you have unmerged files."),
      			me);
    @@ advice.c: void NORETURN die_resolve_conflict(const char *me)
      	die(_("Exiting because of unfinished merge."));
      }
     
    + ## advice.h ##
    +@@
    + 
    + struct string_list;
    + 
    +-extern int advice_fetch_show_forced_updates;
    +-extern int advice_push_update_rejected;
    +-extern int advice_push_non_ff_current;
    +-extern int advice_push_non_ff_matching;
    +-extern int advice_push_already_exists;
    +-extern int advice_push_fetch_first;
    +-extern int advice_push_needs_force;
    +-extern int advice_push_unqualified_ref_name;
    +-extern int advice_push_ref_needs_update;
    +-extern int advice_status_hints;
    +-extern int advice_status_u_option;
    +-extern int advice_status_ahead_behind_warning;
    +-extern int advice_commit_before_merge;
    +-extern int advice_reset_quiet_warning;
    +-extern int advice_resolve_conflict;
    +-extern int advice_sequencer_in_use;
    +-extern int advice_implicit_identity;
    +-extern int advice_detached_head;
    +-extern int advice_set_upstream_failure;
    +-extern int advice_object_name_warning;
    +-extern int advice_amworkdir;
    +-extern int advice_rm_hints;
    + extern int advice_add_embedded_repo;
    +-extern int advice_ignored_hook;
    +-extern int advice_waiting_for_editor;
    + extern int advice_graft_file_deprecated;
    +-extern int advice_checkout_ambiguous_remote_branch_name;
    +-extern int advice_submodule_alternate_error_strategy_die;
    +-extern int advice_add_ignored_file;
    +-extern int advice_add_empty_pathspec;
    + 
    + /*
    +  * To add a new advice, you need to:
    +
      ## branch.c ##
     @@ branch.c: void create_branch(struct repository *r,
      	real_ref = NULL;
    @@ branch.c: void create_branch(struct repository *r,
      				exit(1);
     
      ## builtin/add.c ##
    -@@ builtin/add.c: static void check_embedded_repo(const char *path)
    - 	strbuf_strip_suffix(&name, "/");
    - 
    - 	warning(_("adding embedded git repository: %s"), name.buf);
    --	if (advice_add_embedded_repo) {
    -+	if (advice_enabled(ADVICE_ADD_EMBEDDED_REPO)) {
    - 		advise(embedded_advice, name.buf, name.buf);
    - 		/* there may be multiple entries; advise only once */
    - 		advice_add_embedded_repo = 0;
     @@ builtin/add.c: static int add_files(struct dir_struct *dir, int flags)
      		fprintf(stderr, _(ignore_error));
      		for (i = 0; i < dir->ignored_nr; i++)
    @@ builtin/submodule--helper.c: static int add_possible_reference_from_superproject
      				die(_("submodule '%s' cannot add alternate: %s"),
      				    sas->submodule_name, err.buf);
     
    - ## commit.c ##
    -@@ commit.c: static int read_graft_file(struct repository *r, const char *graft_file)
    - 	struct strbuf buf = STRBUF_INIT;
    - 	if (!fp)
    - 		return -1;
    --	if (advice_graft_file_deprecated)
    -+	if (advice_enabled(ADVICE_GRAFT_FILE_DEPRECATED))
    - 		advise(_("Support for <GIT_DIR>/info/grafts is deprecated\n"
    - 			 "and will be removed in a future Git version.\n"
    - 			 "\n"
    -
      ## editor.c ##
     @@ editor.c: static int launch_specified_editor(const char *editor, const char *path,
      		const char *args[] = { editor, NULL, NULL };
3:  c044f6a6d7 < -:  ---------- advice: add `advice_set` to update advice settings at runtime
-:  ---------- > 3:  02613d0f30 advice: remove use of global advice_add_embedded_repo
4:  644709115f ! 4:  fe6f6328f9 advice: remove static global variables for advice tracking
    @@
      ## Metadata ##
    -Author: Ben Boeckel <mathstuf@gmail.com>
    +Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    advice: remove static global variables for advice tracking
    +    advice: move advice.graftFileDeprecated squashing to commit.[ch]
     
    -    All of the preferences are now tracked as part of the `advice_setting`
    -    array and all consumers of the global variables have been removed, so
    -    the parallel tracking through `advice_config` is no longer necessary.
    +    Move the squashing of the advice.graftFileDeprecated advice over to an
    +    external variable in commit.[ch], allowing advice() to purely use the
    +    new-style API of invoking advice() with an enum.
     
    -    This concludes the move from the old advice API to the new one
    -    introduced via c4a09cc9ccb (Merge branch 'hw/advise-ng', 2020-03-25).
    +    See 8821e90a09a (advice: don't pointlessly suggest
    +    --convert-graft-file, 2018-11-27) for why quieting this advice was
    +    needed. It's more straightforward to move this code to commit.[ch] and
    +    use it builtin/replace.c, than to go through the indirection of
    +    advice.[ch].
     
    -    Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
    +    Because this was the last advice_config variable we can remove that
    +    old facility from advice.c.
    +
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## advice.c ##
     @@
      #include "help.h"
      #include "string-list.h"
      
    --int advice_fetch_show_forced_updates = 1;
    --int advice_push_update_rejected = 1;
    --int advice_push_non_ff_current = 1;
    --int advice_push_non_ff_matching = 1;
    --int advice_push_already_exists = 1;
    --int advice_push_fetch_first = 1;
    --int advice_push_needs_force = 1;
    --int advice_push_unqualified_ref_name = 1;
    --int advice_push_ref_needs_update = 1;
    --int advice_status_hints = 1;
    --int advice_status_u_option = 1;
    --int advice_status_ahead_behind_warning = 1;
    --int advice_commit_before_merge = 1;
    --int advice_reset_quiet_warning = 1;
    --int advice_resolve_conflict = 1;
    --int advice_sequencer_in_use = 1;
    --int advice_implicit_identity = 1;
    --int advice_detached_head = 1;
    --int advice_set_upstream_failure = 1;
    --int advice_object_name_warning = 1;
    --int advice_amworkdir = 1;
    --int advice_rm_hints = 1;
    --int advice_add_embedded_repo = 1;
    --int advice_ignored_hook = 1;
    --int advice_waiting_for_editor = 1;
     -int advice_graft_file_deprecated = 1;
    --int advice_checkout_ambiguous_remote_branch_name = 1;
    --int advice_submodule_alternate_error_strategy_die = 1;
    --int advice_add_ignored_file = 1;
    --int advice_add_empty_pathspec = 1;
     -
      static int advice_use_color = -1;
      static char advice_colors[][COLOR_MAXLEN] = {
    @@ advice.c: static const char *advise_get_color(enum color_advice ix)
     -	const char *name;
     -	int *preference;
     -} advice_config[] = {
    --	{ "fetchShowForcedUpdates", &advice_fetch_show_forced_updates },
    --	{ "pushUpdateRejected", &advice_push_update_rejected },
    --	{ "pushNonFFCurrent", &advice_push_non_ff_current },
    --	{ "pushNonFFMatching", &advice_push_non_ff_matching },
    --	{ "pushAlreadyExists", &advice_push_already_exists },
    --	{ "pushFetchFirst", &advice_push_fetch_first },
    --	{ "pushNeedsForce", &advice_push_needs_force },
    --	{ "pushUnqualifiedRefName", &advice_push_unqualified_ref_name },
    --	{ "pushRefNeedsUpdate", &advice_push_ref_needs_update },
    --	{ "statusHints", &advice_status_hints },
    --	{ "statusUoption", &advice_status_u_option },
    --	{ "statusAheadBehindWarning", &advice_status_ahead_behind_warning },
    --	{ "commitBeforeMerge", &advice_commit_before_merge },
    --	{ "resetQuiet", &advice_reset_quiet_warning },
    --	{ "resolveConflict", &advice_resolve_conflict },
    --	{ "sequencerInUse", &advice_sequencer_in_use },
    --	{ "implicitIdentity", &advice_implicit_identity },
    --	{ "detachedHead", &advice_detached_head },
    --	{ "setUpstreamFailure", &advice_set_upstream_failure },
    --	{ "objectNameWarning", &advice_object_name_warning },
    --	{ "amWorkDir", &advice_amworkdir },
    --	{ "rmHints", &advice_rm_hints },
    --	{ "addEmbeddedRepo", &advice_add_embedded_repo },
    --	{ "ignoredHook", &advice_ignored_hook },
    --	{ "waitingForEditor", &advice_waiting_for_editor },
     -	{ "graftFileDeprecated", &advice_graft_file_deprecated },
    --	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remote_branch_name },
    --	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
    --	{ "addIgnoredFile", &advice_add_ignored_file },
    --	{ "addEmptyPathspec", &advice_add_empty_pathspec },
    --
    --	/* make this an alias for backward compatibility */
    --	{ "pushNonFastForward", &advice_push_update_rejected }
     -};
     -
      static struct {
    @@ advice.h
      
      struct string_list;
      
    --extern int advice_fetch_show_forced_updates;
    --extern int advice_push_update_rejected;
    --extern int advice_push_non_ff_current;
    --extern int advice_push_non_ff_matching;
    --extern int advice_push_already_exists;
    --extern int advice_push_fetch_first;
    --extern int advice_push_needs_force;
    --extern int advice_push_unqualified_ref_name;
    --extern int advice_push_ref_needs_update;
    --extern int advice_status_hints;
    --extern int advice_status_u_option;
    --extern int advice_status_ahead_behind_warning;
    --extern int advice_commit_before_merge;
    --extern int advice_reset_quiet_warning;
    --extern int advice_resolve_conflict;
    --extern int advice_sequencer_in_use;
    --extern int advice_implicit_identity;
    --extern int advice_detached_head;
    --extern int advice_set_upstream_failure;
    --extern int advice_object_name_warning;
    --extern int advice_amworkdir;
    --extern int advice_rm_hints;
    --extern int advice_add_embedded_repo;
    --extern int advice_ignored_hook;
    --extern int advice_waiting_for_editor;
     -extern int advice_graft_file_deprecated;
    --extern int advice_checkout_ambiguous_remote_branch_name;
    --extern int advice_submodule_alternate_error_strategy_die;
    --extern int advice_add_ignored_file;
    --extern int advice_add_empty_pathspec;
     -
      /*
       * To add a new advice, you need to:
       * Define a new advice_type.
    +
    + ## builtin/replace.c ##
    +@@ builtin/replace.c: static int convert_graft_file(int force)
    + 	if (!fp)
    + 		return -1;
    + 
    +-	advice_graft_file_deprecated = 0;
    ++	no_graft_file_deprecated_advice = 1;
    + 	while (strbuf_getline(&buf, fp) != EOF) {
    + 		if (*buf.buf == '#')
    + 			continue;
    +
    + ## commit.c ##
    +@@
    + static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
    + 
    + int save_commit_buffer = 1;
    ++int no_graft_file_deprecated_advice;
    + 
    + const char *commit_type = "commit";
    + 
    +@@ commit.c: static int read_graft_file(struct repository *r, const char *graft_file)
    + 	struct strbuf buf = STRBUF_INIT;
    + 	if (!fp)
    + 		return -1;
    +-	if (advice_graft_file_deprecated)
    ++	if (!no_graft_file_deprecated_advice &&
    ++	    advice_enabled(ADVICE_GRAFT_FILE_DEPRECATED))
    + 		advise(_("Support for <GIT_DIR>/info/grafts is deprecated\n"
    + 			 "and will be removed in a future Git version.\n"
    + 			 "\n"
    +
    + ## commit.h ##
    +@@ commit.h: struct commit {
    + };
    + 
    + extern int save_commit_buffer;
    ++extern int no_graft_file_deprecated_advice;
    + extern const char *commit_type;
    + 
    + /* While we can decorate any object with a name, it's only used for commits.. */
-- 
2.33.0.rc0.680.gf07173a897a

