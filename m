Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C37C4727D
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 07:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C845D235FC
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 07:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZK/nwz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgIWHaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 03:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgIWHaj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 03:30:39 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB26C061755
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 00:30:39 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id o5so21866394qke.12
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 00:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XM178Kolr6F+51QSvZaKRKC/XvXe3mqYFzJQOqwJRRs=;
        b=IZK/nwz6lgPVkiC7qUaGSbPqPNcoFltzxOxkH0AsopUon0PH6V5g0A9zRXqtToBUVe
         w8D41do0UrBuun8t0WHu48hIaM1glVFTDLYt3JPPB13e4SYD0P1waL1QWd7NXglC6Yys
         egfQfQuT/QeES0dnxClxfLd8dgrcaPu3cpBrfufRM93O8BOb9sSyM850LmgjB1azZEuN
         nYmWPBiUQUMKK6CQzJHasw3KxfAAx+V7kcfe4Jd+yWF9Xc3/U5f9L4CsOwCdwNIPBysJ
         YulVcFXNYENaJWxUzYMva6kA0HD7n0ietOGaIH08GRqoEMXlwoBA9BSSpotX1Qmx87gv
         QaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XM178Kolr6F+51QSvZaKRKC/XvXe3mqYFzJQOqwJRRs=;
        b=ncQIg3stBb87YCosl66fUrDe2NTZKVLhKNqbBcbX+SHiLZc9gkykOi90V2g7ZqVAbc
         J6+R/h35Vym71X8JplfDpuDQzZbc7asa0hBcNSuRCHZ0wZl7T/J4Lv9C5ABe7aUdz+E0
         0KfRmQNoayhTpBthr2X2PlS+ioHbzm/7LJKEM6uVF9hGt7L/4ubuon+0cWFBaSyiqeTp
         7PbRVTqItIuq95TSxehqow/xa5Uy+xutXNc617Vo1r4Z/0Ytvd3GBtrulBJw8eISxuCe
         2KewO69tbsBsBubJkDBNLz/FFZMPM5Jk6D67/H/z+GGgeBVD4YVX0BJcdVnle5U2RYYa
         7eyw==
X-Gm-Message-State: AOAM532aXjZUCNLEgStTX1EzIaENEnKtgLPd/1Cfg1rDI2yTHiDbuR/y
        qZyP3/7gvk2nvgggevW2q/+5gCFHYs/sBxxG
X-Google-Smtp-Source: ABdhPJy5/xObexXHiNDPr0hx3SlmIrTN41yuMbGWJyIwnL+uRkgKSXzd/tSFjkRvXnEFsmsVl69g5g==
X-Received: by 2002:a37:9e81:: with SMTP id h123mr8062882qke.117.1600846238273;
        Wed, 23 Sep 2020 00:30:38 -0700 (PDT)
Received: from localhost.localdomain ([124.123.107.121])
        by smtp.gmail.com with ESMTPSA id i18sm6341138qka.50.2020.09.23.00.30.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 00:30:37 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: [PATCH v5 3/3] t, doc: update tests, reference for "--force-if-includes"
Date:   Wed, 23 Sep 2020 13:00:22 +0530
Message-Id: <20200923073022.61293-4-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200923073022.61293-1-shrinidhi.kaushik@gmail.com>
References: <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
 <20200923073022.61293-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update test cases for the new option, and document its usage
and update related references.

 - t/t5533-push-cas.sh:
   Update test cases for "compare-and-swap" when used along with
   "--force-if-includes" helps mitigate overwrites when remote
   ref are updated in the background.

 - Documentation:
   Add reference for the new option, configuration setting
   ("push.useForceIfIncludes") and advise messages.

Signed-off-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
---
 Documentation/config/advice.txt |  9 ++++--
 Documentation/config/push.txt   |  6 ++++
 Documentation/git-push.txt      | 26 +++++++++++++++-
 t/t5533-push-cas.sh             | 53 +++++++++++++++++++++++++++++++++
 4 files changed, 90 insertions(+), 4 deletions(-)

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
index f5e5b38c68..fd981f7808 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -114,3 +114,9 @@ push.recurseSubmodules::
 	specifying '--recurse-submodules=check|on-demand|no'.
 	If not set, 'no' is used by default, unless 'submodule.recurse' is
 	set (in which case a 'true' value means 'on-demand').
+
+push.useForceIfIncludes::
+	If set to "true", it is equivalent to specifying
+	"--force-if-includes" as an option to linkgit:git-push[1]
+	in the command line. Adding "--no-force-if-includes" at the
+	time of push overrides this configuration setting.
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 3b8053447e..706380d263 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	   [--repo=<repository>] [-f | --force] [-d | --delete] [--prune] [-v | --verbose]
 	   [-u | --set-upstream] [-o <string> | --push-option=<string>]
 	   [--[no-]signed|--signed=(true|false|if-asked)]
-	   [--force-with-lease[=<refname>[:<expect>]]]
+	   [--force-with-lease[=<refname>[:<expect>]] [--force-if-includes]]
 	   [--no-verify] [<repository> [<refspec>...]]
 
 DESCRIPTION
@@ -320,6 +320,14 @@ seen and are willing to overwrite, then rewrite history, and finally
 force push changes to `master` if the remote version is still at
 `base`, regardless of what your local `remotes/origin/master` has been
 updated to in the background.
++
+Alternatively, specifying "--force-if-includes" an an ancillary option
+along with "--force-with-lease[=<refname>]" (i.e., without saying what
+exact commit the ref on the remote side must be pointing at, or which
+refs on the remote side are being protected) at the time of "push" will
+verify if updates from the remote-tracking refs that may have been
+implicitly updated in the background are integrated locally before
+allowing a forced update.
 
 -f::
 --force::
@@ -341,6 +349,22 @@ one branch, use a `+` in front of the refspec to push (e.g `git push
 origin +master` to force a push to the `master` branch). See the
 `<refspec>...` section above for details.
 
+--[no-]force-if-includes::
+	Force an update only if the tip of the remote-tracking ref
+	has been integrated locally.
++
+This option enables a check that verifies if the tip of the
+remote-tracking ref is reachable from one of the "reflog" entries of
+the local branch based in it for a rewrite. The check ensures that any
+updates from the remote have been incorporated locally by rejecting the
+forced update if that is not the case.
++
+If the option is passed without specifying "--force-with-lease", or
+specified along with "--force-with-lease=<refname>:<expect>", it is
+a "no-op".
++
+Specifying "--no-force-if-includes" disables this behavior.
+
 --repo=<repository>::
 	This option is equivalent to the <repository> argument. If both
 	are specified, the command-line argument takes precedence.
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index 0b0eb1d025..620d101f50 100755
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
+		test_must_fail git push --force-with-lease origin
+	)
+'
+
 test_done
-- 
2.28.0

