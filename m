Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF57395275
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282220; cv=none; b=mDMj8d4MU6aXpTzJJgiZQGa/tsSWHB4fnB0DJlZZCFFEUU5IN5jikzJW5HF+Kj8rhA3GIBSNV4v695JqWYWjBUCv/LAyPZRBFcZD1hFxKpiwOUaN8AiESCDuwVWu5ynaTNIxTuzbAmTYhsa8G/WFpk1eIjtmbas9ENcUrtvRBrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282220; c=relaxed/simple;
	bh=Cy925sk3G7+4myHfful13IjoeXPYZqtiCzd4/ajvgPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YWBuOtlbGipLA8xFSdA4U6bN4hqfnaDe18IbB5oo0b2oVBdo8mH9njo22q4clJk0GzgZS4CsDx7y1RrAJesWQPyxcQFTmS8Lvck34atlencDHFA/mHGQmWHYPDQiWmoD96zxEiZaQJRTPZJAju0+Ed7EhhdT0/BqCoqKIOOaxkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=fEHa9hkw; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="fEHa9hkw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774282216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dfR0/dt+A5+I1CUbjKz/hbjT+5oXfn84n5wLSDl+8Z0=;
	b=fEHa9hkw+ti08ROz15BaA7/KzahTbHRoQOsA5nDN3g4T3NfOzafsewdMFT3/EAuF4au5bD
	uCKVdAmzpfqMddQ7GmukFGCZsRMgRIee7yEf5x6RQeHLAmAngAgfJrFbvjhwXI4Cv8vLDq
	bQOTIIuHdzVZvVG2xg9YYsmJC/d9KF0=
From: Toon Claes <toon@iotcl.com>
Date: Mon, 23 Mar 2026 17:09:50 +0100
Subject: [PATCH 1/3] t3650: use option with value consistenly with equal
 sign
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-toon-replay-arbitrary-ref-v1-1-5c7172f675ec@iotcl.com>
References: <20260323-toon-replay-arbitrary-ref-v1-0-5c7172f675ec@iotcl.com>
In-Reply-To: <20260323-toon-replay-arbitrary-ref-v1-0-5c7172f675ec@iotcl.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Siddharth Asthana <siddharthasthana31@gmail.com>, 
 Yee Cheng Chin <yeecheng.chin@gmail.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

The tests in t3650-replay-basics have mixed use of option arguments
with value with and without equal sign. Bring in consistency and use
equal sign for all options that expect a value. This makes it easier to
distinguish them from positional arguments.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 t/t3650-replay-basics.sh | 70 ++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 0c1e03e0fb..47811b3197 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -95,8 +95,8 @@ test_expect_success '--contained requires --onto' '
 '
 
 test_expect_success 'cannot advance target ... ordering would be ill-defined' '
-	cat >expect <<-\EOF &&
-	fatal: '"'"'--advance'"'"' cannot be used with multiple revision ranges because the ordering would be ill-defined
+	cat >expect <<-EOF &&
+	fatal: ${SQ}--advance${SQ} cannot be used with multiple revision ranges because the ordering would be ill-defined
 	EOF
 	test_must_fail git replay --advance=main main topic1 topic2 2>actual &&
 	test_cmp expect actual
@@ -109,7 +109,7 @@ test_expect_success 'replaying merge commits is not supported yet' '
 '
 
 test_expect_success 'using replay to rebase two branches, one on top of other' '
-	git replay --ref-action=print --onto main topic1..topic2 >result &&
+	git replay --ref-action=print --onto=main topic1..topic2 >result &&
 
 	test_line_count = 1 result &&
 
@@ -125,16 +125,16 @@ test_expect_success 'using replay to rebase two branches, one on top of other' '
 '
 
 test_expect_success 'using replay on bare repo to rebase two branches, one on top of other' '
