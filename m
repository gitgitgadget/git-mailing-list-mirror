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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EEEC43331
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B94207FC
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uudICuXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgCYVKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:10:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53701 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYVK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 17:10:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id b12so4272177wmj.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 14:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TjrI4YbPXuAi0XptulVduR4s2jsL4np4xnJEXlqOmxY=;
        b=uudICuXY2yhiOZN0v1tuhLAXKCP/pct2M4f81NbYT4sCBdascpRoRwiCTWWMQ9On0u
         EvhEXspZEqI6+RaFAwHC//QNkpgwLWphl9cZwQ1CcjmcpDKmXZVSCkbQc09JUmELgWcY
         qL6CLezHFST+LzPnhmyRdqfw8V0GHQeTMBgjuhND44229af3B3bh0D9CB/05F6tgDY7g
         KaYCAxkSwZQO3skxq0OnlV6C6hoOmW0ZyysR3oAGlHoH04M9Z/Sz8VjMGbEP5qZzsbm6
         fUzAbHoDkcqMOm4PZ9u5yMMP+yli1SU05csxjjkbne6E2TGGYRpbm16rzN7vIU6s0JwF
         mnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TjrI4YbPXuAi0XptulVduR4s2jsL4np4xnJEXlqOmxY=;
        b=pvtfMKwIE05TSfp3jmu72KKkffef/l8BUHXrKOeYEhim+r2Pw8tdCuoUmHZ45lLLRQ
         rSUfDjW33TqvrTTbHQd7bZiC5o3RTFd/f8xX5OuMgxUq2tsVLwkaqdwCmP34/dXQ4jzS
         s6sOSx6z4egj1WNpFZ4pCnUfVJ5/TQqiSlXcNqYnZCS52jRWf9yo2uFYkN3lEyJfKZPJ
         FW65u0qj7gTLrPeH6k9BCil6zVr0MAvGue2dSoCDkFDsM7K7PB1vhDeeclkRFX3M+ZpR
         10fHeyIMS3kY2yAgK7mp5YznGl/s4QXAEkeJxtpFuEuSMTHG9GHEFjskaA4i+vjqYPvU
         KLCA==
X-Gm-Message-State: ANhLgQ11ISD0oo9xol+YPdnsHebQL9zM29b+nSY7phVJiDaKUemXPR7w
        w0R0To34ybM99PVjSHrWafyIQ1wTnW8=
X-Google-Smtp-Source: ADFU+vtChbbQAPEbul+oTNmuxvjlmp9PqhnPbfBPe+pMxyNcTyWnFhAQDsiLda1j/JobhPeWIviCyQ==
X-Received: by 2002:a1c:1f14:: with SMTP id f20mr5446748wmf.61.1585170626687;
        Wed, 25 Mar 2020 14:10:26 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id u16sm352760wro.23.2020.03.25.14.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 14:10:25 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v4 2/5] doc: document --recurse-submodules for reset and restore
Date:   Wed, 25 Mar 2020 22:09:40 +0100
Message-Id: <20200325210943.339240-3-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200325210943.339240-1-damien.olivier.robert+git@gmail.com>
References: <20200325210943.339240-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also unify the formulation about --no-submodules for checkout and
switch, which we reuse for restore.

And correct the formulation about submodules' HEAD in read-tree, which
we reuse in reset.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 Documentation/git-checkout.txt  |  2 +-
 Documentation/git-read-tree.txt |  2 +-
 Documentation/git-reset.txt     |  6 ++++++
 Documentation/git-restore.txt   | 11 +++++++++++
 Documentation/git-switch.txt    |  2 +-
 5 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index c8fb995fa7..140bd3eabb 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -296,7 +296,7 @@ Note that this option uses the no overlay mode by default (see also
 	submodules according to the commit recorded in the superproject. If
 	local modifications in a submodule would be overwritten the checkout
 	will fail unless `-f` is used. If nothing (or `--no-recurse-submodules`)
-	is used, the work trees of submodules will not be updated.
+	is used, submodules working trees will not be updated.
 	Just like linkgit:git-submodule[1], this will detach `HEAD` of the
 	submodule.
 
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index da33f84f33..807cad4691 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -118,7 +118,7 @@ OPTIONS
 --[no-]recurse-submodules::
 	Using --recurse-submodules will update the content of all initialized
 	submodules according to the commit recorded in the superproject by
-	calling read-tree recursively, also setting the submodules HEAD to be
+	calling read-tree recursively, also setting the submodules' HEADs to be
 	detached at that commit.
 
 --no-sparse-checkout::
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 932080c55d..d7a09f11a0 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -87,6 +87,12 @@ but carries forward unmerged index entries.
 	different between `<commit>` and `HEAD`.
 	If a file that is different between `<commit>` and `HEAD` has local
 	changes, reset is aborted.
+
+--[no-]recurse-submodules::
+	When the working tree is updated, using --recurse-submodules will
+	also recursively reset the working tree of all active submodules
+	according to the commit recorded in the superproject, also setting
+	the submodules' HEADs to be detached at that commit.
 --
 
 See "Reset, restore and revert" in linkgit:git[1] for the differences
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 5bf60d4943..8e3b339802 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -107,6 +107,17 @@ in linkgit:git-checkout[1] for details.
 	patterns and unconditionally restores any files in
 	`<pathspec>`.
 
+--recurse-submodules::
+--no-recurse-submodules::
+	If `<pathspec>` names an active submodule and the restore location
+	includes the working tree, the submodule will only be updated if
+	this option is given, in which case its working tree will be
+	restored to the commit recorded in the superproject, and any local
+	modifications overwritten. If nothing (or
+	`--no-recurse-submodules`) is used, submodules working trees will
+	not be updated. Just like linkgit:git-checkout[1], this will detach
+	`HEAD` of the submodule.
+
 --overlay::
 --no-overlay::
 	In overlay mode, the command never removes files when
diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
index 197900363b..79dbc9624d 100644
--- a/Documentation/git-switch.txt
+++ b/Documentation/git-switch.txt
@@ -183,7 +183,7 @@ name, the guessing is aborted.  You can explicitly give a name with
 	Using `--recurse-submodules` will update the content of all
 	initialized submodules according to the commit recorded in the
 	superproject. If nothing (or `--no-recurse-submodules`) is
-	used, the work trees of submodules will not be updated. Just
+	used, submodules working trees will not be updated. Just
 	like linkgit:git-submodule[1], this will detach `HEAD` of the
 	submodules.
 
-- 
Patched on top of v2.26.0 (git version 2.25.2)

