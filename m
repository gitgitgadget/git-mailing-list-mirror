Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572EF2BAF7
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754221757; cv=none; b=AvrOHqDhm1uRZq52lZHmH2OjDZD96DDNClS7HvLW1AF17F8rszfvLnqU+w/ABlTI+xKeLROO9GdrUQ9c72AvA7Pp4jCN0WoMQQFFOhKT2dOZ4um0gozHYGwF6cOqHEUdbCX8NUX3iubAa/UCmGyHIFYFAvposN2yAnVB5nMOb/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754221757; c=relaxed/simple;
	bh=Vg5U7XdJIRZAE2FQ0345Fyo6yr2RB0cEDP2jD5+jYvo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=IdVTNcddhJbKdOa6+ohsPOGMnL+m6ouCQfMieSD8n9TESfk9fVQesrU37oVKJVV2LD3DbOY2PzEynka2Wovm0K/HjHHE9pgSYOoAZa6i1dl0dOTEMEJgarQTQOmaEfGwdZGRzFCJVIc6J76VbFk+es+S1MzxpkpmBuOm8YEKwJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ZjYXHHFa; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ZjYXHHFa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754221752; x=1754826552; i=l.s.r@web.de;
	bh=G4eJ/pYKvzsdKEe48GX7uPIi1M5iOWHBrDFzd3k3xxU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZjYXHHFaJYSPBOoicGTYHgaSbIr21Zje8cNbcy1Ke6C14vKyXF9ykt5i9we/Wjor
	 3gg/hOc0R0XEJxj58RTX6UnUmRLd6fCAEtOkTGOWIM0gkcIT4PUnv5OXuIHmrBXKs
	 Fj5aj+r/CycIJaQBAZE/83EHX0PWZ4l+fV8omao7nxUKaJsOWG5pMX9vqWjU6uCSG
	 79I21Y6j1DeY1GtUC5nPoC7WKiVxnCHzPENUxi9C8RWu/VGrIy+MYqCpnsZal1s+w
	 O3ANDgOl6UTzej0ZPFHfpkv/ERKDiO7sfQDkvwO8SiQh3as1wRKKBaxAJ8shbsf1c
	 oYCK4ZGSPWFWVpMoBw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2BM4-1uVyfG0wvu-00tQ26 for
 <git@vger.kernel.org>; Sun, 03 Aug 2025 13:49:12 +0200
Message-ID: <36d5b59a-a99a-4a6f-b637-dfb0b760660f@web.de>
Date: Sun, 3 Aug 2025 13:49:11 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] describe: use prio_queue_replace()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
References: <81c7deee-75e9-471a-84f3-8604c0860ee3@web.de>
Content-Language: en-US
In-Reply-To: <81c7deee-75e9-471a-84f3-8604c0860ee3@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TE03crwhDh7r3SQAyaZk0/MveZXrAp2Y7bv6xMxyEGr2YRJbd8g
 8237Q5o6lAbRCAXc9MS2TkSb4RbGaWJLj0jvUj/AYEUGDcM3d9f4dV0j4bb9kEIK2lEW2n4
 cB6OG0eiVgx1NBX8Uqd2CnhIpvvx9gqm+SMZz8Z2OG9dxMS+L25eoqY2wxufr9Qp9RYMFSk
 jaXcmjm8mj7X3Hf8Lu6IA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jis3sXNYq7M=;7pnFqHHsRbK3kRbUgGXLY/f9sQu
 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
 3NmY9QVhs1qd8FLQMtfPUO0=

Optimize the sequence get+put to peek+replace to avoid one unnecessary
heap rebalance.

Do that by tracking partial get operations in a prio_queue wrapper,
struct lazy_queue, and using wrapper functions that turn get into peek
and put into replace as needed.  This is simpler than tracking the
state explicitly in the calling code.

We get a nice speedup on top of the previous patch's conversion to
prio_queue:

Benchmark 1: ./git_2.50.1 describe $(git rev-list v2.41.0..v2.47.0)
  Time (mean =C2=B1 =CF=83):      1.559 s =C2=B1  0.002 s    [User: 1.493 =
s, System: 0.051 s]
  Range (min =E2=80=A6 max):    1.556 s =E2=80=A6  1.563 s    10 runs

Benchmark 2: ./git_describe_pq describe $(git rev-list v2.41.0..v2.47.0)
  Time (mean =C2=B1 =CF=83):      1.204 s =C2=B1  0.001 s    [User: 1.138 =
s, System: 0.051 s]
  Range (min =E2=80=A6 max):    1.202 s =E2=80=A6  1.205 s    10 runs

Benchmark 3: ./git describe $(git rev-list v2.41.0..v2.47.0)
  Time (mean =C2=B1 =CF=83):     850.9 ms =C2=B1   1.6 ms    [User: 786.6 =
ms, System: 49.8 ms]
  Range (min =E2=80=A6 max):   849.1 ms =E2=80=A6 854.1 ms    10 runs

Summary
  ./git describe $(git rev-list v2.41.0..v2.47.0) ran
    1.41 =C2=B1 0.00 times faster than ./git_describe_pq describe $(git re=
v-list v2.41.0..v2.47.0)
    1.83 =C2=B1 0.00 times faster than ./git_2.50.1 describe $(git rev-lis=
t v2.41.0..v2.47.0)

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
A more convincing showcase for that optimization than a79e3519d6
(commit: use prio_queue_replace() in pop_most_recent_commit(),
2025-07-18).

 builtin/describe.c | 68 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 16 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 80722ae0c0..c18e4b3e4b 100644
=2D-- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -250,22 +250,58 @@ static int compare_pt(const void *a_, const void *b_=
)
 	return 0;
 }
