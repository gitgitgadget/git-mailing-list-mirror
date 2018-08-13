Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D5381F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbeHMS6b (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:58:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33311 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729943AbeHMS63 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:58:29 -0400
Received: by mail-lf1-f68.google.com with SMTP id u14-v6so11676968lfu.0
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3qNP3Jlc6BqAzGdoNDpOxRq6lJHoQugigHh32Z9JpeU=;
        b=Hup1OzyxzTQjB0xARf6aqj1VxI+lOqiwNq+JeueMDrCAmORfI9cFHt+kPLxY5EA82w
         8NvGyrwUEGWm22arLwyywikoZ7ZeVcteKLvEChK/itgk67+vWMBMkTsBqCnGd16Nh1HF
         KGDERhtQreJoTpWbbmJZTuwO2eOVrMI7IjtgmRKGI1kqESMwIQ1cHUVPm+5kLO2gW457
         igMfiqOtN98hUaOPJHutURbVDfVXEuFXG+qlPUCA41ksl/QSD/fqK95C5eFGHlfKd5zQ
         V25lWNbeZLwjXcjEUbLN6QtZGhodyI+uku750BrZtiDStpwh/QRcHhlnvqlPPkHHFuc6
         LKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3qNP3Jlc6BqAzGdoNDpOxRq6lJHoQugigHh32Z9JpeU=;
        b=G1o3RUFP7vr0hsjkynjKkeuzHfL9hLhpJBymLQkv23186Zec8qQPnTHPJa5FZb2KVa
         cfnrL2LbP1A9njvl5xeTKy8NOkVCoytA2kS8BikvnF6rSJdgYW1Gerk5JrkX5fa7jREP
         zxElvPGrLWTBDgP+A4EX47IedecIzitXODkFzXAvxslqAINpU/Jil9czrJ3gUQSXZVAK
         sD5KoJcgBctbJd9yU0L1DCLGzMOGqw/Og/XOb8ngrPYqtLzJ9e91akyt3iuOSdIqzhoc
         EeoHsCSzrgUoSVm5bU+/Ltl3NQ3N/tRCd6HU+kWKzQ/555h6Al80NTCvKFAL2rNk7tQh
         D7mg==
X-Gm-Message-State: AOUpUlGFLLYEvc0Nh5kKQPnm35aoyLlw16qPF51gwVlwZE8UCHyzmPcl
        MpKNGtT3Dz4Rh/nVtU625jEx1kq9
X-Google-Smtp-Source: AA+uWPxZScHlnQShqX1u0gNgykp1eP8mtCzgJRSJtQxEfV1QLon8evRFzmVlQ009sp0RZdG3AqERsg==
X-Received: by 2002:a19:d8e8:: with SMTP id r101-v6mr11054123lfi.121.1534176934619;
        Mon, 13 Aug 2018 09:15:34 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d14-v6sm3066031ljc.56.2018.08.13.09.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:15:33 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/24] submodule.c: use the right index instead of the_index
Date:   Mon, 13 Aug 2018 18:14:31 +0200
Message-Id: <20180813161441.16824-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180813161441.16824-1-pclouds@gmail.com>
References: <20180813161441.16824-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 submodule.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/submodule.c b/submodule.c
index 293efc2a2f..50cbf5f13e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -93,7 +93,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	if (!file_exists(GITMODULES_FILE)) /* Do nothing without .gitmodules */
 		return -1;
 
-	if (is_gitmodules_unmerged(&the_index))
+	if (is_gitmodules_unmerged(the_repository->index))
 		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
 
 	submodule = submodule_from_path(the_repository, &null_oid, oldpath);
@@ -127,7 +127,7 @@ int remove_path_from_gitmodules(const char *path)
 	if (!file_exists(GITMODULES_FILE)) /* Do nothing without .gitmodules */
 		return -1;
 
-	if (is_gitmodules_unmerged(&the_index))
+	if (is_gitmodules_unmerged(the_repository->index))
 		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
 
 	submodule = submodule_from_path(the_repository, &null_oid, path);
@@ -188,7 +188,7 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 
 		if (ignore)
 			handle_ignore_submodules_arg(diffopt, ignore);
-		else if (is_gitmodules_unmerged(&the_index))
+		else if (is_gitmodules_unmerged(the_repository->index))
 			diffopt->flags.ignore_submodules = 1;
 	}
 }
@@ -258,7 +258,7 @@ int is_submodule_active(struct repository *repo, const char *path)
 		}
 
 		parse_pathspec(&ps, 0, 0, NULL, args.argv);
-		ret = match_pathspec(&the_index, &ps, path, strlen(path), 0, NULL, 1);
+		ret = match_pathspec(repo->index, &ps, path, strlen(path), 0, NULL, 1);
 
 		argv_array_clear(&args);
 		clear_pathspec(&ps);
-- 
2.18.0.1004.g6639190530

