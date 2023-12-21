Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4852F59924
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e49c36UQ"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2370535060so395167566b.1
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 09:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703178441; x=1703783241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8iZ2o6NQNax5wnjEz+RFn73JzmHNezbmKccuAsG8B4=;
        b=e49c36UQIJ+FhF+58WTlQYL4+qFlqfqXwkizLK32WFneJsP2jdNCp27x168vK6xXio
         +D0W1nHtWEqEmbB8ahcJxV2x6HPZHvgLN2Ip5Ee050CBgwjtMWR4AO8xY7NU9dHsLmgo
         ww9qypoAXoSFAeU4iDE5hxhqeuLrf1R8RehrGYEkDdC3W/uLuV6L/lADUF0BCAXc9JOa
         4hewvQih1NkmJqZQM1FlED5wfM7boaOEVDV226KwEtREc0570QWK04fmLJDVTlskmFGB
         dH6YLALZolMYcVcs45nS0TiPG8agi8m5R2AMUPRx3+Yhv85dLkgzp/4nGODdhODlTgbg
         HAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703178441; x=1703783241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8iZ2o6NQNax5wnjEz+RFn73JzmHNezbmKccuAsG8B4=;
        b=P/Wr4ivnQcV/qVpyPkoDMC+d1a4nZl0ZJb/s3Hug7xezNc6fOB1/arbjGccYbMxjDB
         qlkNzb/VFi+Tsf89BkcNsjDV/2cDKtc1i9EcdPp+p7ApeFjPHCfaEmEXPZxU5LFX4s0D
         CBgk+bCWICDSsjvAfYgkc0R5XBqkO349fm07O4MvCow00J6mk0+IXD/gHGQRQvZrtUTv
         GP91WidCjZf1+og3g9z4NKZqqu37tg6hC+XPeI7MamI8U/p/7YWqkeFbocz6yQs9tAPr
         xttSkml9Fq/ltH2fBM9rrrRun+E375O3HNH3ShV3Gx5+32cozrFKTiogUkiiah1pH/5f
         jdbg==
X-Gm-Message-State: AOJu0YzIn05s8inyxfGJd2aSzsusxX1LkNsnr7eeYASyAzW9ZizV4d82
	JGp3JFIc+c2o9wlBAv1nYE1Z/jIlsl3xLw==
X-Google-Smtp-Source: AGHT+IGIs3j9oojDaa6XqrbsM3hDLYKeTgjlQQmkuwxKwdD6jtoY3cnKGQX/16V0is3g/RZbqoK5bg==
X-Received: by 2002:a17:906:2249:b0:a1e:7ddb:29c3 with SMTP id 9-20020a170906224900b00a1e7ddb29c3mr1060867ejr.63.1703178440596;
        Thu, 21 Dec 2023 09:07:20 -0800 (PST)
Received: from localhost.localdomain (h-213.61.124.196.host.de.colt.net. [213.61.124.196])
        by smtp.gmail.com with ESMTPSA id en6-20020a17090728c600b00a23577b265csm1163789ejc.173.2023.12.21.09.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:07:20 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	christian.couder@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 1/2] refs: introduce the `refs_single_ref` function
Date: Thu, 21 Dec 2023 18:07:14 +0100
Message-Id: <20231221170715.110565-2-karthik.188@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231221170715.110565-1-karthik.188@gmail.com>
References: <20231221170715.110565-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We currently provide the functionality to iterate over refs and call a
specific callback. This functionality currently supports iterating over
the entire "refs/*" space or directly the "HEAD" ref. This leaves
operational refs "ORIG_HEAD", "REBASE_HEAD" and so forth behind.

In the following commit, we introduce a mechanism to process all the
operational refs outside the "refs/*" space. To do this, we require a
function similar `refs_head_ref`, which can process a single specified
reference. This commit introduces `refs_single_ref` to fill in that gap.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c | 12 +++++++++---
 refs.h |  2 ++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 59fea0d44b..cebc5458d3 100644
--- a/refs.c
+++ b/refs.c
@@ -1549,18 +1549,24 @@ const char *find_descendant_ref(const char *dirname,
 	return NULL;
 }
 
-int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+int refs_single_ref(struct ref_store *refs, const char *refname,
+					each_ref_fn fn, void *cb_data)
 {
 	struct object_id oid;
 	int flag;
 
-	if (refs_resolve_ref_unsafe(refs, "HEAD", RESOLVE_REF_READING,
+	if (refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING,
 				    &oid, &flag))
-		return fn("HEAD", &oid, flag, cb_data);
+		return fn(refname, &oid, flag, cb_data);
 
 	return 0;
 }
 
+int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+{
+	return refs_single_ref(refs, "HEAD", fn, cb_data);
+}
+
 int head_ref(each_ref_fn fn, void *cb_data)
 {
 	return refs_head_ref(get_main_ref_store(the_repository), fn, cb_data);
diff --git a/refs.h b/refs.h
index 4816e46846..e147f13a85 100644
--- a/refs.h
+++ b/refs.h
@@ -324,6 +324,8 @@ typedef int each_repo_ref_fn(struct repository *r,
  * modifies the reference also returns a nonzero value to immediately
  * stop the iteration. Returned references are sorted.
  */
+int refs_single_ref(struct ref_store *refs, const char *refname,
+					each_ref_fn fn, void *cb_data);
 int refs_head_ref(struct ref_store *refs,
 		  each_ref_fn fn, void *cb_data);
 int refs_for_each_ref(struct ref_store *refs,
-- 
2.43.GIT