=20
-static bool all_have_flag(const struct prio_queue *queue, unsigned flag)
+struct lazy_queue {
+	struct prio_queue queue;
+	bool get_pending;
+};
+
+#define LAZY_QUEUE_INIT { { compare_commits_by_commit_date }, false }
+
+static void *lazy_queue_get(struct lazy_queue *queue)
+{
+	if (queue->get_pending)
+		prio_queue_get(&queue->queue);
+	else
+		queue->get_pending =3D true;
+	return prio_queue_peek(&queue->queue);
+}
+
+static void lazy_queue_put(struct lazy_queue *queue, void *thing)
+{
+	if (queue->get_pending)
+		prio_queue_replace(&queue->queue, thing);
+	else
+		prio_queue_put(&queue->queue, thing);
+	queue->get_pending =3D false;
+}
+
+static bool lazy_queue_empty(const struct lazy_queue *queue)
+{
+	return queue->queue.nr =3D=3D (queue->get_pending ? 1 : 0);
+}
+
+static void lazy_queue_clear(struct lazy_queue *queue)
+{
+	clear_prio_queue(&queue->queue);
+	queue->get_pending =3D false;
+}
+
+static bool all_have_flag(const struct lazy_queue *queue, unsigned flag)
 {
-	for (size_t i =3D 0; i < queue->nr; i++) {
-		struct commit *commit =3D queue->array[i].data;
+	for (size_t i =3D queue->get_pending ? 1 : 0; i < queue->queue.nr; i++) =
{
+		struct commit *commit =3D queue->queue.array[i].data;
 		if (!(commit->object.flags & flag))
 			return false;
 	}
 	return true;
 }
=20
-static unsigned long finish_depth_computation(struct prio_queue *queue,
+static unsigned long finish_depth_computation(struct lazy_queue *queue,
 					      struct possible_tag *best)
 {
 	unsigned long seen_commits =3D 0;
-	while (queue->nr) {
-		struct commit *c =3D prio_queue_get(queue);
+	while (!lazy_queue_empty(queue)) {
+		struct commit *c =3D lazy_queue_get(queue);
 		struct commit_list *parents =3D c->parents;
 		seen_commits++;
 		if (c->object.flags & best->flag_within) {
@@ -277,7 +313,7 @@ static unsigned long finish_depth_computation(struct p=
rio_queue *queue,
 			struct commit *p =3D parents->item;
 			repo_parse_commit(the_repository, p);
 			if (!(p->object.flags & SEEN))
-				prio_queue_put(queue, p);
+				lazy_queue_put(queue, p);
 			p->object.flags |=3D c->object.flags;
 			parents =3D parents->next;
 		}
@@ -319,7 +355,7 @@ static void append_suffix(int depth, const struct obje=
ct_id *oid, struct strbuf
 static void describe_commit(struct object_id *oid, struct strbuf *dst)
 {
 	struct commit *cmit, *gave_up_on =3D NULL;
-	struct prio_queue queue =3D { compare_commits_by_commit_date };
+	struct lazy_queue queue =3D LAZY_QUEUE_INIT;
 	struct commit_name *n;
 	struct possible_tag all_matches[MAX_TAGS];
 	unsigned int match_cnt =3D 0, annotated_cnt =3D 0, cur_match;
@@ -363,9 +399,9 @@ static void describe_commit(struct object_id *oid, str=
uct strbuf *dst)
 	}
=20
 	cmit->object.flags =3D SEEN;
-	prio_queue_put(&queue, cmit);
-	while (queue.nr) {
-		struct commit *c =3D prio_queue_get(&queue);
+	lazy_queue_put(&queue, cmit);
+	while (!lazy_queue_empty(&queue)) {
+		struct commit *c =3D lazy_queue_get(&queue);
 		struct commit_list *parents =3D c->parents;
 		struct commit_name **slot;
=20
@@ -399,7 +435,7 @@ static void describe_commit(struct object_id *oid, str=
uct strbuf *dst)
 				t->depth++;
 		}
 		/* Stop if last remaining path already covered by best candidate(s) */
-		if (annotated_cnt && !queue.nr) {
+		if (annotated_cnt && lazy_queue_empty(&queue)) {
 			int best_depth =3D INT_MAX;
 			unsigned best_within =3D 0;
 			for (cur_match =3D 0; cur_match < match_cnt; cur_match++) {
@@ -422,7 +458,7 @@ static void describe_commit(struct object_id *oid, str=
uct strbuf *dst)
 			struct commit *p =3D parents->item;
 			repo_parse_commit(the_repository, p);
 			if (!(p->object.flags & SEEN))
-				prio_queue_put(&queue, p);
+				lazy_queue_put(&queue, p);
 			p->object.flags |=3D c->object.flags;
 			parents =3D parents->next;
=20
@@ -437,7 +473,7 @@ static void describe_commit(struct object_id *oid, str=
uct strbuf *dst)
 			strbuf_add_unique_abbrev(dst, cmit_oid, abbrev);
 			if (suffix)
 				strbuf_addstr(dst, suffix);
-			clear_prio_queue(&queue);
+			lazy_queue_clear(&queue);
 			return;
 		}
 		if (unannotated_cnt)
@@ -453,11 +489,11 @@ static void describe_commit(struct object_id *oid, s=
truct strbuf *dst)
 	QSORT(all_matches, match_cnt, compare_pt);
=20
 	if (gave_up_on) {
-		prio_queue_put(&queue, gave_up_on);
+		lazy_queue_put(&queue, gave_up_on);
 		seen_commits--;
 	}
 	seen_commits +=3D finish_depth_computation(&queue, &all_matches[0]);
-	clear_prio_queue(&queue);
+	lazy_queue_clear(&queue);
=20
 	if (debug) {
 		static int label_width =3D -1;
=2D-=20
2.50.1
