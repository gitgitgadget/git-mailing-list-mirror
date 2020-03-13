Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A47C4CECE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 20:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6940A206E9
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 20:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWbEjBjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgCMUDI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 16:03:08 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:32994 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgCMUDI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 16:03:08 -0400
Received: by mail-wm1-f45.google.com with SMTP id r7so8582313wmg.0
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 13:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=a91vqj5ecDLk6LuC8vJZlEpLFygEL6hfKRpptZvwD+A=;
        b=EWbEjBjsFhD1juvdx6FwnV7RT4s1zPc04Bjgc3/Pv+9Qh7PvpcQcjwwjCydKiwEJr8
         CZuunaa/1Sdriu9c5dVBKeBYepTdo/jHHOUU9FwHmQHBKgiS2lKYNl2OvKwZ4Td6lnG7
         KlW3Les9GrhmVHNfke7geF1SmDU/dt5TzYR1Lb2sAMNpPQNY/vt3XMgdxoitYDDD7jRn
         AWeqcY15t3ZeOcAdCFB+Rg+hlL/yWjIBN5E+8ovw+kuPXiwDi66tETW6+TGWYt/rLy5k
         U/1+oZtt8Vm3L2a3GPvk4DkvuEMAoA/sg06OquSDkueZWG0HM9sifTykXggTVm0xux2U
         u3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=a91vqj5ecDLk6LuC8vJZlEpLFygEL6hfKRpptZvwD+A=;
        b=Ap3Ld1OiOc3/QZqa4wmyfQQm8RJGGLTJshm8ySLeNxkn68PpX1u7wRoXZE6/5FxD+U
         6Hz4MeHU+vVxK00OLQCWjLdaa8x6NYAqoNX4m1L6+dw8K8JQOEUF5eCcCBTNT0F3IKzR
         ELiOjKj2M7D+plCEZRi8vGKgcO7zkk+i5+iGSMyLP1G9a+Diddv4lTd1Y9BfiDSGNaMY
         rDYobVNOWOOXyWxCU4PSHhO3sBAdFBYfWequscbFcr4D/8d/QldLwwrmW+JsEIfDCkne
         gAfqo2agMhv9SBcW4GpFRB2eSTXYU1aj/wy+jVtQ4Wj3XBjdlpL7nhUwckFjXgP58iFH
         6V/Q==
X-Gm-Message-State: ANhLgQ1sA66/rU7S+ahuG/mUf5W4DuwinzkLAPCuwXNrALwTNeZjr4KG
        XBRb7cnBS2Zu//H9y7dKMpV8A33W
X-Google-Smtp-Source: ADFU+vvOdXC4+13FTWpthVBYqNwldZDTMyAyDypfGnADuv17vGYyC+KODNNdytrAk88+HNqZpGcApQ==
X-Received: by 2002:a1c:3d6:: with SMTP id 205mr13170809wmd.155.1584129784449;
        Fri, 13 Mar 2020 13:03:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y7sm14247209wmd.1.2020.03.13.13.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 13:03:04 -0700 (PDT)
Message-Id: <pull.725.v2.git.git.1584129783076.gitgitgadget@gmail.com>
In-Reply-To: <pull.725.git.git.1584125875550.gitgitgadget@gmail.com>
References: <pull.725.git.git.1584125875550.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Mar 2020 20:03:02 +0000
Subject: [PATCH v2] t6022, t6046: fix flaky files-are-updated checks
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Several tests wanted to verify that files were actually modified by a
merge, which it would do by checking that the mtime was updated.  In
order to avoid problems with the merge completing so fast that the mtime
at the beginning and end of the operation was the same, these tests
would first set the mtime of a file to something "old".  This "old"
value was usually determined as current system clock minus one second,
truncated to the nearest integer.  Unfortunately, it appears the system
clock and filesystem clock are different and comparing across the two
runs into race problems resulting in flaky tests.

