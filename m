Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FAEC47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 14:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F5FC206A5
	for <git@archiver.kernel.org>; Tue,  5 May 2020 14:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5GICo2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgEEOlr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 10:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729095AbgEEOlo (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 10:41:44 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA8CC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 07:41:44 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id b8so1096915pgi.11
        for <git@vger.kernel.org>; Tue, 05 May 2020 07:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZjTaJDrUfGhQukqvWlT4kI4HU9XosJz7dey7/Ev1QtA=;
        b=c5GICo2zylQkJ6bHXRkYHcTZd5Jb8DHbm/S1iBiaZmEYhKubpQ/uvVwJwjG2zHC0NR
         ouyS37rlBG4VESc8TdcTtfYiYLC45T+NCuVA97ZDeUDzRP1hfNvAO25T4+9Fp2QXWe0I
         GAvEPEVHVCyWwt8G3hCgRgOQDI26fQMTrvo8mwoxLikXg9p60xWoN6FdUzApqNc3XcgM
         PCYwAze4OnUNmgD4/B7rc2NLAngwmLqcYlGIsBwjIw4dXKlDqe+mu9o8jOQtPNBYir40
         bApR0gHVx5TZX6HKi70xJ3/zvBGgSmKdpZkdQkpJPbzj2G9//JuE+naQwrOo7UGFN0VM
         iC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZjTaJDrUfGhQukqvWlT4kI4HU9XosJz7dey7/Ev1QtA=;
        b=sdbtCy8+I2KAzuHzCuoadRFXd3tTg+TV2/hLYNd7cMCdexX/MZ04s+S8qrrP3+VNjw
         afasMq9UU3RMQX7gQMXP5J+iSW3098OH9DdWL85B3WHkvM/rt1guSWhY9K4lM7nA9ljq
         ro3EJ+zLhNsaJg5q4a4g3wsSutkN3wnqS5l6i0j7KXIre2tLuxCpn8HLsobUicSZwm9p
         psoBv/eE8Kt3nK7cgMW14EPa0IBIhiTB/cMrSFktCZTdHlJCTf7rPZe44TqHLaH18H5N
         lydM3nY0KP6c5dgxpgwSNlueocrjTqKhSPhDOtR+j58xvXpXPxPx145cTWEeKl9Lbq8E
         RGCQ==
X-Gm-Message-State: AGi0PuYL+xB5dzvwJcddGZhPX30kZYkB/1HszF2QGbQPmuiWoFE4wd3C
        8Z1NOmJIPqytzTtxh+sdkC1RhG/y
X-Google-Smtp-Source: APiQypIsKGPyS50xGSfv8PNScEKVgJ9pEyS5MqeNWiw2WwZlTUlBHBAgGMUXmpUptSKwxF4EUsYM5Q==
X-Received: by 2002:a63:e242:: with SMTP id y2mr3069912pgj.205.1588689703598;
        Tue, 05 May 2020 07:41:43 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id f99sm2431012pjg.22.2020.05.05.07.41.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 07:41:43 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v14 3/7] New capability "report-status-v2" for git-push
Date:   Tue,  5 May 2020 10:41:27 -0400
Message-Id: <20200505144131.30048-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <CANYiYbFCG1_hdy1kA06wjrvGSQ2=y-hJX3Rsh-rn=X9tcqv1VQ@mail.gmail.com>
References: <CANYiYbFCG1_hdy1kA06wjrvGSQ2=y-hJX3Rsh-rn=X9tcqv1VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

The new introduced "proc-receive" hook may handle a command for a
pseudo-reference with a zero-old as its old-oid, while the hook may
create or update a reference with different name, different new-oid,
and different old-oid (the reference may exist already with a non-zero
old-oid).  Current "report-status" protocol cannot report the status for
such reference rewrite.

Add new capability "report-status-v2" and new report protocol which is
not backward compatible for report of git-push.

If a user pushes to a pseudo-reference "refs/for/master/topic", and
"receive-pack" creates two new references "refs/changes/23/123/1" and
"refs/changes/24/124/1", for client without the knowledge of
"report-status-v2", "receive-pack" will only send "ok/ng" directives in
the report, such as:

    ok ref/for/master/topic

But for client which has the knowledge of "report-status-v2",
"receive-pack" will use "option" directives to report more attributes
for the reference given by the above "ok/ng" directive.

    ok refs/for/master/topic
    option refname refs/changes/23/123/1
    option new-oid <new-oid>
    ok refs/for/master/topic
    option refname refs/changes/24/124/1
    option new-oid <new-oid>

