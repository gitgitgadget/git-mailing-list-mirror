Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A02C51FBB0
	for <e@80x24.org>; Fri, 25 Nov 2016 16:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755231AbcKYQg2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Nov 2016 11:36:28 -0500
Received: from mout.gmx.net ([212.227.17.22]:58644 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755107AbcKYQg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2016 11:36:27 -0500
Received: from virtualbox ([95.208.59.208]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LpwZn-1chCKY43NP-00ff5h; Fri, 25
 Nov 2016 17:36:22 +0100
Date:   Fri, 25 Nov 2016 17:36:20 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Markus Klein <markus.klein@reelworx.at>
Subject: [PATCH 1/2] cherry-pick: demonstrate a segmentation fault
In-Reply-To: <cover.1480091758.git.johannes.schindelin@gmx.de>
Message-ID: <89ffd6eaf4e1e121426c84f31dfc9c289f2a948b.1480091758.git.johannes.schindelin@gmx.de>
References: <cover.1480091758.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ByR5cxIcs1iG8tKsX7paE1WxlPPeKLzVzS8lASsF2g3ljHuIMuV
 bNc5Ijsc7W/qV2Lm1xV2tKf1jin8ZX5ZwunTAyYHFp38A7dkn4D6HFgm74uk+X1kcg0ui0y
 WthiH9huJjqyvYXL5AkjBVSuwP2tEzyY9v9pZYp3rA5mv+oNiEEj7GxmKb/EpuRUWUKY41y
 nEUjXSClKTwQyk6sohKuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q5+/x4U1HwA=:oDfCljndbOy7xEzGXMDj4J
 uYEzQP4GoaeZ3xRH3U6A1mb4DUAHda0hKcaQ7OsQUqUU5vhWDscBmNAlGR8rZR9pCJ7pwSifd
 ERzIji9dwT+ysucRnlKFcWE6jSRX/jD09TR9R+esaHwjNpiLp1yIBrLQdw/xxAFRr5CoMsmJ5
 67xEj9A7NRQyvZP0cjx2dgZewNmozsJyWTsKcAkwxzVB/LfQtXY1A1e1yGkcelarxyWQtdGkR
 jRs+tqosZBzCQ/+En/EWHaJNvdOkloabyDeLtQ+PrEKpszL+pFBYN+u+1b+eMnEmZ6alPW00U
 /R2mG0U95K9LpFS8KQFZ2W/s18pylPLNZobjZevAM04DFq/aA9UCEfkaf9vIKWoat5pBM+ccM
 D9nQ0GVuwVPLsBsE1n8tyR57y92zTOaeTMgyCv4CVq23rK2Q6zanLbUfCJZ62c6HnKnJpttlC
 HmQPPmhds3Qi5CHsVBxgnSLPzDf1NKwHqr7pgJPaLWci9yUPF4bDZgYsYoUj+3Gc/daxNwYoN
 j2YHJ8uAtiBGqZ81M6/CxBu0TZK+YVLHQGXOGlMFzFFmSccdkZbgRuXUtIyH2aMpKJUTfw3D2
 ZkZSBJjJB0EOfMLOUMXJ3OV3avzegvg+5gZ5pqn/FMumcU58f7SbjcxrHZSFvJTaBHUY6IVIh
 kLwWAhSg4zgh6sop8tMQ4qXzcNfJG3oGLswzg81USV3ZKLYcXKKO68jHsmEgBGHT06ulzUqYk
 0W32UXBbe/QLeySsFHKulNA3IuM2eHmd2Q0fF7pF9rSsk92HnfxNt+bcbIjZNa+qnFgFsmQCQ
 gBlRnWO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In https://github.com/git-for-windows/git/issues/952, a complicated
scenario was described that leads to a segmentation fault in
cherry-pick.

It boils down to a certain code path involving a renamed file that is
dirty, for which `refresh_cache_entry()` returns `NULL`, and that
`NULL` not being handled properly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3501-revert-cherry-pick.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 394f0005a1..d96d391af3 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -141,4 +141,16 @@ test_expect_success 'cherry-pick "-" works with arguments' '
 	test_cmp expect actual
 '
 
+test_expect_failure 'cherry-pick fails gracefully with dirty renamed file' '
+	test_commit to-rename &&
+	git checkout -b unrelated &&
+	test_commit unrelated &&
+	git checkout @{-1} &&
+	git mv to-rename.t renamed &&
+	test_tick &&
+	git commit -m renamed &&
+	echo modified >renamed &&
+	git cherry-pick unrelated
+'
+
 test_done
-- 
2.11.0.rc3.windows.1


