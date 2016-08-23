Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CEF72018E
	for <e@80x24.org>; Tue, 23 Aug 2016 16:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753846AbcHWQHp (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:07:45 -0400
Received: from mout.gmx.net ([212.227.17.22]:53096 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753065AbcHWQHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:07:16 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LtEtL-1bAV8m3vPH-012mnd; Tue, 23 Aug 2016 18:06:48
 +0200
Date:   Tue, 23 Aug 2016 18:06:46 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/15] sequencer: lib'ify do_pick_commit()
In-Reply-To: <cover.1471968378.git.johannes.schindelin@gmx.de>
Message-ID: <92fdb70f3db157f8a3d2442d872e989d81c6756e.1471968378.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RLbqoj1S0HMSC8oTvYmwoEBog6T1trZmGMRJOcxmmzV253t2R6U
 L1/NxjbfgNB76kKUFtUq7IyTjqk99CrwVtqj4H5kbbtCqCVwa3+zS5KQNRDiMReV3o0XFOH
 zDLTB9FnCybaui9QtCjqCxnJFZhZnvAMN4D9M6uS8YMWBVWqIv8TSXveZMhCYfB/mNUD2bA
 MXpB3VMybcuQb5ltRmqHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fQbUPFgssxA=:CJXZdRlDwi62t680gFh9Tv
 Pjuk2dyugmEDMrk00M+PayUW4elA4xqPjlUc8YOsJkfVLKFmnZVC/d3mWKchHOhWvnAopfiHc
 Erk9A8F3HOvzQq2HhDIXAg6B0TdybQGAJKsFX4rsWbuIuF6KAJZFR9E11fwgb/8PAXkkmaal2
 8r+8Buz8xI7szUMeYAZzJMuYGvty1bQkxhglv+AbHvZjgaInZkoM1PeuBQ70s5m3pOyi1WEXY
 2s0h3B9M9OluE1e7nUFDKJqWUJMqNsc0JfX36sVlRXjgT0gps131/QDYb069IXPBVNcHJJn6q
 So2qHGvcQWalAPOEemf+WLbG7aI65VGwC09/1gkkcJcNjCWmLnbvGdavMf2ka3uPiwchtJxT/
 nCozWz/8GLNWLCPJTwxrtfJy479jcNyqjQNOrcO7FEd6AEw1+hucCM4tlULHDo7Lv7F/CXNwk
 Qz0nEXAUhR+CjfcKhru+2SsIRF5pmhlociUlpqFsaKDVoium/jQyoCML9nvjoyrypWsSknw+l
 cAetIRRhxpLPcO0YiIUQ3T79N97K+7GpnF4eV6PukxVUNki5WCWz6OpsNhpNCazlt5d4PW3vz
 MInkseLp3sGS4bmxHysvAken3Q1MovIjWMdeks27vlIygaz9z5Qjrjeava6rzrOBgeE9qNrZq
 YMbyb4LP2V2ou2+4n/e3VUsw1TviQVdP3/5Lhe/6woMOR9+Grh5ykwTL5k5SOjFXiQmx4rNaR
 3wufR30+HsvHzkzEOIehFDqwWeqTHs4tEvkXmD9ZYyF1KOnnO/ibPCCzuHSpQYU/c9Z9SciI1
 mDlXfDT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To be truly useful, the sequencer should never die() but always return
an error.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 0c8c955..6ac2187 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -464,7 +464,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		 * to work on.
 		 */
 		if (write_cache_as_tree(head, 0, NULL))
-			die (_("Your index file is unmerged."));
+			return error (_("Your index file is unmerged."));
 	} else {
 		unborn = get_sha1("HEAD", head);
 		if (unborn)
-- 
2.10.0.rc1.99.gcd66998


