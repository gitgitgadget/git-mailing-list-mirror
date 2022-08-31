Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8116ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 08:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiHaImN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 04:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiHaImF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 04:42:05 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DDBBCC1F
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:42:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso2572398wmr.3
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6BYeDT5hU6O4kU9gX8r4+SYqkWUY9/01sHdede1dbZc=;
        b=GRVysd/zD+EwYk8wnIAwJSUYC7e8txla1491+raK4m5q2Xc8nAUqWjyoMQ9lwMzC8m
         BWEbLWFEaYFJD2fT0MNUC4EPj7EyU8hYRHgYkyXlyWt1ab6S1a69Egw8QLtNVPLgnWF9
         HGAlkKW9N5vXu7pqmNC64XoyUcDkjajbKD+ZqMI4jOm5x10zPGo208Q40xlhBjitS7B4
         GYVpNvuEwdb96dpMiprB8rhyjBuKNvQ/PU23g2laGaka3bqJ2FG7glxZ2Mz+l8sPNBm1
         bIHTqnhFvFBSSkqjYOHMKt6tF3dckw4V0hYlSe6pxD3h7oJV+ohebGVYFwBVIJfgAYIt
         +hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6BYeDT5hU6O4kU9gX8r4+SYqkWUY9/01sHdede1dbZc=;
        b=rXWSgkKFZieTywFdlgwFOC443wXqLoXDli0KcZFxqbA+2dWv1pWMdozQ1zYirI7AhU
         eawFtbLTJsiqUHhyf6zS1VWAEpvnb/v5/dVhOIOV85gq8BHSCrZsVtc5mHeZGFjbKnha
         1s8To0f68k0dU7pUfRMnkwh92G/xNXa7lCCwV/pI23a8ztruNHCEVIMDz1ud4LejXRyD
         DscPWad07dD3Z32zc5rAgacZaG6e4Kxm36Vdflne2ufiYQs0trbfTpOSfoJZnp0u3ADr
         Ul8FxVGZ1HYpqZEDWCIt2W/zN+77YJKWkBYmBDhpLjauz/Nu1kWL7LfAY8Ba6Kto2GnE
         fcYg==
X-Gm-Message-State: ACgBeo18281N9pCzo3MEgXwhrcz69nMidDttcgmOmpUfuCy090cwdlmA
        WtIvihHdelVdLYcgUvSP+K9h+2SfrcpcDg==
X-Google-Smtp-Source: AA6agR77+/NeeKADPy1dh1e3gMMFyvNb07GHS3N2IOfilMrcAgsQ/fLBZp+Ig1JwpiM+U2P94gsp9Q==
X-Received: by 2002:a05:600c:5105:b0:3a8:3f3c:ca90 with SMTP id o5-20020a05600c510500b003a83f3cca90mr1211578wms.81.1661935318519;
        Wed, 31 Aug 2022 01:41:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2-20020a7bc5c2000000b003a5c064717csm1439036wmk.22.2022.08.31.01.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 01:41:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 7/9] log docs: de-duplicate configuration sections
Date:   Wed, 31 Aug 2022 10:41:38 +0200
Message-Id: <patch-v3-7.9-e07585ba085-20220831T083759Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1406.g184357183a6
In-Reply-To: <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/log.txt |  4 ++++
 Documentation/git-log.txt    | 30 ++----------------------------
 2 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index 5250ba45fb4..bc63bc3939c 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -7,6 +7,10 @@ log.date::
 	Set the default date-time mode for the 'log' command.
 	Setting a value for log.date is similar to using 'git log''s
 	`--date` option.  See linkgit:git-log[1] for details.
++
+If the format is set to "auto:foo" and the pager is in use, format
+"foo" will be the used for the date format. Otherwise "default" will
+be used.
 
 log.decorate::
 	Print out the ref names of any commits that are shown by the log
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 410095e9a4f..2a66cf88807 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -209,36 +209,10 @@ i18n.logOutputEncoding::
 	Defaults to the value of `i18n.commitEncoding` if set, and UTF-8
 	otherwise.
 
-log.date::
-	Default format for human-readable dates.  (Compare the
-	`--date` option.)  Defaults to "default", which means to write
-	dates like `Sat May 8 19:35:34 2010 -0500`.
-+
-If the format is set to "auto:foo" and the pager is in use, format
-"foo" will be the used for the date format. Otherwise "default" will
-be used.
-
-log.follow::
-	If `true`, `git log` will act as if the `--follow` option was used when
-	a single <path> is given.  This has the same limitations as `--follow`,
-	i.e. it cannot be used to follow multiple files and does not work well
-	on non-linear history.
-
-log.showRoot::
-	If `false`, `git log` and related commands will not treat the
-	initial commit as a big creation event.  Any root commits in
-	`git log -p` output would be shown without a diff attached.
-	The default is `true`.
-
-log.showSignature::
-	If `true`, `git log` and related commands will act as if the
-	`--show-signature` option was passed to them.
-
-mailmap.*::
-	See linkgit:git-shortlog[1].
-
 include::includes/cmd-config-section-rest.txt[]
 
+include::config/log.txt[]
+
 include::config/notes.txt[]
 
 GIT
-- 
2.37.3.1406.g184357183a6

