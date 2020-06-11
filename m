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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7686AC433E1
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F622078D
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roY1HaEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgFKMFu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgFKMFr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 08:05:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E372C08C5C1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:46 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e1so5888529wrt.5
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XVwia3sigb5Wo8L5lvGQ0V2KBptthOaQFfQdxux7OHc=;
        b=roY1HaEiMNddhl3A4kxVtel3czQ0dhLg1pisU4/Njyv7eHEjJSvJlr1tl9WSxFdGvu
         np6CAyAcy9LQE3IRO5WKGrZc/B4axf1EUR1zgDROL1jXbbMSCj6BOXUCVvB6mM/cl6y0
         75YGnKTp5qGWWzFy+q7SUDgw+HgQ+nRDGt7pmJGBOvyUs1vaBdkc1TQ3zJ4RvRLM1ryB
         d9GMvPki3SXEk7xm/rA7NGAaU2ZBKSPqFdZNk/nG1KmLMX1BPUBAuLo1/51r8z21zUGT
         qD1yDGjzyYpOCi4TTKJziqSzqsdb57aW/MbeKXGk47icE9QXgo/HSAuFKQOv2S+mGmW2
         mC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XVwia3sigb5Wo8L5lvGQ0V2KBptthOaQFfQdxux7OHc=;
        b=PdbRaMbTsNHZ/1Xx2003zH/BSUJiXgXauTN/ntGpcpM7L0KzRFiu8CpERuOp6a8nxd
         Br2wo1U8bRvny0JjFNYsF4oLY3RXwTLgAWmYhcFyzcXNCl//EhIK+l1mHwFideHIbY7p
         1uUZSLWnYEFHUpL+rx3FfB+E5nGtyCXHvva+H3idu6vHdPs0z0AvRyhsj3mfd31bNBbm
         A0ctGsPPJ5VfQUn9Sh78BfUnnxb2BkjXQoi5Ey5wIwGZcgJa63M98FSYPOwLeqFeE1LN
         FcQAT+Fy75fmk0qowQ+haL1IZ4BHzrChFC1aqhtHBEAJRcq0HSx7yZMJ6lBC5r8it9Y2
         dfHw==
X-Gm-Message-State: AOAM5317AYs49OEdXfiYlzSHBrwJYFmwTtlPF0H4SyZVFAf1b1dPGttH
        yZS47Ao1wtXbuwyAfzW3ef582UKLYTI=
X-Google-Smtp-Source: ABdhPJxuwXZbBMXodf1bZBsxX9qPC9bDDWmVWcYqSs6L4t0bjPP1GSE29KHnaU64mIZ5905Ni7mLlw==
X-Received: by 2002:a5d:5006:: with SMTP id e6mr9713181wrt.170.1591877144607;
        Thu, 11 Jun 2020 05:05:44 -0700 (PDT)
Received: from localhost.localdomain ([185.228.229.208])
        by smtp.gmail.com with ESMTPSA id o8sm4047174wmb.20.2020.06.11.05.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:05:43 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 08/14] upload-pack: change allow_unadvertised_object_request to an enum
Date:   Thu, 11 Jun 2020 14:05:12 +0200
Message-Id: <20200611120518.10771-9-chriscool@tuxfamily.org>
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
more thoroughly, let's change allow_unadvertised_object_request,
which is now part of 'upload_pack_data', from an 'unsigned int'
to an enum.

This will make it clear which values this variable can take.

While at it let's change this variable name to 'allow_uor' to
make it shorter.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 68 ++++++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 36 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 5cd1342f62..0b30794d91 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -44,13 +44,15 @@
 
 static timestamp_t oldest_have;
 
