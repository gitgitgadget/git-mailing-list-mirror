Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4752D211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 23:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbeLCXhw (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 18:37:52 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:43377 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeLCXhv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 18:37:51 -0500
Received: by mail-it1-f201.google.com with SMTP id 128so5531464itw.8
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 15:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q75k8oHP/P+PZ7h+Wn/kvgU2W+N4gR3oumZ6U473kyw=;
        b=V6HsUj3/aDo6n7OCajjQazMsaMsPh04NO8HJxs6ed4cNLpHao/UOvdcvPQClhQbpu6
         9gLrkRNb9mUU+MD32nntFNNQ3vLKWTwDOw9hDpcTKY3CvJq6+Qs+4Xr8u/zmO/N9MyJW
         qXYJobXbj+2cENmENC9nFksYH+0fIjApv1ZnQz8vGwLcswKH6thbvNVzQWP+KbAzPxZP
         2plhMwehO7zLoqaV/zCDDeORakp4MwqdvtI8+ADQEV1VF2MJpDKGFfEI5y0ZbOcZCnG8
         auM5oFoaHehFDG0/50af7XK146JtPLFyRcSgYzo6EGgDbwIgsU4FKikSWE05o0NSjM1d
         5law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q75k8oHP/P+PZ7h+Wn/kvgU2W+N4gR3oumZ6U473kyw=;
        b=GdhW1zkwuUXG1Bxv5OWmYsgHk5hYxIiR4bXT96NIN/Dxz0YRZeWQB1KXgtE73ewkdR
         BkLx13WEc3CmAb2sn31IWE/E5TZgFTx2gU8rlMkKzNlnomWtonRKLSkSMpfvrJ+keCdl
         NV1+IsZs19FAHzmCViiDXG2+d6nPjOtPrXhXq4LKYQgzGMqd3YJyyLDwLto/jwLQza0S
         BgszfDIKtQwmRhr+xEwAkaEKNCcvz9JFG7N2Ip+RhpJH2jwBgY66262ANbAY+0lNomwz
         y6ByCdWC7eXozIAzyuIX8J0ssIZxFxphN9mvu1vQYjaBBTyQxWgdIj9z1SpGvM7dA4sH
         NKEw==
X-Gm-Message-State: AA+aEWZxOKOjUeZi5M8Z7ul0h//Hus3w3nvGptdghwiDJ2mC68XWBQQ6
        1uMKmR8NFqe2tqCLvpI7wRlaEPSKypCvAifiFDnxbXFOfPOHudPZEucXsplAG00wS9i/UlfTwZ0
        juTuskZIPzKoA5vm9YtB5Uy7r8tal4TPscpZI8W6NHQIT5uwDNM14IUnuacuE0g1nMbIqAO22QO
        Yp
X-Google-Smtp-Source: AFSGD/WWUQiEYbgtS2r/6AuEeKTOAW0nFt/M9S8S2hC9f1Xo1CMeVbt4CCACC/iE7NAI+XslCuW+iG+ayTO8kapT8RKD
X-Received: by 2002:a24:16d3:: with SMTP id a202mr8229288ita.21.1543880270540;
 Mon, 03 Dec 2018 15:37:50 -0800 (PST)
Date:   Mon,  3 Dec 2018 15:37:36 -0800
In-Reply-To: <cover.1543879256.git.jonathantanmy@google.com>
Message-Id: <e19f294df9ff999d30a47339a7848c7104bfae7d.1543879256.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1543879256.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP RFC 3/5] upload-pack: refactor reading of pack-objects out
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
index 5e81f1ff24..cec43e0a46 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -101,14 +101,51 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
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
@@ -235,39 +272,15 @@ static void create_pack_file(const struct object_array *have_obj,
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
@@ -292,9 +305,8 @@ static void create_pack_file(const struct object_array *have_obj,
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

