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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA149C433FE
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 16:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1C5261051
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 16:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238567AbhIFQxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 12:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbhIFQxb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 12:53:31 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D33C061757
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 09:52:26 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b6so10693466wrh.10
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 09:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M8cMkenOYpSJIzJ7GJmSZTU5BOuiS7mxgTz003EpiVg=;
        b=D6geH1bMqFxPWcgakemthqUj61nG/0Th+wd58auxXS+tFnwZQNrRTkY4C/lvu70S1h
         ESme2jpa3djAHILp9hqlcdaGQwXaX2soTrRokce/LS8qgmb9uj5SYVJswQ6scet6PvFr
         s3Rex0IZ2Z7o62yui8SsE+cJ+zMxe87nU35Pm+O+NOuQC0WcItw9K16R0pHD86bCXvDM
         GckSxSI5P9kHoPTU0YQhC4rc5luytEnZNkVFkIYOaPpfmhovsqvS0WOygEanQurRdJRD
         IIvBYHkXbGMzIFu/mNk1bo7gmC55f3SZTSNGZ+STrfh1OeKVq8S/O9ddLdAxNbHYHggf
         twOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M8cMkenOYpSJIzJ7GJmSZTU5BOuiS7mxgTz003EpiVg=;
        b=gUK/yxWqZj4Hpq/NoM/euVTemcKTr436I3j/HeRKDEUBJssuNK9/yR5Cva2bwX4Q//
         ZbLwNTsxc2ETWzXMHJqy9mH9KTeKervJh6FJC7mLadhwA4a9F+6rbRLPgo5Gf+dgpYzZ
         /8BerQjplWYWzTrAsg30/A6QkAPtVp8++eqjqXcFnemAw07dkpYj/TkhIDLLj2wyqC5s
         ThiQupVhOlLFUrC4U6OmK+JoD3MOp593dJ7i2zMi8aaYPZ8lCzodD6LOK0leuysatHd1
         Zr9/EJFSzQm9mqq2ZigJe2MZLR+NlMMDku0S8WXVmbwu6ha/c1IhIDLLIuwDPva3kzhI
         Nf+w==
X-Gm-Message-State: AOAM531gI+XBq+jusjEkxXN2VLC6c6N4Qg73MLwwbuG+XZCRcTAddwxD
        xo2YmPTmfVpcPHoty2KW2W7gsMAnSZ8=
X-Google-Smtp-Source: ABdhPJz7rxQ+pIfKDZLgoTeMLt4NR1WAVxHiV6+x33LuuaKbQfRzxmU/PryP5czN0DtPWfEQo7nqcA==
X-Received: by 2002:adf:d193:: with SMTP id v19mr14493525wrc.377.1630947144925;
        Mon, 06 Sep 2021 09:52:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17sm9793378wrt.63.2021.09.06.09.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 09:52:24 -0700 (PDT)
Message-Id: <995d450da42f35b4cecdd699fa1b1a74518f481e.1630947142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
        <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Sep 2021 16:52:18 +0000
Subject: [PATCH v2 1/5] refs: trim newline from reflog message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
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
 builtin/show-branch.c          |  4 +++-
 reflog-walk.c                  |  6 ++----
 refs/files-backend.c           | 30 +++++++++++++++---------------
 t/t1405-main-ref-store.sh      |  5 ++---
 t/t1406-submodule-ref-store.sh |  4 ++--
 5 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index d77ce7aeb38..acf710313a0 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -888,7 +888,9 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				show_one_commit(rev[i], 1);
 			}
 			else
-				puts(reflog_msg[i]);
+				puts(reflog_msg[i]); /* XXX - this puts a
+							newline. Did we put two
+							newlines beforehand? */
 
 			if (is_head)
 				head_at = i;
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

