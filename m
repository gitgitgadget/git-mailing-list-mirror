Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894EB1EB4F
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkUYK12r"
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE63310C6
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 05:10:31 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9bda758748eso977377166b.2
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 05:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697717430; x=1698322230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOwXsI52km5DpnUY5RrPwM/CNPApiMy5mcJkv8NgVew=;
        b=jkUYK12rplED1EaCSOSgowHAxheucg1xtL6JTlJjU8KLmAu31pS+IeICvRhigo8kVU
         TZGLrHTZuXwBHgyrtx5ZOfQDMNGjloIiTc44WF2VVa6E4bJe9wgaDL4TxQuX1HWsrO1g
         qluTIv1+YE5s0h6iuIeKM+yP/ZnXS3V4olYDzQskxi29302+k1pbL3WcZXm22TIi7f+9
         vxH/YLOr6cP+wlq4nbCmxGek30CdviFyeBsuXScU9xKrQsU0Gvhmg2RFh0JB20URXcVB
         8LKRnqZC3pFl6fB2l6H1Pyl/vBfHwe1jsgWBJ6Fu/MqBXe49m2ObK5Gb+ExTCZAxlUQ9
         /qhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697717430; x=1698322230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOwXsI52km5DpnUY5RrPwM/CNPApiMy5mcJkv8NgVew=;
        b=egoV0GqOq4lxQH79HDwEpqLtrVKYsh1R3pyNxSX8otJiaDtDkVVFd9CKgVwIFjpZxD
         RT55j94zOUTqj/Agq7G+yUaoqS6Rc54Kngwio36uBBXUqq+pRfXct/8GscSWMFsctIu0
         FLRMbX+LXk3kWyUnoPgPY0UScusCjxgb63/eejuV95xfBX88bmr5Kn0xTeN3BtwnL/wA
         XM5A8xMDRP2kCLq/fdAE64446sES/U1HWwukq9ICVoEIv+UZQz5afmioiZcU30UgOw3H
         cbHYT0aYbQ/i68mieF+kfK/YiPRk3Ou/Gp6MZJOcmvRr6At0stcNMMXG1KnZnv9/GwmQ
         QmZg==
X-Gm-Message-State: AOJu0YzN7l9wT4Zs20GgIMRovV7/DoxrGoIHHJntSSPTCq4PpyH9zI4V
	OrNyHiC//oAPCCHbYh29ySY=
X-Google-Smtp-Source: AGHT+IH4xUp9YaN2yG5l8QMpB4Za8vUsQ5myiDlnKVyDfo9z4Lf7KifOvA8sLJAjnH971w6KgCO4EQ==
X-Received: by 2002:a17:907:6e87:b0:9be:d55a:81ba with SMTP id sh7-20020a1709076e8700b009bed55a81bamr1285810ejc.65.1697717429620;
        Thu, 19 Oct 2023 05:10:29 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2454:56d:f00:d5ee:6231:6f45:fa9b])
        by smtp.gmail.com with ESMTPSA id oz6-20020a170906cd0600b0099ddc81903asm3469212ejb.221.2023.10.19.05.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 05:10:29 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v3 2/3] rev-list: move `show_commit()` to the bottom
Date: Thu, 19 Oct 2023 14:10:23 +0200
Message-ID: <20231019121024.194317-3-karthik.188@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231019121024.194317-1-karthik.188@gmail.com>
References: <20231016103830.56486-1-karthik.188@gmail.com>
 <20231019121024.194317-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `show_commit()` function already depends on `finish_commit()`, and
in the upcoming commit, we'll also add a dependency on
`finish_object__ma()`. Since in C symbols must be declared before
they're used, let's move `show_commit()` below both `finish_commit()`
and `finish_object__ma()`, so the code is cleaner as a whole without the
need for declarations.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/rev-list.c | 85 +++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 43 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ea77489c38..98542e8b3c 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -100,7 +100,48 @@ static off_t get_object_disk_usage(struct object *obj)
 	return size;
 }
 
-static void finish_commit(struct commit *commit);
+static inline void finish_object__ma(struct object *obj)
+{
+	/*
+	 * Whether or not we try to dynamically fetch missing objects
+	 * from the server, we currently DO NOT have the object.  We
+	 * can either print, allow (ignore), or conditionally allow
+	 * (ignore) them.
+	 */
+	switch (arg_missing_action) {
+	case MA_ERROR:
+		die("missing %s object '%s'",
+		    type_name(obj->type), oid_to_hex(&obj->oid));
+		return;
+
+	case MA_ALLOW_ANY:
+		return;
+
+	case MA_PRINT:
+		oidset_insert(&missing_objects, &obj->oid);
+		return;
+
+	case MA_ALLOW_PROMISOR:
+		if (is_promisor_object(&obj->oid))
+			return;
+		die("unexpected missing %s object '%s'",
+		    type_name(obj->type), oid_to_hex(&obj->oid));
+		return;
+
+	default:
+		BUG("unhandled missing_action");
+		return;
+	}
+}
+
+static void finish_commit(struct commit *commit)
+{
+	free_commit_list(commit->parents);
+	commit->parents = NULL;
+	free_commit_buffer(the_repository->parsed_objects,
+			   commit);
+}
+
 static void show_commit(struct commit *commit, void *data)
 {
 	struct rev_list_info *info = data;
@@ -219,48 +260,6 @@ static void show_commit(struct commit *commit, void *data)
 	finish_commit(commit);
 }
 
-static void finish_commit(struct commit *commit)
-{
-	free_commit_list(commit->parents);
-	commit->parents = NULL;
-	free_commit_buffer(the_repository->parsed_objects,
-			   commit);
-}
-
-static inline void finish_object__ma(struct object *obj)
-{
-	/*
-	 * Whether or not we try to dynamically fetch missing objects
-	 * from the server, we currently DO NOT have the object.  We
-	 * can either print, allow (ignore), or conditionally allow
-	 * (ignore) them.
-	 */
-	switch (arg_missing_action) {
-	case MA_ERROR:
-		die("missing %s object '%s'",
-		    type_name(obj->type), oid_to_hex(&obj->oid));
-		return;
-
-	case MA_ALLOW_ANY:
-		return;
-
-	case MA_PRINT:
-		oidset_insert(&missing_objects, &obj->oid);
-		return;
-
-	case MA_ALLOW_PROMISOR:
-		if (is_promisor_object(&obj->oid))
-			return;
-		die("unexpected missing %s object '%s'",
-		    type_name(obj->type), oid_to_hex(&obj->oid));
-		return;
-
-	default:
-		BUG("unhandled missing_action");
-		return;
-	}
-}
-
 static int finish_object(struct object *obj, const char *name UNUSED,
 			 void *cb_data)
 {
-- 
2.42.0

