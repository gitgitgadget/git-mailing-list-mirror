Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FA8C63798
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 23:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BADA20771
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 23:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAlgiDCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKVXXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 18:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgKVXXb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 18:23:31 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94B4C0613CF
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 15:23:30 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r17so16947966wrw.1
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 15:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HK8Cga6yqD2xYMQ+t6PPXGVS4VNst4tdBe0uo0y/dxk=;
        b=LAlgiDCxNMizgkehRd7dK7saRqtd2QkJGdOqekxv3LWLS2JllKDrQX3dl1uqGtReLU
         Se1s/sfUyusOOiX5kfondEQKWtehSeFRKQoOAkh2jxs7Ju9VwuJNHL8NiHJsmQlPGeN/
         6Q/3ZmfVRMaW8xE4j8Za8Qyv3nP1PQ+gRrZhMMLUXMvIoAhI3PBMr1Q4l2NqZe9AabwZ
         QiVi9VMLJLHrKeWsCplPHQs+1aQ66oFI2bFa6LJ8XE5by6yJT97kJ/WvFJnEMhg5w3pt
         p+U5CG7wwGICB+oO36zmgnCMoiX/Dl90kYu6MkytQaZ+hU7gMjmw53CDf1VQVh/d5Zar
         DEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HK8Cga6yqD2xYMQ+t6PPXGVS4VNst4tdBe0uo0y/dxk=;
        b=O5v+dzI8qYba4k/LYwHJHmXoJGmsvxT47XmYLZU1kPFxh9pFyzFuZhG3nLehBUB3Ma
         YWGsNOMKPTc3I6U0GYdooZlxMXWVZdm0mb/nuLZtB6zIEjqJw+lP2JuDxmw4y7KiT+GG
         In7KloW+W+dS3oxieUEMOo4Yc08iSTWQN8J9Wlj/5BxiaFARp7ytMZ+ptVSE1QBKrZdE
         f144roZ9Cdiwj+Oj7KuDKYxDc5TCZMxRtlqXIMacOqNVshTq3Ai+hkU7rh0kuf3vUZLG
         7UAnDhHT/rVvOQwZUxIVjbrcKK2P5pGTO0/duftkKcfMCvI8zwXVA3Lckpy5X/E/uJh6
         Tebg==
X-Gm-Message-State: AOAM53262oaRhlqlc6QIZocMJFZZvVJ0nl0FoUymriBcRQ2TG79yRviS
        O5BIS7XL659K7xahfnsgDRsGOcMpQ88=
X-Google-Smtp-Source: ABdhPJyc502BBi2AFvhZC33Ropy87s83IrMoq8QxJCWG4GQi5fFke2hl5u/Rb853M40WxEj6vEpKTg==
X-Received: by 2002:a5d:5643:: with SMTP id j3mr27122179wrw.43.1606087409273;
        Sun, 22 Nov 2020 15:23:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u81sm14129816wmb.27.2020.11.22.15.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 15:23:28 -0800 (PST)
Message-Id: <1518387eaa95098707878459bc74bd5ef2179386.1606087406.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 22 Nov 2020 23:23:24 +0000
Subject: [PATCH 1/3] init: document `init.defaultBranch` better
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
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
index 59ecda6c17..19f9f16e6b 100644
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
+`master`, but that will be changed in the future; The name can be customized
+via the `init.defaultBranch` configuration variable).
 
 --shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
 
-- 
gitgitgadget