The client will report two new created references to the end user.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/receive-pack.c                        |  52 +++++++-
 builtin/send-pack.c                           |  21 +++-
 remote.c                                      |   7 +-
 remote.h                                      |   2 +-
 send-pack.c                                   |  96 +++++++++++---
 t/t5411/test-0032-report-with-options.sh      |  14 +--
 ...est-0033-report-with-options--porcelain.sh |  14 +--
 ...t-0036-report-multi-rewrite-for-one-ref.sh |  11 +-
 ...rt-multi-rewrite-for-one-ref--porcelain.sh |  11 +-
 t/t5411/test-0038-report-mixed-refs.sh        |   2 +-
 .../test-0039-report-mixed-refs--porcelain.sh |   2 +-
 transport-helper.c                            |  53 +++++++-
 transport.c                                   | 118 +++++++++++++-----
 13 files changed, 328 insertions(+), 75 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 7575eec320..8b96a995b8 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -56,6 +56,7 @@ static int advertise_push_options;
 static int unpack_limit = 100;
 static off_t max_input_size;
 static int report_status;
+static int report_status_v2;
 static int use_sideband;
 static int use_atomic;
 static int use_push_options;
@@ -239,7 +240,7 @@ static void show_ref(const char *path, const struct object_id *oid)
 		struct strbuf cap = STRBUF_INIT;
 
 		strbuf_addstr(&cap,
-			      "report-status delete-refs side-band-64k quiet");
+			      "report-status report-status-v2 delete-refs side-band-64k quiet");
 		if (advertise_atomic_push)
 			strbuf_addstr(&cap, " atomic");
 		if (prefer_ofs_delta)
@@ -1912,6 +1913,8 @@ static struct command *read_head_info(struct packet_reader *reader,
 			const char *feature_list = reader->line + linelen + 1;
 			if (parse_feature_request(feature_list, "report-status"))
 				report_status = 1;
+			if (parse_feature_request(feature_list, "report-status-v2"))
+				report_status_v2 = 1;
 			if (parse_feature_request(feature_list, "side-band-64k"))
 				use_sideband = LARGE_PACKET_MAX;
 			if (parse_feature_request(feature_list, "quiet"))
@@ -2223,6 +2226,49 @@ static void report(struct command *commands, const char *unpack_status)
 	strbuf_release(&buf);
 }
 
+static void report_v2(struct command *commands, const char *unpack_status)
+{
+	struct command *cmd;
+	struct strbuf buf = STRBUF_INIT;
+	struct ref_push_report_options *options;
+
+	packet_buf_write(&buf, "unpack %s\n",
+			 unpack_status ? unpack_status : "ok");
+	for (cmd = commands; cmd; cmd = cmd->next) {
+		int count = 0;
+
+		if (!cmd->report.error_message)
+			packet_buf_write(&buf, "ok %s\n",
+					 cmd->ref_name);
+		else
+			packet_buf_write(&buf, "ng %s %s\n",
+					 cmd->ref_name,
+					 cmd->report.error_message);
+		for (options = cmd->report.options; options; options = options->next) {
+			if (count++ > 0)
+				packet_buf_write(&buf, "ok %s\n", cmd->ref_name);
+			if (options->ref_name)
+				packet_buf_write(&buf, "option refname %s\n",
+						 options->ref_name);
+			if (options->old_oid)
+				packet_buf_write(&buf, "option old-oid %s\n",
+						 oid_to_hex(options->old_oid));
+			if (options->new_oid)
+				packet_buf_write(&buf, "option new-oid %s\n",
+						 oid_to_hex(options->new_oid));
+			if (options->forced_update)
+				packet_buf_write(&buf, "option forced-update\n");
+		}
+	}
+	packet_buf_flush(&buf);
+
+	if (use_sideband)
+		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
+	else
+		write_or_die(1, buf.buf, buf.len);
+	strbuf_release(&buf);
+}
+
 static int delete_only(struct command *commands)
 {
 	struct command *cmd;
@@ -2331,7 +2377,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 				 &push_options);
 		if (pack_lockfile)
 			unlink_or_warn(pack_lockfile);
