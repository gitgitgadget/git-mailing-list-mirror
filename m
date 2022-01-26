Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E77C28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 08:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbiAZImC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 03:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbiAZIl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 03:41:57 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BCBC061747
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 00:41:56 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id d138-20020a1c1d90000000b0034e043aaac7so669321wmd.5
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 00:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/GfXPlMur0t49zu+ymA1xmT5Pa6jK23dItzp/6/2Fnw=;
        b=khGshg4f3me+/c3TbNyDHrvENLndGZNd5NqA6hHqLA0+KmD+TdFtw4Mb3t97xiL9j4
         8jwA2vbx6wiSMBjl1baqwlIhKrdFCVFmjtU2rUlyUs9w7xjieRXNma9XcQ17sdvmeAlT
         CvbsFkhP2kABzIPa12F/xckDuYqdPXbWXonqSn39XWfwCF0poRCBGbgi9GL0MpS2stj9
         9hFbMoAEKCm2dpnxFEJP3n9Ku9t6b/Y3lJL4Fo3tHzxnS89+QuZqsa0wjb9+2BB7WL/B
         JO7riRaP8c5dUXnLGj8ETDvMAs4aoKb/5sY3jCwFjt/d/xtp8+dOdPPViIZpV6brRV6m
         w4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/GfXPlMur0t49zu+ymA1xmT5Pa6jK23dItzp/6/2Fnw=;
        b=oHo/DvUFdWLfH/W1BLzY6VS3Ar8o2eMrTh+ol5sG6eOmbPHMVux/gu/jKtyt2sOHUo
         4H0WBeBC63e1sx0qhbEZU/WG+sZ58joqxmYTrPSdbNbY0CKJnPtiL2n7MqHDE3O6uGbR
         KdeCejvOztLB6uOdW0s1aQa0zAW2Sh+FuCzv8zOSMMwfpGYj0Mzq3qvPfXiSE+4ZspyX
         h/JrSEFMNvz9gbJdx4DgxbyIzMvWFI3h3YtvZGvLa1eCHjXhM7d3cPASB4h0tUoGx6N7
         aY5/Ug26vAKHRGRkqeLpA8vN4IdD6Gfg7u9QrA/bjdn+Rcqdr2RVcYGIDnt29NrIMm3V
         siYA==
X-Gm-Message-State: AOAM533FTFv0IVjOXji9tWQlNBWwahGnCGBh70scPqdtF3kuCjA43Hbd
        1muwN0DvN4E2f6/qgZPoAdVQVlAgmxk=
X-Google-Smtp-Source: ABdhPJxztujxtP8CMLtS/Ws47ohfcid3B1MAWYZcErW044NbG4HE+CJNa2umeIkPPuqeb8BCeI5+Vw==
X-Received: by 2002:a05:600c:2906:: with SMTP id i6mr6360531wmd.14.1643186515318;
        Wed, 26 Jan 2022 00:41:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h127sm2863000wmh.27.2022.01.26.00.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 00:41:54 -0800 (PST)
Message-Id: <213f2c94b73f90fc758c2e3872804cf640cb2005.1643186507.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jan 2022 08:41:46 +0000
Subject: [PATCH 4/5] scalar: teach `diagnose` to gather loose objects
 information
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

When operating at the scale that Scalar wants to support, certain data
shapes are more likely to cause undesirable performance issues, such as
large numbers or large sizes of loose objects.

By including statistics about this, `scalar diagnose` now makes it
easier to identify such scenarios.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 contrib/scalar/scalar.c          | 60 ++++++++++++++++++++++++++++++++
 contrib/scalar/t/t9099-scalar.sh |  2 ++
 2 files changed, 62 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 690933ffdf3..c0ad4948215 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -686,6 +686,60 @@ static void dir_file_stats(struct strbuf *buf, const char *path)
 	closedir(dir);
 }
 
+static int count_files(char *path)
+{
+	DIR *dir = opendir(path);
+	struct dirent *e;
+	int count = 0;
+
+	if (!dir)
+		return 0;
+
+	while ((e = readdir(dir)) != NULL)
+		if (!is_dot_or_dotdot(e->d_name) && e->d_type == DT_REG)
+			count++;
+
+	closedir(dir);
+	return count;
+}
+
+static void loose_objs_stats(struct strbuf *buf, const char *path)
+{
+	DIR *dir = opendir(path);
+	struct dirent *e;
+	int count;
+	int total = 0;
+	unsigned char c;
+	struct strbuf count_path = STRBUF_INIT;
+	size_t base_path_len;
+
+	if (!dir)
+		return;
+
+	strbuf_addstr(buf, "Object directory stats for ");
+	strbuf_add_absolute_path(buf, path);
+	strbuf_addstr(buf, ":\n");
+
+	strbuf_add_absolute_path(&count_path, path);
+	strbuf_addch(&count_path, '/');
+	base_path_len = count_path.len;
+
+	while ((e = readdir(dir)) != NULL)
+		if (!is_dot_or_dotdot(e->d_name) &&
+		    e->d_type == DT_DIR && strlen(e->d_name) == 2 &&
+		    !hex_to_bytes(&c, e->d_name, 1)) {
+			strbuf_setlen(&count_path, base_path_len);
+			strbuf_addstr(&count_path, e->d_name);
+			total += (count = count_files(count_path.buf));
+			strbuf_addf(buf, "%s : %7d files\n", e->d_name, count);
+		}
+
+	strbuf_addf(buf, "Total: %d loose objects", total);
+
+	strbuf_release(&count_path);
+	closedir(dir);
+}
+
 static int cmd_diagnose(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -734,6 +788,12 @@ static int cmd_diagnose(int argc, const char **argv)
 	if ((res = stage(tmp_dir.buf, &buf, "packs-local.txt")))
 		goto diagnose_cleanup;
 
+	strbuf_reset(&buf);
+	loose_objs_stats(&buf, ".git/objects");
+
+	if ((res = stage(tmp_dir.buf, &buf, "objects-local.txt")))
+		goto diagnose_cleanup;
+
 	if ((res = stage_directory(tmp_dir.buf, ".git", 0)) ||
 	    (res = stage_directory(tmp_dir.buf, ".git/hooks", 0)) ||
 	    (res = stage_directory(tmp_dir.buf, ".git/info", 0)) ||
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index b1745851e31..f2ec156d819 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -77,6 +77,8 @@ test_expect_success UNZIP 'scalar diagnose' '
 	unzip -p "$zip_path" diagnostics.log >out &&
 	test_file_not_empty out &&
 	unzip -p "$zip_path" packs-local.txt >out &&
+	test_file_not_empty out &&
+	unzip -p "$zip_path" objects-local.txt >out &&
 	test_file_not_empty out
 '
 
-- 
gitgitgadget

