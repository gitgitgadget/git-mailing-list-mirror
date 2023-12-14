Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4591766AB6
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wZHB2Qec"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1efabc436e4so35010fac.1
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592621; x=1703197421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uXgE8FVumua/OgsY6+EN7x41FTQBQNWf+Toq+QSaXGo=;
        b=wZHB2QecUsaTBcIAGPOfV4ab63T12cK7e9/3b8e7nksVr7K/ugUd9cmt8dEhsAkQd4
         Xr3OlOX3i9OENAHHFdnrdngxP61ccHAsIP3WQJ8dijPps0HczcTXkC3jmG0Wd3Gkl61X
         FZ7OdnehtKMrfZ5ovWQoBF7fGnrXLoMocpeHmkVs+JSHAwXIMDAOlImTXO/YZfDVTVCO
         TqHPUa1JNLVH0U5rrytzgssvXrhgImPHAeQ6IRirxwcNWb1Sp6O7+XbE/R0apYIO9V3x
         0kWfbN5CHOSbsNl++rS+GnFYe70G3YglXN/ZwIczVkmWgTbnun3Pu0ycg+JdaouK1F2C
         0XUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592621; x=1703197421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXgE8FVumua/OgsY6+EN7x41FTQBQNWf+Toq+QSaXGo=;
        b=V9Dxm/ykE5FEQ7sxgIohyTz4B45NCoGgMJUsuYF7Ll0hqsq7stUgpR4IJzB9MxZ7vQ
         NKsm9LQx1k0udVwMIyk0GAD3t76tsjbLbaN55RmviOiwBZdF7Z+p5s3tI4LNkRRFlvyb
         1vSoE3zsaylrUJEsiRxxRhQSWe+e0mAFRc09E/AjxuPVuEA5fIahEKQxPWMXsA2ZKzDp
         DEDT1/HlXQkfdeP8jivnSRCA9uGSMO5EdTMKy/qB0a38lxKJXoxVIuU3ojYyo6IfT0ts
         DII3Rdhl11Fc0wcFiOTSfgrIMA4OAGMwPIbdWc804toXYKLfiHZmbdQKtoKc4vdfvIUF
         RRAA==
X-Gm-Message-State: AOJu0YxZE/XXy3eASiUo5TyJcHTIvzWR5WqpILO4Gars9ombSqxnckqt
	p5Np/C5rVPmnQARKGGEp2Pxwg9DOyYI1T3iDtWaMNg==
X-Google-Smtp-Source: AGHT+IHhGSE201A3Plge5osbbx708Cgl3sSaetQq1MhFQxFiMmVGEHciWGjq5aDqnBRqqzikgPF2Dg==
X-Received: by 2002:a05:6870:9f07:b0:1fb:75a:c43f with SMTP id xl7-20020a0568709f0700b001fb075ac43fmr10075837oab.104.1702592620752;
        Thu, 14 Dec 2023 14:23:40 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id hg5-20020a056870790500b001fa1db68eecsm4759249oab.4.2023.12.14.14.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:23:40 -0800 (PST)
Date: Thu, 14 Dec 2023 17:23:39 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/26] pack-objects: free packing_data in more places
Message-ID: <7d65abfa1d38c8bfa59a06514c5bbe6a07f3c6da.1702592604.git.me@ttaylorr.com>
References: <cover.1701198172.git.me@ttaylorr.com>
 <cover.1702592603.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1702592603.git.me@ttaylorr.com>

The pack-objects internals use a packing_data struct to track what
objects are part of the pack(s) being formed.

Since these structures contain allocated fields, failing to
appropriately free() them results in a leak. Plug that leak by
introducing a clear_packing_data() function, and call it in the
appropriate spots.

This is a fairly straightforward leak to plug, since none of the callers
expect to read any values or have any references to parts of the address
space being freed.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c |  1 +
 midx.c                 |  5 +++++
 pack-objects.c         | 15 +++++++++++++++
 pack-objects.h         |  1 +
 4 files changed, 22 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 89a8b5a976..321d7effb0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4522,6 +4522,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			   reuse_packfile_objects);
 
 cleanup:
+	clear_packing_data(&to_pack);
 	list_objects_filter_release(&filter_options);
 	strvec_clear(&rp);
 
diff --git a/midx.c b/midx.c
index 1d14661dad..778dd536c8 100644
--- a/midx.c
+++ b/midx.c
@@ -1603,8 +1603,13 @@ static int write_midx_internal(const char *object_dir,
 				      flags) < 0) {
 			error(_("could not write multi-pack bitmap"));
 			result = 1;
+			clear_packing_data(&pdata);
+			free(commits);
 			goto cleanup;
 		}
+
+		clear_packing_data(&pdata);
+		free(commits);
 	}
 	/*
 	 * NOTE: Do not use ctx.entries beyond this point, since it might
diff --git a/pack-objects.c b/pack-objects.c
index f403ca6986..a9d9855063 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -151,6 +151,21 @@ void prepare_packing_data(struct repository *r, struct packing_data *pdata)
 	init_recursive_mutex(&pdata->odb_lock);
 }
 
+void clear_packing_data(struct packing_data *pdata)
+{
+	if (!pdata)
+		return;
+
+	free(pdata->cruft_mtime);
+	free(pdata->in_pack);
+	free(pdata->in_pack_by_idx);
+	free(pdata->in_pack_pos);
+	free(pdata->index);
+	free(pdata->layer);
+	free(pdata->objects);
+	free(pdata->tree_depth);
+}
+
 struct object_entry *packlist_alloc(struct packing_data *pdata,
 				    const struct object_id *oid)
 {
diff --git a/pack-objects.h b/pack-objects.h
index 0d78db40cb..b9898a4e64 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -169,6 +169,7 @@ struct packing_data {
 };
 
 void prepare_packing_data(struct repository *r, struct packing_data *pdata);
+void clear_packing_data(struct packing_data *pdata);
 
 /* Protect access to object database */
 static inline void packing_data_lock(struct packing_data *pdata)
-- 
2.43.0.102.ga31d690331.dirty

