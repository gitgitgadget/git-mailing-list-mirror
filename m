Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5291C43331
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97D5964ECE
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhCKRFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhCKRE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:04:57 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030D4C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:04:57 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id u8so22643634ior.13
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HG3GCoWUAVa8w8akz93OyJ5RggkvXDx8g64nnv1ffHU=;
        b=lPkfxMSQiV45HFkB9Qr+s3cl6iN0mZlDf4oCEk6cpu10uAEjreO2ztxszDL7RQgalH
         dp7WcgAkSe1BpOWIF7UglvhrY2MT4dYV1erq3gfAuXoWyIv2WU+GT4hxZRTihZbDsTR8
         c/04omX3Y8EjnY6F8U9b3WRjxcevakz1v/6sJbPQnEBdUy3Jvvh4dUvI94df9BZlkPL+
         KErK+QpGvRKvt59R+Z63uoTVUC+6SipxYgkFbNeUy4OvGYU5CZpc/l+O5m+nPi+RC24N
         zbbVk9WtgSwPOlbc9hkzHFgHSvaNujHEyd8ME7en/uqNClBRHAc3l4JssEqi1V0bn/9n
         ifcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HG3GCoWUAVa8w8akz93OyJ5RggkvXDx8g64nnv1ffHU=;
        b=slJNXf75M27Tbe1zvf7rHtL9Xa0LKdoz43LmA/xbStM53IH8HdK2FxyP7g3KlX98M9
         /kN6d8Vkd9u2A3kpVSOlDMXlQZUKspYdeMwA5bgxOgZ2iw1abFzeh5WUikS1g9V5Pcx/
         3v4WR5OvaOw5Ft0NZ9LljABX3vxSMF9mlcWWqqb0OhaS3+5OzFcyb+6U9DqRhbtItTRC
         QLqP5w/0baewGgrG9iZ64wpoi40gWy2uyn1OpBIym0QwhvDCegMuuMopFCa9PFOWFn02
         wgOpb5qpM5a5KttJG9CrNHA+F7tZaOmKJ2yJ0X8J/o2M3+HAnx0gylIo8bxtcLo5gJsV
         5gjQ==
X-Gm-Message-State: AOAM530VXFYvCJhz+Yjr94DY8bXKkJflXQBA+1Rg7TKVg995o1AmoBx5
        v02D0dDwcI1ZnWeUPX97XU5H0HzBKQr2Aidx
X-Google-Smtp-Source: ABdhPJwzJ2PHGYdYH5o3fqOFOb/+IA7aiFKgVSdG6m6mWYZcK7vynvr4Hb7c3cwGaQLg6IiFnUxPMg==
X-Received: by 2002:a5d:97c9:: with SMTP id k9mr7026104ios.45.1615482296183;
        Thu, 11 Mar 2021 09:04:56 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f947:1686:6ada:db5b])
        by smtp.gmail.com with ESMTPSA id u14sm1499404ilv.0.2021.03.11.09.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:04:55 -0800 (PST)
Date:   Thu, 11 Mar 2021 12:04:53 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com, peff@peff.net
Subject: [PATCH v3 05/16] builtin/multi-pack-index.c: don't enter bogus
 cmd_mode
Message-ID: <bc3b6837f274e3f648c3ce6e959c11d4ddf1bb11.1615482270.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1615482270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even before the recent refactoring, 'git multi-pack-index' calls
'trace2_cmd_mode()' before verifying that the sub-command is recognized.

Push this call down into the individual sub-commands so that we don't
enter a bogus command mode.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/multi-pack-index.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 23e51dfeb4..b5678cc2bb 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -65,6 +65,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 {
 	struct option *options = common_opts;
 
+	trace2_cmd_mode(argv[0]);
+
 	argc = parse_options(argc, argv, NULL,
 			     options, builtin_multi_pack_index_write_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
@@ -79,6 +81,8 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv)
 {
 	struct option *options = common_opts;
 
+	trace2_cmd_mode(argv[0]);
+
 	argc = parse_options(argc, argv, NULL,
 			     options, builtin_multi_pack_index_verify_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
@@ -93,6 +97,8 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv)
 {
 	struct option *options = common_opts;
 
+	trace2_cmd_mode(argv[0]);
+
 	argc = parse_options(argc, argv, NULL,
 			     options, builtin_multi_pack_index_expire_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
@@ -115,6 +121,8 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv)
 	options = parse_options_dup(builtin_multi_pack_index_repack_options);
 	options = add_common_options(options);
 
+	trace2_cmd_mode(argv[0]);
+
 	argc = parse_options(argc, argv, NULL,
 			     options,
 			     builtin_multi_pack_index_repack_usage,
@@ -148,8 +156,6 @@ int cmd_multi_pack_index(int argc, const char **argv,
 		usage_with_options(builtin_multi_pack_index_usage,
 				   builtin_multi_pack_index_options);
 
-	trace2_cmd_mode(argv[0]);
-
 	if (!strcmp(argv[0], "repack"))
 		return cmd_multi_pack_index_repack(argc, argv);
 	else if (!strcmp(argv[0], "write"))
-- 
2.30.0.667.g81c0cbc6fd

