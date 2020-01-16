Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E2BC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 22:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25BA2073A
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 22:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lnCXb4tk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbgAPWUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 17:20:17 -0500
Received: from mail-ua1-f74.google.com ([209.85.222.74]:42957 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730287AbgAPWUR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 17:20:17 -0500
Received: by mail-ua1-f74.google.com with SMTP id x9so3591944uaq.9
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 14:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=zb9ZBa09cJYICm330pSK5bjX/Alwldsd7/VLEPkezxE=;
        b=lnCXb4tk9/7haNCwCex8zZeXs24d8fRMuWtDQLeWxFIy0T7xGuVzZSsU1c8Rr2Lfz8
         VJc/PMJHroDnJt+FnYov4e30fQWOQVbQWnMUgHxlc8Fjl5knj9TO1DMEIM1z02CozOLo
         6FhcXRJdSkmua0Qh2Y3y+DqaW9iBoHw1IOVu0XV0NBZXOejGsmi4AlrB7Rk36TpQSNLi
         fKkVZDevghSGRQmS2xTRIEXdy8kYrFGcmdAI/SHzvG7lVubanm00bKuWybf1GBKEsmIn
         O5jFLK+1+35eF7RG6AmZxKvXvUAJ+SWOLK/7zFP65sDcu4G7Npb44cXDCwPws3jNz28n
         7DNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=zb9ZBa09cJYICm330pSK5bjX/Alwldsd7/VLEPkezxE=;
        b=YWFwlDsZWEEK6oz9iAyTEUiCIdLgKJoyzxwkWMBa6nnbpnZtsdGItW48oPMmO6fbs6
         fM1+swTdku+VpGXJUzQdE+sdnQqUG3ky+rWrm8HvOjdWhtNTsMQcjL4lN92jKjMUPuLl
         p/sh5jpWPAl9cxIPyjjQLUzwjOnT3Qg1+0zgopesGswvUh9gY/CoOiK9Bj3WlZKaLWML
         OyZ+9FTj95B448V8b3URb/2YBWqjPkvgL+nDUTXrtt6DaykSJJEkMqXzShr0g+WDkj1B
         0PcdCHxyUQrhq/Msfe1qZQBXaoWLiLnPsnBd3MYin9N8GCbYPQhQ5UFRjNASHzZVa7yE
         7eHw==
X-Gm-Message-State: APjAAAXpCMzm6VeNUZdUWf/IrPiSNfUCu7nEg11bPQ2TyQyH78Af7JIL
        sxGi9oWeMs/mXeC4GUyUatdFF6jgkQvMc/MMaa879SMPFUif8Tg1/0MbXwcXFfiBPJ+aLHNUoMe
        pOydO9ShNgh3uRPUujdzlAGbBHuX4RBGntR053aAciTPMmDVeQH3dTPWMS9xlxr08VUZ9bJx08A
        ==
X-Google-Smtp-Source: APXvYqx+eFv8r9zDFwY/K4HBC+FYEl/Cs9Ah73T+OLRxq/n/WLrx9ojyqAkzp2EwdunqXuyiOjsWPu1yjUD15wrrIQ4=
X-Received: by 2002:a1f:1b07:: with SMTP id b7mr19576694vkb.79.1579213216324;
 Thu, 16 Jan 2020 14:20:16 -0800 (PST)
Date:   Thu, 16 Jan 2020 14:20:12 -0800
In-Reply-To: <20200116025948.136479-1-emilyshaffer@google.com>
Message-Id: <20200116222012.162642-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH v3] fetch: emphasize failure during submodule fetch
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In cases when a submodule fetch fails when there are many submodules, the error
from the lone failing submodule fetch is buried under activity on the other
submodules if more than one fetch fell back on fetch-by-oid. Call out a failure
late so the user is aware that something went wrong, and where.

Because fetch_finish() is only called synchronously by
run_processes_parallel, mutexing is not required around
submodules_with_errors.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
Since v2, removed mutexing as run_processes_parallel() creates
subprocesses, not threads, and is in fact synchronous. Also added
translation marker for the error message.

 - Emily

 submodule.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/submodule.c b/submodule.c
index 9da7181321..ee74acee27 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1280,10 +1280,12 @@ struct submodule_parallel_fetch {
 	/* Pending fetches by OIDs */
 	struct fetch_task **oid_fetch_tasks;
 	int oid_fetch_tasks_nr, oid_fetch_tasks_alloc;
+
+	struct strbuf submodules_with_errors;
 };
 #define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, \
 		  STRING_LIST_INIT_DUP, \
-		  NULL, 0, 0}
+		  NULL, 0, 0, STRBUF_INIT}
 
 static int get_fetch_recurse_config(const struct submodule *submodule,
 				    struct submodule_parallel_fetch *spf)
@@ -1547,7 +1549,10 @@ static int fetch_finish(int retvalue, struct strbuf *err,
 	struct string_list_item *it;
 	struct oid_array *commits;
 
-	if (retvalue)
+	if (!task || !task->sub)
+		BUG("callback cookie bogus");
+
+	if (retvalue) {
 		/*
 		 * NEEDSWORK: This indicates that the overall fetch
 		 * failed, even though there may be a subsequent fetch
@@ -1557,8 +1562,9 @@ static int fetch_finish(int retvalue, struct strbuf *err,
 		 */
 		spf->result = 1;
 
-	if (!task || !task->sub)
-		BUG("callback cookie bogus");
+		strbuf_addf(&spf->submodules_with_errors, "\t%s\n",
+			    task->sub->name);
+	}
 
 	/* Is this the second time we process this submodule? */
 	if (task->commits)
@@ -1627,6 +1633,11 @@ int fetch_populated_submodules(struct repository *r,
 				   &spf,
 				   "submodule", "parallel/fetch");
 
+	if (spf.submodules_with_errors.len > 0)
+		fprintf(stderr, _("Errors during submodule fetch:\n%s"),
+			spf.submodules_with_errors.buf);
+
+
 	argv_array_clear(&spf.args);
 out:
 	free_submodules_oids(&spf.changed_submodule_names);
-- 
2.25.0.rc1.283.g88dfdc4193-goog

