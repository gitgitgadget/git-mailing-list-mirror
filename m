Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111B2C4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 21:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236823AbiKNVhV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 16:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbiKNVhU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 16:37:20 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3F465F8
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 13:37:18 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id j132-20020a25238a000000b006da635e2073so11435536ybj.2
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 13:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TM24X7TOICLIUrFZKTQkVBtsUBRU2t7ZRNg2WeRYyZY=;
        b=anWgLAuE7mNKF0fLyqd11iqaq3k7617xTWgD/o+SlcCKy2FUmTiaqACFClKG/QuHkY
         SC4p9tjko3Xxtimm56lQzdw6VkCd5FoTH88T8Kef4spZSzRca1Lgj6PKYSRLmV8p3tez
         kP6HUn3RmzypvDdNMyeZvSzUscuv3ZHZAHpeYBMeihQxMHua5+cig3uyIWf2OC0tLeK3
         5iMCbdbZR/0EtNJNSl4oFM6gAV9XIK0jM6r+dVs05wPg1s4hWKkGPoxWW8NVnqDuXIRr
         CV5ONA24wucoVkcBMsNx8gCvY8C0/qRbDDiNgFa0NbiWoPH2VDX9vQ/ODDjCqwWWJNcH
         haRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TM24X7TOICLIUrFZKTQkVBtsUBRU2t7ZRNg2WeRYyZY=;
        b=CMOU4K/d716uTqT2IgYEJAjTL/ZlFStKAzHs4UtaqT1zm/vh41ZWYFJv6C/7Mp6LEV
         TrPU+1owwx968qC8twOU38WryPDVvQHOlWxM+0jnt1gq5f2tho8yfYuzWxaUBGPlwmJp
         EKYvurXdDEFog9dSG5Wil+qlzvI2aAqG4gF4/FPE+sfGmkDLV30ssk0UNqKX/gPKN8O+
         DCis+ubK281U1lO8WkCkdNHvwChVQ8/oTcAWABQ6EBSq8mly2uBGHBhpPen83xdPpzVB
         TVMX6vEl9UN7YnbHCB0t5nHo5qh9YBhCdx6nbcYUW8AAFak5hLg/xnm/cxVpRUiYtyvj
         /krA==
X-Gm-Message-State: ACrzQf3G56dD6hKy8unIBKYW4LNbqLt+8vlW1lvfTCijM1tFKdXys6fS
        zBVl68fyJ0snZKTFefp59Toegpu17mL0NmfoLQ6hIODrGH2Tc/WFxiTELLciFWXGD8rSk5s+pLI
        VLS8FuKTMKiZYb/tTayzTvnW8GBDORqLqWc40060evyGF1vvBdST+UUphN70hbE/K0AqXkQGgvK
        KU
X-Google-Smtp-Source: AMsMyM4rOC+0JOIbySuug8JYeQw2pAshWXlVhKfC4G0a2MGiY+nvBBrKPI3NXsIxemBT83ST3HJVk6es6lIt/tW3mqWx
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:af49:0:b0:6af:fbf5:92d5 with
 SMTP id c9-20020a25af49000000b006affbf592d5mr64720301ybj.624.1668461837302;
 Mon, 14 Nov 2022 13:37:17 -0800 (PST)
Date:   Mon, 14 Nov 2022 13:37:12 -0800
In-Reply-To: <20221108002553.3836987-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20221108002553.3836987-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
Message-ID: <20221114213713.2341945-1-jonathantanmy@google.com>
Subject: [PATCH v2] Doc: document push.recurseSubmodules=only
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, chooglen@google.com,
        me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git learned pushing submodules without pushing the superproject by
the user specifying --recurse-submodules=only through 6c656c3fe4
("submodules: add RECURSE_SUBMODULES_ONLY value", 2016-12-20) and
225e8bf778 ("push: add option to push only submodules", 2016-12-20).
For users who use this feature regularly, it is desirable to have an
equivalent configuration.

