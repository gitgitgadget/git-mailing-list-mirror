Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B44C433DB
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 00:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3968F64EC8
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 00:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhBVAl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Feb 2021 19:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhBVAl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Feb 2021 19:41:59 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB96BC061574
        for <git@vger.kernel.org>; Sun, 21 Feb 2021 16:41:18 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id s23so4610003pji.1
        for <git@vger.kernel.org>; Sun, 21 Feb 2021 16:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S1ezQXGbOQJyUWqTs+TxZjO4nyUTTP3H5NmooLYv3U0=;
        b=uKsdU9P7xFLJwSPU0U/3UJNrPLba9SE9/oTsbGaCwbsHbHo3gZJ4MvfAb02cvdodZL
         KWW8kAHYJ5YUiRwfg/ep8W0+fZgbKirnM95AEF4TlFJrWp5uRMeW7td2+sE7zAStQ10o
         Pwdx3gWtmHoZAqnq3aSpohrHcoDwI5oJxwLMS4A4n0qwca8U0GX8SdsNGS64EiwB3T9L
         Hn1c5ueEzmCdcrdmUdlTMjG9ceOX8qHKC34Fkr7jgAyrbUIvzdjfYdFqYhUbhcWSmVEa
         qZNkJuUeyH8hyAcJ9RF1yftKySJ2N/MyuXeyhHbRPePu7zcZPeCbl9YlKMd47yDJ8TZz
         m8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S1ezQXGbOQJyUWqTs+TxZjO4nyUTTP3H5NmooLYv3U0=;
        b=Al3BOISVtsDZbcT8MUYetnk1cdSWCYf/VfKjGRRnEZc+Jkm3H79M7vuh0MVgc61rph
         PsYmApPajPQOTxUu+IOt4hwOpEyKpf2eSXody9RS/whXPJmEyeAI13T/qgHHEjtxE8+z
         6+exnA9FrTKUaac6kp9+t2iD1vJU3WZPJZajElSl8TsOQOGBvexfoifOs498xWrp3fFv
         G6Wc6gr8q6+giF2J1NiVeFvQgKrnuFB0PN5PMRdGfGrBLqFjqQ/jFetAULyDy1HpXfai
         RL/IBr5rdtNeSvJIuDzmXUXmBIm7D0SS0KuPoVZvJZneGNM7pO4X8TDA2aYuUz1womUg
         OVpw==
X-Gm-Message-State: AOAM5331njYABTPO0k38l7mUz7tuJ58uxp4Jc4RcuSj1TeWPqyvlBkCf
        qXsNpd59pLQ0+O/C/9Ke5tBCObJfXLEKQA==
X-Google-Smtp-Source: ABdhPJyOBCS7hl2sCDiqiL7Ti3XEB4lGyTBqBVpKb5DYMgzBFB5zNbojjNaQ2ir/00sVmAXb2qzQgg==
X-Received: by 2002:a17:90a:7b88:: with SMTP id z8mr14908998pjc.19.1613954477624;
        Sun, 21 Feb 2021 16:41:17 -0800 (PST)
Received: from localhost ([76.126.59.206])
        by smtp.gmail.com with ESMTPSA id y1sm9999416pjr.3.2021.02.21.16.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 16:41:17 -0800 (PST)
From:   Stefan Beller <stefanbeller@gmail.com>
To:     gitgitgadget@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com,
        emilyshaffer@google.com, felipe.contreras@gmail.com,
        git@vger.kernel.org, hanwen@google.com, hanwenn@gmail.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        ps@pks.im, ramsay@ramsayjones.plus.com, steadmon@google.com,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH] refs: introduce API function to write invalid null ref
Date:   Sun, 21 Feb 2021 16:41:12 -0800
Message-Id: <20210222004112.99268-1-stefanbeller@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c109303
In-Reply-To: <d57023d9f13d178dc95d7a74751923b80d1a5939.1607522429.git.gitgitgadget@gmail.com>
References: <d57023d9f13d178dc95d7a74751923b80d1a5939.1607522429.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Different ref backends will have different ways to write out the invalid 00..00
ref when starting a new worktree. Encapsulate this into a function and expose
the function in the refs API.

Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
---

Hi Han-Wen,

it's been a while since I looked at git source code, but today is the day!
I was actually looking how the refs table work progresses and this patch
caught my attention.  I think the changes in builtin/worktree.c (that 
if/else depending on the actual refs backend used)
demonstrate that the refs API layer is leaking implementation details.

What do you think about rolling this patch first, and then implementing
the following part inside the reftable as a function?


int reftable_write_invalid_head_ref(struct *ref_store, const char *dir)
{
	struct sb  = STRBUF_INIT;
	/* the following adapted from this patch: */

+		/* XXX this is cut & paste from reftable_init_db. */
+		strbuf_addf(&sb, "%s/HEAD", dir);
+		write_file(sb.buf, "%s", "ref: refs/heads/.invalid\n");
+		strbuf_reset(&sb);
+
+		strbuf_addf(&sb, "%s/refs", sb_repo.buf);
+		safe_create_dir(sb.buf, 1);
+		strbuf_reset(&sb);
+
+		strbuf_addf(&sb, "%s/refs/heads", sb_repo.buf);
+		write_file(sb.buf, "this repository uses the reftable format");
+		strbuf_reset(&sb);
+
+		strbuf_addf(&sb, "%s/reftable", sb_repo.buf);
+		safe_create_dir(sb.buf, 1);
+		strbuf_reset(&sb);

	return 0;
}

