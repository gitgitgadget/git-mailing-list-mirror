Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F94BC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 07:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhLGHPn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 02:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhLGHPl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 02:15:41 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1762DC061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 23:12:12 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v20-20020a25fc14000000b005c2109e5ad1so24333002ybd.9
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 23:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AAYlti7Z57SzVuWgi6qhjaOKOKY1CYMmk+nm028pozc=;
        b=BZ4nvcI2o8jTsuhLhHRXzHQBUKcDdV0EDj6nSRbIhcqGRLT213FS7AGacNH3mTQUO9
         GeWZXLtEQJolH+JmSXoUsIpWPXmey0IdzIRWRr8olkrM0PA2x4T7pzo0e+2ix+Fvf1U4
         WpQeBWysy+pR9ZjGMkejmDiazYfk5hAZVEWKC9MMgJDn0FD9mEAGdJroU9zBFuKr44IE
         YHe/aweJMZ8041z1FCdHaeuKukbk83RIqrp3eqIyiWWQfMlNjh+yw6L1o0a2qxrQ/lac
         LJnuGq8cCGN227fFalcF+KBRl6eDjgTY274yWZ/HIzukYihkiq1vefpMhuG+oi2boVlJ
         IeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AAYlti7Z57SzVuWgi6qhjaOKOKY1CYMmk+nm028pozc=;
        b=ODzRwP+RCIFk4Cu/8QYq/j2hR9u9sf4eKx4ZbhI+iZEz9Di51Mj+0D4Na/1MuJT/Di
         IjEYgCeQLEKXAHEcEc8QyTthEoD2GTMG0zLsvhHJ3Q/GdMYMhTw3VHmbTWuuwkzC7ntO
         AIaHD+Z4zN/iDEtgBo7cM7GPyEObspSV3AkuzHOYyISKw9bgavmEo9reg81Wt3MrJQDC
         SGMjd0vDDy2JCO99fG7XOZdFPwIUE6SkK82j35XIY4u+MwanBvqUdQIcA0dA4Aa0vNfT
         aq3g0cxmRhqPueF49uwIJERNKol+HiNsN9hI1IBLfo8jlS613JlpgVhT05uWOI8Dds/7
         e0rw==
X-Gm-Message-State: AOAM5309/Qj4EhBCF0jL4TykjXvMJ3+oC+2+96T3EWEGipwxQ9LfVSwC
        adGrPqVrMUN34m3O+V/IGpi1+8rFtzK5+7Q33dBfiy9k4LTv+hYLlnXkdg4YWeEKO8PfP7N2vYV
        n3X8x3YOiqW9Ax+iho2Zsq4CVJumecspc6piS/LDZk48cjuWyJEyqoJgQdGJFh+8=
X-Google-Smtp-Source: ABdhPJxT0T4tGlWubhp5ZlCxBKyo89itd8U99vE2vbRN+Glql2evgekQ9Gy6fxz/38gshIVh3AzVej9jyj1RFA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:7544:926d:50a3:e38b])
 (user=steadmon job=sendgmr) by 2002:a25:a429:: with SMTP id
 f38mr46120690ybi.34.1638861131221; Mon, 06 Dec 2021 23:12:11 -0800 (PST)
Date:   Mon,  6 Dec 2021 23:12:06 -0800
In-Reply-To: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
Message-Id: <cover.1638859949.git.steadmon@google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v5 0/2] branch: inherit tracking configs
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chooglen@google.com, emilyshaffer@google.com,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've addressed feedback from V4. Since 2/3 reviewers seemed to (at least
slightly) prefer handling multiple upstream branches in the existing
tracking setup, I've gone that direction rather than repurposing the
branch copy code. None of the other issues were controversial.

