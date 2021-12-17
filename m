Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36DBC433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 05:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhLQFMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 00:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhLQFML (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 00:12:11 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0ACC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 21:12:11 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w9-20020a25c709000000b00608a9489fc1so2532245ybe.20
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 21:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=65S1ZwoJpzW5PCbCDKjGMB00KhR3ETQrvV6pttmRdOI=;
        b=jUtR0ViwLr5XHG/IhXnSOjFciK7ttVlX7VnOq6jm78RPK6/JigqxpSX4mKC1TMGwcG
         86LPZyefrwji6iMHltXeWKlg4OEFw6Glq7SfrZRuOVBIpa3dRKcVo5eXbkCl3x1k0Nm2
         f/mcy5xSQLEMpsl//2C+h8/GHdw3pO9ug+UMSL6qCfl2uXfWA4iQPFE3IMOQYWiFJ24+
         q1XmLqDcGs8PAeabOSrr/N50s4u9QbnRPcmJ/Xa9YGUjuU8sfZWQsa60V+tcFrIGiwen
         +CuTLjQJQQpSd0KIHxDl4vAFWuehl+o0nhcZemqMQZGZVpfL2Z3gTtlXy5FiXJFvrMZa
         YnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=65S1ZwoJpzW5PCbCDKjGMB00KhR3ETQrvV6pttmRdOI=;
        b=lejuuj7YagOGIxOdZlA4KAgjyCNj6T3xD0aRlVNQaOsdE6MGaWX49n2cdOnRO6PZZt
         UokbhMBWSDpwBHDspckWaQxIT/f3cAoSdkDgZAlc7Dpl8m4LNncyUZtsqzDukHfMLIG9
         krd3acgCSKanLT9S4Tq0FoV+bKiq0vYJeBtN8tGL/FGmyBLjkxtuipO/vJ3fy/eQLhot
         wKkct0zG/Af6BXmO34Y51UrVyXGFEnH1M2MfXh7GONIwsGT3WhgmQJvzWzICKg8JlXON
         MSmyUwiuzOAr7jn6J41f0aDsN7gVsSYB0+FbAGSeJKTUFqbFI7NPX7lb5P4UeIuH9Me0
         ebdA==
X-Gm-Message-State: AOAM530oyD3y9UkuJXSmYNo1UZXhLhYsShUfpmaObM313aTdvQqmBM2C
        f83W2x/s/5Ekc9LvIAXhQa7eE1PcpWUzBbXwAGyidGBuxzl0td7u21GKZdQ8fiI+MwwN9xSLa96
        6ulhyoYXKK7GMC8I6ejcUgu6hlCJTs6OePTQsNIPi4vCrMfDSmXjk+IvnnPHDJ0s=
X-Google-Smtp-Source: ABdhPJxkz7BIaBOMKYOlb90AvxETAaO+YgxI8yTmvc4uogsSWEJgLV9pIvfKhAFETnI1tKFmOdJuaPtcJcCC6w==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:a37:b5e2:96be:e5d5])
 (user=steadmon job=sendgmr) by 2002:a25:acce:: with SMTP id
 x14mr2104526ybd.745.1639717930804; Thu, 16 Dec 2021 21:12:10 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:12:05 -0800
In-Reply-To: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
Message-Id: <cover.1639717481.git.steadmon@google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v7 0/3] branch: inherit tracking configs
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chooglen@google.com, avarab@gmail.com,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since V6:
* Strip the refs/heads/ prefix in the verbose output when we have only a
  single upstream branch.
* Improve the fatal error message to note that rebasing is only
  incompatible with multiple upstream refs.
* Also note that `branch.<name>.remote` should be set in the manual
  recovery advice.
* Simplify the logic in setup_tracking() when no tracking sources match.
* Make the difference in test cases in t2027 more obvious.

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
 Documentation/git-branch.txt    |  24 ++--
 Documentation/git-checkout.txt  |   2 +-
 Documentation/git-switch.txt    |   2 +-
 branch.c                        | 189 ++++++++++++++++++++++++--------
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
 16 files changed, 310 insertions(+), 66 deletions(-)

