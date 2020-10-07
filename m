Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83F2C4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 08:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56BCC2080A
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 08:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Py9kLWYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgJGIcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgJGIcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 04:32:16 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB67AC061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 01:32:16 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d6so921461pfn.9
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 01:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2aZLVA/Req2NKRbHRjdJHHGvYluG9goua29MlMO6QxE=;
        b=Py9kLWYWN0R72FD6r+gLkJgKjDuRJ1OAOUqKsE2ug7tDKzn8cJISUX2XDUTo1g9GPi
         3iRqKfQ5ev+4iS3bnzgusgbFTXxcaQGtTNg3YO6EtybyuBmxi/o2T0D2nBIjU/eoN5p7
         3NfmWQhswdsH4nI0lPxQ08UnVSWgt5oxIivZ+MQTN2aq4HRbX5Y6r8zNOUYf9/z3tsTa
         6M5X5CN267B7TjDw4ogTKsMnRWRjeojYrvHRVq8ZJdHyjazzR2e0y2IMrxCN4WdTrTC6
         9I1LJ5ggryyYxt2cly4M5/G7G00MRuzZmLfiqOD87BrS3tYVXDdBZiOrjk3/pjfPwKC1
         +BPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2aZLVA/Req2NKRbHRjdJHHGvYluG9goua29MlMO6QxE=;
        b=HgHodJrnWWqUfmOEA7gcPCX3ev/0RQLNCTPj3hczlRS8N3nF0tM8cVPDy3CP7PspQ6
         eZ6VNKCeHKIzofLRMJQ5+99fE6KHx2PQizmdhYxj6Det6CK+KajjY5rvk8nrQIrnJQH0
         8eIQq5Bt+e6IM0pdA0u1rDhw8Z+JhZ5fmcTtDQfcyXalulo+JyXqtfBm9520aqUhOt2D
         hRK6L5wDQvJ1tLBM/eTn86WcV7lSG//S41KWUmGtmwBwRarUP9cN5kwVgH7OgAIsFyEl
         +Pzd1gdVmROBDfsnU13m3N0g/WDmCdghPB56xz4CG2PYH0S1ue0Xm2pnfOgLUKKCg0Jg
         k3NA==
X-Gm-Message-State: AOAM531QCIknW1/TZmDpu2NzteMQQpWfXA5OdNOq23Waaa1I60xWZ/Ae
        mEzkcdYwtJ8HCxYQ07Nh0bIBXJpCxJo=
X-Google-Smtp-Source: ABdhPJzL0Ita1i4ivyO/gJoic0iZDgyIuX51b79qx75lzVoK/pRLR8mYDnvjLBHtKzSKoTH5NGh3Lw==
X-Received: by 2002:a63:1d5a:: with SMTP id d26mr2000941pgm.432.1602059535922;
        Wed, 07 Oct 2020 01:32:15 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id v11sm1520753pjh.56.2020.10.07.01.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 01:32:15 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] compat/mingw.h: drop extern from function declaration
Date:   Wed,  7 Oct 2020 01:31:59 -0700
Message-Id: <9e5a8625cab217bd6aaba68da081bc801354b903.1602059508.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.942.g77c4c6094c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 554544276a (*.[ch]: remove extern from function declarations using
spatch, 2019-04-29), `extern` on function declarations were declared to
be redundant and thus removed from the codebase. An `extern` was
accidentally reintroduced in 08809c09aa (mingw: add a helper function to
attach GDB to the current process, 2020-02-13).

Remove this spurious `extern`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Notes:
    This patch is based on 554544276a, formerly 'js/mingw-open-in-gdb'.

 compat/mingw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 88c07c4520..5c34547539 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -599,7 +599,7 @@ int main(int argc, const char **argv);
  * Call this function to open a new MinTTY (this assumes you are in Git for
  * Windows' SDK) with a GDB that attaches to the current process right away.
  */
-extern void open_in_gdb(void);
+void open_in_gdb(void);
 
 /*
  * Used by Pthread API implementation for Windows
-- 
2.28.0.942.g77c4c6094c

