Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCD0C433FE
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 05:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5173F60E8B
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 05:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbhJMFVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 01:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237650AbhJMFVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 01:21:09 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C48DC061714
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 22:19:05 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id g184so1189475pgc.6
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 22:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NzV8RB7URs90yC/jVzjYQqqva4SIwy/oMHW2og6DwE8=;
        b=a0NVFe3UlMDKVi7B4df8F1G1vfTnBXxpWyevPsACzHXyQ4gCjAKai2aQRL7vS0VAF1
         cTOJb0oycuJ+7n4NG6JWVhFYiepmUCPbWBqkJu8apYBeRplOtp5M4tDauS9GEFrjHbb+
         RiHc9nUlJILu5EwtOqVzrAfnfjQwOpk4RGeOk2gJj6S9J2A9A546znOYMlP87Q6Ta+pl
         xFouuwqnjXCURuFobaU8cmVf5fjdXXaKCE88vrDEhvyJQJegOKN70f6uvCO4Z3jRiOJg
         ZYYlI/wd7d1PAct3zWu7vbRn7zZGn8Sy2R1qR0BZj5/r51tj5TveTt8syJ5z0txgXl+E
         wNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NzV8RB7URs90yC/jVzjYQqqva4SIwy/oMHW2og6DwE8=;
        b=JgbhTDVr/9t/+F/TPm5KrxKlwvjoS1N75zx68SVxe+UYbqEo3T9AEQvRHw6kfpIwUL
         VPEmvyeERhXht+KCI9LmyMJ/YcDo1fgfYC/rofVD4SguKJDT0oo4TaZCngJH7Z4uYjTG
         b7yicc2HO8DhslTSzd8LVM9VNlnHI0Fdeh5N1UqnSD82NPomdOWm41H8LaIdKP+ePp3f
         8HxJUeK1oh/bQ0Zhke8Ao+3LS71xcrUKsmJ0lMZQtkTu8vbFxsRMsBEJlkJQirl+VXjt
         LeEfaIApGUacsEyhNBwtAFSrKkQLQxQcyiWbwnCRrFpZ5zzmkO11Ylh+acqpeChfBqxz
         nB5A==
X-Gm-Message-State: AOAM533+RY0nnNthegmUYBx4AKBo5bkeb/Dw8MWuE1TYc/m5EVjsQci3
        sfCnrVKbPSIZiPzFjRad27w=
X-Google-Smtp-Source: ABdhPJw6cEvJFgPhLY7ZVJbAHciuF1knp3KEz+3fMAdJQdnr6YbMfUCudkfXdvkmlvHW064XvDep0A==
X-Received: by 2002:a05:6a00:16cb:b0:44b:bd38:e068 with SMTP id l11-20020a056a0016cb00b0044bbd38e068mr35817698pfc.34.1634102344925;
        Tue, 12 Oct 2021 22:19:04 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.111])
        by smtp.gmail.com with ESMTPSA id 12sm12481197pfz.133.2021.10.12.22.19.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Oct 2021 22:19:04 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: [PATCH v3 9/9] submodule--helper: rename helper functions
Date:   Wed, 13 Oct 2021 10:48:05 +0530
Message-Id: <20211013051805.45662-10-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211013051805.45662-1-raykar.ath@gmail.com>
References: <20210916103241.62376-1-raykar.ath@gmail.com>
 <20211013051805.45662-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two functions were prefixed with 'do' before the shell-to-C
conversion because they were utility functions meant to be called by
their non-prefixed counterpart.

Since those callers don't exist anymore, and these functions can now be
used directly, let's rename them to signal this fact.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0d6e65bd6c..82d68650e8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2450,7 +2450,7 @@ static int run_update_command(struct update_data *ud, int subforce, struct strin
 	return 0;
 }
 
-static int do_run_update_procedure(struct update_data *ud, struct string_list *err)
+static int run_update_procedure(struct update_data *ud, struct string_list *err)
 {
 	int subforce = is_null_oid(&ud->suboid) || ud->force;
 
@@ -2612,7 +2612,7 @@ static int push_check(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static void do_ensure_core_worktree(const char *path)
+static void ensure_core_worktree(const char *path)
 {
 	const char *cw;
 	struct repository subrepo;
@@ -2871,7 +2871,7 @@ static int update_submodule(struct update_data *update_data)
 	char *prefixed_path;
 	struct string_list err = STRING_LIST_INIT_DUP;
 
-	do_ensure_core_worktree(update_data->sm_path);
+	ensure_core_worktree(update_data->sm_path);
 
 	if (update_data->recursive_prefix)
 		prefixed_path = xstrfmt("%s%s", update_data->recursive_prefix,
@@ -2911,7 +2911,7 @@ static int update_submodule(struct update_data *update_data)
 	}
 
 	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
-		if (do_run_update_procedure(update_data, &err))
+		if (run_update_procedure(update_data, &err))
 			return 1;
 
 	if (update_data->recursive) {
-- 
2.32.0

