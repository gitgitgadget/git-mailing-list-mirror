Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF11FC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE3B6610A3
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhHXQSC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhHXQRh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 12:17:37 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F703C0612A7
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:50 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id l10so7315459ilh.8
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SoorQ/GWxuzmOTfjtez+99in0f4knnTQwgEu6e/ih1M=;
        b=JlFbGCfGna9JxUB9J1mXgncnXGOwuHfYH1rIxHit9XpEJ2o5j0jeinQaajYrJJFA+r
         LLYHcD1wpgoj4kQ7YOMYKqFGTWl5tzCvX1HD+DRai9Ap6Z1z/HWO5epv973BhhZosMtR
         E/X7XkaBLWh/xDDupl+Xv5h26XEi1dmb8MzCA28hmba4M7pUnh5Sfy6RwZE7w8iAxldC
         OBxkji4kpmcvyxOPgpw108fzHEdgmQr2Ne+3AP2oK+ID7+hyngkVm56w/60y5t45EPx6
         l6ICjRKoHZ+7b8Lpc8uFBnpbTNrbjFiMl0TpF57InPj1vCpSsghN7JjwXh4XCI07BL0w
         mYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SoorQ/GWxuzmOTfjtez+99in0f4knnTQwgEu6e/ih1M=;
        b=iRl+rCJcqZ0cJqgaxnQNA4SdA8oEuJO/B7MUEa0e5zpSjYJxJb08E5XrpPhwh2GSyK
         Hsy7LVyMKFqJMKrAYnXF60LhnLZMCS149If39rM/3atu0w2/evOsQBdOY4a9m0/iKqI9
         VZQG6Ub8/llTdlNG09q0tAE3sV8hayIebX7RrYY+kqBKDFsMbqoifzTwOQyfuX95/fgU
         dOZOz+j2bwvnSjLhoJrWcqDDagvnbrqTAOp3ZOpK7RHRVbSUZf8IHYPAnWXftnHhYmb5
         vm/bJyEtVHTe2LSwjtlXILbWRLkCSt2SW/RrZIAqsc72+KFPcv+Q8ITMKIWcMGe2gAGF
         9+3g==
X-Gm-Message-State: AOAM532M226nWU3Msi2mz8eH+WHUeeh6KxBkGpUyVxKFpyB59oFt0mjk
        t/evEMP2dpzqbqFzk6kYeihDWKcTlI+3AjK/
X-Google-Smtp-Source: ABdhPJwXnl9xXhmQwJFma8C88J+oZK5+R+jZRkA8hMgJhh6Y4mkXmLOOX26trFJZJGS+r3PEk0gHWA==
X-Received: by 2002:a92:c5cf:: with SMTP id s15mr26623320ilt.62.1629821809923;
        Tue, 24 Aug 2021 09:16:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x5sm5766231ioa.35.2021.08.24.09.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:16:49 -0700 (PDT)
Date:   Tue, 24 Aug 2021 12:16:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v4 23/25] midx: respect
 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
Message-ID: <c2f94e033d6905e5bb5b27ae237f6a0db16aae53.1629821743.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1629821743.git.me@ttaylorr.com>
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
2.31.1.163.ga65ce7f831

