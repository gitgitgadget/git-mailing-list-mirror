Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC97C4332F
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 03:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5D960F6D
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 03:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbhIMDq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 23:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbhIMDq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 23:46:57 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD8CC061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 20:45:42 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i3so5569270wmq.3
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 20:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SY4yWdNO3Kwd9iJTgu/txS0z+qdGS47qjWvWeIzJcWg=;
        b=mflFJBv+yQftaRJNJIQyz+n+9wZj0OOSgeHtyITpimueG1rtzEVAALzUmdzQ/b/t8k
         PC5iwIhnMThQP85cWEEh3vlQ8LBGtKGZHTKWhu5SYzOdw5k8ePCELobDFYGNfeLDLMz1
         z6AbzgugfaYMtXPWgQ587rOARE6UkScs8XonsBEFLEcPrfQHh9mqGOEZ2KzvVmPuU1vh
         kI+G5ZA7NVA8HVRre+rF6xJyS0MpJFJ6aTiEe+oi7OPxM93LIyXrCdmmTWVhxcyTsEtj
         2bixLCP1v2CRRuWbwoO7ocYGRjg3ftAPVRCbMq+fs9Im7IyRYEVJe3fuoNI7WbJEGUtH
         JmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SY4yWdNO3Kwd9iJTgu/txS0z+qdGS47qjWvWeIzJcWg=;
        b=m3TyNaeBbRClWAisTaRt6keGunbEoZrDCtAlfIP21ZgVSiHsFcnxnFLWmuITVob32t
         1rA1jhkSakUgtqgT/yvT9vppR586RmQ2HWOXItOUcXmQcKjdtr4W3qqwsH15c/nI1vGV
         ouPHnkx9o1Vb6rmcp17wTJ6Ms8ypjrUS6sCEd4JTMUX+3GB3PYX5RL8qTpn58ibvd4+h
         7quf/60Xlk2CqNP5YeIuqzvReZ8u3tocZ0+Fkl62NcPhIbUOdQuCOyPhXwtNHIECq7Fp
         jN9Q3tXymTuS7/sSh+DmW40y8p+mhIzct4v3VhbC/YUlwshHGaFh+Jp2cZq1MVrKYRoE
         ZRgQ==
X-Gm-Message-State: AOAM530nAV46BmjUyXAvZZEZESq40DLYe9xl6zzVziYII6Dknf9BfajQ
        uddFQvcfq73LzKduALPUFbfa6iJVLuGL/w==
X-Google-Smtp-Source: ABdhPJzQCdUD7c8uAnJYQzSmB9ZpEyvirl6SNp/alDueYIyNYyxakEzxFXuT4TBYPAEeXbGnXy/c9g==
X-Received: by 2002:a1c:7713:: with SMTP id t19mr3467318wmi.162.1631504740960;
        Sun, 12 Sep 2021 20:45:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o10sm6631472wrc.16.2021.09.12.20.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 20:45:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/4] difftool: use run_command() API in run_file_diff()
Date:   Mon, 13 Sep 2021 05:35:39 +0200
Message-Id: <patch-v2-3.4-2b093bd71fc-20210913T033204Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.999.ga5f89b684e9
In-Reply-To: <cover-v2-0.4-00000000000-20210913T033204Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210911T182009Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20210913T033204Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the run_file_diff() function to use the run_command() API
directly, instead of invoking the run_command_v_opt_cd_env() wrapper.

This allows it, like run_dir_diff(), to use the "args" from "struct
strvec", instead of the "const char **argv" passed into
cmd_difftool(). This will be used in the subsequent commit to get rid
of OPT_ARGUMENT() from cmd_difftool().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/difftool.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index f8fcc67640f..de2e5545c81 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -663,24 +663,23 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 }
 
 static int run_file_diff(int prompt, const char *prefix,
-			 int argc, const char **argv)
+			 struct child_process *child)
 {
-	struct strvec args = STRVEC_INIT;
 	const char *env[] = {
 		"GIT_PAGER=", "GIT_EXTERNAL_DIFF=git-difftool--helper", NULL,
 		NULL
 	};
-	int i;
 
 	if (prompt > 0)
 		env[2] = "GIT_DIFFTOOL_PROMPT=true";
 	else if (!prompt)
 		env[2] = "GIT_DIFFTOOL_NO_PROMPT=true";
 
+	child->git_cmd = 1;
+	child->dir = prefix;
+	strvec_pushv(&child->env_array, env);
 
-	for (i = 0; i < argc; i++)
-		strvec_push(&args, argv[i]);
-	return run_command_v_opt_cd_env(args.v, RUN_GIT_CMD, prefix, env);
+	return run_command(child);
 }
 
 int cmd_difftool(int argc, const char **argv, const char *prefix)
@@ -770,5 +769,5 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 
 	if (dir_diff)
 		return run_dir_diff(extcmd, symlinks, prefix, &child);
-	return run_file_diff(prompt, prefix, child.args.nr, child.args.v);
+	return run_file_diff(prompt, prefix, &child);
 }
-- 
2.33.0.999.ga5f89b684e9

