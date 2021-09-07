Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C61C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 13:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 431C5610E9
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 13:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344617AbhIGNiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 09:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344229AbhIGNiB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 09:38:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C555C06175F
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 06:36:52 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n5so14483692wro.12
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 06:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JpwBKzKGV5OZrreDmuvwGx82dF6Vy4fzhGZLhC9Pd5Q=;
        b=Lj0bPGeGfm+3DSnPQeX7LCCZblXuDwTaCzAyaViRe7Gxy7lTcZScsbufxoG5cmTJZt
         RJszE5ufC5yBMAEuyhsFLf39rvBfTFa512bnND6E4DpoVGDudZ1OWpVkVZOv210G/yFq
         ZDm55Hu7NElLaTGZ5256OpoP/Wo6tFak6PxRtNhT/zK4gaElWdx1A73uVXfk7J16t2GB
         rB/g7uuaCvwUZtPbVtjjymQ0nzUOfxMqtdYBPTzurX09guTx40KZUeCsA1+wC2u95qu9
         tiHTWIEl5AfipzK0kxBHdbmka0H9RfnkKYxyCxfS80xGoHUDFCbcprThBTciM+B3YVmC
         rG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JpwBKzKGV5OZrreDmuvwGx82dF6Vy4fzhGZLhC9Pd5Q=;
        b=XxcLuuWDZMleJJCsTupZ2hpEgTBMpkMe8wjDGrU8i6VX6S7AefY/xLGHOFkjPH996W
         fXocZxty/wJOm7W0TApC2UcDGXdBa+dtf6lS6JdmHrwmtwv0FoQ6w6UG7h4M/rHGF4qe
         etC02fBT3UIS9EVoGbgLPW7Y4dfoiqwyx2Lqegc/P+7+HlBk+r50pMVzlFfRpBqB/XQY
         s8PXJj3khAuDY2fvAEsyEU5zuPB/wG0BK18+0gkM/pfddh1ZWuE0WAEwPJOLRJXhw+B4
         DF766+QCIRKHjagTmaoNqUPCIaCwO7uoTKFQzRLUU3nbWaavnRRMB+NJX9YywPer5JvI
         jVOA==
X-Gm-Message-State: AOAM532HnaobZC9Jg44X4geQABHznSrgW0jJknlN+J7sgrCrQHB1xDHM
        AsAGO6oqar/H1jf02HVm825pXNs/GXg=
X-Google-Smtp-Source: ABdhPJxs8xA5Ja0mBA2jXOI83iasz+OczNhkX5S1MnSMPwCVXfJnF0gkYJlXtjfbJE3MdYAd3RZBDQ==
X-Received: by 2002:adf:eb4a:: with SMTP id u10mr18890893wrn.11.1631021810741;
        Tue, 07 Sep 2021 06:36:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r27sm1708078wrr.70.2021.09.07.06.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 06:36:50 -0700 (PDT)
Message-Id: <d16d94164c141ded2a918aabf7044e360543fb61.1631021808.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1067.v3.git.git.1631021808.gitgitgadget@gmail.com>
References: <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
        <pull.1067.v3.git.git.1631021808.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Sep 2021 13:36:43 +0000
Subject: [PATCH v3 2/7] refs: trim newline from reflog message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Commit 523fa69c ("reflog: cleanse messages in the refs.c layer") standardizes
how write entries into the reflog. This commit standardizes how we get messages
out of the reflog. Before, the files backend implicitly added '\n' to the end of
reflog message on reading, which creates a subtle incompatibility with alternate
ref storage backends, such as reftable.

We address this by stripping LF from the message before we pass it to the
user-provided callback.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 builtin/show-branch.c          |  5 -----
 reflog-walk.c                  |  6 ++----
 refs/files-backend.c           | 30 +++++++++++++++---------------
 t/t1405-main-ref-store.sh      |  5 ++---
 t/t1406-submodule-ref-store.sh |  4 ++--
 5 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 902a0d99850..58a894e81e2 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -762,7 +762,6 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			char *logmsg;
 			char *nth_desc;
 			const char *msg;
-			char *end;
 			timestamp_t timestamp;
 			int tz;
 
@@ -773,10 +772,6 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				break;
 			}
 
