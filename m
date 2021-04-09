Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AE2C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8C98610CD
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhDISMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbhDISMe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:12:34 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9512BC061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:12:20 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id t14so5454112ilu.3
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S1ySFHRG+npC90ooRQ0ysx7tyG5oQfPYJznoh4OAs70=;
        b=iK0kkzDZISCcRhWOTKku2/3PPnkOHQW36S2H9tyCCXxCbtNj+4xyir8jDgo9X228yy
         aitf2HxCG9QQ9XU9lTlBNmhrRmGUJzeYPMSdhhv33ODsEMZhdqGU38wod08FYNwkKFqZ
         4dBt8q6Yo3OOgjvIgKW4qz6RFi9yHtVoLDxXPyM+h2h5NcKFV2hRRsIIfNdxQRmi+eqE
         nDjUO9cZ0ns/lUeiqy+9f5ciB3tVKd/kuSQIPDrEUGVM4byr5QpL8GSioHtlQCxcVozC
         D2yVXePd0V+Ch9zTylRpzb9M+RshR7PBB+Nd/uFvwjwTAVEMBVtcUb28rDOG7zFiJnCq
         VqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S1ySFHRG+npC90ooRQ0ysx7tyG5oQfPYJznoh4OAs70=;
        b=bxPM7sSBe+FoCFa/BqDMMRtPfpBEHYY/J+LAAeMvD7DoXG8r5s16LDm3oYSO0PnMvj
         2tvcClPjdCWuu6x/2Hr0ps7QpuJ8wV7PUYblOYor79o0sFLzLiRzthEK05KbW8Rnvjlb
         CqLnWE8yn9DqhOY4au6pyxj02IpEkt9wvcjEqdMmblNkMC4F4E1gZSyyXBbmCFGYVcU1
         N+kBzvfNuD7FwGjW6uK9AQomYTfOtf+449QxVT5stmb4L1Kw5Ss7RZjtoqGB3omcdsBb
         jC5OciomBzsxx5L1fasUvp5q8kPCK8ZLmeMaCaUiYXe/2YasNrtLw7lFRnmqtIbRuuvQ
         c1Ag==
X-Gm-Message-State: AOAM532+P6QMm+iMjcCvcMpYvQXDtZ0bevFASYwgXekc1VAQOnyxIkN1
        1j3rwnl7txN2FfU41MfqBXf31Td3ec4pQe/u
X-Google-Smtp-Source: ABdhPJxnJsn0nEhO97VW6ZDyp/0ME/41mBtTyQiFwKmw03DSzQnt07cU/x9Iw/U1SWrwLGJr1elPcA==
X-Received: by 2002:a92:3647:: with SMTP id d7mr13129503ilf.264.1617991939794;
        Fri, 09 Apr 2021 11:12:19 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64f1:fbc0:31eb:386a])
        by smtp.gmail.com with ESMTPSA id m1sm1485583ilh.69.2021.04.09.11.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:12:19 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:12:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH 20/22] midx: respect 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
Message-ID: <83614f928486577892f9345f6a91a6240b47e173.1617991824.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
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
index 2847fdfbab..3cb843fb59 100644
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
 
@@ -720,8 +723,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
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
index a66b5e8c75..7c55a5033e 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -22,6 +22,7 @@ linux-gcc)
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
index fd9375b146..956731da44 100644
--- a/t/README
+++ b/t/README
@@ -420,6 +420,10 @@ GIT_TEST_MULTI_PACK_INDEX=<boolean>, when true, forces the multi-pack-
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

