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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340EEC4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0292320658
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQQ2xlA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgCTVi2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:38:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33843 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgCTVi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 17:38:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id 26so3995736wmk.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 14:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VyCd9IEUTNC3MLYwDaOFYTnLfEw5uWNOX5fip4gyeJU=;
        b=uQQ2xlA7+YisIgwgp2JlRO1TPQE8On+pjti7L2OnOZePumvxLwi+hGZiYOsZB7x9of
         t3UtBoWYVEIFl/UiBxeFTOapMEjGuqSMnhrjP0GamGoo/bjHHC6JJaY5QlGN3l43vYoM
         67yGEUhi1FXrgFgsnz48QjaHpN+UkzZot6A1M7idTfbu9MxYQtjkXu9qZGmPBFAUC+z0
         8e9wX0oEZmvdvQ1wDd40CJkekApH9znrxh8LWXNVAJ3tWE6YpwBscL1IkS9tOZ+jfZOn
         +eJPa/ST+BlIwyWtIa3EmvAbxPJpwFQ4fCvie27vTtbveYPxlPNLAiHk+mzWTFkbUFRg
         FsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VyCd9IEUTNC3MLYwDaOFYTnLfEw5uWNOX5fip4gyeJU=;
        b=LjL2MyXagDZO0xDXlwU+lgviOoduUEPMIEAouOiitJ98pC/Cu9k14dJr4uZdajGl/M
         abej1EOe3uAOL1a6VmU0ehUfILJDZz5c0u2j3490pCvPy9Udbzg9JMV2jOCsWCddtshD
         62eyr4syD+sBhqZLIu+qHXiA1fXv4lhocm7ryrkUfqshBBk9LTtnPa8UQz3y0IzAMHdU
         /YNzvrkMd0r7x5AlpU/q8VV6urbv/A/9bR5KMLlCz/IICjoa6n7upOoVe33l7E4UAmwX
         FJTXfoqw7Jkwx/KTKgKS8hwTDkTDXWnTT3loSMH4cvoqm07kr45vKpnE8aMMCxpmuTco
         fODg==
X-Gm-Message-State: ANhLgQ27AjxL2NY/6IMxjdUIZzxfJvBWx1pm6I6ylua4zxa7w2tSlTLk
        uYVx9Z4TVLaDcgnd/Cl51vkBwSBzbSc=
X-Google-Smtp-Source: ADFU+vuH9eyUojO+ND1tsMuWdGnh6aehrIVQxEgFr5Wp5t8Ilj2eRx4s2J/p7sy9V8JlOjqwD7bgYA==
X-Received: by 2002:a1c:4d16:: with SMTP id o22mr6290540wmh.56.1584740304979;
        Fri, 20 Mar 2020 14:38:24 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id i1sm9742407wrq.89.2020.03.20.14.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 14:38:24 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v3 2/5] doc: document --recurse-submodules for reset and restore
Date:   Fri, 20 Mar 2020 22:37:26 +0100
Message-Id: <20200320213729.571924-3-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320213729.571924-1-damien.olivier.robert+git@gmail.com>
References: <20200320213729.571924-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 Documentation/git-reset.txt   |  6 ++++++
 Documentation/git-restore.txt | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 932080c55d..c8623cfc34 100644
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
+	the submodules HEAD to be detached at that commit.
 --
 
 See "Reset, restore and revert" in linkgit:git[1] for the differences
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 5bf60d4943..47f31d4a0f 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -107,6 +107,16 @@ in linkgit:git-checkout[1] for details.
 	patterns and unconditionally restores any files in
 	`<pathspec>`.
 
+--recurse-submodules::
+--no-recurse-submodules::
+	If `<pathspec>` names a submodule and the restore location includes
+	the working tree, the submodule will only be updated if this option
+	is given, in which case its working tree will be restored to the
+	commit recorded in the superproject, and any local modifications
+	overwritten. If nothing (or `--no-recurse-submodules`) is used,
+	the work trees of submodules will not be updated. Just like
+	linkgit:git-checkout[1], this will detach `HEAD` of the submodule.
+
 --overlay::
 --no-overlay::
 	In overlay mode, the command never removes files when
-- 
Patched on top of v2.26.0-rc2-27-gbe8661a328 (git version 2.25.2)

