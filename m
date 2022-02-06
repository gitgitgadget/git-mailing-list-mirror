Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B21C433F5
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 22:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347388AbiBFWj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 17:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240925AbiBFWjN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 17:39:13 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DD2C06173B
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 14:39:12 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c192so8643163wma.4
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 14:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q/qPpODfOQGps3fZ0eUt0L/gO8hAtKPjrLL6IgJUDZ0=;
        b=N5besYk0QSuieDq6qAAoZbvbmc0lRvg4LjEXiKXlkH2+lT8R2WJ0p7QlidnJiFLZju
         hOBNZ/5DiadoVlwARdZwG/XZVKvxgdXhjAaMLtDS3ZcRbJub1daHaia1UADbecjBmwPQ
         o11Q8cJ5rAQQ65iHnfZYBxEwOQV6qBmHRvpueU11ePrREpKi9cETzRFkc5wE+U/HSXEZ
         SdsmuQGZ91RLT09LzqWlxMESvlZcZVjxXZhRn5E3JzXD7LnQXBMRup/pu6I8JySoCcA6
         sMpkWLicAVt4M71Rua1PHT1aC4ywfyoDTVY0YGQ3kHwAZrsKXXCZm6mO+UhQNxqdrwOb
         mDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Q/qPpODfOQGps3fZ0eUt0L/gO8hAtKPjrLL6IgJUDZ0=;
        b=M21e2+m1kth/3KZt+U2SYGTNUdCQ49ijrJfUlBh9U15kby3EF2417YIhIPsDeamSJx
         ErqBZKZDoGMOlnj6jAmTwInP9XXQYXPhs1GJyGBkVdG2AFOS183qG+OspJjsz2IaZgBN
         w6KCVD4j4dIaRKdbQ9882qFwNti+kA5N7eJUPfugWc3U3Z4eiMdw5fVoFcbFaf5CLh54
         gAek/686eP16IM1Wf8VoSQzXFfgPDKQ3nzGJIvxC/sRygJfXCDRgl3OX85TWe/MCANc+
         mb7yqlx66PeLvQQ87Y1MbLXm0r6GqD97WGSFH0tE9ia/5g0tRJ1Ox6a/Tze38975zHls
         iNwA==
X-Gm-Message-State: AOAM532B3xcxvRsPnPSUFP3huzZBKBlcH9SIt4cRqe3AC6iEGws6UO1i
        CvHdjDAr2WsWzzsgvEpjgI3ft3Vr/9g=
X-Google-Smtp-Source: ABdhPJwbItm0xxbY2YUm7AqfGoK3pPsB9YuqQ8Z7I6Mm0UyRwBJWUMWoj/Hz0EKN9sb2XbTGk5Bbpg==
X-Received: by 2002:a05:600c:2b91:: with SMTP id j17mr4472874wmc.19.1644187151184;
        Sun, 06 Feb 2022 14:39:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l28sm5552434wrz.90.2022.02.06.14.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 14:39:10 -0800 (PST)
Message-Id: <bd9428919fab6f4c600ed04ff0ebc5e0ef615ebc.1644187146.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
        <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 06 Feb 2022 22:39:05 +0000
Subject: [PATCH v2 5/6] scalar: teach `diagnose` to gather packfile info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

It's helpful to see if there are other crud files in the pack
directory. Let's teach the `scalar diagnose` command to gather
file size information about pack files.

While at it, also enumerate the pack files in the alternate
object directories, if any are registered.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 30 ++++++++++++++++++++++++++++++
 contrib/scalar/t/t9099-scalar.sh |  6 +++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index fd666376109..331d48b2a80 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -12,6 +12,7 @@
 #include "packfile.h"
 #include "help.h"
 #include "archive.h"
+#include "object-store.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -592,6 +593,29 @@ cleanup:
 	return res;
 }
 
+static void dir_file_stats_objects(const char *full_path, size_t full_path_len,
+				   const char *file_name, void *data)
+{
+	struct strbuf *buf = data;
+	struct stat st;
+
+	if (!stat(full_path, &st))
+		strbuf_addf(buf, "%-70s %16" PRIuMAX "\n", file_name,
+			    (uintmax_t)st.st_size);
+}
+
+static int dir_file_stats(struct object_directory *object_dir, void *data)
+{
+	struct strbuf *buf = data;
+
+	strbuf_addf(buf, "Contents of %s:\n", object_dir->path);
+
+	for_each_file_in_pack_dir(object_dir->path, dir_file_stats_objects,
+				  data);
+
+	return 0;
+}
+
 static int cmd_diagnose(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -656,6 +680,12 @@ static int cmd_diagnose(int argc, const char **argv)
 	write_or_die(stdout_fd, buf.buf + off, buf.len - off);
 	strvec_push(&archiver_args, buf.buf);
 
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, "--add-file-with-content=packs-local.txt:");
+	dir_file_stats(the_repository->objects->odb, &buf);
+	foreach_alt_odb(dir_file_stats, &buf);
+	strvec_push(&archiver_args, buf.buf);
+
 	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
 	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
 	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index f3d037823c8..e049221609d 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -93,6 +93,8 @@ test_expect_success '`scalar [...] <dir>` errors out when dir is missing' '
 SQ="'"
 test_expect_success UNZIP 'scalar diagnose' '
 	scalar clone "file://$(pwd)" cloned --single-branch &&
+	git repack &&
+	echo "$(pwd)/.git/objects/" >>cloned/src/.git/objects/info/alternates &&
 	scalar diagnose cloned >out &&
 	grep "Available space" out &&
 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <out >zip_path &&
@@ -102,7 +104,9 @@ test_expect_success UNZIP 'scalar diagnose' '
 	folder=${zip_path%.zip} &&
 	test_path_is_missing "$folder" &&
 	unzip -p "$zip_path" diagnostics.log >out &&
-	test_file_not_empty out
+	test_file_not_empty out &&
+	unzip -p "$zip_path" packs-local.txt >out &&
+	grep "$(pwd)/.git/objects" out
 '
 
 test_done
-- 
gitgitgadget

