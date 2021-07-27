Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E5BC4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA0F6023F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhG0VWZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbhG0VVo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 17:21:44 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B96C061382
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:20:25 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id h1so396137iol.9
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SoorQ/GWxuzmOTfjtez+99in0f4knnTQwgEu6e/ih1M=;
        b=MQlnHcTdcIK+ww4qJOMUJri0XNGOW0mmc9qv4YnYxAF1W+v9ZUYVZE6eSf4meoV2I4
         XeE1DyXCgvApKRSicX+/JKdQY6KzUM+a3Lb91nnbbygn7AITHg9V8C1qRXt8gJrMiNmW
         ZiQGDQe2uMbutaGSyjnd3+dItpjnb/fsimv9YI2h4SMoNCn7jZrOGKrm+WV7LGRwRWvs
         3O2mo7tp7l3amstoqu/JQ+9UTiUySOm974BV80g0iMsef9jodVO6tttsx9C6xh7Wb7Vs
         Vnz63uA85zilxk2zCAVfH4xdMyjJvm5zS6WLQxBQOUlmv1y9GKeF5AXOzZYT+6HDf43P
         FYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SoorQ/GWxuzmOTfjtez+99in0f4knnTQwgEu6e/ih1M=;
        b=oBWt6RO5Z4nAlAwp8OjZ4xvhtVG+WBvuolMo/Tu7BKEJt18UUUSPyFv+0TzIdw7LA3
         TEf8usbvgJi1Ao89wFuQPB190GYgydRutiIeiISU2ffQ1gxCiGoJnKIZCAIZ4qa9/qpB
         6ifuj1Z4VAUeiXPmPEprjptVHJMKbJqdlFyDNJdzyihGLdybNAhe1Vaz0JYrGNrAGgKa
         HIKFr/uwNVXwZAo6V/6yVIRagHgxDm/4vZag0AmkS3Wgf4OhzUHsrNG8SXsqRLsST7rE
         gj4vgj09wC58Bgsk5dqIJL4qcPzYgYTOK1teIUO0XAstdAIcjJHsvYGYf3OB+yDZFfgO
         MCFA==
X-Gm-Message-State: AOAM532koRzxxmQ8ab0o04t28o1fN6Zyz/zJZ3mKT7XAkXru+WlZgDNz
        lo725lLGDDw8jjkGMxcEDfoHIgjiYpkRWNA+
X-Google-Smtp-Source: ABdhPJyeZNP1vXNaaj8m0wPHqS1L7Ti1XQQxAre5WcH9k9lo63KWrmbuLrQ8lN5I/hLMg/qxGA9bRQ==
X-Received: by 2002:a05:6638:c58:: with SMTP id g24mr23122300jal.63.1627420824331;
        Tue, 27 Jul 2021 14:20:24 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id n18sm3182887ioz.5.2021.07.27.14.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:20:24 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:20:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v3 23/25] midx: respect
 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
Message-ID: <50865e52a37590d0bef541fd96c95a0416d7d585.1627420428.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1627420428.git.me@ttaylorr.com>
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

