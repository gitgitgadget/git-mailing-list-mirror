Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA360C433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 20:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbiDYUcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 16:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245401AbiDYUcR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 16:32:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8E831509
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 13:29:06 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso283224wma.0
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 13:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/oIz52aIHjAlcJXU74vMc+4p3pNDrUUIIa8JYX462jg=;
        b=bY4vbHjZku82qeHoN3pwu9XMeSV+YrsQ+Qfebwisxf8+t4dJPvHtlIdsl/EKKySWad
         qCiWxaLu1Dyhjdl4fmtcbMl+bM7rkHNibHdv1hy1AguIrB9CyJRUtK0MDQnTC4KH++67
         hixLGsIrtxQIv+TZ/UPGPJYn5uQ/a8mNNW1Bvk30+eXqBIjdn9/6FoDCaHQvFJ+Pwqfs
         vQ3V18a7bHNm/6xHiD1K2TsyjSZxlgG5PjU9wuKey4IiYTI7K6ZsOuuMcpKp8HS0UXDf
         /a6BinsETnawil7Y5t61pDpRGPXLjPCoFmSa3xZ944m0mL9iZ3GURthaE/lGaIPw40Bs
         IVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/oIz52aIHjAlcJXU74vMc+4p3pNDrUUIIa8JYX462jg=;
        b=Ch/B97871X8ys2G4d4Os6/qKjQq3m35omqBRwMJwrIb3G7l6HTGhpPtC1Cxehk6yO0
         H8Z25qCH3c0FFFFySN4xvr722y/bVOUjVMiGfuITOdUmLS5G9Oqk0UGUx7pHlP/TMgIM
         pDiQCCIIRnrZ9Hew97J5RfVBaxLVuppBWzOp7MjDuJ1jYKhijl9VlNuaWZX239graWXu
         3GVY2ZhOXFiC2CQo+hK9mQ6+vSKqTCoY5EwK7iKGHS716OlHDvXiG3SL3UIGm5xv+rRj
         EEBMfpn+P9XrxHejX1SYZQgqRslmo+1Whyv08dGEDjYDwvb/5Hcnusq9exNwWkDsRv9U
         aiSQ==
X-Gm-Message-State: AOAM530cA0zbP9fAQbc7YN9YTM/WXQPfeASlVi1RWCH/mG+UqoVlaEsh
        L2801t0i1TAK4bIGpfZkeKE=
X-Google-Smtp-Source: ABdhPJzQCbcgKMSgXwPdq8CMd8YzwszUMvd5zc4+AmyLzxFaE9jvhpFEDoNgR0HZCdqhmX4DLylARg==
X-Received: by 2002:a05:600c:4f08:b0:391:fe3c:40e6 with SMTP id l8-20020a05600c4f0800b00391fe3c40e6mr27336651wmq.34.1650918544737;
        Mon, 25 Apr 2022 13:29:04 -0700 (PDT)
Received: from localhost.localdomain (123.79.195.77.rev.sfr.net. [77.195.79.123])
        by smtp.gmail.com with ESMTPSA id h9-20020adfa4c9000000b0020ae2a771fdsm876256wrb.72.2022.04.25.13.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 13:29:04 -0700 (PDT)
From:   Jonathan <git.jonathan.bressat@gmail.com>
To:     gitster@pobox.com
Cc:     Jonathan.bressat@etu.univ-lyon1.fr, Matthieu.Moy@univ-lyon1.fr,
        cogoni.guillaume@gmail.com, git.jonathan.bressat@gmail.com,
        git@vger.kernel.org, guillaume.cogoni@gmail.com
Subject: [PATCH v1 2/2] merge with untracked file that are the same without failure
Date:   Mon, 25 Apr 2022 22:27:21 +0200
Message-Id: <20220425202721.20066-3-git.jonathan.bressat@gmail.com>
X-Mailer: git-send-email 2.35.1.7.gc8609858e0.dirty
In-Reply-To: <20220425202721.20066-1-git.jonathan.bressat@gmail.com>
References: <xmqqfsmg97ac.fsf@gitster.g>
 <20220425202721.20066-1-git.jonathan.bressat@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In unpack-trees.c in the check_ok_to_remove() function: add a new
statement, if the file has the same content as the merged file, it
can be removed.

test this new behaviour in t7615.

Signed-off-by: Jonathan <git.jonathan.bressat@gmail.com>
Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
---
 t/t7615-merge-untracked.sh | 8 ++++----
 unpack-trees.c             | 5 ++++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/t/t7615-merge-untracked.sh b/t/t7615-merge-untracked.sh
index 053e6b80ee..99f8bae4c0 100755
--- a/t/t7615-merge-untracked.sh
+++ b/t/t7615-merge-untracked.sh
@@ -12,13 +12,13 @@ test_expect_success 'setup' '
 	git checkout -b A
 '
 
-test_expect_success 'fastforward fail when untracked file has the same content' '
+test_expect_success 'fastforward overwrite untracked file that has the same content' '
 	test_when_finished "git branch -D B && git reset --hard init && git clean --force" &&
 	git checkout -b B &&
 	test_commit --no-tag "tracked" file "content" &&
 	git checkout A &&
 	echo content >file &&
-	test_must_fail git merge B
+	git merge B
 '
 
 test_expect_success 'fastforward fail when untracked file has different content' '
@@ -30,14 +30,14 @@ test_expect_success 'fastforward fail when untracked file has different content'
 	test_must_fail git merge B
 '
 
-test_expect_success 'normal merge fail when untracked file has the same content' '
+test_expect_success 'normal merge overwrite untracked file that has the same content' '
 	test_when_finished "git branch -D B && git reset --hard init && git clean --force" &&
 	git checkout -b B &&
 	test_commit --no-tag "tracked" file "content" fileB "content" &&
 	git switch A &&
 	test_commit --no-tag "exA" fileA "content" &&
 	echo content >file &&
-	test_must_fail git merge B
+	git merge B
 '
 
 test_expect_success 'normal merge fail when untracked file has different content' '
diff --git a/unpack-trees.c b/unpack-trees.c
index 360844bda3..61e06c04be 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2257,6 +2257,8 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 	if (result) {
 		if (result->ce_flags & CE_REMOVE)
 			return 0;
+	} else if (!ie_modified(&o->result, ce, st, 0)) {
+		return 0;
 	}
 
 	return add_rejected_path(o, error_type, name);
@@ -2264,7 +2266,8 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 
 /*
  * We do not want to remove or overwrite a working tree file that
- * is not tracked, unless it is ignored.
+ * is not tracked, unless it is ignored and unless it has the same
+ * content than the merged file.
  */
 static int verify_absent_1(const struct cache_entry *ce,
 			   enum unpack_trees_error_types error_type,
-- 
2.35.1.7.gc8609858e0.dirty

