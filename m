Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A723AC433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88894207BC
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3uBlyDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgE2Ivy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgE2Ivh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:37 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B060C08C5CA
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:36 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x6so2472289wrm.13
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DvIgrHUiH2ABGw/jGLUuC8AlH0nKKG7Z7r1VC6CPdHE=;
        b=X3uBlyDdKP7USIdPN3RGAllPgiQoOlswdxApvHlxb/4yp90tDdj534cLU1R62MaI9M
         5I1/U9a+xnr5RegGjvbGbkvEeYumOaww4GdKbsq9x3U17LzVwEKVoRGmz9ZEIb6i9NPw
         FPQq1Y1kt5ywQrgIrRhuUzUkdnGy10jBau0a3xMQJn7QY8C91KwP5YQPPKGDRR9zB1gs
         Ygxlq2NgnnSGnTPvYwkqUgtO8RO+k3O0q5AlAlzNiHyVCZTnifj3oLdVsHmc9rHpt50l
         2qSFRuZogkciaSCmbSe3j7ySEq5KwuIOamomEO7+aW3faaGshm/xNvZ7c6nwyHkRidAE
         czzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DvIgrHUiH2ABGw/jGLUuC8AlH0nKKG7Z7r1VC6CPdHE=;
        b=aocnErldmbelnnNWWh24xlsyJqHDky4cP/zVEGi3FOFITg+wpowps/j0HqIPa36N5O
         f2B/mYwTfCV788nG4fTMpz6bGMxo0IB8A+aq2CAR8QguwEGb8G8/sPsjZpXlkM0MXJZ0
         Zqoz37pA51U7ikqMpF/x54OH5ythfFV+kRAmjPxuEn/gkXXD1j1z+wvgh2wYurBaljiY
         o/wmnHmv4Av/3xQmnmRyXwiDhwvylR/do2pNAeeyWtaCkRCP4xYSZN3+k2d48tFYsy+P
         c99Nt/Kpix4LFNOZemab2UZw4S09XzE/QKtj3zJVW3ABE6p621SZVBSqiyQGCW1v+kuB
         1Jmw==
X-Gm-Message-State: AOAM5334japVeQE5dPam4S1wA3mTtWnU9aNtmMZhCF4Y5QWyoOV4coxt
        TNt2rK3rJZ/eZxnrDG3UE7JDY0iy
X-Google-Smtp-Source: ABdhPJzbMFN9uaRLHPf2wcGaNUDYyVbuqZ8GzO14XIb6SvR+tO1erdSUXqAT7LEQi83k6CirgCruVQ==
X-Received: by 2002:a5d:4d0d:: with SMTP id z13mr8179942wrt.220.1590742294611;
        Fri, 29 May 2020 01:51:34 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:34 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 24/34] commit-graph: check all leading directories in modified path Bloom filters
Date:   Fri, 29 May 2020 10:50:28 +0200
Message-Id: <20200529085038.26008-25-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The file 'dir/subdir/file' can only be modified if its leading
directories 'dir' and 'dir/subdir' are modified as well.

So when checking modified path Bloom filters looking for commits
modifying a path with multiple path components, then check not only
the full path in the Bloom filters, but all its leading directories as
well.  Take care to check these paths in "deepest first" order,
because it's the full path that is least likely to be modified, and
the Bloom filter queries can short circuit sooner.

This can significantly reduce the average false positive rate, by
about an order of magnitude or three(!), and can further speed up
pathspec-limited revision walks.  The table below compares the average
false positive rate and runtime of

  git -c core.modifiedPathBloomFilters=1 rev-list HEAD -- "$path"

