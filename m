Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA3EC433F5
	for <git@archiver.kernel.org>; Mon,  2 May 2022 17:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386562AbiEBRNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 13:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386556AbiEBRNc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 13:13:32 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7615F55
        for <git@vger.kernel.org>; Mon,  2 May 2022 10:10:03 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 15-20020aa7920f000000b0050cf449957fso8335730pfo.9
        for <git@vger.kernel.org>; Mon, 02 May 2022 10:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=E8Ra9hXify+H+FfVI+GyGahKHJm8UfQuVYMQkEJVd3s=;
        b=IVRbrDefF53GfBWEEmcpBVkbnn3JGxt+8mEXAAWgSut7BYOTb0iT3putgApDHV8VQm
         7dVozJM0WXFfol1BtiMOY7V/rriCo+y4NllE9iJKDCHB5fCKRCjkXMC33HpkoSeLw6h9
         uEMaWDfNtdTuTpppBat7z94IzfCZ4+DCEiuyvqmXZFKQepRQgJkxm1WJCmQoCgTk1dEQ
         7Oo5f+OEuL9S/OrM5R27UHVpaaY0tZDgp/7MZxxJnU+odHx68TBTfLBBvgNB25WqFPVg
         +VtcnNnaRZ9CRj23AVNCtmK15gx2MStR658WF/YlR5fHgkcmhPoGbCkyPkIt8EvrVmJ9
         dcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E8Ra9hXify+H+FfVI+GyGahKHJm8UfQuVYMQkEJVd3s=;
        b=jp627i/laQnvpZWTtxuk78ARnZpPNdp3IKW/w50PkmNDzUvfUBCbCRqOF9Lo/+psEa
         7E6FWsv5HJdqIOMvs/XYl86vKcpbFM/qTLl7tfXANmQ6PE1bLiiQbK87F498jDT6Ost5
         gfVJMRU0T16ZkM7E4LDdhRTZjFJ2nEg7eySsvuYAgTa+gUBa5FCqq7FQcfo19SBASZtb
         oy7GuT20BA9z96aOcpUZAsel45AfSO4WFi+T6q9wDr/hq5ZtygMJDUCXgpgZaZxHtrHS
         bq6/+qMh/pLOBVZQCzHodz37xgKvX6jkX49tL30ACc1QFEQF0A0+26YbmH+P6nUqW4jz
         Gn2g==
X-Gm-Message-State: AOAM5311t3/lObxQL9QCGP4ffYrwkKmgf9R44VAaw28z1ltKfzKnnWqC
        /dkk7gb/pK+aM4q9y94qS7nPi7Makerjx4vzJlIb+YM0jJ+K44xkCJ/6Q80DLm16QwliogtSg6c
        1C/r6Hi9KtsgzMg+vckhl6vrhUadYJjF/B26FRoKO9mW0CWPbarzuqha8cjIKLZqpTg==
X-Google-Smtp-Source: ABdhPJyJCNfF1ldn3c1z7rR8I+KIdjB3M9YkWSJOnkAwuj32Ce9U5RYuOfFPS+F1ASsKSm0w0yonPfUSd7w5plk=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:e8e:b0:4fa:a52f:59cf with SMTP
 id bo14-20020a056a000e8e00b004faa52f59cfmr12380294pfb.84.1651511402943; Mon,
 02 May 2022 10:10:02 -0700 (PDT)
Date:   Mon,  2 May 2022 17:09:00 +0000
In-Reply-To: <20220502170904.2770649-1-calvinwan@google.com>
Message-Id: <20220502170904.2770649-5-calvinwan@google.com>
Mime-Version: 1.0
References: <20220328191112.3092139-1-calvinwan@google.com> <20220502170904.2770649-1-calvinwan@google.com>
X-Mailer: git-send-email 2.36.0.rc2.10170.gb555eefa6f
Subject: [PATCH v4 4/8] object-info: send attribute packet regardless of
 object ids
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com, calvinwan@google.com,
        me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently on the server side of object-info, if the client does not send
any object ids in the request or if the client requests an attribute the
server does not support, the server will either not send any packets
back or error out. Consider the scenario where the client git version is
ahead of the server git version, and the client can request additional
object-info besides 'size'. There needs to be a way to tell whether the
server can honor all of the client attribute requests before the client
sends a request with all of the object ids.  In a future patch, if the
client were to make an initial command request with only attributes, the
server would be able to confirm which attributes it could return.

---
 protocol-caps.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/protocol-caps.c b/protocol-caps.c
index bbde91810a..bc7def0727 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -11,6 +11,7 @@
 
 struct requested_info {
 	unsigned size : 1;
+	unsigned unknown : 1;
 };
 
 /*
@@ -40,12 +41,12 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 	struct string_list_item *item;
 	struct strbuf send_buffer = STRBUF_INIT;
 
-	if (!oid_str_list->nr)
-		return;
-
 	if (info->size)
 		packet_writer_write(writer, "size");
 
+	if (info->unknown || !oid_str_list->nr)
+		goto release;
+
 	for_each_string_list_item (item, oid_str_list) {
 		const char *oid_str = item->string;
 		struct object_id oid;
@@ -72,12 +73,13 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 		packet_writer_write(writer, "%s", send_buffer.buf);
 		strbuf_reset(&send_buffer);
 	}
+release:
 	strbuf_release(&send_buffer);
 }
 
 int cap_object_info(struct repository *r, struct packet_reader *request)
 {
-	struct requested_info info;
+	struct requested_info info = { 0 };
 	struct packet_writer writer;
 	struct string_list oid_str_list = STRING_LIST_INIT_DUP;
 
@@ -92,9 +94,7 @@ int cap_object_info(struct repository *r, struct packet_reader *request)
 		if (parse_oid(request->line, &oid_str_list))
 			continue;
 
-		packet_writer_error(&writer,
-				    "object-info: unexpected line: '%s'",
-				    request->line);
+		info.unknown = 1;
 	}
 
 	if (request->status != PACKET_READ_FLUSH) {
-- 
2.36.0.rc2.10170.gb555eefa6f

