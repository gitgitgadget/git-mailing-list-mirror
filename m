Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9C41C3BFC
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994226; cv=none; b=BujSfLJZtwVauXe4UaLBlsbmqhQMretT2spyh537sEuRXxp5ikO742N+3C1OI6INpoATaHSnkWqEwveuG2su1Gb5BY66T/nDLK7/rYpquZM2P96YiVSIb0BabDlxcdNp/arUFJdDULyBPGAn50UUvsnqFjqvP6d6RK3dvgpu8rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994226; c=relaxed/simple;
	bh=tBIaoaq27w52cai8MF+3eNtgXdTrJsHbZ2jCDaXU11c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDYOBsV2sTvK4/PIz/biGQJrWOm+u6gA6NxqdbIxdvQEBYUYAnsV9Pb+DPQPJCTSbxMH41z/pBbvtJ6bCdV7KR6d/p7wx+QiSyIFwEpoUB4dLz2T5xxEDbSsd4j4+3f269cUieMqBrx9fD/v+yYa+DSI4ypBuDr+Zk22uZks964=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=YGkmxjxm; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="YGkmxjxm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767994223; x=1768599023; i=l.s.r@web.de;
	bh=HMFGsNk70m+RXZJPNj3HNfQnocMytv+AyYDlZuFPmzs=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YGkmxjxmXp4ikQx+DBRnvpZhdwezRTKcQ/pqjeuf1c/XdtHgXm3XjZa3JCPbQZFF
	 gBUI0fH6EG1d+9Ks8ed3M2KgHM3n/MEqnHkZ/joG+8gKFV6amuZL47gkJzhvJvCEa
	 FJb2q+gbvJOyY15b2gcrjwhx3Zw30/6V3lqSu3LNcPc3x9G73uVVHwsbEuNLdZR7H
	 4EzpdIBVQm+y0iHWo1u2iPOv5bAf0qhnHDYzf3/47vgEd90UvFrpsfNIkTrM22Tup
	 FFkE5bqEj0ka6joz2vWOn6tBbYGAKk84hOu1Q40zVy8ftl0IA8OTry1CQA2I08Axe
	 CY9RiQAjRELr1GwzMw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.19.215]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MjxiM-1w72630gjQ-00d8m8 for <git@vger.kernel.org>; Fri, 09 Jan 2026 22:30:23
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 08/10] tree: use repo_parse_tree()
Date: Fri,  9 Jan 2026 22:30:19 +0100
Message-ID: <20260109213021.2546-9-l.s.r@web.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109213021.2546-1-l.s.r@web.de>
References: <20260109213021.2546-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uxnOyJHDt0Sa8c3ebqfnXQ6msPx2CAwLz2OFTY+Tnl3LpEL3nb4
 a68P7OeWTqrJyNil3KTJt0lWb+eOQw7oXKPiSSuAud0y6lnJxWJvTOfadYQbNK08TUxdUJX
 15/CyAesKIlljW3WAPL4UAAHl34FhzXld/v6toNDQNdBL90ytWrnL1FskoYDZvVv66FmFQG
 ZWWaDjrWa2GKeV8bsQ9mw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oxKohn3cT+E=;ZI//7HlaL5Yvy8X/OadK3g3ONUz
 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

e092073d64 (tree.c: make read_tree*() take 'struct repository *',
2018-11-18) replaced explicit uses of the_repository.  parse_tree() uses
it internally, though, so call repo_parse_tree() instead and hand it the
correct repository.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tree.c b/tree.c
index 036f56ca29b..edcf6a284cb 100644
=2D-- a/tree.c
+++ b/tree.c
@@ -28,7 +28,7 @@ int read_tree_at(struct repository *r,
 	if (depth > r->settings.max_allowed_tree_depth)
 		return error("exceeded maximum allowed tree depth");
=20
-	if (parse_tree(tree))
+	if (repo_parse_tree(r, tree))
 		return -1;
=20
 	init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
=2D-=20
2.52.0

