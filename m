Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F9BC19F28
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbiHBPr6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237174AbiHBPrM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:47:12 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E184F2E6B1
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l4so18420003wrm.13
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=nDmwQdOVfDoEH0zIq9ipISm+fY0SL3HfAJeCZm54nUw=;
        b=Fey0cjBpuCTWYa/qGrWpaMZd6Y02KCF7ODAsbudp140TVcXKqqhGwLLW48pP1nBWEk
         Ln6Svi5vYuCascscCrjSbrZ33nMzLmwPhzmTU6+ibV+S3q3x+9M1iMke3zUYWYOCudYp
         a8lV5gOeUBjjWJpcBp2RZwtOfIEasoYhcAm1is6BMuO9LCMbwNgD6gNRr5IE4iiIl6K0
         /gHJiol8QylPUTD2vzEJj8X8MNSQ9rLR798C2pawkh7RK2n9pP93obDbBaLCi7doCSRz
         qLId4fjXINOcUEMlj+GNV1CbgmqTD7jPYpKJyj6qWI6hMQodtqjxAs7SOMhDhxt76UlA
         DunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=nDmwQdOVfDoEH0zIq9ipISm+fY0SL3HfAJeCZm54nUw=;
        b=ZelVkyDN2r4GGhXypejACToZypa8jE8qCfpaQ6l7e5msCuTvaWysqjGmr0D9Qkluxr
         rIrdf1vzJBt8wWnsFqV9sfRJgWUQ6DWozIzrOWQMh7rrkivnlj1AyQs50IMHEEdBWH5G
         NU2SjzvwWBGjrYV3/KNBPN5raCaDpqS8q78fDIV3+Lxe5iaGabu1XXCJgBAPVyADzt9F
         42gt5rNVOiPTOBssbeSdDYHkMpgEnvHLYD+99zZ1coEz9KbAEicTRze85ST17H8Cw8SY
         S3ikmKWFTcM1J3E3nozdCmq+H5yL3VR1bMEoRToLbuVbZWD+wTAuohaWeOTwMV5BDcPw
         NzaQ==
X-Gm-Message-State: ACgBeo2xW6MABQ/EpLyczaajXirtelVb6KOVfPrFcbtnF4Qo0bJ3P+kn
        pvg5sLaW9E8N74tuRh4HPl0/uTHrKsIDtQ==
X-Google-Smtp-Source: AA6agR5qDyoV8V//DEN8oPYxnZ9CjBIG+P5jkQTL7I6WjnjXCinNBRunYo1leSC246TcO5go63mJrg==
X-Received: by 2002:a05:6000:1883:b0:205:c0cb:33c6 with SMTP id a3-20020a056000188300b00205c0cb33c6mr14350375wri.39.1659455204022;
        Tue, 02 Aug 2022 08:46:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 27/28] submodule--helper: libify "must_die_on_failure" code paths (for die)
Date:   Tue,  2 Aug 2022 17:46:11 +0200
Message-Id: <patch-v2-27.28-93cd1ccde54-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue the libification of codepaths that previously relied on
"must_die_on_failure". In these cases we've always been early aborting
by calling die(), but as we know that these codpaths will properly
handle return codes of 128 to mean an early abort let's have them use
die_message() instead.

This still isn't a complete migration away from die() for these
codepaths, in particular this code in update_submodule() will still call die() in some cases:

	char *remote_name = get_default_remote_submodule(update_data->sm_path);
	const char *branch = remote_submodule_branch(update_data->sm_path);

But as that code is used by other callers than the "update" code let's
leave converting it for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 79a11992d1c..4f7ece6fb05 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2263,9 +2263,9 @@ static int run_update_procedure(struct update_data *ud)
 		 */
 		if (!is_tip_reachable(ud->sm_path, &ud->oid) &&
 		    fetch_in_submodule(ud->sm_path, ud->depth, ud->quiet, &ud->oid))
-			die(_("Fetched in submodule path '%s', but it did not "
-			      "contain %s. Direct fetching of that commit failed."),
-			    ud->displaypath, oid_to_hex(&ud->oid));
+			return die_message(_("Fetched in submodule path '%s', but it did not "
+					     "contain %s. Direct fetching of that commit failed."),
+					   ud->displaypath, oid_to_hex(&ud->oid));
 	}
 
 	return run_update_command(ud, subforce);
@@ -2309,13 +2309,14 @@ static const char *remote_submodule_branch(const char *path)
 	return branch;
 }
 
-static void ensure_core_worktree(const char *path)
+static int ensure_core_worktree(const char *path)
 {
 	const char *cw;
 	struct repository subrepo;
 
 	if (repo_submodule_init(&subrepo, the_repository, path, null_oid()))
-		die(_("could not get a repository handle for submodule '%s'"), path);
+		return die_message(_("could not get a repository handle for submodule '%s'"),
+				   path);
 
 	if (!repo_config_get_string_tmp(&subrepo, "core.worktree", &cw)) {
 		char *cfg_file, *abs_path;
@@ -2333,6 +2334,8 @@ static void ensure_core_worktree(const char *path)
 		free(abs_path);
 		strbuf_release(&sb);
 	}
+
+	return 0;
 }
 
 static const char *submodule_update_type_to_label(enum submodule_update_type type)
@@ -2408,7 +2411,9 @@ static int update_submodule(struct update_data *update_data)
 {
 	int ret;
 
-	ensure_core_worktree(update_data->sm_path);
+	ret = ensure_core_worktree(update_data->sm_path);
+	if (ret)
+		return ret;
 
 	update_data->displaypath = get_submodule_displaypath(
 		update_data->sm_path, update_data->prefix);
@@ -2418,16 +2423,14 @@ static int update_submodule(struct update_data *update_data)
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
 	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->suboid))
-		die(_("Unable to find current revision in submodule path '%s'"),
-			update_data->displaypath);
+		return die_message(_("Unable to find current revision in submodule path '%s'"),
+				   update_data->displaypath);
 
 	if (update_data->remote) {
 		char *remote_name = get_default_remote_submodule(update_data->sm_path);
@@ -2437,13 +2440,13 @@ static int update_submodule(struct update_data *update_data)
 		if (!update_data->nofetch) {
 			if (fetch_in_submodule(update_data->sm_path, update_data->depth,
 					      0, NULL))
-				die(_("Unable to fetch in submodule path '%s'"),
-				    update_data->sm_path);
+				return die_message(_("Unable to fetch in submodule path '%s'"),
+						   update_data->sm_path);
 		}
 
 		if (resolve_gitlink_ref(update_data->sm_path, remote_ref, &update_data->oid))
-			die(_("Unable to find %s revision in submodule path '%s'"),
-			    remote_ref, update_data->sm_path);
+			return die_message(_("Unable to find %s revision in submodule path '%s'"),
+					   remote_ref, update_data->sm_path);
 
 		free(remote_ref);
 	}
-- 
2.37.1.1233.ge8b09efaedc

