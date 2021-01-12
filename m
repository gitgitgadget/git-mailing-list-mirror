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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF47C433E6
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD7123125
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437998AbhALVhD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436840AbhALUS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:18:57 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A24EC061794
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:16 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id 91so3833758wrj.7
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KmfSgxs7UUbXBf4J6tUxpCbr5IaXZGJBhCZoA+sPDPk=;
        b=dZayeOHfs7cgttiw0BKWaR1B/SXrJY8qOtjLr9uXP7C2PAkxbry4v3sW5gXdgTRGff
         1hmKbfw5epgOiuPgtn4g67DaEHFs7sY2PfmeriTB2Rw+XlAJdiDCVwIXpqD2omVV64KR
         Lf8NRz4KbkZJPLtII9pgGEL/Rk7Z3o7OJ7ZteBMooZKYQfWglNbFsyv/U1oqxJ02Bx36
         gLvTCOeF0pbzA+X5uKBy2/h5wJ7IcjK+j+humc7S4sS6SjmtzTZRky6eGxyiwl4cTAGf
         cG3gzO4lsfEoxjhZt4spiCQe4OwZtNRy5jAv46LhZCpCBJDR2XZ5/Bgq7csiUtcdiM6Y
         x5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KmfSgxs7UUbXBf4J6tUxpCbr5IaXZGJBhCZoA+sPDPk=;
        b=S7hPnm51lqV7PIbeV8952yBl4l/lfOjgLMW/mf8hXUnJL0+QX9yZNmHQ9TLHG5gzZa
         7hgATLn4xOc8J36JKJYx/A1+tc4F5TylMaVRofI4s9JQ3QVJ8xe/RK7ktq4TvMqbYd7B
         ciUNUl79TGjI95EZYFRH8S7ipbdygS2B3k6pt9I4wh/jBIyXlFzAJzzZrYESI4w5wk76
         70ee1OqtcprlhBbpouha8VLg3Pxkcw7RNLTumXBv0y38Tog9fln/M/f1VtCd3Q3/CRy6
         v2p+IFwPaFUAFkYulInp6gp3makHCspvT+bf3uIx4VANl6mKwRhmZE+XUnM3DNMWYV4c
         oYwg==
X-Gm-Message-State: AOAM530hesSWGVDKHVHeM2Clc2LpDg0L6CdCxk5M+ew1LjzZ7385cQ0H
        NuYobh7fZzSIejxynlJ0qexfhbpf9Rrnow==
X-Google-Smtp-Source: ABdhPJzM/21P59CZo1prPyWZayT2S/x9WmhPevEtLN7hQRCO1P2b7fDtMqC5WTd2qY8hEpuDxzUjXw==
X-Received: by 2002:adf:ba47:: with SMTP id t7mr509996wrg.285.1610482694944;
        Tue, 12 Jan 2021 12:18:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm7095374wrb.92.2021.01.12.12.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:18:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/22] mailmap doc: create a new "gitmailmap(5)" man page
Date:   Tue, 12 Jan 2021 21:17:45 +0100
Message-Id: <20210112201806.13284-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
References: <20210105130359.21139-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a gitmailmap(5) page similar to how .gitmodules and .gitignore
have their own pages at gitmodules(5) and gitignore(5). Now instead of
"check-mailmap", "blame" and "shortlog" documentation including the
description of the format we link to one canonical place.

This makes things easier for readers, since in our manpage or
web-based[1] output it's not clear that the "MAPPING AUTHORS" sections
aren't subtly different, as opposed to just included.

