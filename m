Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FBA71F406
	for <e@80x24.org>; Mon, 15 Jan 2018 12:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933591AbeAOMR7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 07:17:59 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47992 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933469AbeAOMRz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Jan 2018 07:17:55 -0500
X-AuditID: 1207440d-973ff70000000c05-19-5a5c9beff14b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id C6.C0.03077.0FB9C5A5; Mon, 15 Jan 2018 07:17:52 -0500 (EST)
Received: from bagpipes.fritz.box (p54AAEF2D.dip0.t-ipconnect.de [84.170.239.45])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w0FCHiEr010101
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 15 Jan 2018 07:17:50 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Kim Gybels <kgybels@infogroep.be>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/3] create_snapshot(): exit early if the file was empty
Date:   Mon, 15 Jan 2018 13:17:34 +0100
Message-Id: <02915e24958741927467ed750e9782d02ec40c80.1516017331.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180114191416.2368-1-kgybels@infogroep.be>
References: <20180114191416.2368-1-kgybels@infogroep.be>
In-Reply-To: <cover.1516017331.git.mhagger@alum.mit.edu>
References: <cover.1516017331.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsUixO6iqPtxdkyUwfKZohZdV7qZLBp6rzBb
        9C/vYrM42DmT1eL2ivnMDqwef99/YPL48DHOo+/IGkaPi5eUPT5vkgtgjeKySUnNySxLLdK3
        S+DKOHL1OGPBNY6KJVNfsjUwzmbvYuTkkBAwkfj89yVjFyMXh5DADiaJPc962CCci0wS11p/
        soFUsQnoSizqaWYCsUUEVCUOzp8C1sEssIJRYm1TD1hCWMBD4nxHO1gDC1DRk2cPWEBsXoEo
        iZm7W9kg1slLvF9wnxHE5hSwlDj6bhtYXEjAQuLToU/MXYwcQHELiXUXkiHC5hInv3eyT2Dk
        W8DIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10gvN7NELzWldBMjJNB4dzD+XydziFGAg1GJ
        hzdiWXSUEGtiWXFl7iFGSQ4mJVFe9d6YKCG+pPyUyozE4oz4otKc1OJDjBIczEoivI3BQDne
        lMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgTvillAjYJFqempFWmZOSUI
        aSYOTpDhPEDDn4LU8BYXJOYWZ6ZD5E8x6nLcePG6jVmIJS8/L1VKnLcLpEgApCijNA9uDixB
        vGIUB3pLmPcWSBUPMLnATXoFtIQJaEn9kkiQJSWJCCmpBsY56655ly0rN86uv79CRnRRkGFS
        /RSHHxMcldSS33O8+5K5X7LMa+YBw+zZH83D2s8JFnrF5veoMWaoXvpcLs7rm/Jdi3XCrry5
        zZmi8sezPXaxXNoQtuFNgkzC83+fs6Pbp35yFFNz7dK8I8LIv6XE7VV1k2Hh4dbf2ZLn9m7t
        enrr1qVqBSWW4oxEQy3mouJEAJDeGfLrAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the `packed_refs` files is entirely empty (i.e., not even a header
line), then `load_contents()` returns 1 even though `snapshot->buf`
and `snapshot->eof` both end up set to NULL. In that case, the
subsequent processing that `create_snapshot()` does is unnecessary,
and also involves computing `NULL - NULL` and `NULL + 0`, which are
probably safe in real life but are technically undefined in C.

Sidestep both issues by exiting early if `snapshot->buf` is NULL.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index f20f05b4df..36796d65f0 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -613,7 +613,7 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
 	acquire_snapshot(snapshot);
 	snapshot->peeled = PEELED_NONE;
 
-	if (!load_contents(snapshot))
+	if (!load_contents(snapshot) || !snapshot->buf)
 		return snapshot;
 
 	/* If the file has a header line, process it: */
-- 
2.14.2