It turns out that such a configuration (push.recurseSubmodules=only) is
already supported, even though it is neither documented nor mentioned
in the commit messages, due to the way the --recurse-submodules=only
feature was implemented (a function used to parse --recurse-submodules
was updated to support "only", but that same function is used to parse
push.recurseSubmodules too). What is left is to document it and test it,
which is what this commit does.

There is a possible point of confusion when recursing into a submodule
that itself has the push.recurseSubmodules=only configuration, because
if a repository has only its submodules pushed and not itself, its
superproject can never be pushed. Therefore, treat such configurations
as being "on-demand", and print a warning message.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Thanks once again, Taylor and Glen for your comments. To try to
summarize:

- For me, the most important thing is to explicitly support (with
  documentation) the push.recurseSubmodules=only configuration.
- Between the submodule being able to decide for itself whether
  recursion continues, and the superproject deciding everything, Taylor
  thinks the former is more convincing.
  - The former is also the status quo.
- Glen makes a further point that either scheme (the status quo and the
  behavior in v1) would not be the ideal behavior, but that a CLI
  argument overrides all config, and in the absence of a CLI argument,
  a submodule should be able to decide for itself whether recursion
  should continue (except when there is no config present, in which case
  it should defer to the superproject).

If we were to implement v1 and then the ideal behavior later, we
would need to revert some of the v1-introduced behavior: if there is
configuration in both the superproject and a submodule, the status
quo is that the submodule's configuration takes precedence, v1 has the
superproject's configuration taking precedence, and with ideal behavior,
the submodule's configuration takes precedence.

So it makes sense to stick to the status quo for this patch. It is
possible to support push.recurseSubmodules=only with all existing
behavior preserved (in fact, push.recurseSubmodules=only is already
supported, just undocumented) so I have decided to go with that
approach.
---
 Documentation/config/push.txt  | 14 ++--------
 Documentation/git-push.txt     |  6 +++-
 builtin/push.c                 | 12 ++++++--
 submodule.c                    |  6 ++++
 t/t5531-deep-submodule-push.sh | 50 ++++++++++++++++++++++++++++++++++
 5 files changed, 73 insertions(+), 15 deletions(-)

diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index 7386fea225..43338b65e8 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -110,18 +110,8 @@ This will result in only b (a and c are cleared).
 ----
 
 push.recurseSubmodules::
-	Make sure all submodule commits used by the revisions to be pushed
-	are available on a remote-tracking branch. If the value is 'check'
-	then Git will verify that all submodule commits that changed in the
-	revisions to be pushed are available on at least one remote of the
-	submodule. If any commits are missing, the push will be aborted and
-	exit with non-zero status. If the value is 'on-demand' then all
-	submodules that changed in the revisions to be pushed will be
-	pushed. If on-demand was not able to push all necessary revisions
-	it will also be aborted and exit with non-zero status. If the value
-	is 'no' then default behavior of ignoring submodules when pushing
-	is retained. You may override this configuration at time of push by
-	specifying '--recurse-submodules=check|on-demand|no'.
+	May be "check", "on-demand", "only", or "no", with the same behavior
+	as that of "push --recurse-submodules".
 	If not set, 'no' is used by default, unless 'submodule.recurse' is
 	set (in which case a 'true' value means 'on-demand').
 
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index def7657ef9..5bb1d5aae2 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -409,10 +409,14 @@ Specifying `--no-force-if-includes` disables this behavior.
 	all submodules that changed in the revisions to be pushed will be
 	pushed. If on-demand was not able to push all necessary revisions it will
 	also be aborted and exit with non-zero status. If 'only' is used all
-	submodules will be recursively pushed while the superproject is left
+	submodules will be pushed while the superproject is left
 	unpushed. A value of 'no' or using `--no-recurse-submodules` can be used
 	to override the push.recurseSubmodules configuration variable when no
 	submodule recursion is required.
++
+When using 'on-demand' or 'only', if a submodule has a
+"push.recurseSubmodules={on-demand,only}" or "submodule.recurse" configuration,
+further recursion will occur. In this case, "only" is treated as "on-demand".
 
 --[no-]verify::
 	Toggle the pre-push hook (see linkgit:githooks[5]).  The
