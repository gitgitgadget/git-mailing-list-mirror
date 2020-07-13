Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D981CC433E2
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBC7C20738
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2SzrJp0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgGMTKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGMTKy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 15:10:54 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F99C061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 12:10:54 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id x9so9327858ljc.5
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 12:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WCSmfOItjkS++mx21wyYFn6bcfuxCxR1SZLyHwQ0uAs=;
        b=s2SzrJp0hcMMuah99Vjx8CZ03Dc3HuczNo2R3Fu6i9r2kTOdqRkXjfTiKndypPOz3E
         jDIkOBH/sYo2IpTAT6ZBh6N7GqoCanEfhT5dqzEMg1FV3MmTIqCGfTII6nmgy79dgw/E
         tmpgi3deWAmvrYfOO9GfjSyA1mH1iFPQGrpdzcmYEImO5+nVc14TGqZcLj/xQwrBgwpW
         L3BFVkopZ+kuECk1rErrWY2CEGdhGNtMXeGL4RPc0xu+MY5gxHCeJG3Zde6TQuMqnQEC
         pE2Vx+cofhZ1hFVqg6zHXw3SgjZDbVgNATEzTkLcU4O0OQvorpHrsMw1qr9WUwSwv0zx
         huTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WCSmfOItjkS++mx21wyYFn6bcfuxCxR1SZLyHwQ0uAs=;
        b=ht+o0M9ssdDp59450Zl4bVsb9pzRqYrXBJSJNWSC3xX2TZ3BCh3plUTRfaHJseuB4B
         rls7Zt9c2JCBZCeFxde2qWt64nc94rXFH1Dvao6FYFlrOD1ic+abM8NtykwmYStG9NBo
         BEWhHSbxJYUdmwaJrCKF1KA35b0/7R/stYAVaZndVVg9MUI8Xq5KjBBO3bTI4chVRYW6
         52XrMFOIBts+8wf30yfVHM+tPRZGTwc0gVvztJygF9/O1T5RxJWqx3h9dei8bXcNoAQN
         n/0MqrfNGwLer1fLlcWf36uoGRl0XafpI54LRuoXCRqRh5b7zqvN2DbG8ywuE4O7mDT3
         o8Pw==
X-Gm-Message-State: AOAM530rDpjsK7+S6zuKPzy+wjU0b0UH58j28sDPcQTa+cpk0zuLKtgo
        YLgSQBtxuY/sM1A1SpfNE2LYaRQO
X-Google-Smtp-Source: ABdhPJx2ytLjL/iYyD/m59SEtst2OKhJaFaoq1n/39Aljb8iODmOQLgqR+2sRLROEtbWxm7k6R3Ynw==
X-Received: by 2002:a2e:9cd8:: with SMTP id g24mr524485ljj.245.1594667452325;
        Mon, 13 Jul 2020 12:10:52 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id m6sm4192367ljc.134.2020.07.13.12.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 12:10:51 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>
Subject: [PATCH 2/2] git-diff.txt: reorder possible usages
Date:   Mon, 13 Jul 2020 21:10:09 +0200
Message-Id: <280943ef56a2a777ab0162b8ec4ba0166cc2095c.1594666410.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0
In-Reply-To: <cover.1594666410.git.martin.agren@gmail.com>
References: <cover.1594666410.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The description of `git diff` goes through several different invocations
(numbering added by me):

  1. git diff [<options>] [--] [<path>...]
  2. git diff [<options>] --no-index [--] <path> <path>
  3. git diff [<options>] --cached [<commit>] [--] [<path>...]
  4. git diff [<options>] <commit> [--] [<path>...]
  5. git diff [<options>] <commit> <commit> [--] [<path>...]
  6. git diff [<options>] <commit>..<commit> [--] [<path>...]
  7. git diff [<options>] <commit> <commit>... <commit> [--] [<path>...]
  8. git diff [<options>] <commit>...<commit> [--] [<path>...]

It then goes on to say that "all of the <commit> in the above
description, except in the last two forms that use '..' notations, can
be any <tree>". The "last two" actually refers to 6 and 8. This got out
of sync in commit b7e10b2ca2 ("Documentation: usage for diff combined
commits", 2020-06-12) which added item 7 to the mix.

As a further complication, after b7e10b2ca2 we also have some potential
confusion around "the '..' notation". The "..[.]" in items 6 and 8 are
part of the rev notation, whereas the "..." in item 7 is manpage
language for "one or more".

Move item 6 down, i.e., to between 7 and 8, to restore the ordering.
Because 6 refers to 5 ("synonymous to the previous form") we need to
tweak the language a bit.

An added bonus of this commit is that we're trying to steer users away
from `git diff <commit>..<commit>` and moving it further down probably
doesn't hurt.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-diff.txt | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index c613e71ca4..727f24d16e 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -63,12 +63,6 @@ files on disk.
 	This is to view the changes between two arbitrary
 	<commit>.
 
-'git diff' [<options>] <commit>..<commit> [--] [<path>...]::
-
-	This is synonymous to the previous form.  If <commit> on
-	one side is omitted, it will have the same effect as
-	using HEAD instead.
-
 'git diff' [<options>] <commit> <commit>... <commit> [--] [<path>...]::
 
 	This form is to view the results of a merge commit.  The first
@@ -78,6 +72,13 @@ files on disk.
 	For instance, if `master` names a merge commit, `git diff master
 	master^@` gives the same combined diff as `git show master`.
 
+'git diff' [<options>] <commit>..<commit> [--] [<path>...]::
+
+	This is synonymous to the earlier form (without the "..") for
+	viewing the changes between two arbitrary <commit>.  If <commit> on
+	one side is omitted, it will have the same effect as
+	using HEAD instead.
+
 'git diff' [<options>] <commit>\...<commit> [--] [<path>...]::
 
 	This form is to view the changes on the branch containing
-- 
2.28.0.rc0

