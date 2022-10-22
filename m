Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD5BC433FE
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 15:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJVPqN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 11:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJVPqK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 11:46:10 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1B624AADA
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 08:46:08 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so7175228wms.0
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 08:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zZQEqSkvYJEUyPWCQx2roN1Yh8GYsB4xueLYOWIpc7A=;
        b=CuQT+n6oYo1agN0dWbB6kq3WSGI1NTWvkPTCsYdsZn2djdd0bS1oweyobt4PVdDdzq
         8gVZsi/aUHOzry+nQHfgF6Vzc9BCVytRNzzc12TWFJ+TE7deyuqPBGM2hGndib2hF+Rh
         /EKYXJr2ttbintGQioQ/hmxjboabuXAT7PRvUMNXworMMokH8V4VQ4qUZWNquJ0+ZT7Z
         gkgTscKME5x1e/O9rmappX1l3BUhRqeuJPZXSDZZIsfCCAmJHwshoeQbqvvC5Q9Jzl+Z
         x1sAjIT5mFDuEuQyb3Sn5CkhZD9DOwPfT4uMS0fkObcYlgrdn4isEXoeFNdOtQl/yAGU
         b77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZQEqSkvYJEUyPWCQx2roN1Yh8GYsB4xueLYOWIpc7A=;
        b=RD4J19qtLH41NBvvTGVNwt1nfaSEsYiBs1bxAYZlpb8Tb9Y+ydABkVOV8I/PpEkjT6
         AOvr/gN/G56HvtVkcqIX5fkQLSK/4uslWYtoWBhtLO7d+QLrwBpov5MDJTKX1SvN3mIG
         ksx41KYOe0YQUvMjpb729HrmjNZNJ5BkALUv1pmSL41+45bFmEx3nfyI+h55Ac/4XpwJ
         zQHrpq7N1saQmQXyM6tUq99rkw66nAluUe9sdlU07wJUtF8dHf4QA2PgkWb2KQKSJLBe
         kYkiZCB6PaElKkUKocrWu/IEGSOulK/p3VE9Mch5AekXec1fNwSHSBUIx4kIT7lS56G9
         4Vew==
X-Gm-Message-State: ACrzQf0X8xnXMOnL/yzkqE29mcJdyoOpjj19jdITOblT/iQJ7mu3KNpT
        Y5UF0kOkb/ayo1zuUsRrbd82emnsyis=
X-Google-Smtp-Source: AMsMyM5Gv2GvCdPfjdMFDyn6+DMV5qZxk8H4zYxRnA+C8SYYNLOo9XIP3gFVomwB+Atdc5JQVDXZPQ==
X-Received: by 2002:a05:600c:2f08:b0:3c6:befc:9778 with SMTP id r8-20020a05600c2f0800b003c6befc9778mr16556824wmn.101.1666453566167;
        Sat, 22 Oct 2022 08:46:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600012cf00b002365b759b65sm2353219wrx.86.2022.10.22.08.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 08:46:05 -0700 (PDT)
Message-Id: <pull.1392.git.1666453564661.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Oct 2022 15:46:04 +0000
Subject: [PATCH] pack-objects: introduce --exclude-delta=<pattern> option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        James Ramsay <james@jramsay.com.au>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

The server uses delta compression during git clone to reduce
the amount of data transferred over the network, but delta
compression for large binary blobs often does not reduce
storage size significantly and wastes a lot of CPU. Git now
disables delta compression for objects that meet these conditions:

1. files that have -delta set in .gitattributes
2. files that its size exceed the big_file_threshold

However, in 1, .gitattributes needs to be set manually by the user,
and in most cases the user does not actively set it, and it is not
something that can be actively adjusted on the server aside. In 2,
the big_file_threshold now defaults to 512MB, and many binary files
smaller than that will be uselessly delta-compressed, and this is
made worse if the server actively increases the big_file_threshold.

