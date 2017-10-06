Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24EB020131
	for <e@80x24.org>; Fri,  6 Oct 2017 19:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbdJFTAO (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 15:00:14 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:53316 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751484AbdJFTAM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 15:00:12 -0400
Received: by mail-pf0-f172.google.com with SMTP id n73so3296670pfg.10
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 12:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nUcgh9klkNCkw7zceFVEvu5UbPbKmcBQDQOfX5nym6M=;
        b=mPFs6ZhSPvAzauWvSPawbWnGfERHNQqYRxUrhKyfMvSBbK4xsJ5rqHrrjEe0ttyMEl
         MNmCOOyCRf3QUCRCCEBej+CFOcTAUZIFvoA8aG817RsFsB0sIVEjaO2VrapkarSGoZnc
         HKfB+ITK3KPz+d8Tir7F3gY1zwqf8RhK96L5WKmMUxZWEjhnxaxIdqGxBxWipzvEMb0D
         eZHt+s72pskFO6NRszaAfBXKsfSkoqs/QpAAxeSm1vb415BisxT6rPbVuKc5WjkEvxNl
         oQNkXjkOEDatNxNn+d4LR6GuQJqfHbalCmMNv37+B64om4nXqQ8L4uITqEsEqKOe/ovd
         ytDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nUcgh9klkNCkw7zceFVEvu5UbPbKmcBQDQOfX5nym6M=;
        b=JKkLE+ZvIhsor3Zg0/AOlJLaoAHCRNJeQ7jlOq6xvx8LsGqOxPZRDPG+lE6fl0yXnS
         YeDmhTV9rlZQ5s0qEPvf/AUALV1ZZAzSoYARMXdTFWjnIrtIiG8MXBthvbcN19bFtz66
         06dBgAu2Cure7uYC6MP+Y2FVcLx7Qfv5571UlgAn1X+7Uu/Y9OZff/ozK9xQqIG0nt8m
         1zhbfNiX7HN1BiH7J3oMCKit1ziBRG7WsBF+X4k78klwgaxyv0EutJC0aC7XVux5CK7j
         cgmmGs7R7Fs4ca2BiyrhMAvVEvBDEbyXuV6IrrErf/lbvlaNONsYkLmEnFPBGEVsqFv9
         16sw==
X-Gm-Message-State: AMCzsaUUOs5W0kmqX42j1OwhRF1vUvPYFS1soE70oErBS8wwryTDY4ls
        GVYk94tINQoSJ7IzkudZmZTSChdis3U=
X-Google-Smtp-Source: AOwi7QD4Db64YO7hHl0MgzGmxcjIN6A4IKOUkOyy1t96sPEnQZ+6RQgIEmFahpgmm6xvUN4/kccnxw==
X-Received: by 10.101.93.145 with SMTP id f17mr2787709pgt.50.1507316411719;
        Fri, 06 Oct 2017 12:00:11 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:fd93:ec9c:aa89:eb86])
        by smtp.gmail.com with ESMTPSA id u6sm1729537pfg.175.2017.10.06.12.00.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 12:00:11 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] tests: fix diff order arguments in test_cmp
Date:   Fri,  6 Oct 2017 12:00:06 -0700
Message-Id: <20171006190006.19623-2-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <20171006190006.19623-1-sbeller@google.com>
References: <20171006190006.19623-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the argument order for test_cmp. When given the expected
result first the diff shows the actual output with '+' and the
expectation with '-', which is the convention for our tests.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t1004-read-tree-m-u-wf.sh          |  2 +-
 t/t4015-diff-whitespace.sh           |  4 ++--
 t/t4205-log-pretty-formats.sh        |  2 +-
 t/t6007-rev-list-cherry-pick-file.sh | 32 ++++++++++++++++----------------
 t/t6013-rev-list-reverse-parents.sh  |  4 ++--
 t/t7001-mv.sh                        |  2 +-
 t/t7005-editor.sh                    |  6 +++---
 t/t7102-reset.sh                     |  4 ++--
 t/t7201-co.sh                        |  4 ++--
 t/t7400-submodule-basic.sh           |  2 +-
 t/t7405-submodule-merge.sh           |  2 +-
 t/t7506-status-submodule.sh          |  4 ++--
 t/t7600-merge.sh                     |  6 +++---
 t/t7610-mergetool.sh                 |  4 ++--
 t/t9001-send-email.sh                |  6 +++---
 15 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index c70cf42300..c7ce5d8bb5 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -218,7 +218,7 @@ test_expect_success 'D/F' '
 		echo "100644 $a 2	subdir/file2"
 		echo "100644 $b 3	subdir/file2/another"
 	) >expect &&
