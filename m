Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B03C3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 17:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BE320848
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 17:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4vAYSTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgCCRI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:08:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40251 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbgCCRI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 12:08:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id r17so5333273wrj.7
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 09:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qnt+X0LAgEtD2huh6FYtmW1wXfwrdyo8jJTOkW/nJ/A=;
        b=h4vAYSTsjRKDOKxBrwDb2PA9PO9zKBV4EnCAedmoWolkvCAE3DLQXKMhI1GRn/tWXz
         yO3tiyaA773FUD39+tjsuVsQfWa06+fCKv1ENOSlC6qT6MbMRXhWYGr3C0LWk3guu6Lq
         c/U2CR44VJTL7PTp6K+TDl1PzzC+1zqCVu/JjGmyWkecWYuLVafRiftvmK5ItyboiEr3
         RdMvhz8mgoY6fPUMmMXOp3Hyp51bfdEZM/lJbTe/ITJTH60BP/ZprGZJEq59gYSwhN6z
         kRir5WZgq9t5QUelCRa+da3RmYQOleUSoGPnkcV7AoHVJe09AeJs9FR1G46UO46FypMQ
         Wn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qnt+X0LAgEtD2huh6FYtmW1wXfwrdyo8jJTOkW/nJ/A=;
        b=GyaKa5523iVtnJKVxbwSvZJqTwNNt62/+g0Y4YDI9h/FXGm26J66eim+MG7gux1whk
         jeyIStJhrhImhWXIwU4GMpphAbE+fVfcToSxM3u8HptiTNm4D5uQ39EN7QOZSHd9iHkR
         eYese5FJNLPmMOlz9SeZP/dpZcKBhjNJpj+psNl9Q41l7bejwbUtjRm4G13jOo3rjlG5
         d6SypEFkZM3tCidM9X8wmzNmCNk4EP/D1QraiAecKS2YtXXrIMOHRA9g7SSvY4IR/x0i
         shvQdNqVnbj7EjplSSfLmlaC4FGYNLs7UtXYIzNbAngvntvqNNR7ShWZSnnuCOXTzKOn
         Kdjw==
X-Gm-Message-State: ANhLgQ3NfAFKpFDnH1GMZNnlL1Na0cFPmABiwr6qsmHdpBxKP5vRN0Q8
        i8w3uvIkqFvrJ5lHEpkxfM+GpaPfyR0=
X-Google-Smtp-Source: ADFU+vtpvTkBuf+3Ejkd6OXZr5GnpYPSXBAYEQPnbCmbql8X4PnoyhqNmqrVHvyoAtEKNtoGL4nu4Q==
X-Received: by 2002:adf:e546:: with SMTP id z6mr6679603wrm.423.1583255305236;
        Tue, 03 Mar 2020 09:08:25 -0800 (PST)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id 16sm4746576wmi.0.2020.03.03.09.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 09:08:24 -0800 (PST)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v2 2/5] doc: document --recurse-submodules for reset and restore
Date:   Tue,  3 Mar 2020 18:07:37 +0100
Message-Id: <20200303170740.1879432-3-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303170740.1879432-1-damien.olivier.robert+git@gmail.com>
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
 <20200303170740.1879432-1-damien.olivier.robert+git@gmail.com>
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
index 5bf60d4943..5036f91132 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -107,6 +107,16 @@ in linkgit:git-checkout[1] for details.
 	patterns and unconditionally restores any files in
 	`<pathspec>`.
 
+--recurse-submodules::
+--no-recurse-submodules::
+	If `<pathspec>` names a submodule and the restore location includes
+	the working tree, the submodule will only be updated if this option
+	is given, in which case it's working tree will be restored to the
+	commit recorded in the superproject, and it's local modifications
+	overwritten. If nothing (or `--no-recurse-submodules`) is used,
+	the work trees of submodules will not be updated. Just like
+	linkgit:git-checkout[1], this will detach `HEAD` of the submodule.
+
 --overlay::
 --no-overlay::
 	In overlay mode, the command never removes files when
-- 
Patched on top of v2.25.1-377-g2d2118b814 (git version 2.25.1)

