Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4D134AAE1
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756837497; cv=none; b=gaKWULMQNLihm0znNa3XVH059wLzLul47FCph8FjuzVwbr/FW+Bpjvjhm5vmeUpn6oxJbRgZvTXktcWzNCrTYOu1O8Sm8C8xcTQm8YZEdpObPjwQZ1AWLjE5iwLHLb+FlRxxNSO+MmeZeZNitrF9Sets/CYLdXIHFdrgGx8uQcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756837497; c=relaxed/simple;
	bh=KK5bvMNOnG+1j2FaFpvykPWxQQHy25E/uySx6J3FWb8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=graMnv9pzbd4WoUeFuoV94Q/UN72CGh6d1M+OjGpOrpAPsiRAHZtl1CPgFevgyuupnprrOnmefcwmM2r8/0lx05hgtd01V6CtMAMztvkPBnxccE5mrYiQ7QRhmSR3HomVqPor7OKTq0/SlxBNQS9rjZU9UJZqRSjTXm+IxVcJIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=q88DO1h8; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="q88DO1h8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756837492; x=1757442292; i=l.s.r@web.de;
	bh=ir6v/htP1LB4kbDjsEjUZqmfEvhfWDYkqIGK+ccL07k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=q88DO1h8WSyvxvXCRdteCmR9bcDo7n3UmfPDMLoQmwReFpsd9WaEZkmDmqW5qrKF
	 Aa2znDi8r7wtIWyR0lgFZ0p2ukys3lF5w0sdDlaWNsiwosvn5M19aMHzXAFA3eQ3Z
	 RdYFQSOrUsq3pLmDtkiW6Y6iIeCvR17iLsE33cazgVdpMiAyWY/Awq5m1JjaWGcpD
	 uRznagkH1C6N3ZQuUNRrFsDo3JqhfdZQnOqz19wS1q7dKXPPLnH6EUgVWwM0kzl7X
	 mRw2bgYGNUdx27aCfPiUooHYbCeqapwTuKkQzHNfWvrhWx89cPk6m6K6Jn3H1hOUv
	 cqLb65JPCCOvHQ8K/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.159.98]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMp8K-1vA4bA26se-00S8u1; Tue, 02
 Sep 2025 20:24:52 +0200
Message-ID: <b16aa099-b683-4a66-acd9-603cc9f0935c@web.de>
Date: Tue, 2 Sep 2025 20:24:52 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] describe: use oidset in finish_depth_computation()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
References: <9110f085-aec0-42e9-9774-b153ece6284f@web.de>
Content-Language: en-US
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
In-Reply-To: <9110f085-aec0-42e9-9774-b153ece6284f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bwk/Jn/D+gnaunHgP2O5bq2ynyXg2BwueLEiaCKrj6e8qaMnPjd
 Ix3u2Kc+1HrQprdn1EDcJgfJVmHCTYp54SiMu6YYSdIhtqAv4Jac1i9aqHdlzKyC+mdMKl1
 9lsEGK4EoQ5kUuqMUoaw7RWqZtm8TgJL8Z0dytPXdKNQn7tB4KPh7CDNFJwkd1G9UA9z3vj
 /dSFJ+Zu1xp0Lcb8tsTaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jHM6Rf2vCtM=;+S8KGiDUgFskRdcv0+Ls8E7Fsmm
 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
 FcX+hVUuITpkT5TcZ0wA980tFsI/JHmg==

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
hash table, specifically an oidset of commit hashes, to track that.
This avoids quadratic behaviour in all cases and provides a nice
performance boost over the previous commit, 08bb69d70f (describe: use
prio_queue_replace(), 2025-08-03):

Benchmark 1: ./git_08bb69d70f describe $(git rev-list v2.41.0..v2.47.0)
  Time (mean =C2=B1 =CF=83):     855.3 ms =C2=B1   1.3 ms    [User: 790.8 =
ms, System: 49.9 ms]
  Range (min =E2=80=A6 max):   853.7 ms =E2=80=A6 857.8 ms    10 runs

Benchmark 2: ./git describe $(git rev-list v2.41.0..v2.47.0)
  Time (mean =C2=B1 =CF=83):     610.8 ms =C2=B1   1.7 ms    [User: 546.9 =
ms, System: 49.3 ms]
  Range (min =E2=80=A6 max):   608.9 ms =E2=80=A6 613.3 ms    10 runs

Summary
  ./git describe $(git rev-list v2.41.0..v2.47.0) ran
    1.40 =C2=B1 0.00 times faster than ./git_08bb69d70f describe $(git rev=
-list v2.41.0..v2.47.0)

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes:
- Use oidset instead of a custom khash set for simplicity.
- Removed spurious whitespace changes.
- Formatted with --patience to better see the function removal.

 builtin/describe.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index fbe78ace66..9f4e26d7ff 100644
=2D-- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -24,6 +24,7 @@
 #include "commit-slab.h"
 #include "wildmatch.h"
 #include "prio-queue.h"
+#include "oidset.h"
=20
 #define MAX_TAGS	(FLAG_BITS - 1)
 #define DEFAULT_CANDIDATES 10
@@ -286,38 +287,47 @@ static void lazy_queue_clear(struct lazy_queue *queu=
e)
 	queue->get_pending =3D false;
 }
=20
-static bool all_have_flag(const struct lazy_queue *queue, unsigned flag)
-{
-	for (size_t i =3D queue->get_pending ? 1 : 0; i < queue->queue.nr; i++) =
{
-		struct commit *commit =3D queue->queue.array[i].data;
-		if (!(commit->object.flags & flag))
-			return false;
-	}
-	return true;
-}
-
 static unsigned long finish_depth_computation(struct lazy_queue *queue,
 					      struct possible_tag *best)
 {
 	unsigned long seen_commits =3D 0;
+	struct oidset unflagged =3D OIDSET_INIT;
+
+	for (size_t i =3D queue->get_pending ? 1 : 0; i < queue->queue.nr; i++) =
{
+		struct commit *commit =3D queue->queue.array[i].data;
+		if (!(commit->object.flags & best->flag_within))
+			oidset_insert(&unflagged, &commit->object.oid);
+	}
+
 	while (!lazy_queue_empty(queue)) {
 		struct commit *c =3D lazy_queue_get(queue);
 		struct commit_list *parents =3D c->parents;
 		seen_commits++;
 		if (c->object.flags & best->flag_within) {
-			if (all_have_flag(queue, best->flag_within))
+			if (!oidset_size(&unflagged))
 				break;
-		} else
+		} else {
+			oidset_remove(&unflagged, &c->object.oid);
 			best->depth++;
+		}
 		while (parents) {
+			unsigned seen, flag_before, flag_after;
 			struct commit *p =3D parents->item;
 			repo_parse_commit(the_repository, p);
-			if (!(p->object.flags & SEEN))
+			seen =3D p->object.flags & SEEN;
+			if (!seen)
 				lazy_queue_put(queue, p);
+			flag_before =3D p->object.flags & best->flag_within;
 			p->object.flags |=3D c->object.flags;
+			flag_after =3D p->object.flags & best->flag_within;
+			if (!seen && !flag_after)
+				oidset_insert(&unflagged, &p->object.oid);
+			if (seen && !flag_before && flag_after)
+				oidset_remove(&unflagged, &p->object.oid);
 			parents =3D parents->next;
 		}
 	}
+	oidset_clear(&unflagged);
 	return seen_commits;
 }
=20
=2D-=20
2.51.0
