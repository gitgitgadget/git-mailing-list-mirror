Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAF2C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 20:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88BD92074B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 20:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qDZfc5W0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgFJU5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbgFJU5j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 16:57:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5733AC03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 13:57:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n11so3886359ybg.15
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 13:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jlfHSgjj3kRXZq8HvIG/ErOeQQL8Csl72WJpTlfFGBg=;
        b=qDZfc5W0wPYojvS8CDT3iMriGrkKbXbt72NE8o4gTV5m7I0R/BPCVfdq0nn6o093iD
         c97dpcqjIW4uL5loofLYm/Tvkf+FRAkfFmyk3lTi2YrrkWDu8JTYCm6qJZDcpQcdweHz
         90LL9d3O4/PoXYUZMkHBdUf9Uzlisxju1DIf9nZZDmsCz926FzH15Rrj2ENP7ppAbkQ+
         zwe67/L9LKI6ySKirdj5z5j2fIlvw3OWUny+hZ66pWxqDyG4y2z4EFhIz3z0HXHkuVHv
         E61i9sm+8wEl1l4LbXyQ1RNHDs2uKrrg6a2cDHyhdbI+b9XmT2RpGwVt5PyANs1pOA2T
         lwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jlfHSgjj3kRXZq8HvIG/ErOeQQL8Csl72WJpTlfFGBg=;
        b=cNoZpaSHTnVqNbM0y+CwfKGvEFIIIh2fQoulLSfrJvHCHnbvRm1AWrLDnrVXZuFYmD
         1gSC2Rb2mZj1niZKabGzHcuDxl+9AFJ3NDrnE1IgZX+FCiEkJlPzYud9QNsv4WgjYzVp
         V1KSqD7b7NMCLGZvPWleaTxzcQTU7nSVpI8QgXot9NROeoHwmwZggTpz2H8KQ+3dBnMO
         MYuUYo4pX3uxneKvQLWU3Szo8neSue5HRduydVYP25Bo0R6Y8Ll5HeA1y9jmkMOuNScS
         vbwH+IyZQNeNvxohnqOPBAMfyIK79r/Gi8S6BD72ATlKbMkdMYWhSwaZwQSDYUBje0j3
         AOLQ==
X-Gm-Message-State: AOAM532YrHOHjPcZio1JGH15lZBeQ2QvC7KElcqoRUYpxV7742ASXUxJ
        1RGse0llaStSbJDIlxspnP+UKgpVtY45kqYdPN140akQCaN0FEJi9GDpJ7h2cKBM8oPppv3jyK7
        VEfUwBR6rbzSpSb8nh7usT9HwVW8i79qcayr0Wi8le11IGzzQW9m9lTS6rbkqFh2/ZVTLmW9vqw
        ur
X-Google-Smtp-Source: ABdhPJyOlaX1UYjeB+42REWpn/oYnWHK5j27OG06konyLL4w6IQBIJn8RA0ddyS9pVcWJzfkp/mCXemMHbvThf0pSPRc
X-Received: by 2002:a25:3c82:: with SMTP id j124mr7484568yba.89.1591822658511;
 Wed, 10 Jun 2020 13:57:38 -0700 (PDT)
Date:   Wed, 10 Jun 2020 13:57:21 -0700
In-Reply-To: <cover.1591821067.git.jonathantanmy@google.com>
Message-Id: <927ca4133cc0941bd3c16367347e9833feced0cd.1591821067.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1590789428.git.jonathantanmy@google.com> <cover.1591821067.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v2 7/9] upload-pack: refactor reading of pack-objects out
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
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
 upload-pack.c | 84 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 35 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index bc7e3ca19d..da1f749620 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -173,13 +173,52 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 	return 0;
 }
 
+struct output_state {
+	char buffer[8193];
+	int used;
+};
+
+static int relay_pack_data(int pack_objects_out, struct output_state *os,
+			   int use_sideband)
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
+		send_client_data(1, os->buffer, os->used - 1, use_sideband);
+		os->buffer[0] = os->buffer[os->used - 1];
+		os->used = 1;
+	} else {
+		send_client_data(1, os->buffer, os->used, use_sideband);
+		os->used = 0;
+	}
+
+	return readsz;
+}
+
 static void create_pack_file(struct upload_pack_data *pack_data)
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
@@ -312,40 +351,16 @@ static void create_pack_file(struct upload_pack_data *pack_data)
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
+						     &output_state,
+						     pack_data->use_sideband);
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
-			send_client_data(1, data, sz,
-					 pack_data->use_sideband);
 		}
 
 		/*
@@ -370,9 +385,8 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 	}
 
 	/* flush the data */
-	if (0 <= buffered) {
-		data[0] = buffered;
-		send_client_data(1, data, 1,
+	if (output_state.used > 0) {
+		send_client_data(1, output_state.buffer, output_state.used,
 				 pack_data->use_sideband);
 		fprintf(stderr, "flushed.\n");
 	}
-- 
2.27.0.278.ge193c7cf3a9-goog

