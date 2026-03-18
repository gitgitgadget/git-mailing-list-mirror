Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CFA3D6CA1
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837927; cv=none; b=lCH6uTNZRPl2FCYd6GGEGnbwqO9cyaproVmnlYpwxC6D2w5noB1QjcFanwjJlS0BTux1UYbTIZXjlylooBHEoIK18jrNemAKkffHMERyEYV1LdfhYkmTCQJ/FI0hVjKFmVHx+3iXOWHbg9bCQP+ew6bzXAQxlYWWj3Dra+OIcFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837927; c=relaxed/simple;
	bh=i+gaFcsolfgNwFB5IzS8ZeREMUkdPWnoIJs/wVb3qeI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=lh03rzqd/jB3B+5F7T2tooEkfppghQqUeIqE6Rwj6erWUwXbHDjQLz7iqN4Qc+59Uxv+QVZapbv2GU3Po75+zGC9vwGK3XPrnU9vjufgwdZ21GGX5kPDp36vsLKNhhigRHg7dKdjfhrX8bmOIGG+++nsA9XbgBamijhU2t4sJRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=oSQTVxYG; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="oSQTVxYG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773837915; x=1774442715; i=l.s.r@web.de;
	bh=tZwqYHmCt1gakhnAS4jBGiUSFeMy9CVhuzvNfUoIn5E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oSQTVxYGqHzi+F0m2t3APQ2Vccpzo2+OJa0s3x3lWXJWxsFOQjMpZdtDBn6FuJ5f
	 WLeaVUOq2CKsFhKMKaaofqlXmkZBRXuYap3MGiVaIiEPjFJBCVBcEeHyOX5t34l/M
	 nnpjtm5ODGKmhUfUVb0qhUGi2gVS5ofqOBQFRa1jJP4+JjbSRBAn1qRP/9yL1JmlV
	 WkR5+gq8K4v9PJ7YPcqPu0Kkyjx8ZdjQlW4uPL9+aOcbxoVMii+woqdJEK7m0E1ul
	 FzK3Qkvdc6xOTYWuxTtMgzxSEXecBSmrB5uccjNfHBoGoBAN7x4C1b1tT3FpcX6CA
	 uuoILxyWQpoMOq6W8w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MaHWx-1w8hPq2zy9-00SCWc; Wed, 18
 Mar 2026 13:45:15 +0100
Message-ID: <06000e28-c1b1-472f-bd6b-367b6c8d208d@web.de>
Date: Wed, 18 Mar 2026 13:45:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] commit-reach: simplify cleanup of remaining bitmaps in
 ahead_behind()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZrRQVisc8bx6VeCJIfplVjhpr9ilJGloJW//flomlznaSnNXg5u
 8ensHW8L+wjCsZA32CJVY9bHFDnc0GAf0u/F4t3xv6QeOVr3BcB7SCenE9ar3B2ZspsHkQU
 W4tuvLFV+26Dh0kmU4R4BaKlFWzlZQSN+OaCTi/hH8gk+QLTqteSa2kk/ooyFm2q7+JV0Zx
 uuEXvdOZlh3Mc1f5IAMXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vgSnrsbP5GI=;y0RcEz0GeuniJ9LRfqaWYYPR7sb
 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

Use the deep clear function of the bit_arrays commit slab to free
bitmaps of commits we didn't traverse.  We don't care about their order
anymore at this point, so we can bypass the prio_queue and its heap
rebalancing logic.  Note that bitmap_free() handles NULL pointers, so we
don't have to check.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 commit-reach.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 9604bbdcce..a4fc41ff40 100644
=2D-- a/commit-reach.c
+++ b/commit-reach.c
@@ -1047,6 +1047,11 @@ static void free_bit_array(struct commit *c)
 	*bitmap =3D NULL;
 }
=20
+static void free_bitmap_pointer(struct bitmap **bitmap)
+{
+	bitmap_free(*bitmap);
+}
+
 void ahead_behind(struct repository *r,
 		  struct commit **commits, size_t commits_nr,
 		  struct ahead_behind_count *counts, size_t counts_nr)
@@ -1117,11 +1122,7 @@ void ahead_behind(struct repository *r,
=20
 	/* STALE is used here, PARENT2 is used by insert_no_dup(). */
 	repo_clear_commit_marks(r, PARENT2 | STALE);
-	while (prio_queue_peek(&queue)) {
-		struct commit *c =3D prio_queue_get(&queue);
-		free_bit_array(c);
-	}
-	clear_bit_arrays(&bit_arrays);
+	deep_clear_bit_arrays(&bit_arrays, free_bitmap_pointer);
 	clear_prio_queue(&queue);
 }
=20
=2D-=20
2.53.0
