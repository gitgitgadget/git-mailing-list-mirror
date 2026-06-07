Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA979175A62
	for <git@vger.kernel.org>; Sun,  7 Jun 2026 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780817449; cv=none; b=pW6oT1jsx0dxoQgwqiawyc6lUmI9h39PmlVgyBn460IXptts5IWnwZ5jQ5DhzyG6GJTQte1tUhyD/r2wrlX/t+Yxkm5ySEvcfJFSOaDZyWQ/qyP2taokk3Lf2uknhHjcl60SEOv6lMLnT86b3npXsp918uPsmFptHCVWF3ifNYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780817449; c=relaxed/simple;
	bh=XpjEe4LrMEywy5KZ6WdHir/mytrtsuPwOFkhp1+bY/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mP54Es+Rs/rkbjIDlpK30QtcN85jcdtaPTCvs2xPcCvLA+JT8DXOYDK0QWn7mk83xFAmhRily5Lg6Dtyr3Ec3s/bI4u0bP8KdQaQJtqti8LUhx7u9oajvbchRbtmVepn9xDp+le++CrSjftvP9leZjIj2dGshgpOawS2uUj9Ivw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=LYH4d8+P; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="LYH4d8+P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1780817440; x=1781422240; i=l.s.r@web.de;
	bh=k7M+mwHifj+t2SZ7WCxGPnCAR5Vzd3+/Gcs6gQkCtoU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LYH4d8+PxlXoj4Vp5JfvuPTCxaZLpJEKWOBXrsXAOPnZqGfUqGJcpHk/QEUOXOXG
	 mD9yVHmE1zLlVpy/UwXyM31NcsSQbkAWuAced6hm43nOuzmhGnr9V+TKd9y6+FswT
	 +AQiVrBRzVRDzp3UxXWTwSWhMQ8lhYPjg8ujm91cAg6IrR8YoNt/m657zocSYMGeR
	 klF7W2i7MRli4PUeUqOdg9QZXy2F5nsMMlhJLp1tJYrQudSFJDhV/0vaXr6gjXQs6
	 CzxsmJKSJPBb7Ojwj0LLs3BKDa4pnytXNNXV6pD/8EoRmrk0mOJNoeO7qBLZBJ+DG
	 L9KW52XKX389fUBYXg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5lnT-1xLDJk49b1-016GS4; Sun, 07
 Jun 2026 09:30:40 +0200
Message-ID: <1aa5b755-0f74-46d5-bd6e-a9cb7f3fbb12@web.de>
Date: Sun, 7 Jun 2026 09:30:39 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] prio-queue: use cascade-down for faster extract-min
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2132.git.1780250236304.gitgitgadget@gmail.com>
 <pull.2132.v2.git.1780301856444.gitgitgadget@gmail.com>
 <90270818-c52b-4611-8da2-6cee20628fc2@web.de>
 <CAL71e4Ob-B5MJ5DPY+_tzpj6nyrbQ5WutxED2T93SWJV6kJGPA@mail.gmail.com>
 <CAL71e4PV-1aDvn1JnweMa3OR1xxB75fWjzJOBvM54KOWqC0stw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAL71e4PV-1aDvn1JnweMa3OR1xxB75fWjzJOBvM54KOWqC0stw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LR5dy0GD6FhIdF7Njz/6QgyWrlisGdacXzln6H4rsqbBcktKenM
 qKuJlQrmZz7elpKF5+/pj5UPBAPIcW/Rl4+R8/apDjH8ruvAvAB4s4l2rLR7L5W/y66WJdY
 7KVyMT9iUnlaq87dfNx09uZShu7p5c9G7EUGhqY3pE+qwQLO999HCdcTtlVlgtOJxDKMp2x
 nCBbXoKHkEgW5lSA69X1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0w8zK4+C25A=;NpV46P0B0jmVMoW37yVlkpFlTw8
 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
 bY6LQwD+os+qcdFcxYARw/VCfHg=

On 6/5/26 10:39 PM, Kristofer Karlsson wrote:
> I did some more benchmarking to understand how these approaches
> interact, with four variants based on origin/next on my large monorepo:
>=20
>   1. base: next as-is
>   2. cascade: base + sift_up_rebalance from this patch (v2)
>   3. lazy-fold: base + lazy get fusion folded into prio_queue
>   4. cascade+lazy: both combined
>=20
> Note that alt 3 is not yet shared with the mailing list so it's hard for=
 you
> to reason about it, though it's quite straightforward. I will submit a n=
ew
> patch for that one soon, not necessarily with the primary goal to merge =
it,
> but rather show how it is implemented.
>=20
>   merge-base --all master master~1000:
>     base            4.27s
>     cascade         4.07s  (1.05x)
>     lazy-fold       4.12s  (1.03x)
>     cascade+lazy    4.01s  (1.06x)
>=20
>   rev-list --count master~1000..master:
>     base            3.60s
>     cascade         3.35s  (1.08x)
>     lazy-fold       3.37s  (1.07x)
>     cascade+lazy    3.30s  (1.09x)
>=20
> So both optimizations are valuable both on their own, and when combined,
> which I think helps to reason about it. This cascading sift seems to hav=
e a
> larger effect, but folding lazy_queue into prio_queue also speeds up oth=
er
> use cases and simplifies the code a bit.
Right.  I was wondering, though: Why is sift-down so much faster than
cascade in the describe benchmark from 30598ccc4d (describe: use oidset
in finish_depth_computation(), 2025-09-02)?

I think I mostly understand it now: cascade is better in prio_queue_get()
because the sift-down item is from the bottom and will likely end up back
at the bottom, just of a different branch of the heap.  Thus a sift-down
costs 3 compares times the number of levels, while a cascade costs just
2 compares times the number of levels and there is likely little to no
need to sift it back up.

