Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0F6C433DF
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E2C6206DC
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl9QFimL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbgFDRz3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730341AbgFDRzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 13:55:25 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3227EC08C5C1
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 10:55:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x14so7115834wrp.2
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 10:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0AvgNasTiy1kg7vtZwkKc8f2U7l1xPYOkExDxuqhIco=;
        b=nl9QFimL0OafwjvQAM0qeilk6Rl8lWKjPAIBPO7pvgvTkim/KRYIj4CGiYloQa3i/g
         /KE6huh3WVUdU+3eYyqq3Ng2Sy3sFPHoiekSfL1g+viSxGDVbc96Qyf98LEFSPAANBHr
         DmxwK32ISoI9uH/MoL9XwwzJUJuBk1cbAPqjFwT8HuG3vZibrqo8X4W/jPy+NhETx/lX
         SOsrZdIAMLLwxmlhJXp3ReaowoK476SjVh7Xs2NvS0V9FFyhM3QR3JMO1W8Kznqhmy8d
         UMOmMpiBPaQbq1o6nCf+RZo522YI8JqTJOu8XwD48kb25mOyJ3xG4gnJCHnBpgJC0rtl
         ZFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0AvgNasTiy1kg7vtZwkKc8f2U7l1xPYOkExDxuqhIco=;
        b=NK2RQobio1B3+ejliUsjCZL0xzRQAVoR4O0OnsUmLORmdILTHyZKlTKxO4znjSWUhg
         3xyCz+MaChBXs268uSVUU1TxkO7Y4AkgUK47Q3BV8a8wyY6ataxpyc7eVXzTKA5iH878
         GX4oX9AJCIiuj1FWVDBpKaHtvJNANgV0jz2yG00sC7BWfZl4gwIptIIJMRLayljaSLmO
         vaIXTYEEZsQP7dR9BpO8FF0B0dhejCwI9YwJpmxwQcdTJx/yqXqusgdPuMQb8VdBTxfC
         0/5B1/q1IReaG6SJU2hMhYLyJJLpLhXOIuftEUqkuuw8+JuTCpb5CEo/8yjb9zcNNmFS
         KDkg==
X-Gm-Message-State: AOAM530aR0quaTbUq5GWyjs8+Pt9mUuCR93fRsjdJmLvo/VUMgRffv6z
        68fCsh1FWmUIXEf1hJJ3adjdUV/aoH4=
X-Google-Smtp-Source: ABdhPJz66I16R/WIRYykpG95YoYdQzy1e5R4/mUO596hctTcLT5S8vQw/M1ezAXy63fxiIX07umtVA==
X-Received: by 2002:adf:9481:: with SMTP id 1mr5510756wrr.396.1591293323599;
        Thu, 04 Jun 2020 10:55:23 -0700 (PDT)
Received: from localhost.localdomain ([185.228.231.251])
        by smtp.gmail.com with ESMTPSA id s7sm9173540wrr.60.2020.06.04.10.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 10:55:23 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 13/13] upload-pack: move pack_objects_hook to upload_pack_data
Date:   Thu,  4 Jun 2020 19:54:50 +0200
Message-Id: <20200604175450.17385-14-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.rc0.26.gf2851482f5
In-Reply-To: <20200604175450.17385-1-chriscool@tuxfamily.org>
References: <20200602041657.7132-1-chriscool@tuxfamily.org>
 <20200604175450.17385-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, let's move the 'pack_objects_hook' static
variable into this struct.

It is used by code common to protocol v0 and protocol v2.

While at it let's also free() it in upload_pack_data_clear().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 78b10a89ea..bc7e3ca19d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -53,7 +53,6 @@ static timestamp_t oldest_have;
 static unsigned int allow_unadvertised_object_request;
 static int shallow_nr;
 static struct object_array extra_edge_obj;
-static const char *pack_objects_hook;
 
 /*
  * Please annotate, and if possible group together, fields used only
@@ -88,6 +87,8 @@ struct upload_pack_data {
 
 	struct packet_writer writer;
 
+	const char *pack_objects_hook;
+
 	unsigned stateless_rpc : 1;				/* v0 only */
 	unsigned no_done : 1;					/* v0 only */
 	unsigned daemon_mode : 1;				/* v0 only */
@@ -137,6 +138,8 @@ static void upload_pack_data_clear(struct upload_pack_data *data)
 	object_array_clear(&data->shallows);
 	string_list_clear(&data->deepen_not, 0);
 	list_objects_filter_release(&data->filter_options);
+
+	free((char *)data->pack_objects_hook);
 }
 
 static void reset_timeout(unsigned int timeout)
@@ -181,10 +184,10 @@ static void create_pack_file(struct upload_pack_data *pack_data)
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
@@ -1153,7 +1156,7 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 	if (current_config_scope() != CONFIG_SCOPE_LOCAL &&
 	current_config_scope() != CONFIG_SCOPE_WORKTREE) {
 		if (!strcmp("uploadpack.packobjectshook", var))
-			return git_config_string(&pack_objects_hook, var, value);
+			return git_config_string(&data->pack_objects_hook, var, value);
 	}
 
 	return parse_hide_refs_config(var, value, "uploadpack");
-- 
2.27.0.rc0.26.gf2851482f5