-	test_cmp actual expect
+	test_cmp expect actual
 
 '
 
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 12d182dc1b..1709e4578b 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -155,7 +155,7 @@ test_expect_success 'ignore-blank-lines: only new lines' '
 " >x &&
 	git diff --ignore-blank-lines >out &&
 	>expect &&
-	test_cmp out expect
+	test_cmp expect out
 '
 
 test_expect_success 'ignore-blank-lines: only new lines with space' '
@@ -165,7 +165,7 @@ test_expect_success 'ignore-blank-lines: only new lines with space' '
  " >x &&
 	git diff -w --ignore-blank-lines >out &&
 	>expect &&
-	test_cmp out expect
+	test_cmp expect out
 '
 
 test_expect_success 'ignore-blank-lines: after change' '
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index ec5f530102..42f584f8b3 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -590,7 +590,7 @@ test_expect_success '%(trailers:unfold) unfolds trailers' '
 test_expect_success ':only and :unfold work together' '
 	git log --no-walk --pretty="%(trailers:only:unfold)" >actual &&
 	git log --no-walk --pretty="%(trailers:unfold:only)" >reverse &&
-	test_cmp actual reverse &&
+	test_cmp reverse actual &&
 	{
 		grep -v patch.description <trailers | unfold &&
 		echo
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index 2959745196..f0268372d2 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -57,7 +57,7 @@ test_expect_success '--left-right' '
 	git rev-list --left-right B...C > actual &&
 	git name-rev --stdin --name-only --refs="*tags/*" \
 		< actual > actual.named &&
-	test_cmp actual.named expect
+	test_cmp expect actual.named
 '
 
 test_expect_success '--count' '
@@ -77,14 +77,14 @@ test_expect_success '--cherry-pick bar does not come up empty' '
 	git rev-list --left-right --cherry-pick B...C -- bar > actual &&
 	git name-rev --stdin --name-only --refs="*tags/*" \
 		< actual > actual.named &&
-	test_cmp actual.named expect
+	test_cmp expect actual.named
 '
 
 test_expect_success 'bar does not come up empty' '
 	git rev-list --left-right B...C -- bar > actual &&
 	git name-rev --stdin --name-only --refs="*tags/*" \
 		< actual > actual.named &&
-	test_cmp actual.named expect
+	test_cmp expect actual.named
 '
 
 cat >expect <<EOF
@@ -96,14 +96,14 @@ test_expect_success '--cherry-pick bar does not come up empty (II)' '
 	git rev-list --left-right --cherry-pick F...E -- bar > actual &&
 	git name-rev --stdin --name-only --refs="*tags/*" \
 		< actual > actual.named &&
-	test_cmp actual.named expect
+	test_cmp expect actual.named
 '
 
 test_expect_success 'name-rev multiple --refs combine inclusive' '
 	git rev-list --left-right --cherry-pick F...E -- bar >actual &&
 	git name-rev --stdin --name-only --refs="*tags/F" --refs="*tags/E" \
 		<actual >actual.named &&
-	test_cmp actual.named expect
+	test_cmp expect actual.named
 '
 
 cat >expect <<EOF
@@ -115,7 +115,7 @@ test_expect_success 'name-rev --refs excludes non-matched patterns' '
 	git rev-list --left-right --cherry-pick F...E -- bar >actual &&
 	git name-rev --stdin --name-only --refs="*tags/F" \
 		<actual >actual.named &&
-	test_cmp actual.named expect
+	test_cmp expect actual.named
 '
 
 cat >expect <<EOF
@@ -127,14 +127,14 @@ test_expect_success 'name-rev --exclude excludes matched patterns' '
 	git rev-list --left-right --cherry-pick F...E -- bar >actual &&
 	git name-rev --stdin --name-only --refs="*tags/*" --exclude="*E" \
 		<actual >actual.named &&
-	test_cmp actual.named expect
+	test_cmp expect actual.named
 '
 
 test_expect_success 'name-rev --no-refs clears the refs list' '
 	git rev-list --left-right --cherry-pick F...E -- bar >expect &&
 	git name-rev --stdin --name-only --refs="*tags/F" --refs="*tags/E" --no-refs --refs="*tags/G" \
 		<expect >actual &&
-	test_cmp actual expect
+	test_cmp expect actual
 '
 
 cat >expect <<EOF
@@ -148,7 +148,7 @@ test_expect_success '--cherry-mark' '
 	git rev-list --cherry-mark F...E -- bar > actual &&
 	git name-rev --stdin --name-only --refs="*tags/*" \
 		< actual > actual.named &&
-	test_cmp actual.named expect
+	test_cmp expect actual.named
 '
 
 cat >expect <<EOF
@@ -162,7 +162,7 @@ test_expect_success '--cherry-mark --left-right' '
 	git rev-list --cherry-mark --left-right F...E -- bar > actual &&
 	git name-rev --stdin --name-only --refs="*tags/*" \
 		< actual > actual.named &&
-	test_cmp actual.named expect
+	test_cmp expect actual.named
 '
 
 cat >expect <<EOF
@@ -173,14 +173,14 @@ test_expect_success '--cherry-pick --right-only' '
 	git rev-list --cherry-pick --right-only F...E -- bar > actual &&
 	git name-rev --stdin --name-only --refs="*tags/*" \
 		< actual > actual.named &&
-	test_cmp actual.named expect
+	test_cmp expect actual.named
 '
 
 test_expect_success '--cherry-pick --left-only' '
 	git rev-list --cherry-pick --left-only E...F -- bar > actual &&
 	git name-rev --stdin --name-only --refs="*tags/*" \
 		< actual > actual.named &&
-	test_cmp actual.named expect
+	test_cmp expect actual.named
 '
 
 cat >expect <<EOF
@@ -192,7 +192,7 @@ test_expect_success '--cherry' '
 	git rev-list --cherry F...E -- bar > actual &&
 	git name-rev --stdin --name-only --refs="*tags/*" \
 		< actual > actual.named &&
-	test_cmp actual.named expect
+	test_cmp expect actual.named
 '
 
 cat >expect <<EOF
@@ -201,7 +201,7 @@ EOF
 
 test_expect_success '--cherry --count' '
 	git rev-list --cherry --count F...E -- bar > actual &&
-	test_cmp actual expect
+	test_cmp expect actual
 '
 
 cat >expect <<EOF
@@ -210,7 +210,7 @@ EOF
 
 test_expect_success '--cherry-mark --count' '
 	git rev-list --cherry-mark --count F...E -- bar > actual &&
-	test_cmp actual expect
+	test_cmp expect actual
 '
 
 cat >expect <<EOF
@@ -219,7 +219,7 @@ EOF
 
 test_expect_success '--cherry-mark --left-right --count' '
 	git rev-list --cherry-mark --left-right --count F...E -- bar > actual &&
-	test_cmp actual expect
+	test_cmp expect actual
 '
 
 test_expect_success '--cherry-pick with independent, but identical branches' '
diff --git a/t/t6013-rev-list-reverse-parents.sh b/t/t6013-rev-list-reverse-parents.sh
index 59fc2f06e0..89458d370f 100755
--- a/t/t6013-rev-list-reverse-parents.sh
+++ b/t/t6013-rev-list-reverse-parents.sh
@@ -28,7 +28,7 @@ test_expect_success '--reverse --parents --full-history combines correctly' '
 		perl -e "print reverse <>" > expected &&
 	git rev-list --reverse --parents --full-history master -- foo \
 		> actual &&
-	test_cmp actual expected
+	test_cmp expected actual
 	'
 
 test_expect_success '--boundary does too' '
@@ -36,7 +36,7 @@ test_expect_success '--boundary does too' '
 		perl -e "print reverse <>" > expected &&
 	git rev-list --boundary --reverse --parents --full-history \
 		master ^root -- foo > actual &&
-	test_cmp actual expected
+	test_cmp expected actual
 	'
 
 test_done
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index cbc5fb37fe..f5929c46f3 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -488,7 +488,7 @@ test_expect_success 'moving a submodule in nested directories' '
 		git config -f ../.gitmodules submodule.deep/directory/hierarchy/sub.path >../actual &&
 		echo "directory/hierarchy/sub" >../expect
 	) &&