-			end = strchr(logmsg, '\n');
-			if (end)
-				*end = '\0';
-
 			msg = (*logmsg == '\0') ? "(none)" : logmsg;
 			reflog_msg[i] = xstrfmt("(%s) %s",
 						show_date(timestamp, tz,
diff --git a/reflog-walk.c b/reflog-walk.c
index e9cd3283694..944cce929c8 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -245,8 +245,6 @@ void get_reflog_message(struct strbuf *sb,
 
 	info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
 	len = strlen(info->message);
-	if (len > 0)
-		len--; /* strip away trailing newline */
 	strbuf_add(sb, info->message, len);
 }
 
@@ -285,10 +283,10 @@ void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
 		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
 		get_reflog_selector(&selector, reflog_info, dmode, force_date, 0);
 		if (oneline) {
-			printf("%s: %s", selector.buf, info->message);
+			printf("%s: %s\n", selector.buf, info->message);
 		}
 		else {
-			printf("Reflog: %s (%s)\nReflog message: %s",
+			printf("Reflog: %s (%s)\nReflog message: %s\n",
 			       selector.buf, info->email, info->message);
 		}
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 677b7e4cdd2..206c9f8b932 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1897,17 +1897,15 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
 	int tz;
 	const char *p = sb->buf;
 
-	/* old SP new SP name <email> SP time TAB msg LF */
-	if (!sb->len || sb->buf[sb->len - 1] != '\n' ||
-	    parse_oid_hex(p, &ooid, &p) || *p++ != ' ' ||
+	/* old SP new SP name <email> SP time TAB msg */
+	if (!sb->len || parse_oid_hex(p, &ooid, &p) || *p++ != ' ' ||
 	    parse_oid_hex(p, &noid, &p) || *p++ != ' ' ||
-	    !(email_end = strchr(p, '>')) ||
-	    email_end[1] != ' ' ||
+	    !(email_end = strchr(p, '>')) || email_end[1] != ' ' ||
 	    !(timestamp = parse_timestamp(email_end + 2, &message, 10)) ||
 	    !message || message[0] != ' ' ||
-	    (message[1] != '+' && message[1] != '-') ||
-	    !isdigit(message[2]) || !isdigit(message[3]) ||
-	    !isdigit(message[4]) || !isdigit(message[5]))
+	    (message[1] != '+' && message[1] != '-') || !isdigit(message[2]) ||
+	    !isdigit(message[3]) || !isdigit(message[4]) ||
+	    !isdigit(message[5]))
 		return 0; /* corrupt? */
 	email_end[1] = '\0';
 	tz = strtol(message + 1, NULL, 10);
@@ -1999,6 +1997,7 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 				strbuf_splice(&sb, 0, 0, bp + 1, endp - (bp + 1));
 				scanp = bp;
 				endp = bp + 1;
+				strbuf_trim_trailing_newline(&sb);
 				ret = show_one_reflog_ent(&sb, fn, cb_data);
 				strbuf_reset(&sb);
 				if (ret)
@@ -2011,6 +2010,7 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 				 * Process it, and we can end the loop.
 				 */
 				strbuf_splice(&sb, 0, 0, buf, endp - buf);
+				strbuf_trim_trailing_newline(&sb);
 				ret = show_one_reflog_ent(&sb, fn, cb_data);
 				strbuf_reset(&sb);
 				break;
@@ -2060,7 +2060,7 @@ static int files_for_each_reflog_ent(struct ref_store *ref_store,
 	if (!logfp)
 		return -1;
 
-	while (!ret && !strbuf_getwholeline(&sb, logfp, '\n'))
+	while (!ret && !strbuf_getline(&sb, logfp))
 		ret = show_one_reflog_ent(&sb, fn, cb_data);
 	fclose(logfp);
 	strbuf_release(&sb);
@@ -3020,18 +3020,18 @@ static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
 	if ((*cb->should_prune_fn)(ooid, noid, email, timestamp, tz,
 				   message, policy_cb)) {
 		if (!cb->newlog)
-			printf("would prune %s", message);
+			printf("would prune %s\n", message);
 		else if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
-			printf("prune %s", message);
+			printf("prune %s\n", message);
 	} else {
 		if (cb->newlog) {
-			fprintf(cb->newlog, "%s %s %s %"PRItime" %+05d\t%s",
-				oid_to_hex(ooid), oid_to_hex(noid),
-				email, timestamp, tz, message);
+			fprintf(cb->newlog, "%s %s %s %" PRItime " %+05d\t%s\n",
+				oid_to_hex(ooid), oid_to_hex(noid), email,
+				timestamp, tz, message);
 			oidcpy(&cb->last_kept_oid, noid);
 		}
 		if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
-			printf("keep %s", message);
+			printf("keep %s\n", message);
 	}
 	return 0;
 }
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 49718b7ea7f..a600bedf2cd 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -89,13 +89,12 @@ test_expect_success 'for_each_reflog()' '
 test_expect_success 'for_each_reflog_ent()' '
 	$RUN for-each-reflog-ent HEAD >actual &&
 	head -n1 actual | grep one &&
-	tail -n2 actual | head -n1 | grep recreate-main
+	tail -n1 actual | grep recreate-main
 '
 
 test_expect_success 'for_each_reflog_ent_reverse()' '
 	$RUN for-each-reflog-ent-reverse HEAD >actual &&
-	head -n1 actual | grep recreate-main &&
-	tail -n2 actual | head -n1 | grep one
+	tail -n1 actual | grep one
 '
 
 test_expect_success 'reflog_exists(HEAD)' '
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index 0a87058971e..b0365c1fee0 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -74,13 +74,13 @@ test_expect_success 'for_each_reflog()' '
 test_expect_success 'for_each_reflog_ent()' '
 	$RUN for-each-reflog-ent HEAD >actual &&
 	head -n1 actual | grep first &&
-	tail -n2 actual | head -n1 | grep main.to.new
+	tail -n1 actual | grep main.to.new
 '
 
 test_expect_success 'for_each_reflog_ent_reverse()' '
 	$RUN for-each-reflog-ent-reverse HEAD >actual &&
 	head -n1 actual | grep main.to.new &&
-	tail -n2 actual | head -n1 | grep first
+	tail -n1 actual | grep first
 '
 
 test_expect_success 'reflog_exists(HEAD)' '
-- 
gitgitgadget

