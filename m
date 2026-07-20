Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C865A397E6A
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 22:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784586688; cv=none; b=oiR0ekNrcmj3JW0XCc5LfAugDH37EhhoOBOSdt2+lEaT8Nm4o6i8t+/EVP/YQ9qD4GC1X5SKgJGRhv4CyzI0o7rEJC2HEQ+K4ks0rv4MPx/cdaSg5lShq69UzFIeAiRS/nEchgaHQYk3ELKeM83rbatKr1li1GptrFV/ja7KcMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784586688; c=relaxed/simple;
	bh=ZB4f3C8ThrfrKcSIRzXCypvq62IovV+SwrNUNFJKcWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8kEfU6/iqr+H+T+mdN4OrTTkc+jPBz4uS21ronfiGCG7sGLj3clImhk/LgsHf91tdSlg+T82UqX4+qsXR+iTOGzuS8isatV//bWd6bSI+7J542J6D3vCFv0IRntSva9Daug7a78An56Mixg/QA7IPbS7RHCi2tn2F4jGvVWoNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=CrJxDFzC; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="CrJxDFzC"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51ca592e80eso10326461cf.2
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 15:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784586686; x=1785191486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=93Iskaj7klKB7kqtNVIduSBzEafJMamPu5thztFoC4Y=;
        b=CrJxDFzChqAFJbteqYhlSq673eh9vtcKUzLF/jGeFuBrTEgSvz8NOeeCPgxYA4RWIV
         zhgRlhh4BM5Ev4VidFc28M9gdLM4qqfi/pu1cPjQKEjrFtlHL45fyr+NmVqij6RgPCIe
         eFioYUUv/Q+fMQ6eGhSpdxT5pPGH0XJ+bnd40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784586686; x=1785191486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=93Iskaj7klKB7kqtNVIduSBzEafJMamPu5thztFoC4Y=;
        b=luRRR0a80LHivqwHXqJManVf4bayzgdfMZ1v5ccbCN8VZBS12y8XkpPTqpqKVxN2Au
         FlIqOV7zV5kcFitG3dDk9ItffLev2JctGMeo6FejHAJWuI6HzwiBEZoZR6f5QVTRMu0U
         QFPtL9S7bmZuL903gDtIj6SUQjxxYuOEIjt9V24CmO3Wd/dadhQDuPTvvyypswSFs2qN
         8RmCoEaeVmSw2WQRuhzEHJQ9d9tqlC7NoE076x5DNv67+XGhzRl7K+rK5XHoa7dcKMx6
         KTb0oznfYGE8TgFq6rb+KTL7WrojzPRjXPb93/H5SN/ZxSEgv0zYyf7L3hqhmTwNBbiM
         PH3w==
X-Gm-Message-State: AOJu0YxEgwQJ92hyyOr0w5ONlbDmyCXY6FQwi8vUCDWylDKM55vyxhgt
	VetJ+hNrNyIwaFlGaRdo879JL7Hi9K5rOw8hEu1l1ANtnN2whDrxNFpO7vZVc267LQxGXmYwz+m
	g6lfd4bo=
X-Gm-Gg: AfdE7cnLGA/0VnD4mDlzM9v/udMJKv0uVhXzu88n7mQY+SlUgxMzDXBwRpNOHt9EKLI
	iUJTJ3DmXM5EAN0niLVDq0kSydby4WYrZ7vVMFe16sWp6xs55K8YX2uTpzWGHXfUEz+He9ehYXF
	3tXUUu83q8FILyARpCU7nonpJXqFwFucqhv2m84ClwsgY8NcBQoDHxlD209b8UaBX4eBDRwtwnl
	7vryPeNnKS1BZty4GBvJD+NQVCCbFqKBa2+7oH7YAcvCpGNOrOKhBieOv7vlvMF2Vdkp5/y6/Yy
	t/9q/bdklegRCDeyFSkIcRIAcOUEIi8FewLaGgdiLjvTEdUJmWgNYtlrV4jhn1L9Ocd9MsAjcSy
	bqG44MJrJje4yw+FMPjvmPiJHKsG6pNEFj8agtR3I49fieZnHPl0YHfjbhnISZCIcjK5XJoZF76
	WnsQkCk4PX0nseGCksfe/wZdfdeTgIKtUFEKa9l3oz4mTFlwov//FoDA8pXum/RICpVimnKNtfU
	eMSBbU=