What do you think?

Cheers,
Stefan


 builtin/worktree.c    |  6 +++---
 refs.c                |  5 +++++
 refs.h                |  3 +++
 refs/debug.c          | 10 ++++++++++
 refs/files-backend.c  | 13 +++++++++++++
 refs/packed-backend.c |  7 +++++++
 refs/refs-internal.h  |  3 +++
 7 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 1cd5c2016e..6f5d79e5ec 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -330,9 +330,9 @@ static int add_worktree(const char *path, const char *refname,
 	 * worktree.
 	 */
 	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
-	write_file(sb.buf, "%s", oid_to_hex(&null_oid));
-	strbuf_reset(&sb);
+
+	write_invalid_head(get_main_ref_store(the_repository), sb_repo.buf);
+
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
 
diff --git a/refs.c b/refs.c
index a665ed5e10..a7b415c386 100644
--- a/refs.c
+++ b/refs.c
@@ -2454,3 +2454,8 @@ int copy_existing_ref(const char *oldref, const char *newref, const char *logmsg
 {
 	return refs_copy_existing_ref(get_main_ref_store(the_repository), oldref, newref, logmsg);
 }
+
+int write_invalid_head(struct ref_store *refs, const char *dir)
+{
+	return refs->be->write_invalid_head_ref(refs, dir);
+}
diff --git a/refs.h b/refs.h
index 48970dfc7e..7a64f777d5 100644
--- a/refs.h
+++ b/refs.h
@@ -456,6 +456,9 @@ int refs_delete_refs(struct ref_store *refs, const char *msg,
 int delete_refs(const char *msg, struct string_list *refnames,
 		unsigned int flags);
 
+
+int write_invalid_head(struct ref_store *refs, const char *dir);
+
 /** Delete a reflog */
 int refs_delete_reflog(struct ref_store *refs, const char *refname);
 int delete_reflog(const char *refname);
diff --git a/refs/debug.c b/refs/debug.c
index 922e64fa6a..9cfc3ca9f3 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -175,6 +175,15 @@ static int debug_copy_ref(struct ref_store *ref_store, const char *oldref,
 	return res;
 }
 
+static int debug_write_invalid_head_ref(struct ref_store *ref_store,
+					const char *dir)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->write_invalid_head_ref(drefs->refs, dir);
+	trace_printf_key(&trace_refs, "write_invalid_head: %s\n", dir);
+	return res;
+}
+
 struct debug_ref_iterator {
 	struct ref_iterator base;
 	struct ref_iterator *iter;
@@ -384,6 +393,7 @@ struct ref_storage_be refs_be_debug = {
 	debug_delete_refs,
 	debug_rename_ref,
 	debug_copy_ref,
+	debug_write_invalid_head_ref,
 
 	debug_ref_iterator_begin,
 	debug_read_raw_ref,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4fdc68810b..b1c82a6f61 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3169,6 +3169,18 @@ static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 	return 0;
 }
 
+static int files_write_invalid_head_ref(struct ref_store *ref_store,
+					const char *dir)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	strbuf_addf(&sb, "%s/HEAD", dir);
+	write_file(sb.buf, "%s", oid_to_hex(&null_oid));
+	strbuf_release(&sb);
+
+	return 0;
+}
+
 struct ref_storage_be refs_be_files = {
 	NULL,
 	"files",
@@ -3184,6 +3196,7 @@ struct ref_storage_be refs_be_files = {
 	files_delete_refs,
 	files_rename_ref,
 	files_copy_ref,
+	files_write_invalid_head_ref,
 
 	files_ref_iterator_begin,
 	files_read_raw_ref,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index b912f2505f..a1adb81777 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1591,6 +1591,12 @@ static int packed_copy_ref(struct ref_store *ref_store,
 	BUG("packed reference store does not support copying references");
 }
 
+static int packed_write_invalid_head_ref(struct ref_store *ref_store,
+					 const char *dir)
+{
+	BUG("packed reference store does not support writing an invalid head ref");
+}
+
 static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_store)
 {
 	return empty_ref_iterator_begin();
@@ -1656,6 +1662,7 @@ struct ref_storage_be refs_be_packed = {
 	packed_delete_refs,
 	packed_rename_ref,
 	packed_copy_ref,
+	packed_write_invalid_head_ref,
 
 	packed_ref_iterator_begin,
 	packed_read_raw_ref,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 467f4b3c93..5055226f75 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -556,6 +556,8 @@ typedef int rename_ref_fn(struct ref_store *ref_store,
 typedef int copy_ref_fn(struct ref_store *ref_store,
 			  const char *oldref, const char *newref,
 			  const char *logmsg);
+typedef int write_invalid_head_ref_fn(struct ref_store *ref_store,
+				      const char *dir);
 
 /*
  * Iterate over the references in `ref_store` whose names start with
@@ -655,6 +657,7 @@ struct ref_storage_be {
 	delete_refs_fn *delete_refs;
 	rename_ref_fn *rename_ref;
 	copy_ref_fn *copy_ref;
+	write_invalid_head_ref_fn *write_invalid_head_ref;
 
 	ref_iterator_begin_fn *iterator_begin;
 	read_raw_ref_fn *read_raw_ref;
-- 
2.26.2.266.ge870325ee8

