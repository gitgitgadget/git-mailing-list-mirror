Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79180175A98
	for <git@vger.kernel.org>; Tue,  5 May 2026 07:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966939; cv=pass; b=f6XRYV1NBXokfP0WxAESmNNjIIWD4cTdyc5aRNsqcUuJ1u/RXxp9JNBuoqaLoi7MrgTU1evYb6RInoY1Cf7TrHoaSrcecQFTJZyQ+rvctTMTX78xi1kFvPZpFXbsoxg4JSUdvYfcoLnyjUdPj8m8NpE5AmbdnptAJ+TIo7hUoMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966939; c=relaxed/simple;
	bh=d+Gal47YAk3pj7cE1cnzDedqMjAxvNkPve4SoeiRWa4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eiGOEcX0HGVSuyjS719nNaidPjJ6AVCOXD3iNTwfvyBy3wKOFSEMZNTebEa+woeWGcUuNstIyrUEo+NcvdJIZN0rz5vJUFFA1w/8D9opEzeE7oMhbOqobTiTP1iuBY/KBkaa8EXUQCCtfLCyzUJUXFvvP1vUPqRiIixxk3t4pvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=vmiklos@collabora.com header.b=bcDr6J4J; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=vmiklos@collabora.com header.b="bcDr6J4J"
ARC-Seal: i=1; a=rsa-sha256; t=1777966927; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GtPdXosyG8I3pTSQlBf6EvfJtBqwl7pnKumRx9hrOnuF/SLYU9yt8cxzBHBRGFmtLVMLFxayXcEbzQ40lSgjh0SwgFVn2fD4TNGO94NDv+c/2OWoBvOlVK4IVjbrpw7RFf1uqeLb68SBH5XPKuHohUHrTDxE2ulBp4MynCBzmKY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777966927; h=Content-Type:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=I9B2voE6iHR6ScnW1JyO3uW2u8Q98/n6Bjo1O4LWtlY=; 
	b=kcLguVMA0U82AWh1fxUOH6CWLXixjv6dEMtJECMHPS04//vSUrB1NdD6pmgA2Ufp7Bl8mS6LjXiowaOBl24xKkVq/teSX0MgcoSlZPTu/Ikz1fzgYVskLhLGYS8j0CNpf4/RCB52T/CfqOjrFPoQ2qdoluxb42ePODRimrKJRug=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777966927;
	s=zohomail; d=collabora.com; i=vmiklos@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=I9B2voE6iHR6ScnW1JyO3uW2u8Q98/n6Bjo1O4LWtlY=;
	b=bcDr6J4JMoBInJM4aWG/mWa6GSXKgtxexP5jsKg++NB+c+NFHgM7zTkJ8EaboEqN
	Evhe38BoWu56mQIwCyj+KpI1D/h1+bZjT8Vfvygtu5MAzAGTy8pZ21q2xEsQn5IG+Dq
	O+iPkyYBRsJ0BmGl9OlWvS/uVmrLLHBPph+KSD2U=
Received: by mx.zohomail.com with SMTPS id 1777966926087765.0174646423059;
	Tue, 5 May 2026 00:42:06 -0700 (PDT)
Date: Tue, 5 May 2026 09:42:01 +0200
From: Miklos Vajna <vmiklos@collabora.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] log: let --follow follow renames in merge commits
Message-ID: <afmfSa-p-9vuDL3E@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ZohoMailClient: External

Have a repo with a subtree merge, do a 'git log --follow prefix/test.c',
the output only contains history in the outer repo, not commits that
were merged via a subtree merge.

This is inconsistent, since doing a 'git blame prefix/test.c' does find
the original commits. This works because find_rename() in blame.c is
invoked for each parent, and there diff_tree_oid() is used, which uses
try_to_follow_renames(). This means that in case a rename happens as
part of a merge commit, git blame can follow that rename.

Fix the problem in a similar way for the 'git log --follow' case: in
case log_tree_diff() finds a merge commit and it would return early,
then do some extra work in the follow_renames case first. Check each
parent, use diff_tree_oid() and if found_follow is set, then work with
that parent instead of returning.

This means that users examining the history of a repo with subtree
merges can see all commits to a file with a single 'git log --follow'
invocation, instead of one invocation for the outer repo and one for the
history before the subtree merge.

Signed-off-by: Miklos Vajna <vmiklos@collabora.com>
---

Hi,

I recently ran into a case where a subtree merge was used to do a
one-off import of one repo into an other one, into a subdirectory. Turns
out git blame finds original commits nicely, but git log --follow is
less great for this case. This is an improvement to also follow renames
when the rename happens as part of a merge commit.

Let me know if I managed to get some formality wrong, I haven't
contributed since 2022.

Could you please review this?

Thanks,

Miklos

 log-tree.c                          | 20 ++++++++++++++++-
 t/meson.build                       |  1 +
 t/t4218-log-follow-subtree-merge.sh | 34 +++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100755 t/t4218-log-follow-subtree-merge.sh

diff --git a/log-tree.c b/log-tree.c
index 7e048701d0..bce09c7dac 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1142,8 +1142,26 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 				/* Show parent info for multiple diffs */
 				log->parent = parents->item;
 			}
-		} else
+		} else {
+			if (opt->diffopt.flags.follow_renames) {
+				/*
+				 * Detect a rename across one of the parents.
+				 * Check each parent till we find a follow.
+				 */
+				struct commit_list *p;
+				for (p = parents; p; p = p->next) {
+					parse_commit_or_die(p->item);
+					diff_tree_oid(get_commit_tree_oid(p->item),
+						      oid, "", &opt->diffopt);
+					diff_queue_clear(&diff_queued_diff);
+					if (opt->diffopt.found_follow) {
+						opt->diffopt.found_follow = 0;
+						break;
+					}
+				}
+			}
 			return 0;
+		}
 	}
 
 	showed_log = 0;
diff --git a/t/meson.build b/t/meson.build
index 7528e5cda5..b4ae8d76d8 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -574,6 +574,7 @@ integration_tests = [
   't4215-log-skewed-merges.sh',
   't4216-log-bloom.sh',
   't4217-log-limit.sh',
+  't4218-log-follow-subtree-merge.sh',
   't4252-am-options.sh',
   't4253-am-keep-cr-dos.sh',
   't4254-am-corrupt.sh',
diff --git a/t/t4218-log-follow-subtree-merge.sh b/t/t4218-log-follow-subtree-merge.sh
new file mode 100755
index 0000000000..7ca607cbb8
--- /dev/null
+++ b/t/t4218-log-follow-subtree-merge.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+test_description='Test --follow follows renames across subtree merges'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'setup subtree-merged repository' '
+	git init inner &&
+	echo inner >inner/inner.txt &&
+	git -C inner add inner.txt &&
+	git -C inner commit -m "inner init" &&
+
+	git init outer &&
+	echo outer >outer/outer.txt &&
+	git -C outer add outer.txt &&
+	git -C outer commit -m "outer init" &&
+
+	git -C outer fetch ../inner master &&
+	git -C outer merge -s ours --no-commit --allow-unrelated-histories \
+		FETCH_HEAD &&
+	git -C outer read-tree --prefix=inner/ -u FETCH_HEAD &&
+	git -C outer commit -m "Merge inner repo into inner/ subdirectory"
+'
+
+test_expect_success '--follow finds the pre-merge commit through a subtree merge' '
+	git -C outer log --follow --pretty=tformat:%s inner/inner.txt >actual &&
+	echo "inner init" >expect &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.51.0

