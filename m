Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8001C433F5
	for <git@archiver.kernel.org>; Sat,  1 Jan 2022 14:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiAAOjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jan 2022 09:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiAAOjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jan 2022 09:39:25 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BE2C061574
        for <git@vger.kernel.org>; Sat,  1 Jan 2022 06:39:25 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so27916708pjf.3
        for <git@vger.kernel.org>; Sat, 01 Jan 2022 06:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M2vEz+u/+98vQzj9yI14R6RBolqRVXupEPDbv8ZMCyo=;
        b=Ftp54LsTOS3LevxGX4ull2DmRQjDKKf2bgBXLdJTiyWFC9ZUBvoykWqBAw6oEwG8S9
         vVhAvri2zO/CJKglagmPPXHt3ZLeBG2DGj3wlEwaP7IAswxO3M4p5BNOgQFNseLKUX0Q
         z5KP6ZA6HlLfBPEsVICzQZs9Mg54MS8jwZNPpxR5tLnWADbnV8HlZJey5ukQjvaNwqz7
         vuY540e0xKe+0n7qJZccgEsJjzVqet8hirm+3vfGuVCDWhRMSQ5MPd2SFtm62JFJpuiY
         GfEH3OBEXgv5jDsiugO03J1YMQuINv0RDNINEJu4HZDelTP84Ls2hGCm5hEfBcleyx6F
         mf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M2vEz+u/+98vQzj9yI14R6RBolqRVXupEPDbv8ZMCyo=;
        b=UhoIIYIlUMm1gOC3yXKyKYT5vQ4DNQdVo18xtO10t+RhCGpB1aM08jI1QWO0ag4XCC
         4e9vuuKwwkw43ulwop+OfrkASQZPk7KJUBXnYhO0fv/QuAVfvnwHMiT6ehfc9SluIGrF
         P3wIK1nEnX7eTOtUe1LW3QgYr0wD6iqqWy4+MPDGCFOlAtQtNYWiB00BXwwA/gP/xeYT
         WiMA1YzXrQqKUvpPtY/FI/nI1TbGp2aHpSY/xhEIuGlKI/+HOvHmQl0JsJOeHijGqaB2
         IPRuEUOHBruF//PuANVjyDLkUI46S/0ML3+P2Bo0PUYPdL+ZZv/ht6rdM+zX6DcUP3dx
         mmyg==
X-Gm-Message-State: AOAM5332dvNX1PIebdKh6sd2zrSSmyOYWzidaZEx86KJWMoLVSXRf+bC
        703EM+VJ3734u8ggWl8+n0/mEPg8kRw=
X-Google-Smtp-Source: ABdhPJxAuhuX1J3tgmJ4X0/whder7A5XiZx2bYAH/6KmxEZ91n4K4YyOCAIkoTyhOV2kMqMUyhG4Qw==
X-Received: by 2002:a17:90b:38c9:: with SMTP id nn9mr47832277pjb.153.1641047964295;
        Sat, 01 Jan 2022 06:39:24 -0800 (PST)
Received: from LAPTOP-FJDAS7G4.localdomain ([157.40.153.25])
        by smtp.gmail.com with ESMTPSA id kb1sm38220053pjb.56.2022.01.01.06.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 06:39:24 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     git@vger.kernel.org
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: [PATCH v4 1/1] push: make 'set-upstream' have dafault arguments
Date:   Sat,  1 Jan 2022 20:07:48 +0530
Message-Id: <20220101143748.2582-2-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220101143748.2582-1-chakrabortyabhradeep79@gmail.com>
References: <20211209101550.19582-1-chakrabortyabhradeep79@gmail.com>
 <20220101143748.2582-1-chakrabortyabhradeep79@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git push -u" (set-upstream) requires where to push to and what
to push.  Often people push only the current branch to update
the branch of the same name at the 'origin' repository.  For
them, it would be convenient if "git push -u" without repository
or refspec, defaulted to push and set upstream to the branch as
configured by the "push.default" setting, of the remote repository
that is used by default.

Teach "git push -u" not to require repository and refspec.  When
the user do not give what repository to push to, or which
branch(es) to push, behave as if the default remote repository
and a refspec (depending on the "push.default" configuration)
are given.

