Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B347C2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BAC207FF
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZDiMInC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgDGO2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:28:30 -0400
Received: from mail-qv1-f49.google.com ([209.85.219.49]:36291 "EHLO
        mail-qv1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbgDGO22 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:28:28 -0400
Received: by mail-qv1-f49.google.com with SMTP id z13so1901080qvw.3
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wa2yiFIEEyk0AqLOmMfh2cG0f/BmgdXoO+zDzix18sM=;
        b=BZDiMInC85sSPZf3zEAY2IjnuHt3gIBA2tCDV6s0JK1uIyutzxzADsGGKAaXOW26J8
         iJTWH8F07et5g+T+1yK5KuNnw5kMIRPnhh+2yIyXKK8pfNYAtshpBPQlddF68Adbll9z
         XNUICBYRx87M7zIk/VKHhpcGb2alqfrmxcnLi/GQ5hsW9mBpvW8O2/PAQvq0pAnFqXXg
         CPIoBY00BI1skJVBRqoJ+3BK2c2D2SKvc10YKtpkUaM1ZJxgfq4EM0cYL1kvcCkusWNu
         1Gwuu8E/MwIYMKtmGziQgMGngoYdPc9MTT2aDP8OfUdbRmnWL+AVf/BeK2ik0OZ/Syzs
         raIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wa2yiFIEEyk0AqLOmMfh2cG0f/BmgdXoO+zDzix18sM=;
        b=g9xgvlFowXFqP9u4qfR7faTrDxk37Rvld2LQo4TQHx8R/uIu3/dKFIgMXH/uXZdCE+
         HalxUBSRvZseF5acK+lwegSgnj4yORv7flrMm2Ts1pPVpEGX4ADdhwHaHiDF7GxCj1sN
         SgAYKafaTCBoxHk89nCwYIIM/2+xBjcuHXNIqVelBn+St9jcTjerA1dmfJEAbGB5H01n
         3mpZAOgy15lxxkInWK77IH8ykqh/3otVL9r4ANYDaO6/wRPuWQHq+lpjpVXfYQ0Wsp9n
         p417zcekehpIC4IwVLSxZJ9SVdjan/e6wfS+adyt9oFR+GezSFgdSVuHyGxDvZA7u0wf
         dUqQ==
X-Gm-Message-State: AGi0PuaRcVvwnXpBsy3+wQbAexjD0uQMxOB2nXjL/C6g6atRoL54DMy5
        enNUUYr4SXqs3ci9DcEo+cTk5gFS
X-Google-Smtp-Source: APiQypJm1kNd86wo4Si+NvOGHcIDyRlxnF9JqxsEQxGTiXj+T2VXW0g34jC3DKwPVaL6K4jytR0hmg==
X-Received: by 2002:a0c:a122:: with SMTP id d31mr1461608qva.109.1586269706945;
        Tue, 07 Apr 2020 07:28:26 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id j6sm17051736qti.25.2020.04.07.07.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:28:26 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 07/22] sequencer: make read_oneliner() extern
Date:   Tue,  7 Apr 2020 10:27:54 -0400
Message-Id: <50e93770e76863b05e51c25192a7173dc38e0ffe.1586269543.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1586269542.git.liu.denton@gmail.com>
References: <cover.1585962672.git.liu.denton@gmail.com> <cover.1586269542.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function read_oneliner() is a generally useful util function.
Instead of hiding it as a static function within sequencer.c, extern it
so that it can be reused by others.

This patch is best viewed with --color-moved.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 14 +-------------
 sequencer.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 32cc289da3..0d98ddc33c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -419,19 +419,7 @@ static int write_message(const void *buf, size_t len, const char *filename,
 	return 0;
 }
 
-#define READ_ONELINER_SKIP_IF_EMPTY (1 << 0)
-#define READ_ONELINER_WARN_MISSING (1 << 1)
-
-/*
- * Reads a file that was presumably written by a shell script, i.e. with an
- * end-of-line marker that needs to be stripped.
- *
- * Note that only the last end-of-line marker is stripped, consistent with the
- * behavior of "$(cat path)" in a shell script.
- *
- * Returns 1 if the file was read, 0 if it could not be read or does not exist.
- */
-static int read_oneliner(struct strbuf *buf,
+int read_oneliner(struct strbuf *buf,
 	const char *path, unsigned flags)
 {
 	int orig_len = buf->len;
diff --git a/sequencer.h b/sequencer.h
index 718a07426d..ab43717fd6 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -198,6 +198,20 @@ void print_commit_summary(struct repository *repo,
 			  const struct object_id *oid,
 			  unsigned int flags);
 
+#define READ_ONELINER_SKIP_IF_EMPTY (1 << 0)
+#define READ_ONELINER_WARN_MISSING (1 << 1)
+
+/*
+ * Reads a file that was presumably written by a shell script, i.e. with an
+ * end-of-line marker that needs to be stripped.
+ *
+ * Note that only the last end-of-line marker is stripped, consistent with the
+ * behavior of "$(cat path)" in a shell script.
+ *
+ * Returns 1 if the file was read, 0 if it could not be read or does not exist.
+ */
+int read_oneliner(struct strbuf *buf,
+	const char *path, unsigned flags);
 int read_author_script(const char *path, char **name, char **email, char **date,
 		       int allow_missing);
 void parse_strategy_opts(struct replay_opts *opts, char *raw_opts);
-- 
2.26.0.159.g23e2136ad0

