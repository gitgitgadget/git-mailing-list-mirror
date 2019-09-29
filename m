Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FB411F463
	for <e@80x24.org>; Sun, 29 Sep 2019 20:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfI2UoF (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 16:44:05 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39617 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbfI2UoF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 16:44:05 -0400
Received: by mail-io1-f66.google.com with SMTP id a1so32594892ioc.6
        for <git@vger.kernel.org>; Sun, 29 Sep 2019 13:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m+Ez4QhKOceskyoU0ThrcQM2Rg/roEjF2Plt71EGK4k=;
        b=Y6xoBpHeZ0NTkoBShfk23Sx8EfULHNLQ+4hs2z0N0nBY8DlrtTNJMviEbQHcB1B5e9
         qyItWr/xvwAJqeKf10kBn/b8r8s6TnwdwOMk9dT6783Oj0TqOoxsVzCVmOx6Ki8LX9Ls
         XWxrjs818tSPP5F5gwVTx5qMhlWpgUxRKxkFMrPg/r5yS13EevSGmDpQ8lPQiQ68NhBj
         YNi+g5p5wp1LygnpcCZtRCcuuzEIw5Qx4p8/uedyYOu5iQsIgvrFreI6GPOl24g+HmRx
         HjAPwtt6i1S0XNRwfxBOTQgR2x6iS7jGGS4O4AWl/GH34L5xwBlDMZBm2Wq183y4o0Y8
         sV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m+Ez4QhKOceskyoU0ThrcQM2Rg/roEjF2Plt71EGK4k=;
        b=q8o8l5eVbxT2X5/qdOE9uT9zwPlt8QMIKsMBzZd0fmPfRRW1hSmjYxyG8pI6da8Ptm
         +IZ9lAfN6Pu6jTLMyzIZ3C1kU8tOp8GBHTGZsudrfKXyA55bYs83jtJ4zPR5RgwbyIl1
         VnJtLRnyRToNONKE0NcD3sE90PGohPpZiQVMSYAcA00d44iTlrUkPkMpBG3K/CU8iw2S
         G+xp4CHWyvlVyqBs8AcRXYaRoEGYqL7sm7SI8xNO1bmIkkU2g+PPIgz6IGOJ029eIArP
         kg2PjCNeeY1aBdzUeGQrBuGsNskFosJX0ZGwQkejDHEazdG+dxDNKrMdbs5WmMEbWLNe
         qa4A==
X-Gm-Message-State: APjAAAXMGkbaz6dsqzLteUHeu8Xh+EpBr23kb6+qCThbr1ycK4Zgl+bp
        FEBN4jQ9cUpC81RbIVBsERlQTVe59Hk=
X-Google-Smtp-Source: APXvYqwMqXwQ0lC90v7US3pCpUPWQctmqRUFq6SqbQSsS82ILU9uT2YLpreUEZLWN2oZazCPIbkiEw==
X-Received: by 2002:a92:bb47:: with SMTP id w68mr17941470ili.226.1569789843781;
        Sun, 29 Sep 2019 13:44:03 -0700 (PDT)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:4100:375e:3837:c90c:13fa:5c01])
        by smtp.gmail.com with ESMTPSA id m9sm4845545ilc.44.2019.09.29.13.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 13:44:01 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, cb@hashpling.org, dstolee@microsoft.com,
        gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v4] diffcore-break: use a goto instead of a redundant if statement
Date:   Sun, 29 Sep 2019 14:43:22 -0600
Message-Id: <20190929204322.1244907-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The condition "if (q->nr <= j)" checks whether the loop exited normally
or via a break statement. This check can be avoided by replacing the
jump out of the inner loop with a jump to the end of the outer loop.

With the break replaced by a goto, the two diff_q calls then can be
replaced with a single diff_q call outside of the outer if statement.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 diffcore-break.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/diffcore-break.c b/diffcore-break.c
index 875aefd3fe..ee7519d959 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -286,17 +286,15 @@ void diffcore_merge_broken(void)
 					/* Peer survived.  Merge them */
 					merge_broken(p, pp, &outq);
 					q->queue[j] = NULL;
-					break;
+					goto next;
 				}
 			}
-			if (q->nr <= j)
-				/* The peer did not survive, so we keep
-				 * it in the output.
-				 */
-				diff_q(&outq, p);
+			/* The peer did not survive, so we keep
+			 * it in the output.
+			 */
 		}
-		else
-			diff_q(&outq, p);
+		diff_q(&outq, p);
+next:;
 	}
 	free(q->queue);
 	*q = outq;
-- 
2.23.0

