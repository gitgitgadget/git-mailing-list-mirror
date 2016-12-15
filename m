Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F870209E6
	for <e@80x24.org>; Thu, 15 Dec 2016 11:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757366AbcLOL3J (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 06:29:09 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34709 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755521AbcLOL3H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 06:29:07 -0500
Received: by mail-pf0-f194.google.com with SMTP id y68so2782316pfb.1
        for <git@vger.kernel.org>; Thu, 15 Dec 2016 03:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1CthZB1/z7Wbg2OOB/dqqZG71eae9q8GeixIIsbe1RE=;
        b=N5/bsaHV92EfaIvcG172kx29rX5wTLDFdK1WQ2ryhlj9WeB6hiVaXGUnOLVETaDW3q
         eXMgbbGwqu4BZn4tz8TXZWb3DLlVthSOpVf/o+UbfIAwhNEVCKs/eaWzTctfYE7KyQHj
         LYjj6H29jK+W9UZ8aSUsfYGsZ40vjOiv/5/Umg4Q9E7zVb5h2gTtVQjrYjOIR3ntrriB
         ESVFdQmBTTIeFProDQL9h90XzF0AQ+L5InA5uBhcVybZqMwt/8vdqIH+A1t7uvgaAepW
         Z51qYxD66mUTQmHMcuGe0u1PZC2g8oods1AjsNMcbIAefzuQ7yw1S9BihMvB9w6Nhpmf
         OhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1CthZB1/z7Wbg2OOB/dqqZG71eae9q8GeixIIsbe1RE=;
        b=PGEbSRvMsqZB2xLw02X/j/gGNOLeJCzB8dR8YWKaHd1QL8D8Emxh8H26pSzdTU5TL+
         YYErDQlS7Pep6qn5NsjcJaDS1r1TwXNh3K8Pj5tvzvb76wjLfmAxaUXgdcYWoCeVojI2
         3SbTC/6WaRJWA1typkjTQj9u3T9Yq6kr35mr9a/Xkg1Hs9yP+yJO0u+NDhHGnqNI+VFo
         4Sgo2gMuwzv8CT7hRdgovMezOyIisjuD7hk2XdX50gUXRJCuydapqj6VQto4Qz/XEhe4
         CE8nTCiTJJ++OQPg9eXtybLP6MAH3iB2IK3ao6hVO4s5eB4pSE1zdNKWF7pzKdDdJaS8
         uO/Q==
X-Gm-Message-State: AKaTC02SzZHiCjr4jqGc3iAXfl9MnNycvyP4gcYweL4HhjO33in2Zt91Gnz7Ncxfd3nJxg==
X-Received: by 10.84.197.165 with SMTP id n34mr1732602pld.34.1481801346785;
        Thu, 15 Dec 2016 03:29:06 -0800 (PST)
Received: from kpdpro.suho.local ([118.211.97.195])
        by smtp.gmail.com with ESMTPSA id 189sm3930190pgh.5.2016.12.15.03.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Dec 2016 03:29:06 -0800 (PST)
From:   Pierre Dumuid <pmdumuid@gmail.com>
To:     paulus@ozlabs.org, git@vger.kernel.org
Cc:     Pierre Dumuid <pmdumuid@gmail.com>,
        Andreas Amann <andreas.amann@web.de>
Subject: [PATCH 5/6] gitk: Add a "Save file as" menu item
Date:   Thu, 15 Dec 2016 21:58:46 +1030
Message-Id: <20161215112847.14719-5-pmdumuid@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161215112847.14719-1-pmdumuid@gmail.com>
References: <20161215112847.14719-1-pmdumuid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, there was no easy way to save a particular file from the
currently selected revision.

This patch adds a menu item "Save file as" to the file list popup
menu, which opens a file selection dialog to determine the name under
which a file should be saved.  The default filename is of the form
"[shortid] basename".  If the current revision is the index, the
default pattern is of the form "[index] basename".  This works for
both, the "Patch" and "Tree" view.  The menu item is disabled for the
"local uncommitted changes" fake revision.

Signed-off-by: Andreas Amann <andreas.amann@web.de>
Signed-off-by: Pierre Dumuid <pmdumuid@gmail.com>
---
 gitk | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/gitk b/gitk
index 5f27716..0903d2d 100755
--- a/gitk
+++ b/gitk
@@ -2693,6 +2693,7 @@ proc makewindow {} {
 	{mc "Highlight this too" command {flist_hl 0}}
 	{mc "Highlight this only" command {flist_hl 1}}
 	{mc "External diff" command {external_diff}}
+	{mc "Save file as" command {save_file_as}}
 	{mc "Blame parent commit" command {external_blame 1}}
 	{mc "Copy path" command {clipboard clear; clipboard append $flist_menu_file}}
     }
@@ -3504,6 +3505,7 @@ proc sel_flist {w x y} {
 proc pop_flist_menu {w X Y x y} {
     global ctext cflist cmitmode flist_menu flist_menu_file
     global treediffs diffids
+    global nullid
 
     stopfinding
     set l [lindex [split [$w index "@$x,$y"] "."] 0]
@@ -3521,6 +3523,12 @@ proc pop_flist_menu {w X Y x y} {
     }
     # Disable "External diff" item in tree mode
     $flist_menu entryconf 2 -state $xdiffstate
+    set savefilestate "normal"
+    if {[lindex $diffids 0] eq $nullid} {
+	set savefilestate "disabled"
+    }
+    # Disable "Save file as" item "local uncommited changes" revision
+    $flist_menu entryconf 3 -state $savefilestate
     tk_popup $flist_menu $X $Y
 }
 
@@ -3632,6 +3640,34 @@ proc external_diff_get_one_file {diffid filename diffdir} {
 	       "revision $diffid"]
 }
 
+proc save_file_as {} {
+    global nullid nullid2
+    global flist_menu_file cmitmode
+    global diffids
+
+    set diffid [lindex $diffids 0]
+    if {$diffid == $nullid} {
+	return
+    } elseif {$diffid == $nullid2} {
+	set diffidtext [mc "index"]
+	set diffid ""
+	set whattext $diffidtext
+    } else {
+	set diffidtext [shortids $diffid]
+	set whattext "[mc "revision"] $diffidtext"
+    }
+    set diffid $diffid:
+    if {$cmitmode eq "tree"} {
+	set diffid $diffid./
+    }
+    set difffile "\[$diffidtext\] [file tail $flist_menu_file]"
+    set difffile [tk_getSaveFile -initialfile $difffile -title [mc "Save file as"] -parent .]
+    if {$difffile eq {}} {
+	return
+    }
+    save_file_from_commit $diffid$flist_menu_file $difffile $whattext
+}
+
 proc external_diff {} {
     global nullid nullid2
     global flist_menu_file
-- 
2.10.2

