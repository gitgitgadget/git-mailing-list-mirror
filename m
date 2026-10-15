Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB36737F8CA
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075742; cv=pass; b=uaq693MYcI4msVLSR/VYmpd4UT2pKDw0eZQ/qzPTQw5F886+hegVvvxsYftNIGME4s5Dl9ZQTVw6/h5OULn4kyWfXErM3Jzd9mHsF3VJ5vO/n71wPwzNQv8qaAJZ8uWq0ChvrZ4A26bXjG/Zf8WeRdFK5iBx2DP09UlZq176VA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075742; c=relaxed/simple;
	bh=vnFEh0LLtDfPRVueaj2zWGuiqoldrwNKPjN7MRGiJFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0Cc8cPGdhtkbPIDKb3amUMSlfeY/iE097xV061GIknIqv/OONFsoe1bByseu4XaapPN4ymDGMJXyYRr6RRGHDyaz/7o0RbhuoTg8GmphPvt1x+bAYqRorDu9CYXukXvJUY/iiYu7AOdNpireAb3fsotI4+FkZ+lTpKKTS8yO8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=vmiklos@collabora.com header.b=bd8j0kQK; arc=pass smtp.client-ip=165.173.182.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=vmiklos@collabora.com header.b="bd8j0kQK"
ARC-Seal: i=1; a=rsa-sha256; t=1792075732; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hvlNwKBPH8GDKm7N3LIc2MmjDCYp/Beiorwg9WQBHNEPwmKjmPY/9IlRmpLleSTTd7enOndDDKc9bRYF3iE8zenWD4n6K9ytzGpOfDvXfoAQWV3cYYo6d+ckfXHA3BvXLaRtwVKEf9J+5VjZakfvTED8N/n3n9nTFCLtrsNJDMQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792075732; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hdRnLjulGdpBA5PxJ0cmL+N7HNBpJNa17+vWfj4S2g4=; 
	b=JV+/9a84AbBjD62ZUcOINrAUwxFBG2f4nBufJFQQI2rMhuUpGIWGpr/+n5lHCoN4ndyX1JGtMUbrJgJv4gyW+w7LETOjhjTN59BWDe5l34TVHx3EMnR1Y4O0/IHJxJHjwnESdnuj6kDGDpICyLpXsAfsbuNjJ4JoFaf9zEr7APk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792075732;
	s=zohomail; d=collabora.com; i=vmiklos@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=hdRnLjulGdpBA5PxJ0cmL+N7HNBpJNa17+vWfj4S2g4=;
	b=bd8j0kQKiA2+MAg29hU4qj9c+oHkwGf1e5Z+RugBBh3DbsKZc52Btpdb1kkDGJNp
	RpZLvTpxp0/Fd/wgDzQm76HHCWv/9XCPuvVm4JHEdhjPMvt2XvGe5kDeAfwW8VAH2KF
	oEDLNOgeFJh+fyTgfefK3Nyc8A0q6u/7xKCfepqo=
Received: by smtp.zohomail.com with SMTPS id 1792075728287687.6580488587766;
	Thu, 15 Oct 2026 07:48:48 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:48:43 +0200
From: Miklos Vajna <vmiklos@collabora.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: [PATCH] log: speed up --follow following renames for non-linear
 history
Message-ID: <atDnyzC_2oaLF0Wo@collabora.com>
References: <as44NVKZA9C9S5ae@pks.im>
 <as6hmUG5AaL5iLbO@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <as6hmUG5AaL5iLbO@szeder.dev>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/292.52.33
X-ZohoMailClient: External

Test the performance of 'git log --stat --follow --
include/linux/rsc_table.h' on linux.git, it used to take about 28
seconds, and since commit 304812ed33 (log: improve --follow following
renames for non-linear history, 2026-06-22), it takes 6m43s.

What happens is that propagate_follow_pathspec_to_parent() does a
somewhat expensive rename detection of the current commit vs all of its
parents, and this slows down 'git log --follow'.