For prio_queue_replace() we sift down a random item, though; we don't
know where it will end up.  If it belongs at the very top then sift-down
just needs 3 compares, while cascade needs 2 compares times the number
of levels to bring the hole down and the same to bring the item up.

Below is a diff on top of your second cascade patch to use sift-down
only for the root and cascade otherwise.  It comes remarkably close to
the performance of a full sift-down.  I don't know how to find the
optimal number of levels to try sift-down before switching to cascade
for a given random item, though.

So I guess we keep the full sift-down for prio_queue_replace(), knowing
that sometimes we have a lot of items that end up at or close to the
root of the heap.

Benchmark 1: ./git_main describe $(git rev-list v2.41.0..v2.47.0)
  Time (mean =C2=B1 =CF=83):     602.4 ms =C2=B1   1.2 ms    [User: 539.2 =
ms, System: 47.7 ms]
  Range (min =E2=80=A6 max):   600.5 ms =E2=80=A6 604.7 ms    10 runs

Benchmark 2: ./git_cascade1 describe $(git rev-list v2.41.0..v2.47.0)
  Time (mean =C2=B1 =CF=83):     993.9 ms =C2=B1   1.7 ms    [User: 930.2 =
ms, System: 48.2 ms]
  Range (min =E2=80=A6 max):   991.1 ms =E2=80=A6 996.6 ms    10 runs

Benchmark 3: ./git_cascade2 describe $(git rev-list v2.41.0..v2.47.0)
  Time (mean =C2=B1 =CF=83):     602.4 ms =C2=B1   1.7 ms    [User: 539.1 =
ms, System: 47.6 ms]
  Range (min =E2=80=A6 max):   599.9 ms =E2=80=A6 606.2 ms    10 runs

Benchmark 4: ./git describe $(git rev-list v2.41.0..v2.47.0)
  Time (mean =C2=B1 =CF=83):     625.4 ms =C2=B1   1.7 ms    [User: 561.8 =
ms, System: 48.0 ms]
  Range (min =E2=80=A6 max):   623.4 ms =E2=80=A6 627.9 ms    10 runs

Summary
  ./git_main describe $(git rev-list v2.41.0..v2.47.0) ran
    1.00 =C2=B1 0.00 times faster than ./git_cascade2 describe $(git rev-l=
ist v2.41.0..v2.47.0)
    1.04 =C2=B1 0.00 times faster than ./git describe $(git rev-list v2.41=
.0..v2.47.0)
    1.65 =C2=B1 0.00 times faster than ./git_cascade1 describe $(git rev-l=
ist v2.41.0..v2.47.0)

git_main and git_cascade2 (your v2): sift-down
git_cascade1 (your v1): cascade
git (your v2 and the patch below): sift-down for root then cascade

Ren=C3=A9


diff --git a/prio-queue.c b/prio-queue.c
index 66d445b078..4d7debc2ba 100644
=2D-- a/prio-queue.c
+++ b/prio-queue.c
@@ -58,30 +58,12 @@ void prio_queue_put(struct prio_queue *queue, void *th=
ing)
 	}
 }
=20
-static void sift_down_root(struct prio_queue *queue)
+static void sift_up_rebalance(struct prio_queue *queue, size_t ix)
 {
-	size_t ix, child;
-
-	/* Push down the one at the root */
-	for (ix =3D 0; ix * 2 + 1 < queue->nr; ix =3D child) {
-		child =3D ix * 2 + 1; /* left */
-		if (child + 1 < queue->nr &&
-		    compare(queue, child, child + 1) >=3D 0)
-			child++; /* use right child */
-
-		if (compare(queue, ix, child) <=3D 0)
-			break;
-
-		swap(queue, child, ix);
-	}
-}
-
-static void sift_up_rebalance(struct prio_queue *queue)
-{
-	size_t ix, child;
+	size_t child;
=20
 	/* Cascade: promote smaller child at each level. */
-	for (ix =3D 0; (child =3D ix * 2 + 1) < queue->nr; ix =3D child) {
+	for (; (child =3D ix * 2 + 1) < queue->nr; ix =3D child) {
 		if (child + 1 < queue->nr &&
 		    compare(queue, child, child + 1) >=3D 0)
 			child++;
@@ -112,7 +94,7 @@ void *prio_queue_get(struct prio_queue *queue)
 	if (!--queue->nr)
 		return result;
=20
-	sift_up_rebalance(queue);
+	sift_up_rebalance(queue, 0);
 	return result;
 }
=20
@@ -132,9 +114,20 @@ void prio_queue_replace(struct prio_queue *queue, voi=
d *thing)
 	} else if (!queue->compare) {
 		queue->array[queue->nr - 1].ctr =3D queue->insertion_ctr++;
 		queue->array[queue->nr - 1].data =3D thing;
+	} else if (queue->nr < 3) {
+		prio_queue_get(queue);
+		prio_queue_put(queue, thing);
 	} else {
-		queue->array[0].ctr =3D queue->insertion_ctr++;
+		size_t child =3D compare(queue, 1, 2) <=3D 0 ? 1 : 2;
+		queue->array[0].ctr =3D queue->insertion_ctr;
 		queue->array[0].data =3D thing;
-		sift_down_root(queue);
+		if (compare(queue, 0, child) <=3D 0) {
+			queue->insertion_ctr++;
+		} else {
+			queue->array[0] =3D queue->array[child];
+			queue->nr--;
+			sift_up_rebalance(queue, child);
+			prio_queue_put(queue, thing);
+		}
 	}
 }

