Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6CBC388F9
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D82D206CB
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgKCQQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 11:16:38 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:58202 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgKCQQi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 11:16:38 -0500
Received: from client3368.fritz.box (i5C745802.versanet.de [92.116.88.2])
        by dd36226.kasserver.com (Postfix) with ESMTPA id E82853C46F0;
        Tue,  3 Nov 2020 17:16:35 +0100 (CET)
From:   Stefan Haller <stefan@haller-berlin.de>
To:     me@yadavpratyush.com
Cc:     git@vger.kernel.org
Subject: [PATCH v2 1/1] git-gui: Auto-rescan on activate
Date:   Tue,  3 Nov 2020 17:16:31 +0100
Message-Id: <20201103161631.89971-2-stefan@haller-berlin.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103161631.89971-1-stefan@haller-berlin.de>
References: <fe2f24e8-52f2-81fe-0ebd-ecd90b1acfb4@haller-berlin.de>
 <20201103161631.89971-1-stefan@haller-berlin.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do an automatic rescan whenever the git-gui window receives focus. Most other
GUI tools do this, and it's very convenient; no more pressing F5 manually.

People who don't like this behavior can turn it off in the Options dialog.

Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
---
 git-gui.sh     | 5 +++++
 lib/option.tcl | 1 +
 2 files changed, 6 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index 867b8ce..14735a3 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -906,6 +906,7 @@ set font_descs {
 }
 set default_config(gui.stageuntracked) ask
 set default_config(gui.displayuntracked) true
+set default_config(gui.autorescan) true

 ######################################################################
 ##
@@ -4007,6 +4008,10 @@ bind .   <Alt-Key-2> {focus_widget $::ui_index}
 bind .   <Alt-Key-3> {focus $::ui_diff}
 bind .   <Alt-Key-4> {focus $::ui_comm}

+if {[is_config_true gui.autorescan]} {
+	bind .   <FocusIn>  { if {"%W" eq "."} do_rescan }
+}
+
 set file_lists_last_clicked($ui_index) {}
 set file_lists_last_clicked($ui_workdir) {}

diff --git a/lib/option.tcl b/lib/option.tcl
index e43971b..9e83db7 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -145,6 +145,7 @@ proc do_options {} {
 		{b merge.diffstat {mc "Show Diffstat After Merge"}}
 		{t merge.tool {mc "Use Merge Tool"}}

+		{b gui.autorescan  {mc "Auto-Rescan On Activate"}}
 		{b gui.trustmtime  {mc "Trust File Modification Timestamps"}}
 		{b gui.pruneduringfetch {mc "Prune Tracking Branches During Fetch"}}
 		{b gui.matchtrackingbranch {mc "Match Tracking Branches"}}
--
2.29.2

