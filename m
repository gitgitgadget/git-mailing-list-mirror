Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94B331327A
	for <git@vger.kernel.org>; Fri, 26 Dec 2025 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766735389; cv=none; b=Kl8X+n11F4Y98sJlLR+XzWFGD1MGjRPzSALUF9MmSlPuibl8Y9zG8Ol01CFsaxmRnIcHBU6+9rnymSqZMcZEVI9haNdaWtWI8BikBak8ygO8ZFOBksPuu9gvbQWCea0UwjvTqBd9POVnihvZNqCqL5jPJu8So3fbZtGoZhu5p4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766735389; c=relaxed/simple;
	bh=cgXD+X1VUH/kgYhvu5Thk64+T5fdnBq7qIUkMt7G7nQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=kwsgsA9UFdppmhyYAzyXaE6yryDhTd7UcsJ95CbOa6iwsjsVCTthAF4cISlcvfMHQ9t5dKQcE5Y+pXveFZ+Jv/iF/1cf1gEsZg8dLdKZvfb3KYiIeOyUmqTkzwlXCMHQHUI8/4nzV3ZJQBxgSGoK1UUg+9g2bECzRERH4U4TpzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=txKOT62j; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="txKOT62j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766735379; x=1767340179; i=l.s.r@web.de;
	bh=nXVu0YdrO9p3k9Vb7yks9/Q2xpr/ibxV7ax9C12r8Po=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=txKOT62jO7hh/U7OBVK/DkAPrpdYkjryInfe1k5depi8tvKf+XN8azYPLkz/B6XT
	 flq5Pf48tl9EJRhVEmw7wBIZp698FR/8eVbA/NAnpms9m9+z1jsYTA9qzdm1VGquA
	 9HManJN0ujTF95DtYgucTX9zh5x4QBs1pu7/+mVQHHl9AhRg9b6yfp7+YRKCs5HOH
	 pq3zAZGbS7u8keTtjDe6wXWZYVFESI0zaVBn49Dm6C8A1pbM/4f8x+JFQiFab95UA
	 ZzdpWoFIiovgzNV3K/j4+PBDzBGvK/37AO0VlWjFSTBQugb/E7tfYChpoBPdFyj7J
	 Sndj2r+uoKeLrneYaw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.16.205]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8C09-1vd9MV21Ct-00EQXb for
 <git@vger.kernel.org>; Fri, 26 Dec 2025 08:44:28 +0100
Message-ID: <70ed751e-fc3c-4cb4-a4fd-26094a9f622e@web.de>
Date: Fri, 26 Dec 2025 08:44:28 +0100
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
Subject: [PATCH] show-branch: use prio_queue
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kwhWWb4FpBfY2IjSG0IZHS+xspW8/t7KpNuHRFAFwH0sXKib1Is
 sK5edkIb9CvVuqjukah1jvmuiTQBSQJwkJyi5s8pnHKocKuioexuQav2nfbjG65e7f0HCad
 yhuUWjfxLRkfEvfhu1M/93LvNS2PrNcRapHXc63ME/2Impmtm8zwxSHu1CUqvrif5x9nXbO
 NknAtWnMa4BW0n2DfFTBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qsyWV7MoTqo=;pQRWBmAnjfFkw1XrZNs5t9/UbKv
 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

Building a list using commit_list_insert_by_date() has quadratic worst
case complexity.  Avoid it by using prio_queue.

Use prio_queue_peek()+prio_queue_replace() instead of prio_queue_get()+
prio_queue_put() if possible, as the former only rebalance the
prio_queue heap once instead of twice.

In sane repositories this won't make much of a difference because the
number of items in the list or queue won't be very high:

Benchmark 1: ./git_v2.52.0 show-branch origin/main origin/next origin/seen=
 origin/todo
  Time (mean =C2=B1 =CF=83):     538.2 ms =C2=B1   0.8 ms    [User: 527.6 =
ms, System: 9.6 ms]
  Range (min =E2=80=A6 max):   537.0 ms =E2=80=A6 539.2 ms    10 runs

Benchmark 2: ./git show-branch origin/main origin/next origin/seen origin/=
todo
  Time (mean =C2=B1 =CF=83):     530.6 ms =C2=B1   0.4 ms    [User: 519.8 =
ms, System: 9.8 ms]
  Range (min =E2=80=A6 max):   530.1 ms =E2=80=A6 531.3 ms    10 runs

Summary
  ./git show-branch origin/main origin/next origin/seen origin/todo ran
    1.01 =C2=B1 0.00 times faster than ./git_v2.52.0 show-branch origin/ma=
in origin/next origin/seen origin/todo

That number is not limited, though, and in pathological cases like the
one in p6010 we see a sizable improvement:

Test                      v2.52.0           HEAD
=2D-----------------------------------------------------------------
6010.4: git show-branch   2.19(2.19+0.00)   0.03(0.02+0.00) -98.6%

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/show-branch.c      | 34 +++++++++++++++++++++-------------
 t/perf/p6010-merge-base.sh |  8 ++++++--
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 10475a6b5e..f3ebc1d4ea 100644
=2D-- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -18,6 +18,7 @@
 #include "commit-slab.h"
 #include "date.h"
 #include "wildmatch.h"
