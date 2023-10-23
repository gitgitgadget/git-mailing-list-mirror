Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC4224200
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aU/r1Vsl"
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C58399
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:12:01 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c503da4fd6so56032601fa.1
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698099119; x=1698703919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IgaVws3XFXy+Lt2OCphZWNOgHLzlOEKRWpYSFDctJw=;
        b=aU/r1Vslq6IqTy7uXWgsoLPpN0iG2w9JVfIEVF+Oe0I18ugZFBNeZOiS66u4/JJ/Vt
         OSvcz/f7T+6c0OEVAdBemMYOsTzTQKt4KSdMMtnPJabLk/iCVleocCcS3f/Mz7ehtmmC
         hrE1nA3IuL4N5EOZFe/l2Zc7zvjox4yOpoHRXUlESbhYFU9dE+wNsFPKgl2UDZ2sxBgy
         UVr8oCglAI118JtE4/Rlz1BHNGvqNj5XSU0UHxeUG9ImlM59PlMfmNAdwBmUq/LW1U0y
         vcaQzJyc+QmRop5ZxEGkR8usSEoDpvV5fliAKA7C54uYUKQyEQAfP5IGQX415mRuaOzu
         WajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698099119; x=1698703919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IgaVws3XFXy+Lt2OCphZWNOgHLzlOEKRWpYSFDctJw=;
        b=e5sj/nvD9pbgYLHgcifapKOalommzvKm/3l6o5IxGJ2cUTf0FE90IqlDNiP/nSvFYB
         u53h6sOJ+pl5bbG8E1TKDZnQ6+jpsNeDY3oLXEdz+l5MdHfEy4MKiccMQ5JZH/hED0gV
         G1bRAO2UKeoAek5suSw71uQ/mQbxQynzvZNVWCHq21VLPGW40VeDKlttoJ+ggu4A/t1I
         8oSCrfk43DcmQbRZA1LanyqZ7eCuQeyB8XnU5DrZoqaGdNpeFcIrJ0jV7Cc58+4WQumX
         OpGj8Jh/+B4hcUuSERQrQIjfqaxcQvuZDO0FaPICjy4VgKizp85+dS0nHFxQyPkEpv8S
         87cQ==
X-Gm-Message-State: AOJu0YwEKqEXsDPKxQllTaPRLfczo+YNjRbl+oJtK/mvpYWoAJXcT/2d
	Ljnpsu8jDEKwVST2XBSbp3IGBTr2MtHc3Q==
X-Google-Smtp-Source: AGHT+IEP2s9UO19VhGI6neY/GBOt341KLuT9kSqiMt0VI+dVB2r28ojkLnhIYSb+VuzVcY1708U+Yg==
X-Received: by 2002:a2e:b8cc:0:b0:2c5:1f57:1ef5 with SMTP id s12-20020a2eb8cc000000b002c51f571ef5mr8057751ljp.39.1698099119398;
        Mon, 23 Oct 2023 15:11:59 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id w11-20020a5d608b000000b0032008f99216sm8559953wrt.96.2023.10.23.15.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 15:11:59 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	stolee@gmail.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v3 5/7] refs: add pseudorefs array and iteration functions
Date: Mon, 23 Oct 2023 23:11:41 +0100
Message-ID: <20231023221143.72489-6-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231023221143.72489-1-andy.koppe@gmail.com>
References: <20231022214432.56325-1-andy.koppe@gmail.com>
 <20231023221143.72489-1-andy.koppe@gmail.com>
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

