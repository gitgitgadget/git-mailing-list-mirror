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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED7BC4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77752070A
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="romVce3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgCUJWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:22:17 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:35931 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgCUJWR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 05:22:17 -0400
Received: by mail-qv1-f66.google.com with SMTP id z13so4473351qvw.3
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 02:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nsep9eFqDJqK599AyBuyguj4crSxZCp/l2148748kJg=;
        b=romVce3gpiObfyo6Bs/87Kmn1IUdl9I+iplWAp2+cbssVCs88Je2zbt9i9ZWT58dyb
         DU1xshGxyhZAPOThr+ewaM0DdSAniR6/CzDKsiaj+aRQA+Wh4NLzYsDyMypqff49mOYE
         Y2W9X8EB+UPUsa8k/lfsNwsJ9DGAUsbMwqSiNI5jEs/kfzwoSgz7wTsD0488ZzY1ScnY
         7/kWHMVWonmqv4qrkPyAjYS7ux0Esi7RjGU0ErwPUSzUwiVrNmIJ9KnY/CALuoPnEiHg
         uJu0YeDdIZueBeaJmqhnpkw/Uqh3cLoihR46PWFdMxjKm9/9abhhAM+bAGZeD7nydPEl
         0+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nsep9eFqDJqK599AyBuyguj4crSxZCp/l2148748kJg=;
        b=Jb4weo2lGmR2mC2FUQ/dZFrPDmIRX+JCdfQZqMldHS+BNxmKYhnDODOM26Tmpts+o9
         +VZ7VDTEaP3lT9yqugEGwvynDwA7ZC+N0+Meoe724EjJIhi8KBSZ8yGBVlMPu+lqDcGW
         TAtKU45C/wPUnWNLrB4Z38wuV8F1t4SW0ZT7s80de9K2npxxRWG5yEkfqTJqVkvPrZwu
         LYKzZWQZuRjZGPBx0sf3plKEK64qQuAaFExTB4SCiQ8myMyrXt6siYDbdybcRKYQHAhl
         OJX9WRX/j8nW2uKebuK+g1T63EJpBUi2FfA4d5HgVRJ/hoQJzSioagDkcHWfg5aY1BgG
         UGtw==
X-Gm-Message-State: ANhLgQ0/1zD5h5IbfGDaDjuLJXS5xzJunfim6n/ndVMTv4WSL+dwNrCp
        xZhFQbIs1sHQ5sUyOuzxDoSGBRbl
X-Google-Smtp-Source: ADFU+vsKzBfrRdPXUyX4viK6cl/y1icN7A0VrJ4rghOu8p+3a9pomuzahj4rvpc+KNCMTHiL45zGyg==
X-Received: by 2002:ad4:4364:: with SMTP id u4mr11677961qvt.58.1584782535933;
        Sat, 21 Mar 2020 02:22:15 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id z23sm6579890qkg.21.2020.03.21.02.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 02:22:15 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 03/19] sequencer: use file strbuf for read_oneliner()
Date:   Sat, 21 Mar 2020 05:21:22 -0400
Message-Id: <7c37777f07191c8ac1d26300f9465b90758550b2.1584782450.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1584782450.git.liu.denton@gmail.com>
References: <cover.1577185374.git.liu.denton@gmail.com> <cover.1584782450.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the original read_oneliner logic, we duplicated the logic for
strbuf_trim_trailing_newline() with one exception: instead of preventing
buffer accesses below index 0, it would prevent buffer accesses below
index `orig_len`. Although this is correct, it isn't worth having the
duplicated logic around.

Add a second strbuf to which files are read and run
strbuf_trim_trailing_newline() directly on this strbuf then concatenate
this strbuf with the argument strbuf at the end of the function. The
function's external behaviour is unchanged.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e528225e78..c49fe76fe6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -431,26 +431,28 @@ static int write_message(const void *buf, size_t len, const char *filename,
 static int read_oneliner(struct strbuf *buf,
 	const char *path, int skip_if_empty)
 {
-	int orig_len = buf->len;
+	int ret = 0;
+	struct strbuf file_buf = STRBUF_INIT;
 
 	if (!file_exists(path))
 		return 0;
 
-	if (strbuf_read_file(buf, path, 0) < 0) {
+	if (strbuf_read_file(&file_buf, path, 0) < 0) {
 		warning_errno(_("could not read '%s'"), path);
-		return 0;
+		goto done;
 	}
 
-	if (buf->len > orig_len && buf->buf[buf->len - 1] == '\n') {
-		if (--buf->len > orig_len && buf->buf[buf->len - 1] == '\r')
-			--buf->len;
-		buf->buf[buf->len] = '\0';
-	}
+	strbuf_trim_trailing_newline(&file_buf);
 
-	if (skip_if_empty && buf->len == orig_len)
-		return 0;
+	if (skip_if_empty && !file_buf.len)
+		goto done;
 
-	return 1;
+	strbuf_addbuf(buf, &file_buf);
+	ret = 1;
+
+done:
+	strbuf_release(&file_buf);
+	return ret;
 }
 
 static struct tree *empty_tree(struct repository *r)
-- 
2.25.0.114.g5b0ca878e0

