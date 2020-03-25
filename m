Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C28C43331
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6D5207FC
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMcb3Lu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgCYVKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:10:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37966 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYVKc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 17:10:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id l20so4668772wmi.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 14:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NZXwr3FP4IJVyrvuaZinToqpNE4ZtNhNknvmO8dK05g=;
        b=kMcb3Lu9sjtIRD0xEouQ77yG4ehcwZ0gFheeygmt/KRm8EAnfMcs/yKclLL+Auf4/1
         lYuuwMfIMQSfC0X58IgJtg5Mz226rPlvWL4xRnm8kdtsUbuYupfGLvinX0BUi7NZ4MKW
         cWtuGBTi5YzbZEBP7eSzyNiIR3dvp1zPN53IOUP6e/Cu1iChf+ARF6dBqu1R7euZBNk8
         rCPmD5C+oRlCet5mWfRAltN1eQsoSPusqZ74ohmoNBrc5d5AM0DVqu3QZWHr1EtY8C+V
         vT3SmfFmT1eYeqh464djSocOiKJzKp0A6udtSk5hmgD86Ie5n0n8bLmTAHki5unbKA8q
         p11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NZXwr3FP4IJVyrvuaZinToqpNE4ZtNhNknvmO8dK05g=;
        b=kVYR4MkDi5ZMA6B9htBAwuBkhF0PhDvBopYaHD7Ask5nK1WqupgIv4/fzH3LPOtUbI
         cvBkQSSezjFNxwGh3/76+rN3M88rgtPEw13cm6GNELn8kf9WIPhvIRN/aNeos9V8z9cO
         mofW6vT98HMv0rkgIP2fqXCNM/rg7VxRXkI4kkvORfhz2zsja73zg3ooiAF6DgUe2ZDT
         PN7cNQXmM/akM9SkzJk22YYx1mG47HPl7sDPtzCSCQX80X4nKv9MSchrqamRr7ptDC1d
         hUGVFKC1b99TiF3tIxr9Sj+Sd1FkOAcV9u6+iGwvc1Mgi/JeG4u6GaWMsyodrJ9E6Ua2
         UbYg==
X-Gm-Message-State: ANhLgQ0gQm+ChXQlfcX2e+17PP33PdazIb5U0PuWJy5ymK6y0WRjud5j
        Jd9S/waAXJpqy3fRI5X2zscOroJPlk8=
X-Google-Smtp-Source: ADFU+vtSN8LloUvzaRWPI0oFuH6WQ1lVm6hy35j5jymw+aewCEhm2qkm0kIW46E4Djvb+pPvwrTvTw==
X-Received: by 2002:a05:600c:2dd7:: with SMTP id e23mr5202723wmh.159.1585170629992;
        Wed, 25 Mar 2020 14:10:29 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id u16sm352760wro.23.2020.03.25.14.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 14:10:29 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v4 5/5] doc: --recurse-submodules mostly applies to active submodules
Date:   Wed, 25 Mar 2020 22:09:43 +0100
Message-Id: <20200325210943.339240-6-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200325210943.339240-1-damien.olivier.robert+git@gmail.com>
References: <20200325210943.339240-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation refers to "initialized" or "populated" submodules,
to explain which submodules are affected by '--recurse-submodules', but
the real terminology here is 'active' submodules. Update the
documentation accordingly.

Some terminology:
- Active is defined in gitsubmodules(7), it only involves the
  configuration variables 'submodule.active', 'submodule.<name>.active'
  and 'submodule.<name>.url'. The function
  submodule.c::is_submodule_active checks that a submodule is active.
- Populated means that the submodule's working tree is present (and the
  gitfile correctly points to the submodule repository), i.e. either the
  superproject was cloned with ` --recurse-submodules`, or the user ran
  `git submodule update --init`, or `git submodule init [<path>]` and
  `git submodule update [<path>]` separately which populated the
  submodule working tree. This does not involve the 3 configuration
  variables above.
