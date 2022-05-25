Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBC9C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241617AbiEYKE7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241261AbiEYKEt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:04:49 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0288A6D961
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:48 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x12so5141390wrg.2
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AZ3/tKEcQLu4mh5k5aLUKcrTGIGBhgkdKtbJX55YB3o=;
        b=EB0PnfXK3si5vIF+0eV5ZYOB4r0PmNKpCXxJNOQWlli+bGlCEqfdETfKBdrtuortS/
         PRF1wD2EvdOAbGG9ZrB5mmMaI1C1VyaevviOwRQPh31olgzSnE0dUAIatVQpnc9v1j6B
         vVIyJNamJ8fFlIHF14vHnT+unhuJuOY6DASj/+D+ieAsjxbkPN5q0qQ/GaNBuFlm5sBc
         zuc4Wt7QPdxGDCm6zsVV/HuZLYdX7/KRZLC13Chdut94wCIbumKtI49I4qhCidYTmVpA
         09lOzP8HGphakcH6slJznjiIvbAffRhLLB5EJAT5vYvlovrENAvE8s8L8Ejr/tbzea43
         fmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AZ3/tKEcQLu4mh5k5aLUKcrTGIGBhgkdKtbJX55YB3o=;
        b=w9d2/L5/k6p+uVTVziLii81Y+FR/59UkhgjLVPsM0Y+D9gElNQhzX3/V8fuAkpDYZ6
         KzPoo9TyvQ6IxBSCtCUFcfUrOj4G6+nPRb+4yYhilnkggwfszqx7ih7y9sqEk8cKjJYC
         NmaKGiszE9s7P1qtOGdoXUqBHsLZXRzwuQ80y4j7Hszz33s6bZOHYS6A+9G/XDr00DiS
         uyfRy5L3X0qY18E5+A7k24nGDm+GTwu0cox7umcp4i7XSRKn0FHn7SYhMNYVjWWaGaM/
         1vzU+eCqyC08aSR6BUiX0MGbevLHfX/kKOW20QbQFusy2h+B8sPLksyLjKAZBE7SfCXz
         eIvg==
X-Gm-Message-State: AOAM532XCUiRJbQ0pcj7RguW47ymhoK3pqX9ZWuUYKILP7eBPqzc+ENs
        IgX+zu1/yKGny6YQTavg0WoczyO1l6TSkA==
X-Google-Smtp-Source: ABdhPJytJRIp4FKYluluP1XV72A3PvMOLNu7xh4IFr6yY6NklD2TRfvLxutswXyII0BpSaXN5whqRg==
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id b13-20020adff90d000000b0020cde324d35mr25914605wrr.583.1653473086228;
        Wed, 25 May 2022 03:04:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:04:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 04/29] CI: remove dead "tree skipping" code
Date:   Wed, 25 May 2022 12:03:43 +0200
Message-Id: <patch-v6-04.29-36a6287ee9b-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the code related to skipping CI runs if the tree was
successfully tested before. With the GitHub CI this is done with the
"ci-config" step, see e76eec35540 (ci: allow per-branch config for
GitHub Actions, 2020-05-07) and 7d78d5fc1a9 (ci: skip GitHub workflow
runs for already-tested commits/trees, 2020-10-08).

This code hasn't been used since 4a6e4b96026 (CI: remove Travis CI
support, 2021-11-23), and before that for the retired Azure pipeline
support removed in 6081d3898fe (ci: retire the Azure Pipelines
definition, 2020-04-11).

This change is needed because this and subsequent commits are turning
"ci/lib.sh" into a dumber library that'll only be tasked with setting
variables for CI jobs, or for specific steps within those jobs. Now we
don't need to worry about it potentially skipping the run on its own.

This change also removes a subtle potential logic error introduced in
0e7696c64db (ci: disallow directional formatting, 2021-11-04). The
"ci/check-directional-formatting.bash" script would have been made to
run after the "save_good_tree" in invoked in
"ci/run-static-analysis.sh". So if e.g. the "make coccicheck" failed
we'd still mark the tree as good.

