Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34D4C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A85B964E50
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBAWEC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhBAWDh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 17:03:37 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E519EC061797
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 14:02:32 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id j18so620295wmi.3
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 14:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+KteHt2BWR//iqZgex9DKa/luwnSNm9uhzmwsnCG0fE=;
        b=s5dY7oOnZbZ9ZZ177l8XIMNHsMduXKWxJSkbUDZVjTTvaANEH3NkqUcuTf78IVxVWt
         wJq7LzpGkCbK3lYYPnQQsqE9UIZ8IL1RxAs+Bj6NPMpgXD7VWg3v6y9gJa4v6u5d3tvK
         meCRYq/GayeH7LGZF31hpVELLQPmGhRA2VDIBoxX6io4EvnJJhesnVDlgGtoIsEaSaOs
         KBUtDdNZrYmtZjWbZOEh8zJMSBiuchwTHfH3VsBs4bTnCPiD/3rmYkk+AOPk7eRmbDmL
         5g+Tk8QBKazu/T9vHp9/Uf15ntDOon6TR+gGrpATgcrFNNtD5u03c1FN8FQmlRxurgnH
         klng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+KteHt2BWR//iqZgex9DKa/luwnSNm9uhzmwsnCG0fE=;
        b=N6Dct8wS7vuXpl7IXE9oQJJyhuXlcpDzfgZpnBvw/6WW7s78V912EIEZ0q7BuRapTM
         0cl1ZDsIBhiONT90GvtCRHXuaHCa7+0NXBfaSNxbc0IBPAyXhiVEAF8BfFs5dQNO9YYh
         a016RJyEm/06yIccmnljQm4V5Nks4CKzvG318d8eyX61TNWQb8QOgmIDwPo/SulG2fKW
         +y1lu3SOwGQ9y6V/FQ+raD5U0FIjstWL58NDkwea/nMAURI4P/xYG76jEo6P5gkRF+2d
         a1DU9WCR1q8R09PMKyPeBCFxy5mQ2DHjOFPtHya0zNUGrboSClDHd93LhNmETkSJ2Nkz
         kZIA==
X-Gm-Message-State: AOAM530Xf1xPSsdxVN+DGqrKf3NXh0k6mjIZARyEmXUlZC3cD6/SM+DR
        3j6yTebDBoSOkHk484v/LVaScirVczk=
X-Google-Smtp-Source: ABdhPJzUJ3cymq5llfAQxRPWrGNQ7GsEHSWaefIlmbHgAyawTWLo41msRWcan864n6tdANGRQVFimQ==
X-Received: by 2002:a1c:356:: with SMTP id 83mr810738wmd.31.1612216951494;
        Mon, 01 Feb 2021 14:02:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r13sm646481wmh.9.2021.02.01.14.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 14:02:30 -0800 (PST)
Message-Id: <ef64b60c7a0c85df08198a8f104029742c555bad.1612216941.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.860.git.1612216941.gitgitgadget@gmail.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 22:02:17 +0000
Subject: [PATCH 08/11] fsmonitor: log invocation of FSMonitor hook to trace2
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