diff --git a/builtin/push.c b/builtin/push.c
index f0329c62a2..60ac8017e5 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -466,8 +466,16 @@ static int option_parse_recurse_submodules(const struct option *opt,
 
 	if (unset)
 		*recurse_submodules = RECURSE_SUBMODULES_OFF;
-	else
-		*recurse_submodules = parse_push_recurse_submodules_arg(opt->long_name, arg);
+	else {
+		if (!strcmp(arg, "only-is-on-demand")) {
+			if (*recurse_submodules == RECURSE_SUBMODULES_ONLY) {
+				warning(_("recursing into submodule with push.recurseSubmodules=only; using on-demand instead"));
+				*recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
+			}
+		} else {
+			*recurse_submodules = parse_push_recurse_submodules_arg(opt->long_name, arg);
+		}
+	}
 
 	return 0;
 }
diff --git a/submodule.c b/submodule.c
index bf7a2c7918..5cd21252d8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1130,6 +1130,12 @@ static int push_submodule(const char *path,
 	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		strvec_push(&cp.args, "push");
+		/*
+		 * When recursing into a submodule, treat any "only" configurations as "on-
+		 * demand", since "only" would not work (we need all submodules to be pushed
+		 * in order to be able to push the superproject).
+		 */
+		strvec_push(&cp.args, "--recurse-submodules=only-is-on-demand");
 		if (dry_run)
 			strvec_push(&cp.args, "--dry-run");
 
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 3f58b515ce..302e4cbdba 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -512,6 +512,56 @@ test_expect_success 'push only unpushed submodules recursively' '
 	test_cmp expected_pub actual_pub
 '
 
+setup_subsub () {
+	git init upstream &&
+	git init upstream/sub &&
+	git init upstream/sub/deepsub &&
+	test_commit -C upstream/sub/deepsub innermost &&
+	git -C upstream/sub submodule add ./deepsub deepsub &&
+	git -C upstream/sub commit -m middle &&
+	git -C upstream submodule add ./sub sub &&
+	git -C upstream commit -m outermost &&
+
+	git -c protocol.file.allow=always clone --recurse-submodules upstream downstream &&
+	git -C downstream/sub/deepsub checkout -b downstream-branch &&
+	git -C downstream/sub checkout -b downstream-branch &&
+	git -C downstream checkout -b downstream-branch
+}
+
+new_downstream_commits () {
+	test_commit -C downstream/sub/deepsub new-innermost &&
+	git -C downstream/sub add deepsub &&
+	git -C downstream/sub commit -m new-middle &&
+	git -C downstream add sub &&
+	git -C downstream commit -m new-outermost
+}
+
+test_expect_success 'push with push.recurseSubmodules=only on superproject' '
+	test_when_finished rm -rf upstream downstream &&
+	setup_subsub &&
+	new_downstream_commits &&
+	git -C downstream config push.recurseSubmodules only &&
+	git -C downstream push origin downstream-branch &&
+
+	test_must_fail git -C upstream rev-parse refs/heads/downstream-branch &&
+	git -C upstream/sub rev-parse refs/heads/downstream-branch &&
+	test_must_fail git -C upstream/sub/deepsub rev-parse refs/heads/downstream-branch
+'
+
+test_expect_success 'push with push.recurseSubmodules=only on superproject and top-level submodule' '
+	test_when_finished rm -rf upstream downstream &&
+	setup_subsub &&
+	new_downstream_commits &&
+	git -C downstream config push.recurseSubmodules only &&
+	git -C downstream/sub config push.recurseSubmodules only &&
+	git -C downstream push origin downstream-branch 2> err &&
+
+	test_must_fail git -C upstream rev-parse refs/heads/downstream-branch &&
+	git -C upstream/sub rev-parse refs/heads/downstream-branch &&
+	git -C upstream/sub/deepsub rev-parse refs/heads/downstream-branch &&
+	grep "recursing into submodule with push.recurseSubmodules=only; using on-demand instead" err
+'
+
 test_expect_success 'push propagating the remotes name to a submodule' '
 	git -C work remote add origin ../pub.git &&
 	git -C work remote add pub ../pub.git &&
-- 
2.38.1.493.g58b659f92b-goog