before and after this change for 5000+ randomly selected paths from
each repository:

                    Average false           Average        Average
                    positive rate           runtime        runtime
                  before     after     before     after   difference
  ------------------------------------------------------------------
  android-base    0.526%   0.00416%    0.1727s   0.1503s   -13.0%
  cmssw           0.494%   0.00395%    0.0426s   0.0332s   -22.0%
  cpython         0.213%   0.01661%    0.0940s   0.0858s    -8.8%
  elasticsearch   0.679%   0.00325%    0.0191s   0.0147s   -23.2%
  gcc             0.398%   0.00892%    0.3423s   0.2192s   -36.0%
  gecko-dev       0.472%   0.00073%    0.6243s   0.5134s   -17.8%
  git             0.191%   0.06992%    0.0384s   0.0319s   -17.1%
  glibc           0.392%   0.01639%    0.0425s   0.0296s   -30.5%
  go              0.453%   0.01262%    0.0515s   0.0425s   -17.5%
  jdk             0.662%   0.00643%    0.0083s   0.0070s   -15.0%
  linux           0.434%   0.00749%    0.1102s   0.0911s   -17.3%
  llvm-project    0.511%   0.00391%    0.4865s   0.4290s   -11.8%
  rails           0.476%   0.01313%    0.0464s   0.0410s   -11.6%
  rust            0.457%   0.02551%    0.0590s   0.0462s   -21.7%
  tensorflow      0.511%   0.00824%    0.0642s   0.0517s   -19.5%
  webkit          0.661%   0.00101%    0.3315s   0.2576s   -22.3%

The improvements in runtime are much smaller than the improvements in
average false positive rate, as we are clearly reaching diminishing
returns here.  However, all these timings depend on that accessing
tree objects is reasonably fast (warm caches).  If we had a partial
clone and the tree objects had to be fetched from a promisor remote,
e.g.:

  $ git clone --filter=tree:0 --bare file://.../webkit.git webkit.notrees.git
  $ git -C webkit.git -c core.modifiedPathBloomFilters=1 \
        commit-graph write --reachable
  $ cp webkit.git/objects/info/commit-graph webkit.notrees.git/objects/info/
  $ git -C webkit.notrees.git -c core.modifiedPathBloomFilters=1 \
        rev-list HEAD -- "$path"

then checking all leading path component can reduce the runtime from
over an hour to a few seconds (and this is with the clone and the
promisor on the same machine).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 commit-graph.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f9a21ecdfb..1fd1b4f8dd 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -977,8 +977,10 @@ void init_pathspec_bloom_fields(struct repository *r,
 
 	for (i = 0; i < pathspec->nr; i++) {
 		struct pathspec_item *pi = &pathspec->items[i];
-		const char *path = pi->match;
+		const char *path = pi->match, *p;
 		size_t len = pi->len;
+		int path_component_nr = 0, j;
+		uint32_t *hashes;
 
 		/*
 		 * Pathspec parsing has normalized away any consecutive
@@ -988,13 +990,28 @@ void init_pathspec_bloom_fields(struct repository *r,
 		if (path[len - 1] == '/')
 			len--;
 
-		pi->modified_path_bloom_hashes_nr = graph->num_modified_path_bloom_hashes;
+		p = path;
+		do {
+			p = strchrnul(p + 1, '/');
+			path_component_nr++;
+		} while (p - path < len);
+
+		pi->modified_path_bloom_hashes_nr = path_component_nr * graph->num_modified_path_bloom_hashes;
 		ALLOC_ARRAY(pi->modified_path_bloom_hashes,
 			    pi->modified_path_bloom_hashes_nr);
 
-		compute_modified_path_bloom_hashes_for_path(path, len,
-				graph->num_modified_path_bloom_hashes,
-				pi->modified_path_bloom_hashes);
+		p = path;
+		hashes = pi->modified_path_bloom_hashes +
+			 pi->modified_path_bloom_hashes_nr;
+		for (j = 0; j < path_component_nr; j++) {
+			p = strchrnul(p + 1, '/');
+
+			hashes -= graph->num_modified_path_bloom_hashes;
+			compute_modified_path_bloom_hashes_for_path(path,
+					p - path,
+					graph->num_modified_path_bloom_hashes,
+					hashes);
+		}
 	}
 
 	pathspec->can_use_modified_path_bloom_filters = 1;
-- 
2.27.0.rc1.431.g5c813f95dc

