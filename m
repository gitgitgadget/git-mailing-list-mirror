Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DD3C43141
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CD62073C
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wl/iHwbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfLCOCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:02:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36900 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfLCOCc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 09:02:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so3826918wru.4
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 06:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G7opqmJudGICA/Y3BZzKEcINzC9/yKeSSKBMoBEqXVI=;
        b=Wl/iHwbnSNOYAw6AWxh8NZOjbSPvJgoEX5kwkSV61LY7Aj0pdUkQPjgoicwsqbXG66
         rRdHiI2rpKw9Cw6V2Jdm5Z4xqNjQS5+afDgRiI3Vq1EUlUW5rc91syc9yIgzVp9dZPET
         wH2gGBrRTgNJBayPw1rXEicS4d117Pe7gWGm5KwpT30h82AGt6PpbBNcUFuX0y5kpgCJ
         JTdan7sPDFIG7HV7dCq1PGXyCNlxfoI3PtDFBQIAFkcYOz93wEEthWVmtcDdEznEaE/c
         WjrmEb+LJEVwLrMfINNXfkjO78oh6WlQfxiJNY3z2AwGgaYPYZChbUvDLCifQKUgezLg
         e5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G7opqmJudGICA/Y3BZzKEcINzC9/yKeSSKBMoBEqXVI=;
        b=ojaDLq/OzPy475x6oALjnHqClqlZYKlMh7TP27kR9fvsA9fCnJJRcbbRXouM0DHMOx
         CaYd5E8O0gJi5wo3KxhoKZHpKmbTfbP85NnWjpRV1WP+sqeEmNli+NX1qX/jxmruDIXE
         hcodAryULs9K+GdzNhTPU8NWipu0grGGLkUKHMcCwV6R/A8sCINYXM/rPB1vEsJd+qa5
         E7nuJj27BYC9a3S9LhRGm+CqFesZhpSxu+pbxxHMODWtDnUr46AG/CdydJE2IGFg9Awu
         bvNIAGAL7VbTADyIYMcUQtDkyxN5+YH14fNdGy/nVQPf1kfqNe6sinyQ+2nOJ9+4rO/2
         wiFQ==
X-Gm-Message-State: APjAAAWcqZ+wz05RJ4L5XMJXHwQA4ir5j2ZW0v/KpQ47TayH8/2e+xXs
        uY/si9/pdcrCh8ZioWDKlfedbKws
X-Google-Smtp-Source: APXvYqyT0iUUJasLaaYLp05JWheQ1hlGvCbxxPR4dvZShBBcgG1sLwj7cWE3bPE6Qx5Dg8ogLTEgVQ==
X-Received: by 2002:adf:fd07:: with SMTP id e7mr5239607wrr.21.1575381749798;
        Tue, 03 Dec 2019 06:02:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e8sm3730274wrt.7.2019.12.03.06.02.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 06:02:29 -0800 (PST)
Message-Id: <9e37a740e6f420b1e19e7bf829227c25aa42efe6.1575381738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
References: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
        <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Dec 2019 14:02:17 +0000
Subject: [PATCH v4 12/13] doc: restore: synchronize <pathspec> description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

`git add` shows an example of good writing, follow it.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-restore.txt | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 1ab2e40ea9..d7bf016bba 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -8,8 +8,8 @@ git-restore - Restore working tree files
 SYNOPSIS
 --------
 [verse]
-'git restore' [<options>] [--source=<tree>] [--staged] [--worktree] <pathspec>...
-'git restore' (-p|--patch) [<options>] [--source=<tree>] [--staged] [--worktree] [<pathspec>...]
+'git restore' [<options>] [--source=<tree>] [--staged] [--worktree] [--] <pathspec>...
+'git restore' (-p|--patch) [<options>] [--source=<tree>] [--staged] [--worktree] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -113,6 +113,14 @@ in linkgit:git-checkout[1] for details.
 	appear in the `--source` tree are removed, to make them match
 	`<tree>` exactly. The default is no-overlay mode.
 
+\--::
+	Do not interpret any more arguments as options.
+
+<pathspec>...::
+	Limits the paths affected by the operation.
++
+For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
+
 EXAMPLES
 --------
 
-- 
gitgitgadget

