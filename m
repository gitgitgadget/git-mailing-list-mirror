Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856D8ECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbiHaXTf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiHaXSp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:45 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE73E97DE
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so383181wmk.3
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=UC4ZjamO8mbHyoA8batub7PKen7iAmW+PkYG7gM/B5I=;
        b=QhLh+iAp2FJy74cajiPGpwSI0xfEuFJ9Mk3CostaBvQqPDfKlp67enHhaT6H2CxCQ9
         Kb0MBSyw8DPdJXyiTyrUiuQpctPjNld5ShtrnOAifGHdJG/mld9V7/4Qx0A9WLtN4bYj
         hI7YzWFBo25Mm1eZFfhiyLVbfiMJ2k5BvOu6Gc1fwjvjHroTQAuC6IZ49N3O7TKwXzj7
         eNxAfYi55pLZvC2UAoWeYuJEg6qzDDkYzhFEKD0yIRWYdR+pr8ZlLj15mfk6e3ZBEkor
         3lBQkcfsu4Qejbr208fdSFpiI3dwU6ELXl/KGnuXx+wYrYqWxEo97dG4gLx7gopn+jvh
         XVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UC4ZjamO8mbHyoA8batub7PKen7iAmW+PkYG7gM/B5I=;
        b=qG1LQECNAr3ap76N4szFHoJrAzmg/FaBQ+aMR2uDMmYUozVAsGYs1eWNlxM4VbvVmD
         XCtQL4BXv44nt8uf9tDx+D0NLCPE2p2Ddq8wLIG0j6b9iKQHANqR9wJLmUUe6bPbXVQm
         vjP9/tW71P6HLNpN2bM2ct0O4U6NGOyHtDBxz/9G8gaY18DofRhxy4zGGTBLAOMngsxG
         IIKaIIxqINCR0g2cGXAJtSI/VqWMTJXR0eT7s/WW0Nlhvx7dGFOlkTdfzYPReD9ikXgh
         iptZlKHM05o/Rv2M/UpuXPyVNTMLExbneY5j1b0UwnkjBNkA6tgXnF9zeyI4I3KuUoxp
         2khw==
X-Gm-Message-State: ACgBeo2rcZ+M5QJeB+o8ImZUGvEYYyNG/RWi9n1yQSMguCjCeAcc6LH8
        2QxIlZvV8NJLq0TdE8Ki8nuJptKcBUuTNQ==
X-Google-Smtp-Source: AA6agR6dSlAiSYX4Nf65K5yyOO0mMi5gscsvAouBxaux3ZEgxmW3QxiLTVi/pJQT+S04mNRSSZa1bw==
X-Received: by 2002:a1c:c91a:0:b0:3a6:38bf:2c36 with SMTP id f26-20020a1cc91a000000b003a638bf2c36mr3344440wmb.38.1661987922825;
        Wed, 31 Aug 2022 16:18:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 28/33] submodule--helper update: don't override 'checkout' exit code
Date:   Thu,  1 Sep 2022 01:18:10 +0200
Message-Id: <patch-v4-28.33-72e3cdf6543-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "git submodule update" runs it might call "checkout", "merge",
"rebase", or a custom command. Ever since run_update_command() was
added in c51f8f94e5b (submodule--helper: run update procedures from C,
2021-08-24) we'd either exit immediately if the
"submodule.<name>.update" method failed, or in the case of "checkout"
continue trying to update other submodules.

This code used to use the magical "2" return code, but in
55b3f12cb54 (submodule update: use die_message(), 2022-03-15) it was
made to exit(128), which in preceding commits has been changed to
return that 128 code to the top-level.

Let's "libify" this code even more by not having it arbitrarily
override the return code. In practice this doesn't change anything as
the code "git checkout" would return on any normal failure is "1", but
we'll now in principle properly abort the operation if "git checkout"
were to exit with 128.

It would make sense to follow-up this change with a change to allow
the "submodule.<name>.update = !..." (SM_UPDATE_COMMAND) method the
same liberties as "checkout", and perhaps to do the same with a failed
"merge" or "rebase". But let's leave that for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8a086723ba6..4252b6d864c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2136,6 +2136,7 @@ static int run_update_command(const struct update_data *ud, int subforce)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *oid = oid_to_hex(&ud->oid);
+	int ret;
 
 	switch (ud->update_strategy.type) {
 	case SM_UPDATE_CHECKOUT:
@@ -2168,15 +2169,12 @@ static int run_update_command(const struct update_data *ud, int subforce)
 
 	cp.dir = xstrdup(ud->sm_path);
 	prepare_submodule_repo_env(&cp.env);
-	if (run_command(&cp)) {
-		int ret;
-
+	if ((ret = run_command(&cp))) {
 		switch (ud->update_strategy.type) {
 		case SM_UPDATE_CHECKOUT:
 			die_message(_("Unable to checkout '%s' in submodule path '%s'"),
 				    oid, ud->displaypath);
-			/* the command failed, but update must continue */
-			ret = 1;
+			/* No "ret" assignment, use "git checkout"'s */
 			break;
 		case SM_UPDATE_REBASE:
 			ret = die_message(_("Unable to rebase '%s' in submodule path '%s'"),
@@ -2499,7 +2497,6 @@ static int update_submodules(struct update_data *update_data)
 		ret = code;
 		if (ret == 128)
 			goto cleanup;
-		ret = 1;
 	}
 
 cleanup:
-- 
2.37.3.1420.g76f8a3d556c

