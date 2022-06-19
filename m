Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F44C433EF
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 03:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiFSD01 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 23:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbiFSD0X (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 23:26:23 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51315B86D
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 20:26:18 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id go6so2568352pjb.0
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 20:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GqI1VE/xlgwyWmrJRQhBuFug8nWgFNU8Ekx6d4zYx54=;
        b=j79wUxG3m0vlOy4h1ygpWeaayHs4pEPc7x8e4nrh3vuXlEMmirRjrpfBEg5ibFSrvg
         s3CHkrsOvLf69jEYTNla+TcydlOfYOnqw8aatFpSGP/vDjUPuhdPGsslc2Cvym9Bb6NM
         bnqQ85e5ehkWO+jtJKIfZLKbrcSVBW0/Lj2+L3puOe6ZJeVZ+K+gXtpkr1N9QkdyEsW0
         dh+ezv9A4+eZHVH8Rg/MgcY7EskRvB2aTPcQV2BeOW9yF1WZP88PD+fjtc2hrrALfCDl
         WNTAjzWEuYXvAGBLDlx17eYu0kydHc8jAXq9K2cuMIVZ1cbyr3Aqj9dYYighV5Gi8Sbt
         EzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GqI1VE/xlgwyWmrJRQhBuFug8nWgFNU8Ekx6d4zYx54=;
        b=t2G1M9vJXV2c6ki+rShvBN39ZTAQntDFTA25Nw+lHXQtNJEO6k6dgS07+e8MK2Oovt
         uuipqk9g7IIKjVvVPF1511tcUD7wKjSHtN0QHg4d0yablkjAmnSh/taHA8THx8mGnY24
         2AMGRRXZ+Rii+tjRCC1P4lfBIt+15k46ZFDZWQUIGIov673y9XkhqXqyfuS/alKCUX2L
         hHe45p85wIbXkU0tGssOpTp9nOB6zj2EBJ48ZfResvPDEJ2GokTLLU4Ekncy8OiXAqZd
         t0SRb0J7cJlnrfANjvH1zHGP/WO6wU8h6b0EefJVJpfFqdaXC6n8Oik7be5TpTlCO6AE
         eh8Q==
X-Gm-Message-State: AJIora+49IZwSAwlmVLZwr4W0Zvk4vqAUvHm0hI7RkhAZhKSBRvVKZXf
        S+esTLyEDJkXkRUVzGWU1UI=
X-Google-Smtp-Source: AGRyM1sN/pwptAOO2y5lef8wSdoOspy9xKOPdYeO6EDalRgxbyGeBafucG/NOVbNHDBXUYfQkdNhFw==
X-Received: by 2002:a17:903:41c9:b0:164:57e:4b22 with SMTP id u9-20020a17090341c900b00164057e4b22mr17255686ple.2.1655609177708;
        Sat, 18 Jun 2022 20:26:17 -0700 (PDT)
Received: from ffyuanda.localdomain ([112.195.147.33])
        by smtp.gmail.com with ESMTPSA id u1-20020a170903124100b0016188a4005asm5990650plh.122.2022.06.18.20.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 20:26:17 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        vdye@github.com, newren@gmail.com
Subject: [WIP v3 5/7] mv: use flags mode for update_mode
Date:   Sun, 19 Jun 2022 11:25:47 +0800
Message-Id: <20220619032549.156335-6-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220619032549.156335-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220619032549.156335-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As suggested by Derrick [1],
move the in-line definition of "enum update_mode" to the top
of the file and make it use "flags" mode (each state is a different
bit in the word).

[1] https://lore.kernel.org/git/22aadea2-9330-aa9e-7b6a-834585189144@github.com/

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index abb90d3266..7ce7992d6c 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -19,6 +19,14 @@ static const char * const builtin_mv_usage[] = {
 	NULL
 };
 
+enum update_mode {
+	BOTH = 0,
+	WORKING_DIRECTORY = (1 << 1),
+	INDEX = (1 << 2),
+	SPARSE = (1 << 3),
+	SKIP_WORKTREE_DIR = (1 << 4),
+};
+
 #define DUP_BASENAME 1
 #define KEEP_TRAILING_SLASH 2
 
@@ -129,7 +137,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 	const char **source, **destination, **dest_path, **submodule_gitfile;
-	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX, SPARSE } *modes;
+	enum update_mode *modes;
 	struct stat st;
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
 	struct lock_file lock_file = LOCK_INIT;
@@ -191,7 +199,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			pos = cache_name_pos(src, length);
 			if (pos < 0) {
 				/* only error if existence is expected. */
-				if (modes[i] != SPARSE)
+				if (!(modes[i] & SPARSE))
 					bad = _("bad source");
 				goto act_on_entry;
 			}
@@ -207,14 +215,14 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			}
 			/* Check if dst exists in index */
 			if (cache_name_pos(dst, strlen(dst)) < 0) {
-				modes[i] = SPARSE;
+				modes[i] |= SPARSE;
 				goto act_on_entry;
 			}
 			if (!force) {
 				bad = _("destination exists");
 				goto act_on_entry;
 			}
-			modes[i] = SPARSE;
+			modes[i] |= SPARSE;
 			goto act_on_entry;
 		}
 		if (!strncmp(src, dst, length) &&
@@ -242,7 +250,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			}
 
 			/* last - first >= 1 */
-			modes[i] = WORKING_DIRECTORY;
+			modes[i] |= WORKING_DIRECTORY;
 			n = argc + last - first;
 			REALLOC_ARRAY(source, n);
 			REALLOC_ARRAY(destination, n);
@@ -258,7 +266,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				source[argc + j] = path;
 				destination[argc + j] =
 					prefix_path(dst, dst_len, path + length + 1);
-				modes[argc + j] = ce_skip_worktree(ce) ? SPARSE : INDEX;
+				memset(modes + argc + j, 0, sizeof(enum update_mode));
+				modes[argc + j] |= ce_skip_worktree(ce) ? SPARSE : INDEX;
 				submodule_gitfile[argc + j] = NULL;
 			}
 			argc += last - first;
@@ -355,7 +364,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			printf(_("Renaming %s to %s\n"), src, dst);
 		if (show_only)
 			continue;
-		if (mode != INDEX && mode != SPARSE && rename(src, dst) < 0) {
+		if (!(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
+			rename(src, dst) < 0) {
 			if (ignore_errors)
 				continue;
 			die_errno(_("renaming '%s' failed"), src);
@@ -369,7 +379,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 							      1);
 		}
 
-		if (mode == WORKING_DIRECTORY)
+		if (mode & (WORKING_DIRECTORY | SKIP_WORKTREE_DIR))
 			continue;
 
 		pos = cache_name_pos(src, strlen(src));
-- 
2.35.1

