Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047C2C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 07:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbiHEHzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 03:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240355AbiHEHzB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 03:55:01 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979C074DDE
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 00:55:00 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id ay36-20020a05600c1e2400b003a4e30d7995so3591325wmb.5
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 00:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=v16Idmwoj1JNNi0Dc+W/BVdNYQpamh+AWHauS2M4pEE=;
        b=nFc9m5PGWh1gPdejeYoUAniPVW1Cx9dJjKqnGyDIH+R9n92cQbjjWPyzu/xXzPvg8C
         KtuW/mKabMe85AJne/EyyiEaOjy/OdwRTmTzRyI7L09enlKBPjTln4B+HnZS1l31jZop
         kLf3jiQeJrcfeJ8DPzOia5VJrJJJ0P+NUibYiAkkmRCqNzECriTiNUCtoulyvpsxqpKd
         x4R6T6UmJSo+tj+p01Sigmd07+o8PnpJ77trURy4NgDKooT+4h0LD5gP3YVXt5cpuFgC
         0u/MCyq3xuOVXMCMmoEHbXn2gYlijSwiWX5Z66iIY7wAzFsiKsl6pgRsUd7fzp25eNYD
         /eOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=v16Idmwoj1JNNi0Dc+W/BVdNYQpamh+AWHauS2M4pEE=;
        b=5td/0ueze614OPX/PpULUvse1KV/Ds3nZbGbSEf4vS48ilXZ2/S2JtlCsSnTqWkYKU
         zr8dRwXBTZ4gjyhteMikkofOYUf0Jaj098YRIvthw69oGavV9nCUo45sJ2MpQhZ094sG
         Y475h2AxaKXgXlrmXRVJdfv5MzOV3+urfryIerEyfAzRHgiKO8ra0NHnAo+OU5+U8VWK
         +EMaXSUX6QjArpNk4iqGTWTc2f0G/m9isJwmYWYZ86L2BHAjoFTxdc/P7XzhFWQPnG3y
         GEU0rfRoceOBGvGyW3O93V9PQi9LbB2yhYyidZ0Y3ExCjQhTxYRLhlfs8eRNmw4vmnXx
         9ejg==
X-Gm-Message-State: ACgBeo2W9FLjbHQrS1ddh0AsxjCInVGdzzlVfWPsfsOPYaDwb990jjzx
        qBsukC8K8Y/50mkfBoiT0cAkCENKBmI=
X-Google-Smtp-Source: AA6agR6Klv4+za+X/rVca6g6AXgLXsbmGYqdOSebe1TBMXM30jIkdIZ8AHrhRF5adtTWkXezQ1n6og==
X-Received: by 2002:a05:600c:2d02:b0:3a5:e61:d876 with SMTP id x2-20020a05600c2d0200b003a50e61d876mr3813517wmf.132.1659686098554;
        Fri, 05 Aug 2022 00:54:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j42-20020a05600c1c2a00b003a30c3d0c9csm8899834wms.8.2022.08.05.00.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 00:54:57 -0700 (PDT)
Message-Id: <pull.1313.git.1659686097163.gitgitgadget@gmail.com>
From:   "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Aug 2022 07:54:57 +0000
Subject: [PATCH] rev-list: support `--human-readable` option when applied
 `disk-usage`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Li Linchao <lilinchao@oschina.cn>,
        Li Linchao <lilinchao@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Li Linchao <lilinchao@oschina.cn>

The '--disk-usage' option for git-rev-list was introduced in 16950f8384
(rev-list: add --disk-usage option for calculating disk usage, 2021-02-09).
This is very useful for people inspect their git repo's objects usage
infomation, but the result number is quit hard for human to read.

Teach git rev-list to output more human readable result when using
'--disk-usage' to calculate objects disk usage.

Signed-off-by: Li Linchao <lilinchao@oschina.cn>
---
    rev-list: support --human-readable option when applied disk-usage
    
    The '--disk-usage' option for git-rev-list was introduced in 16950f8384
    (rev-list: add --disk-usage option for calculating disk usage,
    2021-02-09). This is very useful for people inspect their git repo's
    objects usage infomation, but the result number is quit hard for human
    to read.
    
    Teach git rev-list to output more human readable result when using
    '--disk-usage' to calculate objects disk usage.
    
    Signed-off-by: Li Linchao lilinchao@oschina.cn

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1313%2FCactusinhand%2Fllc%2Fadd-human-readable-option-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1313/Cactusinhand/llc/add-human-readable-option-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1313

 Documentation/rev-list-options.txt |  5 +++++
 builtin/rev-list.c                 | 31 ++++++++++++++++++++++++++----
 t/t6115-rev-list-du.sh             | 18 +++++++++++++++++
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 195e74eec63..d30301a9159 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -249,6 +249,11 @@ ifdef::git-rev-list[]
 	faster (especially with `--use-bitmap-index`). See the `CAVEATS`
 	section in linkgit:git-cat-file[1] for the limitations of what
 	"on-disk storage" means.
