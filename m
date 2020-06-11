Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A525C433E1
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F4AD20760
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDN4rXrn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgFKMGB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgFKMF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 08:05:56 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CFAC08C5C6
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:55 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q11so5900497wrp.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R4N8wq0vZuV3gtkfEwnO4bpv25RraGCfdPxsYkh3pnw=;
        b=jDN4rXrn40KWt3ywWrgpdT78b1q6Mf92+F1egKIGnMjPyJfK91k8o4sEAh5zv5weD7
         dcRzaQWVZBXn8pdRfBInA9B7qhxu09AawWwhBP4amAle0NQTfEQgq+IaTyf9jhCG1aYA
         lVegatGL0xCxLGUg3QVY8w4MA2XiN9BcAtJk3/ptdxytxFyngCu1cYlOub8FAvAoyth1
         fO0tjfkDBlxcLQ5i9WZ81hr5maxCllcddS2+i7NqOr16s8X5yd+dOpmvzb/ZVXDeJsd5
         /y7ZaFwruGZ+UXd/87f/f1HUaCQaPRjsrPFGx/pr4H+PgYl9Iw9Hcr4t/f8Oo6AeI9p4
         q1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R4N8wq0vZuV3gtkfEwnO4bpv25RraGCfdPxsYkh3pnw=;
        b=mHQQoeOaC/nYN1hYhmzCuB0OhA9nyAwnrhV1H9SYfP94l/beGUJYunXLs7N8A9zztK
         Ki5ujqiZe0gWU7WtqxNmxn+dRoUan34QhwMYjb0rrk7gjAXLTkQ3N72UCDXtpknU4gsF
         NEGiJxg3V+9caTd7s58M2RMdtDhr1zxFJlg5u8xtYSqWhFn5UB4LUOPYMhConM8ZeEwT
         LAjQabHUYGETZpyeCj96XXf/a6cAwKeVmSLwSZdfMJKkgJYJM5o3DLzD0+cft3qcgvmz
         4SA/2BM/QxFkC7j+dn8TSp6jun3yRkpaRFFobHR64UWhJOkYjBAJvNzOXHk3yv9Q5WoS
         CyiQ==
X-Gm-Message-State: AOAM532P7Z16WpEVTW0MtVVNy54jz3b5IOazw5YbvL8lOd4tEFS95grl
        tReeMYzUfFy1rqIX34Idarn1VovsLnM=
X-Google-Smtp-Source: ABdhPJyzZtU/smiF7+r47IaPYzQLvTmzlkKPR1SznicXOj4A/YV05g6xT9rE7uAAEzYGwhu6tY6Ipg==
X-Received: by 2002:a5d:558a:: with SMTP id i10mr9773402wrv.207.1591877153538;
        Thu, 11 Jun 2020 05:05:53 -0700 (PDT)
Received: from localhost.localdomain ([185.228.229.208])
        by smtp.gmail.com with ESMTPSA id o8sm4047174wmb.20.2020.06.11.05.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:05:53 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 14/14] upload-pack: refactor common code into do_got_oid()
Date:   Thu, 11 Jun 2020 14:05:18 +0200
Message-Id: <20200611120518.10771-15-chriscool@tuxfamily.org>
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

As 'upload-pack.c' is now using 'struct upload_pack_data'
thoroughly, let's refactor some common code into a new
do_got_oid() function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 43 +++++++++++++------------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 3d331bedfa..f899fdf46a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -392,18 +392,11 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 	die("git upload-pack: %s", abort_msg);
 }
 
-static int got_oid(struct upload_pack_data *data,
-		   const char *hex, struct object_id *oid)
+static int do_got_oid(struct upload_pack_data *data, const struct object_id *oid)
 {
-	struct object *o;
 	int we_knew_they_have = 0;
+	struct object *o = parse_object(the_repository, oid);
 
-	if (get_oid_hex(hex, oid))
-		die("git upload-pack: expected SHA1 object, got '%s'", hex);
-	if (!has_object_file(oid))
-		return -1;
-
-	o = parse_object(the_repository, oid);
 	if (!o)
 		die("oops (%s)", oid_to_hex(oid));
 	if (o->type == OBJ_COMMIT) {
@@ -427,6 +420,16 @@ static int got_oid(struct upload_pack_data *data,
 	return 0;
 }
 
+static int got_oid(struct upload_pack_data *data,
+		   const char *hex, struct object_id *oid)
+{
+	if (get_oid_hex(hex, oid))
+		die("git upload-pack: expected SHA1 object, got '%s'", hex);
+	if (!has_object_file(oid))
+		return -1;
+	return do_got_oid(data, oid);
+}
+
 static int ok_to_give_up(struct upload_pack_data *data)
 {
 	uint32_t min_generation = GENERATION_NUMBER_ZERO;
@@ -1353,33 +1356,13 @@ static int process_haves(struct upload_pack_data *data, struct oid_array *common
 	/* Process haves */
 	for (i = 0; i < data->haves.nr; i++) {
 		const struct object_id *oid = &data->haves.oid[i];
-		struct object *o;
-		int we_knew_they_have = 0;
 
 		if (!has_object_file(oid))
 			continue;
 
 		oid_array_append(common, oid);
 
-		o = parse_object(the_repository, oid);
-		if (!o)
-			die("oops (%s)", oid_to_hex(oid));
-		if (o->type == OBJ_COMMIT) {
-			struct commit_list *parents;
-			struct commit *commit = (struct commit *)o;
-			if (o->flags & THEY_HAVE)
-				we_knew_they_have = 1;
-			else
-				o->flags |= THEY_HAVE;
-			if (!data->oldest_have || (commit->date < data->oldest_have))
-				data->oldest_have = commit->date;
-			for (parents = commit->parents;
-			     parents;
-			     parents = parents->next)
-				parents->item->object.flags |= THEY_HAVE;
-		}
-		if (!we_knew_they_have)
-			add_object_array(o, NULL, &data->have_obj);
+		do_got_oid(data, oid);
 	}
 
 	return 0;
-- 
2.27.0.90.gabb59f83a2

