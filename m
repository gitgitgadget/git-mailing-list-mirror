Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CAAC64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 05:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjB0FGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 00:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjB0FF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 00:05:59 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C651C307
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 21:05:58 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id i4so3406271ils.1
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 21:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677474357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMuCI9TarG2hPmkGVhLDi3m0Ej2GemTolNT7XX8NbsM=;
        b=a3nWu2QUAnamW+4Ng+JdI1qagLUkhIDf5t8KvCLi+wTVC83AG9/htsFxfQwr4oiCJa
         rWkQt82xsl/ptErzcoNITILMB/3jSAfOsGPpAdsQruwriN9t8iijMZW4YIsNHUSpkHQc
         EktESxonPmYZM8tSbp2UzhzHrbJ8D0zdyxIYO5dz4y+EkUNVD8sOO6YNzXAOSHOmBEn4
         lFh+TMxAjv75ggap2btEbuG5ylYk+DT2no+qTRqpCCUUHDaITDsYyyjGCvVke14YMPVi
         4+VlBgl/vPa/G8cKhge4TFk9c2RdRkxU7kzTYj1yS0FF6oW5gCPG/BgALsOU0fHLoR6N
         BnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677474357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMuCI9TarG2hPmkGVhLDi3m0Ej2GemTolNT7XX8NbsM=;
        b=UwbyQPn7q8nWbM6z3mC6R0TNd/JY7xRpH4AbmB1MdezmZpS5JP+FkvuCdgUHq0G6uU
         ZZSuAjf+gp7b1yZ1ryGO8+UHgCAjJtaQZjxj6R+EO6dy/TRtjjSOhJlauAvaN1hy2MPB
         Nz9qI3l0VpL+mrtOR9vmiLJbESkER1ZYCqU7Nzwp7zv82ZQSe4UiTP4uJLQdi/bGju/5
         Cg3FoEZpSBKHHuQrZSIEm4xsleNhlBs3lmPw4nY2sGHyA0CSVq/ROjLBPE0xo6k1a0kB
         TBePY5dYSvVS339kLNCRgvUheSUJBGLulD9CX4JWACWFB+nc6C8BEQ9zlnnqoEV5JM7C
         VZlA==
X-Gm-Message-State: AO0yUKXLnNwgLTqNwY+BBEmcYSnkI2O31cOqY5xaKXmx8wsxxoitbqG2
        I2m6ey/VY3d74PNyPUU0oaWGRprRPxHrKg==
X-Google-Smtp-Source: AK7set8n0w9qSDkEzcLIYFOrtYz32UX79vXcobCBoTX5RflzFgqayyP6COlN8G1K/cXiD+LPssPT/A==
X-Received: by 2002:a05:6e02:1a08:b0:316:fd71:d505 with SMTP id s8-20020a056e021a0800b00316fd71d505mr12572562ild.6.1677474357600;
        Sun, 26 Feb 2023 21:05:57 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id l15-20020a02ccef000000b003a4419ba0c2sm1736959jaq.139.2023.02.26.21.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 21:05:57 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>
Subject: [RFC PATCH 1/1] check-attr: integrate with sparse-index
Date:   Mon, 27 Feb 2023 00:05:43 -0500
Message-Id: <20230227050543.218294-2-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230227050543.218294-1-cheskaqiqi@gmail.com>
References: <20230227050543.218294-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 builtin/check-attr.c                     |  3 +++
 t/t1092-sparse-checkout-compatibility.sh | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 0fef10eb6b..f85b91ebba 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -112,6 +112,9 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+	
 	argc = parse_options(argc, argv, prefix, check_attr_options,
 			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 801919009e..b28010aa5c 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2055,4 +2055,23 @@ test_expect_success 'grep sparse directory within submodules' '
 	test_cmp actual expect
 '
 
+test_expect_success 'check-attr pathspec inside sparse definition' '
+	init_repos &&
+
+	run_on_all touch deep/test.c &&
+	echo "*.c diff=cpp -crlf myAttr" >>.gitattributes &&
+	run_on_all cp ../.gitattributes . &&
+	test_all_match git add .gitattributes &&
+	test_all_match git commit -m "add .gitattributes" &&
+	
+	run_on_all git reset --hard &&
+	test_all_match echo "deep/test.c" | git check-attr --stdin  -a &&
+
+	run_on_all git reset --hard &&
+	test_all_match git check-attr -a  deep/test.c &&
+
+	run_on_all git reset --hard &&
+	test_all_match git check-attr -a  --cached deep/test.c 
+'
+
 test_done
-- 
2.39.0