+
+-H::
+--human-readable::
+	Print on-disk objects size in human readable format. This option
+	must be combined with `--disk-usage` together.
 endif::git-rev-list[]
 
 --cherry-mark::
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 30fd8e83eaf..be677f29070 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -81,6 +81,7 @@ static int arg_show_object_names = 1;
 
 static int show_disk_usage;
 static off_t total_disk_usage;
+static int human_readable;
 
 static off_t get_object_disk_usage(struct object *obj)
 {
@@ -473,6 +474,8 @@ static int try_bitmap_disk_usage(struct rev_info *revs,
 				 int filter_provided_objects)
 {
 	struct bitmap_index *bitmap_git;
+	struct strbuf bitmap_size_buf = STRBUF_INIT;
+	off_t size_from_bitmap;
 
 	if (!show_disk_usage)
 		return -1;
@@ -481,8 +484,13 @@ static int try_bitmap_disk_usage(struct rev_info *revs,
 	if (!bitmap_git)
 		return -1;
 
-	printf("%"PRIuMAX"\n",
-	       (uintmax_t)get_disk_usage_from_bitmap(bitmap_git, revs));
+	size_from_bitmap = get_disk_usage_from_bitmap(bitmap_git, revs);
+	if (human_readable) {
+		strbuf_humanise_bytes(&bitmap_size_buf, size_from_bitmap);
+		printf("%s\n", bitmap_size_buf.buf);
+	} else
+		printf("%"PRIuMAX"\n", (uintmax_t)size_from_bitmap);
+	strbuf_release(&bitmap_size_buf);
 	return 0;
 }
 
@@ -490,6 +498,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	struct rev_list_info info;
+	struct strbuf disk_buf = STRBUF_INIT;
 	struct setup_revision_opt s_r_opt = {
 		.allow_exclude_promisor_objects = 1,
 	};
@@ -630,9 +639,17 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
+		if (!strcmp(arg, "--human-readable") || !strcmp(arg, "-H")) {
+			human_readable = 1;
+			continue;
+		}
+
 		usage(rev_list_usage);
 
 	}
+
+	if (!show_disk_usage && human_readable)
+		die(_("option '%s' should be used with '%s' together"), "--human-readable/-H", "--disk-usage");
 	if (revs.commit_format != CMIT_FMT_USERFORMAT)
 		revs.include_header = 1;
 	if (revs.commit_format != CMIT_FMT_UNSPECIFIED) {
@@ -752,10 +769,16 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			printf("%d\n", revs.count_left + revs.count_right);
 	}
 
-	if (show_disk_usage)
-		printf("%"PRIuMAX"\n", (uintmax_t)total_disk_usage);
+	if (show_disk_usage) {
+		if (human_readable) {
+			strbuf_humanise_bytes(&disk_buf, total_disk_usage);
+			printf("%s\n", disk_buf.buf);
+		} else
+			printf("%"PRIuMAX"\n", (uintmax_t)total_disk_usage);
+	}
 
 cleanup:
 	release_revisions(&revs);
+	strbuf_release(&disk_buf);
 	return ret;
 }
diff --git a/t/t6115-rev-list-du.sh b/t/t6115-rev-list-du.sh
index b4aef32b713..614ebb72aaa 100755
--- a/t/t6115-rev-list-du.sh
+++ b/t/t6115-rev-list-du.sh
@@ -48,4 +48,22 @@ check_du HEAD
 check_du --objects HEAD
 check_du --objects HEAD^..HEAD
 
+
+test_expect_success 'rev-list --disk-usage with --human-readable' '
+	git rev-list --objects HEAD --disk-usage --human-readable >actual &&
+	test_i18ngrep -e "446 bytes" actual
+'
+
+test_expect_success 'rev-list --disk-usage with bitmap and --human-readable' '
+	git rev-list --objects HEAD --use-bitmap-index --disk-usage -H >actual &&
+	test_i18ngrep -e "446 bytes" actual
+'
+
+test_expect_success 'rev-list use --human-readable without --disk-usage' '
+	test_must_fail git rev-list --objects HEAD --human-readable 2> err &&
+	echo "fatal: option '\''--human-readable/-H'\'' should be used with" \
+	"'\''--disk-usage'\'' together" >expect &&
+	test_cmp err expect
+'
+
 test_done

base-commit: 4af7188bc97f70277d0f10d56d5373022b1fa385
-- 
gitgitgadget
