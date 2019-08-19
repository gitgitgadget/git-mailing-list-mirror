Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54A8B1F461
	for <e@80x24.org>; Mon, 19 Aug 2019 21:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfHSVlb (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 17:41:31 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:34165 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHSVlb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 17:41:31 -0400
Received: from localhost.localdomain (unknown [1.186.12.8])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id F312D100005;
        Mon, 19 Aug 2019 21:41:28 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] git-gui: Move revert confirmation dialog creation to separate function
Date:   Tue, 20 Aug 2019 03:11:08 +0530
Message-Id: <20190819214110.26461-2-me@yadavpratyush.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819214110.26461-1-me@yadavpratyush.com>
References: <20190819214110.26461-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Upcoming commits will introduce reverting lines and hunks. They also
need to prompt the user for confirmation. Put the dialog creation in its
separate function so the same code won't be repeated again and again.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
 git-gui/lib/index.tcl | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/git-gui/lib/index.tcl b/git-gui/lib/index.tcl
index b588db11d9..cb7f74af45 100644
--- a/git-gui/lib/index.tcl
+++ b/git-gui/lib/index.tcl
@@ -388,6 +388,18 @@ proc do_add_all {} {
 	add_helper [mc "Adding all changed files"] $paths
 }
 
+proc revert_dialog {query} {
+	return [tk_dialog \
+		.confirm_revert \
+		"[appname] ([reponame])" \
+		"$query" \
+		question \
+		1 \
+		[mc "Do Nothing"] \
+		[mc "Revert Changes"] \
+		]
+}
+
 proc revert_helper {txt paths} {
 	global file_states current_diff_path
 
@@ -430,17 +442,12 @@ proc revert_helper {txt paths} {
 		set query [mc "Revert changes in these %i files?" $n]
 	}
 
-	set reply [tk_dialog \
-		.confirm_revert \
-		"[appname] ([reponame])" \
-		"$query
+	set query "$query
+
+[mc "Any unstaged changes will be permanently lost by the revert."]"
+
+	set reply [revert_dialog $query]
 
-[mc "Any unstaged changes will be permanently lost by the revert."]" \
-		question \
-		1 \
-		[mc "Do Nothing"] \
-		[mc "Revert Changes"] \
-		]
 	if {$reply == 1} {
 		checkout_index \
 			$txt \
-- 
2.21.0

