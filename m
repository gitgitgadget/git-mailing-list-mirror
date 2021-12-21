Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539B9C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 03:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhLUDa2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 22:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhLUDa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 22:30:28 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EBEC061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 19:30:27 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l75-20020a25254e000000b005f763be2fecso23358110ybl.7
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 19:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qVhn+/pOxiBY8MZtbLMFx71Om+kGrT9BPQzDMUsFznY=;
        b=gCzxL7cXEeNGNDxgdeq5KWViJxq0/5C6UmA2Y9ZuSIQZ0JMI/lJbxOwMg33ktd0WN7
         vGxUSDR8WVNPt2a0YgOMxCLwlLAMQtRau3ADZet8JCK4MShniGbJr/31x/rG7NH66S+C
         pFNWT/hplGADaoBKp7twZ9hnGaOhaJXZ3ZXQYTUjl+Mp05A5ZMe2+V7aTOOFvGAIKhi/
         1Y+5yjtllazcD4hXKXh21thu7KBwjj4IXel/iGXln/Dml/S/GVJdJBnC9iyJIXXgcxhF
         kzPjHLcLbVSL9wDqrX6Qf3roTJVbb453rc8Sv/wY1UZH8fnpNbF3G3ZztQpxBFP3gG/C
         g6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qVhn+/pOxiBY8MZtbLMFx71Om+kGrT9BPQzDMUsFznY=;
        b=uNrLDifoAshDetcFgzoqeauDh1MoBBuaEToNAt2OEfrcnmumDAXz4YDRHB7QY5CDB2
         QCUrhNBvPXRQMv2S6Ex1+UY9NJeO2n1RIZUXzXEd167L28oL9sUYR/O7LZbJeVrMgnnH
         Vs1K1xY9Gmub7L5NccfPqX5vhvDoq+za3f/Uz+FyQKmlqcOYULzPSnA9VoHX+RrJFOJl
         +mJn9r8ZJcs3IkpCAMrs7w9gs82Jmn0j70MS7JP8h9x5TuaFub1xwAGj15d/Oe5u7iCi
         4iX4+WZdrZsNvZvHyfX+3jYTJy9l32kZhCN5yePbO2OcJ3qzOrHvU6Gp2ehQo01qHv9i
         4Pow==
X-Gm-Message-State: AOAM530eg5zFlO6DWetZXJ5ieGF8H9Es3Z2i4sy389ioNE48Xt1h1Mkj
        P5tFW3MIDrbN8mTLgGYZOzwXiqU9BLvYjjuljbbSmx/Z13SK55Gf+63PF/Xk84ZBOIroM0mtp88
        a7LamtDRAnX0MDUrPqPgOus4kM3UaL+u87pikhsuscPdb44GL/9Z+T7Z14tEuaDo=
X-Google-Smtp-Source: ABdhPJzIOTXFr90XuoSJVCDnq2OF9rnS5nX/+ynpINZV0N4WoIX8ulFWRxQk+OCs4AA6Tv1NK4zWJWuT7RiDFg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:e4d8:c4fc:fa70:c18e])
 (user=steadmon job=sendgmr) by 2002:a25:bf8f:: with SMTP id
 l15mr1885696ybk.670.1640057426897; Mon, 20 Dec 2021 19:30:26 -0800 (PST)
Date:   Mon, 20 Dec 2021 19:30:21 -0800
In-Reply-To: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
Message-Id: <cover.1640039978.git.steadmon@google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v8 0/3] branch: inherit tracking configs
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, chooglen@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since V7:
* Further simplify verbose output by adding an "<origin>/" prefix for
  remote-tracking upstream refs.
* Add a comment explaining the self-tracking check & early exit.

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
 branch.c                        | 192 ++++++++++++++++++++++++--------
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
 16 files changed, 312 insertions(+), 67 deletions(-)

