Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC11C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 02:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiF3Cih (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 22:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiF3CiT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 22:38:19 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A124219A
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 19:38:07 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so1347204pjj.5
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 19:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pKi2vCQNb2ZS0CuxuO6LgV7erG3i83Eul0GEsSVlS3c=;
        b=VkB/L+/EqimI2jCuyMmjzB91+0PSkzmg4K6iwFeDXIuOAo/Eo9+OBI7zFEUUB6NI3Q
         iRR1tkkSd2u05UDOJD+1EljQGObAiITyXHWQpInRyg07AeJrV2Wsyj5aEDGjoIYE4Yuc
         JKG0LqYfcWcUHo77Mr5CsP1k3Kn7OlXJ5hNCvCyVWElyzBUFULW8URexrkjQvv7RSDyG
         UNlk1fcwKvBE+9UGjutHike0CZ25BryP4DzyXacCzysJOqC87XLNEO7RiRlwzBd/HaBQ
         9m7rLtAZOnd8DnmPQ6MG5g73RzJ4iRYCmIpQCoIN9qOiVpb45nwJz336nqiRqGZ7pD1I
         9b6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pKi2vCQNb2ZS0CuxuO6LgV7erG3i83Eul0GEsSVlS3c=;
        b=d/yoBpK94/gjAsrCIe8sreRp5YpXgdpkQA/elKIXVl+51eL2WwekgKqc7oGg2LrRGp
         OypXDeidf5zefGRpSvOf3mXVP//17p139uxTV/hzzTQj2qX7G/X2MdeCd2l0ASrdl+oe
         ynmdCw3QvJSm06vLPrANSLKlmW6x1Ws5lcKx/x/UzE0amRTWFZvimiyDeXlAXNhUl5Ea
         cjF0uRKLho0SByCOWEwIbhaRrr/N1IE/n6uHzVJ7vb/7n0ED8+r1wCDV0+nyBzTOn4c/
         OgBepdpRRNFWygI8TtgvH6cC5CKcShxrPcP7qhCq01ZMf5wGyEvxYhMjLb9CLn8CP6Ge
         KuAQ==
X-Gm-Message-State: AJIora/xRal4joojsKh+szeUoIJ9hPbTtdml8OjoARI6fNPdTBbR4OeS
        Wp3/tNJaeVjy2byHBvg3Uo0/FOnUS0o=
X-Google-Smtp-Source: AGRyM1sfqb8eCogHyHPw5EmHhrN1PNZ+svoJrvCyoLoMRT/JmzWEUzzAZh/fXEmTx/UJQT3DodfIGg==
X-Received: by 2002:a17:902:8502:b0:16a:34a:e477 with SMTP id bj2-20020a170902850200b0016a034ae477mr12801377plb.40.1656556686853;
        Wed, 29 Jun 2022 19:38:06 -0700 (PDT)
Received: from ffyuanda.localdomain ([101.206.226.29])
        by smtp.gmail.com with ESMTPSA id c16-20020a170902b69000b001678dcb4c5asm12157509pls.100.2022.06.29.19.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 19:38:06 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v5 7/8] mv: use flags mode for update_mode
Date:   Thu, 30 Jun 2022 10:37:36 +0800
Message-Id: <20220630023737.473690-8-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220630023737.473690-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220630023737.473690-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As suggested by Derrick [1], move the in-line definition of
"enum update_mode" to the top of the file and make it use "flags"
mode (each state is a different bit in the word).

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
index 7d9627938a..b805a0d0f6 100644
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