Therefore, we need a way to be able to actively skip the delta
compression of some files on the server. Introduces the
`-exclude-delta=<pattern>` option, which can be used to disable delta
compression for objects that satisfy the pattern.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    pack-objects: introduce --exclude-delta= option
    
    While analyzing some repositories using git filter-repo -analyze, I
    noticed that many huge binaries in the repositories were
    delta-compressed without much reduction in size.
    
    $ cat .git/filter-repo/analysis/path-all-sizes.txt | more === All paths
    by reverse accumulated size === Format: unpacked size, packed size, date
    deleted, path name 23816778 23765921 2022-08-22
    managed/src/universal/ybc/ybc-1.0.0-b1-linux-x86_64.tar.gz 22504398
    22445676 2022-08-22
    managed/src/universal/ybc/ybc-1.0.0-b1-el8-aarch64.tar.gz 11726471
    6424233 2022-08-09 managed/yba-installer/yba-installer_linux_amd64
    294644800 5794201 src/yb/master/catalog_manager.cc 2912780 2872186
    docs/static/images/yp/tables-view-ycql.png 2992192 2634232
    docs/static/images/yb-cloud/cloud-clusters-backups.png 2757095 2501915
    docs/static/images/deploy/aws/aws-cf-configure-options.png ...
    
    The current solution to avoid delta compression is not very suitable for
    git servers. First, files that exceed the big_file_threshold are not
    delta compressed, but the above analysis indicates that many big binary
    files do not exceed the the big_file_threshold (default to 512MB).
    Second, there is not .gitattrbutes to disable delta compression for
    them, we also don't really can let repo administrators add it manually.
    
    But we can also see that the large files in these repositories often
    have some common characteristics: they end in ".tar.gz"or “.png". So
    perhaps we can take advantage of this feature and disable delta
    compression on the server for some common type binary files.
    
    This is currently implemented by command line parameters
    --exclude-delta=<pattern>. But maybe we can also try passing it through
    git config.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1392%2Fadlternative%2Fadl%2Fpack-object-no-try-delta-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1392/adlternative/adl/pack-object-no-try-delta-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1392

 Documentation/git-pack-objects.txt |  6 +++++-
 builtin/pack-objects.c             | 28 +++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index a9995a932ca..92cfee83df5 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	[--no-reuse-delta] [--delta-base-offset] [--non-empty]
 	[--local] [--incremental] [--window=<n>] [--depth=<n>]
 	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
-	[--cruft] [--cruft-expiration=<time>]
+	[--cruft] [--cruft-expiration=<time>] [--exclude-delta=<file>]
 	[--stdout [--filter=<filter-spec>] | <base-name>]
 	[--shallow] [--keep-true-parents] [--[no-]sparse] < <object-list>
 
@@ -221,6 +221,10 @@ depth is 4095.
 	This flag tells the command not to reuse existing deltas
 	but compute them from scratch.
 
+--exclude-delta=<pattern>::
+	Delta compression will not be attempted for blobs for paths
+	matching pattern. See linkgit:gitignore[5] for pattern details.
+
 --no-reuse-object::
 	This flag tells the command not to reuse existing object data at all,
 	including non deltified object, forcing recompression of everything.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3658c05cafc..ab9cff98e3a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -272,6 +272,8 @@ static struct commit **indexed_commits;
 static unsigned int indexed_commits_nr;
 static unsigned int indexed_commits_alloc;
 
+static struct pattern_list *exclude_delta_patterns;
+
 static void index_commit_for_bitmap(struct commit *commit)
 {
 	if (indexed_commits_nr >= indexed_commits_alloc) {
@@ -1315,13 +1317,20 @@ static void write_pack_file(void)
 static int no_try_delta(const char *path)
 {
 	static struct attr_check *check;
+	int dtype;
 
 	if (!check)
 		check = attr_check_initl("delta", NULL);
 	git_check_attr(the_repository->index, path, check);
 	if (ATTR_FALSE(check->items[0].value))
 		return 1;
-	return 0;
+
+	return exclude_delta_patterns &&
+		path_matches_pattern_list(path,
+					  strlen(path),
+					  path, &dtype,
+					  exclude_delta_patterns,
+					  the_repository->index) == MATCHED;
 }
 
 /*
@@ -4149,6 +4158,19 @@ static int option_parse_cruft_expiration(const struct option *opt,
 	return 0;
 }
 
+static int option_parse_exclude_delta(const struct option *opt,
+					 const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+
+	if (!exclude_delta_patterns)
+		exclude_delta_patterns = xcalloc(1, sizeof(*exclude_delta_patterns));
+
+	if (arg)
+		add_pattern(arg, "", 0, exclude_delta_patterns, 0);
+	return 0;
+}
+
 struct po_filter_data {
 	unsigned have_revs:1;
 	struct rev_info revs;
@@ -4242,6 +4264,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F(0, "cruft-expiration", NULL, N_("time"),
 		  N_("expire cruft objects older than <time>"),
 		  PARSE_OPT_OPTARG, option_parse_cruft_expiration),
+		OPT_CALLBACK_F(0, "exclude-delta", NULL, N_("pattern"),
+		  N_("disable delta compression for files matching pattern"),
+		  PARSE_OPT_NONEG, option_parse_exclude_delta),
 		OPT_BOOL(0, "sparse", &sparse,
 			 N_("use the sparse reachability algorithm")),
 		OPT_BOOL(0, "thin", &thin,
@@ -4514,6 +4539,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 cleanup:
 	strvec_clear(&rp);
+	FREE_AND_NULL(exclude_delta_patterns);
 
 	return 0;
 }

base-commit: 1fc3c0ad407008c2f71dd9ae1241d8b75f8ef886
-- 
gitgitgadget
