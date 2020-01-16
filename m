Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CA3C32771
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 03:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A2F214AF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 03:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b9ctsO1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbgAPDBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 22:01:24 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:40018 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbgAPDBX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 22:01:23 -0500
Received: by mail-pl1-f202.google.com with SMTP id o12so7990108pll.7
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 19:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=d+qeiYkX8zmURRZGvTqx9IZtUay7UL3xLabz0hUqv9g=;
        b=b9ctsO1V+TdxRw2zl+X9+3PzzYCVJQJlE/yeWcZ4d0eCJsmAeNoiSwsf2jLRLNR1Ta
         JW+avlYbhaJaEXVxGT3QfsXXix4wteR2CDuqUmuaZttJ3i+eL1iN62IQner99om1hd8M
         mRxnJ8xA9VmtVqUgTvGJfZCqxExU5f/Iv2E4irECdwi3wMwXKJ6z8Em468PVELw04L59
         AYuu+SU+xC7DmGJPAMbriSCtoFEru6QnuWz6ItKI3MtjcgkCD6U2i6P+vTF4S4hjjhmV
         UZlp8qjLkqco24VkPeg9pf3whIAncP4G4h1Ws2KtgplybXeFw5L1nTZlCnlNRcXta6nM
         htgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=d+qeiYkX8zmURRZGvTqx9IZtUay7UL3xLabz0hUqv9g=;
        b=LtpL5wEYNNxdozDtrs3gFmWZ/+LWSF28aZRjr5NzDQIDHXsKIYeGFsm+x2lBFZuOXk
         U4HyyFZbxky905rvNSkYc0BrQsDJhb+FfcNUfXpmW/WPfKsKc5Ma7TmUet8CdcZnUH7T
         Ye6hBvFGuVpnJBXpRG5BlBeoqGihp/EZoyCNc936oQw949i0sl/uzMKxwh1/HISalUTj
         2uV5CMKreDx5st8uPMhvQAUnhyEz296l3RUwcPdZRXhK+6KtHs1PSMZhp2IhO1czZ6Ec
         aebFlawhkxwvNfx3Nyhi+Ct+bYf27Se1784L39Dxmg9E2T2knZxARRoyJ1heoFOe/1fm
         06dQ==
X-Gm-Message-State: APjAAAX8r1dgSm2Ke98IVf9q2epUXIoqN3xTMgqMcIhO6pMOpFruhQwi
        cDE5Hccmn5LkJP0elo0wQtJJKlCMRPEjwlAx9+YEnh8xmch7goVQoz/BbzqKrve1iBQbUjVuFr4
        nCmb/YxLI2BBSJVyHcNYZbsiAbRKjL8fTb/tPuNsmS3OXZCrdt3onVjkATwXlb1PPfS0Qrckdvw
        ==
X-Google-Smtp-Source: APXvYqxMf5sJ2SZQ5TJ4Vau0gYBWk36WDJcQi7yBGJvZ8HWcoBGygD66HZnUV3E6mzchHgyyk3HvasI1ieBkLLYoq4M=
X-Received: by 2002:a65:68ca:: with SMTP id k10mr37503846pgt.222.1579143682672;
 Wed, 15 Jan 2020 19:01:22 -0800 (PST)
Date:   Wed, 15 Jan 2020 18:59:48 -0800
In-Reply-To: <20200110195533.6416-1-emilyshaffer@google.com>
Message-Id: <20200116025948.136479-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH v2] fetch: emphasize failure during submodule fetch
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

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
V1's approach was to show a generic error based on the output status of
fetch_populated_submodules(); with a long set of submodules, this is
only marginally better than showing the error inline. For v2, instead
we're gathering a list of submodules which failed during the parallel
processing.

The contents of stderr at the time fetch_finish() is called is not
available to us; 'err' on the input is for providing output only. So,
gather the submodule name only.

 - Emily

 submodule.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/submodule.c b/submodule.c
index 9da7181321..13bc9354bc 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1280,10 +1280,13 @@ struct submodule_parallel_fetch {
 	/* Pending fetches by OIDs */
 	struct fetch_task **oid_fetch_tasks;
 	int oid_fetch_tasks_nr, oid_fetch_tasks_alloc;
+
+	struct strbuf submodules_with_errors;
+	pthread_mutex_t submodule_errors_mutex;
 };
 #define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, \
 		  STRING_LIST_INIT_DUP, \
-		  NULL, 0, 0}
+		  NULL, 0, 0, STRBUF_INIT, PTHREAD_MUTEX_INITIALIZER}
 
 static int get_fetch_recurse_config(const struct submodule *submodule,
 				    struct submodule_parallel_fetch *spf)
@@ -1547,7 +1550,10 @@ static int fetch_finish(int retvalue, struct strbuf *err,
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
@@ -1557,8 +1563,11 @@ static int fetch_finish(int retvalue, struct strbuf *err,
 		 */
 		spf->result = 1;
 
-	if (!task || !task->sub)
-		BUG("callback cookie bogus");
+		pthread_mutex_lock(&spf->submodule_errors_mutex);
+		strbuf_addf(&spf->submodules_with_errors, "\t%s\n",
+			    task->sub->name);
+		pthread_mutex_unlock(&spf->submodule_errors_mutex);
+	}
 
 	/* Is this the second time we process this submodule? */
 	if (task->commits)
@@ -1627,6 +1636,11 @@ int fetch_populated_submodules(struct repository *r,
 				   &spf,
 				   "submodule", "parallel/fetch");
 
+	if (spf.submodules_with_errors.len > 0)
+		fprintf(stderr, "Errors during submodule fetch:\n%s",
+			spf.submodules_with_errors.buf);
+
+
 	argv_array_clear(&spf.args);
 out:
 	free_submodules_oids(&spf.changed_submodule_names);
-- 
2.25.0.rc1.283.g88dfdc4193-goog

