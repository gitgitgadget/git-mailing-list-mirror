Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FD6F211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 23:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbeLCXhy (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 18:37:54 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:33327 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeLCXhx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 18:37:53 -0500
Received: by mail-qk1-f201.google.com with SMTP id 80so14994090qkd.0
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 15:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IZP3L7PtOa1HXrhgi5ZlMpI0/opEBv1MrL1tjcrgHoA=;
        b=VjT0NJz/FYY9O9Usg8VQhXTJ1ELFq4tmkc3rYm83dqvYK7VTSZPcVrijzgiy0qf8Y+
         M08E1i6xEGpaY1Wb8N0PWGkz4rIttSlD9Db5B0zdRyahuplVGPWNdgozPAnxVarVSRti
         qKjx5yW6MNM3THvDrCtnovVP6icJHOdCNOX33uaEbesZF1zagVjwpAcqu59AnSA2ippQ
         SqQJlXuFHWygvrAfuV2liyLl8tVC34QAK33Pm6SOvgj8a2xYZCigkR1hngkWa9A5L2UZ
         /mEDE+DxMwZfm+d07XkG3Kix4MTf3ZkK1xBdz6DXnd8WfuEYa5Z1TniIre5SNv6l+dPv
         QR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IZP3L7PtOa1HXrhgi5ZlMpI0/opEBv1MrL1tjcrgHoA=;
        b=nRJ7ySWHUV9jOWCUcnnDRB/RbfPX2aVO9bjaamZ1UgT6O421M5KJqyLT4ILY23r4nW
         H2uE5pvdEHcqW6POAf3FlYV4p9TfbawTLLsjiGrsn+GNnoGUqq1FnckCLbYJKC+BB2iF
         6SERxi5JEJfEg9xcdxKyJ5KqupVwDxLcWjrQz4OYO31s6xjGaKKBP9Jf9y+vD8B5kMAo
         fM7A9Wjvjd18ZKZr07ZMZMaoBMbYaMsXuZvOET8AzZrNJDAPxf/v7sQaS5seT1FTeGnV
         5jgxC7DvrH+YxTk1vX9Vx0Qj/shd413C+U9+oXAKgcWViGKx3mN1UIJiB6bdgYfeTwSG
         Rg6A==
X-Gm-Message-State: AA+aEWaFa8HbBqrdnPjBfLT6Gcr4+WiNgT2+cPmz5PtmqZ+xUYuPlx07
        AhX63ufAk0H5xrVju4Wqds13bnC/2uZNE8Ede5TdbtYKMeOuZOOceKEINWeyCFVhpmLwEYf/dmE
        +348dA/BeIiCN49L4mVD2bzJJexuxAnaxXKiQXe3gnG5vFuwMgzZYYmxBuAWjDWJ/R9cjr/UG8S
        t6
X-Google-Smtp-Source: AFSGD/U4dnu5qOeXRfSR11BiCxqeZjRgAOnaFSwxwOOAuwP9tFKQZlhQZkWr5Zf/mCMP7bdvu5hPegxjprOJLQLtXlgq
X-Received: by 2002:a0c:981c:: with SMTP id c28mr14146631qvd.51.1543880272822;
 Mon, 03 Dec 2018 15:37:52 -0800 (PST)
Date:   Mon,  3 Dec 2018 15:37:37 -0800
In-Reply-To: <cover.1543879256.git.jonathantanmy@google.com>
Message-Id: <1d678a78a63b7e58988b52c8c0efab38c34a6848.1543879256.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1543879256.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP RFC 4/5] upload-pack: refactor writing of "packfile" line
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent patch allows pack-objects to output additional information
(in addition to the packfile that it currently outputs). This means that
we must hold off on writing the "packfile" section header to the client
before we process the output of pack-objects, so move the writing of
the "packfile" section header to read_pack_objects_stdout().

Unfortunately, this also means that we cannot send keepalive packets
until pack-objects starts sending out the packfile, since the sideband
is only established when the "packfile" section header is sent.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 upload-pack.c | 47 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index cec43e0a46..aa2589b858 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -104,9 +104,12 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 struct output_state {
 	char buffer[8193];
 	int used;
+	unsigned packfile_started : 1;
+	struct strbuf progress_buf;
 };
 
