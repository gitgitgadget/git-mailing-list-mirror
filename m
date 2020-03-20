Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F31C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706F920658
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpNf6mS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgCTVic (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:38:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36211 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbgCTVib (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 17:38:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id g62so7985725wme.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 14:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AaIBXBiwZjyHq05MKO5m5ugQuJ/deIjpKaGuP9M1dtk=;
        b=dpNf6mS9NrwJhVGKOhW8nOKHQKVa2MFficotnYXMnJ7MgQwGGGXK6aykMACX9ZyGfk
         DdSyaDIRVFF9uqM8f/RN4qSzDIRX9Mz1Zt+75iCsa/NpjDC0geo0l9yT2vpShcp7vhU4
         9J58BeZms2ytdw0E7kkIEfERiQgeDhixUOKXq4lwUxSvvoUXffC4Py59zr9gfTZ3vJWN
         eO0tqpZfiKc6x9P7U+VOnhPz8YZc7Mh3xxHYcZQO3+3dB3GhrM87SOgtFeYzit46z/m+
         93Ybtu8N3uGAC/GbwaJkqb0cbODmsaA8N2ny8HB5mwsjSXo1w3D9mYux2nDBZvTAHzIS
         nQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AaIBXBiwZjyHq05MKO5m5ugQuJ/deIjpKaGuP9M1dtk=;
        b=EzpPFBE2uaIJNADSae5AKFEMOx7OCdBVC0hWcU3klazGSVu6M89abs9UOiHgDh3KjD
         oUCXvgQaUlzj6GlROPI0DgPN6LKq/9Zv9iYjutwL/6k0lUTewraJO8NhOBGgDIRJlDp6
         qOyKIAZtHAntm0fWHqX9NPCvn69yCy0rsG/AWObec7Bpj8I0vAiGHbiA0VHz4bDePDdx
         LrczdQagL/e2y6n0ALhTPDo5n0GE/nRpxxa9cEZwgNWYl1+ihem2h+y0vkkzBy43uDum
         DbA2HsQ33hWV9hYPbGtOG6zyAnTUn1/sjdVRTAwMFSNwGASc81nr6F56nGotqvjXkBt6
         +SYw==
X-Gm-Message-State: ANhLgQ0D+Pz/v5DxTkMnhJF5aWXp6BZv2PC/dt3S3Umle5jZxdytQFDL
        hcPYHck9CT+ALuXFLFh0bgYXLuXg8a0=
X-Google-Smtp-Source: ADFU+vtKovC2pRyIs2hmW6urhmpLjmhLcWAGw+ntDdNfROjSAnfEdbERuMAbU2xBf0wbAsOBsgaKyg==
X-Received: by 2002:a05:600c:286:: with SMTP id 6mr12587463wmk.101.1584740308377;
        Fri, 20 Mar 2020 14:38:28 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id i1sm9742407wrq.89.2020.03.20.14.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 14:38:27 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v3 5/5] doc: --recurse-submodules mostly only apply to active submodules
Date:   Fri, 20 Mar 2020 22:37:29 +0100
Message-Id: <20200320213729.571924-6-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320213729.571924-1-damien.olivier.robert+git@gmail.com>
References: <20200320213729.571924-1-damien.olivier.robert+git@gmail.com>
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
  `git submodule update [<path]` separately which populated the
  submodule working tree. This does not involve the 3 configuration
  variables above.
- Initialized (at least in the context of the man pages involved in this
  patch) means both "populated" and "active" as defined above, i.e. what
  `git submodule update --init` does.

The --recurse-submodules option mostly affects submodules. An exception
is `git fetch` where the option affects populated submodules.
As a consequence, in `git pull` the fetch affects populated submodules,
but the resulting working tree update only affects active submodules.

In the documentation of `git-pull` we only refer to active submodules,
since it is implicit that the fetching behaviour is governed by the
fetch command.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
Helped-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-checkout.txt  | 2 +-
 Documentation/git-grep.txt      | 2 +-
 Documentation/git-ls-files.txt  | 2 +-
 Documentation/git-pull.txt      | 2 +-
 Documentation/git-read-tree.txt | 2 +-
 Documentation/git-switch.txt    | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index c8fb995fa7..3be0a28284 100644
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
index 47bc4a7061..2285f3729d 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -85,7 +85,7 @@ OPTIONS
 	Pass --verbose to git-fetch and git-merge.
 
 --[no-]recurse-submodules[=yes|on-demand|no]::
-	This option controls if new commits of all populated submodules should
+	This option controls if new commits of all active submodules should
 	be fetched and updated, too (see linkgit:git-fetch[1], linkgit:git-config[1] and linkgit:gitmodules[5]).
 +
 If the checkout is done via rebase, local submodule commits are rebased as well.
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index da33f84f33..aab6856341 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -116,7 +116,7 @@ OPTIONS
 	located in.
 
 --[no-]recurse-submodules::
-	Using --recurse-submodules will update the content of all initialized
+	Using --recurse-submodules will update the content of all active
 	submodules according to the commit recorded in the superproject by
 	calling read-tree recursively, also setting the submodules HEAD to be
 	detached at that commit.
diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
index 197900363b..337852d86b 100644
--- a/Documentation/git-switch.txt
+++ b/Documentation/git-switch.txt
@@ -181,7 +181,7 @@ name, the guessing is aborted.  You can explicitly give a name with
 --recurse-submodules::
 --no-recurse-submodules::
 	Using `--recurse-submodules` will update the content of all
-	initialized submodules according to the commit recorded in the
+	active submodules according to the commit recorded in the
 	superproject. If nothing (or `--no-recurse-submodules`) is
 	used, the work trees of submodules will not be updated. Just
 	like linkgit:git-submodule[1], this will detach `HEAD` of the
-- 
Patched on top of v2.26.0-rc2-27-gbe8661a328 (git version 2.25.2)

