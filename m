Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9B8C433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 18:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 546526056C
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 18:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbhIFSLd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 14:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhIFSLc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 14:11:32 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DC3C061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 11:10:27 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id u4so235678qta.2
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 11:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=da99FOW0pzHyxU0tEy8U8EnlwIG6MMfNZaJnpnvAUkk=;
        b=OPTz7dJRXYKvCV0Xl3pNCutdhHDPtdYCaHKCGZNgsOgsf/FPHcpwoTsI/Oc/x5o8Xd
         DWTukytmpupXeLq3uV/XkylpQfWEPQaZP4LATNP2HbfezPOHGN465GSU9jEKBy5Vw06o
         41klovgrHpLxLfr5bRrxzvRFmevM636/C4/hIgQSbbn4Awxzu5IE07hYl1Hkh9A6R/gb
         1V7RCPvzcz7kaxyyLDp2oyW2YKWfRwghaFhNW9Q83quLlSmSTydXYEfTX0inyQSWDafl
         jGQpHOU4ZJZw2nA4qA7rKYpVmCt65LtxroNTDUA3og4TtgtD397NhNY/t1FAjX2kbzOY
         RL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=da99FOW0pzHyxU0tEy8U8EnlwIG6MMfNZaJnpnvAUkk=;
        b=Lwenl80mBBrBOrom5RL7oadM3PlSVnJ6aptVgtFxwJPfoCwh7ygmspJapPPubmd6NP
         I8926lAZYtedw0VW5xpwoaVOMGB4qFZgVQDlRJIsLZMxat0PxwIDNpKgRt/pTvtJjpd/
         YMo30nY1oyzeyebbrmPXyAkfCVMcJvY6SoFGpxLCMjgGLyh6taGpkUcyIWRv6rGFs4FP
         s8FBThGJYi2cfb7UDjwPWGrJZFpaYhpoOOWe2BOFet5rTLnC/ZaYgSNRZfVygQ7i3vq8
         qWL8mBEcQ9v0ixUp55oJE9fAc1g+oxrJ/tGEnZg3VzzS7ajgP+4NXdVZ8lTGs7Qbfps/
         HZ3w==
X-Gm-Message-State: AOAM531OLDcKov1wAbjZIBhi/qC71BPBmH48YzuGbNuLtQ7JADNMXasb
        a0HOb5cKH+M7Ns045PWtD4nUeP2TloN8tQ==
X-Google-Smtp-Source: ABdhPJyvx3TvPpAp84MdD64HVLWLY3EwApc/E8iEnUOrLxnHeYqAsMWNvjjKf/uXexvL2o0f7v0WRA==
X-Received: by 2002:a05:622a:148e:: with SMTP id t14mr12010041qtx.356.1630951826716;
        Mon, 06 Sep 2021 11:10:26 -0700 (PDT)
Received: from CalumsBeastlyLaptop ([139.147.201.88])
        by smtp.gmail.com with ESMTPSA id r128sm7168709qke.98.2021.09.06.11.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:10:26 -0700 (PDT)
Received: from calum by CalumsBeastlyLaptop with local (Exim 4.94.2)
        (envelope-from <calum@calumsbeastlylaptop.computercalum.com>)
        id 1mNJ4b-002cn6-Pq; Mon, 06 Sep 2021 14:10:25 -0400
From:   Calum McConnell <calumlikesapplepie@gmail.com>
To:     git@vger.kernel.org
Cc:     Calum McConnell <calumlikesapplepie@gmail.com>
Subject: [PATCH 1/3] Add support for new %w wildcard in checkout filter
Date:   Mon,  6 Sep 2021 14:10:00 -0400
Message-Id: <20210906181002.625647-1-calumlikesapplepie@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When building content filters with gitattributes, for instance to ensure
git stores the plain-text rather than the binary form of data for certain
formats, it is often advantageous to separate the filters into separate,
potentially complex scripts.  However, as the $PWD where content filters
are executed is unspecified the path to scripts needs to be specified as
an absolute path.  That means that the guide for setting up a repository
which uses scripts to filter content cannot simply consist of "include
the following lines in your .git/config file", and it means that the
otherwise safe operation of moving a git repository from one folder to
another is decidedly unsafe.

This %w (short for 'work tree') will allow such scripts to exist and
be executed on each checkout, without needing to be added to the PATH
or be dependent upon the $PWD of the checkout call.

Signed-off-by: Calum McConnell <calumlikesapplepie@gmail.com>
---
 convert.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/convert.c b/convert.c
index 0d6fb3410a..5d64ccce57 100644
--- a/convert.c
+++ b/convert.c
@@ -9,6 +9,7 @@
 #include "sub-process.h"
 #include "utf8.h"
 #include "ll-merge.h"
+#include "repository.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -630,19 +631,26 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 
 	/* apply % substitution to cmd */
 	struct strbuf cmd = STRBUF_INIT;
-	struct strbuf path = STRBUF_INIT;
+	struct strbuf filePath = STRBUF_INIT;
+	struct strbuf worktreePath = STRBUF_INIT;
 	struct strbuf_expand_dict_entry dict[] = {
 		{ "f", NULL, },
+		{ "w", NULL, }, 
 		{ NULL, NULL, },
 	};
 
-	/* quote the path to preserve spaces, etc. */
-	sq_quote_buf(&path, params->path);
-	dict[0].value = path.buf;
+	/* quote the paths to preserve spaces, etc. */
+	sq_quote_buf(&filePath, params->path);
+	dict[0].value = filePath.buf;
+	
+	sq_quote_buf(&worktreePath, the_repository->worktree);
+	dict[1].value = worktreePath.buf;
 
-	/* expand all %f with the quoted path */
+	/* expand all %f or %w with the quoted path */
 	strbuf_expand(&cmd, params->cmd, strbuf_expand_dict_cb, &dict);
-	strbuf_release(&path);
+	strbuf_release(&filePath);
+  	strbuf_release(&worktreePath);
+
 
 	strvec_push(&child_process.args, cmd.buf);
 	child_process.use_shell = 1;
-- 
2.30.2

