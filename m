Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71552C433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 461C120760
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7Vbu7jS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgFKMFt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbgFKMFp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 08:05:45 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20005C08C5C3
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l26so4742456wme.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AjtFMT5xPjzuul5HDYktJ5Bp59qGVX8BGmNsrPxRMQE=;
        b=N7Vbu7jSvAhwpXH8zDSTRDhryLcSTgHryqq/5yP9ffIKjHBb1VHwo7E9/bZ6VlQVz9
         +DYHeMMwUiPPPUkxdCQBFfo++t4tSqDWQ0npK7Ubv6utkFQNMnMkGD4lFt9NUYupcTn8
         TM/2Z1q80PP0c+5zqTKg80GaGtZz4hu2/xSEQqxJav1j/dk+QpdXg12yMhaf5a8xenXV
         3sWl/tc0tIDARB4chZSRFqx+eDlh8v1okLbld2gZMwCzVKUPhz0+IZ+CcmgLv8lW16a0
         urt4KGjPkjLyUtmkB+30DI3CWe2XWTcaNxE5cGAvEb2+8OApdYBfXAgdWkeiq3rZOaCD
         Qqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AjtFMT5xPjzuul5HDYktJ5Bp59qGVX8BGmNsrPxRMQE=;
        b=k3BhXYkStQ8EwtPE1eWzVcTUQD5MN4NgVrm03tkd1hme0sRp6nNpQfQPSECIVPc2wz
         rf3i2E5gFYIp+H+WrguQ8AgAfdCkFqaJk1nmetlk5F7S/LtGVfLpdkmKB46GYrW/2HtW
         QQsjYRjVwUgpL56GdRSuZGr5ExpPTCKa2mp21K3FAYtQiOKlMMbmnpq3E9t6MSB7elim
         dkqp0o5IHTASSgf0nvUPOzRvgiP7afA7D7Tx6Vc0h/WTTgoQFNKNTqHznN2by/Niwboh
         rGWzO/ps8qAbJyLnCvu5i42MQ46ToUvx6VSzcurYXmQcCMQ1VQPp6P5R5l/K2pa6zG5P
         apYw==
X-Gm-Message-State: AOAM530/KCjR2eeFhGLOThXmwQKlMKdbob9QNwkvK3c1hn84eDxzqufI
        MUednZy4gubQYjE8oW4vPao019YwPL4=
X-Google-Smtp-Source: ABdhPJzADuteSlGCizjDKw/8h9/6P0ZuyKb8BS77Sx43YYOn+kT3XG5zYpq7ykljeVg8tSzoFEgB8g==
X-Received: by 2002:a1c:2d83:: with SMTP id t125mr8176293wmt.187.1591877142898;
        Thu, 11 Jun 2020 05:05:42 -0700 (PDT)
Received: from localhost.localdomain ([185.228.229.208])
        by smtp.gmail.com with ESMTPSA id o8sm4047174wmb.20.2020.06.11.05.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:05:42 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 07/14] upload-pack: move allow_unadvertised_object_request to upload_pack_data
Date:   Thu, 11 Jun 2020 14:05:11 +0200
Message-Id: <20200611120518.10771-8-chriscool@tuxfamily.org>
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
more thoroughly, let's move the 'allow_unadvertised_object_request'
static variable into this struct.

It is used by code common to protocol v0 and protocol v2.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 55 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index acddfe28d6..5cd1342f62 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -44,13 +44,13 @@
 
 static timestamp_t oldest_have;
 
+/* Values for allow_unadvertised_object_request flags */
 /* Allow specifying sha1 if it is a ref tip. */
 #define ALLOW_TIP_SHA1	01
 /* Allow request of a sha1 if it is reachable from a ref (possibly hidden ref). */
 #define ALLOW_REACHABLE_SHA1	02
 /* Allow request of any sha1. Implies ALLOW_TIP_SHA1 and ALLOW_REACHABLE_SHA1. */
 #define ALLOW_ANY_SHA1	07
