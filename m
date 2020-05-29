Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A053C433E1
	for <git@archiver.kernel.org>; Fri, 29 May 2020 22:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 378CB207BC
	for <git@archiver.kernel.org>; Fri, 29 May 2020 22:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IEdfEQUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgE2Wan (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 18:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbgE2Wal (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 18:30:41 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175A3C03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 15:30:40 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y2so3121950qkf.2
        for <git@vger.kernel.org>; Fri, 29 May 2020 15:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=a4bzFUaFdGp0H0bR41YlH9SDOh3PjiNdIlFPhBYrjSs=;
        b=IEdfEQUWvN7Osm6l2u8RGiyX8LPanCZ7ml7aC/FvT16NXvsfQHyfafxtL0g3psefp+
         sy5cjNQZALpyex5CFYUkn3g+3TXEdM0ZV5Q58bp0RJjnVYidlZqJsFLRf5ecBYJ9YriM
         i2Dsr4cMtHWGP2o9Agq/5uOvkLIhM9sUe1jLEuUGesMhLf7ACJN28cP+i63OxZi2/+Go
         9GqiRM49ATfZqLZQIWvNG9DAx3//Bu/Rwl09w3EaV3nh5ajVd26gOJ6Hqc7dkeVv/z4W
         EDfZbmG7S1KH9BmotFc8oIBkzNM/+TEawPPq/pQwZcmj7KnYg6sate8sq1K2YTjwoLuB
         a+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a4bzFUaFdGp0H0bR41YlH9SDOh3PjiNdIlFPhBYrjSs=;
        b=OFeXmtpNIwxDSWbvFe8kenZjbZJrwhydiq2IMeAS3gb5jVHG+FE0WIy162Y9HbtpbD
         BhkMMYWFr2iFZ5fs17Ja3wR6PW5YLuaLZFyXRN81P5L77jadqz2v0hzQexD07w4jP8Gx
         kpbFvY+kvkmbeKqFdDeq91Mq1MLJthGcgVFMt/wuPGvFHUUA9FG2wha1v12XedAgZp2a
         W5riJ/GCvu+oECFp0P31duMWzCnh8//wLoHeGfEuVfmy9W3m/nMGdn9zBtwTPMzjk7Bs
         r/pl5yH87AJuirKCOkZc6hjYpEKTA77dnd2/cPRQwoJQDz9Yoe5o5v5eSOGbd6laKH5R
         jr8g==
X-Gm-Message-State: AOAM533bVAJadfvJTchZc1gwoZ//5NL5CH7KL9q1USZxtjaGMypRdVc8
        7pGbp/B6U/g1o+P4/6hYpuLS3qlgmftSsEPPLja8VMf95ID3Xx4S6aqjVkRIEtOjpKt0sXYvHvC
        eRR7il3vVe4wTZp7ur+KyvwHGe1bnUEGU6h2I748oO40kn2zDEz62GlSDKSe6VpytntECX2Shjg
        ZH
X-Google-Smtp-Source: ABdhPJwVWPfFPoLWVWquJqJUJ5dWjoijzuq2K9O27Vnd3cwFQDEV3t9SrWOJeCP2Wspoaoog+XGIL3GVoZ4zPGofGTmf
X-Received: by 2002:a0c:8e84:: with SMTP id x4mr10819183qvb.175.1590791439176;
 Fri, 29 May 2020 15:30:39 -0700 (PDT)
Date:   Fri, 29 May 2020 15:30:18 -0700
In-Reply-To: <cover.1590789428.git.jonathantanmy@google.com>
Message-Id: <65db1a649d9b481b0122f981eee255907b7139bd.1590789428.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1590789428.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH 6/8] upload-pack: refactor reading of pack-objects out
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
 upload-pack.c | 81 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 34 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 0478bff3e7..13f6152560 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -102,15 +102,53 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
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
 			     const struct object_array *want_obj,
 			     struct list_objects_filter_options *filter_options)
 {
 	struct child_process pack_objects = CHILD_PROCESS_INIT;
-	char data[8193], progress[128];
+	struct output_state output_state = { { 0 } };
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
2.27.0.rc0.183.gde8f92d652-goog

