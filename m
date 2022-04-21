Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCFFC433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 14:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389773AbiDUPAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 11:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389751AbiDUPAo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 11:00:44 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10080443C3
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 07:57:54 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w4so7041042wrg.12
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 07:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+ol0+1Qc4bYwYytjRhghEShUA8gWYWE4SDrmV1uHNy4=;
        b=JCab6JprPlTsyc0LCsaoc4cLaVuBISQt/Ui10LVDXeu74+2SalnM79tu6VD2UqpbZG
         yEHOv2MxCh8tVk0k1ARpGYO+LUvp778nFATlnlhDbw/ZUNLQm1/cP0JQJKGKczAgm80u
         NMFIGQ/aUYNUi9dlyY0gjS9znlLUtGf78Q8y+3UjQOm85vqUZQ0zpcUr5UyEzT8tKjvj
         C0DliFBowxPE1cbZgFAGQqmbWy/E5qiLU180v+IXaKyUTqc3A6riNLgLNmok6Nx49H1F
         5aATilFZi91AHK8LR43yt6sGCodcDLS4W95+fHfHoDG5tBbgb2k1xibRb6Wb3Etwq86T
         6C4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+ol0+1Qc4bYwYytjRhghEShUA8gWYWE4SDrmV1uHNy4=;
        b=DhnLYVP1MzlpAnzoGu3KEkBAR7UZtATQDapKHIXQ+MgEk6/aC0jT1rauVrnmZuxs/X
         2c6cY0xym/4obpaTrQB0UhztPVmw3tmvbPpOp+VuVDLmXy6JxycWg6f0Zo36rKFiF3z4
         io5ui3llN0KYWHVqwd6D4/TGIoI+f/UePCQxIqc7cuP9Ne5ReqHDQpKewPRIDFpkTWyy
         I9PgYZU8IsxHDO6NeyHtaX3dnjCTIG4nUoWj3hl+wjiOgwq8IIxyC/QVO73LL09qlBLs
         JHQyEhAs0PEerAGBuENxX+511GxMcgpMdKVyZlYGc96PySJVfssjr39XblMDHJiz5NKT
         z8vw==
X-Gm-Message-State: AOAM5314TeqJ9mdGIO7BA6NArbRfbC9dRnF6lYnNQGzJMRukXuLzgxh4
        2h3rQidIVIJXR1O+ORodZzlsR6y7WMY=
X-Google-Smtp-Source: ABdhPJy001k/ItsA7eg9UURHtF6CoEoAn9yoJ1GviwxpnJPiyBblRmXCSwkHPu0i2urMPBwOyy60gQ==
X-Received: by 2002:a05:6000:2c5:b0:20a:9675:d26c with SMTP id o5-20020a05600002c500b0020a9675d26cmr91451wry.185.1650553072251;
        Thu, 21 Apr 2022 07:57:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b00392951086efsm2430504wmq.34.2022.04.21.07.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:57:51 -0700 (PDT)
Message-Id: <34785a0c7cc6c3547951fb29fc2b3c1cf8be6f54.1650553069.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1221.git.1650553069.gitgitgadget@gmail.com>
References: <pull.1221.git.1650553069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Apr 2022 14:57:48 +0000
Subject: [PATCH 1/2] midx: use real paths in lookup_multi_pack_index()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This helper looks for a parsed multi-pack-index whose object directory
matches the given object_dir. Before going into the loop over the parsed
multi-pack-indexes, it calls find_odb() to ensure that the given
object_dir is actually a known object directory.

However, find_odb() uses real-path manipulations to compare the input to
the alternate directories. This same real-path comparison is not used in
the loop, leading to potential issues with the strcmp().

Update the method to use the real-path values instead.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 midx.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/midx.c b/midx.c
index 107365d2114..3db0e47735f 100644
--- a/midx.c
+++ b/midx.c
@@ -1132,17 +1132,26 @@ cleanup:
 static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
 							const char *object_dir)
 {
+	struct multi_pack_index *result = NULL;
 	struct multi_pack_index *cur;
+	char *obj_dir_real = real_pathdup(object_dir, 1);
+	struct strbuf cur_path_real = STRBUF_INIT;
 
 	/* Ensure the given object_dir is local, or a known alternate. */
-	find_odb(r, object_dir);
+	find_odb(r, obj_dir_real);
 
 	for (cur = get_multi_pack_index(r); cur; cur = cur->next) {
-		if (!strcmp(object_dir, cur->object_dir))
-			return cur;
+		strbuf_realpath(&cur_path_real, cur->object_dir, 1);
+		if (!strcmp(obj_dir_real, cur_path_real.buf)) {
+			result = cur;
+			goto cleanup;
+		}
 	}
 
-	return NULL;
+cleanup:
+	free(obj_dir_real);
+	strbuf_release(&cur_path_real);
+	return result;
 }
 
 static int write_midx_internal(const char *object_dir,
-- 
gitgitgadget