-/* Values for allow_unadvertised_object_request flags */
-/* Allow specifying sha1 if it is a ref tip. */
-#define ALLOW_TIP_SHA1	01
-/* Allow request of a sha1 if it is reachable from a ref (possibly hidden ref). */
-#define ALLOW_REACHABLE_SHA1	02
-/* Allow request of any sha1. Implies ALLOW_TIP_SHA1 and ALLOW_REACHABLE_SHA1. */
-#define ALLOW_ANY_SHA1	07
+/* Enum for allowed unadvertised object request (UOR) */
+enum allow_uor {
+	/* Allow specifying sha1 if it is a ref tip. */
+	ALLOW_TIP_SHA1 = 0x01,
+	/* Allow request of a sha1 if it is reachable from a ref (possibly hidden ref). */
+	ALLOW_REACHABLE_SHA1 = 0x02,
+	/* Allow request of any sha1. Implies ALLOW_TIP_SHA1 and ALLOW_REACHABLE_SHA1. */
+	ALLOW_ANY_SHA1 = 0x07
+};
 
 /*
  * Please annotate, and if possible group together, fields used only
@@ -83,8 +85,7 @@ struct upload_pack_data {
 	/* 0 for no sideband, otherwise DEFAULT_PACKET_MAX or LARGE_PACKET_MAX */
 	int use_sideband;
 
-	/* See ALLOW_* values defined above */
-	unsigned int allow_unadvertised_object_request;
+	enum allow_uor allow_uor;
 
 	struct list_objects_filter_options filter_options;
 
@@ -517,11 +518,10 @@ static int get_common_commits(struct upload_pack_data *data,
 	}
 }
 
-static int is_our_ref(struct object *o,
-		      unsigned int allow_unadvertised_object_request)
+static int is_our_ref(struct object *o, enum allow_uor allow_uor)
 {
-	int allow_hidden_ref = (allow_unadvertised_object_request &
-			(ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));
+	int allow_hidden_ref = (allow_uor &
+				(ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));
 	return o->flags & ((allow_hidden_ref ? HIDDEN_REF : 0) | OUR_REF);
 }
 