-	git -C bare replay --ref-action=print --onto main topic1..topic2 >result-bare &&
+	git -C bare replay --ref-action=print --onto=main topic1..topic2 >result-bare &&
 	test_cmp expect result-bare
 '
 
 test_expect_success 'using replay to rebase with a conflict' '
-	test_expect_code 1 git replay --onto topic1 B..conflict
+	test_expect_code 1 git replay --onto=topic1 B..conflict
 '
 
 test_expect_success 'using replay on bare repo to rebase with a conflict' '
-	test_expect_code 1 git -C bare replay --onto topic1 B..conflict
+	test_expect_code 1 git -C bare replay --onto=topic1 B..conflict
 '
 
 test_expect_success 'using replay to perform basic cherry-pick' '
@@ -143,7 +143,7 @@ test_expect_success 'using replay to perform basic cherry-pick' '
 	# 2nd field of result is refs/heads/main vs. refs/heads/topic2
 	# 4th field of result is hash for main instead of hash for topic2
 
-	git replay --ref-action=print --advance main topic1..topic2 >result &&
+	git replay --ref-action=print --advance=main topic1..topic2 >result &&
 
 	test_line_count = 1 result &&
 
@@ -159,7 +159,7 @@ test_expect_success 'using replay to perform basic cherry-pick' '
 '
 
 test_expect_success 'using replay on bare repo to perform basic cherry-pick' '
-	git -C bare replay --ref-action=print --advance main topic1..topic2 >result-bare &&
+	git -C bare replay --ref-action=print --advance=main topic1..topic2 >result-bare &&
 	test_cmp expect result-bare
 '
 
@@ -170,11 +170,11 @@ test_expect_success 'commits that become empty are dropped' '
 	test_when_finished "git update-ref --stdin <original-branches &&
 		rm original-branches" &&
 	# Cherry-pick tip of topic1 ("F"), from the middle of A..empty, to main
-	git replay --advance main topic1^! &&
+	git replay --advance=main topic1^! &&
 
 	# Replay all of A..empty onto main (which includes topic1 & thus F
 	# in the middle)
-	git replay --onto main --branches --ancestry-path=empty ^A \
+	git replay --onto=main --branches --ancestry-path=empty ^A \
 		>result &&
 	git log --format="%s%d" L..empty >actual &&
 	test_write_lines >expect \
@@ -183,7 +183,7 @@ test_expect_success 'commits that become empty are dropped' '
 '
 
 test_expect_success 'replay on bare repo fails with both --advance and --onto' '
-	test_must_fail git -C bare replay --advance main --onto main topic1..topic2 >result-bare
+	test_must_fail git -C bare replay --advance=main --onto=main topic1..topic2 >result-bare
 '
 
 test_expect_success 'replay fails when both --advance and --onto are omitted' '
@@ -191,7 +191,7 @@ test_expect_success 'replay fails when both --advance and --onto are omitted' '
 '
 
 test_expect_success 'using replay to also rebase a contained branch' '
-	git replay --ref-action=print --contained --onto main main..topic3 >result &&
+	git replay --ref-action=print --contained --onto=main main..topic3 >result &&
 
 	test_line_count = 2 result &&
 	cut -f 3 -d " " result >new-branch-tips &&
@@ -215,12 +215,12 @@ test_expect_success 'using replay to also rebase a contained branch' '
 '
 
 test_expect_success 'using replay on bare repo to also rebase a contained branch' '
-	git -C bare replay --ref-action=print --contained --onto main main..topic3 >result-bare &&
+	git -C bare replay --ref-action=print --contained --onto=main main..topic3 >result-bare &&
 	test_cmp expect result-bare
 '
 
 test_expect_success 'using replay to rebase multiple divergent branches' '
-	git replay --ref-action=print --onto main ^topic1 topic2 topic4 >result &&
+	git replay --ref-action=print --onto=main ^topic1 topic2 topic4 >result &&
 
 	test_line_count = 2 result &&
 	cut -f 3 -d " " result >new-branch-tips &&
