Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002A7C05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 22:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjBFW7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 17:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjBFW7i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 17:59:38 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EF732518
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 14:59:09 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m14so11895416wrg.13
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 14:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYo4LmQz8tsOCeeINxs8N0upCxpze1DHtxPxolZQxoI=;
        b=pqZgNztKIRp0oVSb0H2KhckOF3XPEr4ucNSCrDRASlze6ES5CAhQdy4pVWfXNV7zpz
         rG8BD9aG/gGUjdnfgzmY4cLnymvVKXC4AVEJkE3EPjdAMIIjUiTX2ABSXME1vTi5E6bj
         0Hva1mApFpoO6hAwXjAGzfwD9T1chvFkcXRY9j6uGyM3YnDUdvbNXRj8/HJHzLe4yKt0
         KauRd5OKRQdj8PQh+fShwh+H0kdEniZVyV6oLwnOAErEa13qQhDNyN0fWm1g0Uig74vy
         5zIkdxYeGzzjlhf/LrJNfXIkc3FjHyy5yp0D3ePJiFawaT51eg4Y2Wz4tXxEelPL0ee4
         jPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYo4LmQz8tsOCeeINxs8N0upCxpze1DHtxPxolZQxoI=;
        b=poJVeBr2dJnn12pXjY+V2M7UQdQkvl1wFX/fMvjYB9SquiKvwm3XeQHKqDvkqwb4Yf
         orJ1xUD211xhtpiU62lf8PC+AZkbn3BZ6jyG1ccEohdL62Zpt2ybl5FlEfDh1gY9A54Z
         uMadcOMIGoWcy+9os//XG3w90QCKOZ8pYbJ3sXm0C87/MeX1rO/mzj/9VmZ9dZ1Hny5Y
         6/MxwvcBqM4mbsYZ75B9LmBOsgpeRxk9b26w/o30RbY3SODACvyEZq2478gZZFqx79C9
         Z61AWgBy1kjIZ59O7DNLceZ61gQ9vhiS0K8PnGzxp33t1rJkyKK32o4VrMQix1hK0rRC
         eFrw==
X-Gm-Message-State: AO0yUKWEtr9xB72JQ1X60qmNKZtFfjVecbJoENNFhjozsC2luBflCPUZ
        N1iC/bwBEbr+PgtZhSHzfB4PKA0Bl0rSy9Gi
X-Google-Smtp-Source: AK7set9J0fSQJlWXvqd0cdBRXM+6+PsuEUA4xcm2Me2udofInt2QLy14WUzImCvzpfQ8/QuObFv4pA==
X-Received: by 2002:a5d:5052:0:b0:2c3:ea70:2898 with SMTP id h18-20020a5d5052000000b002c3ea702898mr528033wrt.34.1675724347112;
        Mon, 06 Feb 2023 14:59:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y17-20020adfd091000000b002c3ea68c58asm3170055wrh.1.2023.02.06.14.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 14:59:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?Slavica=20=C4=90uki=C4=87?= <slawica92@hotmail.com>,
        Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/3] docs & comments: replace mentions of "git-add--interactive.perl"
Date:   Mon,  6 Feb 2023 23:58:58 +0100
Message-Id: <patch-v2-3.3-09bece75c22-20230206T225639Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v2-0.3-00000000000-20230206T225639Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20230203T125859Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20230206T225639Z-avarab@gmail.com>
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
2.39.1.1425.gac85d95d48c

