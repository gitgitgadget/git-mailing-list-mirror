Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED9C3C6A0
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 19:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdHE/pOh"
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3ABFA
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:39:50 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d9ac31cb051so63150276.3
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697744389; x=1698349189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1J7bjU/KPb/7aUQIjSXiJwC9DN/I87KB+lEhYCd9Og=;
        b=cdHE/pOhOM9Tpu2m2yCd6egmUziURRJM7AmEvAS3cuWOESFCkKURdEp9wfn4nl8ZFU
         YgT7/POiPTtx2OKTm6ZjzjqG4fRekbaPuFnfcjz/hJlRbMz5kA3lC4ngt1JH92zJ6w2T
         YBSJvuNJ7uIM18PBKLnZkQDkQS0O8hFuhobGMfGMYQv16ChcY/5ikHtrlQenfXp6afXM
         NlAxS8aUmuSTRgZ+m4mWpHDcs99qoc2WXhaKIWrD1m/9nMqqivxg/NrRxRGzIQdVNrmk
         AdEPoh4xrg4aCjFqroK4aaO//k5GBc+eiobFdbo0Eg6QN/jqvFrddnpfNPyrbsCRNLeB
         4n7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697744389; x=1698349189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1J7bjU/KPb/7aUQIjSXiJwC9DN/I87KB+lEhYCd9Og=;
        b=UA8rfX963CP+ikdVLWcEMtL2Hsg3Tk1T7iX6SCfc0ml4PMZmLgq/1LPkcD0dmb5Vpe
         YhEWHe7KEThYJUVKwKffnMhLzk06keFNi2MiIIVvOk8wA2YL+GrOwA9jg9tuyAeqhOSu
         Ta/x/ccISGMvroukuq/iQaIx4e38U5vRd+CoxhVoRyTq/UkeZRYuGptiFZcw1d0p8dQv
         4B8Ugfecyu2jqpJjiwhAHEzqyrHsN1OtdVWgc6Gwfpz4Ldct+onghBYWDpRNAeeWevsF
         oaewPiQ9VNWfs+p5gCcPZEljPgqlNA81pBTypVKsxaiSJRf47lCh3JbAHjSHjiDu7qTe
         dzaw==
X-Gm-Message-State: AOJu0Yx0xjmy2LbB7p++A0cFGDpCAAD4/vM4IzJggenf5AbJghP6SgOu
	e4EI0n3rH58LlaH82RpNoUhh+XQ5jcE=
X-Google-Smtp-Source: AGHT+IFqcAMCO5nYVRpopHPj7Av7QHwI5OBErcnJoVoH5dA/UO3ZnnNV2gMisX/I/IxTMAr/IR0JCw==
X-Received: by 2002:a25:324b:0:b0:d7f:d6a7:d57d with SMTP id y72-20020a25324b000000b00d7fd6a7d57dmr3222090yby.27.1697744389277;
        Thu, 19 Oct 2023 12:39:49 -0700 (PDT)
Received: from u.ad.analog.com (cpc99472-lich12-2-0-cust1752.3-2.cable.virginm.net. [80.2.214.217])
        by smtp.gmail.com with ESMTPSA id ph5-20020a0562144a4500b0066d0ab215b5sm99940qvb.13.2023.10.19.12.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 12:39:48 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH 4/7] refs: separate decoration type from default filter
Date: Thu, 19 Oct 2023 20:39:08 +0100
Message-ID: <20231019193911.1669705-5-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231003205442.22963-1-andy.koppe@gmail.com>
References: <20231003205442.22963-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 'include' bit to struct ref_namespace_info to determine whether a
ref namespace is to be included in the default decoration filters,
instead of using the decoration type for the purpose.

This is to allow adding ref namespaces that do have a decoration type
but that are not shown by default.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 builtin/log.c | 6 ++----
 refs.c        | 6 ++++++
 refs.h        | 4 ++++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index ba775d7b5cf..25d73c25697 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -227,10 +227,8 @@ static void set_default_decoration_filter(struct decoration_filter *decoration_f
 	 * populate with sensible defaults.
 	 */
 	for (i = 0; i < ARRAY_SIZE(ref_namespace); i++) {
-		if (!ref_namespace[i].decoration)
-			continue;
-
-		string_list_append(include, ref_namespace[i].ref);
+		if (ref_namespace[i].include)
+			string_list_append(include, ref_namespace[i].ref);
 	}
 }
 
diff --git a/refs.c b/refs.c
index fcae5dddc60..416c35f0c2f 100644
--- a/refs.c
+++ b/refs.c
@@ -70,14 +70,17 @@ struct ref_namespace_info ref_namespace[] = {
 		.ref = "HEAD",
 		.decoration = DECORATION_REF_HEAD,
 		.exact = 1,
+		.include = 1,
 	},
 	[NAMESPACE_BRANCHES] = {
 		.ref = "refs/heads/",
 		.decoration = DECORATION_REF_LOCAL,
+		.include = 1,
 	},
 	[NAMESPACE_TAGS] = {
 		.ref = "refs/tags/",
 		.decoration = DECORATION_REF_TAG,
+		.include = 1,
 	},
 	[NAMESPACE_REMOTE_REFS] = {
 		/*
@@ -87,6 +90,7 @@ struct ref_namespace_info ref_namespace[] = {
 		 */
 		.ref = "refs/remotes/",
 		.decoration = DECORATION_REF_REMOTE,
+		.include = 1,
 	},
 	[NAMESPACE_STASH] = {
 		/*
@@ -96,6 +100,7 @@ struct ref_namespace_info ref_namespace[] = {
 		.ref = "refs/stash",
 		.exact = 1,
 		.decoration = DECORATION_REF_STASH,
+		.include = 1,
 	},
 	[NAMESPACE_REPLACE] = {
 		/*
@@ -107,6 +112,7 @@ struct ref_namespace_info ref_namespace[] = {
 		 */
 		.ref = "refs/replace/",
 		.decoration = DECORATION_GRAFTED,
+		.include = 1,
 	},
 	[NAMESPACE_NOTES] = {
 		/*
diff --git a/refs.h b/refs.h
index 23211a5ea1c..4b054d30fe5 100644
--- a/refs.h
+++ b/refs.h
@@ -987,10 +987,14 @@ struct ref_namespace_info {
 	 * If 'exact' is true, then we must match the 'ref' exactly.
 	 * Otherwise, use a prefix match.
 	 *
+	 * If 'include' is true, the namespace is included in the
+	 * default decoration filters.
+	 *
 	 * 'ref_updated' is for internal use. It represents whether the
 	 * 'ref' value was replaced from its original literal version.
 	 */
 	unsigned exact:1,
+		 include:1,
 		 ref_updated:1;
 };
 
-- 
2.42.GIT

