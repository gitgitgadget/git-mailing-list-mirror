Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A948C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 670042071A
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkU68WE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgE0QsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 12:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387583AbgE0QsI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 12:48:08 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9565CC05BD1E
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:48:08 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so24763046wru.0
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nkG9ASB0F2f1N5uJN9mnbqQ/vFK2xlrVKb1Ou+cdgLQ=;
        b=QkU68WE1zIz3C9Z8yNyt02O9TQKza4yjEuqvWuthYCdSVOtBQqK8YCh5BD3Uc6vIwq
         L9VJnVNy/9MAB062A4axREagcm3jGZSMYVywcoyE4BEhVMaCTkeuhrAyaLJPuY4eAPsv
         2qyqmY5ohGp4I4hO7X64ORSLKoEQBbUOawzPmEfmCBxnCboHKo9XryaMjl3t9YIQCIf2
         ERLjytzD1n8mPKfWgh0hfmk6JeHojJYGfJNDObGqHySiqyP496AJVvDU7HYB2pQg7Z+w
         gH9ksclhHKi9Jnj+mbtVAj3fv6KJZf5ONf21G7qJ88GfRFHqOTlyJVkYVl6cJVAPchku
         p//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nkG9ASB0F2f1N5uJN9mnbqQ/vFK2xlrVKb1Ou+cdgLQ=;
        b=gpdNYABRhLeXV5QxQr5s1eJ0vkGwebZFlYTTXMbjDQmW9taDlX5/Sf/hHmE8iv0GCq
         3GxGVcw08w0MfUaSaCE4KhYsxyw4w2wlBsNAYbIfPKEOET5CFFNAs8b6advkHmQ86QGH
         fpr4r/QVd4XX7Ou+CqghWw9yAXcMa+tcZ8fenr2Tq/KeNEeDoncX+sjnbZkABf36JU53
         AukUznYtSebfTUAVhsYgOmZ3VsLkBesTWw1fnA0mfqtl7AKaWd557BkrkW/2KXMI6ZRp
         VW/ehDzDIk0jYolSmsDq7oX52YDx5UJiaQjTRxwoHjFPhY0yNMtJl/yuBe/QvgIU+hUM
         6n6A==
X-Gm-Message-State: AOAM532IQQiZqoRbS0WndHXNH8L+YxWZS1JMUeWCeeBJ10zn7RiQ7vPA
        wAtH4waIt5fiUWF4nK8dF2A7+JBr3dw=
X-Google-Smtp-Source: ABdhPJxeW92Hw4B9H6aYCk1lsVzbSKReenG727MLV3kDpjAK9guUZDV6Igusw7SKU1ShPC/lVA4D+g==
X-Received: by 2002:a05:6000:10cf:: with SMTP id b15mr24985312wrx.214.1590598087053;
        Wed, 27 May 2020 09:48:07 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.40])
        by smtp.gmail.com with ESMTPSA id d17sm2432852wrg.75.2020.05.27.09.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:48:06 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 08/12] upload-pack: move keepalive to upload_pack_data
Date:   Wed, 27 May 2020 18:47:38 +0200
Message-Id: <20200527164742.23067-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.rc2.38.gc6b4ed14d2.dirty
In-Reply-To: <20200527164742.23067-1-chriscool@tuxfamily.org>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200527164742.23067-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, let's move the 'keepalive' static variable
into this struct.

It is used by code common to protocol v0 and protocol v2.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 101e28f478..e00631a703 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -53,7 +53,6 @@ static timestamp_t oldest_have;
 static unsigned int allow_unadvertised_object_request;
 static int shallow_nr;
 static struct object_array extra_edge_obj;
-static int keepalive = 5;
 static const char *pack_objects_hook;
 
 static int allow_filter;
@@ -75,6 +74,7 @@ struct upload_pack_data {
 	int deepen_rev_list;
 	int deepen_relative;
 	int timeout;
+	int keepalive;
 
 	enum  {
 		no_multi_ack = 0,
@@ -120,6 +120,8 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	data->shallows = shallows;
 	data->deepen_not = deepen_not;
 	packet_writer_init(&data->writer, 1);
+
+	data->keepalive = 5;
 }
 
 static void upload_pack_data_clear(struct upload_pack_data *data)
@@ -248,7 +250,7 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 
 	while (1) {
 		struct pollfd pfd[2];
-		int pe, pu, pollsize;
+		int pe, pu, pollsize, polltimeout;
 		int ret;
 
 		reset_timeout(pack_data->timeout);
@@ -272,8 +274,11 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 		if (!pollsize)
 			break;
 
-		ret = poll(pfd, pollsize,
-			keepalive < 0 ? -1 : 1000 * keepalive);
+		polltimeout = pack_data->keepalive < 0
+			? -1
+			: 1000 * pack_data->keepalive;
+
+		ret = poll(pfd, pollsize, polltimeout);
 
 		if (ret < 0) {
 			if (errno != EINTR) {
@@ -1110,6 +1115,8 @@ static int find_symref(const char *refname, const struct object_id *oid,
 
 static int upload_pack_config(const char *var, const char *value, void *cb_data)
 {
+	struct upload_pack_data *data = cb_data;
+
 	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
 		if (git_config_bool(var, value))
 			allow_unadvertised_object_request |= ALLOW_TIP_SHA1;
@@ -1126,9 +1133,9 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 		else
 			allow_unadvertised_object_request &= ~ALLOW_ANY_SHA1;
 	} else if (!strcmp("uploadpack.keepalive", var)) {
-		keepalive = git_config_int(var, value);
-		if (!keepalive)
-			keepalive = -1;
+		data->keepalive = git_config_int(var, value);
+		if (!data->keepalive)
+			data->keepalive = -1;
 	} else if (!strcmp("uploadpack.allowfilter", var)) {
 		allow_filter = git_config_bool(var, value);
 	} else if (!strcmp("uploadpack.allowrefinwant", var)) {
-- 
2.27.0.rc2.38.gc6b4ed14d2.dirty

