Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C7E7211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 22:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfAKWSz (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 17:18:55 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:53868 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfAKWSz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 17:18:55 -0500
Received: by mail-qk1-f201.google.com with SMTP id r145so10749181qke.20
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 14:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/7twxnn7Iz4wc2JC/kdGYLyArr4JAVsEg+FhUY4JsXE=;
        b=vi7Be1eWhOfc5kGRceYd5SZlWLrlHdz1680OH0bTaGIyK9tW75TKhaz7npXvPcM/+p
         0xM/HgGpCWwp8Hpw0+H7MDbPaQnm7f/YYRrrnBRS1/oyjfZQLa2csber2Wfhtaek6LzW
         6Dz8ziOoogLIpa151ES4QqW07QvvC1MarAAUOj8uzgoPs1xHyrEEkPq3VuQRAzHWlyxq
         cTYQweqe5ZjIgNOIWnaIWHNCHOp9vszDLH6HMRcMYwRSbK8L1LnwFUkTSCX/UxLP36MJ
         3kBia1AIFWddiRl9dzSMtV9CoQpoH/sGl6gOVd5hsCUab5AHwzj7CGvEOV3ql4dLUCB+
         MxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/7twxnn7Iz4wc2JC/kdGYLyArr4JAVsEg+FhUY4JsXE=;
        b=hKuCSvGVuNcqyYKdgZhKch09VMlhhCZHP7mYi5xI5oJI4Ad0W0IweudurqS3A6r+3i
         DOebSEr3piLnvktyiopg5hVxY6An1zgzcs5aYBk03twoyNP7WfL1HwiI5oR8YAZHGGKz
         gNcDcawR3FS/Q9nxYTK3PuKEpve689z/PRwJ/v+k97PjyAjl8y9vHK0pPFW7bF2oSDY+
         Y81UFXQrFsAc45kTLr6UgYPuaGWwvZB+kb6pAYROULQPLsU4lMxdfDAQsh4SzB0EUVsg
         OOJ+xvu3bwPHTtXVaVTJgbCS5HAq3lUe+SFqPKI6ma+oDPTbwAPTu+bL/wYU866WyEex
         l5ZQ==
X-Gm-Message-State: AJcUukevRPLgLoQFECkqlr9invwy6i52nrmL/+/PgOxWPFhYKoHCB+Va
        /2436037gt7eL0ZJDNScgPW0laSIjea88wWzZICsf1Oc6ap1xFVQfNSIvkI5U0Ria3nZybLtx0o
        wMssI6urWdpkhtJR6dtLJBOicdvsWlXyNO35dLmfYG+wiqqZTTRMvY1uPQsGLxvBI4rQu0tDEHO
        wh
X-Google-Smtp-Source: ALg8bN71zmbGif5iKb1Eq8yST5MjyocDdhcaqCFfrgH+O2ROrqjMslPGEDebj+dr/+O7ScLX+9eX3HxmmTjB81BCqnFR
X-Received: by 2002:a0c:ae41:: with SMTP id z1mr1545403qvc.11.1547245133777;
 Fri, 11 Jan 2019 14:18:53 -0800 (PST)
Date:   Fri, 11 Jan 2019 14:18:20 -0800
In-Reply-To: <cover.1547244620.git.jonathantanmy@google.com>
Message-Id: <e87b45637a9773f0aaf1a04e97c0939e45a0cf80.1547244620.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1547244620.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP 7/4] upload-pack: refactor reading of pack-objects out
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subsequent patches will change how the output of pack-objects is
processed, so extract that processing into its own function.

Currently, at most 1 character can be buffered (in the "buffered" local
variable). One of those patches will require a larger buffer, so replace
that "buffered" local variable with a buffer array.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 upload-pack.c | 80 +++++++++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 34 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 0c1feccaab..c87b752550 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -103,14 +103,51 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 	return 0;
 }
 
+struct output_state {
+	char buffer[8193];
+	int used;
+};
+
+static int read_pack_objects_stdout(int outfd, struct output_state *os)
+{
+	/* Data ready; we keep the last byte to ourselves
+	 * in case we detect broken rev-list, so that we
+	 * can leave the stream corrupted.  This is
+	 * unfortunate -- unpack-objects would happily
+	 * accept a valid packdata with trailing garbage,
+	 * so appending garbage after we pass all the
+	 * pack data is not good enough to signal
+	 * breakage to downstream.
+	 */
+	ssize_t readsz;
+
+	readsz = xread(outfd, os->buffer + os->used,
+		       sizeof(os->buffer) - os->used);
+	if (readsz < 0) {
+		return readsz;
+	}
+	os->used += readsz;
+
+	if (os->used > 1) {
+		send_client_data(1, os->buffer, os->used - 1);
+		os->buffer[0] = os->buffer[os->used - 1];
+		os->used = 1;
+	} else {
+		send_client_data(1, os->buffer, os->used);
+		os->used = 0;
+	}
+
+	return readsz;
+}
+
 static void create_pack_file(const struct object_array *have_obj,
 			     const struct object_array *want_obj)
 {
 	struct child_process pack_objects = CHILD_PROCESS_INIT;
-	char data[8193], progress[128];
+	struct output_state output_state = {0};
+	char progress[128];
 	char abort_msg[] = "aborting due to possible repository "
 		"corruption on the remote side.";
-	int buffered = -1;
 	ssize_t sz;
 	int i;
 	FILE *pipe_fd;
@@ -237,39 +274,15 @@ static void create_pack_file(const struct object_array *have_obj,
 			continue;
 		}
 		if (0 <= pu && (pfd[pu].revents & (POLLIN|POLLHUP))) {
-			/* Data ready; we keep the last byte to ourselves
-			 * in case we detect broken rev-list, so that we
-			 * can leave the stream corrupted.  This is
-			 * unfortunate -- unpack-objects would happily
-			 * accept a valid packdata with trailing garbage,
-			 * so appending garbage after we pass all the
-			 * pack data is not good enough to signal
-			 * breakage to downstream.
-			 */
-			char *cp = data;
-			ssize_t outsz = 0;
-			if (0 <= buffered) {
-				*cp++ = buffered;
-				outsz++;
-			}
-			sz = xread(pack_objects.out, cp,
-				  sizeof(data) - outsz);
-			if (0 < sz)
-				;
-			else if (sz == 0) {
+			int result = read_pack_objects_stdout(pack_objects.out,
+							      &output_state);
+
+			if (result == 0) {
 				close(pack_objects.out);
 				pack_objects.out = -1;
-			}
-			else
+			} else if (result < 0) {
 				goto fail;
-			sz += outsz;
-			if (1 < sz) {
-				buffered = data[sz-1] & 0xFF;
-				sz--;
 			}
-			else
-				buffered = -1;
-			send_client_data(1, data, sz);
 		}
 
 		/*
@@ -294,9 +307,8 @@ static void create_pack_file(const struct object_array *have_obj,
 	}
 
 	/* flush the data */
-	if (0 <= buffered) {
-		data[0] = buffered;
-		send_client_data(1, data, 1);
+	if (output_state.used > 0) {
+		send_client_data(1, output_state.buffer, output_state.used);
 		fprintf(stderr, "flushed.\n");
 	}
 	if (use_sideband)
-- 
2.19.0.271.gfe8321ec05.dirty