Fix the problem by introducing two shortcuts:
1) Only do that when the path is added relative to a parent and
2) If the path is the same as in one of the parents, then just follow
   that history

These shortcuts keep all the uses-cases in t4219-log-follow-merge.sh
working, but now the above use case takes 29s, close to the original
cost.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Miklos Vajna <vmiklos@collabora.com>
---

Hi Gabor, Patrick,

Here is my suggested speed-up patch. I think it's correct to take these two shortcuts since the
original use cases continue to work, and then we're almost back to the original performance.

Let me know what you think; if you don't see problems with it, then a bit later I would send the
patch to Junio.

Thanks,

Miklos

 log-tree.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 4 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 83a3c4bf9b..0d7bf001f0 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1180,6 +1180,74 @@ static void propagate_follow_pathspec_to_parent(struct rev_info *opt,
 	diff_free(&diff_opts);
 }
 
+enum follow_path_change {
+	FOLLOW_PATH_SAME,
+	FOLLOW_PATH_ADDED,
+	FOLLOW_PATH_OTHER,
+};
+
+/* How does the followed path change from parent to commit? */
+static enum follow_path_change get_follow_path_change(struct rev_info *opt,
+						      struct commit *commit,
+						      struct commit *parent)
+{
+	struct diff_options diff_opts;
+	enum follow_path_change ret = FOLLOW_PATH_OTHER;
+
+	parse_commit_or_die(parent);
+	repo_diff_setup(opt->diffopt.repo, &diff_opts);
+	copy_pathspec(&diff_opts.pathspec, &opt->diffopt.pathspec);
+	diff_opts.flags.recursive = 1;
+	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_setup_done(&diff_opts);
+	diff_tree_oid(get_commit_tree_oid(parent),
+		      get_commit_tree_oid(commit),
+		      "", &diff_opts);
+
+	if (!diff_queued_diff.nr)
+		ret = FOLLOW_PATH_SAME;
+	else if (diff_queued_diff.nr == 1 &&
+		 !DIFF_FILE_VALID(diff_queued_diff.queue[0]->one))
+		ret = FOLLOW_PATH_ADDED;
+
+	diff_queue_clear(&diff_queued_diff);
+	diff_free(&diff_opts);
+	return ret;
+}
+
+/* Compute a path to follow in each parent of a merge */
+static void propagate_follow_pathspec_to_parents(struct rev_info *opt,
+						 struct commit *commit,
+						 struct commit_list *parents)
+{
+	const char *path = pathspec_single_path(&opt->diffopt.pathspec);
+	struct commit_list *p;
+	enum follow_path_change *changes;
+	int nr = commit_list_count(parents), i;
+	int has_same = 0;
+
+	if (!path)
+		return;
+
+	ALLOC_ARRAY(changes, nr);
+	for (p = parents, i = 0; p; p = p->next, i++) {
+		changes[i] = get_follow_path_change(opt, commit, p->item);
+		if (changes[i] == FOLLOW_PATH_SAME) {
+			has_same = 1;
+			break;
+		}
+	}
+
+	for (p = parents, i = 0; p; p = p->next, i++) {
+		if (!has_same && changes[i] == FOLLOW_PATH_ADDED)
+			/* Never the same, added here: expensive rename detection */
+			propagate_follow_pathspec_to_parent(opt, commit, p->item);
+		else
+			remember_follow_pathspec(opt, p->item, path);
+	}
+	free(changes);
+}
+
 /*
  * Show the diff of a commit.
  *
@@ -1303,10 +1371,8 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 	if (opt->diffopt.flags.follow_renames) {
 		struct commit_list *parents = get_saved_parents(opt, commit);
 		if (parents && parents->next) {
-			struct commit_list *p;
-			for (p = parents; p; p = p->next)
-				propagate_follow_pathspec_to_parent(opt, commit,
-								    p->item);
+			propagate_follow_pathspec_to_parents(opt, commit,
+							     parents);
 		} else if (parents) {
 			remember_follow_pathspec(opt, parents->item,
 				pathspec_single_path(&opt->diffopt.pathspec));
-- 
2.56.0

