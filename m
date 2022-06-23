Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AABC433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 11:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiFWLmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 07:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiFWLl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 07:41:57 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8974C4CD43
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 04:41:55 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id d129so18894254pgc.9
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 04:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KEyj55fx2hqgi3jtHrN+A4isIxXz3bquoRPbZlG4MkQ=;
        b=ZPQIOTsDFSQvr7vvk8zeTIAHZGqYnoIOxKJDMa9AnfVIEwW4S2zcQNixITI6I+BXqF
         ShOm0C2swnREh1SHMQn0ntUh1GClSglD3F/jILr7IuJR0DQ88OIqKLec5yOKo8q9nQPa
         w5l0+fUDvhPi5OEOmoIC98Mf+wDVvOpDxOqZmwYepkCgF36Ofe4QuPXwKx2QacqSj4xL
         areksngKxLkLaxwc+vZgBXIVEcmOGCSLFUed/OXEPtyJrsBCNuOmofFOqxX9+ZvJJwDt
         wXgzpIub6X8o9fsvarT/VfuixhGywNaE/3IugiKhkJLsIFGJ4z8P+bZ93GFY3G+vkF0H
         H+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KEyj55fx2hqgi3jtHrN+A4isIxXz3bquoRPbZlG4MkQ=;
        b=Aap1lIzoz1rmrGP+Kdx/VqLL1zxiffesPH8okftYwjgM4uVll7SZrlQnDDDHiVGDKH
         9+PcUqcETZaVKTiy0MZF+ONo1KJP073rht13FubYtdJXoDLOm1Ah2vz07ki+orUvr5c+
         xlfUY9XUWiqmeYjNaKzjlSQ1KKgjynu2wtubB2a5FA5CWZgwZOSf1/ZZxg6kORvTad6E
         2tJ0C8HMdLUZdnfUL/4ScKgugDnyAq/RbK9JaknDXr4ZJLdKCqI4xpn4SS0qypzZ2s9L
         0B3O3qrqbovt59XG2RDA56lxxtj+M+Ua147pk4gKk00yVBsvmYDiQ02LeSUrfFIVajoA
         lqqg==
X-Gm-Message-State: AJIora8EZEUBC07Nc7bpnb+WgTKBgyRmLXR+iZxfPB10Lb2ZVlyTOjqO
        uBGexsP0g/MGev88lAyU0w2GYJwO8eUheQfK
X-Google-Smtp-Source: AGRyM1uTSQIpKETVAbhdB4QYw70GQZn6gjb2wM4GGsc3okAkm0zJ4OJL8GzZtfanN5k2Fr4Ltua5QQ==
X-Received: by 2002:a63:6bca:0:b0:408:897c:3fb8 with SMTP id g193-20020a636bca000000b00408897c3fb8mr7169586pgc.576.1655984515094;
        Thu, 23 Jun 2022 04:41:55 -0700 (PDT)
Received: from ffyuanda.localdomain ([112.195.146.236])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090a7e8700b001ec4f258028sm1629299pjl.55.2022.06.23.04.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 04:41:54 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        vdye@github.com
Subject: [PATCH v4 6/7] mv: use flags mode for update_mode
Date:   Thu, 23 Jun 2022 19:41:19 +0800
Message-Id: <20220623114120.12768-7-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As suggested by Derrick [1],
move the in-line definition of "enum update_mode" to the top
of the file and make it use "flags" mode (each state is a different
bit in the word).

Change the flag assignments from '=' (single assignment) to '|='
(additive). Also change flag evaluation from '==' to '&', etc.

[1] https://lore.kernel.org/git/22aadea2-9330-aa9e-7b6a-834585189144@github.com/

Helped-by: Victoria Dye <vdye@github.com>
Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 40a3a5c5ff..aa29da4337 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -20,6 +20,13 @@ static const char * const builtin_mv_usage[] = {
 	NULL
 };
 
+enum update_mode {
+	BOTH = 0,
+	WORKING_DIRECTORY = (1 << 1),
+	INDEX = (1 << 2),
+	SPARSE = (1 << 3),
+};
+
 #define DUP_BASENAME 1
 #define KEEP_TRAILING_SLASH 2
 
@@ -130,7 +137,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 	const char **source, **destination, **dest_path, **submodule_gitfile;
-	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX, SPARSE } *modes;
+	enum update_mode *modes;
 	struct stat st;
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
 	struct lock_file lock_file = LOCK_INIT;
@@ -192,7 +199,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			pos = cache_name_pos(src, length);
 			if (pos < 0) {
 				/* only error if existence is expected. */
-				if (modes[i] != SPARSE)
+				if (!(modes[i] & SPARSE))
 					bad = _("bad source");
 				goto act_on_entry;
 			}
@@ -208,14 +215,14 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
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
@@ -243,7 +250,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			}
 
 			/* last - first >= 1 */
-			modes[i] = WORKING_DIRECTORY;
+			modes[i] |= WORKING_DIRECTORY;
 			n = argc + last - first;
 			REALLOC_ARRAY(source, n);
 			REALLOC_ARRAY(destination, n);
@@ -259,7 +266,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				source[argc + j] = path;
 				destination[argc + j] =
 					prefix_path(dst, dst_len, path + length + 1);
-				modes[argc + j] = ce_skip_worktree(ce) ? SPARSE : INDEX;
+				memset(modes + argc + j, 0, sizeof(enum update_mode));
+				modes[argc + j] |= ce_skip_worktree(ce) ? SPARSE : INDEX;
 				submodule_gitfile[argc + j] = NULL;
 			}
 			argc += last - first;
@@ -361,7 +369,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			printf(_("Renaming %s to %s\n"), src, dst);
 		if (show_only)
 			continue;
-		if (mode != INDEX && mode != SPARSE && rename(src, dst) < 0) {
+		if (!(mode & (INDEX | SPARSE)) &&
+		    rename(src, dst) < 0) {
 			if (ignore_errors)
 				continue;
 			die_errno(_("renaming '%s' failed"), src);
@@ -375,7 +384,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 							      1);
 		}
 
-		if (mode == WORKING_DIRECTORY)
+		if (mode & (WORKING_DIRECTORY))
 			continue;
 
 		pos = cache_name_pos(src, strlen(src));
-- 
2.35.1