@@ -244,7 +244,7 @@ test_expect_success 'using replay to rebase multiple divergent branches' '
 '
 
 test_expect_success 'using replay on bare repo to rebase multiple divergent branches, including contained ones' '
-	git -C bare replay --ref-action=print --contained --onto main ^main topic2 topic3 topic4 >result &&
+	git -C bare replay --ref-action=print --contained --onto=main ^main topic2 topic3 topic4 >result &&
 
 	test_line_count = 4 result &&
 	cut -f 3 -d " " result >new-branch-tips &&
@@ -276,7 +276,7 @@ test_expect_success 'using replay to update detached HEAD' '
 	test_when_finished git switch "$current_head" &&
 	git switch --detach &&
 	test_commit something &&
-	git replay --ref-action=print --onto HEAD~2 --ref-action=print HEAD~..HEAD >updates &&
+	git replay --ref-action=print --onto=HEAD~2 --ref-action=print HEAD~..HEAD >updates &&
 	test_grep "update HEAD " updates
 '
 
@@ -299,7 +299,7 @@ test_expect_success 'merge.directoryRenames=false' '
 	git commit -m modified to-rename/add-a-file.t &&
 
 	git -c merge.directoryRenames=false replay \
-		--onto rename-onto rename-onto..rename-from
+		--onto=rename-onto rename-onto..rename-from
 '
 
 test_expect_success 'default atomic behavior updates refs directly' '
@@ -308,7 +308,7 @@ test_expect_success 'default atomic behavior updates refs directly' '
 	test_when_finished "git branch -D test-atomic" &&
 
 	# Test default atomic behavior (no output, refs updated)
-	git replay --onto main topic1..test-atomic >output &&
+	git replay --onto=main topic1..test-atomic >output &&
 	test_must_be_empty output &&
 
 	# Verify ref was updated
@@ -329,7 +329,7 @@ test_expect_success 'atomic behavior in bare repository' '
 	test_when_finished "git -C bare update-ref refs/heads/topic2 $START" &&
 
 	# Test atomic updates work in bare repo
-	git -C bare replay --onto main topic1..topic2 >output &&
+	git -C bare replay --onto=main topic1..topic2 >output &&
 	test_must_be_empty output &&
 
 	# Verify ref was updated in bare repo
@@ -344,7 +344,7 @@ test_expect_success 'reflog message for --advance mode' '
 	test_when_finished "git update-ref refs/heads/main $START" &&
 
 	# Test --advance mode reflog message
-	git replay --advance main topic1..topic2 >output &&
+	git replay --advance=main topic1..topic2 >output &&
 	test_must_be_empty output &&
 
 	# Verify reflog message includes --advance and branch name
@@ -360,7 +360,7 @@ test_expect_success 'replay.refAction=print config option' '
 
 	# Test with config set to print
 	test_config replay.refAction print &&
-	git replay --onto main topic1..topic2 >output &&
+	git replay --onto=main topic1..topic2 >output &&
 	test_line_count = 1 output &&
 	test_grep "^update refs/heads/topic2 " output
 '
@@ -372,7 +372,7 @@ test_expect_success 'replay.refAction=update config option' '
 
 	# Test with config set to update
 	test_config replay.refAction update &&
-	git replay --onto main topic1..topic2 >output &&
+	git replay --onto=main topic1..topic2 >output &&
 	test_must_be_empty output &&
 
 	# Verify ref was updated
@@ -388,14 +388,14 @@ test_expect_success 'command-line --ref-action overrides config' '
 
 	# Set config to update but use --ref-action=print
 	test_config replay.refAction update &&
-	git replay --ref-action=print --onto main topic1..topic2 >output &&
+	git replay --ref-action=print --onto=main topic1..topic2 >output &&
 	test_line_count = 1 output &&
 	test_grep "^update refs/heads/topic2 " output
 '
 
 test_expect_success 'invalid replay.refAction value' '
 	test_config replay.refAction invalid &&
