Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340FCC54EBE
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 05:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjAJFov (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 00:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjAJFoI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 00:44:08 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A448040C2F
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 21:43:58 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id vm8so25800654ejc.2
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 21:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8L2pFFIcDxNN1bhvWkYi9ywET2ix7HgymzThUUquK98=;
        b=AgkbzJb+FbiCvW4/CfJ9+W1qi5SWxVrEMSH2QZ1xeVsTc4xUkSd/OqARLbc38GPLBR
         JIJD4W3jXCFJXIy65PfbbQd7MFF4XABDHCTUY5m7856mnYLbLZSiz5cLh5zkR8OXD36u
         irrHwI9ImccI5N6FtXY0zz8GDOxzjil1waZq3g+2VFZJbpjG/29wUIJHinFrrazmrMaW
         8hJb7F1wD04RICtK5BnUC19oQ4DnKaV1X0Jo990iltJCAx4pSMMco0FG19+HuVwpI58C
         awHMJ9CSb0O633V9A2D8EBhkqncnA2YTcmuYwxtSDyC5Vy31Cdxv2/ZjYlKUS95nmjOF
         DLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8L2pFFIcDxNN1bhvWkYi9ywET2ix7HgymzThUUquK98=;
        b=6K58YG6l506k/O04sJkTi29m8IIFUz5grU0guUjPnFSRPxw/0XPktpx74QeTWmXjA4
         Y/YfWW2qOtFKvpaSyrN6jLZ/00uJwi7okfzaHALL4IW4opCPRV04E9PLOBKx49bFr6pI
         B8BioAygH2P15Ubt7mKQoeoisfcI6dv5NljqmpFtHC9NEHgDvkaM8xyWamuuCUnaxRW6
         TrSngbbA8PxbAUeVnqd3Qs4t9opjwsITKf6gduX8NIm0DnLHnq+1/G0U0WR2i4zOaxHy
         zYAvzWxbcwJvouMbMnbkpm8SxypDFCJeuFjZ4bySLKSliyqzIIcXEz7w8nYsOE7bjn0L
         h7+A==
X-Gm-Message-State: AFqh2krn+GcAB053XZSOKxx7DjAwprIoxi30dEFz5szP3rMvWERcbj4J
        c0TDmWstePOmHxf0Y4Qgtwaz3RO73Z5L/g==
X-Google-Smtp-Source: AMrXdXtJ6AwJV1Dy5XNWQUNIbGv0U9KZTgPsYuXDr4jDsqQB7knffIdm71CXWW8P1N8QkV+7qRksuA==
X-Received: by 2002:a17:906:3ac3:b0:844:1d1d:f7 with SMTP id z3-20020a1709063ac300b008441d1d00f7mr50685053ejd.23.1673329436914;
        Mon, 09 Jan 2023 21:43:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906869500b0084d36fd208esm3428423ejx.18.2023.01.09.21.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 21:43:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/19] repack: fix leaks on error with "goto cleanup"
Date:   Tue, 10 Jan 2023 06:43:27 +0100
Message-Id: <patch-v3-07.19-a3f1e800127-20230110T054138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
In-Reply-To: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
References: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com> <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
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
2.39.0.1195.gabc92c078c4

