Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F75DC433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 684E02065F
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euHFfwam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgERPgm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 11:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERPgm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 11:36:42 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EBFC061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 08:36:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g14so276105wme.1
        for <git@vger.kernel.org>; Mon, 18 May 2020 08:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oETChw/yCWTYQH8BcKSHVxceeUOWLuvqXybctvtBAMc=;
        b=euHFfwamyrmJRLZ5Ya38TK2wf0fNfz4A/1/80elQqRjH4lDc0RJGJgI3Qu9jCGRxwV
         tOd78XUd7gx84CiJxkhImROlQuETvwgQgyMxYjpTaq35bjdaSgqP1aVl8S2lufZnYU26
         h8WL27ZjSgJh7VHYfdn6S1wA3YG9WVE+JyzuF4oqyjoF6TFNgXkPnLG1Oqkd3ioMkPEC
         2KUWlh+Nmw8gHLZjMVyFlg39/zdqzNd4IW5jO8VBEdPpN4C9fjnf1kTLKnwwpiwTg7dn
         pxBmT0l39z/PqrqOI3rX1VoEZjiP6pw/mwhLy6adEwSieqOmUlXvFZSIKslliG/NGy04
         Fi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oETChw/yCWTYQH8BcKSHVxceeUOWLuvqXybctvtBAMc=;
        b=NAMZbdk9wE0OJbKhFh/T2/LXqKhJU0jvtWhA4j7qr8DEKSnFXGxURVYEAANHB4aD5G
         2T/8L2Rfk9GmJxbdxDODqsCBd0eCwhp2GOpRGlGXvxCOzvgDZ99RgeQPPRIQ1FVCGW95
         PEMmaxiVSWYc51T5/RCloV0F/SZs7UALclaYPTXBr3cKmzkldb1m9EVlkGVoQF2wmluX
         yl0ROz9WF/DlAZKXAGgIlzRmiaPHFZiZ/YFZH0VFeFmJD04SxXOEJJMZLVsfIFpmLCCZ
         HxNh/y0nFUaETKLDBL6r7jvrGlQM9nS9fCVjJG5qmDuqmu5oKR6N/dOaVV4CEdewNgb9
         x84g==
X-Gm-Message-State: AOAM532xVYIgfVAHutRUFBiY+ktXZ5XBuUI7krKQTSXS3eAS3d+QxaaI
        +mIJhDqBeauDQUXX798Bi59zCmInaNc=
X-Google-Smtp-Source: ABdhPJwXAUuxZm3As9XPiK/PpRLd9LKEzt+h963jlfOLJklS/WFxfEK2OypDCljzWWS7cMIA2BEZjA==
X-Received: by 2002:a7b:c358:: with SMTP id l24mr5123343wmj.13.1589816199542;
        Mon, 18 May 2020 08:36:39 -0700 (PDT)
Received: from RYZENTEST-WIN10.eu.sony.com ([217.205.218.246])
        by smtp.gmail.com with ESMTPSA id l5sm17474326wrr.72.2020.05.18.08.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 08:36:35 -0700 (PDT)
From:   anng.sw@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, eantoranz@gmail.com,
        Andrew Ng <andrew.ng@sony.com>
Subject: [PATCH] merge: optimization to skip evaluate_result for single strategy
Date:   Mon, 18 May 2020 16:36:13 +0100
Message-Id: <20200518153613.17497-1-anng.sw@gmail.com>
X-Mailer: git-send-email 2.26.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrew Ng <andrew.ng@sony.com>

For a merge with a single strategy, the result of evaluate_result() is
effectively not used and therefore is not needed, so avoid altogether.

On Windows, this optimization can half the time required to perform a
recursive merge of a single commit with the LLVM repo.

Signed-off-by: Andrew Ng <andrew.ng@sony.com>
---
 builtin/merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index ca6a5dc4bf..7da707bf55 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1656,7 +1656,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				}
 				merge_was_ok = 1;
 			}
-			cnt = evaluate_result();
+			cnt = (use_strategies_nr > 1) ? evaluate_result() : 0;
 			if (best_cnt <= 0 || cnt <= best_cnt) {
 				best_strategy = use_strategies[i]->name;
 				best_cnt = cnt;
-- 
2.26.2.windows.1

