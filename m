Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6CF627E5
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNJyCmwX"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-552d39ac3ccso3919321a12.0
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 09:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703178442; x=1703783242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIAxp/FD+dMxzIK605pn8H9YJfXne+MzPui1TAupPw8=;
        b=MNJyCmwXtTLEetCswmzofHfjkrSGeqtYXrHdHfbWRAzp0DMKXk//CZvY1Ew3ylvSaf
         EOFIHd7kCRtwQeCSkbj7xTscws7eagaXqdoBrpId0OkR6iAIdGEBSBalwu4VwxweiHtE
         GPqvHwgl2rxrr5e9jcnlSXKeNOE7Ym3pX3rTqCE3/z9pq9ofQpRMrKxCVJE/O33fFG3A
         NvYKQOwMfxIPA5ml6BgJ/Hdfvki5bO+zsEb36IMF/I+cd9oIAE+vkJ9LrOyR1CfBuP+7
         Sl0lXwNvl8H02lbnDuVLzPSFbZkYWD6T4nmfL4UtjYtsBWdmcbREXvQwaq0hbFTbwfLP
         V1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703178442; x=1703783242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IIAxp/FD+dMxzIK605pn8H9YJfXne+MzPui1TAupPw8=;
        b=Q9+UO4Pf3Ec6pU3/rKc6Zz6Kx0jN5xe8X4V9W8adWFlH23GyvwXQ60IFBHvGGXhZXw
         F4O2Wgk0ennMZ9T6uUatjUlK0bd/84VxdZntAApVXKNFhDevY8zyENFDKpafX4qvmBut
         sKPawhC40gUYVZVw0iyQg/ozvkCZqCAtarVTQBpoAJGUECto03+0Q2RiYm7wT3COdh6y
         8RC7FbOH9lpAHiL3GZA++H/xe/scZqlYnwKvHKnX1SHRVDqYrBaoY/1ehBJi+hDd8Y0r
         /htVCn2hxS/bSzgGQMGG2vjct0PcC0MPR96JErG4/kwIzB+mY8Z3KYXyIXAb3K3NSd8L
         yAOw==
X-Gm-Message-State: AOJu0YwAx9K8X770i/OAz8/93ieGPlcZ+10gMQgq794IFszoKQXl2yTJ
	F5uBfQ8JWwzW+eBbfu12Av0fUMNnZPralA==
X-Google-Smtp-Source: AGHT+IGwFyex/iGVy09WSMM/13kou2yXE1tf6KrumFo/0s2MFiaH4IlWE/nAVQ9JpAmN0IYO4byBoA==
X-Received: by 2002:a17:906:739c:b0:a1d:2f59:81a4 with SMTP id f28-20020a170906739c00b00a1d2f5981a4mr1088084ejl.62.1703178442095;
        Thu, 21 Dec 2023 09:07:22 -0800 (PST)
Received: from localhost.localdomain (h-213.61.124.196.host.de.colt.net. [213.61.124.196])
        by smtp.gmail.com with ESMTPSA id en6-20020a17090728c600b00a23577b265csm1163789ejc.173.2023.12.21.09.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:07:21 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	christian.couder@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 2/2] ref-filter: support filtering of operational refs
Date: Thu, 21 Dec 2023 18:07:15 +0100
Message-Id: <20231221170715.110565-3-karthik.188@gmail.com>
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

With the upcoming introduction of the reftable backend, it becomes ever
so important to provide the necessary tooling for printing all refs
associated with a repository.

While regular refs stored within the "refs/" namespace are currently
supported by multiple commands like git-for-each-ref(1),
git-show-ref(1). Neither support printing all the operational refs
within the repository.

This is crucial because with the reftable backend, all these refs will
also move to reftable. It would be necessary to identify all the refs
that are stored within the reftable since there is no easy way to do so
otherwise. This is because the reftable itself is a binary format and
all access will be via git. Unlike the filesystem backend, which allows
access directly via the filesystem.

This commit adds the necessary code to iterate over operational refs
present in a repository and provides a new filter flag
'FILTER_REFS_OPERATIONAL' to iterate over operational refs.

This flag can now be used to extend existing git commands to print
operational refs.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 12 ++++++++++++
 ref-filter.h |  4 +++-
 refs.c       | 14 ++++++++++++++
 refs.h       |  3 +++
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index fdaabb5bb4..307a512c27 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2756,6 +2756,10 @@ static int filter_ref_kind(struct ref_filter *filter, const char *refname)
 	    filter->kind == FILTER_REFS_REMOTES ||
 	    filter->kind == FILTER_REFS_TAGS)
 		return filter->kind;
+
+	if (filter->kind & FILTER_REFS_OPERATIONAL)
+		return filter->kind;
+
 	return ref_kind_from_refname(refname);
 }
 
@@ -3032,6 +3036,14 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref
 	if (!filter->kind)
 		die("filter_refs: invalid type");
 	else {
+		size_t i;
+		if (filter->kind & FILTER_REFS_OPERATIONAL) {
+			for (i = 0; i < operational_refs_max; i++) {
+				refs_single_ref(get_main_ref_store(the_repository),
+								operational_refs[i], fn, cb_data);
+			}
+		}
+
 		/*
 		 * For common cases where we need only branches or remotes or tags,
 		 * we only iterate through those refs. If a mix of refs is needed,
diff --git a/ref-filter.h b/ref-filter.h
index 0ce5af58ab..eec1d29514 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -23,7 +23,9 @@
 #define FILTER_REFS_ALL            (FILTER_REFS_TAGS | FILTER_REFS_BRANCHES | \
 				    FILTER_REFS_REMOTES | FILTER_REFS_OTHERS)
 #define FILTER_REFS_DETACHED_HEAD  0x0020
-#define FILTER_REFS_KIND_MASK      (FILTER_REFS_ALL | FILTER_REFS_DETACHED_HEAD)
+#define FILTER_REFS_OPERATIONAL    0x0040
+#define FILTER_REFS_KIND_MASK      (FILTER_REFS_ALL | FILTER_REFS_DETACHED_HEAD | \
+				    FILTER_REFS_OPERATIONAL)
 
 struct atom_value;
 struct ref_sorting;
diff --git a/refs.c b/refs.c
index cebc5458d3..70f6854301 100644
--- a/refs.c
+++ b/refs.c
@@ -82,6 +82,20 @@ static unsigned char refname_disposition[256] = {
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 4, 4
 };
 
+const char *operational_refs[] = {
+	"HEAD",
+	"ORIG_HEAD",
+	"REBASE_HEAD",
+	"REVERT_HEAD",
+	"CHERRY_PICK_HEAD",
+	"BISECT_HEAD",
+	"BISECT_EXPECTED_REV",
+	"NOTES_MERGE_PARTIAL",
+	"NOTES_MERGE_REF",
+};
+
+const int operational_refs_max = ARRAY_SIZE(operational_refs) - 1;
+
 struct ref_namespace_info ref_namespace[] = {
 	[NAMESPACE_HEAD] = {
 		.ref = "HEAD",
diff --git a/refs.h b/refs.h
index e147f13a85..b01938a91a 100644
--- a/refs.h
+++ b/refs.h
@@ -15,6 +15,9 @@ int default_ref_storage_format(void);
 int ref_storage_format_by_name(const char *name);
 const char *ref_storage_format_to_name(int ref_storage_format);
 
+extern const char *operational_refs[];
+extern const int operational_refs_max;
+
 /*
  * Resolve a reference, recursively following symbolic refererences.
  *
-- 
2.43.GIT

