Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE24217A31B
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756024661; cv=none; b=NXiEXHglivjAxzFrMM1yMDTQXbCEc9lFOb1FPQDeaMeOiyqCBj4J7Cp4X0IPQGqEoKxQJxmMtKUxrBLUg5x6fED+DoHv1zI+7q8EO/4OPTnCB9zFr6t3GeBZ9KUQVCSJM1QLiM0i3QpZHubx0KsCv2ODUr3Dx5MNLf/kdT44dbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756024661; c=relaxed/simple;
	bh=qDZUDTyE3FWcfYQOqf+jQ2vtD5jXC+lM0KJo+bikOuw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=JKLch8FYjHbCa4bZo3HvJN50gHil2tbvvT4TS9IfnuJ2nuKCuHxPF62O6Q6wplROrBmTql+fq4dIOvTlc+6OQjix1IyjrVF7tkuo59dgSQbXl1I4IutJVBnBqmIJ0kjiBxqf80ThmczugT9UKghotXo9Tr0EWJ+2d6gLnVMybKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=GyPEBvS1; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="GyPEBvS1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756024648; x=1756629448; i=l.s.r@web.de;
	bh=iyr/sslcqgBiPAGohzzmaY3Jj3LwWXrcIsuoUFm5inw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GyPEBvS1i5R4qLuYKC6vsuY2jdopg/74rkCf+zXOFUWSQoEJ98d0jX3xEICAB1bU
	 Zj0OSKddAzhvk7w6dT2+0yzIdmlfxV+ZpAS9fRmB+xpWdN1Jh6jyQH30XGlbbA0V2
	 1rtjfbxF7w65R8Eb2T/2zHBsk5s66b5E6VkercqJx0XbngQnLd4U99He9YpIG2Hnc
	 cIrazMeQUvz5aUNoeNOEWPGC0/c3by0LuY/VmzoTR+f6GKHeJrt2ELFCkw8i1mePg
	 n+UfYI1FMz0CL11soL7SB7c+RRHEqvXyEKBPnYKoMlXViufXnrBrxCeasFTGEBySi
	 ZjFKLyozdx+3CatUtA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.152.110]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MxHYA-1uaVFo31rM-00y03l for
 <git@vger.kernel.org>; Sun, 24 Aug 2025 10:37:28 +0200
Message-ID: <9110f085-aec0-42e9-9774-b153ece6284f@web.de>
Date: Sun, 24 Aug 2025 10:37:28 +0200
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
Subject: [PATCH] describe: use khash in finish_depth_computation()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CW8oxjH/gLHzQ4GuEX+aYxNOIKH+2KnmOra8mKvFqmvZ9wyaeqF
 Q5/fWDLBrtRjm349iFmkrObGkPFKsUoZZmeEmIr7VPCfx1RMHrF4dUyLkSz2Mfzxi1fqgsp
 eQIokDYO0PmzqpaKtLoOg9V4Mx1RXJNNbn20KraOK+4f8XijPK9R2zk9gTs9YZSl1Kd6KNJ
 h5j+yvw8/7XIkh3anP9yQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cvFIiT56WU4=;dmLl2nkwFSBUoVpeyw6bZ2KuogC
 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

Depth computation can end early if all remaining commits are flagged.
The current code determines if that's the case by checking all queue
items each time it dequeues a flagged commit.  This can cause
quadratic complexity.

We could simply count the flagged items in the queue and then update
that number as we add and remove items.  That would provide a general
speedup, but leave one case where we have to scan the whole queue: When
we flag a previously seen, but unflagged commit.  It could be on the
queue and then we'd have to decrease our count.

We could dedicate an object flag to track queue membership, but that
would leave less for candidate tags, affecting the results.  So use a
hash table, specifically a khash set of commit pointers, to track that.
This avoids quadratic behaviour in all cases and provides a nice
performance boost over the previous commit, 08bb69d70f (describe: use
prio_queue_replace(), 2025-08-03):

Benchmark 1: ./git_08bb69d70f describe $(git rev-list v2.41.0..v2.47.0)
  Time (mean =C2=B1 =CF=83):     851.7 ms =C2=B1   1.1 ms    [User: 788.7 =
ms, System: 49.2 ms]
  Range (min =E2=80=A6 max):   849.4 ms =E2=80=A6 852.8 ms    10 runs

