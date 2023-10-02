Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6ABE784A7
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbjJBCle (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbjJBClP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:41:15 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56E31B4
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:40:57 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79f82b26abfso562693039f.1
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214457; x=1696819257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2Tpg3bVdy9YaIiHJYFcCNoaRuC55AkyHBlJKIbRy1I=;
        b=Hk4ptNPGn/HdGrowT70PuVWTcltRGQp3mGLyFIXDSLq/crU8nuMp0GgRFw/sDtgEr2
         TO9b97IwRP1nqgYFOUINiqcXG5kMhd8XAWuo63IuZDCDfaGEX77bwZludMF/SJ78TS+m
         qfq3wMktEJd1uBW44uStF4JJPIVVIITQ3VjQsZdWTibeixqH8TPG5Yw043B91VtP8ZCX
         zFeUOrkunzu/vYR9RdF+KBlArD+SjRRQnOzA4FdlXFbfOofeP0VkBnueixFKaUwOWYuE
         /2utLFdf3KC4+nLh2XNn4F2tTyI3LLctnEaYFdt5c9zOZtzg7HIUeMD9ixyLWKZ0wOjO
         hPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214457; x=1696819257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2Tpg3bVdy9YaIiHJYFcCNoaRuC55AkyHBlJKIbRy1I=;
        b=osn7orJXYsFdYcGcWPnrwEeuDedTAhU1XOFhepZ5IJ8gcipenlpwhTzmV7q7b2Nd/0
         j++OYaoom2YkybXmehFXCEr4rzdqFcFzicRC+4keejBnM6rovdb/QyqjI1fg7I+ylSAb
         Nzd5mhEPrmCCacqm4cr8V0oNz0r2nt0xF4NIyWNoUVa1eLKDKLbTNMzNUGXVfaY9zlxe
         D3rsmB/HWZZC+jQy45EHFBrngY7n+r2ZT8McAR80R8SWPi/YO4a8vNk2Dlt3ZjIragQB
         EVogm0Exry5/7W6Yoc5QclwKg4eHzjPqY4NOx31S0vn9ADf7XVSW2QvHrF5lBhvjVEhb
         5Yzw==
X-Gm-Message-State: AOJu0YyPQj4CftEJfHnoe5VMacxdFEjoKTytWX1ZSaLGX3ihmV6yB2qB
        sfpGqpYnXiEw/MwHl9CyVvY=
X-Google-Smtp-Source: AGHT+IFta2hh8MA0cRZLqHhmemGLv8oENMUpv3MOWNzVo5jWOYW+MAvyjs/cfIEw5tDsGpH/VmLTVA==
X-Received: by 2002:a5e:a903:0:b0:79f:97b6:76de with SMTP id c3-20020a5ea903000000b0079f97b676demr11495924iod.3.1696214456806;
        Sun, 01 Oct 2023 19:40:56 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:40:56 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 20/30] object-file: update object_info_extended to reencode objects
Date:   Sun,  1 Oct 2023 21:40:24 -0500
Message-Id: <20231002024034.2611-20-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
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
index 820810a5f4b3..b2d43d009898 100644
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

