Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E46AC61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjBBJxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjBBJx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:53:26 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A2976BE
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:53:05 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so927986wmq.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frzWfRJpJ0O1aFO/GRUiQuCxmVwilh+adMvWOTqAKL8=;
        b=QOEo6eiZTUTjrpm2Hyny/q/2Fv/hCfK3AVzpR2Is3xwCIh6M5HeVylUx6CRITIzrsK
         90DAyBMJX8j1nYstCpTmQIgZfRQNhstJPaiHLwjs90VWBNEP9UJ5b23lNKwI+ogtFWwb
         u/b6Zx30O/MxqXF7BcVqBbhDiTy9FI+R0Y771rFYvY2TQ6nWW24wh7vKs+mnqNvSMoPp
         m4Xa2AvvqTEtRykHfUW5aPB2cLt85JvFnd2A3yjg1LV52GgEbQJP9UxfXjDCa5/KktXB
         67884pstA9RHLTsAcol7KT195AXYmSxDYtX6jYNlIWYJDK7yehVMnh9W4y6Wjn8waw+R
         KmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frzWfRJpJ0O1aFO/GRUiQuCxmVwilh+adMvWOTqAKL8=;
        b=x2vmGjCcMMQnn8hc7do+msZrAg8wIJOmt/oNDUHb4xL7oTpMNkli13KiiYOrzIWQWl
         MoUP8dlPWofK7GI8maFrB6i688hHBvKDK+9pAeYA84CcloTQJXAjj5LqU4r+SIjEr7gE
         NtjsWoSSKduoW7L6wXLbMyd98MsMNm7P+gT/fOhjS2Pen9QTk/1z0VzMILIR42L+YP6g
         fbYeKqWUR/eKIpVnGTwnXjr9AjygVEELx6vascMpv3SW5zvBzKquE1H5eoAXeVQmf30R
         X5bRzz/YF09jptiXnVTr0zxCOmNk9yo+72x1D3S+vlYY5QH3ycCgWiRIMSKslexNQG73
         9A9Q==
X-Gm-Message-State: AO0yUKUGTTzU1/7+4KWKH9HFHlxqyVrIk4Nvq8nzsfisOY+Y8ZUpsy1D
        sPcsnMa56Y0eKaVhnkyw0bq/kvZ964EM+Qa3
X-Google-Smtp-Source: AK7set+ajWRpCDprZL9wd4JFpGRmq2vPBzfsIuErBWoobWf6Dpjif1m2vJ4OgzY9KUS8e6Nx5I3/4w==
X-Received: by 2002:a1c:f211:0:b0:3db:8de:6993 with SMTP id s17-20020a1cf211000000b003db08de6993mr1399415wmc.4.1675331583604;
        Thu, 02 Feb 2023 01:53:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13-20020a1c540d000000b003db03725e86sm4356234wmb.8.2023.02.02.01.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:53:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 07/19] repack: fix leaks on error with "goto cleanup"
Date:   Thu,  2 Feb 2023 10:52:38 +0100
Message-Id: <patch-v6-07.19-09950d92940-20230202T094704Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
References: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com> <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In cmd_repack() when we hit an error, replace "return ret" with "goto
cleanup" to ensure we free the necessary data structures.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/repack.c                    | 13 +++++++------
 t/t5312-prune-corruption.sh         |  1 +
 t/t6011-rev-list-with-bad-commit.sh |  1 +
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index c1402ad038f..f6493795318 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -948,7 +948,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	ret = start_command(&cmd);
 	if (ret)
-		return ret;
+		goto cleanup;
 
 	if (geometry) {
 		FILE *in = xfdopen(cmd.in, "w");
@@ -977,7 +977,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	fclose(out);
 	ret = finish_command(&cmd);
 	if (ret)
-		return ret;
+		goto cleanup;
 
 	if (!names.nr && !po_args.quiet)
 		printf_ln(_("Nothing new to pack."));
@@ -1007,7 +1007,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				       &existing_nonkept_packs,
 				       &existing_kept_packs);
 		if (ret)
-			return ret;
+			goto cleanup;
 
 		if (delete_redundant && expire_to) {
 			/*
@@ -1039,7 +1039,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 					       &existing_nonkept_packs,
 					       &existing_kept_packs);
 			if (ret)
-				return ret;
+				goto cleanup;
 		}
 	}
 
@@ -1115,7 +1115,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		string_list_clear(&include, 0);
 
 		if (ret)
-			return ret;
+			goto cleanup;
 	}
 
 	reprepare_packed_git(the_repository);
@@ -1172,10 +1172,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		write_midx_file(get_object_directory(), NULL, NULL, flags);
 	}
 
+cleanup:
 	string_list_clear(&names, 1);
 	string_list_clear(&existing_nonkept_packs, 0);
 	string_list_clear(&existing_kept_packs, 0);
 	clear_pack_geometry(geometry);
 
-	return 0;
+	return ret;
 }
diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
index 9d8e249ae8b..230cb387122 100755
--- a/t/t5312-prune-corruption.sh
+++ b/t/t5312-prune-corruption.sh
@@ -14,6 +14,7 @@ what currently happens. If that changes, these tests should be revisited.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'disable reflogs' '
diff --git a/t/t6011-rev-list-with-bad-commit.sh b/t/t6011-rev-list-with-bad-commit.sh
index bad02cf5b83..b2e422cf0f7 100755
--- a/t/t6011-rev-list-with-bad-commit.sh
+++ b/t/t6011-rev-list-with-bad-commit.sh
@@ -2,6 +2,7 @@
 
 test_description='git rev-list should notice bad commits'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Note:
-- 
2.39.1.1392.g63e6d408230

