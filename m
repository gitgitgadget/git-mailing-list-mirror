Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE34C433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE9D2073E
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/FfoXH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgEOKFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 06:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbgEOKFV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 06:05:21 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E6AC061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:20 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id n5so2015574wmd.0
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pR80uivEZOrWUeo4orvhK4n9OcNxsnR4EAIxK7J3saU=;
        b=O/FfoXH1L94NT8uHTu6hnghd1fmQFL4+UHgOEM7/wF3xACAgme4WkZ+IxCS00Le4db
         OLHRvFbxYmp0hekp0AvaC7dNUr/OS6wj641qHscHaUUlLSmTq7qXl5XubD1R/L0nlCC8
         JDa1ofz2jWHo+tZI1NHxhs8PvotYOOuzEZPb7DG2YQayNdDAcQa5xV6L3IbvWnpOOn5v
         s2iW1skqmDM65JRJwoI5eW1fyWjqRN9nRvvz1PAlQM00X8R7d23fWzyNn4nWqJSIplf4
         OZTpVq9fpxjQ5T94H3lOUAatwV4g56908rmcXniXAuFw3mJ/TtBy1WklRxh+t3omjBAK
         LPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pR80uivEZOrWUeo4orvhK4n9OcNxsnR4EAIxK7J3saU=;
        b=OclBNjFV7MxcHDuB/sfFckQmznbzVC7LAkmuH4HaNc/LAb5kKKFdSnAXPgtrKa74at
         BapEfhN4QzJQ+EnclQPoYoxS+0d+G5SZWURSUlhb1d7/QO0WJc7SYkqC18fAIoal43t6
         f2741O3z9Hi06RNEoMH/PMhywFPQhzBbddAQIsNedXN9Lkg+xZ9mpwvNF9U+aH8PcaSd
         clJKjetiDdOp7S4eWNcbLS5Xtf6lMlTODqlX24gVxf7VPRJ1RNcvR/W9r7bVypO/iUs/
         2dlAAxtNPZdx8w/c3aIgCUcGiqlKUHp+q0QufXKoaDqODtXWlzVMbCTYMH+o66r+9579
         0wjw==
X-Gm-Message-State: AOAM530AVlAvPm1LNN4T2wWGuZhr+bNo1EGwa3mPZQy6Jb3vZ95Z98+3
        2M/TBbfh6zAF+vakaP+PEohjvAxtgyk=
X-Google-Smtp-Source: ABdhPJyHBxlZLLx2GWHVE2yNrkbCFA3UeZRGssSCu3Iwy8+C6FJm75rSmrPWjZUhVWpMXsfJdRU85A==
X-Received: by 2002:a7b:cf25:: with SMTP id m5mr3372531wmg.65.1589537119249;
        Fri, 15 May 2020 03:05:19 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.171])
        by smtp.gmail.com with ESMTPSA id m3sm2792326wrn.96.2020.05.15.03.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:05:18 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 08/13] upload-pack: move symref to upload_pack_data
Date:   Fri, 15 May 2020 12:04:49 +0200
Message-Id: <20200515100454.14486-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.26.2.639.gb7dde20fdf
In-Reply-To: <20200515100454.14486-1-chriscool@tuxfamily.org>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, we are passing around that struct to many
functions, so let's also pass 'struct string_list symref' around
at the same time by moving it from a local variable in
upload_pack() into a field of 'struct upload_pack_data'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 399ec60ade..c7e35a7fc9 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -73,6 +73,7 @@ static int allow_ref_in_want;
 static int allow_sideband_all;
 
 struct upload_pack_data {
+	struct string_list symref;
 	struct string_list wanted_refs;
 	struct object_array want_obj;
 	struct object_array have_obj;
@@ -100,6 +101,7 @@ struct upload_pack_data {
 
 static void upload_pack_data_init(struct upload_pack_data *data)
 {
+	struct string_list symref = STRING_LIST_INIT_DUP;
 	struct string_list wanted_refs = STRING_LIST_INIT_DUP;
 	struct object_array want_obj = OBJECT_ARRAY_INIT;
 	struct object_array have_obj = OBJECT_ARRAY_INIT;
@@ -108,6 +110,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
 
 	memset(data, 0, sizeof(*data));
+	data->symref = symref;
 	data->wanted_refs = wanted_refs;
 	data->want_obj = want_obj;
 	data->have_obj = have_obj;
@@ -119,6 +122,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 
 static void upload_pack_data_clear(struct upload_pack_data *data)
 {
+	string_list_clear(&data->symref, 1);
 	string_list_clear(&data->wanted_refs, 1);
 	object_array_clear(&data->want_obj);
 	object_array_clear(&data->have_obj);
@@ -1142,7 +1146,6 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 
 void upload_pack(struct upload_pack_options *options)
 {
-	struct string_list symref = STRING_LIST_INIT_DUP;
 	struct packet_reader reader;
 	struct upload_pack_data data;
 
@@ -1154,19 +1157,18 @@ void upload_pack(struct upload_pack_options *options)
 
 	upload_pack_data_init(&data);
 
-	head_ref_namespaced(find_symref, &symref);
+	head_ref_namespaced(find_symref, &data.symref);
 
 	if (options->advertise_refs || !stateless_rpc) {
 		reset_timeout();
-		head_ref_namespaced(send_ref, &symref);
-		for_each_namespaced_ref(send_ref, &symref);
+		head_ref_namespaced(send_ref, &data.symref);
+		for_each_namespaced_ref(send_ref, &data.symref);
 		advertise_shallow_grafts(1);
 		packet_flush(1);
 	} else {
 		head_ref_namespaced(check_ref, NULL);
 		for_each_namespaced_ref(check_ref, NULL);
 	}
-	string_list_clear(&symref, 1);
 
 	if (!options->advertise_refs) {
 		packet_reader_init(&reader, 0, NULL, 0,
-- 
2.26.2.638.gb2c16ea67b.dirty

