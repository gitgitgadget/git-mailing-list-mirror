Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D13C433E5
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 17:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACC0520674
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 17:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mny7Mamo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgGJRUE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgGJRUA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 13:20:00 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF47C08C5DC
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 10:20:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k6so6743001wrn.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 10:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PYQW+oFvkdWbjU/0TRphBU7fadGwnzUgBlThaX0EQfE=;
        b=Mny7MamoYL398Q2FclklmxNB07wzWXpAa022xLhOoM9UYTNJMzaZ0QtvwUpsBM08sS
         r5HZy9zMRxo5TowOup+my1+l0+neaG7CAnHGzWwKnyWiwwnueClSkm7KuN4Z8RXaCZgu
         ICrxzQcYiw45H8wiPA0tjuCK7fMyXSImS0n3qXvRcqx3VgSquHGVzE8L3PpYszK/wcCc
         amTqXe78QnDhO3P3Q4MOciVPwWQXZlii5ibcdypdYjP9HV2pd2dTnClWt9KJs7ga8nEa
         XfMOJ34H/P2pyWXB9wlj/PQhxLpsQYxvj15YYGGgIonKfSHb7Iix3iAUFwJDibcuWehI
         Zy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PYQW+oFvkdWbjU/0TRphBU7fadGwnzUgBlThaX0EQfE=;
        b=KA6niLMo1aZEGxNOJiP03fhEl0RXtyrPG0aRbmH1fGFoiaP2xtQVykmHPFQRAXfDc8
         sDclCHwB2J587JIqxc8Yb/wQbGTEeMI4qGmoNc8zilcNXdE8Vc8ncxWJvDOph3zrR+lb
         efhdI3UGEewvYAD6AzEzDBcWz2pYpoGYO4NsmIOpPCcSbqeOajEyxM+snk+0FdVvrlNb
         xzJIYbrSo3a5BoBvYBCw6rqL8ekiFWweI6RHXDs50jkALrQuUyA2ZBdb1c+uWx6NtZWn
         kLCe+UF2W9QI2oXrLil35XLqzgEQTXm5ZRGYjF7xJaZHcszKUIUAa4yJNDmEpCchbgxR
         sBcg==
X-Gm-Message-State: AOAM533IE9g8R/0kCvR9bgGrsYio95/V9UvqSAJVG3Mx7FdTpb2j852W
        PEBFBxE7rkhWj8sYDmay54jUSe7w
X-Google-Smtp-Source: ABdhPJy1E22Vu7sl0T/ZymKoZklAVrFzq3xsWTC3KYRZz1j3YVJTONzDZLNb0/VYTSsXqA9FpidR+Q==
X-Received: by 2002:a05:6000:46:: with SMTP id k6mr39681344wrx.102.1594401598442;
        Fri, 10 Jul 2020 10:19:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v7sm10941833wrp.45.2020.07.10.10.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 10:19:57 -0700 (PDT)
Message-Id: <6ca5b99c8d7af1a3f35b3a7d25db284c879a2f10.1594401593.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.669.v2.git.1594401593.gitgitgadget@gmail.com>
References: <pull.669.git.1593518738.gitgitgadget@gmail.com>
        <pull.669.v2.git.1594401593.gitgitgadget@gmail.com>
From:   "Junio C Hamano via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Jul 2020 17:19:53 +0000
Subject: [PATCH v2 4/4] Cleanse reflog messages in the refs.c layer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Regarding reflog messages:

 - We expect that a reflog message consists of a single line.  The
   file format used by the files backend may add a LF after the
   message as a delimiter, and output by commands like "git log -g"
   may complete such an incomplete line by adding a LF at the end,
   but philosophically, the terminating LF is not a part of the
   message.

 - We however allow callers of refs API to supply a random sequence
   of NUL terminated bytes.  We cleanse caller-supplied message by
   squashing a run of whitespaces into a SP, and by trimming trailing
   whitespace, before storing the message.  This is how we tolerate,
   instead of erring out, a message with LF in it (be it at the end,
   in the middle, or both).

Currently, the cleansing of the reflog message is done by the files
backend, before the log is written out.  This is sufficient with the
current code, as that is the only backend that writes reflogs.  But
new backends can be added that write reflogs, and we'd want the
resulting log message we would read out of "log -g" the same no
matter what backend is used.

An added benefit is that the "cleansing" function could be updated
later, independent from individual backends, to e.g. allow
multi-line log messages if we wanted to, and when that happens, it
would help a lot to ensure we covered all bases if the cleansing
function (which would be updated) is called from the generic layer.

Side note: I am not interested in supporting multi-line
reflog messages right at the moment (nobody is asking for
it), but I envision that instead of the "squash a run of
whitespaces into a SP and rtrim" cleansing, we can
%urlencode problematic bytes in the message *AND* append a
SP at the end, when a new version of Git that supports
multi-line and/or verbatim reflog messages writes a reflog
record.  The reading side can detect the presense of SP at
the end (which should have been rtrimmed out if it were
written by existing versions of Git) as a signal that
decoding %urlencode recovers the original reflog message.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c               | 50 ++++++++++++++++++++++++++++++++++++--------
 refs/files-backend.c |  2 +-
 refs/refs-internal.h |  6 ------
 3 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 639cba93b4..89814c7be4 100644
