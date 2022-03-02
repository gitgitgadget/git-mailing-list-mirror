Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A74C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 13:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242170AbiCBNXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 08:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242143AbiCBNXb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 08:23:31 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40484263D
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 05:22:42 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u1so2748280wrg.11
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 05:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=746Pcik37Ub57qp6a7Ps4MWcDnSlayC+wgcuwCVGfVM=;
        b=aNU+dg13/t96p7q3FhRLZl1KCLRgPYbz6lCTYbbK0+4ER7BjpR9QjIZvxf54ZoPjF2
         F+MjVCsYS4JQ1GNkFoyJKlRVgXpzjfSYiX/U+tDnJm5a39bPalG46bNZpUelwOxKjoqa
         8tcts3irZJPWTUyHn5CdEouXGW7RY58lpAV6ZjhPAuc9Mnx8KBTHQIPr95rCXgZcFAV4
         RdVoqoY4Ggi19+eGT09f1osnLCvhRRb9M8fz3ok4yIRs2BP9x+WS2z4lUi/uvxwzkC+g
         EnxJ/Xt/MEmT4CsA0cf0QfiQ7mvVXbqKGbWrE+rElG+RRERiN2d3JEyytzpIGAHIQtdE
         ff8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=746Pcik37Ub57qp6a7Ps4MWcDnSlayC+wgcuwCVGfVM=;
        b=h1h4Ken/inWtqH/qqsDACPyHfKxr5Va6Y9SO/VCEf29v/W9/u6uBi56bf1HySQVYnx
         mc61NJdu+xUCQaEQYkyxKWcc80nOzCU1ooRvKQUHfhC+PyTSZLVVg80NCTqh0qpqWuyH
         Bd/PfXFLcrVjL6nUXaqvmY41rPbTiVILRNThhgsHiturxtgkvIvOW4/1QMBHgEUXnvS5
         /o1nRK8xDfecPp0CsPERj5lxEn25EKlt3ZQjDxLV3SB0SrjtJHBFMBrJ6dl1jqUMYPKw
         ezlTOhO1ou2JfkWNuacs70tnjlSmJBmDRqlRroL9pIksrDwwtn5ttVisw7YvdFf+bSSM
         C6rA==
X-Gm-Message-State: AOAM532E0BJoiHpR+fr0CCiOToOfNSAv2BF1LuG54ZuwrhcejpGfeInm
        ET1ydnsOmjq2Cb7CFXVIpY8aHRc0A/tETQ==
X-Google-Smtp-Source: ABdhPJwX3WjrJ8FcW0k7xAU2gQg4JEIZn86SvrQk8jWkEg1ZQmY3voVoPfdx8I5XSe6aDRciAvHtIw==
X-Received: by 2002:adf:90ca:0:b0:1ea:99dd:db45 with SMTP id i68-20020adf90ca000000b001ea99dddb45mr23028931wri.262.1646227360536;
        Wed, 02 Mar 2022 05:22:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d648d000000b001efd62a840dsm10814197wri.111.2022.03.02.05.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 05:22:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/10] fetch+push tests: have tests clean up their own mess
Date:   Wed,  2 Mar 2022 14:22:26 +0100
Message-Id: <patch-07.10-7ce22dbe738-20220302T131859Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "t5516-fetch-push.sh" test code to make use of
"test_when_finished" to remove data instead of having tests clean up
leftover data from earlier tests, which may or may not be
there (e.g. depending on the --run=* option).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5516-fetch-push.sh | 50 +++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index e4bb7581568..fbe0a72b0b2 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -23,7 +23,8 @@ D=$(pwd)
 
 mk_empty () {
 	repo_name="$1"
-	rm -fr "$repo_name" &&
+	test_when_finished "rm -rf \"$repo_name\"" &&
+	test_path_is_missing "$repo_name" &&
 	git init "$repo_name" &&
 	git -C "$repo_name" config receive.denyCurrentBranch warn
 }
@@ -86,7 +87,7 @@ mk_test_with_hooks() {
 }
 
 mk_child() {
-	rm -rf "$2" &&
+	test_when_finished "rm -rf \"$2\"" &&
 	git clone "$1" "$2"
 }
 
@@ -191,32 +192,32 @@ grep_wrote () {
 	grep 'write_pack_file/wrote.*"value":"'$1'"' $2
 }
 
-test_expect_success 'push with negotiation' '
-	# Without negotiation
+test_expect_success 'push without negotiation' '
 	mk_empty testrepo &&
 	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
 	test_commit -C testrepo unrelated_commit &&
 	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
-	echo now pushing without negotiation &&
+	test_when_finished "rm event" &&
 	GIT_TRACE2_EVENT="$(pwd)/event" git -c protocol.version=2 push testrepo refs/heads/main:refs/remotes/origin/main &&
-	grep_wrote 5 event && # 2 commits, 2 trees, 1 blob
+	grep_wrote 5 event # 2 commits, 2 trees, 1 blob
+'
 
-	# Same commands, but with negotiation
-	rm event &&
+test_expect_success 'push with negotiation' '
 	mk_empty testrepo &&
 	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
 	test_commit -C testrepo unrelated_commit &&
 	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
+	test_when_finished "rm event" &&
 	GIT_TRACE2_EVENT="$(pwd)/event" git -c protocol.version=2 -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main &&
 	grep_wrote 2 event # 1 commit, 1 tree
 '
 
 test_expect_success 'push with negotiation proceeds anyway even if negotiation fails' '
-	rm event &&
 	mk_empty testrepo &&
 	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
 	test_commit -C testrepo unrelated_commit &&
 	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
