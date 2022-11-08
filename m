Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CF9C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 00:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiKHA0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 19:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiKHA0A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 19:26:00 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813C4E0DF
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 16:25:59 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s201-20020a2577d2000000b006d5848a04e4so5571922ybc.23
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 16:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6XvwUmtVhnHf89WEujF9W3UiL36OfpGgC/CdfydqX78=;
        b=nrWvuEqMdwlQ44HJSEridTy0S+1F4bMKk1jbhv/o2R9tA+TNddZMfRSpDdSkeo3adN
         CyKIXo0WGThPLqLLM8mHNyPM9PRrck9wRdLWNJKnBDaSlW2i019GvSrvbdLQCVeBe0T1
         UmFV2rgTgJrX5UZb9DNsowb0Iy9VIMOwXldLyuTOdb/Meqqmd/FA7NSXVytTbLf1ZW4/
         uQNNwA/FRD1isLY9hCHhBLaYGvVfMOUuSEOaks2pJw3c4lKNVSIadOfV1vTf9wY9gbv4
         7STmUfKc1d85OXv0eSGyWy/y0lVI/3Q+x0fGnaotGMpM8DxBLq3l6takEEX2JArLClUo
         /Dxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6XvwUmtVhnHf89WEujF9W3UiL36OfpGgC/CdfydqX78=;
        b=c7YhB9+xd8d/bNdYl2ZedTyF8YIeVmArqRLZdJYCE9Nf0uAUDDJOWGWzspFqQ61dVB
         FGZhSS2iEgZZ9uAZfMKnsp5m90RMUX6YGAKbJcZUVD2t2AL7+CvHbcGbyvKr5bkE2+Z6
         lEqL/LNFLvheXR7m5One6WPu69O20Tkp3vfs1X502JFfZjfu+DIiOVpgqUy/WPU5tYnW
         aySB8NjdWcdjsm8o7Yposv0MOrHFuoUHqqHiJMze7Zs7cxadw25KylMYkGATMpubTviQ
         sdoiF57sO2hR1Aulydc0LrCRDaHoXK/z0kIDy7xgsNfk9NF4FgE0N86spJFxc/GSEAKy
         RvHQ==
X-Gm-Message-State: ACrzQf0s9cm7VVmEWPjDxoMkkctV4KtuW+U5Gu/Do4ob7jMQkqYbaz/r
        J9C2h+20z55vqwcGkvo25M02oDQ7CplEiDQ/4nHRx8K9YcONIpIdNbfOfLxC9L3FhlM/jqcLrQo
        vbpUFlkK5kpLNmuWeXVwNHSVTYfKrqmvsvkGGxUTbIycLvWTzODLNPHjfkPLeo9Mm9y9IYItHEa
        TA
X-Google-Smtp-Source: AMsMyM7Q/3Wui4OmOrHrj1rG6V8Wh38sE3V8zIIE3UV0ME2jCQESgon5T3zh9Uidk91YMJolTMZZMrl05pARXyBsGg7I
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a5b:1c3:0:b0:6ac:c87f:3dc8 with SMTP
 id f3-20020a5b01c3000000b006acc87f3dc8mr48793366ybp.547.1667867158728; Mon,
 07 Nov 2022 16:25:58 -0800 (PST)
Date:   Mon,  7 Nov 2022 16:25:52 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221108002553.3836987-1-jonathantanmy@google.com>
Subject: [PATCH] submodule: explicitly specify on-demand upon push
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running "git push --recurse-submodules=on-demand" (or "=only") on a
superproject with nested submodules and assuming default configurations,
only the top-level submodules are pushed. This is because recursion
into the top-level submodules is performed with "git push" (without any
additional relevant options), and the default configuration is to not
recurse to nested submodules.

Therefore, instead of recursing with "git push" without any additional
relevant options, recurse with "--recurse-submodules=on-demand".

This now means that any push.recurseSubmodules configuration in any
submodule is no longer respected: only the configuration (or CLI
argument to override it) of the superproject is used. Update the
documentation accordingly.

(As a side effect of making the documentation of both the CLI argument
and the config variable consistent, the config variable is now
documented to support "only". This has been the case for a while, and I
have also included a test to show that.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/config/push.txt  | 18 ++++------
 Documentation/git-push.txt     |  2 +-
 submodule.c                    |  9 +++++
 t/t5531-deep-submodule-push.sh | 66 ++++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+), 13 deletions(-)

diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index 7386fea225..9960afef84 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -110,20 +110,14 @@ This will result in only b (a and c are cleared).
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
++
+Whenever "git push" is executed, only the configuration of the
+repository in which the command was run is used, not any of its
+submodules (even if any such submodule contains its own submodules).
 
 push.useForceIfIncludes::
 	If set to "true", it is equivalent to specifying
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index def7657ef9..c63a4c186b 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -407,7 +407,7 @@ Specifying `--no-force-if-includes` disables this behavior.
 	remote of the submodule. If any commits are missing the push will
 	be aborted and exit with non-zero status. If 'on-demand' is used
 	all submodules that changed in the revisions to be pushed will be
-	pushed. If on-demand was not able to push all necessary revisions it will
+	recursively pushed. If on-demand was not able to push all necessary revisions it will
 	also be aborted and exit with non-zero status. If 'only' is used all
 	submodules will be recursively pushed while the superproject is left
 	unpushed. A value of 'no' or using `--no-recurse-submodules` can be used
diff --git a/submodule.c b/submodule.c
index bf7a2c7918..06ee74a282 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1130,6 +1130,15 @@ static int push_submodule(const char *path,
 	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		strvec_push(&cp.args, "push");
+		/*
+		 * If this function is called, it is because the user
+		 * requested recursion through
+		 * --recurse-submodules=on-demand or
+		 * --recurse-submodules=only (or the equivalent
+		 * config). In both cases, we should fully recurse into
+		 * all submodules and their descendants.
+		 */
+		strvec_push(&cp.args, "--recurse-submodules=on-demand");
 		if (dry_run)
 			strvec_push(&cp.args, "--dry-run");
 
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 3f58b515ce..b9daf262a9 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -512,6 +512,72 @@ test_expect_success 'push only unpushed submodules recursively' '
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
+test_expect_success 'push recurses into submodule and sub-submodule' '
+	test_when_finished rm -rf upstream downstream &&
+	setup_subsub &&
+	new_downstream_commits &&
+	git -C downstream push --recurse-submodules=only origin downstream-branch &&
+
+	test_must_fail git -C upstream rev-parse refs/heads/downstream-branch &&
+	git -C upstream/sub rev-parse refs/heads/downstream-branch &&
+	git -C upstream/sub/deepsub rev-parse refs/heads/downstream-branch
+'
+
+test_expect_success 'recursive push ignores submodule config' '
+	test_when_finished rm -rf upstream downstream &&
+	setup_subsub &&
+	new_downstream_commits &&
+	git -C downstream config push.recurseSubmodules no &&
+	git -C downstream/sub config push.recurseSubmodules no &&
+	git -C downstream/sub/deepsub config push.recurseSubmodules no &&
+	git -C downstream push --recurse-submodules=on-demand origin downstream-branch &&
+
+	# pushes still happen, despite config
+	git -C upstream rev-parse refs/heads/downstream-branch &&
+	git -C upstream/sub rev-parse refs/heads/downstream-branch &&
+	git -C upstream/sub/deepsub rev-parse refs/heads/downstream-branch
+'
+
+test_expect_success 'push with push.recurseSubmodules=only' '
+	test_when_finished rm -rf upstream downstream &&
+	setup_subsub &&
+	new_downstream_commits &&
+	git -C downstream config push.recurseSubmodules only &&
+	git -C downstream/sub config push.recurseSubmodules only &&
+	git -C downstream/sub/deepsub config push.recurseSubmodules only &&
+	git -C downstream push origin downstream-branch &&
+
+	# all pushes happen except superproject (the intermediate
+	# "only" does not apply because only the superproject config is honored)
+	test_must_fail git -C upstream rev-parse refs/heads/downstream-branch &&
+	git -C upstream/sub rev-parse refs/heads/downstream-branch &&
+	git -C upstream/sub/deepsub rev-parse refs/heads/downstream-branch
+'
+
 test_expect_success 'push propagating the remotes name to a submodule' '
 	git -C work remote add origin ../pub.git &&
 	git -C work remote add pub ../pub.git &&
-- 
2.38.1.431.g37b22c650d-goog

