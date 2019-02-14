Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E63441F453
	for <e@80x24.org>; Thu, 14 Feb 2019 19:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438184AbfBNTHH (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 14:07:07 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:33267 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405535AbfBNTHH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 14:07:07 -0500
Received: by mail-qt1-f201.google.com with SMTP id k5so6663594qte.0
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 11:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vJYsToxEfOw9d2DfGrwa7y7mGOiNHNMjm/rGE2K76+E=;
        b=tKeaPOGYQAH1EjTtmqFqVGS6kZK4ChoKbeDEKkVfaJjCFnmqrKxWseJRsHqjMVmZXH
         GgA/UBwhe/ecKgv74o2cuKSqqeQSpcaJk6F2A41+yHfTvOY9qPlf+AlGWSBUiUw6c9t5
         KKsPAow53oqEBlfPXN5TKdurl5YlZPlT1lfVJDECjgxEGPzVG9FjgpH+4FJvlDe/7tAq
         WmnIHF6s0iLKVXPwQ/Fo45WSBMU7N/wdieQyD+Uy/P53b77yLsYqOWKm9pmW0ZwUKdBm
         XSijRrrNNx2DVe3Ciy/paQxLwfRgPIS8S2avf3686G6qEt4b60pnckev4tqHCHPMQM6O
         eZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vJYsToxEfOw9d2DfGrwa7y7mGOiNHNMjm/rGE2K76+E=;
        b=W2l+ugitymlY+Ft4el8EavzXV7KL0vgus2rPUWvJaPtxPU7cJiF2LqUHvKZhU+Ab7m
         bCCAj6VvcM9ZC6Cu6AKk7YvTiknLMCZmMB9S7l7wK/w8aj4FpuiU6D70hV7aB04Gy1VP
         IhXsNS+EMb63yQZBYL8bCqE0FMAhlXqNUS/MNh8FNOk6yvOcBDvvA48QYsa6WsSZowIY
         6C9Vmkqi+10026LqB4U8Q7wrNFmDoPNfZ3cbBYFNqx//hnneRHfd+ORmj04bcbvMeeo2
         R8zHpr35yHtrk+bk47zdxQrfYaiV6CAvm8lutOJELaEXX8sWYudUkjsBlVKhauSVrO/J
         Ho+A==
X-Gm-Message-State: AHQUAuYzW4f9yPuItVoXyIElC68GybOKLkJg8Wzkd8iivCMKJiSv9hQv
        tc6Z6RR660dSyAGyUhFhZBdFeDmfzaeZjFFHZpEOmoTHlpMlZpiYFZRYjK0v4qDMSClOFsS13zy
        6ERi0ybxOlNZpaun1TV25mNNIadCpNrgvOaaWOM/yBHwobnFHg013A22Fql9Argz3QcCgYWXDLm
        PP
X-Google-Smtp-Source: AHgI3IZcjLV0cRXiyDlHDM5OvfGZkuBXg/AEAHCusmA/Npj0DIFcjquwiblfk5MS7j1mEurC8nO42USthHA4uqN+jUEF
X-Received: by 2002:a0c:d486:: with SMTP id u6mr3045089qvh.56.1550171226042;
 Thu, 14 Feb 2019 11:07:06 -0800 (PST)
Date:   Thu, 14 Feb 2019 11:06:38 -0800
In-Reply-To: <cover.1550170980.git.jonathantanmy@google.com>
Message-Id: <2357bf6af7798e8e400599d47c89dc92ecd2eb8d.1550170980.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1550170980.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 4/5] remote-curl: refactor reading into rpc_state's buf
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, whenever remote-curl reads pkt-lines from its response file
descriptor, only the payload is written to its buf, not the 4 characters
denoting the length. A future patch will require the ability to also
write those 4 characters, so in preparation for that, refactor this read
into its own function.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 remote-curl.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 2eb39774d0..32c133f636 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -506,6 +506,25 @@ struct rpc_state {
 	unsigned initial_buffer : 1;
 };
 
+/*
+ * Appends the result of reading from rpc->out to the string represented by
+ * rpc->buf and rpc->len if there is enough space. Returns 1 if there was
+ * enough space, 0 otherwise.
+ *
+ * Writes the number of bytes appended into appended.
+ */
+static int rpc_read_from_out(struct rpc_state *rpc, size_t *appended) {
+	size_t left = rpc->alloc - rpc->len;
+	char *buf = rpc->buf + rpc->len;
+
+	if (left < LARGE_PACKET_MAX)
+		return 0;
+
+	*appended = packet_read(rpc->out, NULL, NULL, buf, left, 0);
+	rpc->len += *appended;
+	return 1;
+}
+
 static size_t rpc_out(void *ptr, size_t eltsize,
 		size_t nmemb, void *buffer_)
 {
@@ -515,11 +534,12 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 
 	if (!avail) {
 		rpc->initial_buffer = 0;
-		avail = packet_read(rpc->out, NULL, NULL, rpc->buf, rpc->alloc, 0);
+		rpc->len = 0;
+		if (!rpc_read_from_out(rpc, &avail))
+			BUG("The entire rpc->buf should be larger than LARGE_PACKET_MAX");
 		if (!avail)
 			return 0;
 		rpc->pos = 0;
-		rpc->len = avail;
 	}
 
 	if (max < avail)
@@ -663,20 +683,15 @@ static int post_rpc(struct rpc_state *rpc)
 	 * chunked encoding mess.
 	 */
 	while (1) {
-		size_t left = rpc->alloc - rpc->len;
-		char *buf = rpc->buf + rpc->len;
-		int n;
+		size_t n;
 
-		if (left < LARGE_PACKET_MAX) {
+		if (!rpc_read_from_out(rpc, &n)) {
 			large_request = 1;
 			use_gzip = 0;
 			break;
 		}
-
-		n = packet_read(rpc->out, NULL, NULL, buf, left, 0);
 		if (!n)
 			break;
-		rpc->len += n;
 	}
 
 	if (large_request) {
-- 
2.19.0.271.gfe8321ec05.dirty

