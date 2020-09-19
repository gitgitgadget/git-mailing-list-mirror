Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FC4C43465
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 17:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA2DA2100A
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 17:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8MXYeWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgISRDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 13:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgISRDv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 13:03:51 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE53C0613CE
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 10:03:51 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m15so4649509pls.8
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3XRViAYEO4UU+hFLpk2U4nEE24rHuj78W9pgCcyBX4A=;
        b=W8MXYeWg9U+7lng4bzCRw29omJvnZRBkeoWOuM0a73sRUfX/ERSjXG+j/TgdT9VxUC
         Lztt8THdnfnXuSu9LOuc2RLWcLRDnQ/Yj6+yBDBbY/bwwRSFYzI8LO0i7DzOyUdMP36V
         ChmPU5HnyJCOmgKSfCcT31j1kOibOd/5nguZ8+COT8cJja5t79FBP6Tc5NBeP5QQqsl1
         TsxV2n1pcgeGxw7AhCJwzWxg+BvVVFqWTeSYQOC9m5AHn3RSMYuU2dlo6uI944A5v0ei
         FLOBgKaIl6BsMfDZVoKPvLwfppvWkugBeDG1Z3xLRhmQogjt4dCY09UD2F+lvJ65jBIy
         xYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3XRViAYEO4UU+hFLpk2U4nEE24rHuj78W9pgCcyBX4A=;
        b=MModGRjoMU3LeT8Um5O6kTzX+BinkJWEjL4srclsc86p6HGhaIqrpGYY7oR3N6jqjQ
         eqBWhU/OHqbiGCgWWtL+5Gc7UupJ+FEzAywg8dsE0Lw24R0O/9AZRL7zTAVM2n3p6X0j
         4qnn1ns77rDmigZ/vllu6J0OeleJYvzjggzlakc9vKITFZzoYZLvbV84zZ7ac/feHEbd
         BK5kAiLSa3R9OkHNWtKZJWd6s2mgEmbWKdG8ogq7nkDNgA15IBXBcedcVX2ZdHB8XJuy
         XoQx6RutW5V7Esb8wQrV6gkIdc8d6WfYTKX66l7/EQUpq0eAKED/rEx6c28C4Uv0qeVu
         xIRg==
X-Gm-Message-State: AOAM532dyBVliXK+mzZoqQUed10WYaZIlG7FFEK3GugKZCBK+pRccfJ9
        nz80Ei4I7l8Dv94R61AL9ox6CaNHmM/wYIjb
X-Google-Smtp-Source: ABdhPJxjpfLE8gNTkjNgC7tiks6rTojAD135srItbnFUEkLf4FkgkNGBnBjJHAQVdjcvMJOfkV7C1A==
X-Received: by 2002:a17:90a:f3d1:: with SMTP id ha17mr17807849pjb.231.1600535030679;
        Sat, 19 Sep 2020 10:03:50 -0700 (PDT)
Received: from localhost.localdomain ([104.200.132.172])
        by smtp.gmail.com with ESMTPSA id 25sm1510140pgo.34.2020.09.19.10.03.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Sep 2020 10:03:49 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: [PATCH v4 3/3] t, doc: update tests, reference for "--force-if-includes"
Date:   Sat, 19 Sep 2020 22:33:16 +0530
Message-Id: <20200919170316.5310-4-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
 <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* t/t5533-push-cas.sh:
    Updates test cases for "compare-and-swap" when used along with
    "--force-if-includes" helps mitigate overwrites when remote
    ref are updated in the background.

* Documentation:
    Adds reference for the new option, configuration setting
    ("push.useForceIfIncludes") and advise messages.

Signed-off-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
---
 Documentation/config/advice.txt |  9 ++++--
 Documentation/config/push.txt   |  5 ++++
 Documentation/git-push.txt      | 20 +++++++++++++
 t/t5533-push-cas.sh             | 53 +++++++++++++++++++++++++++++++++
 4 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index bdd37c3eaa..acbd0c09aa 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -10,9 +10,8 @@ advice.*::
 		that the check is disabled.
 	pushUpdateRejected::
 		Set this variable to 'false' if you want to disable
-		'pushNonFFCurrent',
-		'pushNonFFMatching', 'pushAlreadyExists',
-		'pushFetchFirst', and 'pushNeedsForce'
+		'pushNonFFCurrent', 'pushNonFFMatching', 'pushAlreadyExists',
+		'pushFetchFirst', 'pushNeedsForce', and 'pushRefNeedsUpdate'
 		simultaneously.
 	pushNonFFCurrent::
 		Advice shown when linkgit:git-push[1] fails due to a