-	test_cmp actual expect
+	test_cmp expect actual
 '
 
 test_expect_failure 'moving nested submodules' '
diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 1b530b5022..29e5043b94 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -38,7 +38,7 @@ test_expect_success setup '
 	test_commit "$msg" &&
 	echo "$msg" >expect &&
 	git show -s --format=%s > actual &&
-	test_cmp actual expect
+	test_cmp expect actual
 
 '
 
@@ -85,7 +85,7 @@ do
 		git --exec-path=. commit --amend &&
 		git show -s --pretty=oneline |
 		sed -e "s/^[0-9a-f]* //" >actual &&
-		test_cmp actual expect
+		test_cmp expect actual
 	'
 done
 
@@ -107,7 +107,7 @@ do
 		git --exec-path=. commit --amend &&
 		git show -s --pretty=oneline |
 		sed -e "s/^[0-9a-f]* //" >actual &&
-		test_cmp actual expect
+		test_cmp expect actual
 	'
 done
 
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 86f23be34a..95653a08ca 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -428,9 +428,9 @@ test_expect_success 'test --mixed <paths>' '
 	git reset HEAD -- file1 file2 file3 &&
 	test_must_fail git diff --quiet &&
 	git diff > output &&
-	test_cmp output expect &&
+	test_cmp expect output &&
 	git diff --cached > output &&