From https://stackoverflow.com/questions/14392975/timestamp-accuracy-on-ext4-sub-millsecond:

    date will call the gettimeofday system call which will always return
    the most accurate time available based on the cached kernel time,
    adjusted by the CPU cycle time if available to give nanosecond
    resolution. The timestamps stored in the file system however, are
    only based on the cached kernel time. ie The time calculated at the
    last timer interrupt.

and from https://apenwarr.ca/log/20181113:

    Does mtime get set to >= the current time?

    No, this depends on clock granularity. For example, gettimeofday()
    can return times in microseconds on my system, but ext4 rounds
    timestamps down to the previous ~10ms (but not exactly 10ms)
    increment, with the surprising result that a newly-created file is
    almost always created in the past:

      $ python -c "
      import os, time
      t0 = time.time()
      open('testfile', 'w').close()
      print os.stat('testfile').st_mtime - t0
      "

      -0.00234484672546

So, instead of trying to compare across what are effectively two
different clocks, just avoid using the system clock.  Any new updates to
files have to give an mtime at least as big as what is already in the
file, so we could define "old" as one second before the mtime found in
the file before the merge starts.  But, to avoid problems with leap
seconds, ntp updates, filesystems that only provide two second
resolution, and other such weirdness, let's just pick an hour before the
mtime found in the file before the merge starts.

Also, clarify in one test where we check the mtime of different files
that it really was intentional.  I totally forgot the reasons for that
and assumed it was a bug when asked.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    t6022, t6046: fix flaky files-are-updated checks
    
    Who knew that the system clock and the filesystem clock were apparently
    different things, causing mtime comparisons to be flaky?
    
    Definitely not me. Fix the flaky tests that SZEDER reported and helped
    track down the cause of.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-725%2Fnewren%2Ftest-cleanup-more-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-725/newren/test-cleanup-more-v2
Pull-Request: https://github.com/git/git/pull/725

