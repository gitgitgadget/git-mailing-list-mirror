Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2312C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 06:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CFC560FC3
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 06:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhJVGo3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 02:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhJVGo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 02:44:27 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27133C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 23:42:10 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 187so2749973pfc.10
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 23:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JGEJupecB/IyS/f6Y9JyuQnPUpr15SBY2WK9cmy+WFI=;
        b=qGfcO6c3wEl5gUmkGQKL+xrH16iuSMnen/jztVK2fquGuw6AGbTyCp8VGFNny32WxA
         qotq0mCUuNuXxg4hLVwRyUKoMi/8iHbx3RWZXBqshnrvqMOmJ+7jcAd2+mVxPAbCoipK
         +Pz/Ng3a7gNJ1hr4ySbxM27IQMAQiGIrGAV2/YhaAHDwr0g6g7RE4QkBpGgGfQrzdmRm
         QA3/q0Qd9Gzyzf+A10uAHwkua8cCvKE0Iw9DP6g5xcBdK+mY2AYhS1agzC4cUKrVxDp7
         1mshOX3WbBRzDvYNk8B861Cp/HNSoSnbKrLhikJXJtv9hW+NnlaMWCMS8+qeA+W/r2j6
         4qYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JGEJupecB/IyS/f6Y9JyuQnPUpr15SBY2WK9cmy+WFI=;
        b=qOE+OJkDaRcAbgcempd+jgDcauvEXaYlJ8N5mHTz+VnFFuCxIwUivoxMLiAHZK8HTc
         ltbcLoCQnIzpBbKJgJwHmvnJhC9ke0fSpvM7zETuzCTmP2jcYRGcjMeKlzYre8tCNMLC
         FytU4ct9n8vu2eUV0QjJT047aaQv/EjEgyiDjBU1TCEFAuQ3SvG4jYR3d5KNsru8Q8HC
         IgYC08KljQD83y6p2dFBsc7blES/oSH1I90sgCERW2qRZkcvER00YAm6bw9MxeTTs7fD
         ZgjFUoUtb9V7xwSpvFxjUtpgu+XRG458Z8nZjE9sRqT0ZBVakjBUEbBowCOZM350Qvrc
         OChw==
X-Gm-Message-State: AOAM5325pfrmHH9UnasJtmX92VYIOeZ2ZfSeV1PVjwbk0/xGCtVRBYCM
        lQVDvORME/KLZ/PXckMHA4HR4rBh8fctB+3l
X-Google-Smtp-Source: ABdhPJyiCzKIi2c4avKr4rOG2Cvhurai+lSbVZo4gz0gerqqtg1fDlKyM3NR/WxEAiVZ3S4O+hs0Ew==
X-Received: by 2002:a63:e243:: with SMTP id y3mr8132840pgj.101.1634884929474;
        Thu, 21 Oct 2021 23:42:09 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-84.three.co.id. [180.214.233.84])
        by smtp.gmail.com with ESMTPSA id l17sm9766097pfc.94.2021.10.21.23.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 23:42:09 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] MyFirstContribution: teach to use "format-patch --base=auto"
Date:   Fri, 22 Oct 2021 13:40:46 +0700
Message-Id: <20211022064044.28761-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Let's encourage first-time contributors to tell us what commit they
based their work with the format-patch invocation. As the example
already forks from origin/master and branch.autosetupmerge by
default records the upstream when the psuh branch was created, we
can use --base=auto for this.  Also, mention to the readers that the
range of commits can simply be given with `@{u}` if they are on the
`psuh` branch already.

As we are getting one more option on the command line, and spending
one paragraph each to explain them, let's reformat that part of the
description as a bulletted list.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
[Bagas Sanjaya: fix grammar in commit message and explain `auto` value]
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/MyFirstContribution.txt | 41 ++++++++++++++++++---------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index b20bc8e914..b896d10755 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -905,19 +905,34 @@ Sending emails with Git is a two-part process; before you can prepare the emails
 themselves, you'll need to prepare the patches. Luckily, this is pretty simple:
 
 ----
-$ git format-patch --cover-letter -o psuh/ master..psuh
-----
-
-The `--cover-letter` parameter tells `format-patch` to create a cover letter
-template for you. You will need to fill in the template before you're ready
-to send - but for now, the template will be next to your other patches.
-
-The `-o psuh/` parameter tells `format-patch` to place the patch files into a
-directory. This is useful because `git send-email` can take a directory and
-send out all the patches from there.
-
-`master..psuh` tells `format-patch` to generate patches for the difference
-between `master` and `psuh`. It will make one patch file per commit. After you
+$ git format-patch --cover-letter -o psuh/ --base=auto psuh@{u}..psuh
+----
+
+ . The `--cover-letter` option tells `format-patch` to create a
+   cover letter template for you. You will need to fill in the
+   template before you're ready to send - but for now, the template
+   will be next to your other patches.
+
+ . The `-o psuh/` option tells `format-patch` to place the patch
+   files into a directory. This is useful because `git send-email`
+   can take a directory and send out all the patches from there.
+
+ . The `--base=auto` option tells the command to record the "base
+   commit", on which the recipient is expected to apply the patch
+   series. The `auto` value will cause `format-patch` to track
+   the base commit automatically, which is the merge base of tip
+   commit of the remote-tracking branch and the specified
+   revision range.
+
+ . The `psuh@{u}..psuh` option tells `format-patch` to generate
+   patches for the commits you created on the `psuh` branch since it
+   forked from its upstream (which is `origin/master` if you
+   followed the example in the "Set up your workspace" section).  If
+   you are already on the `psuh` branch, you can just say `@{u}`,
+   which means "commits on the current branch since it forked from
+   its upstream", which is the same thing.
+
+The command will make one patch file per commit. After you
 run, you can go have a look at each of the patches with your favorite text
 editor and make sure everything looks alright; however, it's not recommended to
 make code fixups via the patch file. It's a better idea to make the change the

base-commit: f443b226ca681d87a3a31e245a70e6bc2769123c
-- 
An old man doll... just what I always wanted! - Clara

