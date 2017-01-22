Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BD9A20A17
	for <e@80x24.org>; Sun, 22 Jan 2017 19:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751581AbdAVTxS (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 14:53:18 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:25022 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbdAVTxK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 14:53:10 -0500
Received: from localhost.localdomain ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id VOCIcRFMZHGLwVOCLca3TW; Sun, 22 Jan 2017 19:53:09 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=xtxXYLxNAAAA:8 a=i_KNsj1ChjcTQNpJ6ZwA:9
 a=xts0dhWdiJbonKbuqhAr:22
From:   Philip Oakley <philipoakley@iee.org>
To:     GitList <git@vger.kernel.org>
Cc:     Self <philipoakley@iee.org>
Subject: [PATCH v3 4/4] git gui: allow for a long recentrepo list
Date:   Sun, 22 Jan 2017 19:53:01 +0000
Message-Id: <20170122195301.1784-5-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1.323.g0305acf
In-Reply-To: <20170122195301.1784-1-philipoakley@iee.org>
References: <20170122195301.1784-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfIyb42WxosabUrMQ8QqD3viNe5kuTWnxpLIfT6/7mzi4Z1oUfYImx9gwaepjWkI4nsHvIr02a3NxbgWHWpkiKT4fN8UHPW6cgYMk6mG3ia3lbUxLL6xE
 RMvmICa0lLZfPGu7qziNLQOHX38hwB3vhKVH3IvkfQclKdWouJc2wMz25iL7neKbT5t1tZmYViqcYvQqtGMnFod39kUnEKwcAmI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The gui.recentrepo list may be longer than the maxrecent setting.
Allow extra space to show any extra entries.

In an ideal world, the git gui would limit the number of entries
to the maxrecent setting, however the recentrepo config list may
have been extended outwith the gui, or the maxrecent setting changed
to a reduced value. Further, when testing the gui's recentrepo
logic it is useful to show these extra, but valid, entries.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 lib/choose_repository.tcl | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
index f39636f..80f5a59 100644
--- a/lib/choose_repository.tcl
+++ b/lib/choose_repository.tcl
@@ -142,6 +142,10 @@ constructor pick {} {
 				-label [mc "Recent Repositories"]
 		}
 
+	if {[set lenrecent [llength $sorted_recent]] < $maxrecent} {
+		set lenrecent $maxrecent
+	}
+
 		${NS}::label $w_body.space
 		${NS}::label $w_body.recentlabel \
 			-anchor w \
@@ -153,7 +157,7 @@ constructor pick {} {
 			-background [get_bg_color $w_body.recentlabel] \
 			-wrap none \
 			-width 50 \
-			-height $maxrecent
+			-height $lenrecent
 		$w_recentlist tag conf link \
 			-foreground blue \
 			-underline 1
-- 
2.9.0.windows.1.323.g0305acf

