Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918A335513
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="p1CVgMPr"
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46338CF
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 10:28:57 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-66cfd35f595so48819416d6.2
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 10:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697736536; x=1698341336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z/yIZoK7/bYFsNbbqGOq2HXOM4InMO1xEo5GdQEL0RU=;
        b=p1CVgMPrgIzf/9F0YVyJB/yZLqFBGpiEKycmcFOclebQho2l7pUKAzowtHPmtRdGR8
         h0jWMjwkprIKxquOrSrQC/cbtTpOOJNEriFBXcLX7439548KakWqAm5JGbqp/udeUO/9
         4cu5jjCt+eBninfgajHnbTKGVRojEWiewHwq0bBgep577HwLTKd1kHqJUy4pJrKVydh1
         YmXIpD2ND0v+ANWotCjfLcEix321TVaO7MK2w/S25gimoRfj5AthHMIYmwt3OI3JhcUF
         gZCDJulqn91tBaR6YFKxqlUroiSBhGPwX5PIdxlahkW8tOb40qpKf/R5ugDzOWMq7M4i
         UeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697736536; x=1698341336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/yIZoK7/bYFsNbbqGOq2HXOM4InMO1xEo5GdQEL0RU=;
        b=QTzUqrEsFPm2lKu+3WKtkUYbUAt39xTXJIXNIVEHt3g1xRpjGSKyXHVjIoIn7k8n/l
         JTSEpPeYJm50QMUp0M8UlPSMRPs2oe0GGgqY/P4rPP7S8kJutBgD2TvvgVotAdty+X28
         AMnCpMpHdL4nN5njHDSCuNZ5vic2Nfo7UUw16MIt6c7GD65KrWXGB2fJC0A+bQXXcSyW
         l4bfvVlcR5BL0qPZvlWilgYrgb1BqAjT797vc30Kj9gGPRlE8Rq5+YEMF0GoSMI4vxVx
         czupPeyYnyVotzBPVA4/+hi79YF0r+hy89gOXPjTHDzkM+qpZJm8jlboiUBKNcvWBIkj
         5SOA==
X-Gm-Message-State: AOJu0YxLq+0CoewzteUdxFdbeNhN6bXs0Ra8thLdbWE/9bKaFitGK9wh
	QNtz1ga/06sQUXapSU5HJJ1PUveql2vLL3R8SDVOVw==
X-Google-Smtp-Source: AGHT+IFYMVdUlY/ixoA4vEbFQildLhzt4mIsDh9UOp2ZeMc0qV7dqFprWC5FnSTeFpMRu5W2RiP1LQ==
X-Received: by 2002:a05:6214:e6c:b0:66d:11fd:c9c4 with SMTP id jz12-20020a0562140e6c00b0066d11fdc9c4mr2904672qvb.46.1697736536118;
        Thu, 19 Oct 2023 10:28:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id pm10-20020ad446ca000000b0066d1f118b7esm18211qvb.1.2023.10.19.10.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 10:28:55 -0700 (PDT)
Date: Thu, 19 Oct 2023 13:28:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 5/7] bulk-checkin: introduce
 `index_blob_bulk_checkin_incore()`
Message-ID: <48095afe80fa94a4e9b47f95e9e5821e690075c3.1697736516.git.me@ttaylorr.com>
References: <cover.1697736516.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697736516.git.me@ttaylorr.com>

Now that we have factored out many of the common routines necessary to
index a new object into a pack created by the bulk-checkin machinery, we
can introduce a variant of `index_blob_bulk_checkin()` that acts on
blobs whose contents we can fit in memory.

This will be useful in a couple of more commits in order to provide the
`merge-tree` builtin with a mechanism to create a new pack containing
any objects it created during the merge, instead of storing those
objects individually as loose.

Similar to the existing `index_blob_bulk_checkin()` function, the
entrypoint delegates to `deflate_obj_to_pack_incore()`. That function in
turn delegates to deflate_obj_to_pack(), which is responsible for
formatting the pack header and then deflating the contents into the
pack.

Consistent with the rest of the bulk-checkin mechanism, there are no
direct tests here. In future commits when we expose this new
functionality via the `merge-tree` builtin, we will test it indirectly
there.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bulk-checkin.c | 29 +++++++++++++++++++++++++++++
 bulk-checkin.h |  4 ++++
 2 files changed, 33 insertions(+)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 60361b3e2e..655a583b06 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -368,6 +368,23 @@ static int deflate_obj_to_pack(struct bulk_checkin_packfile *state,
 	return 0;
 }
 
+static int deflate_obj_to_pack_incore(struct bulk_checkin_packfile *state,
+				       struct object_id *result_oid,
+				       const void *buf, size_t size,
+				       const char *path, enum object_type type,
+				       unsigned flags)
+{
+	struct bulk_checkin_source source = {
+		.type = SOURCE_INCORE,
+		.buf = buf,
+		.size = size,
+		.read = 0,
+		.path = path,
+	};
+
+	return deflate_obj_to_pack(state, result_oid, &source, type, 0, flags);
+}
+
 static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 				struct object_id *result_oid,
 				int fd, size_t size,
@@ -431,6 +448,18 @@ int index_blob_bulk_checkin(struct object_id *oid,
 	return status;
 }
 
+int index_blob_bulk_checkin_incore(struct object_id *oid,
+				   const void *buf, size_t size,
+				   const char *path, unsigned flags)
+{
+	int status = deflate_obj_to_pack_incore(&bulk_checkin_packfile, oid,
+						buf, size, path, OBJ_BLOB,
+						flags);
+	if (!odb_transaction_nesting)
+		flush_bulk_checkin_packfile(&bulk_checkin_packfile);
+	return status;
+}
+
 void begin_odb_transaction(void)
 {
 	odb_transaction_nesting += 1;
diff --git a/bulk-checkin.h b/bulk-checkin.h
index aa7286a7b3..1b91daeaee 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -13,6 +13,10 @@ int index_blob_bulk_checkin(struct object_id *oid,
 			    int fd, size_t size,
 			    const char *path, unsigned flags);
 
+int index_blob_bulk_checkin_incore(struct object_id *oid,
+				   const void *buf, size_t size,
+				   const char *path, unsigned flags);
+
 /*
  * Tell the object database to optimize for adding
  * multiple objects. end_odb_transaction must be called
-- 
2.42.0.405.g86fe3250c2

