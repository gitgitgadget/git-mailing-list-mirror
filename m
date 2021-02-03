Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445B2C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB9E164F5D
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbhBCPku (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 10:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbhBCPhY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 10:37:24 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2C4C0617A9
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 07:35:02 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v15so24895998wrx.4
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 07:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+KteHt2BWR//iqZgex9DKa/luwnSNm9uhzmwsnCG0fE=;
        b=i8jLYMoH9MAF7drPuad5Nz4gOnE5G+n0V4L4HvLw4+tq/+43k2tiKdXIuMZtKXz7cS
         S6FUxbVxZ2f9Mws9meFYd3uJtRaHUTIWMPkB1xdiBh4asWy6srZEkoRqTmWTXBr0izM6
         hRPY4P8CeYX+4QuiQpeN4BQM+bb+/k+gBK+NB8390s86+pJk7J10mL6SvzcU6nF21Z84
         QSzXm33Lh5wDbvcXSWrvpt+SdTOKDlrxKmAyzhd7H0k9MYTcvKuz9jfsVsAxEy/vFIKh
         BnBfeHAWLoI0b1Kul18fRVOHEBNBNLRBklvWbR3PiWLfl/lr73OugEYe0OmRYtEh0B6t
         gAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+KteHt2BWR//iqZgex9DKa/luwnSNm9uhzmwsnCG0fE=;
        b=FsRXfSmiGGeSTRZ5lJSuWUwryxOuOJopnra80T6e60Zp/vgWlqn+cCrQsSzfHd0OR4
         5xeTJf9Fl1XKLytp1F3mx55HZKS0j3iyGFNlaUua1N+S7CoFWUzUNoEzo1MdKCJGmQEN
         hmIYlaIP89+u38dzbbI9lFuHloDpKOfTohzXkk05nDlraq5AHiejIejzrKF5IEI57wMG
         DM7K6PuJw33Toen5RjFLp+vzL4/adTLD1K6TNLNVSwZPVvcZJmzcS5nVO8zB2SB9nFsi
         /V2O2B690mI/2RMnMo4Avi1rxQSKjxKHLa0k+QXQtnrQN6a0FomPgeuBemzpEIUVn5UJ
         SxFw==
X-Gm-Message-State: AOAM533YJ4rf6e0eEMT2w6S576dXN2IdziSea1t/oJ7BqpB4JVRnFtHh
        wyzYaPK+gYfdvJlO0C/Exo4s6bKT9as=
X-Google-Smtp-Source: ABdhPJySfk2DRJSCKE0M3J8cFgibvXTJQjw3DvIPbhN1cQT0jlX6a2nYOeVLbaFa1W8ziB9OzV4nsw==
X-Received: by 2002:adf:f149:: with SMTP id y9mr4175152wro.144.1612366501024;
        Wed, 03 Feb 2021 07:35:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t18sm4190535wrr.56.2021.02.03.07.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:35:00 -0800 (PST)
Message-Id: <c043bccc8affd56f920158935671f9e172d6d343.1612366490.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
        <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 15:34:47 +0000
Subject: [PATCH v2 08/11] fsmonitor: log invocation of FSMonitor hook to
 trace2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Let's measure the time taken to request and receive FSMonitor data
via the hook API and the size of the response.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 fsmonitor.c | 29 ++++++++++++++++++++++++++++-
 fsmonitor.h |  5 +++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index ca031c3abb8..7a2be24cd43 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -142,6 +142,7 @@ void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
 static int query_fsmonitor(int version, const char *last_update, struct strbuf *query_result)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
+	int result;
 
 	if (!core_fsmonitor)
 		return -1;
@@ -152,7 +153,33 @@ static int query_fsmonitor(int version, const char *last_update, struct strbuf *
 	cp.use_shell = 1;
 	cp.dir = get_git_work_tree();
 
-	return capture_command(&cp, query_result, 1024);
+	trace2_region_enter("fsm_hook", "query", NULL);
+
+	result = capture_command(&cp, query_result, 1024);
+
+	if (result)
+		trace2_data_intmax("fsm_hook", NULL, "query/failed", result);
+	else {
+		trace2_data_intmax("fsm_hook", NULL, "query/response-length",
+				   query_result->len);
+
+		if (fsmonitor_is_trivial_response(query_result))
+			trace2_data_intmax("fsm_hook", NULL,
+					   "query/trivial-response", 1);
+	}
+
+	trace2_region_leave("fsm_hook", "query", NULL);
+
+	return result;
+}
+
+int fsmonitor_is_trivial_response(const struct strbuf *query_result)
+{
+	static char trivial_response[3] = { '\0', '/', '\0' };
+	int is_trivial = !memcmp(trivial_response,
+				 &query_result->buf[query_result->len - 3], 3);
+
+	return is_trivial;
 }
 
 static void fsmonitor_refresh_callback(struct index_state *istate, const char *name)
diff --git a/fsmonitor.h b/fsmonitor.h
index 739318ab6d1..7f1794b90b0 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -44,6 +44,11 @@ void tweak_fsmonitor(struct index_state *istate);
  */
 void refresh_fsmonitor(struct index_state *istate);
 
+/*
+ * Does the received result contain the "trivial" response?
+ */
+int fsmonitor_is_trivial_response(const struct strbuf *query_result);
+
 /*
  * Set the given cache entries CE_FSMONITOR_VALID bit. This should be
  * called any time the cache entry has been updated to reflect the
-- 
gitgitgadget

