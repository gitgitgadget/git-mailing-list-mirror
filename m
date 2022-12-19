Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFF3C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 16:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiLSQdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 11:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiLSQds (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 11:33:48 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F40219B
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 08:33:46 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id y16so9264075wrm.2
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 08:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wNaixnfnblPNV4LP3+aBN0XGaA8te4lWnXDNGep08y4=;
        b=Yx7y4STqL8YykdILGKsDu9SRagSxPTRLmeloJ6ds3kpr72EzP+vYybaUp7hLUGwEon
         LkBq4VH6w2+6njoTovphntEeA2NESFFoQefQu2DOmHA3Y9dh6kvSsQV9ISxJ1Lo7AXkd
         4oxlgEv78+d3uLlhoqI4iIHcqACIDvjDfe+pCd2m0Ml9CkBTmtMNkC3OMkjhj400uDM3
         /AkgOCEqH/IRiJycNjm/RiJveX6+CylTSiAugElhvcvyom6DgmBa4biowLtxLUiQfK9I
         xEQUbu/qMdnt1uTKGkfzdRGHsmhewkJdEneitMZ+o6YOjUF0oAlPuKsPX36BO9OXeLOY
         zA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNaixnfnblPNV4LP3+aBN0XGaA8te4lWnXDNGep08y4=;
        b=OvERz6LbztIKiIxet4VIv1zNJ9cjsgKzjiUZVNTd2ZrDXMKcTiJQYSYOvwcVLl02d2
         u4+MkJJoroF03eKU0P6fjkIhk61F10u5vm9VMtCDD5JpJDHW8wyBmYgvwnH07qt8J1pL
         Cx81ivHZHC9cSc4TMUQ21YFV7us78a6E+GufRFsGrFaZGdBQrIlVUVZn1htGFRz5O5rY
         71eUG4avnwhGtrAR7W+8HjuUc90JHe21+TQQTF8eQLyAge+g7LztFmTQcBfcaPipklRb
         WJf34CRHc+Io7tpW1EuT06rN6JxDV2g0ZYDrrgKTpJTCJNVUcjIM1ELkoE5GLfKZrQmh
         LwDw==
X-Gm-Message-State: ANoB5pkMlOwOxAmwglr+da1nGHnAUu3RNIR6RUtoVmKPT/80h9Cqr7NW
        VeIghUByk8+4wN1u66Vd9UGOQ4HRIgs=
X-Google-Smtp-Source: AA0mqf7xOvDFk2xuKajd8iSnhl1u7tExbYa3kjUMnnlCFHbYiia2mDIXwhFuhuD4WfJgZFBqhXKDAg==
X-Received: by 2002:a5d:6f10:0:b0:242:43f3:8950 with SMTP id ay16-20020a5d6f10000000b0024243f38950mr29510693wrb.22.1671467625016;
        Mon, 19 Dec 2022 08:33:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d4-20020a5d6dc4000000b0024165454262sm10481428wrz.11.2022.12.19.08.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 08:33:44 -0800 (PST)
Message-Id: <pull.1403.git.git.1671467624143.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Dec 2022 16:33:43 +0000
Subject: [PATCH] diff: use strncmp to check for "diff." prefix
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

This would be a lot more efficient than
checking for the full string, as
so many of the accepted values
begin with "diff."

This allows the computer to skip most checks
if var did not start with diff at all.

It would also let us add more "diff." strings
in the future without having to duplicate
these 5 character so many times.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    diff: use strncmp to check for "diff." prefix
    
    This would be a lot more efficient than checking for the full string, as
    so many of the accepted values begin with "diff."
    
    This allows the computer to skip most checks if var did not start with
    diff at all.
    
    It would also let us add more "diff." strings in the future without
    having to duplicate these 5 character so many times.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1403%2FAtariDreams%2Fdiff-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1403/AtariDreams/diff-v1
Pull-Request: https://github.com/git/git/pull/1403

 diff.c | 158 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 87 insertions(+), 71 deletions(-)

diff --git a/diff.c b/diff.c
index 4dfe824c858..e0fddbe6009 100644
--- a/diff.c
+++ b/diff.c
@@ -345,82 +345,98 @@ static unsigned parse_color_moved_ws(const char *arg)
 
 int git_diff_ui_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
+	if (!strcmp(var, "color.diff")) {
 		diff_use_color_default = git_config_colorbool(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "diff.colormoved")) {
-		int cm = parse_color_moved(value);
-		if (cm < 0)
-			return -1;
-		diff_color_moved_default = cm;
-		return 0;
-	}
-	if (!strcmp(var, "diff.colormovedws")) {
-		unsigned cm = parse_color_moved_ws(value);
-		if (cm & COLOR_MOVED_WS_ERROR)
-			return -1;
-		diff_color_moved_ws_default = cm;
-		return 0;
-	}
-	if (!strcmp(var, "diff.context")) {
-		diff_context_default = git_config_int(var, value);
-		if (diff_context_default < 0)
-			return -1;
-		return 0;
-	}
-	if (!strcmp(var, "diff.interhunkcontext")) {
-		diff_interhunk_context_default = git_config_int(var, value);
-		if (diff_interhunk_context_default < 0)
-			return -1;
-		return 0;
-	}
-	if (!strcmp(var, "diff.renames")) {
-		diff_detect_rename_default = git_config_rename(var, value);
-		return 0;
-	}
-	if (!strcmp(var, "diff.autorefreshindex")) {
-		diff_auto_refresh_index = git_config_bool(var, value);
-		return 0;
-	}
-	if (!strcmp(var, "diff.mnemonicprefix")) {
-		diff_mnemonic_prefix = git_config_bool(var, value);
-		return 0;
-	}
-	if (!strcmp(var, "diff.noprefix")) {
-		diff_no_prefix = git_config_bool(var, value);
-		return 0;
-	}
-	if (!strcmp(var, "diff.relative")) {
-		diff_relative = git_config_bool(var, value);
-		return 0;
-	}
-	if (!strcmp(var, "diff.statgraphwidth")) {
-		diff_stat_graph_width = git_config_int(var, value);
-		return 0;
-	}
-	if (!strcmp(var, "diff.external"))
-		return git_config_string(&external_diff_cmd_cfg, var, value);
-	if (!strcmp(var, "diff.wordregex"))
-		return git_config_string(&diff_word_regex_cfg, var, value);
-	if (!strcmp(var, "diff.orderfile"))
-		return git_config_pathname(&diff_order_file_cfg, var, value);
 
-	if (!strcmp(var, "diff.ignoresubmodules"))
-		handle_ignore_submodules_arg(&default_diff_options, value);
-
-	if (!strcmp(var, "diff.submodule")) {
-		if (parse_submodule_params(&default_diff_options, value))
-			warning(_("Unknown value for 'diff.submodule' config variable: '%s'"),
-				value);
-		return 0;
-	}
+	if (!strncmp(var, "diff.", 5)) {
+		const char *tmp = var + 5;
+		if (!strcmp(var, "color")) {
+			diff_use_color_default =
+				git_config_colorbool(var, value);
+			return 0;
+		}
+		if (!strcmp(tmp, "colormoved")) {
+			int cm = parse_color_moved(value);
+			if (cm < 0)
+				return -1;
+			diff_color_moved_default = cm;
+			return 0;
+		}
+		if (!strcmp(tmp, "colormovedws")) {
+			unsigned cm = parse_color_moved_ws(value);
+			if (cm & COLOR_MOVED_WS_ERROR)
+				return -1;
+			diff_color_moved_ws_default = cm;
+			return 0;
+		}
+		if (!strcmp(tmp, "context")) {
+			diff_context_default = git_config_int(var, value);
+			if (diff_context_default < 0)
+				return -1;
+			return 0;
+		}
+		if (!strcmp(tmp, "interhunkcontext")) {
+			diff_interhunk_context_default =
+				git_config_int(var, value);
+			if (diff_interhunk_context_default < 0)
+				return -1;
+			return 0;
+		}
+		if (!strcmp(tmp, "renames")) {
+			diff_detect_rename_default =
+				git_config_rename(var, value);
+			return 0;
+		}
+		if (!strcmp(tmp, "autorefreshindex")) {
+			diff_auto_refresh_index = git_config_bool(var, value);
+			return 0;
+		}
+		if (!strcmp(tmp, "mnemonicprefix")) {
+			diff_mnemonic_prefix = git_config_bool(var, value);
+			return 0;
+		}
+		if (!strcmp(tmp, "noprefix")) {
+			diff_no_prefix = git_config_bool(var, value);
+			return 0;
+		}
+		if (!strcmp(tmp, "relative")) {
+			diff_relative = git_config_bool(var, value);
+			return 0;
+		}
+		if (!strcmp(tmp, "statgraphwidth")) {
+			diff_stat_graph_width = git_config_int(var, value);
+			return 0;
+		}
+		if (!strcmp(tmp, "external"))
+			return git_config_string(&external_diff_cmd_cfg, var,
+						 value);
+		if (!strcmp(tmp, "wordregex"))
+			return git_config_string(&diff_word_regex_cfg, var,
+						 value);
+		if (!strcmp(tmp, "orderfile"))
+			return git_config_pathname(&diff_order_file_cfg, var,
+						   value);
+
+		if (!strcmp(tmp, "ignoresubmodules"))
+			handle_ignore_submodules_arg(&default_diff_options,
+						     value);
+
+		if (!strcmp(tmp, "submodule")) {
+			if (parse_submodule_params(&default_diff_options,
+						   value))
+				warning(_("Unknown value for 'diff.submodule' config variable: '%s'"),
+					value);
+			return 0;
+		}
 
-	if (!strcmp(var, "diff.algorithm")) {
-		diff_algorithm = parse_algorithm_value(value);
-		if (diff_algorithm < 0)
-			return -1;
-		return 0;
+		if (!strcmp(tmp, "algorithm")) {
+			diff_algorithm = parse_algorithm_value(value);
+			if (diff_algorithm < 0)
+				return -1;
+			return 0;
+		}
 	}
 
 	if (git_color_config(var, value, cb) < 0)

base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
-- 
gitgitgadget
