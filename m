Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF6713B797
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324440; cv=none; b=W/xClmOlKV96jkLUr4xRoD9nGZKQQRt71HEfgqNqkgK91WRxIM599MWqM+1vqk+hZ2nqYki+KXBJP7Jd2aSwkRF48ip+KwwrpbuPv1PQS6A6W9R2gd0RDM39NV7i7w/vZqx1lCJBJGRRsmJO83Ij+w8DQK8K/aDEX94QNy8edjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324440; c=relaxed/simple;
	bh=UUX3Xjb4UdbnFlcf7tlAse7TmevUqEVk0COhOtMARKs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=oyuZpdGTdZIvc4f2W+Cp3TWhDTPCnozutlQJylmmcNM7CpRXsiHfI4SE9I0l0TRPcVfFf3MM3IGFplDvqNLdndnt0o+0Vby47e2jnvfbrmKYPV21WC7czbD8UkXWrRDgfbm0iqUO652weAvE9v7Urj1girb36MVm14pqPEYyOrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=IVu8WjR/; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="IVu8WjR/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761324430; x=1761929230; i=l.s.r@web.de;
	bh=E9eeFLZQ3sVcHabzCdD+LgEUTK9fc6XozZv2qJauj7I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IVu8WjR/Szkn1HUuTI4aRPyLqbswPqMVn54kz5bBWZEKRpa5VqLudiMQi/9uzJEW
	 2cAs4HQqoJPJaCxJ8u/NQAxCc4C/T/rgQh9U3PmtDtXhn3mqNGtKOnqM2XSN1XRq6
	 V5K4oO8oC83vr6h38raUnBr5+T6kFzxZx9ewc3L5ntO1/lzc4ZyM6GnBz1b/zMGl/
	 Ho7jm7SUNrB3zFEhpm8GHq69UirEd8MCSJnEfOp6kMk0ye8fsEecxIvlhBROp2wAn
	 LL+/+qQxZZCuJeWEvQnUfcifeUoVemgL3Ao2ICrv7+nWH3NY1f+QPd7V5r4vVfz4q
	 jpXDLm6kUI+4OkrJoA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.30.88]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mt8gP-1uIzEV1UQD-01875X for
 <git@vger.kernel.org>; Fri, 24 Oct 2025 18:47:10 +0200
Message-ID: <87a00cb8-8faf-48ec-91aa-009e6e906363@web.de>
Date: Fri, 24 Oct 2025 18:47:10 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] commit-reach: avoid commit_list_insert_by_date()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zc6me1UJACzA5AvtM0eMHL3BKzOJUt9M3Yu3ZF3LZZF4pPMm8u1
 b3WnMas6sVgvVPCZkky7gB5Q4rtRCQ83TAvJtjdKEydtuqmcpAiDdLZPFor3ecs3q7X+/9E
 BLqniY+V/5Vol4Hqzi+N45iXg5npR3lEuEb83eAIIfgNEM7jgOKv/bBDoc6+oR5T4FSRcsJ
 9gRriy4S+wlsSHrHqsgCw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:owY5uR0qow0=;pgiuVr3ZiR4ZUU51RYTbuV+e+d7
 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
 ygL+Q==

Building a list using commit_list_insert_by_date() has quadratic worst
case complexity.  Avoid it by just appending in the loop and sorting at
the end.

The number of merge bases is usually small, so don't expect speedups in
normal repositories.  It has no limit, though.  The added perf test
shows a nice improvement when dealing with 16384 merge bases:

Test                     v2.51.1           HEAD
=2D----------------------------------------------------------------
6010.2: git merge-base   0.55(0.54+0.00)   0.03(0.02+0.00) -94.5%

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Patch formatted with --function-context for easier review, particularly
of paint_down_to_common().

 commit-reach.c             |  14 +++--
 t/perf/p6010-merge-base.sh | 101 +++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 5 deletions(-)
 create mode 100755 t/perf/p6010-merge-base.sh

