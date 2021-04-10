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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40354C433ED
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 17:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB96611CA
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 17:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbhDJRRt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 13:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbhDJRRi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 13:17:38 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED32C06138B
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 10:17:23 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j18so14685261lfg.5
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 10:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dgnW3d7zj7OHdSus7sVihMDY3Fiv9ul0GN7RZl/DC7U=;
        b=UQI5cKfolVQgYwr4eVPU48fULDPVRxevhfxznxj+gBl2xwUTkNGYQRZPQKMGJntBNW
         7SBy8Imj2NF91g3vrssuxr4oLkQcLi13URK0yCfJJYnuyGCOfmWJs2SbGZDTmgI04EwQ
         llYq5j221RcXIjejaFIRDQu0yMrm/CpXn1N/tlbzVIVKT8ZoonmHf3W5UFDwCrxS4MJJ
         TCyNcu2e9FB2BZ5OkicT4ltz1O5mP9A6GBe8OYXPkWHndat76qJUisgZFudIb5+nypH7
         DBAMkX8BdFVo7MupIeZgfT/UxE//xbLLqP/FRIU2YsRqcazNcjw6xQAqxsAyhvPIC3mH
         l6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dgnW3d7zj7OHdSus7sVihMDY3Fiv9ul0GN7RZl/DC7U=;
        b=RtNtnicVH99abe7cGtFZAfjgC+sJTGwqVs1DCq/WtgenWS1pmB8eAuRymOVQikmfr8
         SNazDvmzx4JnEQNce3s8PMxgWlBoogyFKfORc9T1mRHwwVcOs/cqX/UNJ3qqIx2Sw979
         W4zrqTvMsmJyLJ9tRbNUd0kPPmBIXhau0A2N/nYqGLx2ZiToqHeMRYcQ+fFnKR0aVqyr
         xJA13FohiWnnfnweIGdXjOET8eq5E13n5EJtKU07yST5outIIDkfit0TKaAhjb/d1QBW
         3/Wlpz5nFNkL8AFEQHxVkYAoQT2vM7d+SZTZd43hBXBH8x+4rOlKg5l2nFfPYvvX33dU
         O/YQ==
X-Gm-Message-State: AOAM532fSlAHO4AuALHRhse/nN7JKTgiS3vUasR1+jdHxIVcM6MyHMoX
        SOB8BJxPQy633F0OS95tPKk=
X-Google-Smtp-Source: ABdhPJxsbI8hb2mrU767xXEGHLke39aUSJR3NpfQMaZVdNZJqrN3e8+KEggp/Yt635GjBxezhz+1jQ==
X-Received: by 2002:ac2:46cf:: with SMTP id p15mr3309199lfo.227.1618075042381;
        Sat, 10 Apr 2021 10:17:22 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id z7sm1336543ljo.64.2021.04.10.10.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 10:17:21 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 5/5] doc/diff-options: document new --diff-merges features
Date:   Sat, 10 Apr 2021 20:16:57 +0300
Message-Id: <20210410171657.20159-6-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210410171657.20159-1-sorganov@gmail.com>
References: <20210407225608.14611-1-sorganov@gmail.com>
 <20210410171657.20159-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document changes in -m and --diff-merges=m semantics, as well as new
--diff-merges=default option.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-options.txt | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index aa2b5c11f20b..31e2bacf5252 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -34,7 +34,7 @@ endif::git-diff[]
 endif::git-format-patch[]
 
 ifdef::git-log[]
---diff-merges=(off|none|first-parent|1|separate|m|combined|c|dense-combined|cc)::
+--diff-merges=(off|none|default|first-parent|1|separate|m|combined|c|dense-combined|cc)::
 --no-diff-merges::
 	Specify diff format to be used for merge commits. Default is
 	{diff-merges-default} unless `--first-parent` is in use, in which case
@@ -45,17 +45,24 @@ ifdef::git-log[]
 	Disable output of diffs for merge commits. Useful to override
 	implied value.
 +
+--diff-merges=default:::
+--diff-merges=m:::
+-m:::
+	This option makes diff output for merge commits to be shown in
+	the default format. `-m` will produce the output only if `-p`
+	is given as well. The default format could be changed using
+	`log.diffMerges` configuration parameter, which default value
+	is `separate`.
++
 --diff-merges=first-parent:::
 --diff-merges=1:::
 	This option makes merge commits show the full diff with
 	respect to the first parent only.
 +
 --diff-merges=separate:::
---diff-merges=m:::
--m:::
 	This makes merge commits show the full diff with respect to
 	each of the parents. Separate log entry and diff is generated
-	for each parent. `-m` doesn't produce any output without `-p`.
+	for each parent.
 +
 --diff-merges=combined:::
 --diff-merges=c:::
-- 
2.25.1

