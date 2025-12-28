Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AB723A58F
	for <git@vger.kernel.org>; Sun, 28 Dec 2025 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766945462; cv=none; b=sCGoqiV0tKIMCv8FiqaP4/I9Kp4Av9ZhpG6U9S3v0XrIFhqD0yxdzzvxTHFnx7/CzS/7myD+IJB8Cuw1T1gyzGFnP5KFp/EnEn/igRvwzh0WzI+0ebC2y0QakUVSCoEju4xvi2xuo1o5MxDhQ/M02loCalK7UvH0h6X3DqZ3Saw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766945462; c=relaxed/simple;
	bh=38Z/E6B4aVqtfaHAS5IndFk9jewa/NrLQgG1LOi6LHA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHm6Zw8/skNyBuTUcI0rChbkaJDyXcLoOrFTAwZDBGeLM8OzjW10v+COD8PVdQIbGkFIWzsfGPhvib9kCcslTAvKTDkG6x9rT1wI7q1fpeVY53gSyfLeLt53gztrfvscLdLcWArLjyQeFFNsxHz2gM5tY7Q2Q7pqa2hHwGfZyrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=eHz/+wq+; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="eHz/+wq+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766945452; x=1767550252; i=l.s.r@web.de;
	bh=8p/3fcPvSHwUsko9rxKcpoxQjBnyD2VDTv3nJe+JwZo=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eHz/+wq+T3cuvbHhZxf+Ch25FKweCHxemM3hpqpIte+1mM6ecC+2h5dkEsqmJrrn
	 ZxJaSY9p1goTnZW/IeKggEPIolo9r/nd6DxS3CXAcDT0h7yq9VOtDQ42CQh5SBNNd
	 5NWsYaW7GiUpNVlRie5Wu5zACZlAO93jvPJDwy306EpRZkD0kRfauVCeIa1GLjXZ8
	 +JSQAGNYxEkc7l2u8kFvwEZFCdToewzOn2neWlh0uaxWBYIHwtcTfl08106DTkDH1
	 lB8jBfWv9ztoH8k3ePgrJ4gcaAo1iFXSL0Bd+tDz2Pbqjdw/V1kAkwoprEi8lZaqY
	 S90TfmZiJWUKSYyEaw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.18.156]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1M6YNJ-1vXRK63lUn-007snk for <git@vger.kernel.org>; Sun, 28 Dec 2025 19:10:51
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 3/4] tag: support arbitrary repositories in parse_tag()
Date: Sun, 28 Dec 2025 19:10:50 +0100
Message-ID: <20251228181051.68724-4-l.s.r@web.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251228181051.68724-1-l.s.r@web.de>
References: <20251228181051.68724-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MRxkCc7zwnrDtDGG1Hemhs+ZMSSZNvRLwnbKUdl2frV5NLvCwMu
 xX9tcXRkMZodCH7K4ERgMxwi8x28vSquJy8sTjh0l/rNgDNwQ/4G/kDW+OJjDKFMYn9Jy5M
 Fbkv0w0DiKnYrKHNman82i1L9wPvrMdJdpJnNi9Vn9a4LuFjg3EIGD3kjjwRgXN9Rn4sB13
 48zg4P0uVql9EmXEuilBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d8yN7XATvrM=;GPahKYikGh6lvWZAyk3kizZKB2N
 Gzx65co65iqtc2dXAy48k2BzEXaa1wUiyFMCnJju/aDQ2aXJ+cxCIGyt7je4ec/kIOVfQh/ob
 Xd4+V03ug2MK6+QoKvlA485f4xzlGdCqDzRlMdgEQ7ZHQvKNFDjTKfgRgvH5ecCN5wIcCZAZV
 AF6M7sUqhCrqeNDFp4M/la78s/nO41ljL2NrsLhVGSLz9CzEdqnRx2ZnkNsRdNh/to4HNGOzM
 x9NxwBp0vtUQ+OBbnUplI7j4f5vyxaJeZWmqA3qCjtf5nNqJNBWFbxvvvTOHMZdObl7gkTmOx
 XpVXDEc4rJmD/K++PF7JJviY/lOXzMGpXTe+W36/w6kmvOvZwsplPjghQi21Axqt6KJsoIhHe
 a8CbmTimnLU+zdN9K3+53aU/lp8bf5oWAges+Dm7v0oXtvCN+BgzSTYjyhPLZIL7sVn5Uh7sL
 gur6r0VGEnH5gAcNb+/3WHjxAkkt+OQf0tx0yadIAvx9RiQnonMqlftKfBzvA3vW973lJa9U+
 USeW6zu26YuSQQ4WRoUuQSJNdc7fVObJLItVeqjh7U8KM2wMYbjThP2zdZ2KreON+Xvwd7VkA
 m6lrODYF8XjCLz3hmFg/lUngglNnjRWTES8RVtob7Z6ukzqQ0wUOfWMomysFv/fufOuLq1b/w
 IARR8ig/zCQ+EK4s7bFj7LmX71rTW9sh0/l+jbltJkfJbfQfeT74IP2AM614Bd/wlijP0vO9P
 LKENKGZgrgEG9PAcvGrHq7/Z3JwzESdDTJh4cxx6xYSgZZT9xt7s6+065NEZ+/sBEUXFYPN1G
 +cA893sfk1cMZQmX287UWbnyl6z14hodoHFkKrjpAPHlhNIPREF5mgwvStBumOnpP1qjf4O4e
 SNA92Ho/0vt/hRgUhvSH1NTrJwQuzZC86B3rLCQxbyw+Z9UzIJrzdaZyu9SjPAx3hQ+6nc1ed
 Z/VVxPfu9RxPSrSo/wHz7hTeVdLimnf9cMLJdll+Osnbx3yMKS0yFAOHoY8VIXzGuU/NR8sS1
 /1pVKXtcEq/NqYG8engv/3LValLs+dUgY/e17nvu313h3Qhhjzk28dqsm4fOeVvJOC7aVG0d2
 XqoZw9Mwil8z8i5q4WOp1dtIVQhHLspU4xyzoyNKFcN69gODv5XWgbiiHVIE1W1ZpVNSmPtvN
 lIIBwTZRRAfzn2E+IPPaIj4Om/DBcfbIAqG9g5K97rTAOQFrJ6iUk5K43XKvA27lwIpXFaT5E
 y55SW5eXlm21Z0RDXVdn3Z/Sg6kpuvkaXQ2y6SxE3KBTLodEOPPFfehJme4Lbh1UhYq0AvogG
 OW3rAGKdqxjSRGUw3xkH4Cgoj6zkug/yv2AHktQIdOe8+d2tDZkZHi9UhsuBKqdmdNceg1lBC
 tQiIEeFOFaVd3wrrwdQFq7QWw8mFtdHtMo+MkTMwFKTl91A9xmB3A/aaULu+EqL72DmitkLlI
 aSkMi1kgjpv1RATrhjLSUtc8Sgf2G3PyA6ChxMw9cMbjzIARZgi4mZ2KCDSlEGW+y22mSBthD
 n2fbnowxEA8WphSE7PMp1/pA7tY/kjFhVQ3KoV+7SMlaDRfY7RNl8BeZC0aDYdIGfjYwMz8rx
 GNWXrNonM2iB8wIkxFLI8mIws+h6SgqewBl7m++ZAaL/UZMFIreFLa4ailHPjhtKX3VF2GOEX
 eAS8iIvR8C3l1Elr3bgWUnrBKHPdUGC6JRHvWMVCaxl6DKgkd7UCANuiARTso23OCNBRwgvtp
 rwFiyvRhNUEaO7QlSATjA5JJtx53+sMtXTbekkjPmaEXusXv4agwtISqX9vg16p2Tqi8Dp+uM
 WofS3VmXA+BBo1ROtcsQw9sVJRFfQQgkmmywrlqmuC5IKjJXg4Xl61uQLY3JjmBkW0QmkTl5h
 J8fNG7h//dtaWFwSrdt+9c8pA5eMDe18zGdC5siLeWlkf3pfgZzMXjjVItvYyoyw0OM/mktPa
 QBjCEmD8mD7SCnn5TsyHTPFOqWBFb4XmjggWPgJ75CzyATsK8YU7q3L6oSMQxwp9la0oAqvJ/
 noEKmKhqVUvP86htZ9SLbnfQOCxrzSZXTRgmDriczn/IAG/JZja/3wJxWlxG99cPB2XRZoaXP
 T/DuPfa1lbaK39vymAXjk1WmJ0G0lwdEgJi1eQz1H34u9pJCC2ujKY8TiIIAOEVHZVhC5YvZx
 3yI43FUZihznodfxRLcMBjoiTWrgKQE1pwHm5kow+QfT6BgrlGR+HBTauAj+6dCNPWNgWmTWr
 en2za0QnBP4krIr9WJCjU5Fq/3TccYyMZ02pPCe2jrLz5yVs4z/qVYMSAhSdzJ2fz9Y11NWHB
 a6a6juy8LAtL+hQLUgjNV5oW35KozUDC8khipU91Vvp/XIzRlkBO17ktoyAKEfOYXdxZ43NIm
 61A3g1SOoXJRWCq7QldtVcmhQjsXiJBRbD7eaWGhaX12vC2h95eu6hZOYmB+2MchKgDW5kQly
 O+PA82D+fDEnIqTQbf/pzVRNK8xApcjGPBEHaKSGngG5lsrB60IF5ykCNCHYaHA5Xl9kIJbFj
 aLDU+4gJTdjB1xEsqDV28sGPZdGRqr9qKyoNCV/+UrYLVb6bIx1BGE3fhtXTtTcHOShPNBbxI
 47kn9F0jcWPbeEneo3OabebhoU8RZm+Hm7VZjuFODY6vRG6Wr3AewLiCpc+kvstjagfqnhfeK
 z/yOkHBl5xyGvLo14qiJeDcIxYBr9H2SNLnVSwH+j+3nOZcGs6yVig1h7y7rdIB8ragBjM5vv
 t4ZfHZDPXnL6nqVuErF0Qj3Pdtwe41MbLu2COwjCzjNk+FHAOQZrUZhbf6hDpxAI/h9kZFai1
 qkL42dXGTxHdQvtNiKHfJVqdiZJK0qCfagS2u2ADwwi9J398zrPWgb+yKbVfMmWKvNB4ssP4K
 B7EUztyoMqcBH/64NWcjXt2ec6PjkTf1sgZPIEdwbLi5mgI9uJ2BGtKg5xjU+PrlBYbz1mh7I
 p3YVfmfz3OlkOCx1FHutC4HO/qywtdZzzqE4ryrPPWsBYSI1x7HRuWjxrTx3k5ixbO/CIS+BT
 hH5d6vb1vUoRQFB4CYwvKeX2pXauLxZQZZ4wf4jue8lqJnl1qa/1grASkaSnO5wFmfTTlikNH
 6BEjmBkbbzm7cbESEmExuZzzX8rjczkqJQlwom7WS+4cVh7xC3cq8XYdK5UQseyING3YrAje2
 NpIqU9Cy5I6V1tG3dODBhHXDBfW1tgcGPZjlc1fp1xZ2tO35YeqkmeBfwrP5V3OXtcsF8lzRS
 SBHg0yK1OKtxKwFcJzKOGdd1dApQWFcRB4fFoP30DncmccHds8ZLyEikT87yZeh4f3KvYuBWK
 nrF6T8IINrbXZI08nOWyYa0Ki15u3ggCb3oyn8tI9+hngV3CzY5CYc1nz0LNntqgAN66m4eFV
 EDGxjXuuaECREWWaSxPWkQ2yg/EqSKjo9s9pLzxVzsxUoWtjjRBLahAGuWYRVk/yoWyiz47aa
 VRPRNbjD25N4GjoDfCRtQJGwPVKGOUxxM84x75JK8V6cjhelWg3v+egSwPQJWVx/Q7wCocfrQ
 s8C3D4dzBm6yeFd6zbhOF3ykJtot3Y8wZiwjTxvST/AOmCrccpXpd7mx/AkZHNfPlA72luLkt
 B5r28RonjynNcEqysywFafYU9XSO9wgWzk1nSoPK6cZyvR81iCL/GEqyxLYBD+yKQe3S/tHsD
 ZlyCbafp1u/CuwV3kJgs24MmdhoBRNVwg8twGWd4Fxl3Z9mbSvbQlZ63pedolcUZfVN3r59a1
 Dkj2vamVncBUKZv8qpyKlteB8qRXytOM7Xu0iVUEiXZu6NJPnEWHdHlcQYMYhZwmb0IAHsyEa
 R4nAyqMzZGhPvwV/Z5sH7RCa177LeMZUfDHVuayWTUjg22inl1kqsCbtZMpPygxJPqOQqGy72
 H6T9xcOttGbEeyXnqwrWUA6ahcyoEcBMOzb6mO/eEMPf4lvL+rLsdG8RYkU7DjQB30ToiKBJ9
 Adm5zbUM/p/irweYbictpBjwQxdIm+SE/+OT8DlPR+BvQAYfBXrUK6n61aJMnr4qzPHrleybv
 9nuOQMtAD1ROgiASj1E21MuWGDs5Ln8360v5KhKK0QCYKPD3tZ28hHIjG5ksnI7xiWQqpgKFc
 J5s3aa2CDiKWfNXCbwh7yjv8P5e2pWeI86+lFO+Q9ayFnDCm4pOt7subPher3sIS2XskLBclC
 +mPcMIHLjtsy2A9HzfXVy5Kgv3lGtLf867x1tpJYvNJVBORicsDX4rXZ2Q5RonNVz2vgHRwmH
 7qbReIujaUn0asUCWtchtBxENP2vM0EO2BpHbEdRTRlf+Oat+QlfBsJEuzsWwsas+nUlqDmLf
 uTAfMVpV+o9ItCiPkmkmnsCDEZu/ZTbl9+DvlkWQA8v2az8iG+rfk9+l1aOEBWm0nHnZ8wtIk
 yLFhADGYODhtSIypiM5lgzc+nTBN1sX3SllpIa1QBoVA1+NF0958KvmIPPOn9bi2hio/20mio
 Kl9SIjumf8JCb04yTTYo9Hl3GLMqCYuh5YV+/YJS9NUtvdS5PxFUvF/o6Gx8vdU10rMBGDiyy
 wKRbxLtuSumpvxuU8HnSS/lIEAI9l46WpLRzGzCZhoG6aUQBTeV8z5LKiVrojEbfmRzLB9KrP
 ONr1uG6qaImU6LtgrIIZhOz9a0zIg3BYNoD9RlMVV1ARorERyi/Dnom3urOQ+nGS9Jdo2jnSm
 iaXDFIXUz8/zLhg7l0Zifx53e9iwfQf372yRSj40MHK5diHCEPkGbj5a7sgcIWJC5Bykvzowu
 elcBd0FLPozHdiNMaMgbNzaZEG9FoyNHPp2OZl2ge0KoSjrpG0JO/MDkZxvPtao/RoslJ3Ilk
 PaB8Q+73JkCC9qI8F40TnAgp0z8j6+EPLT/0WEBbO5O3JGPHfm50LsW4U/9tb2q1REi2/9U6G
 AxU/V/igWUkw4HHl1P4lqNJXi4f12CWS5724HbEdXGIbqV2AOgJD6uHexIWiqehmjODwDnwSm
 jFVQKhA1BKBNp010ckWAVxxeNc/5de1AsyieEQ00gbFjw/Thg/8kd7O4uwcZcuE18XZc8eUk2
 d0UdtQGLfMSA1q+Ywwk70h0H556HKTGqNtExpeiarsYVlfIwzq5jGSxHZAa3LisLk12NCNqOB
 GYsjv/721uYQUVurfej/FRtn7TR6fbXggvb5aPLOus+tJz3kL2Kjq3Yyey5g==