Benchmark 2: ./git describe $(git rev-list v2.41.0..v2.47.0)
  Time (mean =C2=B1 =CF=83):     607.1 ms =C2=B1   0.9 ms    [User: 544.6 =
ms, System: 48.6 ms]
  Range (min =E2=80=A6 max):   606.1 ms =E2=80=A6 608.3 ms    10 runs

Summary
  ./git describe $(git rev-list v2.41.0..v2.47.0) ran
    1.40 =C2=B1 0.00 times faster than ./git_08bb69d70f describe $(git rev=
-list v2.41.0..v2.47.0)

Use the commit index value as a hash because it is unique, has the
right size and needs no computation.  We could also derive the hash
directly from the pointer value, but that requires slightly more effort.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/describe.c | 57 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 0540976210..edb4dec79d 100644
=2D-- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -24,6 +24,7 @@
 #include "commit-slab.h"
 #include "wildmatch.h"
 #include "prio-queue.h"
+#include "khash.h"
=20
 #define MAX_TAGS	(FLAG_BITS - 1)
 #define DEFAULT_CANDIDATES 10
@@ -286,38 +287,74 @@ static void lazy_queue_clear(struct lazy_queue *queu=
e)
 	queue->get_pending =3D false;
 }
=20
-static bool all_have_flag(const struct lazy_queue *queue, unsigned flag)
+static inline unsigned int commit_index(const struct commit *commit)
 {
-	for (size_t i =3D queue->get_pending ? 1 : 0; i < queue->queue.nr; i++) =
{
-		struct commit *commit =3D queue->queue.array[i].data;
-		if (!(commit->object.flags & flag))
-			return false;
-	}
-	return true;
+	return commit->index;
+}
+
+static inline int ptr_eq(const void *a, const void *b)
+{
+	return a =3D=3D b;
+}
+
+KHASH_INIT(commit_set, struct commit *, int, 0, commit_index, ptr_eq)
+
+static void commit_set_insert(kh_commit_set_t *set, struct commit *commit=
)
+{
+	int added;
+	kh_put_commit_set(set, commit, &added);
+}
+
+static void commit_set_remove(kh_commit_set_t *set, struct commit *commit=
)
+{
+	khiter_t pos =3D kh_get_commit_set(set, commit);
+	if (pos !=3D kh_end(set))
+		kh_del_commit_set(set, pos);
 }
=20
 static unsigned long finish_depth_computation(struct lazy_queue *queue,
 					      struct possible_tag *best)
 {
 	unsigned long seen_commits =3D 0;
+	kh_commit_set_t unflagged =3D { 0 };
+
+	for (size_t i =3D queue->get_pending ? 1 : 0; i < queue->queue.nr; i++) =
{
+		struct commit *commit =3D queue->queue.array[i].data;
+		if (!(commit->object.flags & best->flag_within))
+			commit_set_insert(&unflagged, commit);
+	}
+
 	while (!lazy_queue_empty(queue)) {
 		struct commit *c =3D lazy_queue_get(queue);
 		struct commit_list *parents =3D c->parents;
+
 		seen_commits++;
 		if (c->object.flags & best->flag_within) {
-			if (all_have_flag(queue, best->flag_within))
+			if (!kh_size(&unflagged))
 				break;
-		} else
+		} else {
+			commit_set_remove(&unflagged, c);
 			best->depth++;
+		}
 		while (parents) {
 			struct commit *p =3D parents->item;
+			unsigned seen, flag_before, flag_after;
+
 			repo_parse_commit(the_repository, p);
-			if (!(p->object.flags & SEEN))
+			seen =3D p->object.flags & SEEN;
+			if (!seen)
 				lazy_queue_put(queue, p);
+			flag_before =3D p->object.flags & best->flag_within;
 			p->object.flags |=3D c->object.flags;
+			flag_after =3D p->object.flags & best->flag_within;
+			if (!seen && !flag_after)
+				commit_set_insert(&unflagged, p);
+			if (seen && !flag_before && flag_after)
+				commit_set_remove(&unflagged, p);
 			parents =3D parents->next;
 		}
 	}
+	kh_release_commit_set(&unflagged);
 	return seen_commits;
 }
=20
=2D-=20
2.51.0
