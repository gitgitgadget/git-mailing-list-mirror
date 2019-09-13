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
	by dcvr.yhbt.net (Postfix) with ESMTP id ADB7F1F463
	for <e@80x24.org>; Fri, 13 Sep 2019 13:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388162AbfIMNCx (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 09:02:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37740 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387878AbfIMNCw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 09:02:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id i1so27021496edv.4
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 06:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vbJCW7SAsR7LZySePzU4Jn4AHu3TVJFjRIctZSV/Dj0=;
        b=QuxB0vpi98Q3qH0Yx/aoJxKAt4iX2ax71MV2SAxFGfuMFNTqrhzQbBLbZgwYaSvcI6
         nY6Nk2Od9cQ6BEO79DEIdVan4Md1aoc+p7fwA0WaRaYLkukn3vTmnQJ7A8NUnksARpsR
         F402NCdjiLl6pPfv7iMQ71czJM1MEDqNCRSgju+KOVxYyxP2VHvAHWtE0H3W45X6lAK8
         QhV9twdYohUse0KM571L+rNCesM7wtm01R+09ld4KvJKdhbV6vvap/0LoxXv3D2jGP3v
         71kdRZSz7H4tb5n9MCp2xxdKhRZmO88JKUsxKedZMOSH74gozAfa6T2TK01cHri3Zzxd
         INeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vbJCW7SAsR7LZySePzU4Jn4AHu3TVJFjRIctZSV/Dj0=;
        b=gDDLT4pDz8IvT+410EZLyP8CtJfOwnQpWF7LnmhaEUCkYmCiiBvJMurNY28pLThdFT
         9Wh+61OJ0hBnn1SQq1xChGrkthkwwvPXgcmDFk1PenE9eJkzFd4G39RW0lHPvQNFchFL
         GaiD6bPuRPW0xRL21aAIb7BwIin6ORP/2l/d7+N6K8uDIvw+azd2rp2gwQ6+N/CUV3/r
         pSFSPVp4Bpk9+P31OB8YkBqPgmEfFhv/pbEGH+vc17h7/ld328iTo2mWe+ZlUqBDmU/B
         1WZDLvjYhDDvn1luurlxnsyy/R5AtsqIkxtsU2oagsmZ8Rck8vr54MvImSlD8ity7SfX
         oqgw==
X-Gm-Message-State: APjAAAVpfC0uUdLm05RBAfJs6PbSAky6ZwctN6UfE6YvxEthrnMapqc3
        gWm71V2m8aw/qJJgsBVEQnpXVpuB
X-Google-Smtp-Source: APXvYqyijGQz2YAblPLzHQ6vUVUSfq977LKlycBOUjUe1uDI8aNaqrF6nGVyZiK+Y1WVZ2MsKX6PqQ==
X-Received: by 2002:a50:8f81:: with SMTP id y1mr47378968edy.181.1568379770154;
        Fri, 13 Sep 2019 06:02:50 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id c14sm2846570ejx.31.2019.09.13.06.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 06:02:49 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        James Ramsay <james@jramsay.com.au>
Subject: [RFC PATCH 01/10] builtin/pack-objects: report reused packfile objects
Date:   Fri, 13 Sep 2019 15:02:17 +0200
Message-Id: <20190913130226.7449-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.23.0.46.gd213b4aca1.dirty
In-Reply-To: <20190913130226.7449-1-chriscool@tuxfamily.org>
References: <20190913130226.7449-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

To see when packfile reuse kicks in or not, it is useful to
show reused packfile objects statistics in the output of
upload-pack.

Helped-by: James Ramsay <james@jramsay.com.au>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 76ce906946..c11b2ea8d4 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3525,7 +3525,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (progress)
 		fprintf_ln(stderr,
 			   _("Total %"PRIu32" (delta %"PRIu32"),"
-			     " reused %"PRIu32" (delta %"PRIu32")"),
-			   written, written_delta, reused, reused_delta);
+			     " reused %"PRIu32" (delta %"PRIu32"),"
+			     " pack-reused %"PRIu32),
+			   written, written_delta, reused, reused_delta,
+			   reuse_packfile_objects);
 	return 0;
 }
-- 
2.23.0.46.gd213b4aca1.dirty

