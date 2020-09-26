Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2E4C4727D
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A1923719
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ttFiWGoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgIZVdF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 17:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgIZVdB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 17:33:01 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA75C0613D9
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:32:58 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so7677756wrm.2
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kPwKcxGrRvsZn7FWly9EDeX7JTF/jA86riQcfqmFzIg=;
        b=ttFiWGooJ90OuQLAyBFVHjzuX6e2hurJb/vRDCv8IZ/R9hwtohUOyR/O+gHftIAspP
         aN+y5jZASk7O46nFdnr+YyCPNx4SW9iuEr+7txbDTJccUG98ciUqOpB2a9gjkRuhPcPm
         nAoEsj6BGpiKKXaMCaTBt5kSsekQcJoLUD7WquDVG5cjKp4safG0U/SP3MAG5R+eefrG
         eDgn5rGLR0tnZiQ51NH5j3hoL+eju8ut6I5m6yDuVTcecXXwMKdoI95jv7m5ZP4a3b5j
         TGJYDzhdn7rWPVaOJlFMXsln5eCLeMB5iMX+Ighocmwz7FgxgdU7rTOjbtQP/QVgvA4E
         8y3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kPwKcxGrRvsZn7FWly9EDeX7JTF/jA86riQcfqmFzIg=;
        b=HzunovFxWySBB7CS4HxN1SGncU9RSSRtlfJzu2CLh5AkLnYSQJse8arIa3JwMT6lH3
         TMpBbr8WuUPfCr/nrD1b7IWlBNJikp6X/PL5+GMep0hs1tOxcXpThGuChxldpiyHQqoN
         9dqji5QlNWkToKcPOhQPVG+HNskqv3NrKkp14Ry3L4bIvwyYmhKyKtZdwRphACrdobBf
         lwNMdnL5zXjSMvYpHSJgakYW4MWcuzThTrXn7O+0KsbMDkNHzVuq5IsSN9v6linPLFJK
         lGBjkeHwy+xkcJqvtqDRG5lc56tAYdMikltCQpgGxFYRLnfA6x6z06oaUcDcIWhRggIh
         a3yg==
X-Gm-Message-State: AOAM533piegq2lEoBGrpvbjzBY3q/0MQg5MhUBRf2KQ9TxiuOJk6eZoP
        irjkpFxYD7ncQBJ0p2js64sj06xoccQ=
X-Google-Smtp-Source: ABdhPJycRvYkpDPOrXB+eStP7Dv/u0P/3tVdoLONpAPQMzsps67WUITpF8EHEC96EPTgg5FMKbNhcg==
X-Received: by 2002:a05:6000:124d:: with SMTP id j13mr11610065wrx.182.1601155977425;
        Sat, 26 Sep 2020 14:32:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14sm8027466wrv.72.2020.09.26.14.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 14:32:57 -0700 (PDT)
Message-Id: <68a7d984ec225f08486a4faf2b8d5bd2df2d5083.1601155970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>
        <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 26 Sep 2020 21:32:48 +0000
Subject: [PATCH v2 09/10] cmake (Windows): recommend using Visual Studio's
 built-in CMake support
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is a lot more convenient to use than having to specify the
configuration in CMake manually (does not matter whether using the
command-line or CMake's GUI).

While at it, recommend using `contrib/buildsystems/out/` as build
directory also in the part that talks about running CMake manually.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 1eaeb8b8e0..de92e4fe2d 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -4,17 +4,25 @@
 
 #[[
 
-Instructions to run CMake:
+Instructions how to use this in Visual Studio:
 
-cmake `relative-path-to-CMakeLists.txt` -DCMAKE_BUILD_TYPE=Release
-Eg.
-From the root of git source tree
-	`cmake contrib/buildsystems/ `
-This will build the git binaries at the root
+Open the worktree as a folder. Visual Studio 2019 and later will detect
+the CMake configuration automatically and set everything up for you,
+ready to build. You can then run the tests in `t/` via a regular Git Bash.
 
-For out of source builds, say build in 'git/git-build/'
-	`mkdir git-build;cd git-build; cmake ../contrib/buildsystems/`
-This will build the git binaries in git-build directory
+Note: Visual Studio also has the option of opening `CMakeLists.txt`
+directly; Using this option, Visual Studio will not find the source code,
+though, therefore the `File>Open>Folder...` option is preferred.
+
+Instructions to run CMake manually:
+
+    mkdir -p contrib/buildsystems/out
+    cd contrib/buildsystems/out
+    cmake ../ -DCMAKE_BUILD_TYPE=Release
+
+This will build the git binaries in contrib/buildsystems/out
+directory (our top-level .gitignore file knows to ignore contents of
+this directory).
 
 Possible build configurations(-DCMAKE_BUILD_TYPE) with corresponding
 compiler flags
-- 
gitgitgadget

