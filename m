Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5AFC28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 08:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238556AbiAZIl5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 03:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238551AbiAZIl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 03:41:56 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B23C061744
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 00:41:56 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s18so24356677wrv.7
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 00:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3G1lUAZNqs+dHXlYXdtb9rjLEGLGv6eMZuLNYmd4lsA=;
        b=AIfbj6rGe+1/1xtoYRHC6KXAKbkTKChIRSk4TNJGrp/x+S05m4v64k7F2AnKaE/Eyn
         Y2OdT4ayX4eYmHL25cWHdmDpH+x4v1KbIzJvwzh8lGgE/fTuHbOOI1fb5MxpQHcKxuvu
         r6XxbA6WSAJqHi9Gg0UrvzlrF4Ev4AbIUlabR92aCqBNdGmdnCQBBRLVjzCDqlvf8po0
         0ao6BbB62MVt5U8p780PiWE0O5iBoUKMvvIV5i7eAhkU9dhDoPQtxEFJdpVb7hhfGUyb
         +ynv0IQJNmRu9Q++w9cJcOUrlMJ6AoOHNB3NYGRvWQ/D49cGgUZksqTPTqKIOEeDuVyM
         urQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3G1lUAZNqs+dHXlYXdtb9rjLEGLGv6eMZuLNYmd4lsA=;
        b=2Wfk3JSwyDMcWfKSBDbNiEJ04H52/YPa2sgtiQCxQP4oe55Hol8eeX/RVHhoWG+Fui
         HiAKMmJ6AWoUUO4vVMhuQGCrmwNaUUVorteiEk7sMABeK0zWXutyXv1mgdZCQMv58Yua
         j6eEe54c+uQ51YB9ed8BDxYZ/yAKbM/i9WS07hk/pbiaYdOXj46oV+JD7QwdxXWdKgmD
         Pr4NKgBIMCFmMlldD+octDnhu8DjPy/MQtDlkJ50faqAT65++9KtFSlYfDcb6An+C2cf
         l4Tps/yUIJjhiN86KrMOCr+SpoPWdLuWTdm6eBDEu7oWA4J4Um7tyTFZKG/RhPXbx4fB
         8JSw==
X-Gm-Message-State: AOAM532dVgvsrPgsv0xg/QTs3gW2jxu7wk2xKZfJA6Uz+zOgbTG/eDOR
        5H/PjhJZraBGbs6v1lbiPtP43JtzVaA=
X-Google-Smtp-Source: ABdhPJwRDJHZ9zb2pQWOSUIsGqmjTNtZQd3rE3SIC768Uj+rcXlNULY9DIJ79RCimqJoVf+gNqAVbg==
X-Received: by 2002:adf:f48a:: with SMTP id l10mr21358768wro.220.1643186514477;
        Wed, 26 Jan 2022 00:41:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x13sm19089293wru.28.2022.01.26.00.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 00:41:53 -0800 (PST)
Message-Id: <330b36de799f82425c22bec50e6e42f0e495cab8.1643186507.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jan 2022 08:41:45 +0000
Subject: [PATCH 3/5] scalar: teach `diagnose` to gather packfile info
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

Teach the `scalar diagnose` command to gather file size information
about pack files.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 contrib/scalar/scalar.c          | 39 ++++++++++++++++++++++++++++++++
 contrib/scalar/t/t9099-scalar.sh |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index e26fb2fc018..690933ffdf3 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -653,6 +653,39 @@ cleanup:
 	return res;
 }
 
+static void dir_file_stats(struct strbuf *buf, const char *path)
+{
+	DIR *dir = opendir(path);
+	struct dirent *e;
+	struct stat e_stat;
+	struct strbuf file_path = STRBUF_INIT;
+	size_t base_path_len;
+
+	if (!dir)
+		return;
+
+	strbuf_addstr(buf, "Contents of ");
+	strbuf_add_absolute_path(buf, path);
+	strbuf_addstr(buf, ":\n");
+
+	strbuf_add_absolute_path(&file_path, path);
+	strbuf_addch(&file_path, '/');
+	base_path_len = file_path.len;
+
+	while ((e = readdir(dir)) != NULL)
+		if (!is_dot_or_dotdot(e->d_name) && e->d_type == DT_REG) {
+			strbuf_setlen(&file_path, base_path_len);
+			strbuf_addstr(&file_path, e->d_name);
+			if (!stat(file_path.buf, &e_stat))
+				strbuf_addf(buf, "%-70s %16"PRIuMAX"\n",
+					    e->d_name,
+					    (uintmax_t)e_stat.st_size);
+		}
+
+	strbuf_release(&file_path);
+	closedir(dir);
+}
+
 static int cmd_diagnose(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -695,6 +728,12 @@ static int cmd_diagnose(int argc, const char **argv)
 	if ((res = stage(tmp_dir.buf, &buf, "diagnostics.log")))
 		goto diagnose_cleanup;
 
+	strbuf_reset(&buf);
+	dir_file_stats(&buf, ".git/objects/pack");
+
+	if ((res = stage(tmp_dir.buf, &buf, "packs-local.txt")))
+		goto diagnose_cleanup;
+
 	if ((res = stage_directory(tmp_dir.buf, ".git", 0)) ||
 	    (res = stage_directory(tmp_dir.buf, ".git/hooks", 0)) ||
 	    (res = stage_directory(tmp_dir.buf, ".git/info", 0)) ||
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index ecd06e207c2..b1745851e31 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -75,6 +75,8 @@ test_expect_success UNZIP 'scalar diagnose' '
 	folder=${zip_path%.zip} &&
 	test_path_is_missing "$folder" &&
 	unzip -p "$zip_path" diagnostics.log >out &&
+	test_file_not_empty out &&
+	unzip -p "$zip_path" packs-local.txt >out &&
 	test_file_not_empty out
 '
 
-- 
gitgitgadget