In this version, I'd appreciate feedback mainly on patch 1:
* Is the combination of `git_config_set_gently()` +
  `git_config_set_multivar_gently() the best way to write multiple
  config entries for the same key?
* Does the reorganization of the BRANCH_CONFIG_VERBOSE output make
  things more readable, or less? Should I try to simplify the output
  here so that we don't end up with so many translatable variants of the
  same message?

Also, a question specifically for Junio: this will conflict with
gc/branch-recurse-submodules; should I rebase on that, or wait till it
hits next, or just ignore it for now?

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

Josh Steadmon (2):
  branch: accept multiple upstream branches for tracking
  branch: add flags and config to inherit tracking

 Documentation/config/branch.txt |   3 +-
 Documentation/git-branch.txt    |  24 +++--
 Documentation/git-checkout.txt  |   2 +-
 Documentation/git-switch.txt    |   2 +-
 branch.c                        | 169 ++++++++++++++++++++++++--------
 branch.h                        |   3 +-
 builtin/branch.c                |   6 +-
 builtin/checkout.c              |   6 +-
 config.c                        |   5 +-
 parse-options-cb.c              |  15 +++
 parse-options.h                 |   2 +
 t/t2017-checkout-orphan.sh      |   7 ++
 t/t2027-checkout-track.sh       |  23 +++++
 t/t2060-switch.sh               |  28 ++++++
 t/t3200-branch.sh               |  33 +++++++
 t/t7201-co.sh                   |  17 ++++
 16 files changed, 289 insertions(+), 56 deletions(-)

Range-diff against v4:
-:  ---------- > 1:  ba7d557725 branch: accept multiple upstream branches for tracking
1:  7ad7507f18 ! 2:  c7e4af9a36 branch: add flags and config to inherit tracking
    @@ Documentation/git-branch.txt: This option is only applicable in non-verbose mode
     +start-point is either a local or remote-tracking branch. Set it to
     +`inherit` if you want to copy the tracking configuration from the
     +branch point.
    +++
    ++See linkgit:git-pull[1] and linkgit:git-config[1] for additional discussion on
    ++how the `branch.<name>.remote` and `branch.<name>.merge` options are used.
      
      --no-track::
      	Do not set up "upstream" configuration, even if the
    @@ Documentation/git-switch.txt: should result in deletion of the path).
      	details.
     
      ## branch.c ##
    +@@
    + 
    + struct tracking {
    + 	struct refspec_item spec;
    +-	char *src;
    ++	struct string_list *srcs;
    + 	const char *remote;
    + 	int matches;
    + };
    +@@ branch.c: static int find_tracked_branch(struct remote *remote, void *priv)
    + 
    + 	if (!remote_find_tracking(remote, &tracking->spec)) {
    + 		if (++tracking->matches == 1) {
    +-			tracking->src = tracking->spec.src;
    ++			string_list_append(tracking->srcs, tracking->spec.src);
    + 			tracking->remote = remote->name;
    + 		} else {
    + 			free(tracking->spec.src);
    +-			FREE_AND_NULL(tracking->src);
    ++			string_list_clear(tracking->srcs, 0);
    + 		}
    + 		tracking->spec.src = NULL;
    + 	}
     @@ branch.c: int install_branch_config(int flag, const char *local, const char *origin, const
    - 	return -1;
    + 	string_list_clear(&remotes, 0);
      }
      
     +static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
     +{
     +	const char *bare_ref;
     +	struct branch *branch;
    ++	int i;
     +
     +	bare_ref = orig_ref;
     +	skip_prefix(orig_ref, "refs/heads/", &bare_ref);
     +
     +	branch = branch_get(bare_ref);
     +	if (!branch->remote_name) {
    -+		warning(_("asked to inherit tracking from %s, but no remote is set"),
    ++		warning(_("asked to inherit tracking from '%s', but no remote is set"),
     +			bare_ref);
     +		return -1;
     +	}
     +
     +	if (branch->merge_nr < 1 || !branch->merge_name || !branch->merge_name[0]) {
    -+		warning(_("asked to inherit tracking from %s, but no merge configuration is set"),
    ++		warning(_("asked to inherit tracking from '%s', but no merge configuration is set"),
     +			bare_ref);
     +		return -1;
     +	}
     +
     +	tracking->remote = xstrdup(branch->remote_name);
    -+	tracking->src = xstrdup(branch->merge_name[0]);
    ++	for (i = 0; i < branch->merge_nr; i++)
    ++		string_list_append(tracking->srcs, branch->merge_name[i]);
     +	tracking->matches = 1;
     +	return 0;
     +}
    @@ branch.c: int install_branch_config(int flag, const char *local, const char *ori
       * This is called when new_ref is branched off of orig_ref, and tries
       * to infer the settings for branch.<new_ref>.{remote,merge} from the
     @@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
    + 			   enum branch_track track, int quiet)
    + {
    + 	struct tracking tracking;
    ++	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
    + 	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
      
      	memset(&tracking, 0, sizeof(tracking));
      	tracking.spec.dst = (char *)orig_ref;
     -	if (for_each_remote(find_tracked_branch, &tracking))
    -+	if (track != BRANCH_TRACK_INHERIT) {
    ++	tracking.srcs = &tracking_srcs;
    ++	if (track != BRANCH_TRACK_INHERIT)
     +		for_each_remote(find_tracked_branch, &tracking);
    -+	} else if (inherit_tracking(&tracking, orig_ref))
    ++	else if (inherit_tracking(&tracking, orig_ref))
      		return;
      
      	if (!tracking.matches)
    +@@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
    + 		die(_("Not tracking: ambiguous information for ref %s"),
    + 		    orig_ref);
    + 
    +-	if (install_branch_config(config_flags, new_ref, tracking.remote,
    +-			      tracking.src ? tracking.src : orig_ref) < 0)
    ++	if (tracking.srcs->nr < 1)
    ++		string_list_append(tracking.srcs, orig_ref);
    ++	if (install_branch_config_multiple_remotes(config_flags, new_ref, tracking.remote,
    ++			      tracking.srcs) < 0)
    + 		exit(-1);
    + 
    +-	free(tracking.src);
    ++	string_list_clear(tracking.srcs, 0);
    + }
    + 
    + int read_branch_desc(struct strbuf *buf, const char *branch_name)
     
      ## branch.h ##
     @@ branch.h: enum branch_track {
    @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const char *prefix
     -		OPT_SET_INT('t', "track",  &track, N_("set up tracking mode (see git-pull(1))"),
     -			BRANCH_TRACK_EXPLICIT),
     +		OPT_CALLBACK_F('t', "track",  &track, "direct|inherit",
    -+			N_("set up tracking mode (see git-pull(1))"),
    ++			N_("set branch tracking configuration"),
     +			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
     +			parse_opt_tracking_mode),
      		OPT_SET_INT_F(0, "set-upstream", &track, N_("do not use"),
    @@ builtin/checkout.c: static struct option *add_common_switch_branch_options(
      		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
     
      ## config.c ##
    -@@ config.c: static int git_default_branch_config(const char *var, const char *value)
    - 		if (value && !strcasecmp(value, "always")) {
    +@@ config.c: static int git_default_i18n_config(const char *var, const char *value)
    + static int git_default_branch_config(const char *var, const char *value)
    + {
    + 	if (!strcmp(var, "branch.autosetupmerge")) {
    +-		if (value && !strcasecmp(value, "always")) {
    ++		if (value && !strcmp(value, "always")) {
      			git_branch_track = BRANCH_TRACK_ALWAYS;
      			return 0;
    -+		} else if (value && !strcasecmp(value, "inherit")) {
    ++		} else if (value && !strcmp(value, "inherit")) {
     +			git_branch_track = BRANCH_TRACK_INHERIT;
     +			return 0;
      		}
    @@ parse-options-cb.c: int parse_opt_passthru_argv(const struct option *opt, const
     +	else if (!strcmp(arg, "inherit"))
     +		*(enum branch_track *)opt->value = BRANCH_TRACK_INHERIT;
     +	else
    -+		return error(_("option `--track' expects \"direct\" or \"inherit\""));
    ++		return error(_("option `%s' expects \"%s\" or \"%s\""),
    ++			     "--track", "direct", "inherit");
     +
     +	return 0;
     +}
    @@ t/t2027-checkout-track.sh: test_expect_success 'checkout --track -b rejects an e
      
     +test_expect_success 'checkout --track -b overrides autoSetupMerge=inherit' '
     +	# Set up tracking config on main
    -+	git config branch.main.remote origin &&
    -+	git config branch.main.merge refs/heads/main &&
    ++	test_config branch.main.remote origin &&
    ++	test_config branch.main.merge refs/heads/main &&
     +	test_config branch.autoSetupMerge inherit &&
     +	# With --track=inherit, we copy the tracking config from main
     +	git checkout --track=inherit -b b1 main &&

base-commit: 6c40894d2466d4e7fddc047a05116aa9d14712ee
-- 
2.34.1.400.ga245620fadb-goog