+	test_when_finished "rm event" &&
 	GIT_TEST_PROTOCOL_VERSION=0 GIT_TRACE2_EVENT="$(pwd)/event" \
 		git -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main 2>err &&
 	grep_wrote 5 event && # 2 commits, 2 trees, 1 blob
@@ -1323,7 +1324,7 @@ done
 
 test_expect_success 'fetch follows tags by default' '
 	mk_test testrepo heads/main &&
-	rm -fr src dst &&
+	test_when_finished "rm -rf src" &&
 	git init src &&
 	(
 		cd src &&
@@ -1333,6 +1334,7 @@ test_expect_success 'fetch follows tags by default' '
 		sed -n "p; s|refs/heads/main$|refs/remotes/origin/main|p" tmp1 |
 		sort -k 3 >../expect
 	) &&
+	test_when_finished "rm -rf dst" &&
 	git init dst &&
 	(
 		cd dst &&
@@ -1358,8 +1360,9 @@ test_expect_success 'peeled advertisements are not considered ref tips' '
 
 test_expect_success 'pushing a specific ref applies remote.$name.push as refmap' '
 	mk_test testrepo heads/main &&
-	rm -fr src dst &&
+	test_when_finished "rm -rf src" &&
 	git init src &&
+	test_when_finished "rm -rf dst" &&
 	git init --bare dst &&
 	(
 		cd src &&
@@ -1382,8 +1385,9 @@ test_expect_success 'pushing a specific ref applies remote.$name.push as refmap'
 
 test_expect_success 'with no remote.$name.push, it is not used as refmap' '
 	mk_test testrepo heads/main &&
-	rm -fr src dst &&
+	test_when_finished "rm -rf src" &&
 	git init src &&
+	test_when_finished "rm -rf dst" &&
 	git init --bare dst &&
 	(
 		cd src &&
@@ -1404,8 +1408,9 @@ test_expect_success 'with no remote.$name.push, it is not used as refmap' '
 
 test_expect_success 'with no remote.$name.push, upstream mapping is used' '
 	mk_test testrepo heads/main &&
-	rm -fr src dst &&
+	test_when_finished "rm -rf src" &&
 	git init src &&
+	test_when_finished "rm -rf dst" &&
 	git init --bare dst &&
 	(
 		cd src &&
@@ -1433,8 +1438,9 @@ test_expect_success 'with no remote.$name.push, upstream mapping is used' '
 
 test_expect_success 'push does not follow tags by default' '
 	mk_test testrepo heads/main &&
-	rm -fr src dst &&
+	test_when_finished "rm -rf src" &&
 	git init src &&
+	test_when_finished "rm -rf dst" &&
 	git init --bare dst &&
 	(
 		cd src &&
@@ -1456,8 +1462,9 @@ test_expect_success 'push does not follow tags by default' '
 
 test_expect_success 'push --follow-tags only pushes relevant tags' '
 	mk_test testrepo heads/main &&
-	rm -fr src dst &&
+	test_when_finished "rm -rf src" &&
 	git init src &&
+	test_when_finished "rm -rf dst" &&
 	git init --bare dst &&
 	(
 		cd src &&
@@ -1495,9 +1502,9 @@ EOF
 '
 
 test_expect_success 'pushing a tag pushes the tagged object' '
-	rm -rf dst.git &&
 	blob=$(echo unreferenced | git hash-object -w --stdin) &&
 	git tag -m foo tag-of-blob $blob &&
+	test_when_finished "rm -rf dst.git" &&
 	git init --bare dst.git &&
 	git push dst.git tag-of-blob &&
 	# the receiving index-pack should have noticed
@@ -1508,7 +1515,7 @@ test_expect_success 'pushing a tag pushes the tagged object' '
 '
 
 test_expect_success 'push into bare respects core.logallrefupdates' '
-	rm -rf dst.git &&
+	test_when_finished "rm -rf dst.git" &&
 	git init --bare dst.git &&
 	git -C dst.git config core.logallrefupdates true &&
 
@@ -1526,7 +1533,7 @@ test_expect_success 'push into bare respects core.logallrefupdates' '
 '
 
 test_expect_success 'fetch into bare respects core.logallrefupdates' '
-	rm -rf dst.git &&
+	test_when_finished "rm -rf dst.git" &&
 	git init --bare dst.git &&
 	(
 		cd dst.git &&
@@ -1547,6 +1554,7 @@ test_expect_success 'fetch into bare respects core.logallrefupdates' '
 '
 
 test_expect_success 'receive.denyCurrentBranch = updateInstead' '
+	mk_empty testrepo &&
 	git push testrepo main &&
 	(
 		cd testrepo &&
@@ -1649,7 +1657,7 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 	) &&
 
 	# (5) push into void
-	rm -fr void &&
+	test_when_finished "rm -rf void" &&
 	git init void &&
 	(
 		cd void &&
@@ -1671,7 +1679,7 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 '
 
 test_expect_success 'updateInstead with push-to-checkout hook' '
-	rm -fr testrepo &&
+	test_when_finished "rm -rf testrepo" &&
 	git init testrepo &&
 	git -C testrepo pull .. main &&
 	git -C testrepo reset --hard HEAD^^ &&
@@ -1730,7 +1738,7 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 	) &&
 
 	# push into void
-	rm -fr void &&
+	test_when_finished "rm -rf void" &&
 	git init void &&
 	git -C void config receive.denyCurrentBranch updateInstead &&
 	write_script void/.git/hooks/push-to-checkout <<-\EOF &&
-- 
2.35.1.1228.g56895c6ee86

