Return-Path: <SRS0=CKFy=AO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10332C433E0
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 03:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0EC5207E8
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 03:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCPbDErH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgGCDif (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 23:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgGCDie (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 23:38:34 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD25C08C5C1
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 20:38:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f2so3017535wrp.7
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 20:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=t5s1ltNGMpcuEO6GcrOf5U161SBKg5LtyTbXOVytES0=;
        b=bCPbDErHaoosRwjDLGgXJiTUDFz0kdQeC90dF0UxPzjBgBwjDYnVnK9tzOz5xB5yur
         2b3APtayirSixyXjuSJLg2ifdpcNIlaNfNWFtmbotyE9GrdFnktXHw/fAED3GerrFx7T
         xLSpfK+O9VYk3YU0c5QONNk814Ts2NGGkzJDmadS+gx5OCItkMXnQcR31N+/1y3Q3RMx
         kB2QfWJ9YYwjLV5cCTaO+ZUi/nmMquYC5PVCzaKPzoOIXGlsGAbUtXbioFlE3kSk3iXB
         lfOsRFkTxa0i1Yy/P7T3/ufd27D4gHFt3u40XYzxGbBWlTY+1Cc/NycdL9cTVZOlJ+Nw
         e3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=t5s1ltNGMpcuEO6GcrOf5U161SBKg5LtyTbXOVytES0=;
        b=ETT4rk/+SYgwy1+pV0XTVyHWY9hTUG2etokqekkk7pF5kI8YYicMgI2nJGXVCpd2QU
         pVb6VXl84c2BG8mTgbkIxYkcB7FE3VN9bR/inaqqEFy5Iikevx6eUvBq5UAzQe0EKq0E
         y/UhMlc39UGT2z2EyqK6ZQtxFP95htBm5ZIhFqkTlWhm2UqldaoH8gTQmymihNipGXid
         4iPANE+dZfBgTZoLl99PT/9MpSJIbWOT93zjRaZx7Hz8KppIAC/kDMw7QYCe6WVb4BWd
         HQ1+PRaYOXu8EJAOT8iMp8rvsgtY09VWEbiId9kBJhxPZ5buwtzYn0K6CRkbiXaeEXaU
         LuCQ==
X-Gm-Message-State: AOAM531KXn33fJYQfpVNPOiSRTze+/38mi+aDzZRsHtH7M5H7nv6WRdL
        z9ppFpA5Ekv7AvAbMjxxGLXY78nU
X-Google-Smtp-Source: ABdhPJx9PfjRESg3IjcfEJ+jSZAsUynU4QkidYWiWN7AmXnaN5Ui3oMZJ1Fp0BpqB3g8aOc5TYmArQ==
X-Received: by 2002:adf:9307:: with SMTP id 7mr33757630wro.414.1593747512513;
        Thu, 02 Jul 2020 20:38:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c25sm529490wml.18.2020.07.02.20.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 20:38:32 -0700 (PDT)
Message-Id: <eeaf4fe5dc51ba651c85c6dd70919cc1126b8a30.1593747509.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.590.v2.git.1593747509.gitgitgadget@gmail.com>
References: <pull.590.git.1585429894378.gitgitgadget@gmail.com>
        <pull.590.v2.git.1593747509.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Jul 2020 03:38:28 +0000
Subject: [PATCH v2 3/4] git-log.txt: include rev-list-description.txt
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Lawrence Siebert <lawrencesiebert@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The `git log` synopsis mentions `<revision range>`, and the description
of this option links to gitrevisions(7), but a nice explanation of
how a revision range can be constructed from individual commits,
optionnally prefixed with `^`, also exists in `rev-list-description.txt`.

Include this description in the man page for `git log`.

Add Asciidoc 'ifdef's to `rev-list-description.txt` so that either `git
rev-list` or `git log` appears in the respective man pages.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-log.txt              |  3 +++
 Documentation/git-rev-list.txt         |  1 +
 Documentation/rev-list-description.txt | 23 +++++++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 04ea18d1c0..d34d101255 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -15,6 +15,9 @@ DESCRIPTION
 -----------
 Shows the commit logs.
 
+:git-log: 1
+include::rev-list-description.txt[]
+
 The command takes options applicable to the linkgit:git-rev-list[1]
 command to control what is shown and how, and options applicable to
 the linkgit:git-diff[1] family of commands to control how the changes
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index b06e11ae56..5da66232dc 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
+:git-rev-list: 1
 include::rev-list-description.txt[]
 
 'rev-list' is a very essential Git command, since it
diff --git a/Documentation/rev-list-description.txt b/Documentation/rev-list-description.txt
index aa6bbd8cec..dce78561be 100644
--- a/Documentation/rev-list-description.txt
+++ b/Documentation/rev-list-description.txt
@@ -12,9 +12,16 @@ to further limit the result.
 
 Thus, the following command:
 
+ifdef::git-rev-list[]
 -----------------------------------------------------------------------
 	$ git rev-list foo bar ^baz
 -----------------------------------------------------------------------
+endif::git-rev-list[]
+ifdef::git-log[]
+-----------------------------------------------------------------------
+	$ git log foo bar ^baz
+-----------------------------------------------------------------------
+endif::git-log[]
 
 means "list all the commits which are reachable from 'foo' or 'bar', but
 not from 'baz'".
@@ -23,16 +30,32 @@ A special notation "'<commit1>'..'<commit2>'" can be used as a
 short-hand for "{caret}'<commit1>' '<commit2>'". For example, either of
 the following may be used interchangeably:
 
+ifdef::git-rev-list[]
 -----------------------------------------------------------------------
 	$ git rev-list origin..HEAD
 	$ git rev-list HEAD ^origin
 -----------------------------------------------------------------------
+endif::git-rev-list[]
+ifdef::git-log[]
+-----------------------------------------------------------------------
+	$ git log origin..HEAD
+	$ git log HEAD ^origin
+-----------------------------------------------------------------------
+endif::git-log[]
 
 Another special notation is "'<commit1>'...'<commit2>'" which is useful
 for merges.  The resulting set of commits is the symmetric difference
 between the two operands.  The following two commands are equivalent:
 
+ifdef::git-rev-list[]
 -----------------------------------------------------------------------
 	$ git rev-list A B --not $(git merge-base --all A B)
 	$ git rev-list A...B
 -----------------------------------------------------------------------
+endif::git-rev-list[]
+ifdef::git-log[]
+-----------------------------------------------------------------------
+	$ git log A B --not $(git merge-base --all A B)
+	$ git log A...B
+-----------------------------------------------------------------------
+endif::git-log[]
-- 
gitgitgadget