-		if (report_status)
+		if (report_status_v2)
+			report_v2(commands, unpack_status);
+		else if (report_status)
 			report(commands, unpack_status);
 		run_receive_hook(commands, "post-receive", 1,
 				 &push_options);
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index f2c5a34402..4faee72640 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -29,10 +29,12 @@ static struct send_pack_args args;
 static void print_helper_status(struct ref *ref)
 {
 	struct strbuf buf = STRBUF_INIT;
+	struct ref_push_report_options *options;
 
 	for (; ref; ref = ref->next) {
 		const char *msg = NULL;
 		const char *res;
+		int count = 0;
 
 		switch(ref->status) {
 		case REF_STATUS_NONE:
@@ -86,14 +88,29 @@ static void print_helper_status(struct ref *ref)
 
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "%s %s", res, ref->name);
-		if (ref->remote_status)
-			msg = ref->remote_status;
+		if (ref->report.error_message)
+			msg = ref->report.error_message;
 		if (msg) {
 			strbuf_addch(&buf, ' ');
 			quote_two_c_style(&buf, "", msg, 0);
 		}
 		strbuf_addch(&buf, '\n');
 
+		for (options = ref->report.options; options; options = options->next) {
+			if (count++ > 0)
+				strbuf_addf(&buf, "ok %s\n", ref->name);
+			if (options->ref_name)
+				strbuf_addf(&buf, "option refname %s\n",
+						  options->ref_name);
+			if (options->old_oid)
+				strbuf_addf(&buf, "option old-oid %s\n",
+						  oid_to_hex(options->old_oid));
+			if (options->new_oid)
+				strbuf_addf(&buf, "option new-oid %s\n",
+						  oid_to_hex(options->new_oid));
+			if (options->forced_update)
+				strbuf_addf(&buf, "option forced-update\n");
+		}
 		write_or_die(1, buf.buf, buf.len);
 	}
 	strbuf_release(&buf);
diff --git a/remote.c b/remote.c
index 534c6426f1..1f5239650d 100644
--- a/remote.c
+++ b/remote.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "connect.h"
 #include "remote.h"
 #include "refs.h"
 #include "refspec.h"
@@ -789,7 +790,7 @@ struct ref *copy_ref(const struct ref *ref)
 	memcpy(cpy, ref, len);
 	cpy->next = NULL;
 	cpy->symref = xstrdup_or_null(ref->symref);
-	cpy->remote_status = xstrdup_or_null(ref->remote_status);
+	cpy->report.error_message = xstrdup_or_null(ref->report.error_message);
 	cpy->peer_ref = copy_ref(ref->peer_ref);
 	return cpy;
 }
@@ -811,7 +812,7 @@ void free_one_ref(struct ref *ref)
 	if (!ref)
 		return;
 	free_one_ref(ref->peer_ref);
-	free(ref->remote_status);
+	free((void *)ref->report.error_message);
 	free(ref->symref);
 	free(ref);
 }
@@ -2299,4 +2300,4 @@ void apply_push_cas(struct push_cas_option *cas,
 	struct ref *ref;
 	for (ref = remote_refs; ref; ref = ref->next)
 		apply_cas(cas, remote, ref);
-}
+}
\ No newline at end of file
diff --git a/remote.h b/remote.h
index 2ed2a16e16..caa3d5c9ba 100644
--- a/remote.h
+++ b/remote.h
@@ -153,7 +153,7 @@ struct ref {
 		REF_STATUS_EXPECTING_REPORT,
 		REF_STATUS_ATOMIC_PUSH_FAILED
 	} status;
-	char *remote_status;
+	struct ref_push_report report;
 	struct ref *peer_ref; /* when renaming */
 	char name[FLEX_ARRAY]; /* more */
 };