Range-diff against v7:
1:  9152367ba9 ! 1:  a5265e1c7f branch: accept multiple upstream branches for tracking
    @@ branch.c: static int should_setup_rebase(const char *origin)
     +		die(_("cannot inherit upstream tracking configuration of "
     +		      "multiple refs when rebasing is requested"));
     +
    ++	/*
    ++	 * If the new branch is trying to track itself, something has gone
    ++	 * wrong. Warn the user and don't proceed any further.
    ++	 */
     +	if (!origin)
     +		for_each_string_list_item(item, remotes)
     +			if (skip_prefix(item->string, "refs/heads/", &shortname)
    @@ branch.c: int install_branch_config(int flag, const char *local, const char *ori
      
      	if (flag & BRANCH_CONFIG_VERBOSE) {
     -		if (shortname) {
    -+		const char *name;
    -+		struct strbuf ref_string = STRBUF_INIT;
    -+
    -+		for_each_string_list_item(item, remotes) {
    -+			name = item->string;
    -+			skip_prefix(name, "refs/heads/", &name);
    -+			strbuf_addf(&ref_string, "  %s\n", name);
    -+		}
    -+
    -+		if (remotes->nr == 1) {
    -+			struct strbuf refname = STRBUF_INIT;
    -+
    - 			if (origin)
    +-			if (origin)
     -				printf_ln(rebasing ?
     -					  _("Branch '%s' set up to track remote branch '%s' from '%s' by rebasing.") :
     -					  _("Branch '%s' set up to track remote branch '%s' from '%s'."),
    @@ branch.c: int install_branch_config(int flag, const char *local, const char *ori
     -					  _("Branch '%s' set up to track local branch '%s' by rebasing.") :
     -					  _("Branch '%s' set up to track local branch '%s'."),
     -					  local, shortname);
    -+				strbuf_addf(&refname, "%s/", origin);
    -+			skip_prefix(remotes->items[0].string, "refs/heads/", &name);
    -+			strbuf_addstr(&refname, name);
    ++		struct strbuf tmp_ref_name = STRBUF_INIT;
    ++		struct string_list friendly_ref_names = STRING_LIST_INIT_DUP;
     +
    ++		for_each_string_list_item(item, remotes) {
    ++			shortname = item->string;
    ++			skip_prefix(shortname, "refs/heads/", &shortname);
    ++			if (origin) {
    ++				strbuf_addf(&tmp_ref_name, "%s/%s",
    ++					    origin, shortname);
    ++				string_list_append_nodup(
    ++					&friendly_ref_names,
    ++					strbuf_detach(&tmp_ref_name, NULL));
    ++			} else {
    ++				string_list_append(
    ++					&friendly_ref_names, shortname);
    ++			}
    ++		}
    ++
    ++		if (remotes->nr == 1) {
     +			/*
     +			 * Rebasing is only allowed in the case of a single
     +			 * upstream branch.
    @@ branch.c: int install_branch_config(int flag, const char *local, const char *ori
     +			printf_ln(rebasing ?
     +				_("branch '%s' set up to track '%s' by rebasing.") :
     +				_("branch '%s' set up to track '%s'."),
    -+				local, refname.buf);
    -+
    -+			strbuf_release(&refname);
    -+		} else if (origin) {
    -+			printf_ln(_("branch '%s' set up to track from '%s':"),
    -+				local, origin);
    -+			printf("%s", ref_string.buf);
    ++				local, friendly_ref_names.items[0].string);
      		} else {
     -			if (origin)
     -				printf_ln(rebasing ?
    @@ branch.c: int install_branch_config(int flag, const char *local, const char *ori
     -					  _("Branch '%s' set up to track local ref '%s'."),
     -					  local, remote);
     +			printf_ln(_("branch '%s' set up to track:"), local);
    -+			printf("%s", ref_string.buf);
    ++			for_each_string_list_item(item, &friendly_ref_names)
    ++				printf_ln("  %s", item->string);
      		}
     +
    -+		strbuf_release(&ref_string);
    ++		string_list_clear(&friendly_ref_names, 0);
      	}
      
      	return 0;
2:  afeb84539e = 2:  dcba40e2c4 branch: add flags and config to inherit tracking
3:  a818a6561b = 3:  ae7d27b4be config: require lowercase for branch.*.autosetupmerge

base-commit: 6c40894d2466d4e7fddc047a05116aa9d14712ee
-- 
2.34.1.307.g9b7440fafd-goog

