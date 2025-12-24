Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FBF2D24B7
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766595815; cv=none; b=bLwu245w2Um33tK7/4jU9B/x9cChrUv+EP2lt2DPKNVcHPi8dLsX7Jywz3zslMJXCriEgNuC4X5ullkUkDgTShOBBOoXy6FvEcscecA6JCGy7wNjov8jxfjoj2DbkN2xEfBK/E+au6K9xOTIYuJGVy51vZUeAX4H0pxgXrG7Qgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766595815; c=relaxed/simple;
	bh=esdpSwEYlbH37rg0PxISPGKkR9ss7aqt3W+QiLK/2Ls=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Di96ItITvD4Y9PAgfxFvf3RGiYoFZN1H5CiXkDMZdz0oTqzpmmM/D9MdOyq7m88/H3T0prNxq30tIaWIaK1V9o5pD6l6Yh7NSmTxyUwzhWxwdryQ7n2RKnJOC6tBnJ4ZSHZsxD0XQcfgT2ZrAmVMppXbki2spnhwMDlJH5oKnRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=rSpiqh1w; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="rSpiqh1w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766595808; x=1767200608; i=l.s.r@web.de;
	bh=KiZPOElNTK9G2pjdUCNdioBEdaW+9+IOYu092VLIc4Y=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rSpiqh1wlw5IXbWFk1mmBTW234AYMJMquwvziSXVAfQ65a/nJwVIvFh6lV1rfXfx
	 J7ZICbW6+DdpFAD9K6ZOiSmeb/X1yOJcRsevKeiycLAxMM4RaKdQkqvFoa7z7b9v6
	 x0bruvWqQz+/Ne+Bg2Ex1wnRE13+rhWpb1FZvve7ClAirj1R8Q46HDDugcC73d9Ko
	 yAagn/gwi2t1CepwUlMyv1Z17AwXT7JLll5ApL5unKxEuJYGIfhga/UuwXch7UwzM
	 X2BL9sZGE0suEs4ZZqw5k9C8rN2/RHUalSNgbinJUav6yilIeAfP7FTRSzdMBDIXJ
	 nWSy0ixPLjZl2KSwGw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.30.2]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MNORC-1vJePq3Lfm-00QNGz for <git@vger.kernel.org>; Wed, 24 Dec 2025 18:03:28
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 04/14] name-rev: use commit_stack
Date: Wed, 24 Dec 2025 18:03:17 +0100
Message-ID: <20251224170327.68049-5-l.s.r@web.de>
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
X-Provags-ID: V03:K1:oz+3KZ25qIFd7M8JDA9WO8v2RHT4TrEE82fEEUMwKhedVMydRpu
 +IBCvnbpOlEJSiaZIav4eDN4wALSglvE4Gzf7imIysgOqaP3z27ebjRpHPIIN+H8UXQRmw+
 CDO5AlNGrkh3XXYXXJTbiOB1+SKS5oXwR+2G7fgKHzqfVEi8eTvzEEtNqyafprtMC7oLB60
 a/TjuDnK9VAE8SAY49EvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+usWqQiM+2Q=;YcKOK4ghjJlmFnqtDWR0o85CVhd
 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

Simplify the code by using commit_stack instead of open-coding it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/name-rev.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 615f7d1aae..6188cf98ce 100644
=2D-- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -180,8 +180,7 @@ static void name_rev(struct commit *start_commit,
 {
 	struct prio_queue queue;
 	struct commit *commit;
-	struct commit **parents_to_queue =3D NULL;
-	size_t parents_to_queue_nr, parents_to_queue_alloc =3D 0;
+	struct commit_stack parents_to_queue =3D COMMIT_STACK_INIT;
 	struct rev_name *start_name;
=20
 	repo_parse_commit(the_repository, start_commit);
@@ -206,7 +205,7 @@ static void name_rev(struct commit *start_commit,
 		struct commit_list *parents;
 		int parent_number =3D 1;
=20
-		parents_to_queue_nr =3D 0;
+		parents_to_queue.nr =3D 0;
=20
 		for (parents =3D commit->parents;
 				parents;
@@ -238,22 +237,18 @@ static void name_rev(struct commit *start_commit,
 								string_pool);
 				else
 					parent_name->tip_name =3D name->tip_name;
-				ALLOC_GROW(parents_to_queue,
-					   parents_to_queue_nr + 1,
-					   parents_to_queue_alloc);
-				parents_to_queue[parents_to_queue_nr] =3D parent;
-				parents_to_queue_nr++;
+				commit_stack_push(&parents_to_queue, parent);
 			}
 		}
=20
 		/* The first parent must come out first from the prio_queue */
-		while (parents_to_queue_nr)
+		while (parents_to_queue.nr)
 			prio_queue_put(&queue,
-				       parents_to_queue[--parents_to_queue_nr]);
+				       commit_stack_pop(&parents_to_queue));
 	}
=20
 	clear_prio_queue(&queue);
-	free(parents_to_queue);
+	commit_stack_clear(&parents_to_queue);
 }
=20
 static int subpath_matches(const char *path, const char *filter)
=2D-=20
2.52.0