diff --git a/send-pack.c b/send-pack.c
index d1b7edc995..9a9285755c 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -153,24 +153,80 @@ static int receive_status(struct packet_reader *reader, struct ref *refs)
 {
 	struct ref *hint;
 	int ret;
+	int new_options = 1;
 
 	hint = NULL;
 	ret = receive_unpack_status(reader);
 	while (1) {
+		struct object_id old_oid, new_oid;
+		const char *head;
 		const char *refname;
-		char *msg;
+		char *p;
+
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
 			break;
-		if (!starts_with(reader->line, "ok ") && !starts_with(reader->line, "ng ")) {
+		head = reader->line;
+		p = strchr(head, ' ');
+		if (!p) {
 			error("invalid ref status from remote: %s", reader->line);
 			ret = -1;
 			break;
 		}
+		*p++ = '\0';
+
+		if (!strcmp(head, "option")) {
+			struct ref_push_report_options *options;
+			const char *key, *val;
+
+			if (!hint) {
+			       if (new_options) {
+					error("'option' without a matching 'ok/ng' directive");
+					new_options = 0;
+				}
+				ret = -1;
+				continue;
+			}
+			options = hint->report.options;
+			while (options && options->next)
+				options = options->next;
+			if (new_options) {
+				if (!options) {
+					hint->report.options = xcalloc(1, sizeof(struct ref_push_report_options));
+					options = hint->report.options;
+				} else {
+					options->next = xcalloc(1, sizeof(struct ref_push_report_options));
+					options = options->next;
+				}
+				new_options = 0;
+			}
+			assert(options);
+			key = p;
+			p = strchr(key, ' ');
+			if (p)
+				*p++ = '\0';
+			val = p;
+			if (!strcmp(key, "refname"))
+				options->ref_name = xstrdup_or_null(val);
+			else if (!strcmp(key, "old-oid") && val &&
+				 !parse_oid_hex(val, &old_oid, &val))
+				options->old_oid = oiddup(&old_oid);
+			else if (!strcmp(key, "new-oid") && val &&
+				 !parse_oid_hex(val, &new_oid, &val))
+				options->new_oid = oiddup(&new_oid);
+			else if (!strcmp(key, "forced-update"))
+				options->forced_update = 1;
+			continue;
+		}
 
-		refname = reader->line + 3;
-		msg = strchr(refname, ' ');
-		if (msg)
-			*msg++ = '\0';
+		refname = p;
+		p = strchr(refname, ' ');
+		if (p)
+			*p++ = '\0';
+		if (strcmp(head, "ok") && strcmp(head, "ng")) {
+			error("invalid ref status from remote: %s", reader->line);
+			ret = -1;
+			break;
+		}
 
 		/* first try searching at our hint, falling back to all refs */
 		if (hint)
@@ -182,19 +238,25 @@ static int receive_status(struct packet_reader *reader, struct ref *refs)
 					refname);
 			continue;
 		}
-		if (hint->status != REF_STATUS_EXPECTING_REPORT) {
+		if (hint->status != REF_STATUS_EXPECTING_REPORT &&
+		    hint->status != REF_STATUS_OK &&
+		    hint->status != REF_STATUS_REMOTE_REJECT) {
 			warning("remote reported status on unexpected ref: %s",
 					refname);
 			continue;
 		}
-
-		if (reader->line[0] == 'o' && reader->line[1] == 'k')
-			hint->status = REF_STATUS_OK;
-		else
+		if (!strcmp(head, "ng")) {
 			hint->status = REF_STATUS_REMOTE_REJECT;
-		hint->remote_status = xstrdup_or_null(msg);
-		/* start our next search from the next ref */
-		hint = hint->next;
+			if (p)
+				hint->report.error_message = xstrdup(p);
+			else
+				hint->report.error_message = "failed";
+		} else {
+			hint->status = REF_STATUS_OK;
+			if (p)
+				hint->report.message = xstrdup(p);
+		}
+		new_options = 1;
 	}
 	return ret;
 }
