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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C94C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ACD260555
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346878AbhIHBny (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 21:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346698AbhIHBnt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 21:43:49 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8466DC0613D9
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 18:42:40 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q26so726455wrc.7
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 18:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UkV8L6mxUeISHBX+MaekVPfswRsMwROBmHz98kMVj+0=;
        b=obWf1NYpggSYG79EeXy8vwyTw8viML+sCv4WaVRIe4sBXXb1PBSzMRLT76GE/Bd5FN
         tFTWg0z+Jwh+LNAm6Nx2/fztiZ7TWqd46j33+EDsd8wgD0H6hrvTqYibKokbYYP3n2ks
         QjeBxp6UT/0CvS1l39++yU8oNvENlVnL52SUV09AaqQ0V3xdnQvIQ6OA6yAWb+hvPSz4
         dG+2qrcc0BUIHfAWZebWuVuDSBeAkiu8jTi1XyQE6kdQc6OM10pPCzOhQLOAXdeN8d1D
         Icc8Awp245Ko631xIaobnrI+Gq7/Z/CVd/SriiwMTNFLHVC0DTGrQM5Xk0ttcJsajYtY
         UxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UkV8L6mxUeISHBX+MaekVPfswRsMwROBmHz98kMVj+0=;
        b=JFce9/e85EixD2FbvhflGTv4e81QCfJ/eqmpfVXQasJ95Fr2AhglHOoJVYtLtxzE0p
         db8GRvYYNDBjsCL+woKE0kKT6WWHdzwSdsm2VTPY/rB2i+TSt7yPEBxHKKmF7MlC/wYc
         adfsOmYF2dZa/yqhEvnsV8S0kJp9X9q8ZIAAUKBlHZ8VUdTxRKRqRspNpznhAMXiOV/6
         9b2Mz1eHahbA6NjDGLrIybMlnOdbvQNiWWEoWZ113Mb+cRcxx/UdYpaD8H244+h/O1p4
         d0961+R6jCEFIf3gWPFma3mNjZZkcjuDL0g2TUNTOhJo1uMH1gk8C2TLv+UkJqNT9DT/
         GeLw==
X-Gm-Message-State: AOAM531oJmhwT4dfZSCU4YR9fmF0Egq0cL7lMygooooM/CBo9AceY77g
        jORJpkzLFfpv0HErEuMu516JxKF2TvQ=
X-Google-Smtp-Source: ABdhPJyK5TgcxF9FSwL6GlCRyv1sZl9WnMTqknUYSDCqEk6vlRSvrPEl4PVGoMd5pEtELzr6Vu6oZw==
X-Received: by 2002:adf:f88d:: with SMTP id u13mr1121577wrp.297.1631065359233;
        Tue, 07 Sep 2021 18:42:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3sm731308wrv.18.2021.09.07.18.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 18:42:38 -0700 (PDT)
Message-Id: <6ec3cb2042e1064387dba410c9494a6dc8be0e54.1631065353.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v5.git.1631065353.gitgitgadget@gmail.com>
References: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
        <pull.1009.v5.git.1631065353.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 01:42:31 +0000
Subject: [PATCH v5 7/9] attr: be careful about sparse directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 attr.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/attr.c b/attr.c
index d029e681f28..79adaa50ea1 100644
--- a/attr.c
+++ b/attr.c
@@ -14,6 +14,7 @@
 #include "utf8.h"
 #include "quote.h"
 #include "thread-utils.h"
+#include "dir.h"
 
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
@@ -744,6 +745,20 @@ static struct attr_stack *read_attr_from_index(struct index_state *istate,
 	if (!istate)
 		return NULL;
 
+	/*
+	 * The .gitattributes file only applies to files within its
+	 * parent directory. In the case of cone-mode sparse-checkout,
+	 * the .gitattributes file is sparse if and only if all paths
+	 * within that directory are also sparse. Thus, don't load the
+	 * .gitattributes file since it will not matter.
+	 *
+	 * In the case of a sparse index, it is critical that we don't go
+	 * looking for a .gitattributes file, as doing so would cause the
+	 * index to expand.
+	 */
+	if (!path_in_cone_mode_sparse_checkout(path, istate))
+		return NULL;
+
 	buf = read_blob_data_from_index(istate, path, NULL);
 	if (!buf)
 		return NULL;
-- 
gitgitgadget

