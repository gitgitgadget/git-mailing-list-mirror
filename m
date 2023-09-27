Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872A6E82CCF
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjI0T4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjI0T4X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:56:23 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED875CCB
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:05 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-79fa891b645so337332839f.0
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844565; x=1696449365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1a9rKHC3NFMW+Qi8DVW/6mu7Wi6x73PfiC0GhejhjQs=;
        b=m7FglewgD9vuKPO4njaeQAW53zkiNE/HoUtd+xGO6rJqRaPF203VSc2DkD0wgnhbzR
         O3ox1sk4cJnpKdWOGO18enEC7V+aa+n/hMVWM5ksm9OAfekIHlvdK6NdhbWGYpjQDgoN
         uCRuhmnvEwozsqsRAFsuvDX4bQv7lPyJjhN6u03MUxdF5U3rvB+y1aTjAaJ8b++TWT7B
         E3CCqrFNYhkruhOuVH8PTefbSjXyNac8CU4155D2x4BvGOkhzMn2OvxoRiM4Yuit069a
         hNj6G7i3jzGwFZUuP6gfwcE+T9bcmYrK9eDNVYlZD8/KrKJUTLWzX0mnMSI4I8p5P7sS
         iojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844565; x=1696449365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1a9rKHC3NFMW+Qi8DVW/6mu7Wi6x73PfiC0GhejhjQs=;
        b=mvEGCI6EiZkOwzk7F6n8cC9y0SIaesxBQwjy7xtPB+KypEm1swhU8OGKJi5j4beIYx
         S0aZf0ahCij9D+YGcZHKDlHQzTZ1L7k00/Wh+gdX1pDd3Tf0WBBSzTLTqAt+0EhMM2KC
         95AW8ercKbiTvFvuYX684hHk+tRv0vuTAajAFHosQviosQoGQE89tC3DBS7Y0kP0EwE8
         iNGguiLFMwHF1836RtkIDZ4rg85Gd/2lDhfYxqaXz0ie0xArxSvDX/fmnSUfru5Quduq
         bBIUpL4w+duC/P8/qbt4oQdVIss7RfWI1AEErjZ4kNUA6KzbcNROuxkUn5ShDaIsLe1D
         zM4Q==
X-Gm-Message-State: AOJu0YzQfS8nnLk2Gk+WKZpxEOWdU4JNm2w5JsImBh9fsu6L9y6W9hne
        2CFf5HYIp0zNi6oHCEwaEjw07EwrA50=
X-Google-Smtp-Source: AGHT+IHHgFpoMYHHv6Jr8iZeJsj+yvY9RRVOsK0hj7u0nPEVdibGKplXLEvQeIyLcxOiNdcndiQYEg==
X-Received: by 2002:a5d:9251:0:b0:79f:e9ac:f60a with SMTP id e17-20020a5d9251000000b0079fe9acf60amr3052576iol.20.1695844565307;
        Wed, 27 Sep 2023 12:56:05 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:56:04 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 20/30] object-file: Update object_info_extended to reencode objects
Date:   Wed, 27 Sep 2023 14:55:27 -0500
Message-Id: <20230927195537.1682-20-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

oid_object_info_extended is updated to detect an oid encoding that
does not match the current repository, use repo_oid_to_algop to find
the correspoding oid in the current repository and to return the data
for the oid.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 object-file.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/object-file.c b/object-file.c
index d66d11890696..1601d624c9fd 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1662,10 +1662,101 @@ static int do_oid_object_info_extended(struct repository *r,
 	return 0;
 }
 
+static int oid_object_info_convert(struct repository *r,
+				   const struct object_id *input_oid,
+				   struct object_info *input_oi, unsigned flags)
+{
+	const struct git_hash_algo *input_algo = &hash_algos[input_oid->algo];
+	int do_die = flags & OBJECT_INFO_DIE_IF_CORRUPT;
+	struct strbuf type_name = STRBUF_INIT;
+	struct object_id oid, delta_base_oid;
+	struct object_info new_oi, *oi;
+	unsigned long size;
+	void *content;
+	int ret;
+
+	if (repo_oid_to_algop(r, input_oid, the_hash_algo, &oid)) {
+		if (do_die)
+			die(_("missing mapping of %s to %s"),
+			    oid_to_hex(input_oid), the_hash_algo->name);
+		return -1;
+	}
+
+	/* Is new_oi needed? */
+	oi = input_oi;
+	if (input_oi && (input_oi->delta_base_oid || input_oi->sizep ||
+			 input_oi->contentp)) {
+		new_oi = *input_oi;
+		/* Does delta_base_oid need to be converted? */
+		if (input_oi->delta_base_oid)
+			new_oi.delta_base_oid = &delta_base_oid;
+		/* Will the attributes differ when converted? */
+		if (input_oi->sizep || input_oi->contentp) {
+			new_oi.contentp = &content;
+			new_oi.sizep = &size;
+			new_oi.type_name = &type_name;
+		}
+		oi = &new_oi;
+	}
+
+	ret = oid_object_info_extended(r, &oid, oi, flags);
+	if (ret)
+		return -1;
+	if (oi == input_oi)
+		return ret;
+
+	if (new_oi.contentp) {
+		struct strbuf outbuf = STRBUF_INIT;
+		enum object_type type;
+
+		type = type_from_string_gently(type_name.buf, type_name.len,
+					       !do_die);
+		if (type == -1)
+			return -1;
+		if (type != OBJ_BLOB) {
+			ret = convert_object_file(&outbuf,
+						  the_hash_algo, input_algo,
+						  content, size, type, !do_die);
+			if (ret == -1)
+				return -1;
+			free(content);
+			size = outbuf.len;
+			content = strbuf_detach(&outbuf, NULL);
+		}
+		if (input_oi->sizep)
+			*input_oi->sizep = size;
+		if (input_oi->contentp)
+			*input_oi->contentp = content;
+		else
+			free(content);
+		if (input_oi->type_name)
+			*input_oi->type_name = type_name;
+		else
+			strbuf_release(&type_name);
+	}
+	if (new_oi.delta_base_oid == &delta_base_oid) {
+		if (repo_oid_to_algop(r, &delta_base_oid, input_algo,
+				 input_oi->delta_base_oid)) {
+			if (do_die)
+				die(_("missing mapping of %s to %s"),
+				    oid_to_hex(&delta_base_oid),
+				    input_algo->name);
+			return -1;
+		}
+	}
+	input_oi->whence = new_oi.whence;
+	input_oi->u = new_oi.u;
+	return ret;
+}
+
 int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 			     struct object_info *oi, unsigned flags)
 {
 	int ret;
+
+	if (oid->algo && (hash_algo_by_ptr(r->hash_algo) != oid->algo))
+		return oid_object_info_convert(r, oid, oi, flags);
+
 	obj_read_lock();
 	ret = do_oid_object_info_extended(r, oid, oi, flags);
 	obj_read_unlock();
-- 
2.41.0

