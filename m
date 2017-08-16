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
	by dcvr.yhbt.net (Postfix) with ESMTP id 214611F667
	for <e@80x24.org>; Wed, 16 Aug 2017 17:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752313AbdHPR7P (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 13:59:15 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36637 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751772AbdHPR7K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 13:59:10 -0400
Received: by mail-lf0-f67.google.com with SMTP id t128so2959352lff.3
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 10:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=TDfHfkrTJVTEuVYvzEJqMEt9tpe3agGI6PIBMfnU1aU=;
        b=RA9NfnBu1f5HCIEzLVBqjDfoA4o/7ugOmGbK8bFD9unTpNYmQXgYGDgR8UaOqfEP1o
         NsGAWPjgX53JaMIrfFhIo4YoRxwhRNOx96wdp8wQMbf6/AalzyuBYvMm5PnqJX4Kb/k3
         cCS/u1uFP8l8pyr1NlAmjyY5QU/8rz2ddPtA34IL2GaUcjjNKbZo83WBjknuQ74VphTM
         GeVjOgQkPL5DbPSvBcfIg0377LY9cBY2kg6UlfKKZ2/Qvy1gLFjNULpDrILnmqfF6Etx
         J+vNZSejxSeBRMedTltIOADOhvdZ1IUsqQH7ET5Fi42EemNkYhIyx8TMMynu0Bbs9gAK
         liVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=TDfHfkrTJVTEuVYvzEJqMEt9tpe3agGI6PIBMfnU1aU=;
        b=MJTeWPjOAVVf6ab/JQIlxS+KAILql14wS1LOXts67/bpqb61idNqtt+MHiKXWI/vT4
         b7D+qz5/htnTE9fXwnsI6vMpVX/oASZXX0NFeNaYT1vP+jc7NhQ+TVlyV3RDtHh+rtOA
         W8xYFg4lawXplZhMrFrbjJ/ugvwdAgCVzLUzke9S0LEXKJ8ZZl/yvHX/pJS5JUCcAVR0
         f1b8H88mDoqr+9KZYpPTH1F1U+BZq1jC8qLj1vjT+BW5k68i6gDIQLWZNAdQxzZwro37
         7R9KTuphesq/9I1spxHWcB3ayz6xosJeTw6P07I+H5T2r25xmpb/fJV/XHdG1yiHv8dk
         kX9Q==
X-Gm-Message-State: AHYfb5iOA4wsJrjg4pEdXde+u9uF2cEThDgbAdakvf/KSqmEjSpiviDS
        //sRktq/7ytpAPkSsMU=
X-Received: by 10.25.77.213 with SMTP id a204mr1021711lfb.215.1502906349155;
        Wed, 16 Aug 2017 10:59:09 -0700 (PDT)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id c64sm361245lfc.4.2017.08.16.10.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Aug 2017 10:59:08 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Patryk Obara <patryk.obara@gmail.com>
Subject: [PATCH v2 2/4] commit: replace the raw buffer with strbuf in read_graft_line
Date:   Wed, 16 Aug 2017 19:58:23 +0200
Message-Id: <db36e425b29855e31f11f511a27c04cd8b4a19dd.1502905085.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1502905085.git.patryk.obara@gmail.com>
References: <cover.1502796628.git.patryk.obara@gmail.com>
 <cover.1502905085.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1502905085.git.patryk.obara@gmail.com>
References: <cover.1502905085.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This simplifies function declaration and allows for use of strbuf_rtrim
instead of modifying buffer directly.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 builtin/blame.c |  2 +-
 commit.c        | 11 ++++++-----
 commit.h        |  2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

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
index 8b28415..499fb14 100644
--- a/commit.c
+++ b/commit.c
@@ -134,15 +134,16 @@ int register_commit_graft(struct commit_graft *graft, int ignore_dups)
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
+	strbuf_rtrim(line);
+	len = line->len;
 	if (buf[0] == '#' || buf[0] == '\0')
 		return NULL;
 	if ((len + 1) % entry_size)
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

