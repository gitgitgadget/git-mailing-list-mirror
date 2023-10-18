Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DE0450D2
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mzK26bQK"
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0525C119
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:32:49 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41cc7379b23so434651cf.3
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697653968; x=1698258768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=88cy3xkxr/QRAgozGxl3AsK//RK8uTvt0H3vDlw2PBo=;
        b=mzK26bQK+lt60o6eFQaKdlkZdtrkfOpbJDn7bLgqcPJgUIb8V5OMKthJc+5bvv71tU
         1I6fVa+JNykad20775+EGu5+AFOptyhdVD/d+Z5AxFmtJl7YQwYbAcdVzaVXb++nN2ht
         GCOLSWVUTkQEWkIRohj7P9vMDyLiCMgUqgXyaeTyiWpjXgzPwVHWP0KWhGxrU3v6K8ly
         nAObqL/nvh/eS7vaFF/OA2pPtTBTbo8mug0S57cib8m5e6Lw0vahik5posBEwMBH1/6c
         cOdfiuX8GfxUOyqYkM19pkFqGfm0TMIDE/HfSajPSZlP7Pagw+lXz/7AjKp8XSiYMicZ
         Ycuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653968; x=1698258768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88cy3xkxr/QRAgozGxl3AsK//RK8uTvt0H3vDlw2PBo=;
        b=LYmohNkAktbU3x6AzI/pAbFxYxMkhFUmEHcFSM1E/03A+aJ9hCU/6X/sqEC/g8NpkF
         zIa1KjgN0XsRDL4f6dos9frrZofHNOHoVDYTuItbwFMKT7MhscMhRDz9AN1cnJgnRbm/
         RuO6HC8U6miI2kBQuosH1VNkLbOBS0cevpFhmi72FN85uxoRYUHEOkgG1Ma/jWdNF0bZ
         myVjL12JBRbxyV5Md364g5cUxBVjVUussXOPj9yuIqJ/umkRBb6TYa5N7P8eYtWJUqA5
         7ZQhoyCgFNldqA2HgUPxhGhSXpVognqw5WSRP1BYFtLKHGaWp03kOu2X1YmOHYduQhKt
         LIBA==
X-Gm-Message-State: AOJu0YyetOAodzLwf8R/nG9GKP1Du385YxmInLE6UYlmB+kcdEfPd8jb
	A8OTSBcpjYv3GlnsPZIJfb7CCFQeidbz18LmnVT2Kg==
X-Google-Smtp-Source: AGHT+IF1NY1frRWuLNbt0+WwOEdAEQbVmNpFVwo/pgwfz+x81mmMGCmPb6Xisq3eQT1tJ5NTidZqtQ==
X-Received: by 2002:a05:622a:282:b0:418:1194:42f3 with SMTP id z2-20020a05622a028200b00418119442f3mr106874qtw.56.1697653967948;
        Wed, 18 Oct 2023 11:32:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i12-20020a05622a08cc00b00403cce833eesm149541qte.27.2023.10.18.11.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:32:47 -0700 (PDT)
Date: Wed, 18 Oct 2023 14:32:46 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 06/17] bloom.h: make `load_bloom_filter_from_graph()`
 public
Message-ID: <e002e350044ecf2b141ba2c71b6ce81fadeeefc4.1697653929.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com>
 <cover.1697653929.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697653929.git.me@ttaylorr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for a future commit to use the load_bloom_filter_from_graph()
function directly to load specific Bloom filters out of the commit-graph
for manual inspection (to be used during tests).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bloom.c | 6 +++---
 bloom.h | 5 +++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/bloom.c b/bloom.c
index aef6b5fea2..3e78cfe79d 100644
--- a/bloom.c
+++ b/bloom.c
@@ -29,9 +29,9 @@ static inline unsigned char get_bitmask(uint32_t pos)
 	return ((unsigned char)1) << (pos & (BITS_PER_WORD - 1));
 }
 
-static int load_bloom_filter_from_graph(struct commit_graph *g,
-					struct bloom_filter *filter,
-					uint32_t graph_pos)
+int load_bloom_filter_from_graph(struct commit_graph *g,
+				 struct bloom_filter *filter,
+				 uint32_t graph_pos)
 {
 	uint32_t lex_pos, start_index, end_index;
 
diff --git a/bloom.h b/bloom.h
index adde6dfe21..1e4f612d2c 100644
--- a/bloom.h
+++ b/bloom.h
@@ -3,6 +3,7 @@
 
 struct commit;
 struct repository;
+struct commit_graph;
 
 struct bloom_filter_settings {
 	/*
@@ -68,6 +69,10 @@ struct bloom_key {
 	uint32_t *hashes;
 };
 
+int load_bloom_filter_from_graph(struct commit_graph *g,
+				 struct bloom_filter *filter,
+				 uint32_t graph_pos);
+
 /*
  * Calculate the murmur3 32-bit hash value for the given data
  * using the given seed.
-- 
2.42.0.415.g8942f205c8

