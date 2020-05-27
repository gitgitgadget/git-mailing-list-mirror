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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A3BC433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E89CF2071A
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZGMkokw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbgE0QsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 12:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbgE0QsO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 12:48:14 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B113AC08C5C1
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:48:13 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j10so9112779wrw.8
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SRsCxpsZBYpWwlFd7P2jlA08CC1Cq0Wbcebjv+yKgFE=;
        b=RZGMkokwbbeN8rTIWCmSIZDk7LxFIWFRwYG2zjmOc94r3CVds796HNVq/4S57VTLDg
         ebUpEPLoGNwyNH/bkaEbhWRIJSRspiuGZWC3X/yfmtZRhvouMYLfVDEluv7V884IrYr9
         AfVRh4ccdALKFJjsALcys4OYgJY4NOls1CwGwqYoRcG2IfkkVGvCJhxt/EK6te9w+ha0
         NCDEFUQJ84F5EgceNtm5phkINVIKjo57dSv5Jzb5jFYQ0ntfreSeVYsH0jVf6lwIlpIu
         u+JobKnGZLaz91m9OHBJM59d6LeScu5NXsiKEdk0GLWIOHUnvk6Q5uEq35c7vFwee2Yc
         yStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SRsCxpsZBYpWwlFd7P2jlA08CC1Cq0Wbcebjv+yKgFE=;
        b=f3/9xC0i+wZi38ATUJXqwpI9gxKPbB0o8XFeGWlhsBolmn6QHYMJbwwvTvnUvDXpHp
         qtLmAZfUlPjaTre1aFwoqwgYyqJV3r1Mb+7l4eOArZhpS6raumrwPFVaolrXLriSV2HN
         tfeBEBvrsRLXySoLlg1ZgVPLcUKwBpqR3QTxPm/K2UQ5HdXOXBQnLHm1h1chpAJ/BFZq
         25sOw968FFiXKlhSX91HPYYKH9eQIk1FfnxAsknk8x50/Q0nUqvhHB6hNCLsrg+OaNhg
         iMtXB3o+k1fQRl7hLE1bIQ9dWoBZX2aiXZHEC0F0iIVj9GiNW7UMwquFHLrg9K/EIGjh
         HmWw==
X-Gm-Message-State: AOAM5339CE/wbv9112G9JoishPQNwOG/tIJbxtNxigJ4V6IjI9GQjorq
        kPjdJVCbwM+7GFveLssmwFoXtZWUOhc=
X-Google-Smtp-Source: ABdhPJxURN3gNWrS90GzZ2cYUdT3IwUcxTqCqQBBtfRDrunE6FIlT3PPE/vvdbIyUcYUzWHlKXVXBw==
X-Received: by 2002:a5d:6541:: with SMTP id z1mr25529975wrv.264.1590598092206;
        Wed, 27 May 2020 09:48:12 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.40])
        by smtp.gmail.com with ESMTPSA id d17sm2432852wrg.75.2020.05.27.09.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:48:11 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 12/12] upload-pack: move pack_objects_hook to upload_pack_data
Date:   Wed, 27 May 2020 18:47:42 +0200
Message-Id: <20200527164742.23067-13-chriscool@tuxfamily.org>
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
more thoroughly, let's move the 'pack_objects_hook' static
variable into this struct.

It is used by code common to protocol v0 and protocol v2.

While at it let's also free() it in upload_pack_data_clear().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index becefd5bdc..3e9ae53e6c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -53,7 +53,6 @@ static timestamp_t oldest_have;
 static unsigned int allow_unadvertised_object_request;
 static int shallow_nr;
 static struct object_array extra_edge_obj;
-static const char *pack_objects_hook;
 
 struct upload_pack_data {
 	struct string_list symref;
@@ -84,6 +83,8 @@ struct upload_pack_data {
 
 	struct packet_writer writer;
 
+	const char *pack_objects_hook;
+
 	unsigned stateless_rpc : 1;
 	unsigned daemon_mode : 1;
 
@@ -133,6 +134,8 @@ static void upload_pack_data_clear(struct upload_pack_data *data)
 	object_array_clear(&data->shallows);
 	string_list_clear(&data->deepen_not, 0);
 	list_objects_filter_release(&data->filter_options);
+
+	free((char *)data->pack_objects_hook);
 }
 
 static void reset_timeout(int timeout)
@@ -177,10 +180,10 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 	int i;
 	FILE *pipe_fd;
 
-	if (!pack_objects_hook)
+	if (!pack_data->pack_objects_hook)
 		pack_objects.git_cmd = 1;
 	else {
-		argv_array_push(&pack_objects.args, pack_objects_hook);
+		argv_array_push(&pack_objects.args, pack_data->pack_objects_hook);
 		argv_array_push(&pack_objects.args, "git");
 		pack_objects.use_shell = 1;
 	}
@@ -1149,7 +1152,7 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 	if (current_config_scope() != CONFIG_SCOPE_LOCAL &&
 	current_config_scope() != CONFIG_SCOPE_WORKTREE) {
 		if (!strcmp("uploadpack.packobjectshook", var))
-			return git_config_string(&pack_objects_hook, var, value);
+			return git_config_string(&data->pack_objects_hook, var, value);
 	}
 
 	return parse_hide_refs_config(var, value, "uploadpack");
-- 
2.27.0.rc2.38.gc6b4ed14d2.dirty

