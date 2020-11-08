Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17622C5517A
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB15206E3
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCqLmiZy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgKHVlu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbgKHVlr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:47 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DD6C0613D2
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:46 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id b1so9549129lfp.11
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RUsaRfdKVsiQoqxks4QJq4Jrl7ddH4Gb5O313Mis84g=;
        b=MCqLmiZyv/p7u8U6ouXDZlWvOXm7kjCJsrHCkb4ehVfkNtR+knYbdB7hKF5Z1Bffkt
         VL6d2Lx69hbH75GEHibWnnweNVOOxQhloOm1vQY+9T+QnxA7zVU0cSCMa3DeoxN1s8R/
         kqvu2ex3YD/mOJuEOjiki3HpYZfUeVSqT+vO5GBalCwBO9VJcJjcHbz9tS02uNxf3Lel
         TK9WxnUDdSJ8ppMlLyCNT7SOndRRvDWuc6WkK9hSAs5roiOxm844zUY1r3e6LLAMZWO5
         SRYzkX3fGyvNzZff3gS0ITyOl/qgHNsBEexUaFUH65EP5CXL9xP/bjbK0T7WU2DIh3yA
         DKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RUsaRfdKVsiQoqxks4QJq4Jrl7ddH4Gb5O313Mis84g=;
        b=twbuwjQljZEh0tdNxQOr3XIcdlj5BLzvha0wZh+u0xUPQqdInmr4TYQHtHODTwtFIv
         XqFnqoCQhsE+ADA9MQeDR3Rwuf/1+aN0gLS6pZjiD1pClzl6o8O8i4qvDawee18qRDip
         58P6CfajAlPzR6vaZSx9o5XjFecbFUxM3Iw9rMMwSIRkqKDPqdH6RGGMdN4uBe4tZG5h
         YO5vcI/Nt2/W5wDmtMoXr7PD1wTYv5gRC4YfOpKJRRZCGM2S5pE4yHxqUHLpOWDZAI4w
         //218SRgFCi+5eKcvXPHnauoiwMSQUTaCD6wchdbCemIiXoBQbx3IpT/iEvp2XMrsz6P
         meUw==
X-Gm-Message-State: AOAM532RHMAyUp8/79zFJeGXVqnbiTltC2fvFjsepLAqMZ/QdzLiIU5g
        bOe9SYt0Xve9HxqlewzMBj0=
X-Google-Smtp-Source: ABdhPJwPuqp7aC2pFu+ajrNCYnxdjv/8+Y3EiLxdwAnh7iAxEsXK1mvKhTdMEeZjvZ0U1N0lfaBvnQ==
X-Received: by 2002:a19:7102:: with SMTP id m2mr4189573lfc.461.1604871705416;
        Sun, 08 Nov 2020 13:41:45 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:44 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 27/27] doc/git-show: include --diff-merges description
Date:   Mon,  9 Nov 2020 00:38:38 +0300
Message-Id: <20201108213838.4880-28-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201108213838.4880-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move description of --diff-merges option from git-log.txt to
diff-options.txt so that it is included in the git-show help.

While we are at it, make git-show closer to git-log in this area by
providing similar wording in the introduction of diff options.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-options.txt | 54 ++++++++++++++++++++++++++++++++++
 Documentation/git-log.txt      | 52 --------------------------------
 Documentation/git-show.txt     |  8 +++--
 3 files changed, 60 insertions(+), 54 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 573fb9bb71e2..f1629887103e 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -33,6 +33,60 @@ endif::git-diff[]
 	show the patch by default, or to cancel the effect of `--patch`.
 endif::git-format-patch[]
 