If "push.default"=matching, push all the branches matched on both
remote and local side and set those remote branches as the upstream
of their respective local matched branches. Otherwise, set the
refspec to the refspec for current branch.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 Documentation/git-push.txt |  10 +++
 builtin/push.c             |  11 +++-
 t/t5523-push-upstream.sh   | 125 +++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 2f25aa3a29..6fd474441f 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -375,6 +375,16 @@ Specifying `--no-force-if-includes` disables this behavior.
 	upstream (tracking) reference, used by argument-less
 	linkgit:git-pull[1] and other commands. For more information,
 	see `branch.<name>.merge` in linkgit:git-config[1].
++
+`-u` can also work with zero arguments( i.e. no `<repository>` and
+`<refspec>` are given). In that case, it tries to get the `<repository>`
+value from `branch.*.remote` configuration. If not found, it defaults to
+`origin`. If `remote.pushDefault` is set then it uses that instead. The
+value of `<refspec>` depends on the current `push.default` configuration.
+If `push.default` is set to `matching`, all remote branches to which
+local branches pushed, will be set as upstream of respective local
+branches. For all other values of `push.default`, current branch's
+refspec will be used as the `<refspec>`.
 
 --[no-]thin::
 	These options are passed to linkgit:git-send-pack[1]. A thin transfer
diff --git a/builtin/push.c b/builtin/push.c
index 4b026ce6c6..8bc206c9d8 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -202,11 +202,12 @@ static const char *get_upstream_ref(struct branch *branch, const char *remote_na
 	return branch->merge[0]->src;
 }
 
