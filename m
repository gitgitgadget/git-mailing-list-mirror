Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F6FC6379F
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 17:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbjAQRMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjAQRLf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 12:11:35 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB08C2ED6F
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:33 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z11so46042605ede.1
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQ175NIebX6yUupAijy4xhJCiVhtfT9Z75MHK7wrUL8=;
        b=B/edhiQEfz6XmDwHhBos9Dthcta1s2hte/IUjOOvAHcg/yCNrtY0cG8W7lqgy4XG/7
         drp816OS2qe8J+DHfH2TcWRfwufYaBR/WYNd9YQW73dmD1dZeCCX6vyBgt5YErstdf4k
         B3cQTvI0oAPzMlmQ4USdt0/aMgWgS7yQfc0H1FgMAQvBuMidLjZyolB15YV+OUkG1FzZ
         1lil8xnqqAEj4m+hJTYvJYlo8jx4TAZ+8Ib4IhNB9mycaH0nxuysHvL6Mc/6s6q15qD1
         4FPVwOfNBTCoJ4HM2bbEk+VxJfR4+F4KHlD/Tnq9r3wgXUfG3RN8n0CMIbCpx2a1uZVa
         UZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQ175NIebX6yUupAijy4xhJCiVhtfT9Z75MHK7wrUL8=;
        b=gT6TZLI1ljfH60ZuC127rVS34tPuuTs/ZFWg4ozFTLHYbZ8LbkHeS1SqIaRSGx8gBJ
         RYY7tNk8wXk9DAedtrENN9wq2ILxoImhYEZwLBmup7i5XEqxrTDSrYDmtMrHrT7qNzwc
         HejA5zYot1kfFPWjBs0/R7vF15qsahGuANBryafTeIkMfH8Vt4TkR4AfaZ2L1pgeuHzp
         frAkiMErYn5nj3RuDXvOIEe9FxLN8iY6EMSWUlFieLYiEkhtM81d8qz5h0/RIlKRKjsa
         MTAioYUkfVSKnxok+C1pIlwJoinTpHgwix7ALZ0YxRrQnn1aZs3UQlIY2eoH5QE+Se1U
         9pzA==
X-Gm-Message-State: AFqh2kpn9wCGEX906dDsb8R71KMQV6yjCd/3kPZ+qGPKSiT1pqacW6qi
        UQTb3sSQFBAqONUtp2MlPCS7nLdj/9Y1dw==
X-Google-Smtp-Source: AMrXdXtcbEERF20SSEjbfwaPuyhOHmjqa0dSrozC+altQkBPrSJGStHzZkUMNNv4myGpFdRtwycFCQ==
X-Received: by 2002:a05:6402:f05:b0:49c:d9c3:ca74 with SMTP id i5-20020a0564020f0500b0049cd9c3ca74mr4493086eda.13.1673975492114;
        Tue, 17 Jan 2023 09:11:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m2-20020a509302000000b0046892e493dcsm13191268eda.26.2023.01.17.09.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:11:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 07/19] repack: fix leaks on error with "goto cleanup"
Date:   Tue, 17 Jan 2023 18:11:12 +0100
Message-Id: <patch-v4-07.19-fd890121ebe-20230117T151202Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com> <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
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

