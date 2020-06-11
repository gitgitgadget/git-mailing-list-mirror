Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118A7C433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E135220760
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCe0mPJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgFKMF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbgFKMFt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 08:05:49 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BC5C08C5C2
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:49 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c3so5856494wru.12
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VVL+VZ9daRjfPSOUsTO3BXrEhhb/3hvEgqsE2NY9l+w=;
        b=GCe0mPJwhjLMFVOMVjKZJ+WIYLlCBgKUUzcfu9DAG+oCPTwI7qUivse+z0eMPlUmBa
         TwJ2NKfXxUgxb0L1UiZS6AZaNshkZEf1RfXb6EKBLHvPzdM+dIHEMSaJ94uZ0FomIKj4
         wXtp2G58mzwoq3YPOJD8fw75bGUGikiczHQy8Igrx+hAe+HOPALyN/YRBkFU8BsZUgRn
         Uk6TCDTNg1cal4ACixWPPsu4Tuyb+W5hBHxi1iY3fiLrNvnDDILk9rqL54B/UpUzPBgo
         IXINDjpwznkXWRM8Z/t2Kz2dAPRiK43PRLcLp2yVMGHM6r+ha8NJ6TL4YOuM4sZ9JZoA
         Il5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VVL+VZ9daRjfPSOUsTO3BXrEhhb/3hvEgqsE2NY9l+w=;
        b=t9f7KnFJlP/huTDk7L1hxCMUXV7Kc5E5kvUjKnaoVXFajH0H2S+ObdL3aTy23CZUTX
         cghsu5M8/E+fCh5y/GtDPu5NeJVYG5YydLhyknNInHjBL9K5r10ZSqg7QvQDFAGLC8xk
         PBUbqxubKA7dvJ+AepXBPHWaiTyXt46l+vK/mGnRpqp/baCtgVYf7XhvVdq+WJUAg2qA
         MEO5a+UQxm0Aae7Kte+F2MyHeH3VKF7hzBrluRCTt59KW6Lip1bMCzAtzMzlhvd4U616
         Yu7gbIeW3FoJM7ycjuqSh07+tqdsNgX3BBcY7sMdT0+VqhbIkaMc3qUuwdeH39yEQfw3
         iarw==
X-Gm-Message-State: AOAM533gKHIMf0XBfp/uk4flHhgqugC3uQko5gtauPsbLXPJmbTh+h/n
        Lgf4+OOl+JcSdm+i7dOtwY7GiJejNis=
X-Google-Smtp-Source: ABdhPJxQEkAhkvZUOUssJyAd3cScHCVTmdSjYXYh1qDInsUlp2rX0rz2k7N7fImJeZ0E8X8fKhHePw==
X-Received: by 2002:adf:fec8:: with SMTP id q8mr9587464wrs.2.1591877147751;
        Thu, 11 Jun 2020 05:05:47 -0700 (PDT)
Received: from localhost.localdomain ([185.228.229.208])
        by smtp.gmail.com with ESMTPSA id o8sm4047174wmb.20.2020.06.11.05.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:05:47 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 10/14] upload-pack: pass upload_pack_data to send_acks()
Date:   Thu, 11 Jun 2020 14:05:14 +0200
Message-Id: <20200611120518.10771-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.90.gabb59f83a2
In-Reply-To: <20200611120518.10771-1-chriscool@tuxfamily.org>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200611120518.10771-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, let's pass that struct to send_acks(), so
that this function can use all the fields of the struct.

This will be used in followup commits to move a static variable
into 'upload_pack_data'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index b20600fceb..0523feaac2 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1387,26 +1387,24 @@ static int process_haves(struct upload_pack_data *data, struct oid_array *common
 	return 0;
 }
 
-static int send_acks(struct packet_writer *writer, struct oid_array *acks,
-		     const struct object_array *have_obj,
-		     struct object_array *want_obj)
+static int send_acks(struct upload_pack_data *data, struct oid_array *acks)
 {
 	int i;
 
-	packet_writer_write(writer, "acknowledgments\n");
+	packet_writer_write(&data->writer, "acknowledgments\n");
 
 	/* Send Acks */
 	if (!acks->nr)
-		packet_writer_write(writer, "NAK\n");
+		packet_writer_write(&data->writer, "NAK\n");
 
 	for (i = 0; i < acks->nr; i++) {
-		packet_writer_write(writer, "ACK %s\n",
+		packet_writer_write(&data->writer, "ACK %s\n",
 				    oid_to_hex(&acks->oid[i]));
 	}
 
-	if (ok_to_give_up(have_obj, want_obj)) {
+	if (ok_to_give_up(&data->have_obj, &data->want_obj)) {
 		/* Send Ready */
-		packet_writer_write(writer, "ready\n");
+		packet_writer_write(&data->writer, "ready\n");
 		return 1;
 	}
 
@@ -1421,8 +1419,7 @@ static int process_haves_and_send_acks(struct upload_pack_data *data)
 	process_haves(data, &common);
 	if (data->done) {
 		ret = 1;
-	} else if (send_acks(&data->writer, &common,
-			     &data->have_obj, &data->want_obj)) {
+	} else if (send_acks(data, &common)) {
 		packet_writer_delim(&data->writer);
 		ret = 1;
 	} else {
-- 
2.27.0.90.gabb59f83a2

