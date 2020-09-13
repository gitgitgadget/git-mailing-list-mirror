Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A295C43461
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 19:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAFD5208C7
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 19:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pI85M7I/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgIMTcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 15:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgIMTcC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 15:32:02 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A000FC061787
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 12:32:01 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id f142so14927728qke.13
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 12:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vAZy1ZNoYBluS7IQYsrbNAASkxQm1YqhQLiqWTFi1xA=;
        b=pI85M7I/K2/Aw3jIacRJmxqz3DQNNB45roQD2NRGDfedrRH+EQjo0qR09CY4ab+piK
         oYKXLIR3F10VweR1CZzFMF2QkAFTbUSBCnLYNetvAUwQWjQQUUYIXcxg0WHbc9sby/kB
         gMfaD0xKTsNPFYkMrS8tcLIJdgx1h3m4pKqoOjzlhXMgcJrxnuJJ7HG0IYN8OS48fJIL
         G6X23+J/EBfXuXECcHb67vrYjh9w04oyIzkEUWQyzydCFsbqi90dNLQjfAUhqppFv+3N
         fVKdi8W/7lhSOYQbHMAU5jpc3/kty2HucEA9IABGfOKI8piE/Hu186kv4IxwNK2KFf2Z
         JqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vAZy1ZNoYBluS7IQYsrbNAASkxQm1YqhQLiqWTFi1xA=;
        b=g+v+9szL/bh6nRe+m2/qhvK1nypYowhCl60PEy4ihoYYHTOAwbez5aIOgXSDacozM/
         fXycZp25pjXwHN/eR4fti1tw19IqnmLnU9TU0GaMTUslcFM4VhCz2iqg3n/yXQCzwHgc
         Ubs20Amz25jLUjdGJajCPnjulR433m4uvgi8yOH4eKcdb66xCQ5v4INYQsa5M8Q5AGiS
         v8IozNdvKR59jeko8QZDoVE4ZPzMxrAWau/LexSk8oriq2eshK53gFGAGyhw5WpffGt/
         kjRkOSYzBQDCitIvOAstLFdCwE3M99MLQ5GBhnQLZO1PavyX/RgrKAn+gcCNrcqr7pZR
         dHvQ==
X-Gm-Message-State: AOAM530aTscDBHwhe8qI/V0kRfh+aARTaiiGRmvqFoWujcB3LdhakkdH
        o09Z8cyoiIu2UTg/cMCKH9o+ajLPQDL9VL87
X-Google-Smtp-Source: ABdhPJwHjkw7wJjlcCXWLEKuXboOBTOy7i5FvE9bHT+vkUQu15IbrG/CdyL8pnYgOxMDZBzAlP7ApA==
X-Received: by 2002:a37:d53:: with SMTP id 80mr9518447qkn.136.1600025517230;
        Sun, 13 Sep 2020 12:31:57 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id e13sm11523924qtr.85.2020.09.13.12.31.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Sep 2020 12:31:56 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH v3 2/3] Doc: cover multiple contains/no-contains filters
Date:   Sun, 13 Sep 2020 15:31:39 -0400
Message-Id: <20200913193140.66906-3-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200913193140.66906-1-alipman88@gmail.com>
References: <20200911185754.64173-3-alipman88@gmail.com>
 <20200913193140.66906-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update documentation for "git branch", "git for-each-ref" and "git tag"
with notes explaining what happens when passed multiple --contains or
--no-contains filters, e.g.:

  When combining multiple `--contains` and `--no-contains` filters,
  `git for-each-ref` shows refs containing at least one of the named
  `--contains` commits and none of the named `--no-contains` commits.

This behavior is useful to document prior to enabling multiple
merged/no-merged filters, in order to demonstrate consistent behavior
between merged/no-merged and contains/no-contains filters.
---
 Documentation/git-branch.txt       | 4 ++++
 Documentation/git-for-each-ref.txt | 7 +++++++
 Documentation/git-tag.txt          | 7 +++++++
 3 files changed, 18 insertions(+)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 03c0824d52..2a36d29929 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -370,6 +370,10 @@ serve four related but different purposes:
 - `--no-merged` is used to find branches which are candidates for merging
   into HEAD, since those branches are not fully contained by HEAD.
 
+When combining multiple `--contains` and `--no-contains` filters,
+`git branch` shows branches containing at least one of the named
+`--contains` commits and none of the named `--no-contains` commits.
+
 SEE ALSO
 --------
 linkgit:git-check-ref-format[1],
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 616ce46087..e5f0226273 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -408,6 +408,13 @@ Note also that multiple copies of an object may be present in the object
 database; in this case, it is undefined which copy's size or delta base
 will be reported.
 
+NOTES
+-----
+
+When combining multiple `--contains` and `--no-contains` filters,
+`git for-each-ref` shows refs containing at least one of the named
+`--contains` commits and none of the named `--no-contains` commits.
+
 SEE ALSO
 --------
 linkgit:git-show-ref[1]
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index f6d9791780..adfeab7a93 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -377,6 +377,13 @@ $ GIT_COMMITTER_DATE="2006-10-02 10:31" git tag -s v1.0.1
 
 include::date-formats.txt[]
 
+NOTES
+-----
+
+When combining multiple `--contains` and `--no-contains` filters,
+`git tag` shows tags containing at least one of the named `--contains`
+commits and none of the named `--no-contains` commits.
+
 SEE ALSO
 --------
 linkgit:git-check-ref-format[1].
-- 
2.24.3 (Apple Git-128)

