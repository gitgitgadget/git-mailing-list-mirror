Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D9DC3F2D1
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 10:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6A4246A8
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 10:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvC+316F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgB1KhX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:37:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54310 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgB1KhX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 05:37:23 -0500
Received: by mail-wm1-f66.google.com with SMTP id z12so2647333wmi.4
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 02:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ja+i+IOiKyw5RUbI5UjYjv5B1LHV1MbjwbSTq8vVirk=;
        b=nvC+316Fm9P+XbxYZNlA1eHSrhB3rDX5z7Q0QR1o3VfwMuRCi+REIf2tRNLUdbGk95
         YaUUEtOUtfbKaPQTJLj59EwBtShq6ZkwOpp645OQK/DjG+A/3I/T1UnzengaDHaIyDAS
         LSrO/+DlTNBleUt5UDY+jU8sFkpyN9cnCtNEpts2f071qR/OJ2bzDLMUFc6IZVWUK6Ix
         6Ti4pu9xkYmwa4heLltp0t/r0cFYwnaRsoy3flkAQP9co6qFy0VP+Ygv9G51P9FQkXCQ
         b+swUVvJRKgfOGEclMB/kkhoeNA4gyACokxCngk9MCh7e0/8t65eJaakCpqrpjcrghxi
         //Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ja+i+IOiKyw5RUbI5UjYjv5B1LHV1MbjwbSTq8vVirk=;
        b=El/eFQG6T4AiYTHxtmlp9YltUSPlr3rx34nx4dMZBKdgy5J5uwNeP0QvqvCzbcVnO/
         FV7zrDZQPvFPpfQJTT3f1xLKW3WJ3FQnEQ6eABPCk5LHq/AOuE2Z8pDDSK3QDWkiYI8k
         oMzkebmU14y9I9KkrJ774zt1vagy1lEymXmAg1RUBchmmACuSyngVbX6nv08BPow2hwy
         5rM1RdJhP2kHPdz3nJG8ZjmAQfqtfuJ0AGIfnDE2fyauGP9SxOrVehuyGtank5gWlrNX
         dX0h35kY546tC999v1phEEozwNo8k5Y4tVmuNYdvw7LKvQGKbx3uv21ifky3z7vE2mgm
         NM9Q==
X-Gm-Message-State: APjAAAVdThxrJFZm5IA/oSog6CzfPVIxW4ccUufNvassQTA7+CFU4Mg0
        EH40V6f79f4SYZiXdap6sLeqxufDjXs=
X-Google-Smtp-Source: APXvYqytqhcFQ2kfpcfeW1J2DCO0Nv85ge+ajq2XqDMh/eZhlLQG2t9/jgDXrMcf1UdJfwgUC9rjJg==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr4155055wmf.75.1582886240522;
        Fri, 28 Feb 2020 02:37:20 -0800 (PST)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id c9sm12089032wrq.44.2020.02.28.02.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 02:37:20 -0800 (PST)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH 2/4] doc: document --recurse-submodules for reset and restore
Date:   Fri, 28 Feb 2020 11:35:56 +0100
Message-Id: <20200228103558.1684937-3-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 Documentation/git-reset.txt   | 6 ++++++
 Documentation/git-restore.txt | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 932080c55d..838c0f1101 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -87,6 +87,12 @@ but carries forward unmerged index entries.
 	different between `<commit>` and `HEAD`.
 	If a file that is different between `<commit>` and `HEAD` has local
 	changes, reset is aborted.
+
+--[no-]recurse-submodules::
+	When the working tree is updated, using --recurse-submodules will
+	also recursively reset the content of all active submodules
+	according to the commit recorded in the superproject, also setting
+	the submodules HEAD to be detached at that commit.
 --
 
 See "Reset, restore and revert" in linkgit:git[1] for the differences
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 5bf60d4943..b94b2559c7 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -107,6 +107,15 @@ in linkgit:git-checkout[1] for details.
 	patterns and unconditionally restores any files in
 	`<pathspec>`.
 
+--recurse-submodules::
+--no-recurse-submodules::
+	Using `--recurse-submodules` will update the content of all
+	restored submodules according to the commit recorded in the
+	superproject. Local modifications in a restored submodule are
+	overwritten. If nothing (or `--no-recurse-submodules`) is used, the
+	work trees of submodules will not be updated. Just like
+	linkgit:git-submodule[1], this will detach `HEAD` of the submodule.
+
 --overlay::
 --no-overlay::
 	In overlay mode, the command never removes files when
-- 
Patched on top of v2.25.1-377-g2d2118b814 (git version 2.25.1)

