Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2366C4167B
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 18:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbiL1SBJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 13:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbiL1SAu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 13:00:50 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C162D186A9
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:37 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bx10so15563737wrb.0
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiLXVM8TDBUa8BcMOQ5eWP5wWaS+mhqokEYEB9t0d2E=;
        b=Ut8TADzOkFX0LuRNYXBVhJN0yo+2yhz0aGG0ssegobA2iJV1U6vBDWgFgRhMHxqSip
         6QyHNNy8aq0Qr9hPPFMXc4cNln5Wel8wG37Xyvsi5zHNK6lPQ3hcQRujx/DB7bKu4jqB
         ZW35erHSImGy7vJhj+jSgTa7ZfTZ6zAv+26tG/ZgF+/13BY0ajtOoBt+VNIAOQAOD0/K
         HK9sr7rWMJEqsmId7zTydotcvBOoUCAJkCZ6DyGe6qaC79A+EIO+4s1EK/nU/Ak4N4er
         QmW5QTOlfHnGucqnLX+Zets34hFVQN+zQ0zqp0hjjLfLibIXbIGQONH8lhR9e02dP8Zw
         q9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiLXVM8TDBUa8BcMOQ5eWP5wWaS+mhqokEYEB9t0d2E=;
        b=QHDNICnZl5pRDchYaCmVuMxPiHJHxB4kliAnC2ich4ermyUtERwoC4ixJLkHnDpwtx
         MOAqQuGwMcooLX7icI+D2ID/yv14qiVGSfHTS0H/930OtL7tXaIPQNs+t0L0rB5Xf24n
         plKxdi0mt3qf/stt86vsVEFuXksNNuyqNPNTGtynANswd15UZusB9REQlxYiPGV3f33/
         2iS1lSQroALZyPLhrdTu6OGRf1tICcz2XEJzlzgqIKCGyiEoArVS8/Qu9ME0o7IpX0dZ
         +MyCR8g+k9LohAl+KuDa8NWOCvgrhzYUBI3oooeNou3BnrBqPQLOPfylMgtc5a0W5lXD
         yJwg==
X-Gm-Message-State: AFqh2krv7lRHczCUKHS1zp6sFFKUvnnoKYc1rokZg1nxgwNXnwE0oJ41
        uatHVTFr3WVcdzB//JOhXLZzSF7bxlUmOQ==
X-Google-Smtp-Source: AMrXdXu+NO+32NSnK82zhwY5Tm/FXbSTEi4a0sBpZcNUkuP1swjRczKp3SSvK8fzhgjKwfuZaBiUQA==
X-Received: by 2002:adf:cd8c:0:b0:271:9e7d:adbf with SMTP id q12-20020adfcd8c000000b002719e7dadbfmr18968321wrj.65.1672250435947;
        Wed, 28 Dec 2022 10:00:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002428c4fb16asm16022480wrq.10.2022.12.28.10.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 10:00:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/20] repack: fix leaks on error with "goto cleanup"
Date:   Wed, 28 Dec 2022 19:00:10 +0100
Message-Id: <patch-10.20-81555cce790-20221228T175512Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.gb0033028ca9
In-Reply-To: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
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
2.39.0.1153.gb0033028ca9

