Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 827FA1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeH2BOU (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:14:20 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:40051 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeH2BOT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:14:19 -0400
Received: by mail-io0-f196.google.com with SMTP id l14-v6so2706702iob.7
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lIpVPO5y6jPw3YGlwYAdNuZzlWVJeH2kOLQU9le+FR4=;
        b=GpZSi28EFnBQvKtZf90verUnPqCz/yT9c+tn9jLZVAr7LnueYsrXrXlindhe6ST+Gx
         /Jbq92EZ0AnslfW2SAqurK33r5aO9x3w39VpE2rq0aax9MT5D6/kei2AxY5bZpCWLQaW
         auLDdUiunstAIeS0gz8zpTOk6NVbrbVMvMZyMaqd9RyqxfMlHM1HhnFgMFoCMTujEOMF
         2pxOtKnOrzVq3kAPp7GErZ4h4CtP6uVk4wQ47gG1j4E6kHvzpbHqI/XcAt9sRmjUlf7x
         FM90OquHD+UZmO4X1UXuh0QFfbiK74xTRAPlIChGQaurCdf3PhcFYIRMaj2aY8dRfmjm
         wizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lIpVPO5y6jPw3YGlwYAdNuZzlWVJeH2kOLQU9le+FR4=;
        b=UFVwErXKUbsIZS7vps/dERIZJNsGESMklOa02MALxAxW4KWSwTEQlNqkt6fSOfWnG1
         jG0AIGNbDLMuF/waWR0iO4Y5CcwD0UxW1x+vtXJb8DxHRBRJ0XBuq20UmrGbhhE8K6kf
         cz7ct2Hv2Vu9fXLWs3whJQrJySGwhsv6mZtMzPyFyAPfLudw20igFAQH1xB9yBr7Srgd
         q+j5yoGF7nmPd5XDs9rfmFG4/wUGB31EwulHdE3ldPHDjXY9dB2oat1lEaWM2eqhjM5v
         5xcHeuV5H+UDUWBlrqUQ28umGmtKGQee1hremMuRgnnpmYmdycHiyubki/b4wM/6lm7K
         3Etg==
X-Gm-Message-State: APzg51DoIKipPBtnO0YAu6esaubIVU97DcQu06W9f/dMTH6Q7gSbHRi6
        3V1gZobSiiGPcK6F6rEasUZbOVvs
X-Google-Smtp-Source: ANB0VdY5xdjusbTF5zry2u/vDexYjJEexPHEj79Ms1RpBz9u5AknMsuXIMn2kDpwhfAA9hIuNvr90g==
X-Received: by 2002:a5e:db07:: with SMTP id q7-v6mr3131700iop.81.1535491248767;
        Tue, 28 Aug 2018 14:20:48 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id o1-v6sm1090344iop.12.2018.08.28.14.20.47
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 14:20:48 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/9] worktree: move delete_git_dir() earlier in file for upcoming new callers
Date:   Tue, 28 Aug 2018 17:20:19 -0400
Message-Id: <20180828212026.21989-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180828212026.21989-1-sunshine@sunshineco.com>
References: <20180828212026.21989-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a pure code movement to avoid having to forward-declare the
function when new callers are subsequently added.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 41e7714396..a8128289cc 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -47,6 +47,20 @@ static int git_worktree_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+static int delete_git_dir(struct worktree *wt)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int ret = 0;
+
+	strbuf_addstr(&sb, git_common_path("worktrees/%s", wt->id));
+	if (remove_dir_recursively(&sb, 0)) {
+		error_errno(_("failed to delete '%s'"), sb.buf);
+		ret = -1;
+	}
+	strbuf_release(&sb);
+	return ret;
+}
+
 static int prune_worktree(const char *id, struct strbuf *reason)
 {
 	struct stat st;
@@ -822,20 +836,6 @@ static int delete_git_work_tree(struct worktree *wt)
 	return ret;
 }
 
-static int delete_git_dir(struct worktree *wt)
-{
-	struct strbuf sb = STRBUF_INIT;
-	int ret = 0;
-
-	strbuf_addstr(&sb, git_common_path("worktrees/%s", wt->id));
-	if (remove_dir_recursively(&sb, 0)) {
-		error_errno(_("failed to delete '%s'"), sb.buf);
-		ret = -1;
-	}
-	strbuf_release(&sb);
-	return ret;
-}
-
 static int remove_worktree(int ac, const char **av, const char *prefix)
 {
 	int force = 0;
-- 
2.19.0.rc1.350.ge57e33dbd1