@@ -41,6 +40,10 @@ advice.*::
 		we can still suggest that the user push to either
 		refs/heads/* or refs/tags/* based on the type of the
 		source object.
+	pushRefNeedsUpdate::
+		Shown when linkgit:git-push[1] rejects a forced update of
+		a branch when its remote-tracking ref has updates that we
+		do not have locally.
 	statusAheadBehind::
 		Shown when linkgit:git-status[1] computes the ahead/behind
 		counts for a local ref compared to its remote tracking ref,
diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index f5e5b38c68..6e57a27608 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -114,3 +114,8 @@ push.recurseSubmodules::
 	specifying '--recurse-submodules=check|on-demand|no'.
 	If not set, 'no' is used by default, unless 'submodule.recurse' is
 	set (in which case a 'true' value means 'on-demand').
+
+push.useForceIfIncludes::
+	If set to "true", it is equivalent to specifying "--force-if-includes"
+	as an argument to linkgit:git-push[1]. Adding "--no-force-if-includes"
+	the time of push overrides this configuration setting.
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 3b8053447e..dc1215a5ad 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -320,6 +320,13 @@ seen and are willing to overwrite, then rewrite history, and finally
 force push changes to `master` if the remote version is still at
 `base`, regardless of what your local `remotes/origin/master` has been
 updated to in the background.
++
+Alternatively, specifying "--force-if-includes" an an ancillary option along
+with "--force-with-lease[=<refname>]" (i.e., without saying what exact commit
+the ref on the remote side must be pointing at, or which refs on the remote
+side are being protected) at the time of "push" will verify if updates from the
+remote-tracking refs that may have been implicitly updated in the background
+are integrated locally before allowing a forced update.
 
 -f::
 --force::
@@ -341,6 +348,19 @@ one branch, use a `+` in front of the refspec to push (e.g `git push
 origin +master` to force a push to the `master` branch). See the
 `<refspec>...` section above for details.
 
+--[no-]force-if-includes::
+	Force an update only if the tip of the remote-tracking ref
+	has been integrated locally.
++
+This option verifies if the tip of the remote-tracking ref on which
+a local branch has based on (for a rewrite), is reachable from at
+least one of the "reflog" entries of the local branch about to be
+updated by force on the remote. The check ensures that any updates
+from the remote have been incorporated locally by rejecting a push
+if that is not the case.
++
+Specifying "--no-force-if-includes" disables this behavior.
+
 --repo=<repository>::
 	This option is equivalent to the <repository> argument. If both
 	are specified, the command-line argument takes precedence.
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index 0b0eb1d025..60dd7d2f1c 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -256,4 +256,57 @@ test_expect_success 'background updates of REMOTE can be mitigated with a non-up
 	)
 '
 
+test_expect_success 'background updates of REMOTE can be mitigated with "--force-if-includes"' '
+	rm -rf src dst &&
+	git init --bare src.bare &&
+	test_when_finished "rm -rf src.bare" &&
+	git clone --no-local src.bare dst &&
+	test_when_finished "rm -rf dst" &&
+	(
+		cd dst &&
+		test_commit G &&
+		git push origin master:master
+	) &&
+	git clone --no-local src.bare dst2 &&
+	test_when_finished "rm -rf dst2" &&
+	(
+		cd dst2 &&
+		test_commit H &&
+		git push
+	) &&
+	(
+		cd dst &&
+		test_commit I &&
+		git fetch origin &&
+		test_must_fail git push --force-with-lease --force-if-includes origin
+	)
+'
+
+test_expect_success 'background updates of REMOTE can be mitigated with "push.useForceIfIncludes"' '
+	rm -rf src dst &&
+	git init --bare src.bare &&
+	test_when_finished "rm -rf src.bare" &&
+	git clone --no-local src.bare dst &&
+	test_when_finished "rm -rf dst" &&
+	(
+		cd dst &&
+		test_commit G &&
+		git push origin master:master
+	) &&
+	git clone --no-local src.bare dst2 &&
+	test_when_finished "rm -rf dst2" &&
+	(
+		cd dst2 &&
+		test_commit H &&
+		git push
+	) &&
+	(
+		cd dst &&
+		test_commit I &&
+		git fetch origin &&
+		git config --local push.useForceIfIncludes "true" &&
+		test_must_fail git push --force-if-includes origin
+	)
+'
+
 test_done
-- 
2.28.0

