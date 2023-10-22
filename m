Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB44B13FE6
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 21:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W90x++hc"
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF85FB
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 14:45:11 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32003aae100so2133677f8f.0
        for <git@vger.kernel.org>; Sun, 22 Oct 2023 14:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698011110; x=1698615910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IgaVws3XFXy+Lt2OCphZWNOgHLzlOEKRWpYSFDctJw=;
        b=W90x++hcGzRmNRyMYy5SidN3+6+BDUQIwFR1ic3hJcLjMfBND3LK++raQQ8wlka/zq
         6WXpUfJanh7KA5bQIV1yXpJ45SNd8yrq2DpNksj0YQSlW2zlTn/MEqr92VIssvItXfdh
         6zZBRhaehLvGRkh5/Dnda3EvO45PL2qqQU1lBjLJual049HAZTp2Gx52s69m678r8QmZ
         MqRh74aMQTAPI1Hrpxzj9gAd7Eetu9Baa9K2ZCzstuNAVCJJfMzNCSUuz9sh0NX9Tyv+
         6AXKkB11ePhua3B6+rLhTEqjFjsKn/fk2ASE5bc5IG1VZD5ZuW9gfIgnKlaTr1y/43Ab
         QlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698011110; x=1698615910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IgaVws3XFXy+Lt2OCphZWNOgHLzlOEKRWpYSFDctJw=;
        b=nuT4n/MLY6o69UxgufPtJsDoNTtjU3bTKZ8ZwtxcZ/uKdiCtV092M4FtCJC6YVHrbP
         3p718osKv3zEGrmgfMKeNNUhGTU9tEtL7z/41p89nUuXfEj+G8EfLLdwAN1bPoJIZP3M
         E+QU2jAkjuMigCbpnRyb127AiBkuCG1biXCHVwxojkgeIRHUpbKqBxYUdahLavbUNq15
         hx7fxLUEKWmk1h+b+2kD+dH28tP4/WQCGy5XmHGvHDE7f66CU4YwIX1cK5tKSPLfvXSl
         A2JY9842jsDaLeZfk66sVgoPkiSFHLZSOK6cHXtR9zgyyZl4ZWmKzF4Q4d1O+RStvjFo
         4//w==
X-Gm-Message-State: AOJu0YzIOsCFLjDPo7OX6fVcK1rCFbjJDJPg4D/NvFUlEgnwN8CLdhqs
	2SDfZL7RmDb0FiFkC9psBVo4Np9vJz4=
X-Google-Smtp-Source: AGHT+IEJvU0nwWUTgo2dItAhdJziw/advVwOpf/x4XyCDgubbLMZxsZ1D5+jOc6kkvWHa7Mf7LVRJw==
X-Received: by 2002:adf:e901:0:b0:32d:dd74:555c with SMTP id f1-20020adfe901000000b0032ddd74555cmr10057685wrm.33.1698011110181;
        Sun, 22 Oct 2023 14:45:10 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id v3-20020adff683000000b0032d9523de65sm6291972wrp.48.2023.10.22.14.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 14:45:09 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v2 4/6] refs: add pseudorefs array and iteration functions
Date: Sun, 22 Oct 2023 22:44:30 +0100
Message-ID: <20231022214432.56325-5-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231022214432.56325-1-andy.koppe@gmail.com>
References: <20231019193911.1669705-1-andy.koppe@gmail.com>
 <20231022214432.56325-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define const array 'pseudorefs' with the names of the pseudorefs that
are documented in gitrevisions.1, and add functions for_each_pseudoref()
and refs_for_each_pseudoref() for iterating over them.

The functions process the pseudorefs in the same way as head_ref() and
refs_head_ref() process HEAD, invoking an each_ref_fn callback on each
pseudoref that exists.

This is in preparation for adding pseudorefs to log decorations.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 refs.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 refs.h |  5 +++++
 2 files changed, 47 insertions(+)

diff --git a/refs.c b/refs.c
index fcae5dddc6..aa7e4c02c5 100644
--- a/refs.c
+++ b/refs.c
@@ -65,6 +65,21 @@ static unsigned char refname_disposition[256] = {
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 4, 4
 };
 
+/*
+ * List of documented pseudorefs. This needs to be kept in sync with the list
+ * in Documentation/revisions.txt.
+ */
+static const char *const pseudorefs[] = {
+	"FETCH_HEAD",
+	"ORIG_HEAD",
+	"MERGE_HEAD",
+	"REBASE_HEAD",
+	"CHERRY_PICK_HEAD",
+	"REVERT_HEAD",
+	"BISECT_HEAD",
+	"AUTO_MERGE",
+};
+
 struct ref_namespace_info ref_namespace[] = {
 	[NAMESPACE_HEAD] = {
 		.ref = "HEAD",
@@ -1549,6 +1564,33 @@ int head_ref(each_ref_fn fn, void *cb_data)
 	return refs_head_ref(get_main_ref_store(the_repository), fn, cb_data);
 }
 
+int refs_for_each_pseudoref(struct ref_store *refs,
+			    each_ref_fn fn, void *cb_data)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pseudorefs); i++) {
+		struct object_id oid;
+		int flag;
+
+		if (refs_resolve_ref_unsafe(refs, pseudorefs[i],
+					    RESOLVE_REF_READING, &oid, &flag)) {
+			int ret = fn(pseudorefs[i], &oid, flag, cb_data);
+
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+int for_each_pseudoref(each_ref_fn fn, void *cb_data)
+{
+	return refs_for_each_pseudoref(get_main_ref_store(the_repository),
+				       fn, cb_data);
+}
+
 struct ref_iterator *refs_ref_iterator_begin(
 		struct ref_store *refs,
 		const char *prefix,
diff --git a/refs.h b/refs.h
index 23211a5ea1..7b55cced31 100644
--- a/refs.h
+++ b/refs.h
@@ -320,6 +320,8 @@ typedef int each_repo_ref_fn(struct repository *r,
  */
 int refs_head_ref(struct ref_store *refs,
 		  each_ref_fn fn, void *cb_data);
+int refs_for_each_pseudoref(struct ref_store *refs,
+			    each_ref_fn fn, void *cb_data);
 int refs_for_each_ref(struct ref_store *refs,
 		      each_ref_fn fn, void *cb_data);
 int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
@@ -334,6 +336,9 @@ int refs_for_each_remote_ref(struct ref_store *refs,
 /* just iterates the head ref. */
 int head_ref(each_ref_fn fn, void *cb_data);
 
+/* iterates pseudorefs. */
+int for_each_pseudoref(each_ref_fn fn, void *cb_data);
+
 /* iterates all refs. */
 int for_each_ref(each_ref_fn fn, void *cb_data);
 
-- 
2.42.GIT

