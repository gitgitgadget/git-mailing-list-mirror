Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEFBC433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 15:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 881372098B
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 15:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4zBYrev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgH1P0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbgH1PZh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 11:25:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8198C061264
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 08:25:37 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w5so874208wrp.8
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 08:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=BTSrAarGk7iUeBsTKbKKwbiwI64I+bS4SBK3mvQALnk=;
        b=G4zBYrev/ULiwzYgUArwtcpOg/F1KaLv+rtYp351QY2R+QFP9bkX7hLLY0AVPh4IOB
         y/V6fLP+EH0MlS61DAgxOqxCQdAejKf69VMdrQEfVSneguSnLJDgYRsDwm2bJSA/eP+W
         D6QjpQiTOcpRc2RpxdlcO8HZtpN07zO9wvubEP2vBUfNZ38UCs5HDqD3DNVbUHqQCGm0
         nYGF8eBXLBt1uXbE+rHOpjC9GmJyFxaegIfNdPcRidbRBoNhcDuKYJEIJH6AGoNeN8RD
         BUKTbrdD44YwjxZuiA2giUNB/Yi9Y8kCCX//+itnSIu5yVmeb9zUKLEATZgZ2SvFwKiY
         NLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BTSrAarGk7iUeBsTKbKKwbiwI64I+bS4SBK3mvQALnk=;
        b=Fi+QNo4Pli1LzCns4k3cv32f4i0supyNqkIYS56KyeTrH7XrjUt8mWdDY+IdVbnTiV
         v3xDG0QZmn6/YvqlhLsXRum5O1/71Fj34MG7d+andFrBcuXX9ojzZDAA5UnGEEWH/ab1
         z6+2F8e2PdWemla+nbNwgu+5+UT8IiG7YugYM+kstHQdN7AV1fKDIewQmhmezhscsOQi
         u37UIOYfdHgvabFncfHH5Y07r3CTS57H6Pq4mK7dIE3ZkikK99Qu5hIhHavQw5NMuRwP
         uKI9iPITx7U8XyL/jWwSfOHrvZBYDym1hqKL++ZoGrpc18xE6a/804j5/Fgl6I/rYKmW
         Fy3Q==
X-Gm-Message-State: AOAM530f7kSysY4HB23wM+WjeLf/1cGdhI0hhOa9wbe/i5mfPgyoVWhg
        NAkampvEvrEP4tn94+ssOkVtgvmBzms=
X-Google-Smtp-Source: ABdhPJweDVEjOukIgcjSOVfEAWQoSE05H2wCAknJ/evH5A/ASZKAK4IU22KFLrg3OJeASr+MUDT6PA==
X-Received: by 2002:adf:a106:: with SMTP id o6mr2005890wro.1.1598628335780;
        Fri, 28 Aug 2020 08:25:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h7sm2933576wmf.43.2020.08.28.08.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 08:25:35 -0700 (PDT)
Message-Id: <pull.712.git.1598628333959.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Aug 2020 15:25:33 +0000
Subject: [PATCH] refs: move REF_LOG_ONLY to refs-internal.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

REF_LOG_ONLY is used in the transaction preparation: if a symref is involved in
a transaction, the referent of the symref should be updated, and the symref
itself should only be updated in the reflog.

Other ref backends will need to duplicate this logic too, so move it to a
central place.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    refs: move REF_LOG_ONLY to refs-internal.h
    
    REF_LOG_ONLY is used in the transaction preparation: if a symref is
    involved in a transaction, the referent of the symref should be updated,
    and the symref itself should only be updated in the reflog. 
    
    Other ref backends will need to duplicate this logic too, so move it to
    a central place.
    
    Signed-off-by: Han-Wen Nienhuys hanwen@google.com [hanwen@google.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-712%2Fhanwen%2Flog-only-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-712/hanwen/log-only-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/712

 refs/files-backend.c | 7 -------
 refs/refs-internal.h | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 985631f33e..b1946dc583 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -38,13 +38,6 @@
  */
 #define REF_NEEDS_COMMIT (1 << 6)
 
-/*
- * Used as a flag in ref_update::flags when we want to log a ref
- * update but not actually perform it.  This is used when a symbolic
- * ref update is split up.
- */
-#define REF_LOG_ONLY (1 << 7)
-
 /*
  * Used as a flag in ref_update::flags when the ref_update was via an
  * update to HEAD.
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 357359a0be..1f92861aeb 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -31,6 +31,13 @@ struct ref_transaction;
  */
 #define REF_HAVE_OLD (1 << 3)
 
+/*
+ * Used as a flag in ref_update::flags when we want to log a ref
+ * update but not actually perform it.  This is used when a symbolic
+ * ref update is split up.
+ */
+#define REF_LOG_ONLY (1 << 7)
+
 /*
  * Return the length of time to retry acquiring a loose reference lock
  * before giving up, in milliseconds:

base-commit: 675a4aaf3b226c0089108221b96559e0baae5de9
-- 
gitgitgadget
