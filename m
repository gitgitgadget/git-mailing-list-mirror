Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC803C433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 16:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiKOQEx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 11:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiKOQEv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 11:04:51 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE481B1
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 08:04:50 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id n20so16604730ejh.0
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 08:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jmTfyfNos0fShwEAfTpIeaH5euD8ZAXxiiF/3EC1w0=;
        b=Hfc4sBtD5tdDtYOr6UnDF2j/DEq2mgIcutgn4Q27Ig39uuSS4Y2NN7n7j9m/d+OMzS
         yRLPOjiKTyp8gBv3ZUOA5fer2MzGCIXpt+RAMFG7iAE0zq9FQKrygzTzukHQ63xnoLtC
         XhfShnBJntVhLr/LnrJ3BqKPVgykIawVAa3njs2vBS8hqCyYM/ZMJiV20RilnsBh35bD
         38tH/9in2ZfmfjTiHYpLXKuiJVBvKNgL4CzpjvzHA64YoRW0MqIgIiPwY7Wc4XgAWDDF
         xc6R90EyefAGCxFXiH1YqMLHnbeLWl/nfSk0xMHxKaT8wwnrLIA+kZGkknzn1kB/saM0
         vB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jmTfyfNos0fShwEAfTpIeaH5euD8ZAXxiiF/3EC1w0=;
        b=zUS3ugm3J1lX7U27HvCaiEyz+yfjvIcTWUibruZOmIclBHg6pwKRxjgoOKI0cVyggK
         XWGgJIjmMLEVLJF+e+W32kmdIKCmyr8bF5BUJDQ/yumIToluyBato8T/pT/OHzKPOMCJ
         Nh4VgolVis97EHnadHP/6cnnMUzS1q10Tk57465QgjIGYU79Z7LFWlh0Gv8FPtCu58BE
         bLtPjWW19wS7Z7ZkNxgd3wMrzMaEPmuLznIoun1oOc/HAaFoC4EUfej+ztoEUM2QtcyG
         3SxdLc1pc3Si+qllE9EO6pCXJyZrC4+J2nyIihwFQl7oktDUXZKDilf8F03UiN0BugDB
         w30A==
X-Gm-Message-State: ANoB5pmYjqgdSi2Vi8st83PUI72Brvy+EgMw15ZG+p6Kc17wT8XHDwvE
        hLAdlxeSyWpGeurw9epEAXUbvxshgYF3AA==
X-Google-Smtp-Source: AA0mqf4UJNblvVt8e3vMYRPP/jIXJjv8wg11cT4wDJ/Ry298N9vkgvri8zFKv1kL0HOgzxJRBGDPFA==
X-Received: by 2002:a17:906:a194:b0:78d:3e6b:d402 with SMTP id s20-20020a170906a19400b0078d3e6bd402mr14088654ejy.563.1668528288215;
        Tue, 15 Nov 2022 08:04:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k3-20020a17090632c300b0073c10031dc9sm5654525ejk.80.2022.11.15.08.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:04:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Ronan Pigott <ronan@rjp.ie>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] maintenance --unregister: fix uninit'd data use & -Wdeclaration-after-statement
Date:   Tue, 15 Nov 2022 17:04:27 +0100
Message-Id: <patch-v2-1.1-f37e99c9d59-20221115T160240Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1473.g172bcc0511c
In-Reply-To: <patch-1.1-54d405f15f1-20221115T080212Z-avarab@gmail.com>
References: <patch-1.1-54d405f15f1-20221115T080212Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since (maintenance: add option to register in a specific config,
2022-11-09) we've been unable to build with "DEVELOPER=1" without
"DEVOPTS=no-error", as the added code triggers a
"-Wdeclaration-after-statement" warning.

And worse than that, the data handed to git_configset_clear() is
uninitialized, as can be spotted with e.g.:

	./t7900-maintenance.sh -vixd --run=23 --valgrind
	[...]
	+ git maintenance unregister --force
	Conditional jump or move depends on uninitialised value(s)
	   at 0x6B5F1E: git_configset_clear (config.c:2367)
	   by 0x4BA64E: maintenance_unregister (gc.c:1619)
	   by 0x4BD278: cmd_maintenance (gc.c:2650)
	   by 0x409905: run_builtin (git.c:466)
	   by 0x40A21C: handle_builtin (git.c:721)
	   by 0x40A58E: run_argv (git.c:788)
	   by 0x40AF68: cmd_main (git.c:926)
	   by 0x5D39FE: main (common-main.c:57)
	 Uninitialised value was created by a stack allocation
	   at 0x4BA22C: maintenance_unregister (gc.c:1557)

