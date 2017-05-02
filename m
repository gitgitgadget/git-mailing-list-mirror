Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FC8D1F790
	for <e@80x24.org>; Tue,  2 May 2017 16:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbdEBQC4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:02:56 -0400
Received: from mout.gmx.net ([212.227.15.15]:54267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751037AbdEBQCz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:02:55 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWk7n-1dZ3Eh3OLT-00XtTq; Tue, 02
 May 2017 18:02:48 +0200
Date:   Tue, 2 May 2017 18:02:47 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 20/25] shallow: avoid memory leak
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <0e2c75882e0c1a616ffbffffaa628b4fc27b87a4.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Rn0ZHNvTxYOg4qRCOxSdvR8Ot50lVecRPGxeVteOt5wuGWo2Nkf
 r5vFhMFXcMsjdU7DHfMLaw82CBKXzJZ5l3zkocqP/ZR8iFAJ0ZrAomuuT364pK5FSslQg3e
 5FAyFAWDN8JdPVSUE2wLHm02trNwqLELq5X4HwYL+UKjWIpsX497mtb2Z6ZkTtpPa+L10be
 4z/LvcE8UhG8Hlbv2JdHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7jDYPeAPJIA=:nAcg1bJvIql+H9GnpKLEBI
 3rj/TftfTvDNHMu+xvG2KD163cYbGfSDkZRLxdVWYLPIqDyYzxBu4jBoSv2RPIRT3/Ilyk5N9
 Lk1FABh0ZMkBbrWe3DE7Uy/UdjYLuHFN3WbDIRn8xW74aUyVFGg+tLFQpo3bT8y7eh9HjSplU
 IUTtPEbY/okcUT5NkZ3S57AFv6JLkMm1ifZx0VRBauRMSYhQTKf+Xv/uKBpGFzp8UKL+atYqG
 MHndSRnrrtR5M/OygQmazkExNkXtsVL/kTBpF4Dr5oZe7nLXStUzH/GNvjD4mC9vWglq0x/4p
 fZt9n0b/w1wOl8HJlf2hiQGNncYYU/YZgBZnqpjI/kOEMWvKcFJXHDfIpPKSTi8tz7Fbsotvy
 6cqD8fdbFelHLUbDG+RPPFllPej/jQHR6iO6iHdP7xAANdsPb8G9gC2p6xKFG2sfzVTL7Quf7
 IPUIW0UKuSxRYd4/HFK8z8FZ9xPgUnfEUQwNu2wlXW9dK7NiyZiG8Xt3Uu6OZDVvUROQOSbXr
 Rtrh7gmc0BayYRfcYfyGdFxIMCXWtCeXxWc6jT6R28E+zcxF4WqH3AgiducBhKHMOwExdkJeM
 qZ461zreiwfEafUu5ec8A0WJO+IpqvCzh2guFckIW0ERYiHcQVzhqDBCMdLU0Q3Z0SiR1t679
 yxPAd/TjrxewTEFzIKJLq5G+Og1QZMNJdhujFM5xXjuGnSn5/7uXvJ9uLDw8DDow5XZ/Sovfo
 OvzzwtC2H1VVxrmnjwQfhiZX96/V3G4mj0F4rlssyvYv6dwhB09mhuW08eixWmnIMB9CcgNa4
 wYf93yQ
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


