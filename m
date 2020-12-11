Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1DFC4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 11:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D89B23ED0
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 11:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390055AbgLKLiS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 06:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403810AbgLKLhm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 06:37:42 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BA9C061793
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 03:37:01 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id d3so7275525wmb.4
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 03:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p0enlMc/568fNOt3yvkxyzEyBOUTnOaQV/xOUwc/+so=;
        b=bz0U5Fk2jDZliG5Q2QwH9TmtZqjkYJ5xYCep6+AoWk4H6b3ick3ohjdyf2ZdH2kLN6
         WHOUqodJqBA+CLDqo628lBftM6ha/gveVo+gNzLBse9hHA13Ue2hUF40YZdtIl0mtj2k
         ju7CfD4TVoAAxXyESzroeAu3r/E4v3s8cC1Qe6JSdadCl16nU3fPL+T52TMrckEDSchm
         U6hJT/iRtujTe3g0c7pqUlEYq6veUruSCDtC7ldhSaIdACSsmm3XUrnLHszUBG1H303J
         9IMl+djj7bkAcR8+UbmLwYgaZuCFqjjG2MkzaU924XeSKiWf1PdGy09eRnPSFAYv8c5c
         b8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p0enlMc/568fNOt3yvkxyzEyBOUTnOaQV/xOUwc/+so=;
        b=Vg1cAxp8DPOETQOOZIbqs12HGx+1+b2BJP6nK+5qm6Em3J70DozPa67pwBhQdywMo6
         62Rs7ggabx7kcRX/Gt/LLuPFsMeLKPdMAWlPn5fX6tCJOadKtI9zb9HIRJGl34IQFTD5
         6jJNOI/rjUR192pf0NCfNIhEJl8oRrQolzn8jAb1vEWUn3N2Sp2x09T6JDjiQMCOZkrB
         MHmcDYdFSUlQaRBZf/dPfJn630P0nyEOEc/SAhhQrJ+b1v3vR/NmjbLim0uvmnQQ7gys
         Lg6OLKsyQQGxTIefGO7m9Ex24AZqC9tzLgYoFcAiWNKL5O92qwJmbWCS5afV5MSFu05r
         ix8A==
X-Gm-Message-State: AOAM530+ZI0EMQPn5B34oIvS7HxwhLDZSowZ6JPcpjGJqXIeTXprbkNl
        ccZqcylnKZRY57/2jiAWSe/4qivCwzU=
X-Google-Smtp-Source: ABdhPJzZRR9KAIBN75l5T2KumyC+sSetT+SVCD5tyvkNMDylASN5caitiI8zacReLAVj4BxAdI5nuw==
X-Received: by 2002:a1c:e445:: with SMTP id b66mr13330590wmh.187.1607686620195;
        Fri, 11 Dec 2020 03:37:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u85sm13454532wmu.43.2020.12.11.03.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 03:36:59 -0800 (PST)
Message-Id: <ce35cf3da65c60980d1dfdce20928a1498b6390b.1607686618.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.921.v5.git.git.1607686618.gitgitgadget@gmail.com>
References: <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com>
        <pull.921.v5.git.git.1607686618.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Dec 2020 11:36:54 +0000
Subject: [PATCH v5 1/4] init: document `init.defaultBranch` better
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Our documentation does not mention any future plan to change 'master' to
other value. It is a good idea to document this, though.

Initial-patch-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-init.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 59ecda6c17d..b611d80697d 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -20,8 +20,9 @@ DESCRIPTION
 
 This command creates an empty Git repository - basically a `.git`
 directory with subdirectories for `objects`, `refs/heads`,
-`refs/tags`, and template files.  An initial `HEAD` file that
-references the HEAD of the master branch is also created.
+`refs/tags`, and template files.  An initial branch without any
+commits will be created (see the `--initial-branch` option below
+for its name).
 
 If the `$GIT_DIR` environment variable is set then it specifies a path
 to use instead of `./.git` for the base of the repository.
@@ -73,8 +74,10 @@ If this is reinitialization, the repository will be moved to the specified path.
 -b <branch-name>::
 --initial-branch=<branch-name>::
 
-Use the specified name for the initial branch in the newly created repository.
-If not specified, fall back to the default name: `master`.
+Use the specified name for the initial branch in the newly created
+repository.  If not specified, fall back to the default name (currently
+`master`, but this is subject to change in the future; the name can be
+customized via the `init.defaultBranch` configuration variable).
 
 --shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
 
-- 
gitgitgadget

