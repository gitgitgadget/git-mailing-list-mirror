Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EFE8207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936391AbdDZUU5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:20:57 -0400
Received: from mout.gmx.net ([212.227.15.18]:62663 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966731AbdDZUUy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:20:54 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LymHf-1e96mQ3NJP-0168Ox; Wed, 26
 Apr 2017 22:20:45 +0200
Date:   Wed, 26 Apr 2017 22:20:45 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 13/26] split_commit_in_progress(): fix memory leak
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <1f5cb7cd40ad0856dc05d92178756df6c005c69f.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:luX/MK/q7hSQl/esOw3DwdL+NBbHu+glr2FlfLoKEnap5cyZv5g
 yLqMMUmTygdP3AnxrUm2ip7O4dDSicAL9tBkIkKkGfQKbKzteRv3pWaH/wzXtAqezBR9dAP
 4qrOlp/JN+mSAtcNbsHUdZZ1v93S30jA3t37mKVjHSMGMCrCN/UwddAcwz1K3JX8kespBmz
 5SG04HRizt57zbDYXa5qA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rTK+fCZDhBg=:3Jk+vP4GLchH1/xu+ZLMi5
 te7YliWg6SOruVWUPaRsNCtORPtrSnvPioI4nsBLCA87RwZkdxjyUZwdJu8g5TuSYdkok8IAs
 wprIbjEUotak5Sy3tLlGuWFK0SAyizp/yIxJB5UvVrOtALyq76mReQha+iMWXVkovO8Gp+r3a
 Fq65uVzr7X6lptNtAyUsGMetk9h2V/jNdmZYVy6qv/cjK8G+ioDBQV2mKGfJJX2ZNAq9YgLGl
 eue0G02LZwqF4rOD2DX9qpOpBVyv7RUm/4cyO8Um1Y/aqeBFQobRu6jTlBQAOygIRB+h9Y1GV
 fGHouO/QyACC6vHdcsb9bXPDg6Xy34vs/+Y0juso57G/2is62UiKupPkhKO+cz45q1R2FfSxE
 BhZ6Z/2TIm/QADZKmkYd/gRMVNHNpyB3Zd6JFM+zFLSqoIaHHsUP+HaVf4DuSTET8qftNCTwM
 xx38z1A/73JC3YtEZB9I4a2CDeneA54+N/IjVFFcmo19UxMgKVNc6vLo1PRD+tr6cYzxkBA9L
 vRLHUacZrxX6kBur22QP56K4oPSR9VD1kNVDG95Yn1VIDX/bNMgORixsbVFzbEE+xy5MDQYjz
 ZlPeoAHUKYHmsGhirCTdmi/iVfkHB/Fyi84KqlNcyTmuwyb7j81/1E1R22bmu7+7Kx2w4ssbD
 GG2nb8Zcwzg+cArS5J7iWmqKdcvjsQENjZbVXJoMHLCngTTW3jxoxJoS2MM9Rd3AXBKHFLNYh
 fDPl3xD5FFluXO/gOcc+op1aL2XUK/qBjhNHWZSOf3yIIKhEx3zWHodsUyz9D4snCQw+YFjxc
 5Zh5xX5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 wt-status.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index 0a6e16dbe0f..1f3f6bcb980 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1088,8 +1088,13 @@ static int split_commit_in_progress(struct wt_status *s)
 	char *rebase_orig_head = read_line_from_git_path("rebase-merge/orig-head");
 
 	if (!head || !orig_head || !rebase_amend || !rebase_orig_head ||
-	    !s->branch || strcmp(s->branch, "HEAD"))
+	    !s->branch || strcmp(s->branch, "HEAD")) {
+		free(head);
+		free(orig_head);
+		free(rebase_amend);
+		free(rebase_orig_head);
 		return split_in_progress;
+	}
 
 	if (!strcmp(rebase_amend, rebase_orig_head)) {
 		if (strcmp(head, rebase_amend))
-- 
2.12.2.windows.2.800.gede8f145e06


