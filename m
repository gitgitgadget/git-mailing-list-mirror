Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D49C636D4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 16:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjBCQam (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 11:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjBCQah (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 11:30:37 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB29DA7ED8
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 08:30:36 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id u10so1235746wmj.3
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 08:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7Cq3J8IOs7fbOMsbvicyr72gbuokByue01r+u5Z8NQ=;
        b=TemfIgNxmen6ZBQnycu2/a1dGMDutkYWvgJIQZ6j8qOxhbLPCryfzwSBJxgvx42zfO
         s+y2NWBES1UtXOFyDULzKGZiMXbT9hKS0mqOSLqnjDlpJ+ue3fK9XFm9rHRKhXiVYHl+
         bC1H0X99Eo8c8vNm571LhVYymAMCjrDo91gmpNFerjsEbeChO5tpLJQDIs/JGZ51FK2t
         RIR9uqCznTOpnLuE0tO6aAkTjKzSAD24zB7HOIjMzsH98Y7ImsqiCTCHRSRMcqF4h0Re
         0i1yFG/QZLnpwUBdSPvZ1EFl6QlNrqFB2pJcGu7Oyv4pi3huCMYafiIHED52fX3FNwLl
         mwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7Cq3J8IOs7fbOMsbvicyr72gbuokByue01r+u5Z8NQ=;
        b=3OLXNtVtFXidQ3WkIWoxyrv5z8cMBpxvJrbE0HS2G5KMNTNL5Vgb3k7AhCaobTGl93
         f6eIrlU12Kf/K8TWwVmjbG57par1t0kIYwxByUx/R35Go63S3IIkBqnyiycmhszA0ZLd
         +YB7dOgdd40WoC8PSv9prop24ePzD8fJT8BEXl/MZWSLaw2zdgP5B/tcfm7cMO4Amw2I
         YwzYfRQhvbkTAbQOhZsjULgEoyWrzf/soaETTkGU3DLLrDJhio+fwWUK3pz5e9f49Ye2
         JaoRDWyJYXCrIKdEJZTwHDjeBameLbtoiy0ROogCnsw7+G2p/5tdxB/qxwTOUeYib1ow
         Q7Eg==
X-Gm-Message-State: AO0yUKXyivrF6TWZsxOtEK03WjQwAtBFI+qP4Joc6s4DRnRoWhknHn6x
        aQaZaiulFrpFsDOv88AZrO3vNACmtnX9WV+Q
X-Google-Smtp-Source: AK7set++4/0nLqTtLsJo8kV3Mn7OztQ9z8UD+bgGD8k0367HFgiX9ucN75GH3xzBAtadsO0bfq2gCQ==
X-Received: by 2002:a05:600c:510e:b0:3dc:59e9:9285 with SMTP id o14-20020a05600c510e00b003dc59e99285mr11239531wms.18.1675441834894;
        Fri, 03 Feb 2023 08:30:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d6a87000000b00287da7ee033sm2315637wru.46.2023.02.03.08.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 08:30:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?Slavica=20=C4=90uki=C4=87?= <slawica92@hotmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] docs & comments: replace mentions of "git-add--interactive.perl"
Date:   Fri,  3 Feb 2023 17:30:04 +0100
Message-Id: <patch-3.3-6ee56de1371-20230203T125859Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1397.gbe42486b8a4
In-Reply-To: <cover-0.3-00000000000-20230203T125859Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20230203T125859Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we've removed "git-add--interactive.perl" let's replace
mentions of it with "add-interactive.c". In the case of the "git add"
documentation we were using it as an example filename, so the mention
wasn't wrong, but using a dead file is slightly confusing.

The "borrowed" comment here likewise isn't wrong, but let's mention
the successor file instead. In the case of pathspec.c the implied TODO
item should refer to the current code (and the comment may not even be
current, I didn't check).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-add.txt | 6 +++---
 builtin/clean.c           | 2 +-
 pathspec.c                | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index a030d33c6e7..ed44c1cb31c 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -274,7 +274,7 @@ status::
 ------------
               staged     unstaged path
      1:       binary      nothing foo.png
-     2:     +403/-35        +1/-1 git-add--interactive.perl
+     2:     +403/-35        +1/-1 add-interactive.c
 ------------
 +
 It shows that foo.png has differences from HEAD (but that is
@@ -282,7 +282,7 @@ binary so line count cannot be shown) and there is no
 difference between indexed copy and the working tree
 version (if the working tree version were also different,
 'binary' would have been shown in place of 'nothing').  The
-other file, git-add{litdd}interactive.perl, has 403 lines added
+other file, add-interactive.c, has 403 lines added
 and 35 lines deleted if you commit what is in the index, but
 working tree file has further modifications (one addition and
 one deletion).
@@ -303,7 +303,7 @@ like this:
 ------------
            staged     unstaged path
   1:       binary      nothing foo.png
-* 2:     +403/-35        +1/-1 git-add--interactive.perl
+* 2:     +403/-35        +1/-1 add-interactive.c
 ------------
 +
 To remove selection, prefix the input with `-`
diff --git a/builtin/clean.c b/builtin/clean.c
index b2701a28158..1e6d491d3be 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -560,7 +560,7 @@ static int parse_choice(struct menu_stuff *menu_stuff,
 
 /*
  * Implement a git-add-interactive compatible UI, which is borrowed
- * from git-add--interactive.perl.
+ * from add-interactive.c.
  *
  * Return value:
  *
diff --git a/pathspec.c b/pathspec.c
index dbcfe7b3216..ab70fcbe613 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -545,7 +545,7 @@ static void NORETURN unsupported_magic(const char *pattern,
 	}
 	/*
 	 * We may want to substitute "this command" with a command
-	 * name. E.g. when add--interactive dies when running
+	 * name. E.g. when "git add -p" or "git add -i" dies when running
 	 * "checkout -p"
 	 */
 	die(_("%s: pathspec magic not supported by this command: %s"),
-- 
2.39.1.1397.gbe42486b8a4

