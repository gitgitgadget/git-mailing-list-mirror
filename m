Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6E2C64EC7
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBFXIa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjBFXIS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:08:18 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015CD115
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:08:17 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id e22so9426074ejb.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16usFGyP0ajFKYXwj/IxBiQNbrTvGcu2basqJ5/37hc=;
        b=MnEQCryRBRGAN3hTHYKvwcaNKVkWofa2ORUU0PXcNyYArhQqlo7fKU2/esIAXq9+2s
         qAcnZOtZ35SGjlmWZRMGqnJb71uDr4vnCAuqf1PNnelo287KyZe3X6QEM7sQe9XL3swM
         sncXWMEmnPlhbK5U4A8H5cKI2ru29aQS3Eo2jWVwV2+d7il4QxxEJqL/8mBmXJxYFpA4
         mEm/pV+PgReJ/IKsh5V5Zf5J/eWEb2kSANF13g/WDlA+1DrgpzfCZXA6q2KEVsdaFl/A
         QDoN6snAvsG02X8+ZpV30HLFs/xXxCRX9dvAstji6q7BxLGB8guLquGEUPdvZ31rcZnP
         ++Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16usFGyP0ajFKYXwj/IxBiQNbrTvGcu2basqJ5/37hc=;
        b=PWIj781eGU1TuqlDUyvwEqrPsKZ9aSJbynA/wCryQ10IfADDeKeJ9yuXgg+qlYyXkJ
         UjbAHl20/VUwZbbY1dKrIjAas9V4/rE6MqfVLsAaNq5A0cgn5/eX9skBi3OpJy61o/O4
         iyAQcOKi9C4RW+bWW2F1sggxnzqEgYerTKcrXDIp9b2V1mTGpx+SWWdUI8KUnzBkA6YI
         h6kgJi258p8Bl8rFNhJ7lAqeN4TrEyaCK2HX8KmR/dGctIj8zDE+Kd7vkQWezGapuqud
         xb69NL8tbOMVkNfUkSGsSTfPsS3efupFWzWUtFKH9U/sNHp5swHtR/6saeOxKF2sfEjB
         ipMQ==
X-Gm-Message-State: AO0yUKW2s2FcYOycUpyx7Wn5lmpy2/LVuniDVhMXYs9omDn61SiS0SkP
        fuLSHcgYPBTaYCz59UEiX98lhjNqS8bdm6pe
X-Google-Smtp-Source: AK7set+cB5qf6rxiZQ1PSvGh3/sMK1z0WgMrjE4NN2z7KVx9aZrRI03FKgomx8neNw4/QdTdZ01TxQ==
X-Received: by 2002:a17:906:6b8b:b0:879:2a5:dc40 with SMTP id l11-20020a1709066b8b00b0087902a5dc40mr933255ejr.76.1675724896176;
        Mon, 06 Feb 2023 15:08:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906a18f00b0089d5aaf85besm2673586ejy.219.2023.02.06.15.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:08:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 07/19] repack: fix leaks on error with "goto cleanup"
Date:   Tue,  7 Feb 2023 00:07:42 +0100
Message-Id: <patch-v7-07.19-95db54d24b0-20230206T230142Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
References: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com> <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
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
2.39.1.1425.gac85d95d48c

