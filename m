Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7708B20A21
	for <e@80x24.org>; Thu, 14 Sep 2017 17:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751509AbdINRGu (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 13:06:50 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:43125 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbdINRGt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 13:06:49 -0400
Received: by mail-qt0-f182.google.com with SMTP id i50so7644066qtf.0
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 10:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerotech.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+75MnhsbNupMznaU7RKH0BTs/j0amTwi00Vi+tcnHU4=;
        b=T72FPFfr9zHEqrzDl297/HA4y8fnZgngdMkdaOaKJ6SF+DemUazL9GnZQ6vfRoYfkV
         bhUnpswhG+06y4EcEOG3o/THF10sS8AuZPvo+tYboXf2TFDgmmn0Pix1xgrEhyfd/T2H
         MOOE3F+piKqqovbtHrLEu27XREJaul+H8Hacs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+75MnhsbNupMznaU7RKH0BTs/j0amTwi00Vi+tcnHU4=;
        b=klSNyrWWbc2yR89p8msyh2N5ycIkCTHyZ/N3+IKyFli7ImkE9K9o4EFrGjedHlHWRI
         uu56tqzJ3mW/DuAyl8MA2snTr8m7JXQSyr4Dwa6U85KaWiXasqPrldMW+2o6TxJIU5UX
         77ihz9I/Z96fL6PzjUpu6uLDLCc+RWhnEAHWipcVi/FcKuCII4xQXfJJ+0ZXdqN6iKqm
         TRXQ+6bke1BW2tFMr7w7tnNbAgg8CcqRxGRBF8W6o2kmsFRB8Ewt2/zf4+L1CZwE4bIR
         qIrrxd6js4GEKsJKjOts0FclhJ/zRAVWlOw1JCS8nrTKYP2RJRaCfatjoG7Jxuv65OMX
         f0Cw==
X-Gm-Message-State: AHPjjUgMrTdSM7PzEgPEc6mStuuLgCLnt3Gm08/mw8dRiWE2IxtPCOEB
        Ptl1dONq5jkb9sJjHGkKBg==
X-Google-Smtp-Source: AOwi7QCo2zA9fGP5Hinlifooc0e/a0dLVHDPqrvMAaotg094qCfRKWJHnd3YKFZdFTn+WkrYm8t84g==
X-Received: by 10.237.35.37 with SMTP id h34mr34331692qtc.51.1505408808432;
        Thu, 14 Sep 2017 10:06:48 -0700 (PDT)
Received: from AERODSK168.aerotechad.com ([64.58.240.2])
        by smtp.gmail.com with ESMTPSA id c11sm11092053qth.13.2017.09.14.10.06.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Sep 2017 10:06:47 -0700 (PDT)
From:   Ross Kabus <rkabus@aerotech.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Ross Kabus <rkabus@aerotech.com>
Subject: [PATCH v2] commit-tree: do not complete line in -F input
Date:   Thu, 14 Sep 2017 13:05:21 -0400
Message-Id: <20170914170521.8076-1-rkabus@aerotech.com>
X-Mailer: git-send-email 2.13.1.windows.2
In-Reply-To: <xmqqa8260y7g.fsf@gitster.mtv.corp.google.com>
References: <xmqqa8260y7g.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git commit-tree -F <file>", unlike "cat <file> | git
commit-tree" (i.e. feeding the same contents from the standard
input), added a missing final newline when the input ended in an
incomplete line.

Correct this inconsistency by leaving the incomplete line as-is,
as erring on the side of not touching the input is preferable
and expected for a plumbing command like "commit-tree".

Signed-off-by: Ross Kabus <rkabus@aerotech.com>
---
Fixed up commit message with feedback from Junio.

 builtin/commit-tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 19e898fa4..2177251e2 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -102,7 +102,6 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			if (fd && close(fd))
 				die_errno("git commit-tree: failed to close '%s'",
 					  argv[i]);
-			strbuf_complete_line(&buffer);
 			continue;
 		}
 
-- 
2.13.1.windows.2