Range-diff against v6:
1:  43d6f83fed ! 1:  9152367ba9 branch: accept multiple upstream branches for tracking
    @@ branch.c: static int should_setup_rebase(const char *origin)
     +	if (!remotes->nr)
     +		BUG("must provide at least one remote for branch config");
     +	if (rebasing && remotes->nr > 1)
    -+		die(_("cannot inherit upstream tracking configuration when rebasing is requested"));
    ++		die(_("cannot inherit upstream tracking configuration of "
    ++		      "multiple refs when rebasing is requested"));
     +
     +	if (!origin)
     +		for_each_string_list_item(item, remotes)
    @@ branch.c: int install_branch_config(int flag, const char *local, const char *ori
     -					  _("Branch '%s' set up to track local branch '%s'."),
     -					  local, shortname);
     +				strbuf_addf(&refname, "%s/", origin);
    -+			strbuf_addstr(&refname, remotes->items[0].string);
    ++			skip_prefix(remotes->items[0].string, "refs/heads/", &name);
    ++			strbuf_addstr(&refname, name);
     +
     +			/*
     +			 * Rebasing is only allowed in the case of a single
    @@ branch.c: int install_branch_config(int flag, const char *local, const char *ori
     +			origin ? origin : "",
     +			origin ? "/" : "",
     +			remotes->items[0].string);
    -+	else
    ++	else {
    ++		advise("  git config --add branch.\"%s\".remote %s",
    ++			local, origin ? origin : ".");
     +		for_each_string_list_item(item, remotes)
     +			advise("  git config --add branch.\"%s\".merge %s",
     +				local, item->string);
    ++	}
      
      	return -1;
      }
2:  57e57e6e6a ! 2:  afeb84539e branch: add flags and config to inherit tracking
    @@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
      
     -	if (install_branch_config(config_flags, new_ref, tracking.remote,
     -			      tracking.src ? tracking.src : orig_ref) < 0)
    -+	if (tracking.srcs->nr < 1 && track != BRANCH_TRACK_INHERIT)
    ++	if (tracking.srcs->nr < 1)
     +		string_list_append(tracking.srcs, orig_ref);
    -+	if (install_branch_config_multiple_remotes(config_flags, new_ref, tracking.remote,
    -+			      tracking.srcs) < 0)
    ++	if (install_branch_config_multiple_remotes(config_flags, new_ref,
    ++				tracking.remote, tracking.srcs) < 0)
      		exit(-1);
      
     -	free(tracking.src);
    @@ t/t2027-checkout-track.sh: test_expect_success 'checkout --track -b rejects an e
     +test_expect_success 'checkout --track -b overrides autoSetupMerge=inherit' '
     +	# Set up tracking config on main
     +	test_config branch.main.remote origin &&
    -+	test_config branch.main.merge refs/heads/main &&
    ++	test_config branch.main.merge refs/heads/some-branch &&
     +	test_config branch.autoSetupMerge inherit &&
     +	# With --track=inherit, we copy the tracking config from main
     +	git checkout --track=inherit -b b1 main &&
     +	test_cmp_config origin branch.b1.remote &&
    -+	test_cmp_config refs/heads/main branch.b1.merge &&
    ++	test_cmp_config refs/heads/some-branch branch.b1.merge &&
     +	# With branch.autoSetupMerge=inherit, we do the same
     +	git checkout -b b2 main &&
     +	test_cmp_config origin branch.b2.remote &&
    -+	test_cmp_config refs/heads/main branch.b2.merge &&
    ++	test_cmp_config refs/heads/some-branch branch.b2.merge &&
     +	# But --track overrides this
     +	git checkout --track -b b3 main &&
     +	test_cmp_config . branch.b3.remote &&
3:  f79d27dc24 = 3:  a818a6561b config: require lowercase for branch.*.autosetupmerge

base-commit: 6c40894d2466d4e7fddc047a05116aa9d14712ee
-- 
2.34.1.173.g76aa8bc2d0-goog

