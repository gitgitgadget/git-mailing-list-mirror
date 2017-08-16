Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD1181F667
	for <e@80x24.org>; Wed, 16 Aug 2017 20:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbdHPURP (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 16:17:15 -0400
Received: from vie01a-dmta-pe06-1.mx.upcmail.net ([84.116.36.14]:48053 "EHLO
        vie01a-dmta-pe05-1.mx.upcmail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752594AbdHPUQx (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Aug 2017 16:16:53 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe06.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1di4kG-0004LY-GS
        for git@vger.kernel.org; Wed, 16 Aug 2017 22:16:52 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id xwGj1v00o5BuuEg01wGkM2; Wed, 16 Aug 2017 22:16:44 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id 503EA45D4622; Wed, 16 Aug 2017 22:16:43 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [Patch size_t V3 10/19] Add overflow check to get_delta_hdr_size
Date:   Wed, 16 Aug 2017 22:16:22 +0200
Message-Id: <1502914591-26215-11-git-send-email-martin@mail.zuhause>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Koegler <martin.koegler@chello.at>

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
 delta.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/delta.h b/delta.h
index 2df0f55..dab7352 100644
--- a/delta.h
+++ b/delta.h
@@ -96,6 +96,11 @@ static inline size_t get_delta_hdr_size(const unsigned char **datap,
 		cmd = *data++;
 		size |= (cmd & 0x7f) << i;
 		i += 7;
+		if (bitsizeof(size_t) <= i) {
+			die("too large object size");
+			size = 0;
+			break;
+		}
 	} while (cmd & 0x80 && data < top);
 	*datap = data;
 	return size;
-- 
2.1.4

