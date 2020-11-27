Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C98CC2D0E4
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 15:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29DFA221EB
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 15:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbgK0PAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Nov 2020 10:00:00 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:57885 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731015AbgK0O76 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Nov 2020 09:59:58 -0500
X-Originating-IP: 103.82.80.46
Received: from localhost.localdomain (unknown [103.82.80.46])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 0DBBEC0008;
        Fri, 27 Nov 2020 14:59:55 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20Sch=C3=B6n?= 
        <Martin.Schoen@loewensteinmedical.de>
Subject: [PATCH v2 2/2] git-gui: use commit message template
Date:   Fri, 27 Nov 2020 20:29:27 +0530
Message-Id: <20201127145927.26222-3-me@yadavpratyush.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127145927.26222-1-me@yadavpratyush.com>
References: <20201127145927.26222-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Schön <Martin.Schoen@loewensteinmedical.de>

Use the file described by commit.template (if set) to show the commit message
template, just like other GUIs.

Signed-off-by: Martin Schön <Martin.Schoen@loewensteinmedical.de>
Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
 git-gui.sh     | 7 +++++++
 lib/commit.tcl | 1 +
 2 files changed, 8 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index 8ee67e6..cc6c2aa 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1482,6 +1482,7 @@ proc rescan {after {honor_trustmtime 1}} {
 		} elseif {[run_prepare_commit_msg_hook]} {
 		} elseif {[load_message MERGE_MSG]} {
 		} elseif {[load_message SQUASH_MSG]} {
+		} elseif {[load_message [get_config commit.template]]} {
 		}
 		$ui_comm edit reset
 		$ui_comm edit modified false
@@ -1616,6 +1617,12 @@ proc run_prepare_commit_msg_hook {} {
 		fconfigure $fd_sm -encoding utf-8
 		puts -nonewline $fd_pcm [read $fd_sm]
 		close $fd_sm
+	} elseif {[file isfile [get_config commit.template]]} {
+		set pcm_source "template"
+		set fd_sm [open [get_config commit.template] r]
+		fconfigure $fd_sm -encoding utf-8
+		puts -nonewline $fd_pcm [read $fd_sm]
+		close $fd_sm
 	} else {
 		set pcm_source ""
 	}
diff --git a/lib/commit.tcl b/lib/commit.tcl
index b516aa2..11379f8 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -456,6 +456,7 @@ A rescan will be automatically started now.
 	}
 
 	$ui_comm delete 0.0 end
+	load_message [get_config commit.template]
 	$ui_comm edit reset
 	$ui_comm edit modified false
 	if {$::GITGUI_BCK_exists} {
-- 
2.29.2

