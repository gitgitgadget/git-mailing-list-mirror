Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5FE207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 13:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2998142AbdD1NuX (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 09:50:23 -0400
Received: from mout.gmx.net ([212.227.17.20]:61520 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2998139AbdD1NuV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 09:50:21 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8qOm-1dGEJP2Pr2-00C8xX; Fri, 28
 Apr 2017 15:50:15 +0200
Date:   Fri, 28 Apr 2017 15:50:09 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 04/25] add_commit_patch_id(): avoid allocating memory
 unnecessarily
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <21697d727ff5aa3b8b70360a978c295415995744.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IlKL4APYFMfTdTqEvcufxfQ51zoQ8MyzNv92GX1ycA3kRzwF720
 VqfT/AIWqG5Y/UvQBvsOVDG/60UKupUQqh49KDBkBzwc+3o8omghDX7IRoOlkv8NWnWTDpS
 ju7ullSFIcfS/5Srcyo0ZqTWzFMCdIkLCKkdxYF8SD88Y3YWA4SIIYY8DHkf0cEPnwf4tln
 jB4dpStIs5CYXTiA90zGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:teILk2rLZOs=:U9W9vyF3BB0YlXJBbQwAup
 7P6PDnL4UOlEDs/5H875RqX3gM0nszUNaOdd2AiJP7ORrPnoutGEibhHjQF88uHE3+547FcDr
 3wTAfSraosDlNvuyWuqGwPPorGdGnUz0AyKuUPMgBXayVEZauYB/cJ3oicWaJI8DXlL+NKmEq
 1mDyjMxxE0offnUyP4ftZOQ671LahpEtGqf2q1VFs1Q0SrcYL9K3nJ2t5GWgYlKLK6IuJFDzW
 7oHGwTfA5gKZZVMa1jq6i/ZeG3J5Xu5Pw44WHuV0Z93LUnLTodRfYXyayIxnq9f7SOxh7AGYp
 L5eddqNSjl6qbpDtwXoJ4ZBzvNYfdAoOhvT+OMLolSwPr4fkux00i9V1z4ATlF8J0lZihjyYz
 /M+5sfRdqDrWNwwhdl9Z654BqMD+50yIF0+ofveZezM7xYkslnlVdinOT8ichoYFvdNjhoVym
 rjkP4hGhMTNCxKiumAOARdcUMSDPI5JN9zduzdp2IUXccQoEKtIziZ4yg9DAJVwOrVLAL2++T
 5DiUuiQ0YdoGSKDEmpcq43g/3UQNX0ULbdT5BrQg9FHIFwdB8UF0hmHfa/PWrx1IMMSpc8otg
 wB4EnpvOVI7ZtUHdY2Y0Pr8unGJMO9XWFXCR8n1rJPHGtSrW8LOZ5EqrgQDTHR9QdyofvtjY6
 9U4NGNJEooXpDamVsMt7whx40pv99xxHFnRhYyTQAt3/ki1sMjHiSoVp8pLs8o4durL76qZBf
 CJTV6QYVeVl9JSlvGbtyEQ8SWf2U73ebfb4rATGX96562maxAvbLiE2Gcc7Dbd0mc+KnmGnRi
 d9Z2MM4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It would appear that we allocate (and forget to release) memory if the
patch ID is not even defined.

Reported by the Coverity tool.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 patch-ids.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/patch-ids.c b/patch-ids.c
index fa8f11de826..92eba7a059e 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -99,11 +99,12 @@ struct patch_id *has_commit_patch_id(struct commit *commit,
 struct patch_id *add_commit_patch_id(struct commit *commit,
 				     struct patch_ids *ids)
 {
-	struct patch_id *key = xcalloc(1, sizeof(*key));
+	struct patch_id *key;
 
 	if (!patch_id_defined(commit))
 		return NULL;
 
+	key = xcalloc(1, sizeof(*key));
 	if (init_patch_id_entry(key, commit, ids)) {
 		free(key);
 		return NULL;
-- 
2.12.2.windows.2.800.gede8f145e06