-static unsigned int allow_unadvertised_object_request;
 
 /*
  * Please annotate, and if possible group together, fields used only
@@ -83,6 +83,9 @@ struct upload_pack_data {
 	/* 0 for no sideband, otherwise DEFAULT_PACKET_MAX or LARGE_PACKET_MAX */
 	int use_sideband;
 
+	/* See ALLOW_* values defined above */
+	unsigned int allow_unadvertised_object_request;
+
 	struct list_objects_filter_options filter_options;
 
 	struct packet_writer writer;
@@ -514,7 +517,8 @@ static int get_common_commits(struct upload_pack_data *data,
 	}
 }
 
-static int is_our_ref(struct object *o)
+static int is_our_ref(struct object *o,
+		      unsigned int allow_unadvertised_object_request)
 {
 	int allow_hidden_ref = (allow_unadvertised_object_request &
 			(ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));
@@ -526,7 +530,8 @@ static int is_our_ref(struct object *o)
  */
 static int do_reachable_revlist(struct child_process *cmd,
 				struct object_array *src,
-				struct object_array *reachable)
+				struct object_array *reachable,
+				unsigned int allow_unadvertised_object_request)
 {
 	static const char *argv[] = {
 		"rev-list", "--stdin", NULL,
@@ -560,7 +565,7 @@ static int do_reachable_revlist(struct child_process *cmd,
 			continue;
 		if (reachable && o->type == OBJ_COMMIT)
 			o->flags &= ~TMP_MARK;
-		if (!is_our_ref(o))
+		if (!is_our_ref(o, allow_unadvertised_object_request))
 			continue;
 		memcpy(namebuf + 1, oid_to_hex(&o->oid), hexsz);
 		if (write_in_full(cmd->in, namebuf, hexsz + 2) < 0)
@@ -569,7 +574,7 @@ static int do_reachable_revlist(struct child_process *cmd,
 	namebuf[hexsz] = '\n';
 	for (i = 0; i < src->nr; i++) {
 		o = src->objects[i].item;
-		if (is_our_ref(o)) {
+		if (is_our_ref(o, allow_unadvertised_object_request)) {
 			if (reachable)
 				add_object_array(o, NULL, reachable);
 			continue;
@@ -596,7 +601,7 @@ static int do_reachable_revlist(struct child_process *cmd,
 	return -1;
 }
 
-static int get_reachable_list(struct object_array *src,
+static int get_reachable_list(struct upload_pack_data *data,
 			      struct object_array *reachable)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -605,7 +610,8 @@ static int get_reachable_list(struct object_array *src,
 	char namebuf[GIT_MAX_HEXSZ + 2]; /* ^ + hash + LF */
 	const unsigned hexsz = the_hash_algo->hexsz;
 
-	if (do_reachable_revlist(&cmd, src, reachable) < 0)
+	if (do_reachable_revlist(&cmd, &data->shallows, reachable,
+				 data->allow_unadvertised_object_request) < 0)
 		return -1;
 
 	while ((i = read_in_full(cmd.out, namebuf, hexsz + 1)) == hexsz + 1) {
@@ -636,13 +642,15 @@ static int get_reachable_list(struct object_array *src,
 	return 0;
 }
 
-static int has_unreachable(struct object_array *src)
+static int has_unreachable(struct object_array *src,
+			   unsigned int allow_unadvertised_object_request)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	char buf[1];
 	int i;
 
-	if (do_reachable_revlist(&cmd, src, NULL) < 0)
+	if (do_reachable_revlist(&cmd, src, NULL,
+				 allow_unadvertised_object_request) < 0)
 		return 1;
 
 	/*
@@ -683,9 +691,10 @@ static void check_non_tip(struct upload_pack_data *data)
 	 * non-tip requests can never happen.
 	 */
 	if (!data->stateless_rpc
-	    && !(allow_unadvertised_object_request & ALLOW_REACHABLE_SHA1))
+	    && !(data->allow_unadvertised_object_request & ALLOW_REACHABLE_SHA1))
 		goto error;
-	if (!has_unreachable(&data->want_obj))
+	if (!has_unreachable(&data->want_obj,
+			     data->allow_unadvertised_object_request))
 		/* All the non-tip ones are ancestors of what we advertised */
 		return;
 
@@ -693,7 +702,7 @@ static void check_non_tip(struct upload_pack_data *data)
 	/* Pick one of them (we know there at least is one) */
 	for (i = 0; i < data->want_obj.nr; i++) {
 		struct object *o = data->want_obj.objects[i].item;
-		if (!is_our_ref(o)) {
+		if (!is_our_ref(o, data->allow_unadvertised_object_request)) {
 			packet_writer_error(&data->writer,
 					    "upload-pack: not our ref %s",
 					    oid_to_hex(&o->oid));
@@ -774,7 +783,7 @@ static void deepen(struct upload_pack_data *data, int depth)
 		head_ref_namespaced(check_ref, NULL);
 		for_each_namespaced_ref(check_ref, NULL);
 
-		get_reachable_list(&data->shallows, &reachable_shallows);
+		get_reachable_list(data, &reachable_shallows);
 		result = get_shallow_commits(&reachable_shallows,
 					     depth + 1,
 					     SHALLOW, NOT_SHALLOW);
@@ -992,8 +1001,8 @@ static void receive_needs(struct upload_pack_data *data,
 		}
 		if (!(o->flags & WANTED)) {
 			o->flags |= WANTED;
-			if (!((allow_unadvertised_object_request & ALLOW_ANY_SHA1) == ALLOW_ANY_SHA1
-			      || is_our_ref(o)))
+			if (!((data->allow_unadvertised_object_request & ALLOW_ANY_SHA1) == ALLOW_ANY_SHA1
+			      || is_our_ref(o, data->allow_unadvertised_object_request)))
 				has_non_tip = 1;
 			add_object_array(o, NULL, &data->want_obj);
 		}
@@ -1072,9 +1081,9 @@ static int send_ref(const char *refname, const struct object_id *oid,
 		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s agent=%s\n",
 			     oid_to_hex(oid), refname_nons,
 			     0, capabilities,
-			     (allow_unadvertised_object_request & ALLOW_TIP_SHA1) ?
+			     (data->allow_unadvertised_object_request & ALLOW_TIP_SHA1) ?
 				     " allow-tip-sha1-in-want" : "",
-			     (allow_unadvertised_object_request & ALLOW_REACHABLE_SHA1) ?
+			     (data->allow_unadvertised_object_request & ALLOW_REACHABLE_SHA1) ?
 				     " allow-reachable-sha1-in-want" : "",
 			     data->stateless_rpc ? " no-done" : "",
 			     symref_info.buf,
@@ -1112,19 +1121,19 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 
 	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
 		if (git_config_bool(var, value))
-			allow_unadvertised_object_request |= ALLOW_TIP_SHA1;
+			data->allow_unadvertised_object_request |= ALLOW_TIP_SHA1;
 		else
-			allow_unadvertised_object_request &= ~ALLOW_TIP_SHA1;
+			data->allow_unadvertised_object_request &= ~ALLOW_TIP_SHA1;
 	} else if (!strcmp("uploadpack.allowreachablesha1inwant", var)) {
 		if (git_config_bool(var, value))
-			allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
+			data->allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
 		else
-			allow_unadvertised_object_request &= ~ALLOW_REACHABLE_SHA1;
+			data->allow_unadvertised_object_request &= ~ALLOW_REACHABLE_SHA1;
 	} else if (!strcmp("uploadpack.allowanysha1inwant", var)) {
 		if (git_config_bool(var, value))
-			allow_unadvertised_object_request |= ALLOW_ANY_SHA1;
+			data->allow_unadvertised_object_request |= ALLOW_ANY_SHA1;
 		else
-			allow_unadvertised_object_request &= ~ALLOW_ANY_SHA1;
+			data->allow_unadvertised_object_request &= ~ALLOW_ANY_SHA1;
 	} else if (!strcmp("uploadpack.keepalive", var)) {
 		data->keepalive = git_config_int(var, value);
 		if (!data->keepalive)
-- 
2.27.0.90.gabb59f83a2

