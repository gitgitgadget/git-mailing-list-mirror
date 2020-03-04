Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF00C3F2D7
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E18221739
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="Py2+SQpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgCDLsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:48:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36087 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729273AbgCDLsR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 06:48:17 -0500
Received: by mail-pl1-f194.google.com with SMTP id g12so927032plo.3
        for <git@vger.kernel.org>; Wed, 04 Mar 2020 03:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ggv6RA6y4X2xk0aYRb732BGjz00X86c/UVhRt5BbVDk=;
        b=Py2+SQpTaqRMOY9ssXJGTQYKeQae5nc02CI5dY1TRqN17KjFCdd1ZoO9fLVYOfQo8I
         uLwW/Q6Uf9xuKxLzSTPFDpe/Ih4EC/5sUkxs3kuNEVRDULqUNNe65nLk+24uxzg7mjpG
         0U9b0CmHY6y763aPx47TSTqEixrZwc24RavYrPzzq657SL/p2eqLPK6tgw2a8LHMWE7i
         V/MpuiCK3g00Lw8q6sf4ywrhIGKX84ejmsgiq8KZ4AYYTbm1EBkjE2+tJyWNaAsbkjP6
         JJSvkonv57EtFSvLK5+9qZhWdRh4tMEWzGnW+41K4qzvM1fvNl+ysEqPDjdtBJSTqyqX
         GecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ggv6RA6y4X2xk0aYRb732BGjz00X86c/UVhRt5BbVDk=;
        b=FkatF5aWkBD83VVf0UeZxTzuu1yv8JT3GrD+gofREL/8pg8/MuJnm8ZJ238sJ8VTb1
         ns0S/Yy28Ayk4WsrI5Uh7F2WB5EtYTg5fKFmP6rplrljVGEy+SEnQXrsrgC7pXRcGjEM
         sL1kUSMnpiT+P2riSDUk4MyTZujkzRJ5Rws+yEfeGOAXC6dkFtKZDxCn1Cbo6mfVN2aB
         U4VQbPknZHQwnNn5dSimxwtjx1bfq5CLne601wU0Lh2CAOp5x/BIe2NG2+cduP4H7z/o
         sJEjPOFja9T+kzWQ4bhd/kNUV+5tQttV7jXoGtn1gyTlmQ7PqOz9Cn4hrMnghDnDbrOp
         c++g==
X-Gm-Message-State: ANhLgQ1q58JG93nBiuFc9gB9rPfG4Vw+qkxJQahv6rS3Bx1ZcLRj9fms
        z18LtNgOAiPCz1nJamdR9yZuWIumoIU=
X-Google-Smtp-Source: ADFU+vu111OnfaEYVBzNM7gnGOPxti6lInjkx8+eyDFnBCFlxAQ7oogesXr5VtNKyBwqUj77sM5feQ==
X-Received: by 2002:a17:90a:eac9:: with SMTP id ev9mr2683482pjb.80.1583322495116;
        Wed, 04 Mar 2020 03:48:15 -0800 (PST)
Received: from localhost ([203.144.74.196])
        by smtp.gmail.com with ESMTPSA id u3sm2507313pjv.32.2020.03.04.03.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 03:48:14 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH v1 2/2] gpg-interface: prefer check_signature() for GPG verification
Date:   Wed,  4 Mar 2020 11:48:04 +0000
Message-Id: <20200304114804.19108-3-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304114804.19108-1-hji@dyntopia.com>
References: <20191127174821.5830-1-hji@dyntopia.com>
 <20200304114804.19108-1-hji@dyntopia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit refactors the use of verify_signed_buffer() outside of
gpg-interface.c to use check_signature() instead.  It also turns
verify_signed_buffer() into a file-local function since it's now only
invoked internally by check_signature().

There were previously two globally scoped functions used in different
parts of Git to perform GPG signature verification:
verify_signed_buffer() and check_signature().  Now only
check_signature() is used.

The verify_signed_buffer() function doesn't guard against duplicate
signatures as described by Michał Górny [1].  Instead it only ensures a
non-erroneous exit code from GPG and the presence of at least one
GOODSIG status field.  This stands in contrast with check_signature()
that returns an error if more than one signature is encountered.

The lower degree of verification makes the use of verify_signed_buffer()
problematic if callers don't parse and validate the various parts of the
GPG status message themselves.  And processing these messages seems like
a task that should be reserved to gpg-interface.c with the function
check_signature().

Furthermore, the use of verify_signed_buffer() makes it difficult to
introduce new functionality that relies on the content of the GPG status
lines.

