Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F80C433E3
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 227FB20739
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlK4xY9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgGICRC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 22:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgGICQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 22:16:56 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED369C08C5C1
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 19:16:55 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f18so642890wrs.0
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 19:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j7HAjuwSGWlHe4ncDrQrRNejH57r4WVKa9wLfpaGaCA=;
        b=nlK4xY9yyjpA63027iXaGbIqlzxQ5RQ/A/1ugnboUOT5lOi8Aibke8eMsNpfgg3lQz
         C601V3OF84pniNj5tMVUQpK6V09qRZU1FP50C1D3X5Z7P8Cq9J4cCFhFIb+LRnOHzzGF
         pyWnRdJW8YQybSEvGesHkJ1zTVnfTSIa66NPj5gkF5snaTZs+k282No9obkSrEJ+V0k/
         HShKiaTpUBJYzNJ4GYnJEwUYarq8xUiduejEoE0cQqKPisBqvOEzM4ClmPevizUZnDsH
         YFoc1sJgx17N9u/WuTLtdgcCDxaMnc9mEt55b7jWBEkLD+Fma7n7gxHQ2hbGyE5YnQ4V
         bEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j7HAjuwSGWlHe4ncDrQrRNejH57r4WVKa9wLfpaGaCA=;
        b=NU9GNF/NSnmw5JBgwl+sMKIxi0rvTWI7P+5SE22w4MKyyiHpFgLEZmTcaQN/LnMJNR
         Sn1sVIiIW1UHss7MaVljLfW5bryetWJhxJ8CUCKGCLZ68CFlS2f3PrAMLYPUYdi1WFcE
         m+jTGkrI4u/uyKeRWwvqne2prBIF2mI9UfJiXDOESWZTWGRFQDcZDh4cdbOF45FNZLA7
         TbN0YNcwYD7ux0NapI3Wykrk3q9ESUk4du6/kwntgXrh/ODTvKk03Y0P2upHqgAXelzC
         8rtFj/++uRUfnY8/J+KsmOMITs0nT+6zXLLVIGv01ySETkmoiDp8cqE4VY/lUEdmPXvb
         xBPA==
X-Gm-Message-State: AOAM530sbJu0xRvvLvjoNhEib69Hc2d5VFPm/9cLa3Oj2DR+vuxpLja9
        EIbV2xLbYWjb+aY29Nycsxf7m0Jh
X-Google-Smtp-Source: ABdhPJzik4bsj+hYVenfNUckmiKJQ00EOkbcLy4KzqvKiHmBgetKjb9FLHHr4jEqDNQImK9fHgYtyw==
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr55114501wrn.241.1594261014554;
        Wed, 08 Jul 2020 19:16:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j4sm3053485wrp.51.2020.07.08.19.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 19:16:54 -0700 (PDT)
Message-Id: <d04b6c62a3186c4d244384887a555e7875130045.1594261008.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.590.v3.git.1594261008.gitgitgadget@gmail.com>
References: <pull.590.v2.git.1593747509.gitgitgadget@gmail.com>
        <pull.590.v3.git.1594261008.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Jul 2020 02:16:48 +0000
Subject: [PATCH v3 6/6] git-log.txt: include rev-list-description.txt
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Lawrence Siebert <lawrencesiebert@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>,
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
index 0fcaf34d62..3fd26d5212 100644
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
 the linkgit:git-diff[1] command to control how the changes
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
index 14d78b91aa..a9efa7fa27 100644
--- a/Documentation/rev-list-description.txt
+++ b/Documentation/rev-list-description.txt
@@ -12,9 +12,16 @@ result.
 
 Thus, the following command:
 
+ifdef::git-rev-list[]
 -----------------------------------------------------------------------
 $ git rev-list foo bar ^baz
 -----------------------------------------------------------------------
+endif::git-rev-list[]
+ifdef::git-log[]
+-----------------------------------------------------------------------
+$ git log foo bar ^baz
+-----------------------------------------------------------------------
+endif::git-log[]
 
 means "list all the commits which are reachable from 'foo' or 'bar', but
 not from 'baz'".
@@ -23,16 +30,32 @@ A special notation "'<commit1>'..'<commit2>'" can be used as a
 short-hand for "^'<commit1>' '<commit2>'". For example, either of
 the following may be used interchangeably:
 
+ifdef::git-rev-list[]
 -----------------------------------------------------------------------
 $ git rev-list origin..HEAD
 $ git rev-list HEAD ^origin
 -----------------------------------------------------------------------
+endif::git-rev-list[]
+ifdef::git-log[]
+-----------------------------------------------------------------------
+$ git log origin..HEAD
+$ git log HEAD ^origin
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
+$ git log A B --not $(git merge-base --all A B)
+$ git log A...B
+-----------------------------------------------------------------------
+endif::git-log[]
-- 
gitgitgadget