-static int read_pack_objects_stdout(int outfd, struct output_state *os)
+static int read_pack_objects_stdout(int outfd, struct output_state *os,
+				    int use_protocol_v2)
 {
 	/* Data ready; we keep the last byte to ourselves
 	 * in case we detect broken rev-list, so that we
@@ -126,6 +129,12 @@ static int read_pack_objects_stdout(int outfd, struct output_state *os)
 	}
 	os->used += readsz;
 
+	if (!os->packfile_started) {
+		os->packfile_started = 1;
+		if (use_protocol_v2)
+			packet_write_fmt(1, "packfile\n");
+	}
+
 	if (os->used > 1) {
 		send_client_data(1, os->buffer, os->used - 1);
 		os->buffer[0] = os->buffer[os->used - 1];
@@ -138,8 +147,17 @@ static int read_pack_objects_stdout(int outfd, struct output_state *os)
 	return readsz;
 }
 
+static void flush_progress_buf(struct strbuf *progress_buf)
+{
+	if (!progress_buf->len)
+		return;
+	send_client_data(2, progress_buf->buf, progress_buf->len);
+	strbuf_reset(progress_buf);
+}
+
 static void create_pack_file(const struct object_array *have_obj,
-			     const struct object_array *want_obj)
+			     const struct object_array *want_obj,
+			     int use_protocol_v2)
 {
 	struct child_process pack_objects = CHILD_PROCESS_INIT;
 	struct output_state output_state = {0};
@@ -260,9 +278,13 @@ static void create_pack_file(const struct object_array *have_obj,
 			 */
 			sz = xread(pack_objects.err, progress,
 				  sizeof(progress));
-			if (0 < sz)
-				send_client_data(2, progress, sz);
-			else if (sz == 0) {
+			if (0 < sz) {
+				if (output_state.packfile_started)
+					send_client_data(2, progress, sz);
+				else
+					strbuf_add(&output_state.progress_buf,
+						   progress, sz);
+			} else if (sz == 0) {
 				close(pack_objects.err);
 				pack_objects.err = -1;
 			}
@@ -273,8 +295,10 @@ static void create_pack_file(const struct object_array *have_obj,
 		}
 		if (0 <= pu && (pfd[pu].revents & (POLLIN|POLLHUP))) {
 			int result = read_pack_objects_stdout(pack_objects.out,
-							      &output_state);
-
+							      &output_state,
+							      use_protocol_v2);
+			if (output_state.packfile_started)
+				flush_progress_buf(&output_state.progress_buf);
 			if (result == 0) {
 				close(pack_objects.out);
 				pack_objects.out = -1;
@@ -293,12 +317,14 @@ static void create_pack_file(const struct object_array *have_obj,
 		 * protocol to say anything, so those clients are just out of
 		 * luck.
 		 */
-		if (!ret && use_sideband) {
+		if (!ret && use_sideband && output_state.packfile_started) {
 			static const char buf[] = "0005\1";
 			write_or_die(1, buf, 5);
 		}
 	}
 
+	flush_progress_buf(&output_state.progress_buf);
+
 	if (finish_command(&pack_objects)) {
 		error("git upload-pack: git-pack-objects died with error.");
 		goto fail;
@@ -1094,7 +1120,7 @@ void upload_pack(struct upload_pack_options *options)
 	if (want_obj.nr) {
 		struct object_array have_obj = OBJECT_ARRAY_INIT;
 		get_common_commits(&have_obj, &want_obj);
-		create_pack_file(&have_obj, &want_obj);
+		create_pack_file(&have_obj, &want_obj, 0);
 	}
 }
 
@@ -1475,8 +1501,7 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 			send_wanted_ref_info(&data);
 			send_shallow_info(&data, &want_obj);
 
-			packet_write_fmt(1, "packfile\n");
-			create_pack_file(&have_obj, &want_obj);
+			create_pack_file(&have_obj, &want_obj, 1);
 			state = FETCH_DONE;
 			break;
 		case FETCH_DONE:
-- 
2.19.0.271.gfe8321ec05.dirty