@@ -531,7 +531,7 @@ static int is_our_ref(struct object *o,
 static int do_reachable_revlist(struct child_process *cmd,
 				struct object_array *src,
 				struct object_array *reachable,
-				unsigned int allow_unadvertised_object_request)
+				enum allow_uor allow_uor)
 {
 	static const char *argv[] = {
 		"rev-list", "--stdin", NULL,
@@ -565,7 +565,7 @@ static int do_reachable_revlist(struct child_process *cmd,
 			continue;
 		if (reachable && o->type == OBJ_COMMIT)
 			o->flags &= ~TMP_MARK;
-		if (!is_our_ref(o, allow_unadvertised_object_request))
+		if (!is_our_ref(o, allow_uor))
 			continue;
 		memcpy(namebuf + 1, oid_to_hex(&o->oid), hexsz);
 		if (write_in_full(cmd->in, namebuf, hexsz + 2) < 0)
@@ -574,7 +574,7 @@ static int do_reachable_revlist(struct child_process *cmd,
 	namebuf[hexsz] = '\n';
 	for (i = 0; i < src->nr; i++) {
 		o = src->objects[i].item;
-		if (is_our_ref(o, allow_unadvertised_object_request)) {
+		if (is_our_ref(o, allow_uor)) {
 			if (reachable)
 				add_object_array(o, NULL, reachable);
 			continue;
@@ -611,7 +611,7 @@ static int get_reachable_list(struct upload_pack_data *data,
 	const unsigned hexsz = the_hash_algo->hexsz;
 
 	if (do_reachable_revlist(&cmd, &data->shallows, reachable,
-				 data->allow_unadvertised_object_request) < 0)
+				 data->allow_uor) < 0)
 		return -1;
 
 	while ((i = read_in_full(cmd.out, namebuf, hexsz + 1)) == hexsz + 1) {
@@ -642,15 +642,13 @@ static int get_reachable_list(struct upload_pack_data *data,
 	return 0;
 }
 
-static int has_unreachable(struct object_array *src,
-			   unsigned int allow_unadvertised_object_request)
+static int has_unreachable(struct object_array *src, enum allow_uor allow_uor)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	char buf[1];
 	int i;
 
-	if (do_reachable_revlist(&cmd, src, NULL,
-				 allow_unadvertised_object_request) < 0)
+	if (do_reachable_revlist(&cmd, src, NULL, allow_uor) < 0)
 		return 1;
 
 	/*
@@ -690,11 +688,9 @@ static void check_non_tip(struct upload_pack_data *data)
 	 * uploadpack.allowReachableSHA1InWant,
 	 * non-tip requests can never happen.
 	 */
-	if (!data->stateless_rpc
-	    && !(data->allow_unadvertised_object_request & ALLOW_REACHABLE_SHA1))
+	if (!data->stateless_rpc && !(data->allow_uor & ALLOW_REACHABLE_SHA1))
 		goto error;
-	if (!has_unreachable(&data->want_obj,
-			     data->allow_unadvertised_object_request))
+	if (!has_unreachable(&data->want_obj, data->allow_uor))
 		/* All the non-tip ones are ancestors of what we advertised */
 		return;
 
@@ -702,7 +698,7 @@ static void check_non_tip(struct upload_pack_data *data)
 	/* Pick one of them (we know there at least is one) */
 	for (i = 0; i < data->want_obj.nr; i++) {
 		struct object *o = data->want_obj.objects[i].item;
-		if (!is_our_ref(o, data->allow_unadvertised_object_request)) {
+		if (!is_our_ref(o, data->allow_uor)) {
 			packet_writer_error(&data->writer,
 					    "upload-pack: not our ref %s",
 					    oid_to_hex(&o->oid));
@@ -1001,8 +997,8 @@ static void receive_needs(struct upload_pack_data *data,
 		}
 		if (!(o->flags & WANTED)) {
 			o->flags |= WANTED;
-			if (!((data->allow_unadvertised_object_request & ALLOW_ANY_SHA1) == ALLOW_ANY_SHA1
-			      || is_our_ref(o, data->allow_unadvertised_object_request)))
+			if (!((data->allow_uor & ALLOW_ANY_SHA1) == ALLOW_ANY_SHA1
+			      || is_our_ref(o, data->allow_uor)))
 				has_non_tip = 1;
 			add_object_array(o, NULL, &data->want_obj);
 		}
@@ -1081,9 +1077,9 @@ static int send_ref(const char *refname, const struct object_id *oid,
 		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s agent=%s\n",
 			     oid_to_hex(oid), refname_nons,
 			     0, capabilities,
-			     (data->allow_unadvertised_object_request & ALLOW_TIP_SHA1) ?
+			     (data->allow_uor & ALLOW_TIP_SHA1) ?
 				     " allow-tip-sha1-in-want" : "",
-			     (data->allow_unadvertised_object_request & ALLOW_REACHABLE_SHA1) ?
+			     (data->allow_uor & ALLOW_REACHABLE_SHA1) ?
 				     " allow-reachable-sha1-in-want" : "",
 			     data->stateless_rpc ? " no-done" : "",
 			     symref_info.buf,
@@ -1121,19 +1117,19 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 
 	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
 		if (git_config_bool(var, value))
-			data->allow_unadvertised_object_request |= ALLOW_TIP_SHA1;
+			data->allow_uor |= ALLOW_TIP_SHA1;
 		else
-			data->allow_unadvertised_object_request &= ~ALLOW_TIP_SHA1;
+			data->allow_uor &= ~ALLOW_TIP_SHA1;
 	} else if (!strcmp("uploadpack.allowreachablesha1inwant", var)) {
 		if (git_config_bool(var, value))
-			data->allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
+			data->allow_uor |= ALLOW_REACHABLE_SHA1;
 		else
-			data->allow_unadvertised_object_request &= ~ALLOW_REACHABLE_SHA1;
+			data->allow_uor &= ~ALLOW_REACHABLE_SHA1;
 	} else if (!strcmp("uploadpack.allowanysha1inwant", var)) {
 		if (git_config_bool(var, value))
-			data->allow_unadvertised_object_request |= ALLOW_ANY_SHA1;
+			data->allow_uor |= ALLOW_ANY_SHA1;
 		else
-			data->allow_unadvertised_object_request &= ~ALLOW_ANY_SHA1;
+			data->allow_uor &= ~ALLOW_ANY_SHA1;
 	} else if (!strcmp("uploadpack.keepalive", var)) {
 		data->keepalive = git_config_int(var, value);
 		if (!data->keepalive)
-- 
2.27.0.90.gabb59f83a2

