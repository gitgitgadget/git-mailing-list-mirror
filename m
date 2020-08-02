Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B637C433E0
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 15:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4792B20738
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 15:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjeM49gS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgHBPUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 11:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgHBPUv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 11:20:51 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AF5C061756
        for <git@vger.kernel.org>; Sun,  2 Aug 2020 08:20:51 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id f18so9527513wmc.0
        for <git@vger.kernel.org>; Sun, 02 Aug 2020 08:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=djD/3SIoEHw+iUsL/AdbKgn+UWa7uq1S8vjdmn3IL3w=;
        b=OjeM49gSYSzekJCuP29kUaeDPpZArw+g2K/4Q1IuECLw+QSKk7oeZTXGQIgGk7DO60
         qy24IhJLAbYJVlmsy/JA+h7aHdapDaLVawg9aoSNwZTNac52j7vZ7GpVi8/iV7fKL+mb
         w6F6iAzr6ffWirRU/WV5aOQaw38I8rRabH35QKvI4b7JYAhz6x7aF/gT39KLdXiVy7j8
         lo55TxLpYnseAML8lHlRlsI4OakgmA9FtKdDPRIuz5X+iuvofUR4vpjL1E7WwV87Yihg
         /WaaZbtq8phaF59voXf0bapIhGo9gb09PlfIGefJYFyNzeU9ZQvqgBTNH1V0aEezGIYS
         nkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=djD/3SIoEHw+iUsL/AdbKgn+UWa7uq1S8vjdmn3IL3w=;
        b=Nv5dtwez+GhH2gvdAxjDsc986H3mdWVJGKJWStt3FhqWxj7N/YLMGmZvInEszgqLuH
         ygjzLcmXU4tBfni9tVslD665zrEQfrJhZvmXGYV5I1BimnJe0LzNO43pGbrob1VKqVjU
         AGpIt1w+2uXLOVk7Hw5gAc0nL/Nv9LkonIOelDOpAw55lVjJeUy3Iv0m9pdIKPQnwKJG
         Allu7u4zNe7G76d7L7xWRREiUclizgOL4+mvUn0/sx8Ro7Wa7NvrSR3BExh+qeM8CfVF
         x5/JAIkRN7jw8DvERbzTUIalRTSlb8jYQtRu6gilzowTByy6v+KDW+CL+1og84tGbzc3
         eApQ==
X-Gm-Message-State: AOAM531oENJUy112dTUPW+HMggSgp9M6MTCib94t3vJsSa4DVCimSFcc
        cX/FsY3QAuNDRzQ1jpTysdSVusXe
X-Google-Smtp-Source: ABdhPJw+yfPPS6PIEbWSgt0wjYUInyXW/a704bLoK/RFGyoN6oep/NmwD5TD7dFOJqvEn2rUqDvzfQ==
X-Received: by 2002:a1c:964b:: with SMTP id y72mr3281986wmd.69.1596381649947;
        Sun, 02 Aug 2020 08:20:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7sm13964994wra.29.2020.08.02.08.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 08:20:49 -0700 (PDT)
Message-Id: <2bd473e0aa963c6e883a6fcaf01f3137c5e6a2e8.1596381647.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.691.git.1596381647.gitgitgadget@gmail.com>
References: <pull.691.git.1596381647.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 02 Aug 2020 15:20:45 +0000
Subject: [PATCH 1/3] command-list.txt: add missing 'gitcredentials' and
 'gitremote-helpers'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The guides 'gitcredentials' and 'gitremote-helpers' do not currently
appear in command-list.txt.

'gitcredentials' was forgotten back when guides were added to
command-list.txt in 1b81d8cb19 (help: use command-list.txt for the
source of guides, 2018-05-20).

'gitremote-helpers' was moved to section 7 in 439cc74632 (docs: move
gitremote-helpers into section 7, 2019-03-25), but command-list.txt was
not updated at the time.

Add these two guides to the list of guides in 'command-list.txt', so
that they appear in the output of 'git help --guides', and capitalize
the first word of the description of 'gitcredentials', as was done in
1b81d8c (help: use command-list.txt for the source of guides,
2018-05-20) for the other guides.

While at it, add a comment in Documentation/Makefile to remind developers
to update command-list.txt if they add a new guide.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/Makefile           | 1 +
 Documentation/gitcredentials.txt | 2 +-
 command-list.txt                 | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ecd0b340b1..39f6fc8de7 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -17,6 +17,7 @@ MAN1_TXT += git.txt
 MAN1_TXT += gitk.txt
 MAN1_TXT += gitweb.txt
 
+# man5 / man7 guides (note: new guides should also be added to command-list.txt)
 MAN5_TXT += gitattributes.txt
 MAN5_TXT += githooks.txt
 MAN5_TXT += gitignore.txt
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 9e481aec85..758bf39ba3 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -3,7 +3,7 @@ gitcredentials(7)
 
 NAME
 ----
-gitcredentials - providing usernames and passwords to Git
+gitcredentials - Providing usernames and passwords to Git
 
 SYNOPSIS
 --------
diff --git a/command-list.txt b/command-list.txt
index 89aa60cde7..e5901f2213 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -195,6 +195,7 @@ git-write-tree                          plumbingmanipulators
 gitattributes                           guide
 gitcli                                  guide
 gitcore-tutorial                        guide
+gitcredentials                          guide
 gitcvs-migration                        guide
 gitdiffcore                             guide
 giteveryday                             guide
@@ -204,6 +205,7 @@ githooks                                guide
 gitignore                               guide
 gitmodules                              guide
 gitnamespaces                           guide
+gitremote-helpers                       guide
 gitrepository-layout                    guide
 gitrevisions                            guide
 gitsubmodules                           guide
-- 
gitgitgadget

