Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7A6C433F4
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68598619D4
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhC3NLt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbhC3NLR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 09:11:17 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B818EC061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:16 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c8so16173972wrq.11
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/OlR0ax3xndSWGKKDFthuKiuhYT+sjq9OOppgrZbaSQ=;
        b=IFsklqqtyKWhVgjvdGbyewfHXtO7SJ0ozoMkFbe2P5t8s7eR3T9rz2y64gE/KeeP8E
         4c5MMiudMZWcX2jUFSSyeZT4OttNkklJxrdB6q9BHcM4AA/MrtT/3RVPTnGou+5SAB0S
         MBRRYheIhDfWDpO9iV+QX6dvtvvNrMGsaiRmrutM3kwhj6bYTXE7oEjwrHZY0d/X3vSK
         kscIRcS41GBHkyfQ89dQEy/O5pIvkjY8RcsxwUglzoxaV48xs4fIHiLC6I37Av/yX0K1
         2g9QROUZ30zgZDL2FihyB3QRtvic83ek3KSOrHW2l35UeJhFx2p5BYWvvFtz5ATmxBVz
         fl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/OlR0ax3xndSWGKKDFthuKiuhYT+sjq9OOppgrZbaSQ=;
        b=h13zhcZLrH79jrVMrLSPEXQeLcdGTKJiL+CAg61Ge+HBOuB0K1Vf9yXGZmrKmgOIaF
         jIDkty+MxcypkkjA+N6ILbIz5cRQsPgOG5q2BhspREpizHSMK4WanCU5Tqlsz2U6qziy
         MtRuA+AczxQNz576U2EYCwT5SOw+CF6TeX7J6w8s0COro3yOgM6Dplm4medeAYlxM3VV
         DnAxXUTD2EHoVvSEv21G2Cx1ZrpGCsBLpgdhlkIQRG+Ax5+Xi3atBUvgL8m6BIO/aQZj
         CuccM2WIBrKhhKNWccLmessOTP4co0Wc4i8fVkEBvfiilEFmwsvG4OWqsuOBjsu2nPzG
         9fWw==
X-Gm-Message-State: AOAM533LSmBnCm6JF/fmKMo+qwwPQx94Z0+33gbqr5sVsjqM4NC2y6Kk
        SLySzO+ZFTH6nsCVoYw7UBbg3seH4GQ=
X-Google-Smtp-Source: ABdhPJxOfY0EsTR8vfowD2HpTmMxqbHX5l/mTI21XhnY87XKwxvs1ZBu63ZdwqIiyVa+85NCt08ZTA==
X-Received: by 2002:a5d:63c8:: with SMTP id c8mr33708983wrw.299.1617109875569;
        Tue, 30 Mar 2021 06:11:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 81sm3682171wmc.11.2021.03.30.06.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:11:15 -0700 (PDT)
Message-Id: <f926cf8b2e019c710e164521bf90f7d948c7aa3d.1617109864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
References: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
        <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Mar 2021 13:10:54 +0000
Subject: [PATCH v5 11/21] sparse-index: add 'sdir' index extension
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The index format does not currently allow for sparse directory entries.
This violates some expectations that older versions of Git or
third-party tools might not understand. We need an indicator inside the
index file to warn these tools to not interact with a sparse index
unless they are aware of sparse directory entries.

Add a new _required_ index extension, 'sdir', that indicates that the
index may contain sparse directory entries. This allows us to continue
to use the differences in index formats 2, 3, and 4 before we create a
new index version 5 in a later change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/index-format.txt | 12 ++++++++++++
 read-cache.c                             |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index 3b74c05647db..65da0daaa563 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -392,3 +392,15 @@ The remaining data of each directory block is grouped by type:
 	in this block of entries.
 
     - 32-bit count of cache entries in this block
+
+== Sparse Directory Entries
+
+  When using sparse-checkout in cone mode, some entire directories within
+  the index can be summarized by pointing to a tree object instead of the
+  entire expanded list of paths within that tree. An index containing such
+  entries is a "sparse index". Index format versions 4 and less were not
+  implemented with such entries in mind. Thus, for these versions, an
+  index containing sparse directory entries will include this extension
+  with signature { 's', 'd', 'i', 'r' }. Like the split-index extension,
+  tools should avoid interacting with a sparse index unless they understand
+  this extension.
diff --git a/read-cache.c b/read-cache.c
index dd3980c12b53..b8f092d1b7eb 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -47,6 +47,7 @@
 #define CACHE_EXT_FSMONITOR 0x46534D4E	  /* "FSMN" */
 #define CACHE_EXT_ENDOFINDEXENTRIES 0x454F4945	/* "EOIE" */
 #define CACHE_EXT_INDEXENTRYOFFSETTABLE 0x49454F54 /* "IEOT" */
+#define CACHE_EXT_SPARSE_DIRECTORIES 0x73646972 /* "sdir" */
 
 /* changes that can be kept in $GIT_DIR/index (basically all extensions) */
 #define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED | \
@@ -1763,6 +1764,10 @@ static int read_index_extension(struct index_state *istate,
 	case CACHE_EXT_INDEXENTRYOFFSETTABLE:
 		/* already handled in do_read_index() */
 		break;
+	case CACHE_EXT_SPARSE_DIRECTORIES:
+		/* no content, only an indicator */
+		istate->sparse_index = 1;
+		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
 			return error(_("index uses %.4s extension, which we do not understand"),
@@ -3020,6 +3025,10 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		if (err)
 			return -1;
 	}
+	if (istate->sparse_index) {
+		if (write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_SPARSE_DIRECTORIES, 0) < 0)
+			return -1;
+	}
 
 	/*
 	 * CACHE_EXT_ENDOFINDEXENTRIES must be written as the last entry before the SHA1
-- 
gitgitgadget

