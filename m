Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EF3E1FE4E
	for <e@80x24.org>; Wed, 29 Jun 2016 11:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbcF2LhH (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 07:37:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:61180 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544AbcF2LhF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 07:37:05 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lcjgd-1bij3y3F27-00k72L; Wed, 29 Jun 2016 13:37:01
 +0200
Date:	Wed, 29 Jun 2016 13:37:01 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/9] merge-recursive: allow write_tree_from_memory() to error
 out
In-Reply-To: <cover.1467199553.git.johannes.schindelin@gmx.de>
Message-ID: <a9646a7f2ea07ecbe1ef22f7360afc8c0d950535.1467199553.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iXHiWTw+8C2mPbmuyP5joYtK1Gu0nkXkw6qB9ytv9bQlBnUU3bd
 NcDrJAjMOjBiy5EYGZGsry50Nr6rIKtetRg7lekNATq3fiTB5/SXvsCfRK63GkSfS2rPbJY
 JMmPn4PnHLIrXdNwxL3G6Elj4Dv2Px+ICbjgUamFO82E3K/wlkjxNLoqebKpSfwRyZwCYRC
 9bT8TEZFOSWRZGTw7n25w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:bI+K1EuLnKY=:6z02ERYBXOZ89mzoYbUeyC
 y30/lpyRwHmeZgKjs0PMc9/mgJ/8n77QLk4DhkndYwGb4lfGsRKiMx74UV+VDd/x8/6DRbvX4
 PVWRs4tagyADKVAUyHBgXkUgXW1/KP+mCk3O51CgViJG7zB3dhKRVUfUw9/2CXlOIqSTPWbWG
 dlBD5OmDIRklm1Oq6TWC0K6tWJYV05ZP3hR7846wWpgeFCxtDQVHIsLzBDU5erE/+GQ9FiF7v
 3kvM5XQrSkgI2lp/AR167Jkewjtox3L+NIFLZxsuffbP1QiVmAkcBSCqrgIb0unluru7eSKff
 CXdcq3j3xj94ztfRImSs5FE7JqMItQv3+CtZpWvdhJeTQJrYZAVqzMXsQuY0x4ews24g2rsNt
 WdAi8AUGwNzqoYZcMWxehvZiX6jRIOYSezRu8WaoLzP3qZzWRhthe7FU5yqYB969SLsrpu/wy
 lVipXr1yc/a1sBzMEHshjIgUc20ODVnEH2LDtL9WC9leZc9BfoluDvE5kEXNhzzQZXyeqM2E+
 1x/b1Opyfb9w7EF+XfSbKS8j7I2CNcTZEN8RzayowtbdPInH6pGHgA4vw3C6GXqbtFK1y6mXb
 rr9jafWqsSM62nQOtD0gDH5GxGXSaqrWR57TfJ93uGlSU7aF2lEBg+OMZBAfsKsI7cpyeGD+f
 GOrXrYtBmOAyYYWBEEukC2Pe8H2yJBbcF5qLD9q+bgXOib55qIt1YB92xB8ZCfcZWilLTU8iJ
 Ie464MC3wPsQsJmOEPj8Gjsv3bzHiqZd6hGZHvCo/q9nnXGzK7sHpP2bkx+B0L+WV8GAo/7IB
 zIMGCsW
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It is possible that a tree cannot be written (think: disk full). We
will want to give the caller a chance to clean up instead of letting
the program die() in such a case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d56651c9..6ab7dfc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1875,8 +1875,8 @@ int merge_trees(struct merge_options *o,
 	else
 		clean = 1;
 
-	if (o->call_depth)
-		*result = write_tree_from_memory(o);
+	if (o->call_depth && !(*result = write_tree_from_memory(o)))
+		return -1;
 
 	return clean;
 }
-- 
2.9.0.268.gcabc8b0