-static void setup_default_push_refspecs(struct remote *remote)
+static void setup_default_push_refspecs(struct remote *remote, int flags)
 {
 	struct branch *branch;
 	const char *dst;
 	int same_remote;
+	int is_default_u = (flags & TRANSPORT_PUSH_SET_UPSTREAM);
 
 	switch (push_default) {
 	case PUSH_DEFAULT_MATCHING:
@@ -214,6 +215,8 @@ static void setup_default_push_refspecs(struct remote *remote)
 		return;
 
 	case PUSH_DEFAULT_NOTHING:
+		if (is_default_u)
+			break;
 		die(_("You didn't specify any refspecs to push, and "
 		    "push.default is \"nothing\"."));
 		return;
@@ -234,11 +237,15 @@ static void setup_default_push_refspecs(struct remote *remote)
 	case PUSH_DEFAULT_SIMPLE:
 		if (!same_remote)
 			break;
+		if (is_default_u)
+			break;
 		if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
 			die_push_simple(branch, remote);
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
+		if (is_default_u)
+			break;
 		if (!same_remote)
 			die(_("You are pushing to remote '%s', which is not the upstream of\n"
 			      "your current branch '%s', without telling me what to push\n"
@@ -401,7 +408,7 @@ static int do_push(int flags,
 		if (remote->push.nr) {
 			push_refspec = &remote->push;
 		} else if (!(flags & TRANSPORT_PUSH_MIRROR))
-			setup_default_push_refspecs(remote);
+			setup_default_push_refspecs(remote, flags);
 	}
 	errs = 0;
 	url_nr = push_url_of_remote(remote, &url);
diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index fdb4292056..c2d11c3f2a 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -60,6 +60,86 @@ test_expect_success 'push -u :topic_2' '
 	check_config topic_2 upstream refs/heads/other2
 '
 
+default_u_setup() {
+	git checkout main &&
+	test_might_fail	git branch --unset-upstream &&
+	test_config push.default $1 &&
+	test_config remote.pushDefault upstream
+}
+
+check_empty_config() {
+	test_expect_code 1 git config "branch.$1.remote" &&
+	test_expect_code 1 git config "branch.$1.merge"
+}
+
+for i in simple current upstream nothing
+do
+	test_expect_success 'push -u with push.default=$i' '
+		default_u_setup $i &&
+		git push -u &&
+		check_config main upstream refs/heads/main &&
+		git push -u upstream main:other &&
+		git push -u &&
+		check_config main upstream refs/heads/main
+	'
+
+	test_expect_success 'push -u -f with push.default=$i' '
+		default_u_setup $i &&
+		git push -u -f &&
+		check_config main upstream refs/heads/main
+	'
+done
+
+for i in simple current upstream nothing matching
+do
+	test_expect_success 'push -u --prune with push.default=$i' '
+		default_u_setup $i &&
+		git push upstream main:test_u215 &&
+		git push -u --prune >out &&
+		check_config main upstream refs/heads/main &&
+		test_i18ngrep "[deleted]" out &&
+		test_i18ngrep ! "Branch '"'"'test_u215'"'"' set up to track" out
+	'
+
+	test_expect_success 'push -u --mirror with push.default=$i' '
+		default_u_setup $i &&
+		test_might_fail git branch mirror1 &&
+		test_might_fail git branch mirror2 &&
+		git push -u --mirror &&
+		check_config main upstream  refs/heads/main &&
+		check_config mirror1 upstream refs/heads/mirror1 &&
+		check_config mirror2 upstream refs/heads/mirror2
+	'
+done
+
+for i in '' '-f'
+do
+
+	test_expect_success 'push -u $i with push.default=matching' '
+		default_u_setup matching &&
+		test_might_fail git branch test_u &&
+		test_might_fail git branch test_u2 &&
+		git push upstream main:test_u2 &&
+		git push -u $i &&
+		check_config main upstream refs/heads/main &&
+		check_config test_u2 upstream refs/heads/test_u2 &&
+		check_empty_config test_u
+	'
+done
+
+test_expect_success 'push -u -d will fail' '
+	git checkout main &&
+	test_might_fail git branch --unset-upstream &&
+	test_must_fail git push -u -d
+'
+
+test_expect_success 'push -u --dry-run' '
+	git checkout main &&
+	git push -u upstream main:other &&
+	git push -u --dry-run &&
+	check_config main upstream refs/heads/other
+'
+
 test_expect_success 'push -u --all' '
 	git branch all1 &&
 	git branch all2 &&
@@ -81,6 +161,13 @@ test_expect_success TTY 'progress messages go to tty' '
 	test_i18ngrep "Writing objects" err
 '
 
+test_expect_success TTY 'progress messages go to tty with default -u' '
+	ensure_fresh_upstream &&
+
+	test_terminal git push -u 2>err &&
+	test_i18ngrep "Writing objects" err
+'
+
 test_expect_success 'progress messages do not go to non-tty' '
 	ensure_fresh_upstream &&
 
@@ -89,6 +176,14 @@ test_expect_success 'progress messages do not go to non-tty' '
 	test_i18ngrep ! "Writing objects" err
 '
 
+test_expect_success 'progress messages do not go to non-tty (default -u)' '
+	ensure_fresh_upstream &&
+
+	# skip progress messages, since stderr is non-tty
+	git push -u 2>err &&
+	test_i18ngrep ! "Writing objects" err
+'
+
 test_expect_success 'progress messages go to non-tty (forced)' '
 	ensure_fresh_upstream &&
 
@@ -97,6 +192,14 @@ test_expect_success 'progress messages go to non-tty (forced)' '
 	test_i18ngrep "Writing objects" err
 '
 
+test_expect_success 'progress messages go to non-tty with default -u (forced)' '
+	ensure_fresh_upstream &&
+
+	# force progress messages to stderr, even though it is non-tty
+	git push -u --progress 2>err &&
+	test_i18ngrep "Writing objects" err
+'
+
 test_expect_success TTY 'push -q suppresses progress' '
 	ensure_fresh_upstream &&
 
@@ -104,6 +207,13 @@ test_expect_success TTY 'push -q suppresses progress' '
 	test_i18ngrep ! "Writing objects" err
 '
 
+test_expect_success TTY 'push -q suppresses progress (with default -u)' '
+	ensure_fresh_upstream &&
+
+	test_terminal git push -u -q 2>err &&
+	test_i18ngrep ! "Writing objects" err
+'
+
 test_expect_success TTY 'push --no-progress suppresses progress' '
 	ensure_fresh_upstream &&
 
@@ -112,6 +222,14 @@ test_expect_success TTY 'push --no-progress suppresses progress' '
 	test_i18ngrep ! "Writing objects" err
 '
 
+test_expect_success TTY 'push --no-progress suppresses progress (default -u)' '
+	ensure_fresh_upstream &&
+
+	test_terminal git push -u --no-progress 2>err &&
+	test_i18ngrep ! "Unpacking objects" err &&
+	test_i18ngrep ! "Writing objects" err
+'
+
 test_expect_success TTY 'quiet push' '
 	ensure_fresh_upstream &&
 
@@ -126,4 +244,11 @@ test_expect_success TTY 'quiet push -u' '
 	test_must_be_empty output
 '
 
+test_expect_success TTY 'quiet push -u (default -u)' '
+	ensure_fresh_upstream &&
+
+	test_terminal git push --quiet -u --no-progress 2>&1 | tee output &&
+	test_must_be_empty output
+'
+
 test_done
-- 
2.34.1