Range-diff vs v1:

 1:  dfe1f66112b ! 1:  6f603695093 t6022, t6046: fix flaky files-are-updated checks
     @@ -43,8 +43,11 @@
          So, instead of trying to compare across what are effectively two
          different clocks, just avoid using the system clock.  Any new updates to
          files have to give an mtime at least as big as what is already in the
     -    file, so define "old" as one second before the mtime found in the file
     -    before the merge starts.
     +    file, so we could define "old" as one second before the mtime found in
     +    the file before the merge starts.  But, to avoid problems with leap
     +    seconds, ntp updates, filesystems that only provide two second
     +    resolution, and other such weirdness, let's just pick an hour before the
     +    mtime found in the file before the merge starts.
      
          Also, clarify in one test where we check the mtime of different files
          that it really was intentional.  I totally forgot the reasons for that
     @@ -62,7 +65,7 @@
       
      -	test-tool chmtime =31337 B &&
      -	test-tool chmtime --get B >old-mtime &&
     -+	test-tool chmtime --get -1 B >old-mtime &&
     ++	test-tool chmtime --get -3600 B >old-mtime &&
       	GIT_MERGE_VERBOSITY=3 git merge change >out &&
       
       	test-tool chmtime --get B >new-mtime &&
     @@ -74,7 +77,7 @@
      -	test-tool chmtime --get M >old-mtime &&
      +	# A will be renamed to B; we check mtimes and file presence
      +	test_path_is_missing B &&
     -+	test-tool chmtime --get -1 A >old-mtime &&
     ++	test-tool chmtime --get -3600 A >old-mtime &&
       	GIT_MERGE_VERBOSITY=3 git merge change+rename >out &&
       
      +	test_path_is_missing A &&
     @@ -86,7 +89,7 @@
       test_expect_success 'avoid unnecessary update, normal rename' '
       	git checkout -q avoid-unnecessary-update-1^0 &&
      -	test-tool chmtime --get =1000000000 rename >expect &&
     -+	test-tool chmtime --get -1 rename >expect &&
     ++	test-tool chmtime --get -3600 rename >expect &&
       	git merge merge-branch-1 &&
       	test-tool chmtime --get rename >actual &&
       	test_cmp expect actual # "rename" should have stayed intact
     @@ -95,7 +98,7 @@
       test_expect_success 'avoid unnecessary update, with D/F conflict' '
       	git checkout -q avoid-unnecessary-update-2^0 &&
      -	test-tool chmtime --get =1000000000 df >expect &&
     -+	test-tool chmtime --get -1 df >expect &&
     ++	test-tool chmtime --get -3600 df >expect &&
       	git merge merge-branch-2 &&
       	test-tool chmtime --get df >actual &&
       	test_cmp expect actual # "df" should have stayed intact
     @@ -104,7 +107,7 @@
       test_expect_success 'avoid unnecessary update, dir->(file,nothing)' '
       	git checkout -q master^0 &&
      -	test-tool chmtime --get =1000000000 df >expect &&
     -+	test-tool chmtime --get -1 df >expect &&
     ++	test-tool chmtime --get -3600 df >expect &&
       	git merge side &&
       	test-tool chmtime --get df >actual &&
       	test_cmp expect actual # "df" should have stayed intact
     @@ -113,7 +116,7 @@
       test_expect_success 'avoid unnecessary update, modify/delete' '
       	git checkout -q master^0 &&
      -	test-tool chmtime --get =1000000000 file >expect &&
     -+	test-tool chmtime --get -1 file >expect &&
     ++	test-tool chmtime --get -3600 file >expect &&
       	test_must_fail git merge side &&
       	test-tool chmtime --get file >actual &&
       	test_cmp expect actual # "file" should have stayed intact
     @@ -122,7 +125,7 @@
       test_expect_success 'avoid unnecessary update, rename/add-dest' '
       	git checkout -q master^0 &&
      -	test-tool chmtime --get =1000000000 newfile >expect &&
     -+	test-tool chmtime --get -1 newfile >expect &&
     ++	test-tool chmtime --get -3600 newfile >expect &&
       	git merge side &&
       	test-tool chmtime --get newfile >actual &&
       	test_cmp expect actual # "file" should have stayed intact
     @@ -136,7 +139,7 @@
       
      -		test-tool chmtime =-1 b &&
      -		test-tool chmtime --get b >old-mtime &&
     -+		test-tool chmtime --get -1 b >old-mtime &&
     ++		test-tool chmtime --get -3600 b >old-mtime &&
       
       		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
       
     @@ -146,7 +149,7 @@
       
      -		test-tool chmtime =-1 b &&
      -		test-tool chmtime --get b >old-mtime &&
     -+		test-tool chmtime --get -1 b >old-mtime &&
     ++		test-tool chmtime --get -3600 b >old-mtime &&
       		GIT_MERGE_VERBOSITY=3 git merge -s recursive A^0 >out 2>err &&
       
       		# Make sure b WAS updated
     @@ -156,7 +159,7 @@
       
      -		test-tool chmtime =-1 c &&
      -		test-tool chmtime --get c >old-mtime &&
     -+		test-tool chmtime --get -1 c >old-mtime &&
     ++		test-tool chmtime --get -3600 c >old-mtime &&
       		GIT_MERGE_VERBOSITY=3 git merge -s recursive A^0 >out 2>err &&
       
       		# Make sure c WAS updated
     @@ -166,7 +169,7 @@
       
      -		test-tool chmtime =-1 c &&
      -		test-tool chmtime --get c >old-mtime &&
     -+		test-tool chmtime --get -1 c >old-mtime &&
     ++		test-tool chmtime --get -3600 c >old-mtime &&
       		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
       
       		test_must_be_empty err &&
     @@ -176,7 +179,7 @@
       
      -		test-tool chmtime =-1 c &&
      -		test-tool chmtime --get c >old-mtime &&
     -+		test-tool chmtime --get -1 c >old-mtime &&
     ++		test-tool chmtime --get -3600 c >old-mtime &&
       		GIT_MERGE_VERBOSITY=3 &&
       		export GIT_MERGE_VERBOSITY &&
       		test_must_fail git merge -s recursive B^0 >out 2>err &&
     @@ -186,7 +189,7 @@
       
      -		test-tool chmtime =-1 b &&
      -		test-tool chmtime --get b >old-mtime &&
     -+		test-tool chmtime --get -1 b >old-mtime &&
     ++		test-tool chmtime --get -3600 b >old-mtime &&
       
       		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
       
     @@ -196,7 +199,7 @@
       
      -		test-tool chmtime =-1 c &&
      -		test-tool chmtime --get c >old-mtime &&
     -+		test-tool chmtime --get -1 c >old-mtime &&
     ++		test-tool chmtime --get -3600 c >old-mtime &&
       
       		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
       


 t/t6022-merge-rename.sh                | 19 ++++++++++---------
 t/t6046-merge-skip-unneeded-updates.sh | 21 +++++++--------------
 2 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index d97cf48495b..bbbba3dcbf0 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -243,8 +243,7 @@ test_expect_success 'merge of identical changes in a renamed file' '
 	git reset --hard &&
 	git checkout change+rename &&
 