I.e. the addition of "ci/check-directional-formatting.bash" didn't
take into account that the various users of the "save_good_tree"
function in ci/*.sh made a hard assumption that they're the only
ci/*.sh script that's being run (and they use "set -e").

This is entirely academic since we weren't actually running this code,
but is something to be careful of if anyone ever needs to resurrect
parts of this.

Finally, the cache_dir="$HOME/none" added in a3f2eec862b (ci/lib:
allow running in GitHub Actions, 2020-04-08) for the GitHub CI can be
removed. It appears to have been added to appease the subsequent
'mkdir -p "$cache_dir"', which wasn't needed in GitHub CI.

1. https://lore.kernel.org/git/patch-1.1-eec0a8c3164-20211217T000418Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh                 | 91 ---------------------------------------
 ci/run-build-and-tests.sh |  2 -
 ci/run-static-analysis.sh |  2 -
 ci/test-documentation.sh  |  2 -
 4 files changed, 97 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 2e60c0a71b5..e04b53b428d 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -13,75 +13,6 @@ then
 	exit 1
 fi
 
-skip_branch_tip_with_tag () {
-	# Sometimes, a branch is pushed at the same time the tag that points
-	# at the same commit as the tip of the branch is pushed, and building
-	# both at the same time is a waste.
-	#
-	# When the build is triggered by a push to a tag, $CI_BRANCH will
-	# have that tagname, e.g. v2.14.0.  Let's see if $CI_BRANCH is
-	# exactly at a tag, and if so, if it is different from $CI_BRANCH.
-	# That way, we can tell if we are building the tip of a branch that
-	# is tagged and we can skip the build because we won't be skipping a
-	# build of a tag.
-
-	if TAG=$(git describe --exact-match "$CI_BRANCH" 2>/dev/null) &&
-		test "$TAG" != "$CI_BRANCH"
-	then
-		echo "$(tput setaf 2)Tip of $CI_BRANCH is exactly at $TAG$(tput sgr0)"
-		exit 0
-	fi
-}
-
-# Save some info about the current commit's tree, so we can skip the build
-# job if we encounter the same tree again and can provide a useful info
-# message.
-save_good_tree () {
-	echo "$(git rev-parse $CI_COMMIT^{tree}) $CI_COMMIT $CI_JOB_NUMBER $CI_JOB_ID" >>"$good_trees_file"
-	# limit the file size
-	tail -1000 "$good_trees_file" >"$good_trees_file".tmp
-	mv "$good_trees_file".tmp "$good_trees_file"
-}
-
-# Skip the build job if the same tree has already been built and tested
-# successfully before (e.g. because the branch got rebased, changing only
-# the commit messages).
-skip_good_tree () {
-	if test true = "$GITHUB_ACTIONS"
-	then
-		return
-	fi
-
-	if ! good_tree_info="$(grep "^$(git rev-parse $CI_COMMIT^{tree}) " "$good_trees_file")"
-	then
-		# Haven't seen this tree yet, or no cached good trees file yet.
-		# Continue the build job.
-		return
-	fi
-
-	echo "$good_tree_info" | {
-		read tree prev_good_commit prev_good_job_number prev_good_job_id
-
-		if test "$CI_JOB_ID" = "$prev_good_job_id"
-		then
-			cat <<-EOF
-			$(tput setaf 2)Skipping build job for commit $CI_COMMIT.$(tput sgr0)
-			This commit has already been built and tested successfully by this build job.
-			To force a re-build delete the branch's cache and then hit 'Restart job'.
-			EOF
-		else
-			cat <<-EOF
-			$(tput setaf 2)Skipping build job for commit $CI_COMMIT.$(tput sgr0)
-			This commit's tree has already been built and tested successfully in build job $prev_good_job_number for commit $prev_good_commit.
-			The log of that build job is available at $SYSTEM_TASKDEFINITIONSURI$SYSTEM_TEAMPROJECT/_build/results?buildId=$prev_good_job_id
-			To force a re-build delete the branch's cache and then hit 'Restart job'.
-			EOF
-		fi
-	}
-
-	exit 0
-}
-
 check_unignored_build_artifacts ()
 {
 	! git ls-files --other --exclude-standard --error-unmatch \
@@ -102,16 +33,8 @@ if test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
 then
 	CI_TYPE=azure-pipelines
 	# We are running in Azure Pipelines
-	CI_BRANCH="$BUILD_SOURCEBRANCH"
-	CI_COMMIT="$BUILD_SOURCEVERSION"
-	CI_JOB_ID="$BUILD_BUILDID"
-	CI_JOB_NUMBER="$BUILD_BUILDNUMBER"
 	CC="${CC:-gcc}"
 
-	# use a subdirectory of the cache dir (because the file share is shared
-	# among *all* phases)
-	cache_dir="$HOME/test-cache/$SYSTEM_PHASENAME"
-
 	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
 	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
 	MAKEFLAGS="$MAKEFLAGS --jobs=10"
@@ -120,13 +43,7 @@ then
 elif test true = "$GITHUB_ACTIONS"
 then
 	CI_TYPE=github-actions
-	CI_BRANCH="$GITHUB_REF"
-	CI_COMMIT="$GITHUB_SHA"
-	CI_JOB_ID="$GITHUB_RUN_ID"
 	CC="${CC_PACKAGE:-${CC:-gcc}}"
-	DONT_SKIP_TAGS=t
-
-	cache_dir="$HOME/none"
 
 	export GIT_PROVE_OPTS="--timer --jobs 10"
 	export GIT_TEST_OPTS="--verbose-log -x"
@@ -139,14 +56,6 @@ else
 	exit 1
 fi
 
-good_trees_file="$cache_dir/good-trees"
-
-mkdir -p "$cache_dir"
-
-test -n "${DONT_SKIP_TAGS-}" ||
-skip_branch_tip_with_tag
-skip_good_tree
-
 export DEVELOPER=1
 export DEFAULT_TEST_TARGET=prove
 export GIT_TEST_CLONE_2GB=true
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 0a1ec8c2bae..e5a21985b44 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -45,5 +45,3 @@ esac
 # start running tests.
 make $MAKE_TARGETS
 check_unignored_build_artifacts
-
-save_good_tree
diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
index 65bcebda41a..5a87b1cac96 100755
--- a/ci/run-static-analysis.sh
+++ b/ci/run-static-analysis.sh
@@ -28,5 +28,3 @@ fi
 
 make hdr-check ||
 exit 1
-
-save_good_tree
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index de41888430a..9e0652c30dd 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -41,5 +41,3 @@ grep '<meta name="generator" content="Asciidoctor ' Documentation/git.html
 
 rm -f stdout.log stderr.log stderr.raw
 check_unignored_build_artifacts
-
-save_good_tree
-- 
2.36.1.1045.gf356b5617dd