-	test_must_fail git replay --onto main topic1..topic2 2>error &&
+	test_must_fail git replay --onto=main topic1..topic2 2>error &&
 	test_grep "invalid.*replay.refAction.*value" error
 '
 
@@ -407,10 +407,10 @@ test_expect_success 'argument to --revert must be a reference' '
 '
 
 test_expect_success 'cannot revert with multiple sources' '
-	cat >expect <<-\EOF &&
-	fatal: '"'"'--revert'"'"' cannot be used with multiple revision ranges because the ordering would be ill-defined
+	cat >expect <<-EOF &&
+	fatal: ${SQ}--revert${SQ} cannot be used with multiple revision ranges because the ordering would be ill-defined
 	EOF
-	test_must_fail git replay --revert main main topic1 topic2 2>actual &&
+	test_must_fail git replay --revert=main main topic1 topic2 2>actual &&
 	test_cmp expect actual
 '
 
@@ -420,7 +420,7 @@ test_expect_success 'using replay --revert to revert commits' '
 	test_when_finished "git branch -f topic4 $START" &&
 
 	# Revert commits I and J
-	git replay --revert topic4 topic4~2..topic4 &&
+	git replay --revert=topic4 topic4~2..topic4 &&
 
 	# Verify the revert commits were created (newest-first ordering
 	# means J is reverted first, then I on top)
@@ -452,7 +452,7 @@ test_expect_success 'using replay --revert in bare repo' '
 	test_when_finished "git -C bare update-ref refs/heads/topic4 $START" &&
 
 	# Revert commit J in bare repo
-	git -C bare replay --revert topic4 topic4~1..topic4 &&
+	git -C bare replay --revert=topic4 topic4~1..topic4 &&
 
 	# Verify revert was created
 	git -C bare log -1 --format=%s topic4 >actual &&
@@ -466,11 +466,11 @@ test_expect_success 'revert of revert uses Reapply' '
 	test_when_finished "git branch -f topic4 $START" &&
 
 	# First revert J
-	git replay --revert topic4 topic4~1..topic4 &&
+	git replay --revert=topic4 topic4~1..topic4 &&
 	REVERT_J=$(git rev-parse topic4) &&
 
 	# Now revert the revert - should become Reapply
-	git replay --revert topic4 topic4~1..topic4 &&
+	git replay --revert=topic4 topic4~1..topic4 &&
 
 	# Verify Reapply prefix and message format
 	test_commit_message topic4 <<-EOF
@@ -482,21 +482,21 @@ test_expect_success 'revert of revert uses Reapply' '
 
 test_expect_success 'git replay --revert with conflict' '
 	# conflict branch has C.conflict which conflicts with topic1s C
-	test_expect_code 1 git replay --revert conflict B..topic1
+	test_expect_code 1 git replay --revert=conflict B..topic1
 '
 
 test_expect_success 'git replay --revert incompatible with --contained' '
-	test_must_fail git replay --revert topic4 --contained topic4~1..topic4 2>error &&
+	test_must_fail git replay --revert=topic4 --contained topic4~1..topic4 2>error &&
 	test_grep "requires --onto" error
 '
 
 test_expect_success 'git replay --revert incompatible with --onto' '
-	test_must_fail git replay --revert topic4 --onto main topic4~1..topic4 2>error &&
+	test_must_fail git replay --revert=topic4 --onto=main topic4~1..topic4 2>error &&
 	test_grep "cannot be used together" error
 '
 
 test_expect_success 'git replay --revert incompatible with --advance' '
-	test_must_fail git replay --revert topic4 --advance main topic4~1..topic4 2>error &&
+	test_must_fail git replay --revert=topic4 --advance=main topic4~1..topic4 2>error &&
 	test_grep "cannot be used together" error
 '
 

-- 
2.53.0.310.g728cabbaf7