Now all operations that does signature verification share a single entry
point to gpg-interface.c.  This makes it easier to propagate changed or
additional functionality in GPG signature verification to all parts of
Git, without having odd edge-cases that don't perform the same degree of
verification.

[1] https://dev.gentoo.org/~mgorny/articles/attack-on-git-signature-verification.html

Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
---
 builtin/fmt-merge-msg.c | 11 +++--
 gpg-interface.c         | 97 +++++++++++++++++++++--------------------
 gpg-interface.h         |  9 ----
 log-tree.c              | 34 +++++++--------
 4 files changed, 73 insertions(+), 78 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 736f666f64..172dfbd852 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -494,6 +494,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		enum object_type type;
 		unsigned long size, len;
 		char *buf = read_object_file(oid, &type, &size);
+		struct signature_check sigc = { 0 };
 		struct strbuf sig = STRBUF_INIT;
 
 		if (!buf || type != OBJ_TAG)
@@ -502,10 +503,12 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 
 		if (size == len)
 			; /* merely annotated */
-		else if (verify_signed_buffer(buf, len, buf + len, size - len, &sig, NULL)) {
-			if (!sig.len)
-				strbuf_addstr(&sig, "gpg verification failed.\n");
-		}
+		else if (check_signature(buf, len, buf + len, size - len, &sigc) &&
+			!sigc.gpg_output)
+			strbuf_addstr(&sig, "gpg verification failed.\n");
+		else
+			strbuf_addstr(&sig, sigc.gpg_output);
+		signature_check_clear(&sigc);
 
 		if (!tag_number++) {
 			fmt_tag_signature(&tagbuf, &sig, buf, len);
diff --git a/gpg-interface.c b/gpg-interface.c
index 165274d74a..2d538bcd6e 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -256,6 +256,55 @@ static void parse_gpg_output(struct signature_check *sigc)
 	FREE_AND_NULL(sigc->key);
 }
 
+static int verify_signed_buffer(const char *payload, size_t payload_size,
+				const char *signature, size_t signature_size,
+				struct strbuf *gpg_output,
+				struct strbuf *gpg_status)
+{
+	struct child_process gpg = CHILD_PROCESS_INIT;
+	struct gpg_format *fmt;
+	struct tempfile *temp;
+	int ret;
+	struct strbuf buf = STRBUF_INIT;
+
+	temp = mks_tempfile_t(".git_vtag_tmpXXXXXX");
+	if (!temp)
+		return error_errno(_("could not create temporary file"));
+	if (write_in_full(temp->fd, signature, signature_size) < 0 ||
+	    close_tempfile_gently(temp) < 0) {
+		error_errno(_("failed writing detached signature to '%s'"),
+			    temp->filename.buf);
+		delete_tempfile(&temp);
+		return -1;
+	}
+
+	fmt = get_format_by_sig(signature);
+	if (!fmt)
+		BUG("bad signature '%s'", signature);
+
+	argv_array_push(&gpg.args, fmt->program);
+	argv_array_pushv(&gpg.args, fmt->verify_args);
+	argv_array_pushl(&gpg.args,
+			 "--status-fd=1",
+			 "--verify", temp->filename.buf, "-",
+			 NULL);
+
+	if (!gpg_status)
+		gpg_status = &buf;
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+	ret = pipe_command(&gpg, payload, payload_size,
+			   gpg_status, 0, gpg_output, 0);
+	sigchain_pop(SIGPIPE);
+
+	delete_tempfile(&temp);
+
+	ret |= !strstr(gpg_status->buf, "\n[GNUPG:] GOODSIG ");
+	strbuf_release(&buf); /* no matter it was used or not */
+
+	return ret;
+}
+
 int check_signature(const char *payload, size_t plen, const char *signature,
 	size_t slen, struct signature_check *sigc)
 {
@@ -418,51 +467,3 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 
 	return 0;
 }
