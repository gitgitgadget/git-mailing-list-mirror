Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00D3E1F51A
	for <e@80x24.org>; Tue, 15 May 2018 23:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbeEOXnP (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 19:43:15 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:39536 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbeEOXm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 19:42:57 -0400
Received: by mail-pf0-f175.google.com with SMTP id a22-v6so818231pfn.6
        for <git@vger.kernel.org>; Tue, 15 May 2018 16:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UcpXGw/JnQEqnokGSM49Yh0JWbBsG4cCiH2gCv8T7uI=;
        b=jiw7IfWiQCQEH05P3pGCHxJDW9mdVoN2Q5GmkpNEPGmVDobVkIREao9SOStGVCNqXX
         CJS9TQSujHLWBbET59+0Gq5eagcCiz1BCGRy+s7kMiwY0MlMcM3YmrFLYb2dlC0CLhpb
         H/yYIp64EV8I3nA3PoWvmsEsxn9YBywnFUTx1Hmqs9e/L0vn84wSOwZ59c37d0Ngc67U
         CrcHiugaEghUmp7LaxhGtBm7G7deGPldKwQZ3pyu1q/kE+15pJtra3UmIApQLQPC+YbG
         AK/gmCRjIs3Hyn0JHNMsUNLqwVPT1o+mst4Jh+M08PKbXbHeM5hV/Howe16qIYxBTzj3
         alYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UcpXGw/JnQEqnokGSM49Yh0JWbBsG4cCiH2gCv8T7uI=;
        b=hssm34UO7rwcp0a+1nzXsgjsEeKkS/98mvYUZVSiAGf6ndACplo0tiYoRgA0WU+6nJ
         VP4PO79TAOpGP6SnJAZEgwa4RJRgbMN9EQZAk1DKmHkNUEdlFAV4kqaapjIWhk9vzZbB
         vaeuVXmgDP+BdLk3FvDiTGiUEyeJTN6PASJt9A6pXPrt+uCNFBkFTsVYJfgYG5Z/xrNk
         lLF3vGLaOPtIVSfD5uAmufIJbzo9CqWwL76F7bm32SYaqvVS8HudKO/NFySdecQ2E+cP
         G2NcoDTRHNVm+KFAhmZcLMq2hSinJgwYKtEybllkX3+l+aaAnlX0ZSd86dxdJe5S4rL8
         +frw==
X-Gm-Message-State: ALKqPwedUDX4LlQQgaVtIam7YDeKSAa9+MJ9fEYe1WfXeMIGBSj9LqA4
        u2l/uMIl7JmRqY1yPIDw69yD1Y9VeaM=
X-Google-Smtp-Source: AB8JxZpXkF5VCmVvVqxwD50VZCJLFCc6fDgS/hCTPj1lQv0UOPbi6Hmv1BbiZ8zviP2CRyzMJh2trw==
X-Received: by 2002:a62:3cd1:: with SMTP id b78-v6mr16920452pfk.44.1526427776401;
        Tue, 15 May 2018 16:42:56 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id p84-v6sm1711071pfi.66.2018.05.15.16.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 16:42:55 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 14/19] commit: convert read_graft_file to handle arbitrary repositories
Date:   Tue, 15 May 2018 16:42:28 -0700
Message-Id: <20180515234233.143708-15-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180515234233.143708-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Brandon Williams <bmwill@google.com>

Signed-off-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index 8a2ab53fc67..3fcb2fd66ce 100644
--- a/commit.c
+++ b/commit.c
@@ -177,8 +177,7 @@ struct commit_graft *read_graft_line(struct strbuf *line)
 	return NULL;
 }
 
-#define read_graft_file(r, f) read_graft_file_##r(f)
-static int read_graft_file_the_repository(const char *graft_file)
+static int read_graft_file(struct repository *r, const char *graft_file)
 {
 	FILE *fp = fopen_or_warn(graft_file, "r");
 	struct strbuf buf = STRBUF_INIT;
@@ -189,7 +188,7 @@ static int read_graft_file_the_repository(const char *graft_file)
 		struct commit_graft *graft = read_graft_line(&buf);
 		if (!graft)
 			continue;
-		if (register_commit_graft(the_repository, graft, 1))
+		if (register_commit_graft(r, graft, 1))
 			error("duplicate graft data: %s", buf.buf);
 	}
 	fclose(fp);
-- 
2.17.0.582.gccdcbd54c44.dirty

