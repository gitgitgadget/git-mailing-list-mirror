Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E66D3438B5
	for <git@vger.kernel.org>; Sat, 23 May 2026 06:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779516306; cv=pass; b=kgWxBE7TcVPonqYr32p/sYkdjvQDKVoz8t4Dp7t+WybJZPTHzX5Z7/BJs0kMmQCPZmRqcndomQuWAEnO10uJaNFD2e/v8P0fC8amppn47yXaxVrlyukko8mQPSmHUOg8qoyqgMQWlW4CCigY5mmAX4wOKFrQCWQiiATgGH7LADQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779516306; c=relaxed/simple;
	bh=9IB1Ef7Vy3QK2qVM24zY0RLTzIvPlugXk+kS/Lw6kc0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kdMkgW8zIEiKd59TwvDJC7CMhxUJn7tBlweXuhXbwS+4zoXuiguZNp/VfS8MBli7KWcEa5NVbJWZmKLcZBgzqMUxWrhjap1uxMgoUC0IU+B7O7iN74vq6MDVpaUYzbxMuOG6aNQhmQZnrrcXnyI5FkxQwkyKz/9Ouu8v57GOcdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=vmiklos@collabora.com header.b=Rv3+v7yw; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=vmiklos@collabora.com header.b="Rv3+v7yw"
ARC-Seal: i=1; a=rsa-sha256; t=1779516298; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Vs2s01cEcW2LXlZ2IASalmGxRDdU9TyQebJCOyWJAeavfjkKyRA1xJYjBfSMsguHjYPptxlA7e5uiwG2yJjkQkftQ04jWbLNI43QQnjDoyBlabSj9tVyZ1E/EAV5nqJLt40GQiGQ9PAgA5oFir5yCIz9VR4jZwYiPqTN/NlGZpI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779516298; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BC30cNhpqeXTJWRwNXrF3Oh5eUJl/+gjjL+t8xowaFw=; 
	b=czcwBArxKfRdm6t93MYSeTH8uGqKvJLUTp9iZ+6xj2wC1tq5o2KzICDrrq1Rdb50x+5wcVzUUKJ7/Pu/eQyzbjuFqKGvM9ufVhsS1ZUtr4FwVjwjUPqdpDn6xUZIg8dllNd2GJdS/UVjtlvf9gyx44AxbFfbbhZg2TTPcm45EpE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779516297;
	s=zohomail; d=collabora.com; i=vmiklos@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=BC30cNhpqeXTJWRwNXrF3Oh5eUJl/+gjjL+t8xowaFw=;
	b=Rv3+v7ywW062CtfBhU2xa+tv7WhrCQyZQ2Y/1+KaMJP7eGzC1PpGNTWln4cmYp7K
	WoxMmHCKk1FY/S/OABHrCqyMVr+sW5y+7FiJSazKokev3Lx0Q440PvSslSXqHye8JGX
	ZwMdV3wevIU0fXK1Ku/YX+cd89woFom6+ssGf8os=
Received: by mx.zohomail.com with SMTPS id 1779516295640775.4625328719308;
	Fri, 22 May 2026 23:04:55 -0700 (PDT)
Date: Sat, 23 May 2026 08:04:50 +0200
From: Miklos Vajna <vmiklos@collabora.com>
To: Jeff King <peff@peff.net>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: [PATCH] log: improve --follow following renames in merge commits
Message-ID: <ahFDgq4TAcs29zCA@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260522054312.GD861761@coredump.intra.peff.net>
X-ZohoMailClient: External

Have a repo with a subtree merge, do a 'git log --follow prefix/test.c',
the output only contains history in the outer repo, not commits that
were merged via a subtree merge.

There is an inherent limitation of the current 'git log --follow'
design, since it's limited to a single filename, and once 'git log' sees
a rename, it only tracks the new path, which only works with mostly
linear history.  Still, 'git blame prefix/test.c' does find the original
commits, so it's fair to expect 'git log --follow' can do the same.

Fix the problem by improving when to update the followed path in
log_tree_diff(). If the path is untouched versus the merge result in all
parents but one, then choose the parent where it was changed, including
any --follow processing.

This is almost the same as requiring that all but one parents are
TREESAME, except we don't consider the addition of a file as
"interesting". With this, the pre-merge history of subtree merge is
visible in git log, but the behavior is unchanged for other cases (e.g.
when a file was previously named differently on multiple parents).

Signed-off-by: Miklos Vajna <vmiklos@collabora.com>
---

Hi Jeff,

On Fri, May 22, 2026 at 01:43:12AM -0400, Jeff King <peff@peff.net> wrote:
> I think we can probably all agree that both before and after your patch,
> --follow is never going to do the _right_ thing, which is to follow
> paths independently down both sides of history.

Sure.

