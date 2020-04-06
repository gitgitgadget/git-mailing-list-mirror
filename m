Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBDEC2BA1B
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 13:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E17233EA
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 13:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tqUHHIzN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgDFN5k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:57:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34891 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbgDFN5j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 09:57:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id i19so15972659wmb.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 06:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mvoM5/GcQipnc8y5cLDIFcdDrYFJyt/pYp42NjEvE2c=;
        b=tqUHHIzNoBM9VOKGXmkPwTGRVg5OsjbaQiqQ9At3r1wSJXXucb+4PB0tiRqVubFOBI
         3Yj9cgcTyzouXGY3YG/TEKPFX47e2EZMCXZFA0dZ6EWEDnh8iyWY+Z0phHSggIQE4kKS
         jnZt7gjRD4xa0SJ66KzKo7gTgguSoPpPqdScevhAixVj3eUzPE+1zCEdTQYzWWGqJdsO
         JvN/xGwwEmFx3IzxzOOAPs1vfIOSZT1tPxV3aLJNw11PV45b1/b89hsr9fcvWrIxbYjw
         0GDkj9ijFw3Ff98JxilJ0FvcMh8wUlyOcWkxDq0DGWZAGamE43TsXQgixsVs0vzpI/ol
         PeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mvoM5/GcQipnc8y5cLDIFcdDrYFJyt/pYp42NjEvE2c=;
        b=fTyXtiSM9lCJUydoorY9Zb4wP3qT1zWQ3KJumu57gkqt5Ls6dFRbTZ3X27lx2vp/Jm
         F7s2ZvhB/ge/tG9mkC7o7cuZ/4TNVrAPytRz0G7p7k8cJFyIH+hGct1/xCedBO6V4Vt8
         iuVIPRtcCELO80CKeNK1c4va1Y+jaKaSSFH2bDMgUe0PX7qbDCUTmbD1Iyc+bL1NApss
         EKv9JRJ0z4jR3UrfnUCLvYNx2fXl39jeagiT1L7WlQL3kJx2ams0xhhLvvqGaApN5Inw
         htHXNfGkpMIoi9Jqb3IrzmJ8Y8o9BnPX1L+/MDq2kThOPJzbJI3LUAkrLos52ValaTMm
         Nudw==
X-Gm-Message-State: AGi0PuZdL2XJ2duWWeUclEE+F7P6aiZCekRWsMLst+ioXNJftyJ08hEI
        lukj4BFEtfDPmH5h8DLmbNhsPvJW/ss=
X-Google-Smtp-Source: APiQypIW9eBmUyFmSju1vXukABibPnMnDOjSoZ8qYxlBWfYU3XPWog88qkeGFi2kblzRfXJyC8YHtw==
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr9735728wmg.177.1586181456293;
        Mon, 06 Apr 2020 06:57:36 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id s13sm10414149wrw.20.2020.04.06.06.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 06:57:35 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v6 2/5] doc: document --recurse-submodules for reset and restore
Date:   Mon,  6 Apr 2020 15:57:06 +0200
Message-Id: <20200406135709.60041-3-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200406135709.60041-1-damien.olivier.robert+git@gmail.com>
References: <20200406135709.60041-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also unify the formulation about --no-recurse-submodules for checkout
and switch, which we reuse for restore.

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
index da33f84f33..501f2ec375 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -118,7 +118,7 @@ OPTIONS
 --[no-]recurse-submodules::
 	Using --recurse-submodules will update the content of all initialized
 	submodules according to the commit recorded in the superproject by
-	calling read-tree recursively, also setting the submodules HEAD to be
+	calling read-tree recursively, also setting the submodules' HEAD to be
 	detached at that commit.
 
 --no-sparse-checkout::
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 932080c55d..252e2d4e47 100644
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
+	the submodules' HEAD to be detached at that commit.
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
Patched on top of v2.26.0-106-g9fadedd637 (git version 2.26.0)

