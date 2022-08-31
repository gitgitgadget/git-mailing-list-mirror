Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADED8ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiHaXT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiHaXSp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:45 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB11EDC5EA
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c7so13470226wrp.11
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=IlbUbe8IscZDZUVsmEpmoGpgoxhBcWD3DoxD2otXQpw=;
        b=eFJfGBlIlP/Wzv8H05PUmVxJAFP1SRWDB4QEZKAHmxsPjXTwyWuW7gH7024BcavREU
         S17QCjeJcoN+4alSHzaggjORdfwn6eMHhZFplzdcf3oKsCVnSgC6FYhJ1y+VxdUCVcgL
         Wx/vzh0HXSXx4Z6xprI6MwbskMKHhsV2KXcOs84sY2qg7D5Wl/MiefxBOojgRipq4tYz
         AYWIf3uj6NkKc/qGhr5zNn/KM6ckgLc5Txo3Ce27nIRjYmPOzT0wZfHms2bLiDBOUsn4
         f6329+f5Yt+LoRv/97j4x2igQpxeUAbYe/di6hxnUsE/k1FDiYZBBG7WK1ifKmPy9sLF
         K1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IlbUbe8IscZDZUVsmEpmoGpgoxhBcWD3DoxD2otXQpw=;
        b=O37r8H7cSBS5EWyrhZngPv6lpLLMm1nlFkmyubz04ahHzJ/DQgS3oW8IRb3lWQEW+G
         Emo+b4UaoGdUo7Dr1L1VxJhihfgMd/F/othkwvuGl2RdZ+VtCtCt+jZZZU0tsEdib996
         NgdrQiPNjxNew3HCBACR/8dhB6JzhmlgaeOgWWZwH2SeIW+j+hi3uzKGw+LPIveoH6nm
         SAe5kw/j8jbKssTqx3yuznEWwSuYK7w1cxSLsr6syFs7rhHsM7wP1p4svx3vA4NaNNQ3
         ZXcOVTh340V6geQYkZA3gkh7bq3jzwVDz4SD/prHqFgmiisH4zwLSoelgmmck6GBf8kQ
         h8Pg==
X-Gm-Message-State: ACgBeo32dDEe2TZq3jzOqlI16gSHG0vUFBcA9ZQAIuJ3EE1bhP9+3oD+
        yZTswVA5VXGJcWw1QOhcK/JqQlUc4LR4Mw==
X-Google-Smtp-Source: AA6agR7Byki+wdSymLjCwkUmBZJUFZJEh/HzVFQg3YoOvQJbUTs/5pBRwhP3vNhnD0AVI4EqbHj+fQ==
X-Received: by 2002:a5d:6da5:0:b0:222:4634:6a4e with SMTP id u5-20020a5d6da5000000b0022246346a4emr13215076wrs.172.1661987922154;
        Wed, 31 Aug 2022 16:18:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 27/33] submodule--helper: libify "must_die_on_failure" code paths
Date:   Thu,  1 Sep 2022 01:18:09 +0200
Message-Id: <patch-v4-27.33-2b066190739-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preceding commits the codepaths around update_submodules() were
changed from using exit() or die() to ferrying up a
"must_die_on_failure" in the cases where we'd exit(), and in most
cases where we'd die().

We needed to do this this to ensure that we'd early exit or otherwise
abort the update_submodules() processing before it was completed.

Now that those preceding changes have shown that we've converted those
paths, we can remove the remaining "ret == 128" special-cases, leaving
the only such special-case in update_submodules(). I.e. we now know
after having gone through the various codepaths that we were only
returning 128 if we meant to early abort.

In update_submodules() we'll for now set any non-zero non-128 exit
codes to "1", but will start ferrying up the exit code as-is in a
subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 45 +++++++++++++------------------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2f78529736d..8a086723ba6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2132,8 +2132,7 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet,
 	return run_command(&cp);
 }
 
-static int run_update_command(const struct update_data *ud, int subforce,
-			      int *must_die_on_failure)
+static int run_update_command(const struct update_data *ud, int subforce)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *oid = oid_to_hex(&ud->oid);
@@ -2196,8 +2195,6 @@ static int run_update_command(const struct update_data *ud, int subforce,
 			    ud->update_strategy.type);
 		}
 
-		if (ret == 128)
-			*must_die_on_failure = 1;
 		return ret;
 	}
 
@@ -2229,8 +2226,7 @@ static int run_update_command(const struct update_data *ud, int subforce,
 	return 0;
 }
 
-static int run_update_procedure(const struct update_data *ud,
-				int *must_die_on_failure)
+static int run_update_procedure(const struct update_data *ud)
 {
 	int subforce = is_null_oid(&ud->suboid) || ud->force;
 
@@ -2257,7 +2253,7 @@ static int run_update_procedure(const struct update_data *ud,
 			    ud->displaypath, oid_to_hex(&ud->oid));
 	}
 
-	return run_update_command(ud, subforce, must_die_on_failure);
+	return run_update_command(ud, subforce);
 }
 
 static const char *remote_submodule_branch(const char *path)
@@ -2394,8 +2390,7 @@ static void update_data_to_args(const struct update_data *update_data,
 				    "--no-single-branch");
 }
 
-static int update_submodule(struct update_data *update_data,
-			    int *must_die_on_failure)
+static int update_submodule(struct update_data *update_data)
 {
 	int ret;
 
@@ -2409,10 +2404,8 @@ static int update_submodule(struct update_data *update_data,
 						  update_data->sm_path,
 						  update_data->update_default,
 						  &update_data->update_strategy);
-	if (ret) {
-		*must_die_on_failure = 1;
+	if (ret)
 		return ret;
-	}
 
 	if (update_data->just_cloned)
 		oidcpy(&update_data->suboid, null_oid());
@@ -2440,11 +2433,9 @@ static int update_submodule(struct update_data *update_data,
 	}
 
 	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force) {
-		ret = run_update_procedure(update_data, must_die_on_failure);
-		if (*must_die_on_failure)
-			return ret;
+		ret = run_update_procedure(update_data);
 		if (ret)
-			return 1;
+			return ret;
 	}
 
 	if (update_data->recursive) {
@@ -2461,12 +2452,9 @@ static int update_submodule(struct update_data *update_data,
 		update_data_to_args(&next, &cp.args);
 
 		ret = run_command(&cp);
-		if (!ret)
-			return 0;
-		die_message(_("Failed to recurse into submodule path '%s'"),
-			    update_data->displaypath);
-		if (ret == 128)
-			*must_die_on_failure = 1;
+		if (ret)
+			die_message(_("Failed to recurse into submodule path '%s'"),
+				    update_data->displaypath);
 		return ret;
 	}
 
@@ -2499,20 +2487,19 @@ static int update_submodules(struct update_data *update_data)
 
 	for (i = 0; i < suc.update_clone_nr; i++) {
 		struct update_clone_data ucd = suc.update_clone[i];
-		int must_die_on_failure = 0;
 		int code;
 
 		oidcpy(&update_data->oid, &ucd.oid);
 		update_data->just_cloned = ucd.just_cloned;
 		update_data->sm_path = ucd.sub->path;
 
-		code = update_submodule(update_data, &must_die_on_failure);
-		if (code)
-			ret = code;
-		if (must_die_on_failure)
+		code = update_submodule(update_data);
+		if (!code)
+			continue;
+		ret = code;
+		if (ret == 128)
 			goto cleanup;
-		else if (code)
-			ret = 1;
+		ret = 1;
 	}
 
 cleanup:
-- 
2.37.3.1420.g76f8a3d556c