@@ -371,6 +433,8 @@ int send_pack(struct send_pack_args *args,
 	/* Does the other end support the reporting? */
 	if (server_supports("report-status"))
 		status_report = 1;
+	if (server_supports("report-status-v2"))
+		status_report = 2;
 	if (server_supports("delete-refs"))
 		allow_deleting_refs = 1;
 	if (server_supports("ofs-delta"))
@@ -418,8 +482,10 @@ int send_pack(struct send_pack_args *args,
 
 	use_push_options = push_options_supported && args->push_options;
 
-	if (status_report)
+	if (status_report == 1)
 		strbuf_addstr(&cap_buf, " report-status");
+	else if (status_report == 2)
+		strbuf_addstr(&cap_buf, " report-status-v2");
 	if (use_sideband)
 		strbuf_addstr(&cap_buf, " side-band-64k");
 	if (quiet_supported && (args->quiet || !args->progress))
diff --git a/t/t5411/test-0032-report-with-options.sh b/t/t5411/test-0032-report-with-options.sh
index a743aa8018..3742ed3c3d 100644
--- a/t/t5411/test-0032-report-with-options.sh
+++ b/t/t5411/test-0032-report-with-options.sh
@@ -56,7 +56,7 @@ test_expect_success "proc-receive: report option refname ($PROTOCOL)" '
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/master/topic
+	 * [new reference] HEAD -> refs/pull/123/head
 	EOF
 	test_cmp expect actual
 '
@@ -89,7 +89,7 @@ test_expect_success "proc-receive: report option refname and forced-update ($PRO
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/master/topic
+	 * [new reference] HEAD -> refs/pull/123/head
 	EOF
 	test_cmp expect actual
 '
@@ -123,7 +123,7 @@ test_expect_success "proc-receive: report option refname and old-oid ($PROTOCOL)
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/master/topic
+	 <OID-B>..<OID-A> HEAD -> refs/pull/123/head
 	EOF
 	test_cmp expect actual
 '
@@ -155,7 +155,7 @@ test_expect_success "proc-receive: report option old-oid ($PROTOCOL)" '
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/master/topic
+	 <OID-B>..<OID-A> HEAD -> refs/for/master/topic
 	EOF
 	test_cmp expect actual
 '
@@ -189,7 +189,7 @@ test_expect_success "proc-receive: report option old-oid and new-oid ($PROTOCOL)
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/master/topic
+	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
 	EOF
 	test_cmp expect actual
 '
@@ -241,9 +241,9 @@ test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL)" '
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/next/topic
+	 * [new reference] HEAD -> refs/pull/123/head
 	 * [new reference] HEAD -> refs/for/a/b/c/topic
-	 * [new reference] HEAD -> refs/for/master/topic
+	 + <OID-B>...<OID-A> HEAD -> refs/pull/124/head (forced update)
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0033-report-with-options--porcelain.sh b/t/t5411/test-0033-report-with-options--porcelain.sh
index 8a50d7efe3..929c46ccd8 100644
--- a/t/t5411/test-0033-report-with-options--porcelain.sh
+++ b/t/t5411/test-0033-report-with-options--porcelain.sh
@@ -57,7 +57,7 @@ test_expect_success "proc-receive: report option refname ($PROTOCOL/porcelain)"
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	*    HEAD:refs/for/master/topic    [new reference]
+	*    HEAD:refs/pull/123/head    [new reference]
 	Done
 	EOF
 	test_cmp expect actual
@@ -92,7 +92,7 @@ test_expect_success "proc-receive: report option refname and forced-update ($PRO
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	*    HEAD:refs/for/master/topic    [new reference]
+	*    HEAD:refs/pull/123/head    [new reference]
 	Done
 	EOF
 	test_cmp expect actual
@@ -127,7 +127,7 @@ test_expect_success "proc-receive: report option refname and old-oid ($PROTOCOL/
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	*    HEAD:refs/for/master/topic    [new reference]
+	     HEAD:refs/pull/123/head    <OID-B>..<OID-A>
 	Done
 	EOF
 	test_cmp expect actual
@@ -160,7 +160,7 @@ test_expect_success "proc-receive: report option old-oid ($PROTOCOL/porcelain)"
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	*    HEAD:refs/for/master/topic    [new reference]
+	     HEAD:refs/for/master/topic    <OID-B>..<OID-A>
 	Done
 	EOF
 	test_cmp expect actual
@@ -195,7 +195,7 @@ test_expect_success "proc-receive: report option old-oid and new-oid ($PROTOCOL/
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	*    HEAD:refs/for/master/topic    [new reference]
+	     HEAD:refs/for/master/topic    <OID-A>..<OID-B>
 	Done
 	EOF
 	test_cmp expect actual
@@ -249,9 +249,9 @@ test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL/porc
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	*    HEAD:refs/for/next/topic    [new reference]
+	*    HEAD:refs/pull/123/head    [new reference]
 	*    HEAD:refs/for/a/b/c/topic    [new reference]
-	*    HEAD:refs/for/master/topic    [new reference]
+	+    HEAD:refs/pull/124/head    <OID-B>...<OID-A> (forced update)
 	Done
 	EOF
 	test_cmp expect actual &&
diff --git a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
index 12acf9ea1f..64662afdc6 100644
--- a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
+++ b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
@@ -43,7 +43,9 @@ test_expect_success "proc-receive: multiple rewrite for one ref, no refname for
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/master/topic
+	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
+	 * [new reference] HEAD -> refs/changes/24/124/1
+	 <OID-A>..<OID-B> HEAD -> refs/changes/25/125/1
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
@@ -101,7 +103,9 @@ test_expect_success "proc-receive: multiple rewrites for one ref, no refname for
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/master/topic
+	 * [new reference] HEAD -> refs/changes/24/124/1
+	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
+	 + <OID-B>...<OID-A> HEAD -> refs/changes/25/125/1 (forced update)
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
@@ -147,7 +151,8 @@ test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL)" '
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	 * [new reference] HEAD -> refs/for/master/topic
+	 * [new reference] HEAD -> refs/changes/23/123/1
+	 <OID-A>..<OID-B> HEAD -> refs/changes/24/124/2
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
diff --git a/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh b/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
index 57dc0d17ac..a371c8d610 100644
--- a/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
+++ b/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
@@ -43,7 +43,9 @@ test_expect_success "proc-receive: multiple rewrite for one ref, no refname for
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	*    HEAD:refs/for/master/topic    [new reference]
+	     HEAD:refs/for/master/topic    <OID-A>..<OID-B>
+	*    HEAD:refs/changes/24/124/1    [new reference]
+	     HEAD:refs/changes/25/125/1    <OID-A>..<OID-B>
 	Done
 	EOF
 	test_cmp expect actual &&
