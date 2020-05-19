Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A34C433DF
	for <git@archiver.kernel.org>; Tue, 19 May 2020 13:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B99206C3
	for <git@archiver.kernel.org>; Tue, 19 May 2020 13:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6vxLJIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgESNF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 09:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgESNF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 09:05:56 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF65C08C5C0
        for <git@vger.kernel.org>; Tue, 19 May 2020 06:05:56 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so15900679wru.0
        for <git@vger.kernel.org>; Tue, 19 May 2020 06:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tqkBmcgabEzAmSWQh3DvW/t/ZbGzKdhOAUUvc9EOd+E=;
        b=U6vxLJItFhQ2O8dPlOUMnc3hr/eoK5YyjQdRySiRl90yKzQlil1wYmobf4/SPH5njO
         tEtfRZ/bCdjjpsIFeprWDF8LCr3wSmvDd8Aji/mwxHmdMkulCZeYYpgOhwSQ91uY8Ehv
         71GBR5jsjiEQHKS8fkVz4vfTMvuMt1EoGF2kqjQOT3/C8o6e9VslK9E/a4zPVNyjDgqH
         OwPDqCVOs0c2+KnvcMdokDAy3UDVd2tc7n1fPM0LLp9G00tIhv9iJbQj9wNwI1EvJ+1d
         qBdZFh61QOhhHjyi9dRp4olPd5g5wMUdttBi0z9c+UScOFZ79h36l7ITP41yJmoVz8k4
         ybtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tqkBmcgabEzAmSWQh3DvW/t/ZbGzKdhOAUUvc9EOd+E=;
        b=GVu7nbXBTMcN0z5taBTzJqQ8TTBezQ5bNF/eSeaj2TdmXgB+Q1c4icy6uRUTdPlqRa
         qPr5X3bhgBB1dzwjF3eg/GteKLcxoih66YJyjiLA4fmzZXYXBpWhJAcdmWlBmRd7dhTH
         q8HUMMxsSlw4aJoJZNeKRym/A3MIPgxCXtrtmP92oK649Z9dwuYJTs7LfCoDF+xDW+Ue
         0n/qyhjPCpjkv/F6wgS+X9jXgAkuddSIGbcRUNbr/gKzM8rEDcaeOExMRYJqqfOQ297r
         gbCvLhtcGGTzuN5NqLxtmCILPnK87me+iaBveTLsOPemdi43LCGBtLpuOpaffFSETqSa
         WI6Q==
X-Gm-Message-State: AOAM532XeozjRu4R6BsdcauEEJDuFfZC7WCGzRwVE7XmnfBBEKtItPwW
        HsltjUnoPGYFWIbCcKsfgZ9blQTC
X-Google-Smtp-Source: ABdhPJzem22eZs95CPDken5u5fBmXbA/gLhPeGIX/d9BLVwPyzL7/fD/rMg02OlgWH7TTD3AsURxMQ==
X-Received: by 2002:adf:a1c8:: with SMTP id v8mr25317357wrv.79.1589893554351;
        Tue, 19 May 2020 06:05:54 -0700 (PDT)
Received: from RYZENTEST-WIN10.eu.sony.com ([217.205.218.246])
        by smtp.gmail.com with ESMTPSA id q9sm3686268wmb.34.2020.05.19.06.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 06:05:53 -0700 (PDT)
From:   anng.sw@gmail.com
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Andrew Ng <andrew.ng@sony.com>
Subject: [PATCH] merge: optimization to skip evaluate_result for single strategy
Date:   Tue, 19 May 2020 14:05:35 +0100
Message-Id: <20200519130535.23770-1-anng.sw@gmail.com>
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

On Windows, this optimization can halve the time required to perform a
recursive merge of a single commit with the LLVM repo.

Signed-off-by: Andrew Ng <andrew.ng@sony.com>
Reviewed-by: Junio C Hamano <gitster@pobox.com>
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