-	test-tool chmtime =31337 B &&
-	test-tool chmtime --get B >old-mtime &&
+	test-tool chmtime --get -3600 B >old-mtime &&
 	GIT_MERGE_VERBOSITY=3 git merge change >out &&
 
 	test-tool chmtime --get B >new-mtime &&
@@ -253,10 +252,12 @@ test_expect_success 'merge of identical changes in a renamed file' '
 	git reset --hard HEAD^ &&
 	git checkout change &&
 
-	test-tool chmtime =-1 M &&
-	test-tool chmtime --get M >old-mtime &&
+	# A will be renamed to B; we check mtimes and file presence
+	test_path_is_missing B &&
+	test-tool chmtime --get -3600 A >old-mtime &&
 	GIT_MERGE_VERBOSITY=3 git merge change+rename >out &&
 
+	test_path_is_missing A &&
 	test-tool chmtime --get B >new-mtime &&
 	test $(cat old-mtime) -lt $(cat new-mtime)
 '
@@ -645,7 +646,7 @@ test_expect_success 'setup avoid unnecessary update, normal rename' '
 
 test_expect_success 'avoid unnecessary update, normal rename' '
 	git checkout -q avoid-unnecessary-update-1^0 &&
-	test-tool chmtime --get =1000000000 rename >expect &&
+	test-tool chmtime --get -3600 rename >expect &&
 	git merge merge-branch-1 &&
 	test-tool chmtime --get rename >actual &&
 	test_cmp expect actual # "rename" should have stayed intact
@@ -677,7 +678,7 @@ test_expect_success 'setup to test avoiding unnecessary update, with D/F conflic
 
 test_expect_success 'avoid unnecessary update, with D/F conflict' '
 	git checkout -q avoid-unnecessary-update-2^0 &&
-	test-tool chmtime --get =1000000000 df >expect &&
+	test-tool chmtime --get -3600 df >expect &&
 	git merge merge-branch-2 &&
 	test-tool chmtime --get df >actual &&
 	test_cmp expect actual # "df" should have stayed intact
@@ -708,7 +709,7 @@ test_expect_success 'setup avoid unnecessary update, dir->(file,nothing)' '
 
 test_expect_success 'avoid unnecessary update, dir->(file,nothing)' '
 	git checkout -q master^0 &&
-	test-tool chmtime --get =1000000000 df >expect &&
+	test-tool chmtime --get -3600 df >expect &&
 	git merge side &&
 	test-tool chmtime --get df >actual &&
 	test_cmp expect actual # "df" should have stayed intact
@@ -737,7 +738,7 @@ test_expect_success 'setup avoid unnecessary update, modify/delete' '
 
 test_expect_success 'avoid unnecessary update, modify/delete' '
 	git checkout -q master^0 &&
-	test-tool chmtime --get =1000000000 file >expect &&
+	test-tool chmtime --get -3600 file >expect &&
 	test_must_fail git merge side &&
 	test-tool chmtime --get file >actual &&
 	test_cmp expect actual # "file" should have stayed intact
