Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C56CC433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 23:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbhLNXpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 18:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbhLNXo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 18:44:59 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC58BC061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 15:44:59 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id 4-20020a621604000000b004a4ab765028so12544290pfw.13
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 15:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c9lVvvEE7hhl3dErl2MYCRbD7tqypMj57afojfyputw=;
        b=KAFKeYaqMhJRkhyz8q7+WVI3tdtSCQLDQKPsfDH8m2L5snCx5Ync/vX+5HccKLvfV8
         V6aPy7rcYaJTTk/g/2INBQtUyOPtY9H2BQeISnLUUKrCGpku73qmw1LyjtlbtKBR1fPg
         OtdUWC9Ks01xqkBpXjmvT6k/RPpAWWIGQGwbj18U2PWwCjERiJj2/AawXyWmnZ5a5OBz
         faBzax7FT90agfnrdX3a6pGyBkUUqLQjoSA3hIMo4W5Sj2lz7rX4RW38c7LBko+vmyEp
         H/RSk2nE6TL7uF5OjaL2vu46N4SqVeNEr8tjzCI29XNdbR1PIDlt8R5xqyMY/JA/RhvJ
         Z3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c9lVvvEE7hhl3dErl2MYCRbD7tqypMj57afojfyputw=;
        b=tu+9FTAXoxvcL311PSMa1DDJX7SBQGFoPt5Gi02AHSxVbqIUTF0A8j26uVJr02NsQf
         jrwpOFsD/DakIra+Mfzs1Ewi3VA6hg3vviTXwzxKNPOpDJNlHzbMUmj+tCn3lkRyd7C2
         tJlSmhGxxEr5CBp+iL9j7NLPOEzHl+ceHN4GWghEj/1o8pTBCIBYQN1yNa6ns4LoUt75
         PDTW3cr3DsBa3iwmW9uG2Wy1f+96tP2XBHX1qkAjbvwNf086iIbmTvJNXZ3KSrjHnmsF
         8UYQgpYfVk9GMrgRtO9U0nKbybR62iZo2/GtIC3bN+3IKxR7i5697U3cHIotiGkLP0Sv
         74XQ==
X-Gm-Message-State: AOAM530IP0Z27zWzItiVgsR20Vc31Ws/bAlIqD3DXucHZPdBzHu3yunI
        0B6OFKzThjlK2cat3bJELfASYFU1Ga8XkZwYBddMKCGZwBVup5afAJOR56I8iwV8r2Y+H0smffS
        eSbojEUVUqONfkX0u3pH036TQ/6O4XI75WN87U1uMj+RSWUYZUTyZ54UpXYSeNw0=
X-Google-Smtp-Source: ABdhPJwBZjLYHOrrPoQHPX7mXoCheiGtK+a0hMCauuhYCF/wzPl2Wsj8lW1HvnCY1lWRm+iu0Mh9+lcSCleT+g==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:b37:fbed:ef52:5dca])
 (user=steadmon job=sendgmr) by 2002:a63:90c4:: with SMTP id
 a187mr5769491pge.106.1639525498775; Tue, 14 Dec 2021 15:44:58 -0800 (PST)
Date:   Tue, 14 Dec 2021 15:44:53 -0800
In-Reply-To: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
Message-Id: <cover.1639524556.git.steadmon@google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v6 0/3] branch: inherit tracking configs
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chooglen@google.com, avarab@gmail.com,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since V5:
* Greatly simplified BRANCH_CONFIG_VERBOSE output to not require nearly
  so many conditionals.
* Note that rebasing is not compatible with inheriting multiple upstream
  branches.
* Moved the change to case-sensitivity for branch.autosetupmerge to its
  own commit.
* Improve advice on failed tracking setup when multiple branches are
  involved.
* Make better use of string_list API.
* Make better use of config API.
* More straight-forward use of the `struct tracking` API.
* Numerous style fixes.

Changes since V4:
* Add new patch (1/2) to refactor branch.c:install_branch_config() to
  accept multiple upstream refs
* When multiple upstream branches are set in the parent branch, inherit
  them all, instead of just the first
* Break out error string arguments for easier translation
* Don't ignore case for values of branch.autosetupmerge
* Move reference to git-pull out of usage string for --track into
  git-branch.txt
* Use test_config instead of `git config` in t2027
* Style fixes: add single-quotes around warning string arguments, remove
  unnecessary braces

Changes since V3:
* Use branch_get() instead of git_config_get_string() to look up branch
  configuration.
* Remove unnecessary string formatting in new error message in
  parse-options-cb.c.

Josh Steadmon (3):
  branch: accept multiple upstream branches for tracking
  branch: add flags and config to inherit tracking
  config: require lowercase for branch.*.autosetupmerge

 Documentation/config/branch.txt |   3 +-
 Documentation/git-branch.txt    |  24 +++--
 Documentation/git-checkout.txt  |   2 +-
 Documentation/git-switch.txt    |   2 +-
 branch.c                        | 184 ++++++++++++++++++++++++--------
 branch.h                        |   3 +-
 builtin/branch.c                |   6 +-
 builtin/checkout.c              |   6 +-
 config.c                        |   5 +-
 parse-options-cb.c              |  16 +++
 parse-options.h                 |   2 +
 t/t2017-checkout-orphan.sh      |  11 +-
 t/t2027-checkout-track.sh       |  23 ++++
 t/t2060-switch.sh               |  28 +++++
 t/t3200-branch.sh               |  39 ++++++-
 t/t7201-co.sh                   |  17 +++
 16 files changed, 305 insertions(+), 66 deletions(-)

