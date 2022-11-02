Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD276C43219
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 07:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiKBHy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 03:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiKBHyO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 03:54:14 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74E025EB6
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 00:54:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bj12so42980982ejb.13
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 00:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qth/4vtY+GWDUDv1yyhAF72QYNGKyQd+E2A4KecpBHk=;
        b=XfU0n7ocFQFbkGwRNdOt4u1YPKHhybB+XhT5U3GBBMLH6KzoS4yXsGnCEAssXS1N70
         Q+CyuyksYNbh6SYct2KOZ5gDUlkTPtaKeoCp3YC0OXI7Eqpm9+zyqnJ6TLBvAo+Z30pW
         JpUeD22SaDkax1yHRIoVVOwutH8OjSkLN5ApylU36rrFCPjhr0gSzqyk/jzMn88MiksA
         c1EJtlJ5R6iog57OuAdTSIo4nRvKYHpxJV/MwNooLPdU0YC6Uhc7dOwkjYupRMfc1yR/
         1+5S6cGmHx5uYMeCtQgpR4W9K5CcdxdRwFWVMpHnrgcKlEUW9ffWwRCkJN3rNInKsEdb
         LNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qth/4vtY+GWDUDv1yyhAF72QYNGKyQd+E2A4KecpBHk=;
        b=AC/LReOyfEvaFrfqtHcYNQF0BRg2+7gxA+JrXEmeEPVyj03B7qV0skftzKArKQUeky
         eah9LqvgpLCZTLqEOcF6FquF0kgcAV6WKgT2/zBD0JxOVA+c03AluWtw6u5ifxe3QGUR
         lh1nWeTB0eWBxxGspN95oA3JZ0YSIStbRxQ9tAgjh5Z6HIngtKJuM5ZAScTXKsSZPSco
         RMG07R+CzyHwppM9FLO8Jf1oUYRnSgKL8oUGFTreL7mjllzzxe9ucv8GUHyXa0e6Z9fl
         w+TksirmRgNZVN2mADVDefF/nYvBOnqxVliJhxT6Pu3ZkLpVkf/Sc52r3EU13B0v0/wT
         W6aw==
X-Gm-Message-State: ACrzQf30sGC6w1PjlhIClbc4vci4+LfBRzsuHQBQKrZP24cUxalx7aAG
        Ltl66OtPeyi61Ao4tydG+SQe6kx0+3jKqw==
X-Google-Smtp-Source: AMsMyM7LfeodOwiZEP9bLrWZiGbXPsMKfbQbPhKvqClHUCkl+RBCRxNc7ubJONGEBDv4UFgzsqVVVg==
X-Received: by 2002:a17:907:d89:b0:7a8:d67d:87d3 with SMTP id go9-20020a1709070d8900b007a8d67d87d3mr21908177ejc.364.1667375651953;
        Wed, 02 Nov 2022 00:54:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ku11-20020a170907788b00b0073d84a321c8sm5045466ejc.166.2022.11.02.00.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 00:54:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/8] submodule.c: refactor recursive block out of absorb function
Date:   Wed,  2 Nov 2022 08:54:01 +0100
Message-Id: <patch-4.8-f7adfbc13ae-20221102T074148Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A move and indentation-only change to move the
ABSORB_GITDIR_RECURSE_SUBMODULES case into its own function, which as
we'll see makes the subsequent commit changing this code much smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 submodule.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/submodule.c b/submodule.c
index b958162d286..fe1e3f03905 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2310,6 +2310,23 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 	strbuf_release(&new_gitdir);
 }
 
+static void absorb_git_dir_into_superproject_recurse(const char *path)
+{
+
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	cp.dir = path;
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	strvec_pushf(&cp.args, "--super-prefix=%s%s/",
+		     get_super_prefix_or_empty(), path);
+	strvec_pushl(&cp.args, "submodule--helper",
+		     "absorbgitdirs", NULL);
+	prepare_submodule_repo_env(&cp.env);
+	if (run_command(&cp))
+		die(_("could not recurse into submodule '%s'"), path);
+}
+
 /*
  * Migrate the git directory of the submodule given by path from
  * having its git directory within the working tree to the git dir nested
@@ -2366,21 +2383,10 @@ void absorb_git_dir_into_superproject(const char *path,
 	strbuf_release(&gitdir);
 
 	if (flags & ABSORB_GITDIR_RECURSE_SUBMODULES) {
-		struct child_process cp = CHILD_PROCESS_INIT;
-
 		if (flags & ~ABSORB_GITDIR_RECURSE_SUBMODULES)
 			BUG("we don't know how to pass the flags down?");
 
-		cp.dir = path;
-		cp.git_cmd = 1;
-		cp.no_stdin = 1;
-		strvec_pushf(&cp.args, "--super-prefix=%s%s/",
-			     get_super_prefix_or_empty(), path);
-		strvec_pushl(&cp.args, "submodule--helper",
-			     "absorbgitdirs", NULL);
-		prepare_submodule_repo_env(&cp.env);
-		if (run_command(&cp))
-			die(_("could not recurse into submodule '%s'"), path);
+		absorb_git_dir_into_superproject_recurse(path);
 	}
 }
 
-- 
2.38.0.1280.g8136eb6fab2

