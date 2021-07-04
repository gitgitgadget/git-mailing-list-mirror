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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A952DC07E9A
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 22:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B74561405
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 22:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhGDW6A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 18:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhGDW54 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 18:57:56 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21393C061764
        for <git@vger.kernel.org>; Sun,  4 Jul 2021 15:55:20 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i94so19739518wri.4
        for <git@vger.kernel.org>; Sun, 04 Jul 2021 15:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ohsUwEUJZWDq0n1SM4MVcIHcOiKQb72SOf9FIpQcgSo=;
        b=iTIPjvnxQtBvUUy5l0Ty6YVS+UNzJVXmGSC1jfqeL1VGf4iklWxROQiw+pzih1lzs4
         Tr96cd8oUqquWkhIhqlTb9F1R/YRgQo11EgLMAjOgNuacnuQhrK/WoernhxH4YZEGTPH
         zCfPEIVzdqhZlEi4/fkI/zwoguW3fxBBv1nYv/DdrKDoLkahGoMqX05F4VmwhCKkeE0P
         H+sWeJ+jU5RrrUMpRRIe5A7eB9XqB+uPEXfh3YmZ+NP8yqfhk0lgoM81chDvcYmp+MC5
         ekqt5/1a+ctCsayGrF6LCeb1egBw2Sx+2gf8DDE95n1yFkaVJygpQG7+eDIjJuJXX1ob
         +RcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=ohsUwEUJZWDq0n1SM4MVcIHcOiKQb72SOf9FIpQcgSo=;
        b=h0ml8Ix99ECX7SbBF3r3X6HX6GWju7yKaf84Alu3+RdErpOoxdsDhS8w0MWWsWA6kq
         oDrtzijbDP8S2MTIk6rb3U6w8LyCZmVMdDbAFGoI37ucWipha4fVJuxeiHw3oDX2Bfbh
         jvIXROJDZJQZZyThIzUNOyfilRho9BvtdIvphoIj4FJBhlapmrtqujVbrNPGZLI/mG/l
         TWY9SDG+MsQVSsF8I5dzu/EMkrS9PR2i+WIDmqXckiZJpFqSfguUb+qf18Qgzr2UXeXm
         ar5L355UcBJtTWg5wYsx7lGJfwZohDuCVBveOWI0Ma6L/aGn3iVklzXK71hJRXAcVr2Q
         3ulA==
X-Gm-Message-State: AOAM532ejgYu2WUCfyWHotQRgNvjlvDYaQXS9hs98AzaIlYG9EVGRfcm
        b3KydeHRGcIeENeAcB+4dwd9IekshOM=
X-Google-Smtp-Source: ABdhPJxPnzLAz9WO7GbnCWm61eOq+XwZ1on+5sSbD57XrCUzPjNtadG+eq1ceMpWtlt8r2JEtmTTKw==
X-Received: by 2002:a5d:4a8d:: with SMTP id o13mr12090540wrq.241.1625439318860;
        Sun, 04 Jul 2021 15:55:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j17sm14057337wmi.41.2021.07.04.15.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 15:55:18 -0700 (PDT)
Message-Id: <64f7b1f4e231730c002dfdbac80627ace0e83bbc.1625439315.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v3.git.1625439315.gitgitgadget@gmail.com>
References: <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
        <pull.878.v3.git.1625439315.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 04 Jul 2021 22:55:12 +0000
Subject: [PATCH v3 5/7] artifacts-tar: respect NO_GETTEXT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We obviously do not want to bundle `.mo` files during `make
artifacts-tar NO_GETTEXT=Yep`, but that was the case.

To fix that, go a step beyond just fixing the symptom, and simply
define the lists of `.po` and `.mo` files as empty if `NO_GETTEXT` is
set.

Helped-by: Matthias Aßhauer <mha1993@live.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c3565fc0f8f..04e852be015 100644
--- a/Makefile
+++ b/Makefile
@@ -2675,10 +2675,13 @@ po/git.pot: $(GENERATED_H) FORCE
 .PHONY: pot
 pot: po/git.pot
 
+ifdef NO_GETTEXT
+POFILES :=
+MOFILES :=
+else
 POFILES := $(wildcard po/*.po)
 MOFILES := $(patsubst po/%.po,po/build/locale/%/LC_MESSAGES/git.mo,$(POFILES))
 
-ifndef NO_GETTEXT
 all:: $(MOFILES)
 endif
 
-- 
gitgitgadget