diff --git a/commit-reach.c b/commit-reach.c
index a339e41aa4..cc18c86d3b 100644
=2D-- a/commit-reach.c
+++ b/commit-reach.c
@@ -52,127 +52,130 @@ static int queue_has_nonstale(struct prio_queue *que=
ue)
 /* all input commits in one and twos[] must have been parsed! */
 static int paint_down_to_common(struct repository *r,
 				struct commit *one, int n,
 				struct commit **twos,
 				timestamp_t min_generation,
 				int ignore_missing_commits,
 				struct commit_list **result)
 {
 	struct prio_queue queue =3D { compare_commits_by_gen_then_commit_date };
 	int i;
 	timestamp_t last_gen =3D GENERATION_NUMBER_INFINITY;
+	struct commit_list **tail =3D result;
=20
 	if (!min_generation && !corrected_commit_dates_enabled(r))
 		queue.compare =3D compare_commits_by_commit_date;
=20
 	one->object.flags |=3D PARENT1;
 	if (!n) {
 		commit_list_append(one, result);
 		return 0;
 	}
 	prio_queue_put(&queue, one);
=20
 	for (i =3D 0; i < n; i++) {
 		twos[i]->object.flags |=3D PARENT2;
 		prio_queue_put(&queue, twos[i]);
 	}
=20
 	while (queue_has_nonstale(&queue)) {
 		struct commit *commit =3D prio_queue_get(&queue);
 		struct commit_list *parents;
 		int flags;
 		timestamp_t generation =3D commit_graph_generation(commit);
=20
 		if (min_generation && generation > last_gen)
 			BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
 			    generation, last_gen,
 			    oid_to_hex(&commit->object.oid));
 		last_gen =3D generation;
=20
 		if (generation < min_generation)
 			break;
=20
 		flags =3D commit->object.flags & (PARENT1 | PARENT2 | STALE);
 		if (flags =3D=3D (PARENT1 | PARENT2)) {
 			if (!(commit->object.flags & RESULT)) {
 				commit->object.flags |=3D RESULT;
-				commit_list_insert_by_date(commit, result);
+				tail =3D commit_list_append(commit, tail);
 			}
 			/* Mark parents of a found merge stale */
 			flags |=3D STALE;
 		}
 		parents =3D commit->parents;
 		while (parents) {
 			struct commit *p =3D parents->item;
 			parents =3D parents->next;
 			if ((p->object.flags & flags) =3D=3D flags)
 				continue;
 			if (repo_parse_commit(r, p)) {
 				clear_prio_queue(&queue);
 				free_commit_list(*result);
 				*result =3D NULL;
 				/*
 				 * At this stage, we know that the commit is
 				 * missing: `repo_parse_commit()` uses
 				 * `OBJECT_INFO_DIE_IF_CORRUPT` and therefore
 				 * corrupt commits would already have been
 				 * dispatched with a `die()`.
 				 */
 				if (ignore_missing_commits)
 					return 0;
 				return error(_("could not parse commit %s"),
 					     oid_to_hex(&p->object.oid));
 			}
 			p->object.flags |=3D flags;
 			prio_queue_put(&queue, p);
 		}
 	}
=20
 	clear_prio_queue(&queue);
+	commit_list_sort_by_date(result);
 	return 0;
 }
=20
 static int merge_bases_many(struct repository *r,
 			    struct commit *one, int n,
 			    struct commit **twos,
 			    struct commit_list **result)
 {
-	struct commit_list *list =3D NULL;
+	struct commit_list *list =3D NULL, **tail =3D result;
 	int i;
=20
 	for (i =3D 0; i < n; i++) {
 		if (one =3D=3D twos[i]) {
 			/*
 			 * We do not mark this even with RESULT so we do not
 			 * have to clean it up.
 			 */
 			*result =3D commit_list_insert(one, result);
 			return 0;
 		}
 	}
=20
 	if (!one)
 		return 0;
 	if (repo_parse_commit(r, one))
 		return error(_("could not parse commit %s"),
 			     oid_to_hex(&one->object.oid));
 	for (i =3D 0; i < n; i++) {
 		if (!twos[i])
 			return 0;
 		if (repo_parse_commit(r, twos[i]))
 			return error(_("could not parse commit %s"),
 				     oid_to_hex(&twos[i]->object.oid));
 	}
=20
 	if (paint_down_to_common(r, one, n, twos, 0, 0, &list)) {
 		free_commit_list(list);
 		return -1;
 	}
=20
 	while (list) {
 		struct commit *commit =3D pop_commit(&list);
 		if (!(commit->object.flags & STALE))
-			commit_list_insert_by_date(commit, result);
+			tail =3D commit_list_append(commit, tail);
 	}
+	commit_list_sort_by_date(result);
 	return 0;
 }
