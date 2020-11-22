Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4E8C63697
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 19:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 368632078D
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 19:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgKVTqC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 14:46:02 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:41590 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgKVTqC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 14:46:02 -0500
Received: from client3368.fritz.box (i5C744221.versanet.de [92.116.66.33])
        by dd36226.kasserver.com (Postfix) with ESMTPA id 05E6F3C052C;
        Sun, 22 Nov 2020 20:45:59 +0100 (CET)
From:   Stefan Haller <stefan@haller-berlin.de>
To:     me@yadavpratyush.com
Cc:     git@vger.kernel.org
Subject: [PATCH 1/1] git-gui: fix colored label backgrounds when using themed widgets
Date:   Sun, 22 Nov 2020 20:45:37 +0100
Message-Id: <20201122194537.41870-2-stefan@haller-berlin.de>
X-Mailer: git-send-email 2.29.0.18.gf8c967e53c
In-Reply-To: <20201122194537.41870-1-stefan@haller-berlin.de>
References: <20201122194537.41870-1-stefan@haller-berlin.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The aqua theme on Mac doesn't support changing the background color for labels
and frames [1]. Since the red, green, and yellow backgrounds of the labels for
unstaged and staged files and the diff pane are so important design elements of
git gui's main window, it's not acceptable for them to have grey backgrounds on
Mac.

To work around this, simply use non-themed widgets for all labels on Mac. This
is not a big problem because labels don't look extremely different between the
themed and non-themed versions. There are subtle differences, but they are not
as bad as having the wrong background color.

[1] https://stackoverflow.com/a/6723911

Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
---
 lib/themed.tcl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/themed.tcl b/lib/themed.tcl
index 83e3ac7..02aae90 100644
--- a/lib/themed.tcl
+++ b/lib/themed.tcl
@@ -174,7 +174,7 @@ proc InitEntryFrame {} {

 proc gold_frame {w args} {
 	global use_ttk
-	if {$use_ttk} {
+	if {$use_ttk && ![is_MacOSX]} {
 		eval [linsert $args 0 ttk::frame $w -style Gold.TFrame]
 	} else {
 		eval [linsert $args 0 frame $w -background gold]
@@ -183,7 +183,7 @@ proc gold_frame {w args} {

 proc tlabel {w args} {
 	global use_ttk
-	if {$use_ttk} {
+	if {$use_ttk && ![is_MacOSX]} {
 		set cmd [list ttk::label $w -style Color.TLabel]
 		foreach {k v} $args {
 			switch -glob -- $k {
--
2.29.0.18.gf8c967e53c