Range-diff against v5:
1:  ba7d557725 < -:  ---------- branch: accept multiple upstream branches for tracking
-:  ---------- > 1:  43d6f83fed branch: accept multiple upstream branches for tracking
2:  c7e4af9a36 ! 2:  57e57e6e6a branch: add flags and config to inherit tracking
    @@ branch.c: static int find_tracked_branch(struct remote *remote, void *priv)
      		}
      		tracking->spec.src = NULL;
      	}
    -@@ branch.c: int install_branch_config(int flag, const char *local, const char *origin, const
    - 	string_list_clear(&remotes, 0);
    +@@ branch.c: int install_branch_config(int flag, const char *local, const char *origin,
    + 	return ret;
      }
      
     +static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
    @@ branch.c: int install_branch_config(int flag, const char *local, const char *ori
     +	tracking->remote = xstrdup(branch->remote_name);
     +	for (i = 0; i < branch->merge_nr; i++)
     +		string_list_append(tracking->srcs, branch->merge_name[i]);
    -+	tracking->matches = 1;
     +	return 0;
     +}
     +
    @@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
      		return;
      
      	if (!tracking.matches)
    +@@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
    + 		case BRANCH_TRACK_ALWAYS:
    + 		case BRANCH_TRACK_EXPLICIT:
    + 		case BRANCH_TRACK_OVERRIDE:
    ++		case BRANCH_TRACK_INHERIT:
    + 			break;
    + 		default:
    + 			return;
     @@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
      		die(_("Not tracking: ambiguous information for ref %s"),
      		    orig_ref);
      
     -	if (install_branch_config(config_flags, new_ref, tracking.remote,
     -			      tracking.src ? tracking.src : orig_ref) < 0)
    -+	if (tracking.srcs->nr < 1)
    ++	if (tracking.srcs->nr < 1 && track != BRANCH_TRACK_INHERIT)
     +		string_list_append(tracking.srcs, orig_ref);
     +	if (install_branch_config_multiple_remotes(config_flags, new_ref, tracking.remote,
     +			      tracking.srcs) < 0)
    @@ branch.h: enum branch_track {
      	BRANCH_TRACK_EXPLICIT,
     -	BRANCH_TRACK_OVERRIDE
     +	BRANCH_TRACK_OVERRIDE,
    -+	BRANCH_TRACK_INHERIT
    ++	BRANCH_TRACK_INHERIT,
      };
      
      extern enum branch_track git_branch_track;
    @@ builtin/checkout.c: static struct option *add_common_switch_branch_options(
      		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
     
      ## config.c ##
    -@@ config.c: static int git_default_i18n_config(const char *var, const char *value)
    - static int git_default_branch_config(const char *var, const char *value)
    - {
    - 	if (!strcmp(var, "branch.autosetupmerge")) {
    --		if (value && !strcasecmp(value, "always")) {
    -+		if (value && !strcmp(value, "always")) {
    +@@ config.c: static int git_default_branch_config(const char *var, const char *value)
    + 		if (value && !strcasecmp(value, "always")) {
      			git_branch_track = BRANCH_TRACK_ALWAYS;
      			return 0;
     +		} else if (value && !strcmp(value, "inherit")) {
    @@ parse-options-cb.c: int parse_opt_passthru_argv(const struct option *opt, const
      	return 0;
      }
     +
    -+int parse_opt_tracking_mode(const struct option *opt, const char *arg, int unset) {
    ++int parse_opt_tracking_mode(const struct option *opt, const char *arg, int unset)
    ++{
     +	if (unset)
     +		*(enum branch_track *)opt->value = BRANCH_TRACK_NEVER;
     +	else if (!arg || !strcmp(arg, "direct"))
    @@ parse-options.h: enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx
     
      ## t/t2017-checkout-orphan.sh ##
     @@ t/t2017-checkout-orphan.sh: test_expect_success '--orphan ignores branch.autosetupmerge' '
    + 	git checkout main &&
    + 	git config branch.autosetupmerge always &&
      	git checkout --orphan gamma &&
    - 	test -z "$(git config branch.gamma.merge)" &&
    +-	test -z "$(git config branch.gamma.merge)" &&
    ++	test_cmp_config "" --default "" branch.gamma.merge &&
      	test refs/heads/gamma = "$(git symbolic-ref HEAD)" &&
     +	test_must_fail git rev-parse --verify HEAD^ &&
     +	git checkout main &&
     +	git config branch.autosetupmerge inherit &&
     +	git checkout --orphan eta &&
    -+	test -z "$(git config branch.eta.merge)" &&
    -+	test -z "$(git config branch.eta.remote)" &&
    -+	test refs/heads/eta = "$(git symbolic-ref HEAD)" &&
    ++	test_cmp_config "" --default "" branch.eta.merge &&
    ++	test_cmp_config "" --default "" branch.eta.remote &&
    ++	echo refs/heads/eta >expected &&
    ++	git symbolic-ref HEAD >actual &&
    ++	test_cmp expected actual &&
      	test_must_fail git rev-parse --verify HEAD^
      '
      
    @@ t/t2060-switch.sh: test_expect_success 'not switching when something is in progr
     +test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
     +	# default config does not copy tracking info
     +	git switch -c foo-no-inherit foo &&
    -+	test -z "$(git config branch.foo-no-inherit.remote)" &&
    -+	test -z "$(git config branch.foo-no-inherit.merge)" &&
    ++	test_cmp_config "" --default "" branch.foo-no-inherit.remote &&
    ++	test_cmp_config "" --default "" branch.foo-no-inherit.merge &&
     +	# with --track=inherit, we copy tracking info from foo
     +	git switch --track=inherit -c foo2 foo &&
     +	test_cmp_config origin branch.foo2.remote &&
    @@ t/t2060-switch.sh: test_expect_success 'not switching when something is in progr
     +	test_cmp_config refs/heads/foo branch.foo5.merge &&
     +	# no tracking info to inherit from main
     +	git switch -c main2 main &&
    -+	test -z "$(git config branch.main2.remote)" &&
    -+	test -z "$(git config branch.main2.merge)"
    ++	test_cmp_config "" --default "" branch.main2.remote &&
    ++	test_cmp_config "" --default "" branch.main2.merge
     +'
     +
      test_done
    @@ t/t3200-branch.sh: test_expect_success 'invalid sort parameter in configuration'
     +	test_unconfig branch.autoSetupMerge &&
     +	# default config does not copy tracking info
     +	git branch foo-no-inherit my1 &&
    -+	test -z "$(git config branch.foo-no-inherit.remote)" &&
    -+	test -z "$(git config branch.foo-no-inherit.merge)" &&
    ++	test_cmp_config "" --default "" branch.foo-no-inherit.remote &&
    ++	test_cmp_config "" --default "" branch.foo-no-inherit.merge &&
     +	# with autoSetupMerge=inherit, we copy tracking info from my1
     +	test_config branch.autoSetupMerge inherit &&
     +	git branch foo3 my1 &&
    @@ t/t3200-branch.sh: test_expect_success 'invalid sort parameter in configuration'
     +	test_cmp_config refs/heads/main branch.foo3.merge &&
     +	# no tracking info to inherit from main
     +	git branch main2 main &&
    -+	test -z "$(git config branch.main2.remote)" &&
    -+	test -z "$(git config branch.main2.merge)"
    ++	test_cmp_config "" --default "" branch.main2.remote &&
    ++	test_cmp_config "" --default "" branch.main2.merge
     +'
     +
     +test_expect_success '--track overrides branch.autoSetupMerge' '
    @@ t/t3200-branch.sh: test_expect_success 'invalid sort parameter in configuration'
     +	test_cmp_config . branch.foo4.remote &&
     +	test_cmp_config refs/heads/my1 branch.foo4.merge &&
     +	git branch --no-track foo5 my1 &&
    -+	test -z "$(git config branch.foo5.remote)" &&
    -+	test -z "$(git config branch.foo5.merge)"
    ++	test_cmp_config "" --default "" branch.foo5.remote &&
    ++	test_cmp_config "" --default "" branch.foo5.merge
     +'
     +
      test_done
    @@ t/t7201-co.sh: test_expect_success 'custom merge driver with checkout -m' '
     +	git reset --hard main &&
     +	# default config does not copy tracking info
     +	git checkout -b foo-no-inherit koala/bear &&
    -+	test -z "$(git config branch.foo-no-inherit.remote)" &&
    -+	test -z "$(git config branch.foo-no-inherit.merge)" &&
    ++	test_cmp_config "" --default "" branch.foo-no-inherit.remote &&
    ++	test_cmp_config "" --default "" branch.foo-no-inherit.merge &&
     +	# with autoSetupMerge=inherit, we copy tracking info from koala/bear
     +	test_config branch.autoSetupMerge inherit &&
     +	git checkout -b foo koala/bear &&
    @@ t/t7201-co.sh: test_expect_success 'custom merge driver with checkout -m' '
     +	test_cmp_config refs/heads/koala/bear branch.foo.merge &&
     +	# no tracking info to inherit from main
     +	git checkout -b main2 main &&
    -+	test -z "$(git config branch.main2.remote)" &&
    -+	test -z "$(git config branch.main2.merge)"
    ++	test_cmp_config "" --default "" branch.main2.remote &&
    ++	test_cmp_config "" --default "" branch.main2.merge
     +'
     +
      test_done
-:  ---------- > 3:  f79d27dc24 config: require lowercase for branch.*.autosetupmerge

base-commit: 6c40894d2466d4e7fddc047a05116aa9d14712ee
-- 
2.34.1.173.g76aa8bc2d0-goog

