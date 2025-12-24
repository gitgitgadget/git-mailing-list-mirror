Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2DE2673AA
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766595814; cv=none; b=Jc7MT5jdhzlgOLV2r9iG4X7Zyndu3SlxNKuzgdI4Gn9IaJessku6Mhi6ZQizVRxsZwGMGZnr+vIIcWl0yo+4PpCnfjlvIffn650EIiMMp1A++Rd5nA0Pz4bJVfHlwhRY8KlGfeEW51o6zxRapGYDIy2+zLyNVQWGeWj6IheVPZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766595814; c=relaxed/simple;
	bh=zthy1Sy6RP+K52l7GW9qV6Mnc1Izyxo92VDYFp3LZ8w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0uDuzvCI4zyW6XVCp8WM1D8UeVr1hu1VY/GYlyEtiNnXGV9MWDb0MgRriyiyfPByII1ihxs742vb/JqCHsqbYqOrTWSZB23jXYatb2SBkWeGack+nMCyh7Uv2VqI/WNGSs+fggAoMi0nXL8ADNKiOgQUKo4oYZDlJbf+w0DOI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=npx8fAaw; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="npx8fAaw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766595808; x=1767200608; i=l.s.r@web.de;
	bh=RlWAiKIqdugy2wzMgb2Kc9y9EGNAnQ08WwyGl6Y/w+A=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=npx8fAawEOdOMIM8VJbwIY/Yry0iTvb4ZJqMHtcYD30yikl5kUHl2r1NiMiAXRES
	 S9HVfUyrjO2dtWGQT4bSEVZ+wjp0JRwlNDL0wVruYTPVVKKHjZWJIUddFl9EP0TzT
	 kTfPS0YyciVZYK72wprrhzh5Vqxhy+iVsBuJmAfEcetqNOF/OMsVPKoIgHFt+pEf4
	 t5SV6zFIYTteiP3YEcfQQ1zz5JRCK/yPmazkePXAnZGsJSOQ5hiE+WhqD1ouHUbaL
	 6BU2vt6mXNTyEW7AIMOY5Eb5r+TZaj8GRDN5im1O35PWKoPLOelAoszhbGL3rl0LY
	 lXr1b4XkFhQzovMrZA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.30.2]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1Ml46y-1wDJKG2EQu-00kV9b for <git@vger.kernel.org>; Wed, 24 Dec 2025 18:03:28
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 01/14] revision: export commit_stack
Date: Wed, 24 Dec 2025 18:03:14 +0100
Message-ID: <20251224170327.68049-2-l.s.r@web.de>
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
X-Provags-ID: V03:K1:woh2aadn4sf7I5RSUMgqV01v+weX+eqCpABk5oGtzuMSX25zvbS
 +n50CKgwZV6WPWYxb+w79lBMyrW+8+9wEBS2j2TDeSoF5gi3zmyV30sNJ+EX4FCxbdCHUTF
 R2KDlhh41nK9nKDRY0mK0x5jfCavXZFuVySqYESveO2UUha3d2uopRMWHSRfdz2/I/oJMvn
 M2CUXMZNIDnrjbmXcxlyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LwUc67E6P6s=;IVXRmedRNRRY6ryUHcxpFkTot8e
 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

Dynamic arrays of commit pointers are used in several places.  Some of
them use a custom struct to hold array, item count and capacity, others
have them as separate variables linked by a common name part.

Pick one succinct, clean implementation -- commit_stack -- and convert
the different variants to it to reduce code duplication.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 commit.c   | 17 +++++++++++++++++
 commit.h   | 10 ++++++++++
 revision.c | 23 -----------------------
 3 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/commit.c b/commit.c
index 709c9eed58..f2edafa49c 100644
=2D-- a/commit.c
+++ b/commit.c
@@ -1981,3 +1981,20 @@ int run_commit_hook(int editor_is_used, const char =
*index_file,
 	opt.invoked_hook =3D invoked_hook;
 	return run_hooks_opt(the_repository, name, &opt);
 }
+
+void commit_stack_push(struct commit_stack *stack, struct commit *commit)
+{
+	ALLOC_GROW(stack->items, stack->nr + 1, stack->alloc);
+	stack->items[stack->nr++] =3D commit;
+}
+
+struct commit *commit_stack_pop(struct commit_stack *stack)
+{
+	return stack->nr ? stack->items[--stack->nr] : NULL;
+}
+
+void commit_stack_clear(struct commit_stack *stack)
+{
+	FREE_AND_NULL(stack->items);
+	stack->nr =3D stack->alloc =3D 0;
+}
diff --git a/commit.h b/commit.h
index 5406dd2663..81e047f820 100644
=2D-- a/commit.h
+++ b/commit.h
@@ -381,4 +381,14 @@ int parse_buffer_signed_by_header(const char *buffer,
 				  const struct git_hash_algo *algop);
 int add_header_signature(struct strbuf *buf, struct strbuf *sig, const st=
ruct git_hash_algo *algo);
=20
+struct commit_stack {
+	struct commit **items;
+	size_t nr, alloc;
+};
+#define COMMIT_STACK_INIT { 0 }
+
+void commit_stack_push(struct commit_stack *, struct commit *);
+struct commit *commit_stack_pop(struct commit_stack *);
+void commit_stack_clear(struct commit_stack *);
+
 #endif /* COMMIT_H */
diff --git a/revision.c b/revision.c
index 5f0850ae5c..1858e093ee 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -250,29 +250,6 @@ void mark_trees_uninteresting_sparse(struct repositor=
y *r,
 	paths_and_oids_clear(&map);
 }
=20
-struct commit_stack {
-	struct commit **items;
-	size_t nr, alloc;
-};
-#define COMMIT_STACK_INIT { 0 }
-
-static void commit_stack_push(struct commit_stack *stack, struct commit *=
commit)
-{
-	ALLOC_GROW(stack->items, stack->nr + 1, stack->alloc);
-	stack->items[stack->nr++] =3D commit;
-}
-
-static struct commit *commit_stack_pop(struct commit_stack *stack)
-{
-	return stack->nr ? stack->items[--stack->nr] : NULL;
-}
-
-static void commit_stack_clear(struct commit_stack *stack)
-{
-	FREE_AND_NULL(stack->items);
-	stack->nr =3D stack->alloc =3D 0;
-}
-
 static void mark_one_parent_uninteresting(struct rev_info *revs, struct c=
ommit *commit,
 					  struct commit_stack *pending)
 {
=2D-=20
2.52.0

