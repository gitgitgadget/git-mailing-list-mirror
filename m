Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A1CC54FCA
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3842120753
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0m1m4iS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgCUJWV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:22:21 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:42622 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgCUJWV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 05:22:21 -0400
Received: by mail-qk1-f173.google.com with SMTP id e11so9791999qkg.9
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 02:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nbK5JJ+rVte9qzemA7w3H7vu9iGm737vIQwcsQLzN1I=;
        b=l0m1m4iSuEP/OgvYcW5c1WrXJqra2ppPdbPrDzCiZbabm78r0VzlBgZApJhZpbKLTh
         7O6iye4WdLPzlZ7yK9yr4isMUvA8Xl4qg/QachDV/CgNWZ2SiMpMHn0Tr+nrGslojr3c
         1FnAAmMduIIgYaKG7T5Sx7LA0/iwhKTDPIECXNLj5DplqjXOpX6EuFBBkcB1hoPU5idr
         2wTtnfCYpLVSR990Hudnn8d3R3YdPaNlSKAIpo+w9GJ6vCvvKh1OHy5YJmwch6S5K5Am
         xjonSyCABdGeBvvHpqWkENgN7e/I2OyjoZTCtOUqJ2wv5yhLtX/WzvRa1oNDEy52g35v
         ZWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nbK5JJ+rVte9qzemA7w3H7vu9iGm737vIQwcsQLzN1I=;
        b=HdYT55jyzbxVlgetFzL85H2QhoJ17c7Lpc/U+o2bceZvyUy/gVo9qZJLF5rDKh3sKv
         YdZAIyD50ITtcFNVlREvrV0qDV+fgYt6CtqM9xUG98pgEoUsUgwyzFP+kHLs6LOBhvb9
         les1giWvOpDTw21O31PzsYvjBj7QE6Svr9D3EXAmCaV9PMmfWS+TrS/T6PeQ3v36Nmj4
         HCvzglXuaqjBGYXU+WBcVhKMuH7IBnn2t7xezeYf996P3uOKFQFlAdTGwaMB1vQeuUAY
         cAlIv4zw0gn3fKhIkq2ua9lk8xSJu57muxF+36pAlN+VbpcVHUDZ0YiRavUEKWFvaVdJ
         l7HA==
X-Gm-Message-State: ANhLgQ05MjcgQr12CGAxMT3Mdbn452UXlyNWcYJIe8CUNLYUw/kKkxVI
        1MJGA6KTAQOMDHhjCCJfIl1seSuE
X-Google-Smtp-Source: ADFU+vvK785FogmySlmd4hMgsiYunKXBTJ3k3myz9yJYFvw5l35IFJlMmNohhbwcffJQ6MZf67nSUQ==
X-Received: by 2002:a37:9d89:: with SMTP id g131mr12332694qke.166.1584782540160;
        Sat, 21 Mar 2020 02:22:20 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id z23sm6579890qkg.21.2020.03.21.02.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 02:22:19 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 06/19] sequencer: make read_oneliner() extern
Date:   Sat, 21 Mar 2020 05:21:25 -0400
Message-Id: <e4d0c2d9020e1f76928d590c2692502e87babcfa.1584782450.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1584782450.git.liu.denton@gmail.com>
References: <cover.1577185374.git.liu.denton@gmail.com> <cover.1584782450.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function read_oneliner() is a generally useful util function.
Instead of hiding it as a static function within sequencer.c, extern it
so that it can be reused by others.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 14 +-------------
 sequencer.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 92e8d38290..c2102cc2eb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -419,19 +419,7 @@ static int write_message(const void *buf, size_t len, const char *filename,
 	return 0;
 }
 
-#define READ_ONELINER_SKIP_IF_EMPTY (1 << 0)
-#define READ_ONELINER_WARN_NON_EXISTENCE (1 << 1)
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
 	int ret = 0;
diff --git a/sequencer.h b/sequencer.h
index 718a07426d..5c9662a60a 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -198,6 +198,20 @@ void print_commit_summary(struct repository *repo,
 			  const struct object_id *oid,
 			  unsigned int flags);
 
+#define READ_ONELINER_SKIP_IF_EMPTY (1 << 0)
+#define READ_ONELINER_WARN_NON_EXISTENCE (1 << 1)
+
+/*
+ * Reads a file that was presumably written by a shell script, i.e. with an
+ * end-of-line marker that needs to be stripped.
+ *
+ * Note that only the last end-of-line marker is stripped, consistent with the
+ * behavior of "$(cat path)" in a shell script.
+ *
+ * Returns 1 if the file was read, 0 if it could not be read.
+ */
+int read_oneliner(struct strbuf *buf,
+	const char *path, unsigned flags);
 int read_author_script(const char *path, char **name, char **email, char **date,
 		       int allow_missing);
 void parse_strategy_opts(struct replay_opts *opts, char *raw_opts);
-- 
2.25.0.114.g5b0ca878e0

