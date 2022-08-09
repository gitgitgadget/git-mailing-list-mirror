Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAA1C25B07
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 12:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241015AbiHIMKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 08:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242311AbiHIMJz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 08:09:55 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6091524BEC
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 05:09:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id f30so10221542pfq.4
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 05:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6l1zv2CXMwR3LHzu3Jl1gx8XHmOFgfBZ9b1NaiObAKM=;
        b=a59wehEsKcxjJ8E81GLLM0mIFlwVDf+//QD0LCtQfJavrNd+4dUZesVoPJTFecyN2T
         4ESpthgdHS+cnjvCFvzrzwNCPBROPpwcuC8sPoJYril/aUUmbzsVaWKDOO6iiHrO+VJc
         RMiMsmTYDsbtI5wQQuzKYu9Io/YSj26jwNHK05/GneRjLt5BTKl5q76YnfCe1i5GDwK+
         fJm2yci3BEWsvMk888b2fP4Jh4iHqlqDUhwLeZo8wi9ODfkzWot1fSbsg6p2ZjZUZMfN
         Y6ii7OHFXWxkJhiJA4g858cKqaQrT6voDWeKHfAyABSAJkuiUqLDMAWwHBD+ng8sF+og
         ac/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6l1zv2CXMwR3LHzu3Jl1gx8XHmOFgfBZ9b1NaiObAKM=;
        b=E30knguYDjfBTjmNqY4BMe1GWBPORdCIoUcJoSFCNCZPB+dQcfv3GatvBmrhknfuI3
         t/0zXj7tBWWyc+o5sNwaBqkdjmvKJdzpD+LEjL/FEILKoMWMGJdDl+0B3cF2mV4Hwxk5
         PkSr/VHwGKTKSt1xll97ztUa/TLUHY6NJnx6eITaNm6PQH+beGg9se8jjE29bGMAgvIB
         +e+TmJC7j9dkGaX+UoiVstrpDSD12VHewNozLgB5pAzTWMAFOYCKNIj2t+We9wG2lYp0
         2/CFWzAgXYNbypoxx6XQ1hH3Q3wXXt0QMs0qR439X53bFoxBuDcU8MIPmtwncqbJ5M4P
         Jaxw==
X-Gm-Message-State: ACgBeo3oWR5pcMjlcoC0xXKzKW/sta70hObSSZ6TTQgr7PyEMvLElldD
        Ofp17WFXMs6+zAW9O+O6/RdGSV25ehS6cQ==
X-Google-Smtp-Source: AA6agR7cswXUQL61WYfwZNdfl+RR4PBbDQ25Tij1dFEC5RhX3YDp6Red1TDwBNKQb/K8UCeyxwgefg==
X-Received: by 2002:a63:4511:0:b0:41d:70c0:ffbf with SMTP id s17-20020a634511000000b0041d70c0ffbfmr8305389pga.574.1660046987956;
        Tue, 09 Aug 2022 05:09:47 -0700 (PDT)
Received: from ffyuanda.localdomain ([120.239.67.140])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b0016d10267927sm10511485pll.203.2022.08.09.05.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 05:09:47 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v3 9/9] mv: check overwrite for in-to-out move
Date:   Tue,  9 Aug 2022 20:09:10 +0800
Message-Id: <20220809120910.2021413-10-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add checking logic for overwriting when moving from in-cone to
out-of-cone. It is the index version of the original overwrite logic.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c                  | 12 ++++++++++++
 t/t7002-mv-sparse-checkout.sh |  6 +++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index a396a030c7..2d64c1e80f 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -377,6 +377,18 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			goto act_on_entry;
 		}
 
+		if (ignore_sparse &&
+		    (dst_mode & (SKIP_WORKTREE_DIR | SPARSE)) &&
+		    index_entry_exists(&the_index, dst, strlen(dst))) {
+			bad = _("destination exists in the index");
+			if (force) {
+				if (verbose)
+					warning(_("overwriting '%s'"), dst);
+				bad = NULL;
+			} else {
+				goto act_on_entry;
+			}
+		}
 		/*
 		 * We check if the paths are in the sparse-checkout
 		 * definition as a very final check, since that
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 5e5eb70e7a..26582ae4e5 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -323,7 +323,7 @@ test_expect_success 'move clean path from in-cone to out-of-cone' '
 	grep "S folder1/d" actual
 '
 
-test_expect_failure 'move clean path from in-cone to out-of-cone overwrite' '
+test_expect_success 'move clean path from in-cone to out-of-cone overwrite' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 	echo "sub/file1 overwrite" >sub/file1 &&
@@ -359,7 +359,7 @@ test_expect_failure 'move clean path from in-cone to out-of-cone overwrite' '
 # This test is testing the same behavior as the
 # "move clean path from in-cone to out-of-cone overwrite" above.
 # The only difference is the <destination> changes from "folder1" to "folder1/file1"
-test_expect_failure 'move clean path from in-cone to out-of-cone file overwrite' '
+test_expect_success 'move clean path from in-cone to out-of-cone file overwrite' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	setup_sparse_checkout &&
 	echo "sub/file1 overwrite" >sub/file1 &&
@@ -392,7 +392,7 @@ test_expect_failure 'move clean path from in-cone to out-of-cone file overwrite'
 	test_cmp expect actual
 '
 
-test_expect_failure 'move directory with one of the files overwrite' '
+test_expect_success 'move directory with one of the files overwrite' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	mkdir -p folder1/dir &&
 	touch folder1/dir/file1 &&
-- 
2.37.0