+ifdef::git-log[]
+Note that unless one of `--diff-merges` variants (including short
+`-m`, `-c`, and `--cc` options) is explicitly given, merge commits
+will not show a diff, even if a diff format like `--patch` is
+selected, nor will they match search options like `-S`. The exception
+is when `--first-parent` is in use, in which case
+`--diff-merges=first-parent` is implied.
+
+--diff-merges=(off|none|first-parent|separate|combined|dense-combined)::
+--no-diff-merges::
+	Specify diff format to be used for merge commits. This has no
+	effect unless diff output is enabled in the first place (e.g.,
+	with `--patch` option.)
++
+--diff-merges=(off|none):::
+--no-diff-merges:::
+	(default) Disable output of diffs for merge commits. Useful to
+	override implied value.
++
+--diff-merges=first-parent:::
+	This option makes merge commits show the full diff with
+	respect to the first parent only, exactly like	regular
+	commits.
++
+--diff-merges=separate:::
+-m:::
+	This makes merge commits show the full diff with respect to
+	each of the parents. Separate log entry and diff is generated
+	for each parent.
++
+--diff-merges=combined:::
+-c:::
+	With this option, diff output for a merge commit shows the
+	differences from each of the parents to the merge result
+	simultaneously instead of showing pairwise diff between a
+	parent and the result one at a time. Furthermore, it lists
+	only files which were modified from all parents.
++
+--diff-merges=dense-combined:::
+--cc:::
+	With this option the output produced by
+	`--diff-merges=combined` is further compressed by omitting
+	uninteresting hunks whose contents in the parents have only
+	two variants and the merge result picks one of them without
+	modification.
+
+--combined-all-paths::
+	This flag causes combined diffs (used for merge commits) to
+	list the name of the file from all parents.  It thus only has
+	effect when `--diff-merges=[dense-]combined` is in use, and
+	is likely only useful if filename changes are detected (i.e.
+	when either rename or copy detection have been requested).
+endif::git-log[]
+
 -U<n>::
 --unified=<n>::
 	Generate diffs with <n> lines of context instead of
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index de498a189646..0cacc780bf30 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -120,58 +120,6 @@ DIFF FORMATTING
 By default, `git log` does not generate any diff output. The options
 below can be used to show the changes made by each commit.
 
-Note that unless one of `--diff-merges` variants (including short
-`-m`, `-c`, and `--cc` options) is explicitly given, merge commits
-will not show a diff, even if a diff format like `--patch` is
-selected, nor will they match search options like `-S`. The exception
-is when `--first-parent` is in use, in which case
-`--diff-merges=first-parent` is implied.
-
---diff-merges=(off|none|first-parent|separate|combined|dense-combined)::
---no-diff-merges::
-	Specify diff format to be used for merge commits. This has no
-	effect unless diff output is enabled in the first place (e.g.,
-	with `--patch` option.)
-+
---diff-merges=(off|none):::
---no-diff-merges:::
-	(default) Disable output of diffs for merge commits. Useful to
-	override implied value.
-+
---diff-merges=first-parent:::
-	This option makes merge commits show the full diff with
-	respect to the first parent only, exactly like	regular
-	commits.
-+
---diff-merges=separate:::
--m:::
-	This makes merge commits show the full diff with respect to
-	each of the parents. Separate log entry and diff is generated
-	for each parent.
-+
---diff-merges=combined:::
--c:::
-	With this option, diff output for a merge commit shows the
-	differences from each of the parents to the merge result
-	simultaneously instead of showing pairwise diff between a
-	parent and the result one at a time. Furthermore, it lists
-	only files which were modified from all parents.
-+
---diff-merges=dense-combined:::
---cc:::
-	With this option the output produced by
-	`--diff-merges=combined` is further compressed by omitting
-	uninteresting hunks whose contents in the parents have only
-	two variants and the merge result picks one of them without
-	modification.
-
---combined-all-paths::
-	This flag causes combined diffs (used for merge commits) to
-	list the name of the file from all parents.  It thus only has
-	effect when `--diff-merges=[dense-]combined` is in use, and
-	is likely only useful if filename changes are detected (i.e.
-	when either rename or copy detection have been requested).
-
 
 :git-log: 1
 include::diff-options.txt[]
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index fcf528c1b30d..abe58ce5d3a8 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -45,8 +45,12 @@ include::pretty-options.txt[]
 include::pretty-formats.txt[]
 
 
-COMMON DIFF OPTIONS
--------------------
+DIFF FORMATTING
+---------------
+
+By default, `git show` does not generate any diff output. The options
+below can be used to show the changes made by each commit.
+
 
 :git-log: 1
 include::diff-options.txt[]
-- 
2.25.1