-	test_cmp output cached_expect
+	test_cmp cached_expect output
 '
 
 test_expect_success 'test resetting the index at give paths' '
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index d4b217b0ee..76c223c967 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -187,7 +187,7 @@ test_expect_success 'format of merge conflict from checkout -m' '
 	d
 	>>>>>>> local
 	EOF
-	test_cmp two expect
+	test_cmp expect two
 '
 
 test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
@@ -213,7 +213,7 @@ test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
 	d
 	>>>>>>> local
 	EOF
-	test_cmp two expect
+	test_cmp expect two
 '
 
 test_expect_success 'switch to another branch while carrying a deletion' '
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 6f8337ffb5..a39e69a3eb 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1211,7 +1211,7 @@ test_expect_success 'clone --recurse-submodules with a pathspec works' '
 
 	git clone --recurse-submodules="sub0" multisuper multisuper_clone &&
 	git -C multisuper_clone submodule status |cut -c1,43- >actual &&
-	test_cmp actual expected
+	test_cmp expected actual
 '
 
 test_expect_success 'clone with multiple --recurse-submodules options' '
diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index 0d5b42a25b..7bfb2f498d 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -119,7 +119,7 @@ test_expect_success 'merge with one side as a fast-forward of the other' '
 	 git ls-tree test-forward sub | cut -f1 | cut -f3 -d" " > actual &&
 	 (cd sub &&
 	  git rev-parse sub-d > ../expect) &&
-	 test_cmp actual expect)
+	 test_cmp expect actual)
 '
 
 test_expect_success 'merging should conflict for non fast-forward' '
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 055c90736e..9edf6572ed 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -306,7 +306,7 @@ test_expect_success 'diff with merge conflict in .gitmodules' '
 		cd super &&
 		git diff >../diff_actual 2>&1
 	) &&
