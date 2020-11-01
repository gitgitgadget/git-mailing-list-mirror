Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066C9C4741F
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 17:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB5D221FE
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 17:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbgKARF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 12:05:26 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:57936 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgKARFX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 12:05:23 -0500
Received: from client3368.fritz.box (i5C74609C.versanet.de [92.116.96.156])
        by dd36226.kasserver.com (Postfix) with ESMTPA id 59EE03C462B;
        Sun,  1 Nov 2020 18:05:19 +0100 (CET)
From:   Stefan Haller <stefan@haller-berlin.de>
To:     git@vger.kernel.org
Cc:     me@yadavpratyush.com
Subject: [PATCH 2/2] git-gui: Auto-rescan on activate
Date:   Sun,  1 Nov 2020 18:05:05 +0100
Message-Id: <20201101170505.71246-3-stefan@haller-berlin.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201101170505.71246-1-stefan@haller-berlin.de>
References: <20201101170505.71246-1-stefan@haller-berlin.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do an automatic rescan whenever the git-gui window receives focus. Most other
GUI tools do this, and it's very convenient; no more pressing F5 manually.

People who don't like this behavior can turn it off using
"git config gui.autorescan false".

Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
---
 git-gui.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index 8864c14..4a4ac19 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -906,6 +906,7 @@ set font_descs {
 }
 set default_config(gui.stageuntracked) ask
 set default_config(gui.displayuntracked) true
+set default_config(gui.autorescan) true
 
 ######################################################################
 ##
@@ -4020,6 +4021,10 @@ bind .   <Alt-Key-2> {focus_widget $::ui_index}
 bind .   <Alt-Key-3> {focus $::ui_diff}
 bind .   <Alt-Key-4> {focus $::ui_comm}
 
+if {[is_config_true gui.autorescan]} {
+	bind .   <FocusIn>  schedule_rescan
+}
+
 set file_lists_last_clicked($ui_index) {}
 set file_lists_last_clicked($ui_workdir) {}
 
-- 
2.29.2

