Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37F82D5959
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766595814; cv=none; b=UC/ZoOs1GuZui49OX/oiejcqeyjHDCA721Poou1XJRGOVIwbhUeDsAhfOxX6Lz2FqpJkPy/4c+rYauxNE02zjwTPssFDP2wiFSDSY5WrXnZ+KWb7J/Xza3whbUM2PB3C4qYJ/1SeFoYxgnn3mDg1pdd6n8b/w/EucdHL/XqfqVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766595814; c=relaxed/simple;
	bh=ccg+AUo34yXCQSMnGsMU3o7uz3wZGpyW9BiP37VqRlo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fCwrpBaNW0mUPGFce8xImblvlH7WcEpHGyAoBOOxU260lLX2lzMmSvBbnVzgsnhMEA+s2mnOM32KbgyCy0uwh/X6rWkkoOAdASdY8F8/7QB25onFhHw/zYGcU0VTF2APptySs4CuESMFMmY7dC4bv2xFbGkPfPFHzXV0lQDwEw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=K0Jd0oV1; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="K0Jd0oV1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766595809; x=1767200609; i=l.s.r@web.de;
	bh=pExLzgVJJJMzNe7UIz1VaFtcRTG0/edpNaN0Cl/8aSw=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=K0Jd0oV1y5bcDvLbi3SAoqRUyTyH1Hpi/Ozax6kM6nU1lR095M8IrGAELSmNK7Lp
	 D43lucwdhgd3JwXz3/Ye72/zG6aI1Uw7CgVmf2WYs3gXoNysYtCBmOU5RU0dV+AfR
	 ilQjUdYTlkv5rnC/4y613/Q7gqKn9s0444pVljnbmuMYfZmmJrYduHausoAdwTtG+
	 t0zLCbgcUeCfDIXt6LBU2HVqmnmRhbUecb5kBo9R2jTgjFNEh7GNqE0l2nnEtKD3j
	 50TkElABI5TlGbcLShftsSds5qVOue7gu/EM2tpVWdztlPRqKt2e+OiShU2r/5KaM
	 k9DJVFjG9V3irKnKgQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.30.2]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MCGSU-1vhqBn0eAM-00AsgT for <git@vger.kernel.org>; Wed, 24 Dec 2025 18:03:29
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 08/14] test-reach: use commit_stack
Date: Wed, 24 Dec 2025 18:03:21 +0100
Message-ID: <20251224170327.68049-9-l.s.r@web.de>
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
X-Provags-ID: V03:K1:bAPBOMOsg96n1EjBM5WKUoIpOhzcTEYIOSng+7VUUc0soRhmbc4
 HJLoVZuDe7+TnkoSGSB+E3P+0rYop1+SwkiQnSqFtqzx8KiiXbZUHshi30fTb7qsyOUZiAM
 DfJMwCksErRdTNuV/N5kES01pPLevOzorefLKvlxDrqfXEcPHh/u5XewgFg1VxJS5Bfo6kZ
 mGmEGX0PEKAaxDzJypqbQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9YXbD0SuLFY=;O6btaBeGIbkRcBuy0dIDB5rnZPW
 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
 yamP/cY7qhqY42sCI1JKMkOXBbcNtN+uEwd3/7

Use commit_stack instead of open-coding it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/helper/test-reach.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index c58c93800f..feabeb29c2 100644
=2D-- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -34,8 +34,8 @@ int cmd__reach(int ac, const char **av)
 	struct commit *A, *B;
 	struct commit_list *X, *Y;
 	struct object_array X_obj =3D OBJECT_ARRAY_INIT;
-	struct commit **X_array, **Y_array;
-	size_t X_nr, X_alloc, Y_nr, Y_alloc;
+	struct commit_stack X_stack =3D COMMIT_STACK_INIT;
+	struct commit_stack Y_stack =3D COMMIT_STACK_INIT;
 	struct strbuf buf =3D STRBUF_INIT;
 	struct repository *r =3D the_repository;
