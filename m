Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B56CC3DA7A
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 02:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiL3CTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 21:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbiL3CSs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 21:18:48 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E63217055
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:47 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id r26so23668506edc.5
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gc6HsEQht7ylJKQPR1/iLQMr5yITGoX6jGratZyCUeA=;
        b=BvWE1ttu1JzzAaQ1frJ7Q58UemyQlMFIsLrVb1cuzfaArZv9k8HifUBfMI2HzR9hyU
         XJgujz0zchyZFsYm99XKDe0ta4kqHAeQwntKxDv0yKa5xCykBwCSIS9jpBkdyiFP1gGl
         eqx3wXFzxE/ALrbs4+lj2NCpJ++EPkekYn72WzVIWQtpvvF/u1sxMoFy3U9KYz3d9VX+
         zdeno0chnrB4qAiUGBoz7wFpfk1U3gD30YMxOhI1OCVHamjFjanSuC8D4B/RAW+V0xYK
         l64zDnB9Dl+0DE5k9kUkyYK5scGprxuy+It+c+4x4RVKHJufm0/2SnkCJLbsN9S6cogR
         pKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gc6HsEQht7ylJKQPR1/iLQMr5yITGoX6jGratZyCUeA=;
        b=Wjz6BbTeZwZGKzsx3jT9Xqjmv/7Lw/skQLCCOaGJY31vokVb2WgKZgTOWqwfGoO9nH
         3Trijicra5alO8zt1dKNICAVEmcNSGkdHYKgHak6+gRS6VL0rmMFwotlDExnBwy6ItsB
         PUgNosx6xHThZ3a/DoRXghfkcduFLiBT7sc1FDAxwWHbTl1BJ9SM3RMBB2aFv6ZzMBFz
         1pwbZud+7VXAKZZycaebBczJPDdoEsI/0o5zUMsD2x/2Ys0TBRrN0D2IfL2gPXbgfy68
         pzD82mPvEfVjjNKRvhWFduBUwXIuk2PfPSuxW5ndoHxULxXabXMGAhI1u9y7JY9Njo58
         Vxzw==
X-Gm-Message-State: AFqh2kpEBoe6Eh5apWgbfSpm+IYQglZEt6vAJIg5po+TSXEMCaqrt8Kh
        VG4qvu7n8dumNJDHosqlHFwEzR2YtiD6bw==
X-Google-Smtp-Source: AMrXdXvG8ZQCbnz8bEUgMaAmULSQpOhYuTVsc1irKXoyrL9v8LGR/FEu2g26V50vm0b1s3qRPXea2Q==
X-Received: by 2002:a05:6402:a55:b0:475:9918:37ce with SMTP id bt21-20020a0564020a5500b00475991837cemr26282055edb.13.1672366725904;
        Thu, 29 Dec 2022 18:18:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay15-20020a056402202f00b0046dd0c2a08esm8861991edb.36.2022.12.29.18.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 18:18:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/20] repack: fix leaks on error with "goto cleanup"
Date:   Fri, 30 Dec 2022 03:18:22 +0100
Message-Id: <patch-v2-07.20-b5978d75c6a-20221230T020341Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com> <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change cmd_repack() to "goto cleanup" rather than "return ret" on
error, when we returned we'd potentially skip cleaning up the
string_lists and other data we'd allocated in this function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/repack.c                    | 13 +++++++------
 t/t6011-rev-list-with-bad-commit.sh |  1 +
 2 files changed, 8 insertions(+), 6 deletions(-)

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
2.39.0.1153.g589e4efe9dc

