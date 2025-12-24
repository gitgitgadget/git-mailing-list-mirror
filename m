Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124012DCF41
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766595817; cv=none; b=mjsRLAi7UimGbpcKy6NPg9prqyeQYPW4qI9l0gV7QFJvCPEHxLgwIs5DYXA7IHVRC0XTpEyZ7bCxyENdy4SY6n3S5mqQMBo/jjJxszHiIsZxOnefiwKbWfMrJXWDhnouFK0tTNC6lvqIZ1SOTol3t+7Rk9LncQrqe6oVVjaf/fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766595817; c=relaxed/simple;
	bh=Kuw3NzKVusmsGXLN/1ZzE7S5vajkT/Pel3Z4MX4CzoQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTkTdcpBhrJv6RpuFC7pOW3e8J1SWXDvueIKr937OB1R7e3r7AMjzUR/9rAAzpPAMCKfRet5+wPRLMY+VGlALtmtkqeRLuObWprbmRIP2dCBIpXTkz/Dutd7VBk+kPNVj30zya4fknOyWEfwwaHUXWflnkAlUYX432HAlp3AyKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=AaqyckXi; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="AaqyckXi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766595809; x=1767200609; i=l.s.r@web.de;
	bh=wmMxWSgnWur2TaU/cuUyGL4XBYxPySYsh3oUtna4c8M=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AaqyckXicFqNa0FI4hSARIAJRnZ3amZxXw91LNqWFV1W3nra1q70RR4NJHZLoyNv
	 /Sp5vxmwUnVVNJ+xbMC5uqBHUDbOIWDTGj/rS4vdNeOm+zWZn3Bv9v+jEibv6oZpo
	 E3YYya+HrQ/M054OpTw5nlkTzU7YzV7p1EvUnnIGGXvpkdVcjJBwfmUJn/QpfeJEa
	 hiYpyx08wfwmuA27E3lfcLKiCrkZkhy0JCj+M8wOLP+Ux2k47e7NmNe1TLKy9Xu/U
	 bJjSFpqJJ4xkRP/u2DFZvABVTJd0Y+axSEb4BhdKjUYavgqhpLzXzItWb22bfNsjH
	 6WrWkCnoaMsHTKhN0g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.30.2]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MEUSE-1vk0zL37sY-00HTK5 for <git@vger.kernel.org>; Wed, 24 Dec 2025 18:03:29
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 14/14] commit-reach: use commit_stack
Date: Wed, 24 Dec 2025 18:03:27 +0100
Message-ID: <20251224170327.68049-15-l.s.r@web.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224170327.68049-1-l.s.r@web.de>
References: <20251224170327.68049-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fjCQXt5MFXcxwakNeoDXk6ydjrVmSp2Rv01z/pUlrUfClX7aLOM
 p9GBwOHwR5Fx4LCfmWbxkTVAC2tskX2ta/ql1Gx1JzgHWsM3At8jh4reFHeq6J2ETDuQp/I
 EXWV/pkKuhoWdwomAKK6AFIYtkzIrZeEfPNlG779+gi9njBNKbBpV3jUZkNQlcoWVRpc5wY
 RhA9B2A2R+HqmZtg9BRbg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+cFUuYdi9Rw=;n5xD52oOEcHxsHhYEF3/9L+reKV
 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
 OnYds9MsuJwkjweMzY9zxyV0rU=

Use commit_stack instead of open-coding it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 commit-reach.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index cc18c86d3b..e7d9b3208f 100644
=2D-- a/commit-reach.c
+++ b/commit-reach.c
@@ -283,8 +283,8 @@ static int remove_redundant_with_gen(struct repository=
 *r,
 {
 	size_t i, count_non_stale =3D 0, count_still_independent =3D cnt;
 	timestamp_t min_generation =3D GENERATION_NUMBER_INFINITY;
-	struct commit **walk_start, **sorted;
-	size_t walk_start_nr =3D 0, walk_start_alloc =3D cnt;
+	struct commit **sorted;
+	struct commit_stack walk_start =3D COMMIT_STACK_INIT;
 	size_t min_gen_pos =3D 0;
=20
 	/*
@@ -298,7 +298,7 @@ static int remove_redundant_with_gen(struct repository=
 *r,
 	QSORT(sorted, cnt, compare_commits_by_gen);
 	min_generation =3D commit_graph_generation(sorted[0]);
=20
-	ALLOC_ARRAY(walk_start, walk_start_alloc);
+	commit_stack_grow(&walk_start, cnt);
=20
 	/* Mark all parents of the input as STALE */
 	for (i =3D 0; i < cnt; i++) {
@@ -312,18 +312,17 @@ static int remove_redundant_with_gen(struct reposito=
ry *r,
 			repo_parse_commit(r, parents->item);
 			if (!(parents->item->object.flags & STALE)) {
 				parents->item->object.flags |=3D STALE;
-				ALLOC_GROW(walk_start, walk_start_nr + 1, walk_start_alloc);
-				walk_start[walk_start_nr++] =3D parents->item;
+				commit_stack_push(&walk_start, parents->item);
 			}
 			parents =3D parents->next;
 		}
 	}
=20
-	QSORT(walk_start, walk_start_nr, compare_commits_by_gen);
+	QSORT(walk_start.items, walk_start.nr, compare_commits_by_gen);
=20
 	/* remove STALE bit for now to allow walking through parents */
-	for (i =3D 0; i < walk_start_nr; i++)
-		walk_start[i]->object.flags &=3D ~STALE;
+	for (i =3D 0; i < walk_start.nr; i++)
+		walk_start.items[i]->object.flags &=3D ~STALE;
=20
 	/*
 	 * Start walking from the highest generation. Hopefully, it will
@@ -331,12 +330,12 @@ static int remove_redundant_with_gen(struct reposito=
ry *r,
 	 * terminate early. Otherwise, we will do the same amount of work
 	 * as before.
 	 */
-	for (i =3D walk_start_nr; i && count_still_independent > 1; i--) {
+	for (i =3D walk_start.nr; i && count_still_independent > 1; i--) {
 		/* push the STALE bits up to min generation */
 		struct commit_list *stack =3D NULL;
=20
-		commit_list_insert(walk_start[i - 1], &stack);
-		walk_start[i - 1]->object.flags |=3D STALE;
+		commit_list_insert(walk_start.items[i - 1], &stack);
+		walk_start.items[i - 1]->object.flags |=3D STALE;
=20
 		while (stack) {
 			struct commit_list *parents;
@@ -390,8 +389,8 @@ static int remove_redundant_with_gen(struct repository=
 *r,
 	}
=20
 	/* clear marks */
-	clear_commit_marks_many(walk_start_nr, walk_start, STALE);
-	free(walk_start);
+	clear_commit_marks_many(walk_start.nr, walk_start.items, STALE);
+	commit_stack_clear(&walk_start);
=20
 	*dedup_cnt =3D count_non_stale;
 	return 0;
=2D-=20
2.52.0