-
-int verify_signed_buffer(const char *payload, size_t payload_size,
-			 const char *signature, size_t signature_size,
-			 struct strbuf *gpg_output, struct strbuf *gpg_status)
-{
-	struct child_process gpg = CHILD_PROCESS_INIT;
-	struct gpg_format *fmt;
-	struct tempfile *temp;
-	int ret;
-	struct strbuf buf = STRBUF_INIT;
-
-	temp = mks_tempfile_t(".git_vtag_tmpXXXXXX");
-	if (!temp)
-		return error_errno(_("could not create temporary file"));
-	if (write_in_full(temp->fd, signature, signature_size) < 0 ||
-	    close_tempfile_gently(temp) < 0) {
-		error_errno(_("failed writing detached signature to '%s'"),
-			    temp->filename.buf);
-		delete_tempfile(&temp);
-		return -1;
-	}
-
-	fmt = get_format_by_sig(signature);
-	if (!fmt)
-		BUG("bad signature '%s'", signature);
-
-	argv_array_push(&gpg.args, fmt->program);
-	argv_array_pushv(&gpg.args, fmt->verify_args);
-	argv_array_pushl(&gpg.args,
-			 "--status-fd=1",
-			 "--verify", temp->filename.buf, "-",
-			 NULL);
-
-	if (!gpg_status)
-		gpg_status = &buf;
-
-	sigchain_push(SIGPIPE, SIG_IGN);
-	ret = pipe_command(&gpg, payload, payload_size,
-			   gpg_status, 0, gpg_output, 0);
-	sigchain_pop(SIGPIPE);
-
-	delete_tempfile(&temp);
-
-	ret |= !strstr(gpg_status->buf, "\n[GNUPG:] GOODSIG ");
-	strbuf_release(&buf); /* no matter it was used or not */
-
-	return ret;
-}
diff --git a/gpg-interface.h b/gpg-interface.h
index 796571e9e9..f4e9b4f371 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -54,15 +54,6 @@ size_t parse_signature(const char *buf, size_t size);
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
 		const char *signing_key);
 
-/*
- * Run "gpg" to see if the payload matches the detached signature.
- * gpg_output, when set, receives the diagnostic output from GPG.
- * gpg_status, when set, receives the status output from GPG.
- */
-int verify_signed_buffer(const char *payload, size_t payload_size,
-			 const char *signature, size_t signature_size,
-			 struct strbuf *gpg_output, struct strbuf *gpg_status);
-
 int git_gpg_config(const char *, const char *, void *);
 void set_signing_key(const char *);
 const char *get_signing_key(void);
diff --git a/log-tree.c b/log-tree.c
index 52127427ff..897a90233e 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -449,22 +449,21 @@ static void show_signature(struct rev_info *opt, struct commit *commit)
 {
 	struct strbuf payload = STRBUF_INIT;
 	struct strbuf signature = STRBUF_INIT;
-	struct strbuf gpg_output = STRBUF_INIT;
+	struct signature_check sigc = { 0 };
 	int status;
 
 	if (parse_signed_commit(commit, &payload, &signature) <= 0)
 		goto out;
 
-	status = verify_signed_buffer(payload.buf, payload.len,
-				      signature.buf, signature.len,
-				      &gpg_output, NULL);
-	if (status && !gpg_output.len)
-		strbuf_addstr(&gpg_output, "No signature\n");
-
-	show_sig_lines(opt, status, gpg_output.buf);
+	status = check_signature(payload.buf, payload.len, signature.buf,
+				 signature.len, &sigc);
+	if (status && !sigc.gpg_output)
+		show_sig_lines(opt, status, "No signature\n");
+	else
+		show_sig_lines(opt, status, sigc.gpg_output);
+	signature_check_clear(&sigc);
 
  out:
-	strbuf_release(&gpg_output);
 	strbuf_release(&payload);
 	strbuf_release(&signature);
 }
@@ -497,8 +496,9 @@ static int show_one_mergetag(struct commit *commit,
 	struct object_id oid;
 	struct tag *tag;
 	struct strbuf verify_message;
+	struct signature_check sigc = { 0 };
 	int status, nth;
-	size_t payload_size, gpg_message_offset;
+	size_t payload_size;
 
 	hash_object_file(the_hash_algo, extra->value, extra->len,
 			 type_name(OBJ_TAG), &oid);
@@ -520,19 +520,19 @@ static int show_one_mergetag(struct commit *commit,
 	else
 		strbuf_addf(&verify_message,
 			    "parent #%d, tagged '%s'\n", nth + 1, tag->tag);
-	gpg_message_offset = verify_message.len;
 
 	payload_size = parse_signature(extra->value, extra->len);
 	status = -1;
 	if (extra->len > payload_size) {
 		/* could have a good signature */
-		if (!verify_signed_buffer(extra->value, payload_size,
-					  extra->value + payload_size,
-					  extra->len - payload_size,
-					  &verify_message, NULL))
-			status = 0; /* good */
-		else if (verify_message.len <= gpg_message_offset)
+		status = check_signature(extra->value, payload_size,
+					 extra->value + payload_size,
+					 extra->len - payload_size, &sigc);
+		if (sigc.gpg_output)
+			strbuf_addstr(&verify_message, sigc.gpg_output);
+		else
 			strbuf_addstr(&verify_message, "No signature\n");
+		signature_check_clear(&sigc);
 		/* otherwise we couldn't verify, which is shown as bad */
 	}
 
-- 
2.25.1.709.g558d21736a

