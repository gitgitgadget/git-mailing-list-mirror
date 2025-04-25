Received: from postout1.mail.lrz.de (postout1.mail.lrz.de [129.187.255.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B509D2701DA
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.187.255.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745596859; cv=none; b=AL1fG5QMj0nD4Lbiw0Y6DDi1PTxbUghNziIomEO/co7k+gUs5ZJeki/bxWlYDTZgqSbS/QoOeM7H/kjAezzB1hE2eRmxAowpdKI/DmBJE8iOIEPHjeOVrt3mVYrUsmmyNxSaCM59x0qgIkfnqfr+oJYgwgA7oM9dEfhaB6rcCZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745596859; c=relaxed/simple;
	bh=l49GumX2xgoI8VVX3HBIOMmBk6D5gM95Q9qyz97JTp0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MVpr9fGkrpvusAxuI8Pt36c8zU4oJR3vNpF+3QYTVirXhfQfBDFvDXNK/4YWZvJ9ufz1bRqSfJTB+V8cgT8oRiqPujgAmMsH6rvkWxBLe/YmqnzoOuJ+zYWNmnjC/etddylCJ2Vzak1xJtYcPLE9eSW1aDM+GQgaJ1Cg2C9q0cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=campus.lmu.de; spf=pass smtp.mailfrom=campus.lmu.de; dkim=pass (2048-bit key) header.d=lmu.de header.i=@campus.lmu.de header.b=KTHwCWdv; arc=none smtp.client-ip=129.187.255.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=campus.lmu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=campus.lmu.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lmu.de header.i=@campus.lmu.de header.b="KTHwCWdv"
Received: from lxmhs51.srv.lrz.de (localhost [127.0.0.1])
	by postout1.mail.lrz.de (Postfix) with ESMTP id 4Zkcy22YG8zyTV;
	Fri, 25 Apr 2025 18:00:42 +0200 (CEST)
Authentication-Results: postout.lrz.de (amavis); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=lmu.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmu.de; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=
	lm-postout21; i=@campus.lmu.de; t=1745596841; bh=lb6TaFPrvuyTcar
	MAvO+IcHqQdJtDrT9CvSRtptdWaU=; b=KTHwCWdvznoCDisIBG2VFFYaTpE8R/B
	WxYlRS0YQUQPSztVJZWWESnldaQSuyUE6YyGY2jVtvnnZ26n5jYGThGq3hGyS/Jk
	r3KQmNWqnpOxo7nc4OFltkNU3dA7mnjofb36u0jmGjK745TGLn8/9fSiDJgmEaBq
	eOHQxSHsiX9MzFN44pI0Amn8/H8nzj+RXc718iJZBgJPrjuEcUFtNlgKCot5q+lu
	c0dZ4gF5/0G0tIjCUHt7IC//a6iwkTqVswid7SUqMfH4R+OTTYLq0jP1t/iWzyie
	dr4V6UAHC1UciW/NCVQXOsSLTXkORib4MFpI8dRSysnPrvgOfrv5iMw==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs51.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.887
X-Spam-Level:
Received: from postout1.mail.lrz.de ([127.0.0.1])
 by lxmhs51.srv.lrz.de (lxmhs51.srv.lrz.de [127.0.0.1]) (amavis, port 20024)
 with LMTP id QlzqS-MMpIbl; Fri, 25 Apr 2025 18:00:41 +0200 (CEST)
Received: from niels-ubuntu-2023.eduroam.mwn.de (unknown [IPv6:2001:4ca0:0:f238:2a2d:9746:48e5:3e2e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by postout1.mail.lrz.de (Postfix) with ESMTPSA id 4Zkcy05lvfzyVM;
	Fri, 25 Apr 2025 18:00:40 +0200 (CEST)
From: Niels Glodny <n.glodny@campus.lmu.de>
To: git@vger.kernel.org
Cc: johannes.schindelin@gmx.de,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	Niels Glodny <n.glodny@campus.lmu.de>
Subject: [PATCH] xdiff: disable cleanup_records heuristic with --minimal
Date: Fri, 25 Apr 2025 17:59:51 +0200
Message-Id: <20250425155951.1227700-1-n.glodny@campus.lmu.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cleanup_records function marks some lines as changed
before running the actual diff algorithm. For most lines,
this is a good performance optimization, but it also marks
lines that are surrounded by many changed lines as changed
as well. This can cause redundant changes and longer-than-
necessary diffs.

Whether this results in better-looking diffs is subjective.
However, the --minimal flag explicitly requests the shortest
possible diff.

The performance impact of this change is negligible, and it
results in shorter diffs in about 1.3% of diffs in Git's
history.

Signed-off-by: Niels Glodny <n.glodny@campus.lmu.de>
---
 t/meson.build           |  1 +
 t/t4071-diff-minimal.sh | 16 ++++++++++++++++
 xdiff/xprepare.c        | 22 +++++++++++++---------
 3 files changed, 30 insertions(+), 9 deletions(-)
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
index 0000000000..3ad759dab4
--- /dev/null
+++ b/t/t4071-diff-minimal.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+
+test_description='minimal diff algorithm'
+
+. ./test-lib.sh
+
+test_expect_success 'minimal diff should not mark changes between changed lines' '
+	printf "x\nx\nx\nx\n" >pre &&
+	printf "x\nx\nx\nA\nB\nC\nD\nx\nE\nF\nG\n" >post &&
+	test_must_fail git diff --no-index \
+		--minimal pre post >diff &&
+	! grep "+x" diff &&
+	! grep "-x" diff
+'
+
+test_done
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index c84549f6c5..cb0b6c9fd6 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -61,9 +61,11 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			   xdlclassifier_t *cf, xdfile_t *xdf);
 static void xdl_free_ctx(xdfile_t *xdf);
 static int xdl_clean_mmatch(char const *dis, long i, long s, long e);
-static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2);
+static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1,
+			       xdfile_t *xdf2, int need_min);
 static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2);
