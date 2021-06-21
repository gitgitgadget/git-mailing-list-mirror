Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10851C48BC2
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E82396124B
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhFUW2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbhFUW2N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 18:28:13 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E8EC061756
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:58 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id k11so4449375ioa.5
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fzLH9EWtzty/BdnnpE5D2On3mYvZUnuNWIFUpH7BI3g=;
        b=bjWhGIqZc30BkPXh5tPnn8dkn7GIM02n/upLXc1EadHTaO6tTq/RIOPfc5lTXW6P1c
         9Poeey6NpQxeVcGyFp1MVy1S1KuMIla8VPnFsH/qURiB/wixYWYpJDt5s06KAzGWEmJC
         7e8oJHaWlV8CNCFNCXdP7dj39o10b+62i77Zf2LKtqsMgcCYc8/8v9TN0Mh9syspVnQS
         YG6oyOuqoxjK1S1liNT7uQxqQAOXRvTY+Abp4s6O0Ssqj90iYA2fjMY0onxBJ8eYatIo
         6hYOvvU4K3AVZn0z1ZTURDAP0b2nXsXdiilSxmp/Reu7WcXp9WociMAdbPNb7d7hmwa/
         +YWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fzLH9EWtzty/BdnnpE5D2On3mYvZUnuNWIFUpH7BI3g=;
        b=R3548qxDz/9yEx8yr7IJy3ILH6TKkStQ1i4Eum3oyjkNZEwN2RyGZXsplWmaYoVWHP
         ycOHLzFvnOtCniCZQ4lIETWolwQRrKgz6B/oZpkqBX8U6wg0bX8JDfPmc3k1fxX5PXzR
         9rN23wlLQpEO0gvmas2Mzfp0p8FpCL+q7PUSsmu3+vx7RQtRcl34SuK/3ULuO5vAPode
         djSr8wg2yYbL1QJS+IbZfF9IZMmaV+yfx/aDpIDPPyigA9keH4hm0gJSbtqNkD2Aci6m
         6RTCQmGkDNJ04BKPBuBVLN+E/CaVTSb8RjAwqSy1TpFh4tyZJlmkKsSPAEKJeZFRDPgT
         ZQZg==
X-Gm-Message-State: AOAM5302X6oep2oUngckUmqeiAGgjMPK2SoybAieV30VPaDs+jPU7pe9
        gmtFC0swwOSOj+CbH3pGoN6zo3JF+3P5GpyP
X-Google-Smtp-Source: ABdhPJyXJSupetHQ2xC6cyFe6vHoGaw4b7r6cqNXXw3JJLP3VDnEEy49WT7IGuSvt3ZLwsiHuCH1gg==
X-Received: by 2002:a5d:930b:: with SMTP id l11mr224473ion.177.1624314357266;
        Mon, 21 Jun 2021 15:25:57 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id v18sm10541941iom.5.2021.06.21.15.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:25:56 -0700 (PDT)
Date:   Mon, 21 Jun 2021 18:25:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v2 22/24] midx: respect
 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
Message-ID: <00418d5b096c049ddfc738b5d51ef65eae019607.1624314293.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a new 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP' environment
variable to also write a multi-pack bitmap when
'GIT_TEST_MULTI_PACK_INDEX' is set.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c          | 13 ++++++++++---
 ci/run-build-and-tests.sh |  1 +
 midx.h                    |  2 ++
 t/README                  |  4 ++++
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 5f9bc74adc..77f6f03057 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -515,7 +515,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		if (!(pack_everything & ALL_INTO_ONE) ||
 		    !is_bare_repository())
 			write_bitmaps = 0;
-	}
+	} else if (write_bitmaps &&
+		   git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0) &&
+		   git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP, 0))
+		write_bitmaps = 0;
 	if (pack_kept_objects < 0)
 		pack_kept_objects = write_bitmaps > 0;
 
@@ -725,8 +728,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		update_server_info(0);
 	remove_temporary_files();
 
-	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0))
-		write_midx_file(get_object_directory(), NULL, 0);
+	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0)) {
+		unsigned flags = 0;
+		if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP, 0))
+			flags |= MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX;
+		write_midx_file(get_object_directory(), NULL, flags);
+	}
 
 	string_list_clear(&names, 0);
 	string_list_clear(&rollback, 0);
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 3ce81ffee9..7ee9ba9325 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -23,6 +23,7 @@ linux-gcc)
 	export GIT_TEST_COMMIT_GRAPH=1
 	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
+	export GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=1
 	export GIT_TEST_ADD_I_USE_BUILTIN=1
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_WRITE_REV_INDEX=1
diff --git a/midx.h b/midx.h
index 350f4d0a7b..aa3da557bb 100644
--- a/midx.h
+++ b/midx.h
@@ -8,6 +8,8 @@ struct pack_entry;
 struct repository;
 
 #define GIT_TEST_MULTI_PACK_INDEX "GIT_TEST_MULTI_PACK_INDEX"
+#define GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP \
+	"GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP"
 
 struct multi_pack_index {
 	struct multi_pack_index *next;
diff --git a/t/README b/t/README
index 1a2072b2c8..1311b8e17a 100644
--- a/t/README
+++ b/t/README
@@ -425,6 +425,10 @@ GIT_TEST_MULTI_PACK_INDEX=<boolean>, when true, forces the multi-pack-
 index to be written after every 'git repack' command, and overrides the
 'core.multiPackIndex' setting to true.
 
+GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=<boolean>, when true, sets the
+'--bitmap' option on all invocations of 'git multi-pack-index write',
+and ignores pack-objects' '--write-bitmap-index'.
+
 GIT_TEST_SIDEBAND_ALL=<boolean>, when true, overrides the
 'uploadpack.allowSidebandAll' setting to true, and when false, forces
 fetch-pack to not request sideband-all (even if the server advertises
-- 
2.31.1.163.ga65ce7f831

