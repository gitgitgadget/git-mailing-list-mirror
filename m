Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42308EB64DC
	for <git@archiver.kernel.org>; Sat,  1 Jul 2023 06:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGAGzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jul 2023 02:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjGAGzI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2023 02:55:08 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BFB3C3E
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 23:49:04 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4009ea1597bso21254811cf.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 23:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688194143; x=1690786143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPQarEVInifdzSj09d4emw9k7cKTZRLP8g/cnqYEdG0=;
        b=RJeAJLEkdyUj7HUi6tWXnAcrvAtsloTr8TE4NH2Zxx+XFGlpApqp3Xs1jAI//UUdhR
         MbEtSqPclnusQKAdn945DPNHHjp4Q34R98mr5wU1PeKuxGUrUBPA/bWVw8XDY3MsBnST
         5S0VeWHmZWhRDqT5Og7HPsPJbC4a+PPT34VKD222ObJ7Gnoag9xMXd1ZH/8kyWpolwxr
         eUF1az1h12C8gK8cM71sFn7K4aWzaWmdFGGH+rERL6LEwu7vgMA+iz/N18kA+8RNXDtY
         5u7z/mT6qA+nvc/gVIaFPNHAmxBx3ve95Osv8ratPDit5oyI8HxVvA03UiAO00bfq2PS
         dsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688194143; x=1690786143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPQarEVInifdzSj09d4emw9k7cKTZRLP8g/cnqYEdG0=;
        b=WO6LSPb+L/WdQSiCYKlHuTLbaClIlOoH65P5DN/tSTB3mdPl5I58SUVwnKw8ptu9he
         KmZ8L+GvXogUU4vyeNU6BaFksxGDOgfeknapJzohisYaUfVYMmXOdJA1rWcSoYWCXZul
         U3q7g3Hqp9HUt1x9auLdIBLFbPZRzjseI9ttNNLWSQoEFEOZ3kdxMLHxd9Y5sKzC9Qbv
         SkK7Z8J1AxdIrFTR+nRGyXGxnZnzuky14u7++iLPjdzDMdTVCmKSvYf6HKh3KkSZhZ6V
         ocG+GKsCfs/NKqLoPcgMrtEUOv+V9jGkkJgnnhRPjVAfhiHRQp7fsuB0oYeicp+IvevQ
         8HQw==
X-Gm-Message-State: ABy/qLZPf3aG9nZmA4wjSjcUp8ssqC93fl+J8YjjUOMobDX1kz30Y8y7
        3EtYyzE+omJS1xuPy3G79JE+rJ9LbJsuAg==
X-Google-Smtp-Source: ACHHUZ4lrRjzNmI3cgOWhCB2rjtOBGizXqFuu8KK6eCVBwaAwmBm9uj1ynjAn/sVyrKaGkECjBmR2g==
X-Received: by 2002:ac8:5c82:0:b0:3ff:25d0:d29e with SMTP id r2-20020ac85c82000000b003ff25d0d29emr6169854qta.62.1688194143307;
        Fri, 30 Jun 2023 23:49:03 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-18-69-158-189-182.dsl.bell.ca. [69.158.189.182])
        by smtp.googlemail.com with ESMTPSA id a26-20020ac8435a000000b003e69c51cf53sm2269720qtn.72.2023.06.30.23.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 23:49:02 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH v1 3/3] check-attr: integrate with sparse-index
Date:   Sat,  1 Jul 2023 02:48:43 -0400
Message-Id: <20230701064843.147496-4-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230701064843.147496-1-cheskaqiqi@gmail.com>
References: <20230701064843.147496-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set the requires-full-index to false for "diff-tree".

Add test to ensure the index is not expanded when the
sparse index is enabled.

The `p2000` tests demonstrate a ~63% execution time reduction for
'git check-attr' using a sparse index.

Test                                            before  after
-----------------------------------------------------------------------
2000.106: git check-attr -a f2/f4/a (full-v3)    0.05   0.05 +0.0%
2000.107: git check-attr -a f2/f4/a (full-v4)    0.05   0.05 +0.0%
2000.108: git check-attr -a f2/f4/a (sparse-v3)  0.04   0.02 -50.0%
2000.109: git check-attr -a f2/f4/a (sparse-v4)  0.04   0.01 -75.0%

Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 builtin/check-attr.c                     |  3 +++
 t/t1092-sparse-checkout-compatibility.sh | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index b22ff748c3..02267f9bc1 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -122,6 +122,9 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, check_attr_options,
 			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+	
 	if (repo_read_index(the_repository) < 0) {
 		die("invalid cache");
 	}
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 4edfa3c168..317ccc8ec5 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2288,4 +2288,15 @@ test_expect_success 'check-attr with pathspec outside sparse definition' '
 	test_all_match git check-attr  -a --cached -- folder1/a
 '
 
+test_expect_success 'sparse-index is not expanded: check-attr' '
+	init_repos &&
+
+	echo "a -crlf myAttr" >>.gitattributes &&
+	run_on_all cp ../.gitattributes ./deep &&
+
+	ensure_not_expanded check-attr -a -- deep/a &&
+	run_on_all git add deep/.gitattributes &&
+	ensure_not_expanded check-attr -a --cached -- deep/a
+'
+
 test_done
-- 
2.39.0