1. https://git-scm.com/docs/git-check-mailmap

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile                        |  1 +
 Documentation/git-blame.txt                   |  2 +-
 Documentation/git-check-mailmap.txt           |  2 +-
 Documentation/git-shortlog.txt                |  6 +---
 Documentation/{mailmap.txt => gitmailmap.txt} | 33 +++++++++++++++++++
 command-list.txt                              |  1 +
 6 files changed, 38 insertions(+), 7 deletions(-)
 rename Documentation/{mailmap.txt => gitmailmap.txt} (88%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b980407059..81d1bf7a04 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -21,6 +21,7 @@ MAN1_TXT += gitweb.txt
 MAN5_TXT += gitattributes.txt
 MAN5_TXT += githooks.txt
 MAN5_TXT += gitignore.txt
+MAN5_TXT += gitmailmap.txt
 MAN5_TXT += gitmodules.txt
 MAN5_TXT += gitrepository-layout.txt
 MAN5_TXT += gitweb.conf.txt
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 34b496d485..3bf5d5d8b4 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -226,7 +226,7 @@ commit commentary), a blame viewer will not care.
 MAPPING AUTHORS
 ---------------
 
-include::mailmap.txt[]
+See linkgit:gitmailmap[5].
 
 
 SEE ALSO
diff --git a/Documentation/git-check-mailmap.txt b/Documentation/git-check-mailmap.txt
index aa2055dbeb..45a5cfafd8 100644
--- a/Documentation/git-check-mailmap.txt
+++ b/Documentation/git-check-mailmap.txt
@@ -39,7 +39,7 @@ printed; otherwise only ``$$<user@host>$$'' is printed.
 MAPPING AUTHORS
 ---------------
 
-include::mailmap.txt[]
+See linkgit:gitmailmap[5].
 
 
 GIT
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index fd93cd41e9..c16cc3b608 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -111,11 +111,7 @@ include::rev-list-options.txt[]
 MAPPING AUTHORS
 ---------------
 
-The `.mailmap` feature is used to coalesce together commits by the same
-person in the shortlog, where their name and/or email address was
-spelled differently.
-
-include::mailmap.txt[]
+See linkgit:gitmailmap[5].
 
 GIT
 ---
diff --git a/Documentation/mailmap.txt b/Documentation/gitmailmap.txt
similarity index 88%
rename from Documentation/mailmap.txt
rename to Documentation/gitmailmap.txt
index 4a8c276529..8b07f9c5d7 100644
--- a/Documentation/mailmap.txt
+++ b/Documentation/gitmailmap.txt
@@ -1,9 +1,28 @@
+gitmailmap(5)
+=============
+
+NAME
+----
+gitmailmap - Map author/committer names and/or E-Mail addresses
+
+SYNOPSIS
+--------
+$GIT_WORK_DIR/.mailmap
+
+
+DESCRIPTION
+-----------
+
 If the file `.mailmap` exists at the toplevel of the repository, or at
 the location pointed to by the mailmap.file or mailmap.blob
 configuration options, it
 is used to map author and committer names and email addresses to
 canonical real names and email addresses.
 
+
+SYNTAX
+------
+
 In the simple form, each line in the file consists of the canonical
 real name of an author, whitespace, and an email address used in the
 commit (enclosed by '<' and '>') to map to the name. For example:
@@ -27,6 +46,10 @@ commit matching the specified commit email address, and:
 which allows mailmap to replace both the name and the email of a
 commit matching both the specified commit name and email address.
 
+
+EXAMPLES
+--------
+
 Example 1: Your history contains commits by two authors, Jane
 and Joe, whose names appear in the repository under several forms:
 
@@ -73,3 +96,13 @@ Santa Claus <santa.claus@northpole.xx> <me@company.xx>
 
 Use hash '#' for comments that are either on their own line, or after
 the email address.
+
+
+SEE ALSO
+--------
+linkgit:git-check-mailmap[1]
+
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/command-list.txt b/command-list.txt
index 9379b02e5e..a289f09ed6 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -204,6 +204,7 @@ gitfaq                                  guide
 gitglossary                             guide
 githooks                                guide
 gitignore                               guide
+gitmailmap                              guide
 gitmodules                              guide
 gitnamespaces                           guide
 gitremote-helpers                       guide
-- 
2.29.2.222.g5d2a92d10f8

