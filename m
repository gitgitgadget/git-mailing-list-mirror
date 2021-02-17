Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645FDC433E6
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2583D64E79
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhBQT5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbhBQT5O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:57:14 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD5DC061786
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:56:34 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id t4so4080005ljh.11
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fr72n2sJ/d1F7rkcvdwevxHFVd5ukKTZBSOyGN5F2/0=;
        b=lnwcrH1d8BCZCznQISLTjdApInVIDaRxtjnvsBIm4E0UVSovqsvA10WE04JvnqxAEk
         xrA9JyaJDOnHWQbTYYDfYWsGyKe+BvBfOKqxqix85hPColkxF+I/KoEJjbSs5XmEjjz3
         11cb3rYbiyBZwV50N486RITMNJ7DKsoSfalaHL5/yasJ3FxArWNd2n72K8szqtxZ5V+I
         n1tLjbiaIiA9hpFYEcVVue0CaPNhaUHPQuONZc4U5mXWLibrqVPMFN7N8YQ7IW7XfoHM
         cxQVZ3NTbYT4G76wojcLwhZPpxd2pPEuQ/AcR68vX5GV/SUF4qCSdc0ssVCvGSjH7nRn
         4eGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fr72n2sJ/d1F7rkcvdwevxHFVd5ukKTZBSOyGN5F2/0=;
        b=krmssUeZHuO7GBzjP1UfBRzy/uJ5KRxJ9O3uW/QsCuFa7NyTs2TIi+sR9cb8L9xNn9
         6TnBI2gE78D0r2d4zeFk4xQU1oNaBrCIW4JJFDAeBkdRCXwWZPNfXW3z1AnganUG2OGJ
         0JcUWZ/kxQVZuGurq2KEb2Xi81yMgYDbdWhUgQ/PGDWFojNL7YXWJaeolzo9YXw5FEM5
         RMeDb6CKocEQUdmeJIgvFyA0IPY6Uez+sXe3LIVEmyQirSaP/wxmgwSPm+X0KuYzL14K
         lB0AUombYARzMHe90W39PuuOWgDimsXMMzdpSGC8p8cdGegKuoor6FBqYvMB5RTPV01F
         MByg==
X-Gm-Message-State: AOAM530ZX/ddS4I3iz118ql2xnwTYgHRKZxu2KfWkUSXuMPpfG58YN9a
        K8esabHe6dT+KYzbiZGpOZlQ0gCIpkg=
X-Google-Smtp-Source: ABdhPJz5tSRkMDRhvIJpZhgJ0MD8SwmvDdYvgTVKVWcNBFlqbFKx2wENsEul3KCv2x9KleeV3wdBaw==
X-Received: by 2002:a2e:984c:: with SMTP id e12mr487089ljj.69.1613591792398;
        Wed, 17 Feb 2021 11:56:32 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id o19sm347495lfu.182.2021.02.17.11.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:56:31 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Sergey Organov <sorganov@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] gitmailmap.txt: fix rendering of e-mail addresses
Date:   Wed, 17 Feb 2021 20:56:06 +0100
Message-Id: <ee0422ac399daf43a7adcc2b662b50312da04631.1613590761.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5ea
In-Reply-To: <cover.1613590761.git.martin.agren@gmail.com>
References: <cover.1613590761.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both AsciiDoc and Asciidoctor are eager to pick up the e-mail addresses
in this document and turn them into references at the bottom of the
manpage / clickable links. We don't really need that for these dummy
addresses. Spell "@" as "&#64;" to make them not do this. In the open
block, we can instead avoid this by indenting the contents, similar to
the earlier blocks.

Fix a backtick which should have been a single quote mark. With all the
quoting that is going on around here, this mistake trips up the parsing
and rendering quite a bit.

Before this commit, we have the same failure mode with AsciiDoc 8.6.10
and Asciidoctor 1.5.5, and this change makes both of them happy.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 doc-diff:
 --- a/97c686dd7ba1bbd1c0be6f7f61a3a033adf8adb6-asciidoctor-cut-footer/home/martin/share/man/man5/gitmailmap.5
 +++ b/ee0422ac399daf43a7adcc2b662b50312da04631-asciidoctor-cut-footer/home/martin/share/man/man5/gitmailmap.5
 @@ -40,9 +40,9 @@ SYNTAX
         matching both the specified commit name and email address.
 
         Both E-Mails and names are matched case-insensitively. For example this
 -       would also match the Commit Name <commit@email.xx[1]> above:
 +       would also match the Commit Name <commit@email.xx> above:
 
 -       Proper Name <proper@email.xx[2]> CoMmIt NaMe <CoMmIt@EmAiL.xX[3]>
 +           Proper Name <proper@email.xx> CoMmIt NaMe <CoMmIt@EmAiL.xX>
 
  EXAMPLES
         Your history contains commits by two authors, Jane and Joe, whose names
 @@ -62,11 +62,10 @@ EXAMPLES
             Jane Doe <jane@example.com>
             Jane Doe <jane@desktop.(none)>
 
 -       Note that there’s no need to map the name for jane@laptop.(none) to
 +       Note that there’s no need to map the name for <jane@laptop.(none)> to
         only correct the names. However, leaving the obviously broken
 -       <jane@laptop.(none)>' and '<jane@desktop.(none)>' E-Mails as-is is
 -       usually not what you want. A `.mailmap file which also corrects those
 -       is:
 +       <jane@laptop.(none)> and <jane@desktop.(none)> E-Mails as-is is usually
 +       not what you want. A .mailmap file which also corrects those is:
 
             Joe R. Developer <joe@example.com>
             Jane Doe <jane@example.com> <jane@laptop.(none)>
 @@ -93,13 +92,3 @@ SEE ALSO
 
  GIT
         Part of the git(1) suite
 -
 -NOTES
 -        1. commit@email.xx
 -           mailto:commit@email.xx
 -
 -        2. proper@email.xx
 -           mailto:proper@email.xx
 -
 -        3. CoMmIt@EmAiL.xX
 -           mailto:CoMmIt@EmAiL.xX
 Documentation/gitmailmap.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitmailmap.txt b/Documentation/gitmailmap.txt
index 052209b33b..3fb39f801f 100644
--- a/Documentation/gitmailmap.txt
+++ b/Documentation/gitmailmap.txt
@@ -50,9 +50,9 @@ which allows mailmap to replace both the name and the email of a
 commit matching both the specified commit name and email address.
 
 Both E-Mails and names are matched case-insensitively. For example
-this would also match the 'Commit Name <commit@email.xx>' above:
+this would also match the 'Commit Name <commit&#64;email.xx>' above:
 --
-Proper Name <proper@email.xx> CoMmIt NaMe <CoMmIt@EmAiL.xX>
+	Proper Name <proper@email.xx> CoMmIt NaMe <CoMmIt@EmAiL.xX>
 --
 
 EXAMPLES
@@ -79,9 +79,9 @@ Jane Doe <jane@example.com>
 Jane Doe <jane@desktop.(none)>
 ------------
 
-Note that there's no need to map the name for 'jane@laptop.(none)' to
+Note that there's no need to map the name for '<jane&#64;laptop.(none)>' to
 only correct the names. However, leaving the obviously broken
-`<jane@laptop.(none)>' and '<jane@desktop.(none)>' E-Mails as-is is
+'<jane&#64;laptop.(none)>' and '<jane&#64;desktop.(none)>' E-Mails as-is is
 usually not what you want. A `.mailmap` file which also corrects those
 is:
 
-- 
2.30.0.284.gd98b1dd5ea

