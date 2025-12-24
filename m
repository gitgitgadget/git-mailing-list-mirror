Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45073019BE
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766595815; cv=none; b=hHnnJnSJL3b4iwV8PKPHs8yoOOdb8EsWtJfpaJ3BhB5EVZZcJI+Ng3C/vk2UmaJ2z13N7o7tSRxwfGP/cwCGZG8q4lw3K0jmsePxs6EbBCt8ntmDXUDrVCjIisHS/uu7w7SBz3QexOvSf8wowaxedsNMDTdyvfuD3eBufUAhvk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766595815; c=relaxed/simple;
	bh=riYA3VLXMydXtlEptGKMO2PKcMHjKx30+P7WWCCSbSM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8mYObEwbmpDjNwrGU8x7R3isFHdEpJflmzUYqwIMxQfwmVvBLbrhOFwxitCz/m+Z4K86Y3UVswfV2PPnyLMQgQ5TFvrZs4kk6+CNVanjudLvL98vBeGMRAe+2foYc/d7DQL4k+6F260fWBPrAUXgCpLnpxV2p22OCzUCczNGyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=H+ca9yz2; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="H+ca9yz2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766595809; x=1767200609; i=l.s.r@web.de;
	bh=QFLVTzjAGioHN7CGN7MI3rxbfepDZEQzF6G7pb4Wv5E=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=H+ca9yz2kbXij21FBIHk8ORt1rN/3CDfxzGYAyIQTQVzRNmF+1G/smkll7RCJ+K8
	 oeD0QyQZe7Wnf43LAyCY15gHAQaRblzzbduFtfPnmr+43vXeiSqxb86Ldx1z8jYDB
	 7vHKro8k3mQqPYsNc4hcGD17fURCHVurA82oeO6Wppvg6bO4ho7rUpQWzZiK8k/Gr
	 f7nHkHR6XeV8z+tilBo67+HI83gDdaXtLhG0TrIJCTLhQrFTbYr0n9xF/86xm47Nm
	 apNLjBi4bvG7cpw5LLcSsKKh3WTGCqPDh73M68JkyYxSHsFuc9bMd6cmgvknGPCpP
	 ms10JZ7rx3XOCG4x4A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.30.2]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MGgJK-1vmDuV11DG-00FGOf for <git@vger.kernel.org>; Wed, 24 Dec 2025 18:03:29
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 09/14] commit: add commit_stack_init()
Date: Wed, 24 Dec 2025 18:03:22 +0100
Message-ID: <20251224170327.68049-10-l.s.r@web.de>
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
X-Provags-ID: V03:K1:DTMPAGV07uIjnYwOK7EVXMgt16i7kPC/67qMs5RyfTiRJXiEqmO
 Y8gbyOUufAQnGFHOBmeUFamyR56D/245yqG3gqm+JN/aWyDzH7Tm3vIUrJk3dgMtjr0kfeb
 uh+oO3ETzOJ9GEFkrqnqCHx0TyU522dosm4K6N5GNkvZpX0OcJFnwaYnZyhHyrSpkvkH3LZ
 ufLBjELXCPh03FrEC7cuQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IAr7K4iONg4=;Kb+t6FsVOCmNQrTmrLWl5pGfSca
 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
 G3u5D8KOuobngP5to=

Add a function for initializing a struct commit_stack, for when static
initialization is not possible or impractical.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 commit.c | 10 ++++++++--
 commit.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index f2edafa49c..55b1c8d2f8 100644
=2D-- a/commit.c
+++ b/commit.c
@@ -1982,6 +1982,12 @@ int run_commit_hook(int editor_is_used, const char =
*index_file,
 	return run_hooks_opt(the_repository, name, &opt);
 }
=20
+void commit_stack_init(struct commit_stack *stack)
+{
+	stack->items =3D NULL;
+	stack->nr =3D stack->alloc =3D 0;
+}
+
 void commit_stack_push(struct commit_stack *stack, struct commit *commit)
 {
 	ALLOC_GROW(stack->items, stack->nr + 1, stack->alloc);
@@ -1995,6 +2001,6 @@ struct commit *commit_stack_pop(struct commit_stack =
*stack)
=20
 void commit_stack_clear(struct commit_stack *stack)
 {
-	FREE_AND_NULL(stack->items);
-	stack->nr =3D stack->alloc =3D 0;
+	free(stack->items);
+	commit_stack_init(stack);
 }
diff --git a/commit.h b/commit.h
index 81e047f820..7c01a76425 100644
=2D-- a/commit.h
+++ b/commit.h
@@ -387,6 +387,7 @@ struct commit_stack {
 };
 #define COMMIT_STACK_INIT { 0 }
=20
+void commit_stack_init(struct commit_stack *);
 void commit_stack_push(struct commit_stack *, struct commit *);
 struct commit *commit_stack_pop(struct commit_stack *);
 void commit_stack_clear(struct commit_stack *);
=2D-=20
2.52.0