Let's fix both of these issues, and also move the scope of the
variable to the "if" statement it's used in, to make it obvious where
it's used.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
Range-diff against v1:
1:  54d405f15f1 ! 1:  f37e99c9d59 builtin/gc.c: fix -Wdeclaration-after-statement
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    builtin/gc.c: fix -Wdeclaration-after-statement
    +    maintenance --unregister: fix uninit'd data use & -Wdeclaration-after-statement
     
    -    In 1f80129d61b (maintenance: add option to register in a specific
    -    config, 2022-11-09) code was added which triggers a
    -    "-Wdeclaration-after-statement" warning, which is on by default with
    -    DEVELOPER=1.
    +    Since (maintenance: add option to register in a specific config,
    +    2022-11-09) we've been unable to build with "DEVELOPER=1" without
    +    "DEVOPTS=no-error", as the added code triggers a
    +    "-Wdeclaration-after-statement" warning.
     
    +    And worse than that, the data handed to git_configset_clear() is
    +    uninitialized, as can be spotted with e.g.:
    +
    +            ./t7900-maintenance.sh -vixd --run=23 --valgrind
    +            [...]
    +            + git maintenance unregister --force
    +            Conditional jump or move depends on uninitialised value(s)
    +               at 0x6B5F1E: git_configset_clear (config.c:2367)
    +               by 0x4BA64E: maintenance_unregister (gc.c:1619)
    +               by 0x4BD278: cmd_maintenance (gc.c:2650)
    +               by 0x409905: run_builtin (git.c:466)
    +               by 0x40A21C: handle_builtin (git.c:721)
    +               by 0x40A58E: run_argv (git.c:788)
    +               by 0x40AF68: cmd_main (git.c:926)
    +               by 0x5D39FE: main (common-main.c:57)
    +             Uninitialised value was created by a stack allocation
    +               at 0x4BA22C: maintenance_unregister (gc.c:1557)
    +
    +    Let's fix both of these issues, and also move the scope of the
    +    variable to the "if" statement it's used in, to make it obvious where
    +    it's used.
    +
    +    Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/gc.c ##
    -@@ builtin/gc.c: static int maintenance_unregister(int argc, const char **argv, const char *prefi
    - 	int found = 0;
    - 	struct string_list_item *item;
    - 	const struct string_list *list;
    -+	struct config_set cs;
    - 
    - 	argc = parse_options(argc, argv, prefix, options,
    - 			     builtin_maintenance_unregister_usage, 0);
     @@ builtin/gc.c: static int maintenance_unregister(int argc, const char **argv, const char *prefi
      		usage_with_options(builtin_maintenance_unregister_usage,
      				   options);
      
     -	struct config_set cs;
      	if (config_file) {
    ++		struct config_set cs;
    ++
      		git_configset_init(&cs);
      		git_configset_add_file(&cs, config_file);
    + 		list = git_configset_get_value_multi(&cs, key);
    ++		git_configset_clear(&cs);
    + 	} else {
    + 		list = git_config_get_value_multi(key);
    + 	}
    +@@ builtin/gc.c: static int maintenance_unregister(int argc, const char **argv, const char *prefi
    + 		die(_("repository '%s' is not registered"), maintpath);
    + 	}
    + 
    +-	git_configset_clear(&cs);
    + 	free(maintpath);
    + 	return 0;
    + }

 builtin/gc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 56b107e7f0b..d87cf84041f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1550,11 +1550,13 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		usage_with_options(builtin_maintenance_unregister_usage,
 				   options);
 
-	struct config_set cs;
 	if (config_file) {
+		struct config_set cs;
+
 		git_configset_init(&cs);
 		git_configset_add_file(&cs, config_file);
 		list = git_configset_get_value_multi(&cs, key);
+		git_configset_clear(&cs);
 	} else {
 		list = git_config_get_value_multi(key);
 	}
@@ -1590,7 +1592,6 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		die(_("repository '%s' is not registered"), maintpath);
 	}
 
-	git_configset_clear(&cs);
 	free(maintpath);
 	return 0;
 }
-- 
2.38.0.1473.g172bcc0511c

