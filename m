Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1ECC433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 12:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 750CB610C9
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 12:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhIXMTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 08:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbhIXMTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 08:19:09 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BD8C061574
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 05:17:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v19so6864832pjh.2
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 05:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1bd9zH9JhMEwXRcaJUkR0ovC2nj3kqQa/A1jf0zu+pU=;
        b=PaoydeR57f7MarvWxpsPmLU+OHy8jK1P/5XU2KNYJaESVkPdgS0E96I9BStTOSu5iI
         ol6UWTuEuHdcdhNv8s/kfXSAlSDONkeZOKf5yieEow+j2z79tqJtf7fbKfRk4dgW8/mh
         mD2c0OAATXZeuO628mngRL2zEHD9AVGFH9/TiOlc787Cpj9E/jN2SusiRdO8HJTJTTax
         wp8rZ8pjXPHx94/eGxoBvQgfyCUAbCabJZ4h0n5IMsBXTteOQ4GNogd+M5CU9J5nZR6T
         qk+zzEa65b2/l8toSuFI9/cQq0NTfNivacKk+OlKEfcofXXcx+LN6+nHUQ9wcBbqkFt7
         T9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1bd9zH9JhMEwXRcaJUkR0ovC2nj3kqQa/A1jf0zu+pU=;
        b=5uWTXfbGPXku/EnEsfMdMSgsGaiFiOOrPD2ZdmVvuIipDW0nbM89O4Hxc05nqto92X
         fqvVs7pxmr2gXjGL2KsfnhiDGUwZ2rO04dzvx1rhagixn9zBUAHUQtd+vKjSHf8s8nCn
         WwiSMcyMjgDI36S93UMJ0wUh4z1HFlTa77ppXWbKdd+aa5w1tITCaNCGGYm3tzYneHvR
         kt7PvQe7HDdlgAVlpPSEyhbLIyRZY9HbcAN3ay/2dixtfzHP0rDX09H8RHlVNi8RJHYX
         H4u6SxVJ2NWQT9vJVFwrzJg6gsXj+b0qzFXljCyIwWgRvd1z1AfEQ+DBp7w93gUDvL/B
         ZAgQ==
X-Gm-Message-State: AOAM531yP0GUycIobGafvoVu5X2Hs0XoHX6bsFYY4cYDBMoHxfW7s8N7
        1i/0DtEH+koq9fogX7xoR4t0HgUyPZ43ig==
X-Google-Smtp-Source: ABdhPJw+/KNhuhmfoUVxm4cbmXtG3xEWCKyegd/IEtlNYG6ZRF73r3p5RRYfQc5eHHLeDS52qcGwpg==
X-Received: by 2002:a17:90b:3558:: with SMTP id lt24mr1966386pjb.98.1632485856149;
        Fri, 24 Sep 2021 05:17:36 -0700 (PDT)
Received: from ubuntu.mate (subs10b-223-255-225-233.three.co.id. [223.255.225.233])
        by smtp.gmail.com with ESMTPSA id u24sm9683567pfm.81.2021.09.24.05.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:17:35 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Thiago Perrotta <tbperrotta@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] send-email: clarify dual-mode behavior
Date:   Fri, 24 Sep 2021 19:13:54 +0700
Message-Id: <20210924121352.42138-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git send-email can be operated in two modes: one that sends
already-prepared patches and one that generates patches from
revision range on-the-fly for sending. Clarify it in the documentation
and usage help.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 This patch is based on [PATCH v5 2/3] send-email: programmatically
 generate bash completions [1]. PATCH v5 3/3 can be replaced with
 this patch, or be integrated as stand-alone patch.

 Questions:

   1. Do all supported revision range syntaxes from git rev-list also be
      accepted by git send-email? I only test `A..B` and `B ^A` syntaxes
      and assumed that all are supported.
   2. Does git send-email also accepts options understood by git
      rev-list? I interpreted that git send-email accepts file, directory
      or rev-list ranges but not rev-list options (I interpreted from
      previous synopsis before this patch but it said `rev-list options`).

 [1]:
https://lore.kernel.org/git/20210924024606.20542-3-tbperrotta@gmail.com/

 Documentation/git-send-email.txt | 14 ++++++++------
 git-send-email.perl              |  3 ++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 3db4eab4ba..b1d239d74c 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -9,17 +9,19 @@ git-send-email - Send a collection of patches as emails
 SYNOPSIS
 --------
 [verse]
-'git send-email' [<options>] <file|directory|rev-list options>...
+'git send-email' [<options>] <file|directory>...
+'git send-email' [<options>] <revision range>
 'git send-email' --dump-aliases
 
 
 DESCRIPTION
 -----------
-Takes the patches given on the command line and emails them out.
-Patches can be specified as files, directories (which will send all
-files in the directory), or directly as a revision list.  In the
-last case, any format accepted by linkgit:git-format-patch[1] can
-be passed to git send-email.
+In the first form, take the patches in the <file> or <directory> and
+email them out. In the second form, generate patches from the specified
+<revision range> and email them out. <revision range> can be syntaxes
+that are accepted by linkgit:git-rev-list[1]. Options that are
+understood by linkgit:git-format-patch[1] can also be specified in
+<options> if the second form is used.
 
 The header of the email is configurable via command-line options.  If not
 specified on the command line, the user will be prompted with a ReadLine
diff --git a/git-send-email.perl b/git-send-email.perl
index 0214b55b4f..5d623f2fa8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -39,7 +39,8 @@ package main;
 
 
 my $USAGE = <<EOT
-git send-email [options] <file | directory | rev-list options>
+git send-email [options] <file | directory>...
+git send-email [options] <revision range>
 git send-email --dump-aliases
 
   Composing:
-- 
2.25.1

