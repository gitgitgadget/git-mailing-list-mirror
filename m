Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD8B31F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 02:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbfJACaH (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 22:30:07 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35558 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfJACaH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 22:30:07 -0400
Received: by mail-io1-f67.google.com with SMTP id q10so43953459iop.2
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 19:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qIyYxvpanIonNvCXldz4n2SBODNR7cMMv75WZx49I1Q=;
        b=Bne6wkMndKfh+N4w9BQ5inR17nU8/STxgjegfHamFECTf9SlTWYSHj6M1sJgtWNBrT
         fJIvJKTW9+fGlBXjL78fPoqmLtEMwpX3UhDfm9wOUa/4703weCqClqkhGMtYQ6//agte
         EQkj3FL421TvACWI4mctVf+4f2eVx5l1NBCOsKVTZrvRUGSILCrI0bhTV8yS5/luWFun
         +u2sE9Wwwltqu5LEOueD0ioLLPvCyGAVgqZg1/3C+ZJFWOUKtVICJGBTy+VO37LcMtJL
         Zr3G6hij9PG7/+CWWtY1PK7UQR8VLhHlUAbbGF4iTH9WLTjTcuSf95Fz3TcGCRpiiLg9
         OB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qIyYxvpanIonNvCXldz4n2SBODNR7cMMv75WZx49I1Q=;
        b=mxjqXPeJgru0wsU/mOjpimyOY+iUsQ4Cj0Gy1oxrK3gO2Z5U7XoGYCAV3bc7bdUlIr
         CyqPFDccU0jCZqjVipo0j6PVPG5QPpDQGQ25Uf9fMoIxxQ399fBCflie44cIBaU+FDcv
         NITKCNa9UeXMBFvmDigmaierbVvjrE67JMLPPoaABHbhiUg9oqSsLukoZDqq+I3914zr
         dilE1Bcx7i45UxBHGCDL3Ca9uUorKrehVZmAeKKXC3SEc6YXmIsHt+cmBEcPT+P4m7G0
         HBlzd2fyK6l2VZ61QVDlXnDrbuLw+8vxQhPDBapxbgpuSGKirG+/RMRnPy4bh+ciwapO
         IiMQ==
X-Gm-Message-State: APjAAAVxc/MsUXze3ejpphmFOTH8KUzyYATURwHiXjNx0rsZ2sV5JPwH
        5dhAr5BfPyGwLpWP2z9VMPAZlRk+UEA=
X-Google-Smtp-Source: APXvYqxkR0KukhTPz8UfDWIanbGdufl+5/OZu4YpMMSL1YsUWh1uYlY9E4kx06VOnhr5Ufxt4Xun+A==
X-Received: by 2002:a02:3f5c:: with SMTP id c28mr21729767jaf.103.1569897004875;
        Mon, 30 Sep 2019 19:30:04 -0700 (PDT)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:4100:375e:3837:c90c:13fa:5c01])
        by smtp.gmail.com with ESMTPSA id c19sm6415765ila.19.2019.09.30.19.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 19:30:04 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        cb@hashpling.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v5] diffcore-break: use a goto instead of a redundant if statement
Date:   Mon, 30 Sep 2019 20:29:35 -0600
Message-Id: <20191001022936.1757141-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001022936.1757141-1-alexhenrie24@gmail.com>
References: <20191001022936.1757141-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The condition "if (q->nr <= j)" checks whether the loop exited normally
or via a break statement. Avoid this check by replacing the jump out of
the inner loop with a jump to the end of the outer loop, which makes it
obvious that diff_q is not executed when the peer survives.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 diffcore-break.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/diffcore-break.c b/diffcore-break.c
index 875aefd3fe..9d20a6a6fc 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -286,17 +286,17 @@ void diffcore_merge_broken(void)
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
+			diff_q(&outq, p);
 		}
 		else
 			diff_q(&outq, p);
+next:;
 	}
 	free(q->queue);
 	*q = outq;
-- 
2.23.0