> I am OK conceptually with making the current broken behavior slightly
> more useful if it is easy to do. But I am not sure if we are making
> things more useful here or not. If we see a merge where the file "bar"
> was previous "foo" on one side and "bar" on the other, our broken follow
> is going to either pick "foo" or "bar" to continue with as we traverse.
> But which one is right? Whichever name we choose, we are potentially
> omitting results from the other side.

Indeed, I didn't consider this case.

> There might be a more useful rule like: if the path is untouched versus
> the merge result in all parents but one (i.e., TREESAME), then choose
> the parent where it was changed, including any --follow processing.

I like this idea: it keeps working with the subtree use-case I have in
mind and goes back to not change behavior when the file has history on
multiple parents.

> So I dunno. Probably some experimenting could yield more analysis there,

I think requiring TREESAME for all but one parents is too strict, since
a subtree merge will look like an addition vs the first parent and will
look like a rename on the first parent. It seems to me that handling
addition as TREESAME can be correct: if the file was just added, that
suggests it has no prior history.

So a slightly relaxed rule could be: if the path is untouched or just
added versus the merge result in all parents but one, then choose the
parent where it was changed, including any --follow processing.

Here is a patch that implements that idea. It works for the subtree
merge use-case I outlined and I also added a test to show that the
behavior is unchanged for the "multiple parents have actual history for
this file" case you mentioned.

What do you think?

Thanks,

Miklos

 log-tree.c                          | 55 ++++++++++++++++++++++++-
 t/meson.build                       |  1 +
 t/t4218-log-follow-subtree-merge.sh | 64 +++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100755 t/t4218-log-follow-subtree-merge.sh

diff --git a/log-tree.c b/log-tree.c
index 7e048701d0..368144fafc 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1142,8 +1142,61 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 				/* Show parent info for multiple diffs */
 				log->parent = parents->item;
 			}
-		} else
+		} else {
+			if (opt->diffopt.flags.follow_renames) {
+				/*
+				 * If the path is untouched in all parents but
+				 * one, then choose the parent where it was
+				 * changed.
+				 */
+				struct commit_list *p;
+				struct commit *changed_parent = NULL;
+				int n_changed = 0;
+
+				for (p = parents; p; p = p->next) {
+					struct diff_options diff_opts;
+					int interesting = 0;
+					int i;
+
+					parse_commit_or_die(p->item);
+					repo_diff_setup(opt->diffopt.repo, &diff_opts);
+					copy_pathspec(&diff_opts.pathspec,
+						      &opt->diffopt.pathspec);
+					diff_opts.flags.recursive = 1;
+					diff_opts.flags.follow_renames = 1;
+					diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+					diff_setup_done(&diff_opts);
+					diff_tree_oid(get_commit_tree_oid(p->item),
+						      oid, "", &diff_opts);
+
+					for (i = 0; i < diff_queued_diff.nr; i++) {
+						struct diff_filepair *pair = diff_queued_diff.queue[i];
+						if (DIFF_FILE_VALID(pair->one)) {
+							interesting = 1;
+							break;
+						}
+					}
+
+					diff_queue_clear(&diff_queued_diff);
+					diff_free(&diff_opts);
+
+					if (interesting) {
+						n_changed++;
+						changed_parent = p->item;
+						if (n_changed > 1)
+							break;
+					}
+				}
+
+				if (n_changed == 1) {
+					diff_tree_oid(get_commit_tree_oid(changed_parent),
+						      oid, "", &opt->diffopt);
+					diff_queue_clear(&diff_queued_diff);
+					opt->diffopt.found_follow = 0;
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
index 0000000000..fc846ebeb4
--- /dev/null
+++ b/t/t4218-log-follow-subtree-merge.sh
@@ -0,0 +1,64 @@
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
+test_expect_success 'setup merge with rename sources on multiple parents' '
+	git init left &&
+	printf "shared content\n" >left/a.txt &&
+	git -C left add a.txt &&
+	git -C left commit -m "left: a.txt" &&
+
+	git init right &&
+	printf "shared content\n" >right/b.txt &&
+	git -C right add b.txt &&
+	git -C right commit -m "right: b.txt" &&
+
+	git -C left fetch ../right master &&
+	git -C left merge -s ours --no-commit --allow-unrelated-histories \
+		FETCH_HEAD &&
+	git -C left rm a.txt &&
+	printf "shared content\n" >left/c.txt &&
+	git -C left add c.txt &&
+	git -C left commit -m "Merge: rename to c.txt" &&
+
+	printf "more content\n" >>left/c.txt &&
+	git -C left add c.txt &&
+	git -C left commit -m "modify c.txt"
+'
+
+test_expect_success '--follow does not switch when multiple parents supply a rename source' '
+	git -C left log --follow --pretty=tformat:%s c.txt >actual &&
+	echo "modify c.txt" >expect &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.51.0

