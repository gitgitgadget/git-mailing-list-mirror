Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FE6C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 23:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355614AbiFOXgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 19:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353164AbiFOXgE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 19:36:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6B81F2F1
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:36:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g4so664112wrh.11
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z8+UMTp30b1F78jgENYieuMCerJSCWnKSUPMDjMHk04=;
        b=Ivy7WaHPqjGX6KDO4S2I8rVQj41lhgo9ekrlWaIrfrFyBFtYS2JzQlqyHVk1eud52S
         MS/mK8n2wQ8gM0EaDwJDKSG5u5atJwhL5FF6qyiaflCbeGvgioRQDdfFT6jlyiqSs4O/
         A/s7rl/OZAJqg2iAG3Wrkp2SCmtqnOlu2/61gXUg9FiOxY9y3rheK5/rUvYFgB0z5PoE
         I660M/rZOiVV9IJujKKHw18uQ5QN4tudXX165wapVC4SLtCAVoLqfhjgVkanzrmlRtcM
         TVAVbbf86JNLzUtJouV8rwGLugeTWMH7Ol8xn814zQc/q5hLYtoJRo92m10OzULIt7Kh
         28eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z8+UMTp30b1F78jgENYieuMCerJSCWnKSUPMDjMHk04=;
        b=Og7O+BhNlI1a07OJ1MA8O3Q9QMknJ/vAZAb8qAIoOge3DeSs1hyZjApXaMMCCoDf9H
         /vld+4XD0zIEbpltPVciOMknM3AQQmRsrn7DE6LxCYQ8oZN706LaKlY0oE7WsDlw1M1G
         wXgHDVSwGbgxUGLxOb5+bHIbO5uV74J2MPWCHBjPt19sMa1++VYgXYsY7ZVa0gzsiSaK
         XS3cBDEYWLCrGDrogJ3rKcLA6Fn4XAbmimcIjj+jOuyIvZlT0fWxnBRlls1giaKFwVdw
         cwUEvjrTC7xyHuXR/gk2dDMA+oehM5xaAdDAw8RHhCA6O3ffJpCvsw+fca91JBQWgk3U
         lCmg==
X-Gm-Message-State: AJIora/IRniMcTNDReAHxrooDZbqxIyJ843O2rr2GRwuFc/8dZfhTihX
        Tc+QSlkVf2vrMcUgDGB1FXwKZhqXMw6Rbg==
X-Google-Smtp-Source: AGRyM1vUPb0ZIGGxeRsxREdHl5WNqV5CFStRkFrpjffwwiLASiNVz/UMcSP82r3On+qv0ZXg5Nkh7g==
X-Received: by 2002:adf:cc92:0:b0:21a:356e:bda9 with SMTP id p18-20020adfcc92000000b0021a356ebda9mr124570wrj.509.1655336161182;
        Wed, 15 Jun 2022 16:36:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id be8-20020a05600c1e8800b0039c235fb6a5sm376771wmb.8.2022.06.15.16.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 16:36:00 -0700 (PDT)
Message-Id: <a3f79b3e034a3a982b3be7835062493bfdf29ee5.1655336146.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 23:35:42 +0000
Subject: [PATCH 08/11] read_index_from(): avoid memory leak
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 998330ac2e7c (read-cache: look for shared index files next to the
index, too, 2021-08-26), we added code that allocates memory to store
the base path of a shared index, but we never released that memory.

Reported by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 read-cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index e61af3a3d4d..76f372ff917 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2473,15 +2473,15 @@ int read_index_from(struct index_state *istate, const char *path,
 				   the_repository, "%s", base_path);
 	if (!ret) {
 		char *path_copy = xstrdup(path);
-		const char *base_path2 = xstrfmt("%s/sharedindex.%s",
-						 dirname(path_copy),
-						 base_oid_hex);
+		char *base_path2 = xstrfmt("%s/sharedindex.%s",
+					   dirname(path_copy), base_oid_hex);
 		free(path_copy);
 		trace2_region_enter_printf("index", "shared/do_read_index",
 					   the_repository, "%s", base_path2);
 		ret = do_read_index(split_index->base, base_path2, 1);
 		trace2_region_leave_printf("index", "shared/do_read_index",
 					   the_repository, "%s", base_path2);
+		free(base_path2);
 	}
 	if (!oideq(&split_index->base_oid, &split_index->base->oid))
 		die(_("broken index, expect %s in %s, got %s"),
-- 
gitgitgadget