=20
@@ -421,47 +424,48 @@ static int remove_redundant(struct repository *r, st=
ruct commit **array,
 static int get_merge_bases_many_0(struct repository *r,
 				  struct commit *one,
 				  size_t n,
 				  struct commit **twos,
 				  int cleanup,
 				  struct commit_list **result)
 {
-	struct commit_list *list;
+	struct commit_list *list, **tail =3D result;
 	struct commit **rslt;
 	size_t cnt, i;
 	int ret;
=20
 	if (merge_bases_many(r, one, n, twos, result) < 0)
 		return -1;
 	for (i =3D 0; i < n; i++) {
 		if (one =3D=3D twos[i])
 			return 0;
 	}
 	if (!*result || !(*result)->next) {
 		if (cleanup) {
 			clear_commit_marks(one, all_flags);
 			clear_commit_marks_many(n, twos, all_flags);
 		}
 		return 0;
 	}
=20
 	/* There are more than one */
 	cnt =3D commit_list_count(*result);
 	CALLOC_ARRAY(rslt, cnt);
 	for (list =3D *result, i =3D 0; list; list =3D list->next)
 		rslt[i++] =3D list->item;
 	free_commit_list(*result);
 	*result =3D NULL;
=20
 	clear_commit_marks(one, all_flags);
 	clear_commit_marks_many(n, twos, all_flags);
=20
 	ret =3D remove_redundant(r, rslt, cnt, &cnt);
 	if (ret < 0) {
 		free(rslt);
 		return -1;
 	}
 	for (i =3D 0; i < cnt; i++)
-		commit_list_insert_by_date(rslt[i], result);
+		tail =3D commit_list_append(rslt[i], tail);
+	commit_list_sort_by_date(result);
 	free(rslt);
 	return 0;
 }
diff --git a/t/perf/p6010-merge-base.sh b/t/perf/p6010-merge-base.sh
new file mode 100755
index 0000000000..54f52fa23e
=2D-- /dev/null
+++ b/t/perf/p6010-merge-base.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+
+test_description=3D'Test git merge-base'
+
+. ./perf-lib.sh
+
+test_perf_fresh_repo
+
+#
+# Creates lots of merges to make history traversal costly.  In
+# particular it creates 2^($max_level-1)-1 2-way merges on top of
+# 2^($max_level-1) root commits.  E.g., the commit history looks like
+# this for a $max_level of 3:
+#
+#     _1_
+#    /   \
+#   2     3
+#  / \   / \
+# 4   5 6   7
+#
+# The numbers are the fast-import marks, which also are the commit
+# messages.  1 is the HEAD commit and a merge, 2 and 3 are also merges,
+# 4-7 are the root commits.
+#
+build_history () {
+	local max_level=3D"$1" &&
+	local level=3D"${2:-1}" &&
+	local mark=3D"${3:-1}" &&
+	if test $level -eq $max_level
+	then
+		echo "reset refs/heads/master" &&
+		echo "from $ZERO_OID" &&
+		echo "commit refs/heads/master" &&
+		echo "mark :$mark" &&
+		echo "committer C <c@example.com> 1234567890 +0000" &&
+		echo "data <<EOF" &&
+		echo "$mark" &&
+		echo "EOF"
+	else
+		local level1=3D$((level+1)) &&
+		local mark1=3D$((2*mark)) &&
+		local mark2=3D$((2*mark+1)) &&
+		build_history $max_level $level1 $mark1 &&
+		build_history $max_level $level1 $mark2 &&
+		echo "commit refs/heads/master" &&
+		echo "mark :$mark" &&
+		echo "committer C <c@example.com> 1234567890 +0000" &&
+		echo "data <<EOF" &&
+		echo "$mark" &&
+		echo "EOF" &&
+		echo "from :$mark1" &&
+		echo "merge :$mark2"
+	fi
+}
+
+#
+# Creates a new merge history in the same shape as build_history does,
+# while reusing the same root commits.  This way the two top commits
+# have 2^($max_level-1) merge bases between them.
+#
+build_history2 () {
+	local max_level=3D"$1" &&
+	local level=3D"${2:-1}" &&
+	local mark=3D"${3:-1}" &&
+	if test $level -lt $max_level
+	then
+		local level1=3D$((level+1)) &&
+		local mark1=3D$((2*mark)) &&
+		local mark2=3D$((2*mark+1)) &&
+		build_history2 $max_level $level1 $mark1 &&
+		build_history2 $max_level $level1 $mark2 &&
+		echo "commit refs/heads/master" &&
+		echo "mark :$mark" &&
+		echo "committer C <c@example.com> 1234567890 +0000" &&
+		echo "data <<EOF" &&
+		echo "$mark II" &&
+		echo "EOF" &&
+		echo "from :$mark1" &&
+		echo "merge :$mark2"
+	fi
+}
+
+test_expect_success 'setup' '
+	max_level=3D15 &&
+	build_history $max_level | git fast-import --export-marks=3Dmarks &&
+	git tag one &&
+	build_history2 $max_level | git fast-import --import-marks=3Dmarks --for=
ce &&
+	git tag two &&
+	git gc &&
+	git log --format=3D%H --no-merges >expect
+'
+
+test_perf 'git merge-base' '
+	git merge-base --all one two >actual
+'
+
+test_expect_success 'verify result' '
+	test_cmp expect actual
+'
+
+test_done
=2D-=20
2.51.1
