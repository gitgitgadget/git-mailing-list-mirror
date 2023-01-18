Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0231C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 12:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjARMql (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjARMpu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 07:45:50 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAB58BABE
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:42 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id w14so32008135edi.5
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQ175NIebX6yUupAijy4xhJCiVhtfT9Z75MHK7wrUL8=;
        b=UdccGcPuO6OYar+xw1Xqgc8IN9b0yYKM5XScn/UUVh9vaUme4Co0qPpqfvC+L9VViv
         2xA8ZYPmsbPjXmA5Wh1CcqGArEDISeNXxis+4v9RRqM3CseuSWyuGoYpdh1t93pj1UYK
         92CymKYWHSaUZpSN7DnNdmeW6X8zJMmqciZ0GwxWq1r7nG9gE/GWP2uoPzTHEgyAv5zy
         1QRMHT1bHPqwmrxX8QRrkA4ZkNXPUVVCOHtKoPwl0+7OnyUuLCdLjFI1HRW5rOZQ1jxG
         9XNjB3VyxQ0mIzzp88YC/RvUbbL8wfx9KB+Nk0+tZBTQyT1FNZVzTYHjSr9NODIonVwR
         FiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQ175NIebX6yUupAijy4xhJCiVhtfT9Z75MHK7wrUL8=;
        b=MH8hxkC5hmBM1RWEh2oGhct2BAT5nRDZ755/bKHoA0dPa//J+j2BsG3vXlO3Y5h/aU
         gKBnXbzob4C4yta3ug0SUalCeoZ7vtF2vfDIWH9R0m6/cUrVXmi6AkY/nvGIKQ4zpqOi
         dzYewxEIry5N6A86Ow6rRUHmfpSbKp+KHIGqY0TAyv4UB9WgzINs+BGVkCQpLLpIC5cY
         OC1S4EHsCmOo09lAUhy/YhRovYeBw2N7+Ouk+5xkTUGvdMW/4owRIbn8HviJkx+kvOZI
         CJJnfMHxYwJOB23Y1zMVjsAJjz8a75/+36fpf7X5ZIPdXIX10J50uJcePA4iVxqk//wW
         D4BA==
X-Gm-Message-State: AFqh2koMoMHYZnHMXAx23dq1dOWJmMcYgnIrp3PUXqCInKL8fK7UXiyt
        zzmHFlZhfgRzGKDCmqIOxZhbcsTAyDSgHA==
X-Google-Smtp-Source: AMrXdXstgQqq/Le9EbyAtoMiMEdeHGac97USClBgKUfEtdeYvViLnFxBuToGKsqzXFxt85SQq8ADvA==
X-Received: by 2002:a05:6402:138b:b0:46a:3bd0:4784 with SMTP id b11-20020a056402138b00b0046a3bd04784mr7607965edv.7.1674043720481;
        Wed, 18 Jan 2023 04:08:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7c90f000000b004615f7495e0sm14120053edt.8.2023.01.18.04.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 04:08:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 07/19] repack: fix leaks on error with "goto cleanup"
Date:   Wed, 18 Jan 2023 13:08:20 +0100
Message-Id: <patch-v5-07.19-1fac90c306a-20230118T120334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com> <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
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
2.39.0.1225.g30a3d88132d