@@ -765,7 +766,7 @@ test_expect_success 'setup avoid unnecessary update, rename/add-dest' '
 
 test_expect_success 'avoid unnecessary update, rename/add-dest' '
 	git checkout -q master^0 &&
-	test-tool chmtime --get =1000000000 newfile >expect &&
+	test-tool chmtime --get -3600 newfile >expect &&
 	git merge side &&
 	test-tool chmtime --get newfile >actual &&
 	test_cmp expect actual # "file" should have stayed intact
diff --git a/t/t6046-merge-skip-unneeded-updates.sh b/t/t6046-merge-skip-unneeded-updates.sh
index 962030ecdb6..1ddc9e6626b 100755
--- a/t/t6046-merge-skip-unneeded-updates.sh
+++ b/t/t6046-merge-skip-unneeded-updates.sh
@@ -71,8 +71,7 @@ test_expect_success '1a-L: Modify(A)/Modify(B), change on B subset of A' '
 
 		git checkout A^0 &&
 
-		test-tool chmtime =-1 b &&
-		test-tool chmtime --get b >old-mtime &&
+		test-tool chmtime --get -3600 b >old-mtime &&
 
 		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
 
@@ -102,8 +101,7 @@ test_expect_success '1a-R: Modify(A)/Modify(B), change on B subset of A' '
 
 		git checkout B^0 &&
 
-		test-tool chmtime =-1 b &&
-		test-tool chmtime --get b >old-mtime &&
+		test-tool chmtime --get -3600 b >old-mtime &&
 		GIT_MERGE_VERBOSITY=3 git merge -s recursive A^0 >out 2>err &&
 
 		# Make sure b WAS updated
@@ -198,8 +196,7 @@ test_expect_success '2a-R: Modify/rename, merge into rename side' '
 
 		git checkout B^0 &&
 
-		test-tool chmtime =-1 c &&
-		test-tool chmtime --get c >old-mtime &&
+		test-tool chmtime --get -3600 c >old-mtime &&
 		GIT_MERGE_VERBOSITY=3 git merge -s recursive A^0 >out 2>err &&
 
 		# Make sure c WAS updated
@@ -266,8 +263,7 @@ test_expect_success '2b-L: Rename+Mod(A)/Mod(B), B mods subset of A' '
 
 		git checkout A^0 &&
 
-		test-tool chmtime =-1 c &&
-		test-tool chmtime --get c >old-mtime &&
+		test-tool chmtime --get -3600 c >old-mtime &&
 		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
 
 		test_must_be_empty err &&
@@ -373,8 +369,7 @@ test_expect_success '2c: Modify b & add c VS rename b->c' '
 
 		git checkout A^0 &&
 
-		test-tool chmtime =-1 c &&
-		test-tool chmtime --get c >old-mtime &&
+		test-tool chmtime --get -3600 c >old-mtime &&
 		GIT_MERGE_VERBOSITY=3 &&
 		export GIT_MERGE_VERBOSITY &&
 		test_must_fail git merge -s recursive B^0 >out 2>err &&
@@ -679,8 +674,7 @@ test_expect_failure '4a: Change on A, change on B subset of A, dirty mods presen
 		git checkout A^0 &&
 		echo "File rewritten" >b &&
 
-		test-tool chmtime =-1 b &&
-		test-tool chmtime --get b >old-mtime &&
+		test-tool chmtime --get -3600 b >old-mtime &&
 
 		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
 
@@ -747,8 +741,7 @@ test_expect_success '4b: Rename+Mod(A)/Mod(B), change on B subset of A, dirty mo
 		git checkout A^0 &&
 		echo "File rewritten" >c &&
 
-		test-tool chmtime =-1 c &&
-		test-tool chmtime --get c >old-mtime &&
+		test-tool chmtime --get -3600 c >old-mtime &&
 
 		GIT_MERGE_VERBOSITY=3 git merge -s recursive B^0 >out 2>err &&
 

base-commit: 30e9940356dc67959877f4b2417da33ebdefbb79
-- 
gitgitgadget
