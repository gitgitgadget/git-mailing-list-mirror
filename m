Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01CD0207EB
	for <e@80x24.org>; Fri, 28 Apr 2017 14:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164300AbdD1OEa (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 10:04:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:63423 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161842AbdD1OE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 10:04:28 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0gww-1dxiCU1uCE-00utqx; Fri, 28
 Apr 2017 16:04:16 +0200
Date:   Fri, 28 Apr 2017 16:04:15 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 20/25] shallow: avoid memory leak
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <380b55f118efb1b0eaa142e1d3971bca7d1ef17a.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:siBLhGsGE94QlEVvmzekKh7qY/3fc74OrFKOjQkE3Bb5SkarlpD
 VCqiEVUzbNuCvlVExmTRotMZ/sTPnAqo0GTZSbFtmPXJWOdz7cpb8ABH8zirhAzZMfY0PCX
 fqUnW+aJTBL/tZwevQAwtOrdmMrKFmxUTUTwwL2qGlnkjI7zYLefuLWevR8lgpih41iKFtp
 MQ/Du+DezVoyMB31E1o5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6byzt0uIvE8=:GfBPaW10yUuVMKJ12/lZX0
 D+9kQGta/MsQZbE8BghZs02kkDz28obzfwUMZqt12RtMjZRmNwvdRI+kHn0GxhSxc6efZLkrx
 7Jsefv383Tx9mf+f2sPY8SHXxN61qzXj21DJLqnWXhrdUW+A8iRfNiWJrGYoJFRcy5tEuowZZ
 hgrCdQnHPvnp/j+91idCBDXNr6m6Q2VnJ5rqS/xJgEl+WS6te+J+nho452X1SAqsxPOrdscVE
 A4ek6oKL/mh3yCSXfwZOcYDtEcTvPG/gfZfkmBeM6+Iuv+gP0DAX2gR0hoWgNVgBOx7bG96Nb
 NCb9RlChF0ElbwdAHCeFBIO2lYaT346aJcqBM3Gz5BGUw8o6ncDnZ5oM2q4aCy1X6/t3Eu9Zt
 C6NFkCTcwstJa/04fuM2WQ5OmM3d07JAAkSVanJepeBMMgxAh/Y6f8lgo5xYNl5wgaV9EajnB
 yqzQ7QAdeDrwY5UqsBpnkdi7SdjTlL5yfAvD/i+v5ITyArgZjwgyQCuMB2HCU646QYysWOK20
 qneJxjfDAdkGuurtaD87E641FU4KXVULbP6kL14kZmCzW3wfXpZ8WdCt3aBUyOAYkUP3NZ2vW
 LgOnRZTkH/qQ45i/w2fdd+qQHIRCWZERQe73/WQbg/pU66oioq8F3HKpFVt9Hj6UCXKiTjXWK
 2W/wUx/HA9a+2ugJ7mLJ6AGO1yIDhJjJ5+vnNtvxYR0KicrMgXXfvL5nysoPLckg13QuvYLci
 xd6vDLPLvk1Cr6DBxD9oDefXBO7aaBFEwLPAzoyroh7PiqECLqlq0Z095CWkfQrpk4286V/bt
 zz+FKgq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 shallow.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/shallow.c b/shallow.c
index 25b6db989bf..f9370961f99 100644
--- a/shallow.c
+++ b/shallow.c
@@ -473,11 +473,15 @@ static void paint_down(struct paint_info *info, const unsigned char *sha1,
 	struct commit_list *head = NULL;
 	int bitmap_nr = (info->nr_bits + 31) / 32;
 	size_t bitmap_size = st_mult(sizeof(uint32_t), bitmap_nr);
-	uint32_t *tmp = xmalloc(bitmap_size); /* to be freed before return */
-	uint32_t *bitmap = paint_alloc(info);
 	struct commit *c = lookup_commit_reference_gently(sha1, 1);
+	uint32_t *tmp; /* to be freed before return */
+	uint32_t *bitmap;
+
 	if (!c)
 		return;
+
+	tmp = xmalloc(bitmap_size);
+	bitmap = paint_alloc(info);
 	memset(bitmap, 0, bitmap_size);
 	bitmap[id / 32] |= (1U << (id % 32));
 	commit_list_insert(c, &head);
-- 
2.12.2.windows.2.800.gede8f145e06