X-Received: by 2002:ac8:614c:0:10b0:51c:215:3e81 with SMTP id d75a77b69052e-526734b9a04mr5248391cf.4.1784586685450;
        Mon, 20 Jul 2026 15:31:25 -0700 (PDT)
Received: from com-76773.corp.openai.org ([209.249.37.132])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214d095ed4sm81232211cf.10.2026.07.20.15.31.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 15:31:25 -0700 (PDT)
From: tnyman@openai.com
To: git@vger.kernel.org
Cc: Ted Nyman <tnyman@openai.com>,
	Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Jeff King <peff@peff.net>,
	Victoria Dye <vdye@github.com>
Subject: [PATCH 1/2] pathspec: use match for sparse-index expansion checks
Date: Mon, 20 Jul 2026 15:31:20 -0700
Message-ID: <20260720223118.62821-5-tnyman@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720223118.62821-4-tnyman@openai.com>
References: <20260720223118.62821-4-tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ted Nyman <tnyman@openai.com>

The pathspec parser computes `len` and `nowildcard_len` from
`item.match`, which includes any prefix added when a command is run
from a subdirectory. `item.original` can still contain the shorter,
unprefixed argument.

Using `item.original + item.nowildcard_len` in
`pathspec_needs_expanded_index()` can therefore read past the end of
the allocation. AddressSanitizer reports a heap-buffer-overflow for
prefixed wildcard pathspecs passed to `git rm` and `git reset` with a
sparse index.

The mismatch dates back to 4d1cfc1351 ("reset: make --mixed
sparse-aware", 2021-11-29), which introduced the helper using
`item.original`. b29ad38322 ("pathspec.h: move
pathspec_needs_expanded_index() from reset.c to here", 2022-08-07)
later moved it to `pathspec.c` and preserved the affected comparisons.

Use `item.match` consistently when checking whether a pathspec can
match a sparse-directory entry. Add coverage for prefixed wildcard
pathspecs so both commands keep the index sparse.

Signed-off-by: Ted Nyman <tnyman@openai.com>
---
 pathspec.c                               | 12 ++++++------
 t/t1092-sparse-checkout-compatibility.sh |  7 +++++++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index f78b22709ccb67..281858f21f9c59 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -847,9 +847,9 @@ int pathspec_needs_expanded_index(struct index_state *istate,
 			 * - not-in-cone/bar*: may need expanded index
 			 * - **.c: may need expanded index
 			 */
-			if (strspn(item.original + item.nowildcard_len, "*") ==
+			if (strspn(item.match + item.nowildcard_len, "*") ==
 				    (unsigned int)(item.len - item.nowildcard_len) &&
-			    path_in_cone_mode_sparse_checkout(item.original, istate))
+			    path_in_cone_mode_sparse_checkout(item.match, istate))
 				continue;
 
 			for (pos = 0; pos < istate->cache_nr; pos++) {
@@ -865,7 +865,7 @@ int pathspec_needs_expanded_index(struct index_state *istate,
 				 */
 				if ((unsigned int)item.nowildcard_len >
 					    ce_namelen(ce) &&
-				    !strncmp(item.original, ce->name,
+				    !strncmp(item.match, ce->name,
 					     ce_namelen(ce))) {
 					res = 1;
 					break;
@@ -876,13 +876,13 @@ int pathspec_needs_expanded_index(struct index_state *istate,
 				 * directory and the pathspec does not match the whole
 				 * directory, need to expand the index.
 				 */
-				if (!strncmp(item.original, ce->name, item.nowildcard_len) &&
-				    wildmatch(item.original, ce->name, 0)) {
+				if (!strncmp(item.match, ce->name, item.nowildcard_len) &&
+				    wildmatch(item.match, ce->name, 0)) {
 					res = 1;
 					break;
 				}
 			}
-		} else if (!path_in_cone_mode_sparse_checkout(item.original, istate) &&
+		} else if (!path_in_cone_mode_sparse_checkout(item.match, istate) &&
 			   !matches_skip_worktree(pathspec, i, &skip_worktree_seen))
 			res = 1;
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 9814431cd74aff..d0b42371663f9d 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2119,6 +2119,13 @@ test_expect_success 'sparse index is not expanded: rm' '
 	ensure_not_expanded rm -r deep
 '
 
+test_expect_success 'sparse index is not expanded: prefixed wildcard pathspec' '
+	init_repos &&
+
+	ensure_not_expanded -C deep rm --dry-run -- "a*" &&
+	ensure_not_expanded -C deep reset base -- "a*"
+'
+
 test_expect_success 'grep with and --cached' '
 	init_repos &&
 
