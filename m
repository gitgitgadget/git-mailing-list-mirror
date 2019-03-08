Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 117D920248
	for <e@80x24.org>; Fri,  8 Mar 2019 21:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfCHVzw (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 16:55:52 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:53631 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfCHVzv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 16:55:51 -0500
Received: by mail-pg1-f202.google.com with SMTP id k198so21696449pgc.20
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 13:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BMaM3xlxYxQ/4Gyyy/9KVL/EDXmthTjCwBkI0ZxCra0=;
        b=fWJJ24vgP/76z2GPTXT4ZUeTjkX2+2AhEXRJ4ca5bihimExaPlDWQrkgLJ+DcSJntl
         UIaHK/w0m1680N4C98MXqZi5MUbTZoIpeQanWNYy0DARqUBz8chFJ/vR5WgsCvHqIZMO
         g7kEINtl/c/lLbcZi+fnWjve4h5WtnjKrW+Axugwif9rhdwNy+A2H2dkCJjrTCqLl3kn
         CIXoojxNqZBCGcqE2ltXo00NheO/XZ0fqJAdeqE1wNzHdlc1qyKtRDmH6XBpCuqKsh1G
         G5VExrtkSHj60buCocaBlCdgiXraQ6NFlH+P7K08tb6KhbgBsiYFLh7ceVQ5tsmYzSRx
         hvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BMaM3xlxYxQ/4Gyyy/9KVL/EDXmthTjCwBkI0ZxCra0=;
        b=s1eqI3KGzes439xVcbXcH99Ewv7QcSnkWTnDWiXrjnC6Yj4ClEli6AxCBPSbK72ghO
         qHrOi85MVUMVQKqqGGsjEyPBtynMqPjt3y4QjtMyq7vnMlp2vMsoMJ/Dd3Ya++N288rH
         ahkbs2vEXZSBuI1jUNdAszAHY4h1KIrsuH3vLDEW7fHkP+DfhiZBJetbDbXqppZWEUmE
         H7DoeTHFcdMIcvfIsszwf2jksBVFB+avanAeAdZnwA625xugrIMwCTwd6ro38J9Dx609
         0AIVDBX3tLrB/W9KE+TBEIeuVgedwcwg2CDNHQwrKEE6cc7LY0agVVC3UswarKzxYeIJ
         9TGw==
X-Gm-Message-State: APjAAAWiS6TwCTjy47HDih1Z/9AHaQepvSh36Ct4XNJgY4sd1kqOkW65
        5zMfREsh08Dd0dIZwukZalibbxIb5oHskjYjJKJF
X-Google-Smtp-Source: APXvYqzTIjCcv/zau/tu6bVRWiDm0Hxse4WW/LTD1mUyvnRBcIjpWDWcO3Rbpjywohi6Tktye6vRjKDKXmlBEXANjdZQ
X-Received: by 2002:a63:f303:: with SMTP id l3mr7993506pgh.132.1552082150780;
 Fri, 08 Mar 2019 13:55:50 -0800 (PST)
Date:   Fri,  8 Mar 2019 13:55:18 -0800
In-Reply-To: <cover.1552073690.git.jonathantanmy@google.com>
Message-Id: <d487f46b0fe3ba32928b26c38af180edf1fa4f23.1552073690.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1550963965.git.jonathantanmy@google.com> <cover.1552073690.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v2 6/8] upload-pack: refactor reading of pack-objects out
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c | 81 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 34 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index d098ef5982..987d2e139b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -102,14 +102,52 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 	return 0;
 }
 
+struct output_state {
+	char buffer[8193];
+	int used;
+};
+
+static int relay_pack_data(int pack_objects_out, struct output_state *os)
+{
+	/*
+	 * We keep the last byte to ourselves
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
+	readsz = xread(pack_objects_out, os->buffer + os->used,
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
@@ -239,39 +277,15 @@ static void create_pack_file(const struct object_array *have_obj,
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
+			int result = relay_pack_data(pack_objects.out,
+						     &output_state);
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
@@ -296,9 +310,8 @@ static void create_pack_file(const struct object_array *have_obj,
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