--- a/refs.c
+++ b/refs.c
@@ -902,7 +902,7 @@ int delete_ref(const char *msg, const char *refname,
 			       old_oid, flags);
 }
 
-void copy_reflog_msg(struct strbuf *sb, const char *msg)
+static void copy_reflog_msg(struct strbuf *sb, const char *msg)
 {
 	char c;
 	int wasspace = 1;
@@ -919,6 +919,15 @@ void copy_reflog_msg(struct strbuf *sb, const char *msg)
 	strbuf_rtrim(sb);
 }
 
+static char *normalize_reflog_message(const char *msg)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	if (msg && *msg)
+		copy_reflog_msg(&sb, msg);
+	return strbuf_detach(&sb, NULL);
+}
+
 int should_autocreate_reflog(const char *refname)
 {
 	switch (log_all_ref_updates) {
@@ -1124,7 +1133,7 @@ struct ref_update *ref_transaction_add_update(
 		oidcpy(&update->new_oid, new_oid);
 	if (flags & REF_HAVE_OLD)
 		oidcpy(&update->old_oid, old_oid);
-	update->msg = xstrdup_or_null(msg);
+	update->msg = normalize_reflog_message(msg);
 	return update;
 }
 
@@ -1983,9 +1992,14 @@ int refs_create_symref(struct ref_store *refs,
 		       const char *refs_heads_master,
 		       const char *logmsg)
 {
-	return refs->be->create_symref(refs, ref_target,
-				       refs_heads_master,
-				       logmsg);
+	char *msg;
+	int retval;
+
+	msg = normalize_reflog_message(logmsg);
+	retval = refs->be->create_symref(refs, ref_target, refs_heads_master,
+					 msg);
+	free(msg);
+	return retval;
 }
 
 int create_symref(const char *ref_target, const char *refs_heads_master,
@@ -2370,10 +2384,16 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 	return refs->be->initial_transaction_commit(refs, transaction, err);
 }
 
-int refs_delete_refs(struct ref_store *refs, const char *msg,
+int refs_delete_refs(struct ref_store *refs, const char *logmsg,
 		     struct string_list *refnames, unsigned int flags)
 {
-	return refs->be->delete_refs(refs, msg, refnames, flags);
+	char *msg;
+	int retval;
+
+	msg = normalize_reflog_message(logmsg);
+	retval = refs->be->delete_refs(refs, msg, refnames, flags);
+	free(msg);
+	return retval;
 }
 
 int delete_refs(const char *msg, struct string_list *refnames,
@@ -2385,7 +2405,13 @@ int delete_refs(const char *msg, struct string_list *refnames,
 int refs_rename_ref(struct ref_store *refs, const char *oldref,
 		    const char *newref, const char *logmsg)
 {
-	return refs->be->rename_ref(refs, oldref, newref, logmsg);
+	char *msg;
+	int retval;
+
+	msg = normalize_reflog_message(logmsg);
+	retval = refs->be->rename_ref(refs, oldref, newref, msg);
+	free(msg);
+	return retval;
 }
 
 int rename_ref(const char *oldref, const char *newref, const char *logmsg)
@@ -2396,7 +2422,13 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
 		    const char *newref, const char *logmsg)
 {
-	return refs->be->copy_ref(refs, oldref, newref, logmsg);
+	char *msg;
+	int retval;
+
+	msg = normalize_reflog_message(logmsg);
+	retval = refs->be->copy_ref(refs, oldref, newref, msg);
+	free(msg);
+	return retval;
 }
 
 int copy_existing_ref(const char *oldref, const char *newref, const char *logmsg)
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6516c7bc8c..e0aba23eb2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1629,7 +1629,7 @@ static int log_ref_write_fd(int fd, const struct object_id *old_oid,
 
 	strbuf_addf(&sb, "%s %s %s", oid_to_hex(old_oid), oid_to_hex(new_oid), committer);
 	if (msg && *msg)
-		copy_reflog_msg(&sb, msg);
+		strbuf_addstr(&sb, msg);
 	strbuf_addch(&sb, '\n');
 	if (write_in_full(fd, sb.buf, sb.len) < 0)
 		ret = -1;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 4271362d26..357359a0be 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -96,12 +96,6 @@ enum peel_status {
  */
 enum peel_status peel_object(const struct object_id *name, struct object_id *oid);
 
-/*
- * Copy the reflog message msg to sb while cleaning up the whitespaces.
- * Especially, convert LF to space, because reflog file is one line per entry.
- */
-void copy_reflog_msg(struct strbuf *sb, const char *msg);
-
 /**
  * Information needed for a single ref update. Set new_oid to the new
  * value or to null_oid to delete the ref. To check the old value
-- 
gitgitgadget
