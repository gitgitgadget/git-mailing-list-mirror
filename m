Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1208207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755267AbdEDN6e (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:58:34 -0400
Received: from mout.gmx.net ([212.227.15.19]:58142 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755201AbdEDN62 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:58:28 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M08eS-1dwC4C1S5k-00uMfL; Thu, 04
 May 2017 15:58:16 +0200
Date:   Thu, 4 May 2017 15:58:01 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 19/25] line-log: avoid memory leak
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <e03becb8f844f5d5a465b3871f3369f6bc561261.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NPK5xDPjR9+nnI2Owi4uqriqWByMVXOhcmjSVNMXIiYdZyQXR6O
 BTQ5Dv9hRnkm59v+FeexXkQSZz3ezHjMsEMmTlCTiun0PEAHOudB722dOE0lhDiMyFOLeYd
 bqRfu2vENK5iah947B2ffgjWAUlQhoku50iCE6uQRh0s8Garg6wVa254gm9uu88bBhGrDTR
 kjAa8cDz6Jl3jBGZWWqZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LCJRLsEpY74=:6Sq+ZRkckXcX/NfYNWEQzW
 kPwNAlmjaZOlB1Lh5aDOii5oZMCBO6tBv0GxeQgQYQRLj7AkcqF5RyFoNemuGnuzj6S2KB4hZ
 6Up6m4yLHlzhEz15wt/acgvfR4GqxMRITE855/EM37CJmdufF6I0drA9S8fTHilhqzJeAtGAr
 Z1o+2ikc697Mf6D6PpH4868tFDlC7rmrTnmMEAptDAu2ZWGqifROP/4t0C4DdwCVJG+SW4wse
 YWzi1OHkUtUJXkXDTq+J46n2XZsIOCPRkvmMrvdRDRTUsbvp7QhwqhMOy0ORsCAR5goW3mLfY
 NL5xWxKvUzhGSrLululzAhpb7/+sUNdKBg6z4GdizmIg4XMUfCWUOip5LLtkHn3BHav87at7t
 voFYt+48+FPlOi3yE4CyV5vkkK+qNj6gB9yJZhZE47KioBr6oVTQsDfs6SdEczw6CyNFYUmXd
 PEcXtqQN32oYzS84PV6xVvxL6giOBHA0O5aIWiNGTtdDXRDQkw5tU4bH03iBPyEC20aq0kG0J
 98j+kFoywz+q/RVwitkC5zDyboN4Gf2BjXTu413BbxSiSnafW7CM4woQmsBEzbDnhR+VnJQuq
 iaq94kY9ndp4ONZSKzyPGcc0hllIKezsr201YraWz99eG70VjgBOkiSy1khdjGRdAR9kIdxTu
 3tgQJ1A8xY614EmbkM3OwxIyijiO+Qv3Cm1LYzN36+at3O+G69h78XKBvcoC52Z2X36Qk1+oD
 Wl7k0aVr68+lw5ZAj2esiHyTBm/roYxHQ/m85CYSrvtWVH8TGf/2Wq+QmvPg6ht3mDu/DHsui
 PgUE09J
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Discovered by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 line-log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/line-log.c b/line-log.c
index a23b910471b..b9087814b8c 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1125,6 +1125,7 @@ static int process_ranges_ordinary_commit(struct rev_info *rev, struct commit *c
 	changed = process_all_files(&parent_range, rev, &queue, range);
 	if (parent)
 		add_line_range(rev, parent, parent_range);
+	free_line_log_data(parent_range);
 	return changed;
 }
 
-- 
2.12.2.windows.2.800.gede8f145e06


