Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1FE210EB
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 10:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai+sha7g"
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77085E6
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 03:38:44 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99c1c66876aso694621966b.2
        for <git@vger.kernel.org>; Mon, 16 Oct 2023 03:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697452723; x=1698057523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6TnQ1vaFjHTDr0P4PWPFgZC7Ma0ongoXkP+orTCGcI=;
        b=Ai+sha7g3ZpmkI62LA1PEbSvOajjE/qESTwexefWg6Rl/wQYOn+kl7z60OeaYPiNuo
         w8aYVBXVK0LhtFtHGKA6x6cGMGAqZ96r5nlh7ei57l1Zq+RyCwYQCiGOmp6GSHb3JLP3
         dxPdbA4WDEuHMD33rhlabfvF4dLQuhB3j0NzRwhjxYVEYxvPWsFBOEEZ4AMxJM2I2xvK
         ZMLv5OTsG5NSiSvFi43z/kDSfscGyqrdjizOZNSvbdRT06BBUXzqvuvtzCKbVtVUAp20
         ggFmzsdFwnm3zyyhV32Ae5hg+sJl1ovnBTiYWoBJZlE9rMZQcv0Xkva6OZiwncgiZOMZ
         1gtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697452723; x=1698057523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6TnQ1vaFjHTDr0P4PWPFgZC7Ma0ongoXkP+orTCGcI=;
        b=k6gmcKNNqPvpy7TwgRJupW6ry8UC44ZM+ijFFdb8Nrk4a6cR232JukUcHr+DQiwNzi
         MIOlxG+YyjB35YNj/l2yy/6XbvkA4klpv7IOhrl2C97/sleRJW+Ab3ab4F8Yt2PmtO8W
         wDO/yGMMaz3TDCJoshL5W+V3fdGhs/dczBn+hWur60HJfOYXyCdy3rS4dfCTpwAEePMU
         sLIYveq29mU6eVgOMa4V/9+bl6f6WyHma2x/verdprQRUkeovszOEtInM/VQPyybuPAp
         iEkGc2dghGWdQWqLHK5SifQmLbsPo8crhsU89PAYO1tBEoLwU09FRwH0yTcy1UCGLd6v
         IRHw==
X-Gm-Message-State: AOJu0Yzg952PFqL2WYToGneAkWDst/bCOy3/zsFZyTJaiid00LyjsSAq
	S/Hq7vOnbFjCA+cxOZLaOQE=
X-Google-Smtp-Source: AGHT+IGSG5/QQKNpC9gG6Ejm/sRtJYEHWAZa3vvL/b1+ZquXytzvkoZ5LBWmz1Y3wc7bVmH4e09SDg==
X-Received: by 2002:a17:906:314f:b0:9b0:169b:eece with SMTP id e15-20020a170906314f00b009b0169beecemr28200545eje.40.1697452722633;
        Mon, 16 Oct 2023 03:38:42 -0700 (PDT)
Received: from worklaptop.fritz.box ([2a02:2454:56d:f00:b15b:356c:2a07:7b52])
        by smtp.gmail.com with ESMTPSA id jx17-20020a170907761100b009ad875d12d7sm3784390ejc.210.2023.10.16.03.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 03:38:42 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v2 2/3] rev-list: move `show_commit()` to the bottom
Date: Mon, 16 Oct 2023 12:38:29 +0200
Message-ID: <20231016103830.56486-3-karthik.188@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016103830.56486-1-karthik.188@gmail.com>
References: <20231009105528.17777-1-karthik.188@gmail.com>
 <20231016103830.56486-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
2.41.0

