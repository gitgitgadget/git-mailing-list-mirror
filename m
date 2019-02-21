Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9EB21F453
	for <e@80x24.org>; Thu, 21 Feb 2019 20:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfBUUY4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 15:24:56 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:38746 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfBUUY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 15:24:56 -0500
Received: by mail-qk1-f202.google.com with SMTP id x63so6270080qka.5
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 12:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iwufZRvJNcjOpGS1qOmJlSkS9PhHEcvAOHrAj4YqHX4=;
        b=cvtpzhUl7mdSDMN5gRqq5IhXIsV6rhdPRiVeznhpSMVTxKdsTl9aMUh4X9qtEjXUkJ
         T5Gu4xF2d/i2XtsHCnKuIdV/wpRqYPDx6H7RZYjcXsM1TfSwsgWoFQ4tyxZelkYdJq+M
         iyWtpiM4jz49DY/qmCt1ecAwxH1W1dDbpBBvfLfmw49snYu6HnJU+LFxfCQhlnOBECL1
         pHCBEpCsc0otMDoGnqV7eyhbsJbw9BP6Ouws4HYSEedQzobWkkSzkOkN1iFinG1hGtYW
         /G5UDAe+3ue+8OnQsysJ+X3U/MnvXS9uKPBarUYj6BfO2BUs2A0nUEivoiBhIye9dnZd
         wjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iwufZRvJNcjOpGS1qOmJlSkS9PhHEcvAOHrAj4YqHX4=;
        b=a8OltT2IJ+9hlPkonektffH4L3pSGUspDdPLE/7IVWJZOI08ls3SKg5Th5OwlUUe7B
         s8viEvFn2KWje6KcVUK1RzmXJMEllv8HEQXutKu+bpFBzwKFJ+8YDttWPUo+jfqvdzaY
         gm8LIOwzmNz3FagMmkRMByHXm/Snb4xoUPWInqCMJ4l2c7wBnxX7jrGkNZXPpNRWyFMp
         ogw7AdiMa8Ou+zG7/Ga6LWT18b/rEYn//hhiJQMoPCbOzjCpVP6c6orCkAHfBpLq9zZ/
         JK8lzhjyOUAncaxTYmbrRDlhUYuosoJA0cv0JRQvlOavrbwqYX+U0eY2+/UvrqJSwCEb
         nrQw==
X-Gm-Message-State: AHQUAuZ5f7dJGHSzwrQTF7LIAHNZuwlOE1VzgdPuVU/MNmrLmlaOUvEB
        b5MG9V02Psw31LX12CsR2HTc6cTOlMbthYQSK7OpueNl6yj/s0/oXD5mgZC6Hy69QVgV4t7AWYB
        GmpvRaU966ccS11WaSg121KajiRl395CLml2CEXpC1Zj0ykNBL7M8JgaigJWNFqycjVfDAIs6DC
        qE
X-Google-Smtp-Source: AHgI3IbHHSUt+Tv32nep0IrkiUeUdO7kvqUtieYV2vhQM2QZVoADL1iHGP4/FTty0NCQf8EariF1MrUm5bXsIDklLM0N
X-Received: by 2002:ae9:f217:: with SMTP id m23mr237823qkg.5.1550780694895;
 Thu, 21 Feb 2019 12:24:54 -0800 (PST)
Date:   Thu, 21 Feb 2019 12:24:40 -0800
In-Reply-To: <cover.1550780213.git.jonathantanmy@google.com>
Message-Id: <2ecf63458740c631f0a1eb2acdfc877d7d06c278.1550780213.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1550170980.git.jonathantanmy@google.com> <cover.1550780213.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v2 4/5] remote-curl: refactor reading into rpc_state's buf
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
index 8e0e37ed3d..1f0161475d 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -520,6 +520,25 @@ struct rpc_state {
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
@@ -529,11 +548,12 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 
 	if (!avail) {
 		rpc->initial_buffer = 0;
-		avail = packet_read(rpc->out, NULL, NULL, rpc->buf, rpc->alloc, 0);
+		rpc->len = 0;
+		if (!rpc_read_from_out(rpc, &avail))
+			BUG("The entire rpc->buf should be larger than LARGE_PACKET_DATA_MAX");
 		if (!avail)
 			return 0;
 		rpc->pos = 0;
-		rpc->len = avail;
 	}
 
 	if (max < avail)
@@ -677,20 +697,15 @@ static int post_rpc(struct rpc_state *rpc)
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

