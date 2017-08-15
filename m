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
	by dcvr.yhbt.net (Postfix) with ESMTP id DEAFB1F667
	for <e@80x24.org>; Tue, 15 Aug 2017 11:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751843AbdHOLtq (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 07:49:46 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37124 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751500AbdHOLtg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 07:49:36 -0400
Received: by mail-lf0-f68.google.com with SMTP id x16so459605lfb.4
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 04:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=TDfHfkrTJVTEuVYvzEJqMEt9tpe3agGI6PIBMfnU1aU=;
        b=M6s4hLvZBYoyVjoPT+P9BeClheL4CJz2SjdYLjZypSxKgXd77M8aZPrV7hgP4EKgBS
         IN7lfUt684hKyXT7uu2pa5p5pc1p7nBf0GSey5JXfY1F8NV31ETeqbtLkMSgutSa64pw
         mhXGMTVGiHrhiIczSKeJP1dbXsxNcS+rMcpQY3ZpAIVy/WivHgXoQB328YCazxfvKai8
         y1Gmx7IWxVQ7KuJpcIf1i5l3Pk0O9hFBH2jaT5I/Cgp+qE7asA3ROEGH+41vp/CqJMOK
         UqzbNwHWRQcTDoNeLT6hw9A4Jsg5YzQQNMIkVLJGgeteRZ7LDMQAgFTPxTvvjSoX5bUX
         jZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=TDfHfkrTJVTEuVYvzEJqMEt9tpe3agGI6PIBMfnU1aU=;
        b=jubneXN/ZAXnSSpMNJkfcHP78jFMRF1qT20+j/Wx/tUidiCNGHyo0Pt/Ovsryey79X
         FWtf7D/DepoDoz8MF6V365DcoVHhdQTd3UgA52Z+0UgNjDNbNmErG6CPh21NN016xwzd
         4rojXgTJGTPhHXNAbWFzxBg1iBMqjF8Xrvw+5qjU+hmgwWfVQu94wxvCzkk7x30GM+rR
         9gCAvF7f6gv+0IJ8WlRw07sFLSwUHL9HDNOEy6ogP6vw/OuAVBWAi5vzKLlijrTZ1x/p
         ilDAudj3/yjoPVyt9xXCQwDGpUeCA50m20uP79/f4yNoY7t6RvfxBkqov1hVxmr0oT51
         8FVA==
X-Gm-Message-State: AHYfb5ivSNO46uAJo3UKLvx09UlUi38BTZwmIMHO9jgfDA6wSY43iqEj
        8MBhCDMj/CjvTcQ9vPU=
X-Received: by 10.25.181.213 with SMTP id g82mr8642432lfk.197.1502797774778;
        Tue, 15 Aug 2017 04:49:34 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-225-26.play-internet.pl. [94.254.225.26])
        by smtp.gmail.com with ESMTPSA id z25sm1575317lja.1.2017.08.15.04.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Aug 2017 04:49:34 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Patryk Obara <patryk.obara@gmail.com>
Subject: [PATCH 3/5] commit: replace the raw buffer with strbuf in read_graft_line
Date:   Tue, 15 Aug 2017 13:49:04 +0200
Message-Id: <b5633a5425c623f3d2204325e99332b5bb511582.1502796628.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1502796628.git.patryk.obara@gmail.com>
References: <cover.1502796628.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1502796628.git.patryk.obara@gmail.com>
References: <cover.1502796628.git.patryk.obara@gmail.com>
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

