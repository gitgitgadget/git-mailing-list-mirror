Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D991A581
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXTRdpqw"
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59730198
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 03:11:18 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9bf0ac97fdeso110773266b.2
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 03:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698315077; x=1698919877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOwXsI52km5DpnUY5RrPwM/CNPApiMy5mcJkv8NgVew=;
        b=aXTRdpqwm43n4X0deDm3jdx9uWkUKlJCcHsOIx1xZSgLAyclLQ3i10yWUPq62EBn34
         YoGHlVl6nEGkYtEEYcGWZ2qvfYydoOgvptFoIpysHUpjD0SYxugOMfeDglHNKF106/gF
         UdzxGKlOU9xG6VQnF2OHfjNpQVMjiloc8mCaB8SN+cw85EGXz562lp+j8NmM0uPRZh/h
         xe1BUFAxpTbreWx5xBWS+0Ws0/6kS+Iq84QDO3JWgbhUAHX1h3ueeCFmIDuU6mR1jXOx
         NTbByeFpG7/gjpYVReF8fZ1kaWolPeUofsJETTlnEj/Jiet8ewZCCqVxr7E0iWQpzfKV
         9dSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698315077; x=1698919877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOwXsI52km5DpnUY5RrPwM/CNPApiMy5mcJkv8NgVew=;
        b=s/rXcDcrx15qkGGNeDlxwwtDGJhT+Mwotd1T9UF9gAWeWFUWlnqJU3Pu5/ip7OQKei
         SrUjrIVasTtuUiIgDq5YRTLl6smEkSwogy29K46ltoqBBbH1GhS3ZcpbopUfb2Mo4p9X
         oswMXy7uRVLBSr4wjJSElHiScIMzlmBVuAkjUIOiN0LNctj6Nv/7qHArpnq2vs8Iyo+w
         NNUcQMXA7uGhbZki85fYnmMNwzO6qnGUuyS+T6Qwq1itBR9sEpseMYCrLkpH6I0OL1oQ
         LPYQsOh6mPo7E+v6w4cXCJ902/RJpyqS/EeENNvO4CqFS0u/S6bpG2l2cuGw8PKLMvtM
         C7YQ==
X-Gm-Message-State: AOJu0YzzH45oFm4R/78Og/p8PnGAtpB1N6qfjTH0IfJEy5GQA7zcrsEV
	3RtmvvGEcwc3RejF2hO83RU=
X-Google-Smtp-Source: AGHT+IGjv6tDCwCGUV5OOXPxYDkz9EKj6+nP/3n7COKqT5HXJbMSEdahrE9m7hro2fq4dkBlpk05zg==
X-Received: by 2002:a17:907:318d:b0:9c7:5b43:a8e5 with SMTP id xe13-20020a170907318d00b009c75b43a8e5mr14126122ejb.40.1698315076666;
        Thu, 26 Oct 2023 03:11:16 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2454:56d:f00:561:c52d:5ce2:b147])
        by smtp.gmail.com with ESMTPSA id k15-20020a1709065fcf00b00997d7aa59fasm11635390ejv.14.2023.10.26.03.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 03:11:16 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v5 2/3] rev-list: move `show_commit()` to the bottom
Date: Thu, 26 Oct 2023 12:11:08 +0200
Message-ID: <20231026101109.43110-3-karthik.188@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231026101109.43110-1-karthik.188@gmail.com>
References: <20231024122631.158415-1-karthik.188@gmail.com>
 <20231026101109.43110-1-karthik.188@gmail.com>
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

