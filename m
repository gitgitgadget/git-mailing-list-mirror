Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CB733DF
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6cfWfrA"
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C11128
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 05:26:40 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9bdf5829000so656022466b.0
        for <git@vger.kernel.org>; Tue, 24 Oct 2023 05:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698150399; x=1698755199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOwXsI52km5DpnUY5RrPwM/CNPApiMy5mcJkv8NgVew=;
        b=c6cfWfrAeF+ViGKYHRM1XDyeUGMUEH76yuXWBHM5Qqv1/qkd1AiGPUyJ/dtLTs1yPh
         MPEJPtL7v+GBSc8HtdLr4sIh7pt02oSNIDZxSfOCSvK21bFKhrgD5mh4zBsWgx7+vXaI
         oc1zyf5HQ3ynu2Xg0/atw87ZO/xeTBT2NnEkCv58UZULeY+OLP6EANmkZ0J7qMcpW19C
         82AGighrUXhWP3O5zahpUCUPnlT/57qjFNWVumH7up2uOOg0lWJdIo33xKKSPYeD8NN+
         0vKOC0dGsQb/4l6pswfzzdbaJgX7CQnkGOma2B+apcfh6UsEiYp0QeDsvTVGX5TJWbRk
         Xvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698150399; x=1698755199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOwXsI52km5DpnUY5RrPwM/CNPApiMy5mcJkv8NgVew=;
        b=cv6N+ZUeWwCChoxfwtRmA+v30fGIxZcgftJvC0FUfF4Wy84Rgpin1ozXFeTznVjmTA
         P9D1HqdYzMvs/AvQ6/yNjBhCwpt2cKFvdFPLb96nFzH7wzLv3jcUXVxGAGWNcg4p2l8s
         do/LkuTl5IzPABWS/V5xetmaeiDHWZ0AIB/TDfhKgTK6sTtGPgnXTMXn+stWZ3tuOD9i
         iPdkNPo7LIbQ4fJ9pBElvbf1nmS3IJ+DEJIorYQRbAX12MpZn1IQUVorF2tsYNA8mSPJ
         ezp6aRlNibzKKThBEQeiFVNBYSWNJQ0F3aGyZRC/XZfIN1MOLj5dMLZSO8uixexud24o
         U5bQ==
X-Gm-Message-State: AOJu0YxDIj781pomJXYD1g1mAYE36wnKNkytNCekM3ulRGc3Znl8g1n4
	lN+DGjM1fwIR6xT8XrspjhA=
X-Google-Smtp-Source: AGHT+IHoNmfps/D3dXgLBfOj3Fs8fXgBFTAgh0s/CXgcwSPtCToTfNKpxPwJB/nG6ZS38etKNCtiOg==
X-Received: by 2002:a17:907:1b14:b0:9be:b668:5700 with SMTP id mp20-20020a1709071b1400b009beb6685700mr8621334ejc.58.1698150398654;
        Tue, 24 Oct 2023 05:26:38 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2454:56d:f00:be13:9408:ebb5:e370])
        by smtp.gmail.com with ESMTPSA id jl24-20020a17090775d800b0099315454e76sm8102726ejc.211.2023.10.24.05.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 05:26:38 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v4 2/3] rev-list: move `show_commit()` to the bottom
Date: Tue, 24 Oct 2023 14:26:30 +0200
Message-ID: <20231024122631.158415-3-karthik.188@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024122631.158415-1-karthik.188@gmail.com>
References: <20231019121024.194317-1-karthik.188@gmail.com>
 <20231024122631.158415-1-karthik.188@gmail.com>
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