@@ -102,7 +104,9 @@ test_expect_success "proc-receive: multiple rewrites for one ref, no refname for
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	*    HEAD:refs/for/master/topic    [new reference]
+	*    HEAD:refs/changes/24/124/1    [new reference]
+	     HEAD:refs/for/master/topic    <OID-A>..<OID-B>
+	+    HEAD:refs/changes/25/125/1    <OID-B>...<OID-A> (forced update)
 	Done
 	EOF
 	test_cmp expect actual &&
@@ -149,7 +153,8 @@ test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL/porc
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
-	*    HEAD:refs/for/master/topic    [new reference]
+	*    HEAD:refs/changes/23/123/1    [new reference]
+	     HEAD:refs/changes/24/124/2    <OID-A>..<OID-B>
 	Done
 	EOF
 	test_cmp expect actual &&
diff --git a/t/t5411/test-0038-report-mixed-refs.sh b/t/t5411/test-0038-report-mixed-refs.sh
index 9853e47693..9b060b2f84 100644
--- a/t/t5411/test-0038-report-mixed-refs.sh
+++ b/t/t5411/test-0038-report-mixed-refs.sh
@@ -52,7 +52,7 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL)" '
 	 * [new branch] HEAD -> baz
 	 * [new reference] HEAD -> refs/for/next/topic
 	 * [new branch] HEAD -> foo
-	 * [new reference] HEAD -> refs/for/master/topic
+	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
 	EOF
 	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
diff --git a/t/t5411/test-0039-report-mixed-refs--porcelain.sh b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
index b3953c749b..537d4046b9 100644
--- a/t/t5411/test-0039-report-mixed-refs--porcelain.sh
+++ b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
@@ -52,7 +52,7 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL/porcel
 	*    HEAD:refs/heads/baz    [new branch]
 	*    HEAD:refs/for/next/topic    [new reference]
 	*    HEAD:refs/heads/foo    [new branch]
-	*    HEAD:refs/for/master/topic    [new reference]
+	     HEAD:refs/for/master/topic    <OID-A>..<OID-B>
 	Done
 	EOF
 	test_cmp expect actual &&
