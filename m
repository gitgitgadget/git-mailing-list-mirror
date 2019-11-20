Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B8EC432C3
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 21:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED387208A1
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 21:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqngbxU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKTVSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:18:36 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34132 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKTVSg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 16:18:36 -0500
Received: by mail-pf1-f193.google.com with SMTP id n13so406547pff.1
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 13:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=be+YyRDY38TZuonMLsFYhYYjdH2tzjZAZX7TbFqSsxQ=;
        b=pqngbxU3xILE9kFjiCk79mnQJxxJ1wautXGY9JtBObvXxjbjdY/yxVlO/WsstVQsSw
         BhDm+JUALTWszw1Mvv4FoqcMQcGFz+u3lfih5vXq8dowSTEU+Ae9s753xgUo/i7VZDO4
         InCO9jBRZW6ROy5BfiUiWyClDu4lxr7qlzC/Jd21weYJXYFdU0KbtGEfht2hoyQ1FG75
         KOnHON931QyrC5LEY0/XW+qluNT448xboWWSG0oLJgcUCXvw9np1k8lhw1+PFhQcLBbn
         bNzTfOYT3cZ5TslWlntFP2EDiW+fehGv0Q3RXKATB0OpGW+kUfw0cazyGxb/rM3cW7dI
         d2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=be+YyRDY38TZuonMLsFYhYYjdH2tzjZAZX7TbFqSsxQ=;
        b=VKyuHg2kKFMi3n2dfF5QgFUy6D7uuFGi4Wy1LelNyvaduwYz8vpUbaSNznvtXrtUAB
         pSS0Zc2PBVY0xR/9OXcU0CwEDWQpPosTh9vTuWVMsZ0pht9QsMTdRU8yBcPivK4ImVN1
         jI0lHIiHiDTLIIsOeNpgh/2fGGPPCssJlEhhwUKXDi4kfoU5A84+iVF2827VpferaXgU
         npdRoDn5PbYDQZpiB4wmr0e1cSBAbXGfDL8QUXSVaCPFIIE7drBDSc9MQDgCYu2COR9C
         xjCv/G6X9VXm9ytp6Gw0ptZmF09vToUIMuLl6IFO27hPEJD9SNCXibAhbS0Ckd0PICzm
         8GFw==
X-Gm-Message-State: APjAAAXH3nRYmISk2hL1q6G+KZ3bhDgK/GYQEr2LGjIVCoIMp6ihBsEM
        TTtlsT1jTapblaMNL8zl7Aa/yKTD
X-Google-Smtp-Source: APXvYqxcNqLkZ3eybJLpzyvc8JkqGYQs/hb1xzHuWNPk+TYABlXbb8+15gE8SYHRYXagCrlIRMSTYw==
X-Received: by 2002:a63:f207:: with SMTP id v7mr5587580pgh.246.1574284713445;
        Wed, 20 Nov 2019 13:18:33 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id 186sm306618pfe.141.2019.11.20.13.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 13:18:32 -0800 (PST)
Date:   Wed, 20 Nov 2019 13:18:31 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 03/10] pretty-options.txt: --notes accepts a ref instead
 of treeish
Message-ID: <4989956f128fe36f743c25aacc89aae14be845ff.1574284470.git.liu.denton@gmail.com>
References: <cover.1574207673.git.liu.denton@gmail.com>
 <cover.1574284470.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574284470.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although `--notes=` accepts and handles a tree-ish just fine, it isn't a
common use-case for users to pass in bare trees. By having "treeish", it
makes it harder to click in users' minds that the argument here is the
same type as the `notes.displayRef` configuration variable, for example.

Change `treeish` to `ref` so that it will be easier for users to make
this connection.

Note that we don't completely lose the notion that `--notes=` can accept
a tree-ish. In git-notes.txt, we have

	It is also permitted for a notes ref to point directly to a tree
	object, in which case the history of the notes can be read with
	`git log -p -g <refname>`.

which means that a hardcore user who wants to take advantage of this
obscure use-case will be able to infer the connection and not be
completely left in the dark.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/pretty-options.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index e44fc8f738..6893a4a7ba 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -57,7 +57,7 @@ message by 4 spaces (i.e.  'medium', which is the default, 'full',
 and 'fuller').
 
 ifndef::git-rev-list[]
---notes[=<treeish>]::
+--notes[=<ref>]::
 	Show the notes (see linkgit:git-notes[1]) that annotate the
 	commit, when showing the commit log message.  This is the default
 	for `git log`, `git show` and `git whatchanged` commands when
@@ -68,8 +68,8 @@ By default, the notes shown are from the notes refs listed in the
 `core.notesRef` and `notes.displayRef` variables (or corresponding
 environment overrides). See linkgit:git-config[1] for more details.
 +
-With an optional '<treeish>' argument, use the treeish to find the notes
-to display.  The treeish can specify the full refname when it begins
+With an optional '<ref>' argument, use the ref to find the notes
+to display.  The ref can specify the full refname when it begins
 with `refs/notes/`; when it begins with `notes/`, `refs/` and otherwise
 `refs/notes/` is prefixed to form a full name of the ref.
 +
@@ -85,7 +85,7 @@ being displayed. Examples: "--notes=foo" will show only notes from
 	"--notes --notes=foo --no-notes --notes=bar" will only show notes
 	from "refs/notes/bar".
 
---show-notes[=<treeish>]::
+--show-notes[=<ref>]::
 --[no-]standard-notes::
 	These options are deprecated. Use the above --notes/--no-notes
 	options instead.
-- 
2.24.0.450.g7a9a4598a9