-	test_cmp diff_actual diff_expect
+	test_cmp diff_expect diff_actual
 '
 
 test_expect_success 'diff --submodule with merge conflict in .gitmodules' '
@@ -314,7 +314,7 @@ test_expect_success 'diff --submodule with merge conflict in .gitmodules' '
 		cd super &&
 		git diff --submodule >../diff_submodule_actual 2>&1
 	) &&
-	test_cmp diff_submodule_actual diff_submodule_expect
+	test_cmp diff_submodule_expect diff_submodule_actual
 '
 
 # We'll setup different cases for further testing:
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 80194b79f9..dfde6a675a 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -697,7 +697,7 @@ test_expect_success 'merge --no-ff --edit' '
 	git cat-file commit HEAD >raw &&
 	grep "work done on the side branch" raw &&
 	sed "1,/^$/d" >actual raw &&
-	test_cmp actual expected
+	test_cmp expected actual
 '
 
 test_expect_success GPG 'merge --ff-only tag' '
@@ -709,7 +709,7 @@ test_expect_success GPG 'merge --ff-only tag' '
 	git merge --ff-only signed &&
 	git rev-parse signed^0 >expect &&
 	git rev-parse HEAD >actual &&
-	test_cmp actual expect
+	test_cmp expect actual
 '
 
 test_expect_success GPG 'merge --no-edit tag should skip editor' '
@@ -721,7 +721,7 @@ test_expect_success GPG 'merge --no-edit tag should skip editor' '
 	EDITOR=false git merge --no-edit signed &&
 	git rev-parse signed^0 >expect &&
 	git rev-parse HEAD^2 >actual &&
-	test_cmp actual expect
+	test_cmp expect actual
 '
 
 test_expect_success 'set up mod-256 conflict scenario' '
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 381b7df452..1a430b9c40 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -621,7 +621,7 @@ test_expect_success 'file with no base' '
 	test_must_fail git merge master &&
 	git mergetool --no-prompt --tool mybase -- both &&
 	>expected &&
-	test_cmp both expected
+	test_cmp expected both
 '
 
 test_expect_success 'custom commands override built-ins' '
@@ -632,7 +632,7 @@ test_expect_success 'custom commands override built-ins' '
 	test_must_fail git merge master &&
 	git mergetool --no-prompt --tool defaults -- both &&
 	echo master both added >expected &&
-	test_cmp both expected
+	test_cmp expected both
 '
 
 test_expect_success 'filenames seen by tools start with ./' '
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index f30980895c..4d261c2a9c 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1266,7 +1266,7 @@ test_expect_success $PREREQ 'asks about and fixes 8bit encodings' '
 	grep email-using-8bit stdout &&
 	grep "Which 8bit encoding" stdout &&
 	egrep "Content|MIME" msgtxt1 >actual &&
-	test_cmp actual content-type-decl
+	test_cmp content-type-decl actual
 '
 
 test_expect_success $PREREQ 'sendemail.8bitEncoding works' '
@@ -1277,7 +1277,7 @@ test_expect_success $PREREQ 'sendemail.8bitEncoding works' '
 			--smtp-server="$(pwd)/fake.sendmail" \
 			email-using-8bit >stdout &&
 	egrep "Content|MIME" msgtxt1 >actual &&
-	test_cmp actual content-type-decl
+	test_cmp content-type-decl actual
 '
 
 test_expect_success $PREREQ '--8bit-encoding overrides sendemail.8bitEncoding' '
@@ -1289,7 +1289,7 @@ test_expect_success $PREREQ '--8bit-encoding overrides sendemail.8bitEncoding' '
 			--8bit-encoding=UTF-8 \
 			email-using-8bit >stdout &&
 	egrep "Content|MIME" msgtxt1 >actual &&
-	test_cmp actual content-type-decl
+	test_cmp content-type-decl actual
 '
 
 test_expect_success $PREREQ 'setup expect' '
-- 
2.14.0.rc0.3.g6c2e499285