diff --git a/transport-helper.c b/transport-helper.c
index a46afcb69d..21d6e47966 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -725,6 +725,49 @@ static int push_update_ref_status(struct strbuf *buf,
 {
 	char *refname, *msg;
 	int status, forced = 0;
+	static struct ref *hint = NULL;
+	static int new_options = 1;
+
+	if (starts_with(buf->buf, "option ")) {
+		struct ref_push_report_options *options;
+		struct object_id old_oid, new_oid;
+		const char *key, *val;
+		char *p;
+
+		if (!hint)
+			die(_("'option' without a matching 'ok/error' directive"));
+		options = hint->report.options;
+		while (options && options->next)
+			options = options->next;
+		if (new_options) {
+			if (!options) {
+				hint->report.options = xcalloc(1, sizeof(struct ref_push_report_options));
+				options = hint->report.options;
+			} else {
+				options->next = xcalloc(1, sizeof(struct ref_push_report_options));
+				options = options->next;
+			}
+			new_options = 0;
+		}
+		assert(options);
+		key = buf->buf + 7;
+		p = strchr(key, ' ');
+		if (p)
+			*p++ = '\0';
+		val = p;
+		if (!strcmp(key, "refname"))
+			options->ref_name = xstrdup_or_null(val);
+		else if (!strcmp(key, "old-oid") && val &&
+			 !parse_oid_hex(val, &old_oid, &val))
+			options->old_oid = oiddup(&old_oid);
+		else if (!strcmp(key, "new-oid") && val &&
+			 !parse_oid_hex(val, &new_oid, &val))
+			options->new_oid = oiddup(&new_oid);
+		else if (!strcmp(key, "forced-update"))
+			options->forced_update = 1;
+		/* Not update remote namespace again. */
+		return 1;
+	}
 
 	if (starts_with(buf->buf, "ok ")) {
 		status = REF_STATUS_OK;
@@ -787,8 +830,11 @@ static int push_update_ref_status(struct strbuf *buf,
 		*ref = find_ref_by_name(remote_refs, refname);
 	if (!*ref) {
 		warning(_("helper reported unexpected status of %s"), refname);
+		hint = NULL;
 		return 1;
 	}
+	hint = *ref;
+	new_options = 1;
 
 	if ((*ref)->status != REF_STATUS_NONE) {
 		/*
@@ -801,7 +847,12 @@ static int push_update_ref_status(struct strbuf *buf,
 
 	(*ref)->status = status;
 	(*ref)->forced_update |= forced;
-	(*ref)->remote_status = msg;
+	if (msg) {
+		if (status == REF_STATUS_OK)
+			(*ref)->report.message = msg;
+		else
+			(*ref)->report.error_message = msg;
+	}
 	return !(status == REF_STATUS_OK);
 }
 
diff --git a/transport.c b/transport.c
index 26fefd13c1..2e2b7de036 100644
--- a/transport.c
+++ b/transport.c
@@ -461,13 +461,21 @@ void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int v
 
 static void print_ref_status(char flag, const char *summary,
 			     struct ref *to, struct ref *from, const char *msg,
+			     struct ref_push_report_options *options,
 			     int porcelain, int summary_width)
 {
+	char *to_name;
+
+	if (options && options->ref_name)
+		to_name = options->ref_name;
+	else
+		to_name = to->name;
+
 	if (porcelain) {
 		if (from)
-			fprintf(stdout, "%c\t%s:%s\t", flag, from->name, to->name);
+			fprintf(stdout, "%c\t%s:%s\t", flag, from->name, to_name);
 		else
-			fprintf(stdout, "%c\t:%s\t", flag, to->name);
+			fprintf(stdout, "%c\t:%s\t", flag, to_name);
 		if (msg)
 			fprintf(stdout, "%s (%s)\n", summary, msg);
 		else
@@ -481,9 +489,11 @@ static void print_ref_status(char flag, const char *summary,
 		fprintf(stderr, " %s%c %-*s%s ", red, flag, summary_width,
 			summary, reset);
 		if (from)
-			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
+			fprintf(stderr, "%s -> %s",
+				prettify_refname(from->name),
+				prettify_refname(to_name));
 		else
-			fputs(prettify_refname(to->name), stderr);
+			fputs(prettify_refname(to_name), stderr);
 		if (msg) {
 			fputs(" (", stderr);
 			fputs(msg, stderr);
@@ -493,27 +503,52 @@ static void print_ref_status(char flag, const char *summary,
 	}
 }
 
-static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_width)
+static void print_ok_ref_status(struct ref *ref,
+				struct ref_push_report_options *options,
+				int porcelain, int summary_width)
 {
+	struct object_id *old_oid;
+	struct object_id *new_oid;
+	const char *ref_name;
+	int forced_update;
+
+	if (options && options->old_oid)
+		old_oid = options->old_oid;
+	else
+		old_oid = &ref->old_oid;
+	if (options && options->new_oid)
+		new_oid = options->new_oid;
+	else
+		new_oid = &ref->new_oid;
+	if (options && options->forced_update)
+		forced_update = options->forced_update;
+	else
+		forced_update = ref->forced_update;
+	if (options && options->ref_name)
+		ref_name = options->ref_name;
+	else
+		ref_name = ref->name;
+
 	if (ref->deletion)
 		print_ref_status('-', "[deleted]", ref, NULL, NULL,
-				 porcelain, summary_width);
-	else if (is_null_oid(&ref->old_oid))
+				 options, porcelain, summary_width);
+	else if (is_null_oid(old_oid))
 		print_ref_status('*',
-				 (starts_with(ref->name, "refs/tags/")
+				 (starts_with(ref_name, "refs/tags/")
 				  ? "[new tag]"
-				  : (starts_with(ref->name, "refs/heads/")
+				  : (starts_with(ref_name, "refs/heads/")
 				     ? "[new branch]"
 				     : "[new reference]")),
-				 ref, ref->peer_ref, NULL, porcelain, summary_width);
+				 ref, ref->peer_ref, NULL,
+				 options, porcelain, summary_width);
 	else {
 		struct strbuf quickref = STRBUF_INIT;
 		char type;
 		const char *msg;
 
-		strbuf_add_unique_abbrev(&quickref, &ref->old_oid,
+		strbuf_add_unique_abbrev(&quickref, old_oid,
 					 DEFAULT_ABBREV);
-		if (ref->forced_update) {
+		if (forced_update) {
 			strbuf_addstr(&quickref, "...");
 			type = '+';
 			msg = "forced update";
@@ -522,17 +557,18 @@ static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_widt
 			type = ' ';
 			msg = NULL;
 		}
-		strbuf_add_unique_abbrev(&quickref, &ref->new_oid,
+		strbuf_add_unique_abbrev(&quickref, new_oid,
 					 DEFAULT_ABBREV);
 
 		print_ref_status(type, quickref.buf, ref, ref->peer_ref, msg,
-				 porcelain, summary_width);
+				 options, porcelain, summary_width);
 		strbuf_release(&quickref);
 	}
 }
 
-static int print_one_push_status(struct ref *ref, const char *dest, int count,
-				 int porcelain, int summary_width)
+static int _print_one_push_status(struct ref *ref, const char *dest, int count,
+				  struct ref_push_report_options *options,
+				  int porcelain, int summary_width)
 {
 	if (!count) {
 		char *url = transport_anonymize_url(dest);
@@ -543,65 +579,89 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count,
 	switch(ref->status) {
 	case REF_STATUS_NONE:
 		print_ref_status('X', "[no match]", ref, NULL, NULL,
-				 porcelain, summary_width);
+				 options, porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_NODELETE:
 		print_ref_status('!', "[rejected]", ref, NULL,
 				 "remote does not support deleting refs",
-				 porcelain, summary_width);
+				 options, porcelain, summary_width);
 		break;
 	case REF_STATUS_UPTODATE:
 		print_ref_status('=', "[up to date]", ref,
-				 ref->peer_ref, NULL, porcelain, summary_width);
+				 ref->peer_ref, NULL,
+				 options, porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_NONFASTFORWARD:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-				 "non-fast-forward", porcelain, summary_width);
+				 "non-fast-forward",
+				 options, porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_ALREADY_EXISTS:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-				 "already exists", porcelain, summary_width);
+				 "already exists",
+				 options, porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_FETCH_FIRST:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-				 "fetch first", porcelain, summary_width);
+				 "fetch first",
+				 options, porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_NEEDS_FORCE:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-				 "needs force", porcelain, summary_width);
+				 "needs force",
+				 options, porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_STALE:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-				 "stale info", porcelain, summary_width);
+				 "stale info",
+				 options, porcelain, summary_width);
 		break;
 	case REF_STATUS_REJECT_SHALLOW:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
 				 "new shallow roots not allowed",
-				 porcelain, summary_width);
+				 options, porcelain, summary_width);
 		break;
 	case REF_STATUS_REMOTE_REJECT:
 		print_ref_status('!', "[remote rejected]", ref,
 				 ref->deletion ? NULL : ref->peer_ref,
-				 ref->remote_status, porcelain, summary_width);
+				 ref->report.error_message,
+				 options, porcelain, summary_width);
 		break;
 	case REF_STATUS_EXPECTING_REPORT:
 		print_ref_status('!', "[remote failure]", ref,
 				 ref->deletion ? NULL : ref->peer_ref,
 				 "remote failed to report status",
-				 porcelain, summary_width);
+				 options, porcelain, summary_width);
 		break;
 	case REF_STATUS_ATOMIC_PUSH_FAILED:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-				 "atomic push failed", porcelain, summary_width);
+				 "atomic push failed",
+				 options, porcelain, summary_width);
 		break;
 	case REF_STATUS_OK:
-		print_ok_ref_status(ref, porcelain, summary_width);
+		print_ok_ref_status(ref, options, porcelain, summary_width);
 		break;
 	}
 
 	return 1;
 }
 
+static int print_one_push_status(struct ref *ref, const char *dest, int count,
+				 int porcelain, int summary_width)
+{
+	struct ref_push_report_options *options;
+	int n = 0;
+
+	if (!ref->report.options)
+		return _print_one_push_status(ref, dest, count,
+					      NULL, porcelain, summary_width);
+
+	for (options = ref->report.options; options; options = options->next)
+		_print_one_push_status(ref, dest, count + n++,
+				       options, porcelain, summary_width);
+	return n;
+}
+
 static int measure_abbrev(const struct object_id *oid, int sofar)
 {
 	char hex[GIT_MAX_HEXSZ + 1];
-- 
2.26.1.120.g98702cf3e9

