Received: from postout1.mail.lrz.de (postout1.mail.lrz.de [129.187.255.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C6646BF
	for <git@vger.kernel.org>; Sun, 27 Apr 2025 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.187.255.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745791691; cv=none; b=YS/s5c5HSihCsohdp4Vb6lJlyHMIeVfkmrtG6c14Wogtmnj4PCqhgfEvacGZLbn3xF0OK/7yKewfJMkQjtK6TnXyllo5B4YP1P3sxmTZ8YkNNOsLuqsNqpyuZirGD7Y90nMKs3hdkYAW8TtiAqX7B+dP1ZUXitS0beoe3uZz7dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745791691; c=relaxed/simple;
	bh=5UWGMu4hqle+VIWgeJ9imbhe6nx79lmADxfcszCpHD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LVRwyXc9WA4xIbsNHjfoSwDiFR3D8H4WaEOz1JSJCQs/wFqUhWp2wpe+DgBh9bXzBOH26X8LHIuplRTmitp5PaKwCi4W70Tn/PAryz18W4E9HWfAE6YLAFil3XLRQ8Bq/n/x1dnnm7ootKOT4j1N5/8mVQ1lXCyRxuVyrCQ/tlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=campus.lmu.de; spf=pass smtp.mailfrom=campus.lmu.de; dkim=pass (2048-bit key) header.d=lmu.de header.i=@campus.lmu.de header.b=BbPI+3vL; arc=none smtp.client-ip=129.187.255.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=campus.lmu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=campus.lmu.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lmu.de header.i=@campus.lmu.de header.b="BbPI+3vL"
Received: from lxmhs51.srv.lrz.de (localhost [127.0.0.1])
	by postout1.mail.lrz.de (Postfix) with ESMTP id 4Zm11203XKzyS2;
	Mon, 28 Apr 2025 00:08:06 +0200 (CEST)
Authentication-Results: postout.lrz.de (amavis); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=lmu.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmu.de; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=lm-postout21; i=@campus.lmu.de; t=
	1745791685; bh=02Tr30XqZdFQtMIWo6dgFlI0TfD23kD6ObNtRzVZH9I=; b=B
	bPI+3vLt/b/8TAqAFWb6G14xGT38WrwCuqbJC+IW2LQG7moCoU/+YaESWd89IAQy
	jp91ONSWH1zU7ZZKb4dS0zjS8iC56/G8lAwokshg88koRrUC+AOwiAc06zQwutAi
	wZbeAeO5fRRVgpOfrrwnO3KQAyETUMYsUzDAhEIDNoJzgejDDPM6FpJmqNQ8nOzY
	/ll3O5+FvvjGQ6GgdE1sasAF1dtuaRNrQZH14Gi1BDWZaUBtu1BlDixu8boBZZA3
	TYT0pNXJ9iEEAwddRXpUhQiLztIVCz7ZcLwnrFKw9YdT8b9hNtT599N4YlIO3LR8
	RF9lKJnIW/HaGdqAQuYCA==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs51.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.886
X-Spam-Level:
Received: from postout1.mail.lrz.de ([127.0.0.1])
 by lxmhs51.srv.lrz.de (lxmhs51.srv.lrz.de [127.0.0.1]) (amavis, port 20024)
 with LMTP id TwURtQHUZSCs; Mon, 28 Apr 2025 00:08:05 +0200 (CEST)
Received: from niels-ubuntu-2023.speedport.ip (p200300ed2f4ea578279eff224f78ac2b.dip0.t-ipconnect.de [IPv6:2003:ed:2f4e:a578:279e:ff22:4f78:ac2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by postout1.mail.lrz.de (Postfix) with ESMTPSA id 4Zm11069klzySl;
	Mon, 28 Apr 2025 00:08:04 +0200 (CEST)
From: Niels Glodny <n.glodny@campus.lmu.de>
To: git@vger.kernel.org
Cc: Niels Glodny <n.glodny@campus.lmu.de>,
	johannes.schindelin@gmx.de,
	peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: [PATCH v2] xdiff: disable cleanup_records heuristic with --minimal
Date: Mon, 28 Apr 2025 00:06:53 +0200
Message-Id: <20250427220653.2325573-1-n.glodny@campus.lmu.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250425155951.1227700-1-n.glodny@campus.lmu.de>
References: <20250425155951.1227700-1-n.glodny@campus.lmu.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cleanup_records function marks some lines as changed before running
the actual diff algorithm. For most lines, this is a good performance
optimization, but it also marks lines that are surrounded by many
changed lines as changed as well. This can cause redundant changes and
longer-than-necessary diffs.

Whether this results in better-looking diffs is subjective. However, the
--minimal flag explicitly requests the shortest possible diff.

A performance impact of this is not measurable, and it results in
shorter diffs in about 1.3% of diffs in Git's history.

Signed-off-by: Niels Glodny <n.glodny@campus.lmu.de>
---
 t/meson.build           |  1 +
 t/t4071-diff-minimal.sh | 14 ++++++++++++++
 xdiff/xprepare.c        |  5 +++--
 3 files changed, 18 insertions(+), 2 deletions(-)
 create mode 100755 t/t4071-diff-minimal.sh

diff --git a/t/meson.build b/t/meson.build
index bfb744e886..8f2e9d2c50 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -501,6 +501,7 @@ integration_tests = [
   't4068-diff-symmetric-merge-base.sh',
   't4069-remerge-diff.sh',
   't4070-diff-pairs.sh',
+  't4071-diff-minimal.sh',
   't4100-apply-stat.sh',
   't4101-apply-nonl.sh',
   't4102-apply-rename.sh',
diff --git a/t/t4071-diff-minimal.sh b/t/t4071-diff-minimal.sh
new file mode 100755
index 0000000000..4c484dadfb
--- /dev/null
+++ b/t/t4071-diff-minimal.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+
+test_description='minimal diff algorithm'
+
+. ./test-lib.sh
+
+test_expect_success 'minimal diff should not mark changes between changed lines' '
+	test_write_lines x x x x >pre &&
+	test_write_lines x x x A B C D x E F G >post &&
+	test_expect_code 1 git diff --no-index --minimal pre post >diff &&
+	test_grep ! ^[+-]x diff 
+'
+
+test_done
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index c84549f6c5..e1d4017b2d 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -368,6 +368,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	xrecord_t **recs;
 	xdlclass_t *rcrec;
 	char *dis, *dis1, *dis2;
+	int need_min = !!(cf->flags & XDF_NEED_MINIMAL);
 
 	if (!XDL_CALLOC_ARRAY(dis, xdf1->nrec + xdf2->nrec + 2))
 		return -1;
@@ -379,7 +380,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
 		rcrec = cf->rcrecs[(*recs)->ha];
 		nm = rcrec ? rcrec->len2 : 0;
-		dis1[i] = (nm == 0) ? 0: (nm >= mlim) ? 2: 1;
+		dis1[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
 	}
 
 	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
@@ -387,7 +388,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
 		rcrec = cf->rcrecs[(*recs)->ha];
 		nm = rcrec ? rcrec->len1 : 0;
-		dis2[i] = (nm == 0) ? 0: (nm >= mlim) ? 2: 1;
+		dis2[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
 	}
 
 	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];

base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
-- 
2.34.1

