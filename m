Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3857320899
	for <e@80x24.org>; Fri, 18 Aug 2017 01:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753908AbdHRB7q (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 21:59:46 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37557 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753822AbdHRB7o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 21:59:44 -0400
Received: by mail-lf0-f67.google.com with SMTP id x16so5391003lfb.4
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 18:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=PUUCwLXMaW35/1uUm4ZZAjy5tr78DTVQPtBn9/K7AJM=;
        b=ujDXmHDFkCd0fa2LfsFF80HZMW3k3/HTfhnj2O+RykmIQ7c1EMdpSrpibSR4pvo0Ao
         9L/jXnjE4RI9b5tg5a9S05p6xctp9H03DroyI+eOGenqm2XZD3cqYTqzUTC1w+8jahFK
         1fa0FBvmUCWmcFCL5D7+lI6EQPNMaOJIIZewUsc0ZOUVwvKGMAxYWwem2akzhkkppphe
         RX6rVD6+7eF3ekBW1Wp3OfXV58U21OvbEN1VbHoI65wvXmjo98GFL2A5nuV1Yz4DoTOD
         MHxh2qzomceVltMqqWFgUlVCY7a68Vh1iAUh9FnXD7OK+GujBa91gP+g/1iRLUXota53
         RM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=PUUCwLXMaW35/1uUm4ZZAjy5tr78DTVQPtBn9/K7AJM=;
        b=KYIalt5D9+6X1+Fbhxe/AX00miDwvBwwsGX5wUM0jH7qhDi+qCN9D5eJqcGEzYulB/
         Hk28IWnLtVTviufpTxPkVx26DI5ThtzR+Y64XIWNNwc/FJh4xJyt0BUiyjI9o1GwuiLS
         KjlFMUNIjLLWOSUXJ4+YIT3QTCyOO8Gw6qWjpC6Ksg75uPnemZhxtBqaw57Ge1ovPgec
         gg8+gMui70J+U0Po67u/ZynimXr6MTV+qhrDekPs4PCWK60vVhvCiXM5rHphRlFVYPqP
         JROeX0it2+6sCjBFkGWYGqxc4aZYl8wjv7KrA38jQMoihULV6fQH8H2pHrpqHO9TEAq2
         5uoQ==
X-Gm-Message-State: AHYfb5g+PfRjgofL5k5Gr4oMpyPq3Hlp5FNNldqUbyPGb4kP7Qgdls01
        R4NCra/5GQgTRmyov3E=
X-Received: by 10.25.19.24 with SMTP id j24mr2833733lfi.54.1503021583407;
        Thu, 17 Aug 2017 18:59:43 -0700 (PDT)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id c23sm363156lfh.79.2017.08.17.18.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Aug 2017 18:59:42 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3 2/4] commit: replace the raw buffer with strbuf in read_graft_line
Date:   Fri, 18 Aug 2017 03:59:36 +0200
Message-Id: <65f84c5eb94e8b6f5cbce31f56810fdb71a58bf9.1503020338.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1503020338.git.patryk.obara@gmail.com>
References: <cover.1502905085.git.patryk.obara@gmail.com>
 <cover.1503020338.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1503020338.git.patryk.obara@gmail.com>
References: <cover.1503020338.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This simplifies function declaration and allows for use of strbuf_rtrim
instead of modifying buffer directly.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 builtin/blame.c |  2 +-
 commit.c        | 15 ++++++++-------
 commit.h        |  2 +-
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index bda1a78..d4472e9 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -488,7 +488,7 @@ static int read_ancestry(const char *graft_file)
 		return -1;
 	while (!strbuf_getwholeline(&buf, fp, '\n')) {
 		/* The format is just "Commit Parent1 Parent2 ...\n" */
-		struct commit_graft *graft = read_graft_line(buf.buf, buf.len);
+		struct commit_graft *graft = read_graft_line(&buf);
 		if (graft)
 			register_commit_graft(graft, 0);
 	}
diff --git a/commit.c b/commit.c
index 8b28415..019e733 100644
--- a/commit.c
+++ b/commit.c
@@ -134,17 +134,18 @@ int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 	return 0;
 }
 
-struct commit_graft *read_graft_line(char *buf, int len)
+struct commit_graft *read_graft_line(struct strbuf *line)
 {
 	/* The format is just "Commit Parent1 Parent2 ...\n" */
-	int i;
+	int i, len;
+	char *buf = line->buf;
 	struct commit_graft *graft = NULL;
 	const int entry_size = GIT_SHA1_HEXSZ + 1;
 
-	while (len && isspace(buf[len-1]))
-		buf[--len] = '\0';
-	if (buf[0] == '#' || buf[0] == '\0')
+	strbuf_rtrim(line);
+	if (line->buf[0] == '#' || line->len == 0)
 		return NULL;
+	len = line->len;
 	if ((len + 1) % entry_size)
 		goto bad_graft_data;
 	i = (len + 1) / entry_size - 1;
@@ -161,7 +162,7 @@ struct commit_graft *read_graft_line(char *buf, int len)
 	return graft;
 
 bad_graft_data:
-	error("bad graft data: %s", buf);
+	error("bad graft data: %s", line->buf);
 	free(graft);
 	return NULL;
 }
@@ -174,7 +175,7 @@ static int read_graft_file(const char *graft_file)
 		return -1;
 	while (!strbuf_getwholeline(&buf, fp, '\n')) {
 		/* The format is just "Commit Parent1 Parent2 ...\n" */
-		struct commit_graft *graft = read_graft_line(buf.buf, buf.len);
+		struct commit_graft *graft = read_graft_line(&buf);
 		if (!graft)
 			continue;
 		if (register_commit_graft(graft, 1))
diff --git a/commit.h b/commit.h
index 6d857f0..baecc0a 100644
--- a/commit.h
+++ b/commit.h
@@ -247,7 +247,7 @@ struct commit_graft {
 };
 typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
 
-struct commit_graft *read_graft_line(char *buf, int len);
+struct commit_graft *read_graft_line(struct strbuf *line);
 int register_commit_graft(struct commit_graft *, int);
 struct commit_graft *lookup_commit_graft(const struct object_id *oid);
 
-- 
2.9.5