=20
@@ -46,10 +46,6 @@ int cmd__reach(int ac, const char **av)
=20
 	A =3D B =3D NULL;
 	X =3D Y =3D NULL;
-	X_nr =3D Y_nr =3D 0;
-	X_alloc =3D Y_alloc =3D 16;
-	ALLOC_ARRAY(X_array, X_alloc);
-	ALLOC_ARRAY(Y_array, Y_alloc);
=20
 	while (strbuf_getline(&buf, stdin) !=3D EOF) {
 		struct object_id oid;
@@ -88,15 +84,13 @@ int cmd__reach(int ac, const char **av)
=20
 			case 'X':
 				commit_list_insert(c, &X);
-				ALLOC_GROW(X_array, X_nr + 1, X_alloc);
-				X_array[X_nr++] =3D c;
+				commit_stack_push(&X_stack, c);
 				add_object_array(orig, NULL, &X_obj);
 				break;
=20
 			case 'Y':
 				commit_list_insert(c, &Y);
-				ALLOC_GROW(Y_array, Y_nr + 1, Y_alloc);
-				Y_array[Y_nr++] =3D c;
+				commit_stack_push(&Y_stack, c);
 				break;
=20
 			default:
@@ -112,16 +106,16 @@ int cmd__reach(int ac, const char **av)
 		       repo_in_merge_bases(the_repository, A, B));
 	else if (!strcmp(av[1], "in_merge_bases_many"))
 		printf("%s(A,X):%d\n", av[1],
-		       repo_in_merge_bases_many(the_repository, A, X_nr, X_array, 0));
+		       repo_in_merge_bases_many(the_repository, A, X_stack.nr, X_stack.=
items, 0));
 	else if (!strcmp(av[1], "is_descendant_of"))
 		printf("%s(A,X):%d\n", av[1], repo_is_descendant_of(r, A, X));
 	else if (!strcmp(av[1], "get_branch_base_for_tip"))
-		printf("%s(A,X):%d\n", av[1], get_branch_base_for_tip(r, A, X_array, X_=
nr));
+		printf("%s(A,X):%d\n", av[1], get_branch_base_for_tip(r, A, X_stack.ite=
ms, X_stack.nr));
 	else if (!strcmp(av[1], "get_merge_bases_many")) {
 		struct commit_list *list =3D NULL;
 		if (repo_get_merge_bases_many(the_repository,
-					      A, X_nr,
-					      X_array,
+					      A, X_stack.nr,
+					      X_stack.items,
 					      &list) < 0)
 			exit(128);
 		printf("%s(A,X):\n", av[1]);
@@ -159,8 +153,8 @@ int cmd__reach(int ac, const char **av)
 		const int reachable_flag =3D 1;
 		int count =3D 0;
 		struct commit_list *current;
-		struct commit_list *list =3D get_reachable_subset(X_array, X_nr,
-								Y_array, Y_nr,
+		struct commit_list *list =3D get_reachable_subset(X_stack.items, X_stac=
k.nr,
+								Y_stack.items, Y_stack.nr,
 								reachable_flag);
 		printf("get_reachable_subset(X,Y)\n");
 		for (current =3D list; current; current =3D current->next) {
@@ -169,8 +163,8 @@ int cmd__reach(int ac, const char **av)
 				    oid_to_hex(&list->item->object.oid));
 			count++;
 		}
-		for (size_t i =3D 0; i < Y_nr; i++) {
-			if (Y_array[i]->object.flags & reachable_flag)
+		for (size_t i =3D 0; i < Y_stack.nr; i++) {
+			if (Y_stack.items[i]->object.flags & reachable_flag)
 				count--;
 		}
=20
@@ -185,7 +179,7 @@ int cmd__reach(int ac, const char **av)
 	strbuf_release(&buf);
 	free_commit_list(X);
 	free_commit_list(Y);
-	free(X_array);
-	free(Y_array);
+	commit_stack_clear(&X_stack);
+	commit_stack_clear(&Y_stack);
 	return 0;
 }
=2D-=20
2.52.0

