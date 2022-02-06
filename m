Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A965C433EF
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 22:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347355AbiBFWja (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 17:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240994AbiBFWjO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 17:39:14 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EE7C061353
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 14:39:13 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h6so2956294wrb.9
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 14:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vqFeBZv0w8pn4i/0FkUVFoI6BFfYtcspoLuca1bT42w=;
        b=ocbhsOP0ZtwhxLcofvSxTWeIhdifR3/hwPA+5Q9IGZLDwbwYBMxtVdNXAypmPdN+lQ
         +CEMRC0yA3WA/bAzAvRixEqzvklQorTKcPNthTZYEDKd7RLzkJabB2M+JCUAniDK7jPg
         NcazJ8AG17qHcKirtk+c2DYcOfDkSZJoI1EAcRNBex3dKgHqfz+O1yNdtxRTOcgqZ3oK
         TK4wt6dS8/4Pe7UWiYdmXempZa6v8iJSUMJz1YclojQ+KveoIfMnrrcfY4ZsAJHr9JDn
         yKSUJ234ajBKBv93wgr8522hoo4JKffjwHGUSV+WKp5XWBxJGzHrASntl48lpLswbArX
         4lTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vqFeBZv0w8pn4i/0FkUVFoI6BFfYtcspoLuca1bT42w=;
        b=1zfsW5IitTS3Gh49lCGLKtekZ8KwOToY4kGEQ4PifKs9h8DRUopaegC6DfKJupSYfQ
         rMFHr84ebYdqwcoLmRht3BCzpcNdy86y7LGNTEaqmv+OYKfeW3G5Hcq/I98a4awhOxih
         72JJAu+F8AbJFHn18X07BX3AJIUtZsMADGr4sKyFttocSrCrThEZXTC5WBj8HQgaCUsT
         fsTv6kc63gRiBxmhDkSncyEebRlXn51/3/cSbiTBq3Gz8oQ9aD8IE5c5c9tkmLWwOoZi
         Rl2RUFdW+E5Lzd2vMQpBU2rrPsttACbAwi1vDDpodktuuyyVTbiL+8SMMpuRL25cmzGt
         UsnA==
X-Gm-Message-State: AOAM533VRjN8ts9Tme+h60YPT8tGcmeKmuiIR8nJE0GYwf2S3vhS+ViG
        aRHebalwTFW3a6/zSHWU/zabA0m0cSk=
X-Google-Smtp-Source: ABdhPJwyQLwoppERSryk0IL4782YrkLQxu4Lllmwwce6mLwr879uQnEfSVXX0GkSxAftJ4wv52tpDA==
X-Received: by 2002:a05:6000:1884:: with SMTP id a4mr7378975wri.509.1644187151889;
        Sun, 06 Feb 2022 14:39:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm15363325wmf.37.2022.02.06.14.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 14:39:11 -0800 (PST)
Message-Id: <7a8875be425b272becd6c08f4cd5b23c41304ae3.1644187146.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
        <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 06 Feb 2022 22:39:06 +0000
Subject: [PATCH v2 6/6] scalar: teach `diagnose` to gather loose objects
 information
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

When operating at the scale that Scalar wants to support, certain data
shapes are more likely to cause undesirable performance issues, such as
large numbers of loose objects.

By including statistics about this, `scalar diagnose` now makes it
easier to identify such scenarios.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 59 ++++++++++++++++++++++++++++++++
 contrib/scalar/t/t9099-scalar.sh |  5 ++-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 331d48b2a80..537b97ae734 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -616,6 +616,60 @@ static int dir_file_stats(struct object_directory *object_dir, void *data)
 	return 0;
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
@@ -686,6 +740,11 @@ static int cmd_diagnose(int argc, const char **argv)
 	foreach_alt_odb(dir_file_stats, &buf);
 	strvec_push(&archiver_args, buf.buf);
 
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, "--add-file-with-content=objects-local.txt:");
+	loose_objs_stats(&buf, ".git/objects");
+	strvec_push(&archiver_args, buf.buf);
+
 	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
 	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
 	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index e049221609d..9b4eedbb0aa 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -95,6 +95,7 @@ test_expect_success UNZIP 'scalar diagnose' '
 	scalar clone "file://$(pwd)" cloned --single-branch &&
 	git repack &&
 	echo "$(pwd)/.git/objects/" >>cloned/src/.git/objects/info/alternates &&
+	test_commit -C cloned/src loose &&
 	scalar diagnose cloned >out &&
 	grep "Available space" out &&
 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <out >zip_path &&
@@ -106,7 +107,9 @@ test_expect_success UNZIP 'scalar diagnose' '
 	unzip -p "$zip_path" diagnostics.log >out &&
 	test_file_not_empty out &&
 	unzip -p "$zip_path" packs-local.txt >out &&
-	grep "$(pwd)/.git/objects" out
+	grep "$(pwd)/.git/objects" out &&
+	unzip -p "$zip_path" objects-local.txt >out &&
+	grep "^Total: [1-9]" out
 '
 
 test_done
-- 
gitgitgadget