- Initialized (at least in the context of the man pages involved in this
  patch) means both "populated" and "active" as defined above, i.e. what
  `git submodule update --init` does.

The --recurse-submodules option mostly affects active submodules. An
exception is `git fetch` where the option affects populated submodules.
As a consequence, in `git pull --recurse-submodules` the fetch affects
populated submodules, but the resulting working tree update only affects
active submodules.

In the documentation of `git-pull`, let's distinguish between the
fetching part which affects populated submodules, and the updating of
worktrees, which only affects active submodules.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
Helped-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-checkout.txt  | 2 +-
 Documentation/git-grep.txt      | 2 +-
 Documentation/git-ls-files.txt  | 2 +-
 Documentation/git-pull.txt      | 6 ++++--
 Documentation/git-read-tree.txt | 2 +-
 Documentation/git-switch.txt    | 2 +-
 6 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 140bd3eabb..5b697eee1b 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -292,7 +292,7 @@ Note that this option uses the no overlay mode by default (see also
 
 --recurse-submodules::
 --no-recurse-submodules::
-	Using `--recurse-submodules` will update the content of all initialized
+	Using `--recurse-submodules` will update the content of all active
 	submodules according to the commit recorded in the superproject. If
 	local modifications in a submodule would be overwritten the checkout
 	will fail unless `-f` is used. If nothing (or `--no-recurse-submodules`)
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index ddb6acc025..cdf8e26b47 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -93,7 +93,7 @@ OPTIONS
 	with `--no-index`.
 
 --recurse-submodules::
-	Recursively search in each submodule that has been initialized and
+	Recursively search in each submodule that is active and
 	checked out in the repository.  When used in combination with the
 	<tree> option the prefix of all submodule output will be the name of
 	the parent project's <tree> object. This option has no effect
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 8461c0e83e..3cb2ebb438 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -148,7 +148,7 @@ a space) at the start of each line:
 	top directory.
 
 --recurse-submodules::
-	Recursively calls ls-files on each submodule in the repository.
+	Recursively calls ls-files on each active submodule in the repository.
 	Currently there is only support for the --cached mode.
 
 --abbrev[=<n>]::
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 47bc4a7061..b336df00c7 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -85,8 +85,10 @@ OPTIONS
 	Pass --verbose to git-fetch and git-merge.
 
 --[no-]recurse-submodules[=yes|on-demand|no]::
-	This option controls if new commits of all populated submodules should
-	be fetched and updated, too (see linkgit:git-fetch[1], linkgit:git-config[1] and linkgit:gitmodules[5]).
+	This option controls if new commits of populated submodules should
+	be fetched, and if the working trees of active submodules should be
+	updated, too (see linkgit:git-fetch[1], linkgit:git-config[1] and
+	linkgit:gitmodules[5]).
 +
 If the checkout is done via rebase, local submodule commits are rebased as well.
 +
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 807cad4691..a2350994ee 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -116,7 +116,7 @@ OPTIONS
 	located in.
 
 --[no-]recurse-submodules::
-	Using --recurse-submodules will update the content of all initialized
+	Using --recurse-submodules will update the content of all active
 	submodules according to the commit recorded in the superproject by
 	calling read-tree recursively, also setting the submodules' HEADs to be
 	detached at that commit.
diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
index 79dbc9624d..3759c3a265 100644
--- a/Documentation/git-switch.txt
+++ b/Documentation/git-switch.txt
@@ -181,7 +181,7 @@ name, the guessing is aborted.  You can explicitly give a name with
 --recurse-submodules::
 --no-recurse-submodules::
 	Using `--recurse-submodules` will update the content of all
-	initialized submodules according to the commit recorded in the
+	active submodules according to the commit recorded in the
 	superproject. If nothing (or `--no-recurse-submodules`) is
 	used, submodules working trees will not be updated. Just
 	like linkgit:git-submodule[1], this will detach `HEAD` of the
-- 
Patched on top of v2.26.0 (git version 2.25.2)

