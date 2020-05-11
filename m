Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03F4C47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9A3F206F5
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPTcGVVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbgEKTqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 15:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbgEKTqd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 15:46:33 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3503C061A0C
        for <git@vger.kernel.org>; Mon, 11 May 2020 12:46:32 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so12509113wra.7
        for <git@vger.kernel.org>; Mon, 11 May 2020 12:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yByOx8Gp2oGeDi3Ff0uJaMx+4YFkzZwhj52WjMTFMH4=;
        b=PPTcGVVCUIryeLE+TfFbhNeL7VTwA8p9DFrZjw9G/FhvnM/zB97D99VB8sxW9gIpYH
         Y9ni7OexRa+BcDMRFIQjyBNNuhzMirVuzHPhBTALsp0ql30rz6CgiPALmnpLFV7tU/G6
         dHiyuPK7kZcROxwCMz7D2NEdwDd7N4uPlc/LvmyUyEqviu2uwa8D9WVzfE+ehXj4t8WT
         mQ4V/R7FkFKIZO2N2vHtM52WXDbtwe3FsYwnK8C0ZIQYl4/CN/XqsIwdQbqjKX/muRXx
         aIZ/b6ltsItWdNXlSf27YkoIr0g5s0ovF1hqF7vpoliiH54YWaWw5409c5utEFT0iSLA
         zKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yByOx8Gp2oGeDi3Ff0uJaMx+4YFkzZwhj52WjMTFMH4=;
        b=jBG9Snh6rQnjMU6B0B2Rp9O+jwraubncwD5eGKKOznX0ZFDXkGrPrjkNJm+NG5qaHg
         COq6Hc+tZT9ved2e3lEgUHT259tI+IRwPHukhUDSKDhQ6DQYR3XkGaFCfL2WzuM9UJM8
         K/yXJSkrYd1bsOBCkEOpnSrRGD8TyAzVw8H83gXbaDuW6Ytbn9//eedSulro3R7QEmTa
         oLncLQz9ZC7h6aWMFnMdK9QEnvubCGdJwBgN23+Ax0BLM0wh0GAVkk6FV+CPYvYMcOzw
         9SXtE9dG31rX8USJexAX94rBUJgSVGvXmKKZgF4lt7qoFLzFqvbsnwlmRe7g33WbGhrj
         IlfQ==
X-Gm-Message-State: AGi0PuajV31id+MwiSimMfLs07jS0x3IQutv6IKiyV1ElVyWXNkFPj48
        McUmvgVIAxzgDVusPGhU3zyXejkf
X-Google-Smtp-Source: APiQypKId/Fjax9MZpoLRfWrVuhpOHpgqPsFLHzB6BiL3YvzlN9rcYiMyQgaqR8l0Jb7gLKvSNQNUg==
X-Received: by 2002:adf:ea05:: with SMTP id q5mr19855782wrm.87.1589226391297;
        Mon, 11 May 2020 12:46:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8sm19324236wrg.85.2020.05.11.12.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 12:46:30 -0700 (PDT)
Message-Id: <8394c156eb4aef348f36622c3ec07e3a825b1c41.1589226388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 19:46:16 +0000
Subject: [PATCH v13 01/13] refs.h: clarify reflog iteration order
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/refs.h b/refs.h
index a92d2c74c83..99ba9e331e5 100644
--- a/refs.h
+++ b/refs.h
@@ -432,19 +432,31 @@ int delete_refs(const char *msg, struct string_list *refnames,
 int refs_delete_reflog(struct ref_store *refs, const char *refname);
 int delete_reflog(const char *refname);
 
-/* iterate over reflog entries */
+/* Callback to process a reflog entry found by the iteration functions (see
+ * below) */
 typedef int each_reflog_ent_fn(
 		struct object_id *old_oid, struct object_id *new_oid,
 		const char *committer, timestamp_t timestamp,
 		int tz, const char *msg, void *cb_data);
 
+/* Iterate in over reflog entries in the log for `refname`. */
+
+/* oldest entry first */
 int refs_for_each_reflog_ent(struct ref_store *refs, const char *refname,
 			     each_reflog_ent_fn fn, void *cb_data);
+
+/* youngest entry first */
 int refs_for_each_reflog_ent_reverse(struct ref_store *refs,
 				     const char *refname,
 				     each_reflog_ent_fn fn,
 				     void *cb_data);
+
+/* Call a function for each reflog entry in the log for `refname`. */
+
+/* oldest entry first */
 int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data);
+
+/* youngest entry first */
 int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data);
 
 /*
-- 
gitgitgadget