-static int xdl_optimize_ctxs(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2);
+static int xdl_optimize_ctxs(xdlclassifier_t *cf, xdfile_t *xdf1,
+			     xdfile_t *xdf2, int need_min);
 
 
 
@@ -279,7 +281,8 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 
 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF) &&
-	    xdl_optimize_ctxs(&cf, &xe->xdf1, &xe->xdf2) < 0) {
+	    xdl_optimize_ctxs(&cf, &xe->xdf1, &xe->xdf2,
+			      (xpp->flags & XDF_NEED_MINIMAL) != 0) < 0) {
 
 		xdl_free_ctx(&xe->xdf2);
 		xdl_free_ctx(&xe->xdf1);
@@ -363,7 +366,8 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
  * matches on the other file. Also, lines that have multiple matches
  * might be potentially discarded if they happear in a run of discardable.
  */
-static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
+static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1,
+			       xdfile_t *xdf2, int need_min) {
 	long i, nm, nreff, mlim;
 	xrecord_t **recs;
 	xdlclass_t *rcrec;
@@ -379,7 +383,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
 		rcrec = cf->rcrecs[(*recs)->ha];
 		nm = rcrec ? rcrec->len2 : 0;
-		dis1[i] = (nm == 0) ? 0: (nm >= mlim) ? 2: 1;
+		dis1[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
 	}
 
 	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
@@ -387,7 +391,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
 		rcrec = cf->rcrecs[(*recs)->ha];
 		nm = rcrec ? rcrec->len1 : 0;
-		dis2[i] = (nm == 0) ? 0: (nm >= mlim) ? 2: 1;
+		dis2[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
 	}
 
 	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
@@ -449,10 +453,10 @@ static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
 }
 
 
-static int xdl_optimize_ctxs(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
-
+static int xdl_optimize_ctxs(xdlclassifier_t *cf, xdfile_t *xdf1,
+	xdfile_t *xdf2, int need_min) {
 	if (xdl_trim_ends(xdf1, xdf2) < 0 ||
-	    xdl_cleanup_records(cf, xdf1, xdf2) < 0) {
+	    xdl_cleanup_records(cf, xdf1, xdf2, need_min) < 0) {
 
 		return -1;
 	}

base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
-- 
2.34.1

