Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC12C0018C
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 23:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97B4923BE5
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 23:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391812AbgLJXN2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 18:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391839AbgLJXNR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 18:13:17 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47035C0611CB
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 14:37:17 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a6so6021143wmc.2
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 14:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wgxnSsbC7L9Mc1xpGuOrcn+3CuCN0TyjlWT75S2Kiac=;
        b=jnhs3at7b6gjTcSeSjPpMq76cgMVqyKNjSIu4e25jVN0EtJovXtYIeSJS/yqjzTKMq
         neBLv88jXC5XbrBAe1ATBJqHU33mHyxLFangqK3lkCNpnFyOmQMjLyWtGciHVTIOLRXv
         RYL3WbDaeEoK9KEZylpAZlh/cIYIi6B56NwVM9ccC5/r3hJAoPBgasZCeHvojbIQjQTp
         4TaZkSkiMcQJ33zX5LjNsAEyakj/gycwX+6sKiiK74CKI+A057eqd5caFESaTol4cKQU
         Yzn4xWpxsNfoDG+Tn625pAi3RfKPrwY2fMqNkJpees2rKaAFXIfl3ko7xzC2fRrXaKQ0
         CQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wgxnSsbC7L9Mc1xpGuOrcn+3CuCN0TyjlWT75S2Kiac=;
        b=dY2lyXp60i9UdWTLlJv95ReOLK0y72bWKuXgsa5SYyUhmqMObYoHea/WKHYxnRSsLp
         oVWikbEXwbPRyhn86/1j6q5n399WvK50rsYCB+IGClB+F2aIdoC3vOmPiWGBdHrStOWp
         1Ieklqry+4tOjt4N9mivleLv0WBHFdSv0VDqLF8P8Qa8MVGRyMdmaKRJJYAwus/9LUrB
         kg2SEE2uqNehX1bdYJlLudoGVAavCo3SNCK2/6uEWOmFVisOQ8d0MRrrhMQjb+wKx9Tt
         ujwjytuCLfSZFO2pmhEKMIFnnRAJe6gFOKIhyTvJYPOsGIQjjHtfmSDpPdEejg8CAW6N
         2kNA==
X-Gm-Message-State: AOAM533PA9lhMUJ9VVa0YEF/kkMoqm6WJ3TXAw2Q7CCInEGBt9DtyxvG
        P1yZF01or9/o/qX7cgm9W5gumbtgMhU=
X-Google-Smtp-Source: ABdhPJxFalV0NNm2DR4IV0YZOH/kFJBHOA2DsGVMFqKuCanFdyYpoDOXkK19QSibAr9+aF1g/8Paeg==
X-Received: by 2002:a1c:bc88:: with SMTP id m130mr10588234wmf.82.1607637519814;
        Thu, 10 Dec 2020 13:58:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d9sm12240237wrc.87.2020.12.10.13.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 13:58:39 -0800 (PST)
Message-Id: <483e490349165223a80a0bdf7716c5189560c977.1607637517.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com>
References: <pull.921.v3.git.git.1606230450.gitgitgadget@gmail.com>
        <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Dec 2020 21:58:33 +0000
Subject: [PATCH v4 1/4] init: document `init.defaultBranch` better
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
index 59ecda6c17d..2b399cb73d7 100644
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
+`master`, but that will be changed in the future; the name can be customized
+via the `init.defaultBranch` configuration variable).
 
 --shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
 
-- 
gitgitgadget