+#include "prio-queue.h"
=20
 static const char*const show_branch_usage[] =3D {
     N_("git show-branch [-a | --all] [-r | --remotes] [--topo-order | --d=
ate-order]\n"
@@ -59,11 +60,10 @@ static const char *get_color_reset_code(void)
 	return "";
 }
=20
-static struct commit *interesting(struct commit_list *list)
+static struct commit *interesting(struct prio_queue *queue)
 {
-	while (list) {
-		struct commit *commit =3D list->item;
-		list =3D list->next;
+	for (size_t i =3D 0; i < queue->nr; i++) {
+		struct commit *commit =3D queue->array[i].data;
 		if (commit->object.flags & UNINTERESTING)
 			continue;
 		return commit;
@@ -222,17 +222,18 @@ static int mark_seen(struct commit *commit, struct c=
ommit_list **seen_p)
 	return 0;
 }
=20
-static void join_revs(struct commit_list **list_p,
+static void join_revs(struct prio_queue *queue,
 		      struct commit_list **seen_p,
 		      int num_rev, int extra)
 {
 	int all_mask =3D ((1u << (REV_SHIFT + num_rev)) - 1);
 	int all_revs =3D all_mask & ~((1u << REV_SHIFT) - 1);
=20
-	while (*list_p) {
+	while (queue->nr) {
 		struct commit_list *parents;
-		int still_interesting =3D !!interesting(*list_p);
-		struct commit *commit =3D pop_commit(list_p);
+		int still_interesting =3D !!interesting(queue);
+		struct commit *commit =3D prio_queue_peek(queue);
+		bool get_pending =3D true;
 		int flags =3D commit->object.flags & all_mask;
=20
 		if (!still_interesting && extra <=3D 0)
@@ -253,8 +254,14 @@ static void join_revs(struct commit_list **list_p,
 			if (mark_seen(p, seen_p) && !still_interesting)
 				extra--;
 			p->object.flags |=3D flags;
-			commit_list_insert_by_date(p, list_p);
+			if (get_pending)
+				prio_queue_replace(queue, p);
+			else
+				prio_queue_put(queue, p);
+			get_pending =3D false;
 		}
+		if (get_pending)
+			prio_queue_get(queue);
 	}
=20
 	/*
@@ -639,7 +646,8 @@ int cmd_show_branch(int ac,
 {
 	struct commit *rev[MAX_REVS], *commit;
 	char *reflog_msg[MAX_REVS] =3D {0};
-	struct commit_list *list =3D NULL, *seen =3D NULL;
+	struct commit_list *seen =3D NULL;
+	struct prio_queue queue =3D { compare_commits_by_commit_date };
 	unsigned int rev_mask[MAX_REVS];
 	int num_rev, i, extra =3D 0;
 	int all_heads =3D 0, all_remotes =3D 0;
@@ -883,14 +891,14 @@ int cmd_show_branch(int ac,
 		 */
 		commit->object.flags |=3D flag;
 		if (commit->object.flags =3D=3D flag)
-			commit_list_insert_by_date(commit, &list);
+			prio_queue_put(&queue, commit);
 		rev[num_rev] =3D commit;
 	}
 	for (i =3D 0; i < num_rev; i++)
 		rev_mask[i] =3D rev[i]->object.flags;
=20
 	if (0 <=3D extra)
-		join_revs(&list, &seen, num_rev, extra);
+		join_revs(&queue, &seen, num_rev, extra);
=20
 	commit_list_sort_by_date(&seen);
=20
@@ -1001,7 +1009,7 @@ int cmd_show_branch(int ac,
 	for (size_t i =3D 0; i < ARRAY_SIZE(reflog_msg); i++)
 		free(reflog_msg[i]);
 	free_commit_list(seen);
-	free_commit_list(list);
+	clear_prio_queue(&queue);
 	free(args_copy);
 	free(head);
 	return ret;
diff --git a/t/perf/p6010-merge-base.sh b/t/perf/p6010-merge-base.sh
index 54f52fa23e..08212dd037 100755
=2D-- a/t/perf/p6010-merge-base.sh
+++ b/t/perf/p6010-merge-base.sh
@@ -83,9 +83,9 @@ build_history2 () {
 test_expect_success 'setup' '
 	max_level=3D15 &&
 	build_history $max_level | git fast-import --export-marks=3Dmarks &&
-	git tag one &&
+	git branch one &&
 	build_history2 $max_level | git fast-import --import-marks=3Dmarks --for=
ce &&
-	git tag two &&
+	git branch two &&
 	git gc &&
 	git log --format=3D%H --no-merges >expect
 '
@@ -98,4 +98,8 @@ test_expect_success 'verify result' '
 	test_cmp expect actual
 '
=20
+test_perf 'git show-branch' '
+	git show-branch one two
+'
+
 test_done
=2D-=20
2.52.0