Allow callers of parse_tag() pass in the repository to use.  Let most of
them pass in the_repository to get the same result as before.  One of
them has stopped using the_repository in ef9b0370da (sha1-name.c: store
and use repo in struct disambiguate_state, 2019-04-16); let it pass in
its stored repository.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/describe.c     | 6 +++---
 builtin/pack-objects.c | 2 +-
 fsck.c                 | 2 +-
 object-name.c          | 2 +-
 ref-filter.c           | 2 +-
 tag.c                  | 8 ++++----
 tag.h                  | 2 +-
 walker.c               | 2 +-
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 443546aaac..989a78d715 100644
=2D-- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -112,13 +112,13 @@ static int replace_name(struct commit_name *e,
=20
 		if (!e->tag) {
 			t =3D lookup_tag(the_repository, &e->oid);
-			if (!t || parse_tag(t))
+			if (!t || parse_tag(the_repository, t))
 				return 1;
 			e->tag =3D t;
 		}
=20
 		t =3D lookup_tag(the_repository, oid);
-		if (!t || parse_tag(t))
+		if (!t || parse_tag(the_repository, t))
 			return 0;
 		*tag =3D t;
=20
@@ -335,7 +335,7 @@ static void append_name(struct commit_name *n, struct =
strbuf *dst)
 {
 	if (n->prio =3D=3D 2 && !n->tag) {
 		n->tag =3D lookup_tag(the_repository, &n->oid);
-		if (!n->tag || parse_tag(n->tag))
+		if (!n->tag || parse_tag(the_repository, n->tag))
 			die(_("annotated tag %s not available"), n->path);
 	}
 	if (n->tag && !n->name_checked) {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1ce8d6ee21..ca44b7894f 100644
=2D-- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3293,7 +3293,7 @@ static void add_tag_chain(const struct object_id *oi=
d)
=20
 	tag =3D lookup_tag(the_repository, oid);
 	while (1) {
-		if (!tag || parse_tag(tag) || !tag->tagged)
+		if (!tag || parse_tag(the_repository, tag) || !tag->tagged)
 			die(_("unable to pack objects reachable from tag %s"),
 			    oid_to_hex(oid));
=20
diff --git a/fsck.c b/fsck.c
index 138fffded9..fae18d8561 100644
=2D-- a/fsck.c
+++ b/fsck.c
@@ -474,7 +474,7 @@ static int fsck_walk_tag(struct tag *tag, void *data, =
struct fsck_options *optio
 {
 	const char *name =3D fsck_get_object_name(options, &tag->object.oid);
=20
-	if (parse_tag(tag))
+	if (parse_tag(the_repository, tag))
 		return -1;
 	if (name)
 		fsck_put_object_name(options, &tag->tagged->oid, "%s", name);
diff --git a/object-name.c b/object-name.c
index fed5de5153..8b862c124e 100644
=2D-- a/object-name.c
+++ b/object-name.c
@@ -449,7 +449,7 @@ static int show_ambiguous_object(const struct object_i=
d *oid, void *data)
 	} else if (type =3D=3D OBJ_TAG) {
 		struct tag *tag =3D lookup_tag(ds->repo, oid);
=20
-		if (!parse_tag(tag) && tag->tag) {
+		if (!parse_tag(ds->repo, tag) && tag->tag) {
 			/*
 			 * TRANSLATORS: This is a line of ambiguous
 			 * tag object output. E.g.:
diff --git a/ref-filter.c b/ref-filter.c
index d7454269e8..c318f9ca0e 100644
=2D-- a/ref-filter.c
+++ b/ref-filter.c
@@ -2866,7 +2866,7 @@ static int match_points_at(struct oid_array *points_=
at,
 	while (obj && obj->type =3D=3D OBJ_TAG) {
 		struct tag *tag =3D (struct tag *)obj;
=20
-		if (parse_tag(tag) < 0) {
+		if (parse_tag(the_repository, tag) < 0) {
 			obj =3D NULL;
 			break;
 		}
diff --git a/tag.c b/tag.c
index 9373c49d06..9daeaf2a78 100644
=2D-- a/tag.c
+++ b/tag.c
@@ -13,6 +13,7 @@
 #include "gpg-interface.h"
 #include "hex.h"
 #include "packfile.h"
+#include "repository.h"
=20
 const char *tag_type =3D "tag";
=20
@@ -203,7 +204,7 @@ int parse_tag_buffer(struct repository *r, struct tag =
*item, const void *data, u
 	return 0;
 }
=20
-int parse_tag(struct tag *item)
+int parse_tag(struct repository *r, struct tag *item)
 {
 	enum object_type type;
 	void *data;
@@ -212,8 +213,7 @@ int parse_tag(struct tag *item)
=20
 	if (item->object.parsed)
 		return 0;
-	data =3D odb_read_object(the_repository->objects, &item->object.oid,
-			       &type, &size);
+	data =3D odb_read_object(r->objects, &item->object.oid, &type, &size);
 	if (!data)
 		return error("Could not read %s",
 			     oid_to_hex(&item->object.oid));
@@ -222,7 +222,7 @@ int parse_tag(struct tag *item)
 		return error("Object %s not a tag",
 			     oid_to_hex(&item->object.oid));
 	}
-	ret =3D parse_tag_buffer(the_repository, item, data, size);
+	ret =3D parse_tag_buffer(r, item, data, size);
 	free(data);
 	return ret;
 }
diff --git a/tag.h b/tag.h
index 55c2d0792b..534687c4ca 100644
=2D-- a/tag.h
+++ b/tag.h
@@ -13,7 +13,7 @@ struct tag {
 };
 struct tag *lookup_tag(struct repository *r, const struct object_id *oid)=
;
 int parse_tag_buffer(struct repository *r, struct tag *item, const void *=
data, unsigned long size);
-int parse_tag(struct tag *item);
+int parse_tag(struct repository *r, struct tag *item);
 void release_tag_memory(struct tag *t);
 struct object *deref_tag(struct repository *r, struct object *, const cha=
r *, int);
 int gpg_verify_tag(struct repository *r, const struct object_id *oid,
diff --git a/walker.c b/walker.c
index 409b646578..2891563b03 100644
=2D-- a/walker.c
+++ b/walker.c
@@ -115,7 +115,7 @@ static int process_commit(struct walker *walker, struc=
t commit *commit)
=20
 static int process_tag(struct walker *walker, struct tag *tag)
 {
-	if (parse_tag(tag))
+	if (parse_tag(the_repository, tag))
 		return -1;
 	return process(walker, tag->tagged);
 }
=2D-=20
2.52.0

