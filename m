Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CB5C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378323AbiBUOre (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:47:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378298AbiBUOrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:47:16 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DBD1122
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:46:52 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m27so15711633wrb.4
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kGnWKoJdyrnKKTEOcUKcWHEHzPOLi+v3luyaskEh4T0=;
        b=LBHNWUEN1SMY6QOQUkcrmYoOj3/wihCV/EbUllY08JfSHGrcvL/VqRpmh8NGAqj/F9
         mMEJtFyMSqXNuOJLQwr/w6Y8Z7+egUne2MinKajW1QgofUSu30efbr+4aciJtqcQWe9a
         A0j+G3+06pfoj3fqKnoiiihV5yL1UbpBEO9DV4QHMQG/fqn65yG2ZFxMqFe6U3bTa+Ek
         +Fhjs4WPHinpKJdp//naUfY8a915x0ADND12ZiwymtDF4ZKjxUpEA7u+cryHijSjoX7L
         tcndonrYxgUSOA8pmR8giZiDg4stSNqxZlmLNC2GOEZ66OGAKMYH9yX5lG7/kguvjJvt
         1Ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kGnWKoJdyrnKKTEOcUKcWHEHzPOLi+v3luyaskEh4T0=;
        b=i8cseG1LxRBhVsYxaLJQzP6ISCA7ugHtZ0jvD/ypmbZceseQh6NThZdKXgeIjLB8dR
         +cDv2Ih8H4CtQ97eP4IWYegLCf1ybl6z0fnfFxV11ZM7T84jdXd7RNABuMmzqKfv70+w
         qShUc/WjCjqa0L+bfKzzAfb0gES2GDotnj7i6WA8XukJ4b3XCNZCYD4lHvbBTo+dggH7
         hOiSw7AmmXmuUPeOamc7hihhXnGTW5UeuNsiJpIzFLhVCPYGWArGQdcTJWZCX0hzOZW+
         XvnUkekubxqm9KqRnXk+u3Iv3GtcN1J/ebPk1mGCOUb4vpXc9k5bj5/kiwIYkKL8Rjh7
         4gxw==
X-Gm-Message-State: AOAM531O5K6sC+t508Wqpc1hm5vt7kd6S88HEZgpiemlZ8IxR8xQ8EO6
        CKolT6mwk4Oacc9jYOjN1fR/bhoyUJVE9w==
X-Google-Smtp-Source: ABdhPJysji3K/k7oG+8lAZaTqZEio/2yYmM7k9/Lmtt1ruLAtITUUYE0pYZVukQasqAcyr5B1ZW6Xg==
X-Received: by 2002:a5d:5045:0:b0:1e3:3d02:84b3 with SMTP id h5-20020a5d5045000000b001e33d0284b3mr15509359wrt.384.1645454811080;
        Mon, 21 Feb 2022 06:46:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r14sm25071094wrz.84.2022.02.21.06.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:46:50 -0800 (PST)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/25] CI: remove dead "tree skipping" code
Date:   Mon, 21 Feb 2022 15:46:16 +0100
Message-Id: <patch-04.25-c81c1b3f504-20220221T143936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
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
index c3c06d66862..5a8938d4b3c 100755
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
 	CC="${CC:-gcc}"
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
2.35.1.1132.ga1fe46f8690

