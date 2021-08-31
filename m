Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2927FC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10A7B6103A
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241384AbhHaUxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241360AbhHaUxt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:53:49 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380ABC061292
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:45 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id e186so734452iof.12
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C1W1zkLF6+PUEqyzPRKGz+wxHjEIxGpKnu9spXfGQyg=;
        b=EEmyyAWfQ0iIDdBmeTnkceImv8ZpYLaAFhnSNEXhrPmHC5oD50rZQkoTOoRCV6/ghD
         Pe50dZFxwSdEB/md77sL/p6rT6fj0/uW+Jz379gszrZpzlSxqLjJNgQBftwndEAhHHIe
         gu2CEJYhdUyckuV1Y8txqKNqU37QKhAWdq7oXsuvRHCDvip9A83+87XThCO71fSxp6Mf
         t/ofZFFRYgZXrHGSTMPvadSvffDiohmC92y7IPS5olXW/vHYmuj+5mIAcUT6YJ+4rjzC
         gVYSZczknxc/GzhPLiNYtovxqumtgpBSqOP66k95putpCiKc2umvPR9KIEjh1pEjQHC6
         q8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C1W1zkLF6+PUEqyzPRKGz+wxHjEIxGpKnu9spXfGQyg=;
        b=Xsc5AqBotopI/qooc2u3vqafX35PMv4jH8rGZYwelzsaB4srzHYluwwgQ7kDGuQyK+
         YyEqqLCsvA4AveEzGI8O5lsHZNgimI+V1RRYMqu4fFg2Nnxo4lTTGkWKPHCsDJ6P6Z+f
         cexk8L53g2K8K77ezYCDIFRVDz5lwtGFsgm0OdQidiRG8Dq158VcdyO0fWbwhzpHB9nP
         mMTdXZDAvWe1H0Z4TVYoRAa1EFUep4vO/Hgh7IPyFufQ3rTWtsci+qlcN0Yfwu02d6pB
         Td4Pa+dpy8HOMo8lwaLAz0mfuuMo78rFamhX50QAm+RFLlUPwdSLhIOoXUXX3w5sb5YG
         UJLg==
X-Gm-Message-State: AOAM531cImmBdog9IEB0t8oYkgmWP1Ahi8OHuC8VCpUwnKkFRFna7OkZ
        VE7kZaccbJCKkBTFC3balGusJHjBfFTOC9vw
X-Google-Smtp-Source: ABdhPJzfizQ40jN8oaR8y/2M+WP4b84//ZfbS6cPC5Nv6DDe7538QNnsbFlT0TzlMU7SS1AAnFsT0Q==
X-Received: by 2002:a02:9542:: with SMTP id y60mr4500102jah.87.1630443164516;
        Tue, 31 Aug 2021 13:52:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a14sm10666950iol.24.2021.08.31.13.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:52:44 -0700 (PDT)
Date:   Tue, 31 Aug 2021 16:52:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v5 25/27] midx: respect
 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
Message-ID: <44a4800756de7749e17cea0db5790a876db96d28.1630443072.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630443072.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a new 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP' environment
variable to also write a multi-pack bitmap when
'GIT_TEST_MULTI_PACK_INDEX' is set.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c          | 12 ++++++++++--
 ci/run-build-and-tests.sh |  1 +
 midx.h                    |  2 ++
 t/README                  |  4 ++++
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 5f9bc74adc..82ab668272 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -515,6 +515,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		if (!(pack_everything & ALL_INTO_ONE) ||
 		    !is_bare_repository())
 			write_bitmaps = 0;
+	} else if (write_bitmaps &&
+		   git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0) &&
+		   git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP, 0)) {
+		write_bitmaps = 0;
 	}
 	if (pack_kept_objects < 0)
 		pack_kept_objects = write_bitmaps > 0;
@@ -725,8 +729,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
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
index 9e70122302..12014aa988 100644
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
2.33.0.96.g73915697e6

