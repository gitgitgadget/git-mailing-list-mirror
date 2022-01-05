Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93CFC433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 04:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbiAEEUp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 23:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbiAEEUn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 23:20:43 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34682C061785
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 20:20:43 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v6so18559106wra.8
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 20:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mLaByYi+QfagezeHuWfWDfates2Ax6Y+fPE4+rCFGJE=;
        b=eBYC27fnyuFu6ovNz2kUEFA2drd3FD9xW+z0/PLvzKb3Tt7AAcJaDwu/guEmlSuxHT
         TnCla+8ufVq4NkUAnjy/Ok5gw/hTjhMzSlyR1/O5nZVw2kMp5ostfwapsUJh6UNrTy/K
         WeJGkTn5KfYWCWfC7WCdTyY+goos6Cbr8Dr1Dv5cnLPvAxbtYhO1Yb5DDZeZheWdfvzB
         PLwjUG2g1+X5iEnHUFy2GDfB8nJjAJjmBnOwH91GLPg//fHXBut+3l3PhCwOoN3T8aB6
         rhScTD5FqSsvodGxV2Foj63z4N79rmoL0E9FdmCwW6h94+P5jrwm+5Jxa+6d/S5Yx2HJ
         3DPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mLaByYi+QfagezeHuWfWDfates2Ax6Y+fPE4+rCFGJE=;
        b=rMFTwSjtQWwd6Ny4gDnEMAgjofYUTwgb/TShH7/moKLQa814DkBKxFTGiLRXa97nk2
         gOAjzeojkaKFZlW1bC/2bipfeJwV1b7gMdke14VUS3RbHiSnvwk6eRX1mYX/J9AhvsEQ
         q78j6MHqpyxmGZWx11G6leZzasDId75rqfD42m9Ki28kwALI/YwHTI8Dg7ptByrypvsi
         D5wMhjCw6nd//+rgWMDGCfWJgq1ZKTkpW4XqVO9QmgdKpy7mnuUWehX3qGtVKd7qtR5q
         DqlYUzXoUI4T9YbYfovzAK6AzeBkfoOG35r1e6rXB2ZwCng7ALGAm5NOz4q7g2n/t9OM
         Xpzw==
X-Gm-Message-State: AOAM5320QJR306w+wYB7z1mK38GN+Ma+Dtg1fEA+Nj1N50h1h/e9uvYd
        FvAdAmDn3gopjiLxjYRQYY3ToZikybY=
X-Google-Smtp-Source: ABdhPJx70SzY63SL8CtlCxjbAIK2F7YesV/QC5Q7HgCbQ2CKB8/p0Awsh0ovQDLVSxp0IG2lTMZLBQ==
X-Received: by 2002:adf:ec46:: with SMTP id w6mr44944332wrn.288.1641356441691;
        Tue, 04 Jan 2022 20:20:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n41sm1445670wms.32.2022.01.04.20.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 20:20:41 -0800 (PST)
Message-Id: <2acd70f36e73fe47261fc7b2f86dcdfc10580d82.1641356439.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v5.git.git.1641356439.gitgitgadget@gmail.com>
References: <pull.1171.v4.git.git.1641307776.gitgitgadget@gmail.com>
        <pull.1171.v5.git.git.1641356439.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 04:20:39 +0000
Subject: [PATCH v5 2/2] name-rev.c: use strbuf_getline instead of limited size
 buffer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Using a buffer limited to 2048 is unnecessarily limiting. Switch to
using a string buffer to read in stdin for annotation.

Signed-off-by: "John Cai" <johncai86@gmail.com>
---
 builtin/name-rev.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 21370afdaf9..d16b4ca0b66 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -625,12 +625,11 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	if (annotate_stdin) {
 		struct strbuf sb = STRBUF_INIT;
 
-		while (!feof(stdin)) {
-			char *p = fgets(buffer, sizeof(buffer), stdin);
-			if (!p)
-				break;
-			name_rev_line(p, &data);
+		while (strbuf_getline(&sb, stdin) != EOF) {
+			strbuf_addch(&sb, '\n');
+			name_rev_line(sb.buf, &data);
 		}
+		strbuf_release(&sb);
 	} else if (all) {
 		int i, max;
 
-- 
gitgitgadget
