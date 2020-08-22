Return-Path: <SRS0=iV/m=CA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D1AC433DF
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 22:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B80206B5
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 22:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTiMtvU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgHVWZV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Aug 2020 18:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgHVWZV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Aug 2020 18:25:21 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5071C061573
        for <git@vger.kernel.org>; Sat, 22 Aug 2020 15:25:20 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v12so5621303ljc.10
        for <git@vger.kernel.org>; Sat, 22 Aug 2020 15:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bv4RMkwcOlZpej2hktFe6El7FFPnyTv09yTKDaM5GVc=;
        b=bTiMtvU7qjZ/CLaJ+vCfFGnCiTzvmHzrgFtWwnm6G8fDtxSIV7G7Mc65FDaUtVMBLE
         onH46MINCD15bTuiLkNDoK9GkZFJqLPtZVrQ6Zx9QIyU3AdmO72uztjTcyEOyIpZpSAP
         wNnVQaZKuMjVvkM6sULZT6eQ+4PTVGnlePYareIiH+VV9dgzQYhC4THBBXo0adAnhnDa
         ZcfGWj5hC9K4WywvPOUWIDg6kpR8qLk+aBvbTTmOEJnoP3h5X1sSvg4Zbsbox6cS2tkK
         CCs70qv+/tZiLetAH/FE/1Jc9goo4IHMpPhnHlaHkLa0PK7VCtaP4TNyRhZPWDSe2BYn
         +a/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bv4RMkwcOlZpej2hktFe6El7FFPnyTv09yTKDaM5GVc=;
        b=YHLk2Tr1O+aTh4FxaaMfOD7zeHXUdDOVUyyA3/vykalzDSv8gRJlJuIaJF2/Wk+DcV
         Q58qIx7eu97i893nHw+qwXcgN5+x+f2pETQs2cv6K4pJ7rolq0xHJOb/XTWwr4AXyzuy
         hIQr0kiLZqrbbnnl9fa/5TqrWNdCmT6HV2ZJ1ELi8Z5zLf43gTQchGjx8Li+x9f9HORc
         H3t0GWTcnzIXbylUZtHOUfJPGQhamMYoPvx/GlBOR+IdCv099QFUsGmd3A5x++biRz2p
         bHEfW3CzzPLSechjXTgSRRZ9NwJyoayzRmpk+nj44l+Ev9eSenaq0jMqz3FSkTCDggkY
         +0Mw==
X-Gm-Message-State: AOAM531fJZOTjOo1NBTOB/6nkhAlkBm5rU53olmkIZCd1Xi5XvsVjw1s
        Z0//tYdBtci2I3k2jBRu1NrcbY30BYpqTg==
X-Google-Smtp-Source: ABdhPJz04uw6r3wz02fs3DdUtvaUXYxx2AjL4gMwbD/tKiIxXTkTbHWq9fUoBHYRsmdwxjMAvlFcog==
X-Received: by 2002:a05:651c:3cd:: with SMTP id f13mr4669751ljp.207.1598135118861;
        Sat, 22 Aug 2020 15:25:18 -0700 (PDT)
Received: from localhost.localdomain ([46.98.122.26])
        by smtp.gmail.com with ESMTPSA id m15sm1215857ljh.62.2020.08.22.15.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 15:25:18 -0700 (PDT)
From:   Serg Tereshchenko <serg.partizan@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Serg Tereshchenko <serg.partizan@gmail.com>
Subject: [PATCH v2] style(git-gui): Fix mixed tabs & spaces; Prefer tabs.
Date:   Sun, 23 Aug 2020 01:24:31 +0300
Message-Id: <20200822222431.35027-1-serg.partizan@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <xmqq7dtq7a7w.fsf@gitster.c.googlers.com>
References: <xmqq7dtq7a7w.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is cleaned up version of the patch.

Spaces replaced with tabs when possible. In some cases just replacing
spaces with tabs would break readability, so it was left as it is.

Signed-off-by: Serg Tereshchenko <serg.partizan@gmail.com>
---
 git-gui.sh | 154 ++++++++++++++++++++++++++---------------------------
 1 file changed, 77 insertions(+), 77 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 49bd86e..847c3c9 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -947,15 +947,15 @@ if {![regsub {^git version } $_git_version {} _git_version]} {
 }
 
 proc get_trimmed_version {s} {
-    set r {}
-    foreach x [split $s -._] {
-        if {[string is integer -strict $x]} {
-            lappend r $x
-        } else {
-            break
-        }
-    }
-    return [join $r .]
+	set r {}
+	foreach x [split $s -._] {
+		if {[string is integer -strict $x]} {
+			lappend r $x
+		} else {
+			break
+		}
+	}
+	return [join $r .]
 }
 set _real_git_version $_git_version
 set _git_version [get_trimmed_version $_git_version]
@@ -967,7 +967,7 @@ if {![regexp {^[1-9]+(\.[0-9]+)+$} $_git_version]} {
 		-type yesno \
 		-default no \
 		-title "[appname]: warning" \
-		 -message [mc "Git version cannot be determined.
+		-message [mc "Git version cannot be determined.
 
 %s claims it is version '%s'.
 
@@ -1181,44 +1181,44 @@ enable_option transport
 disable_option bare
 
 switch -- $subcommand {
-browser -
-blame {
-	enable_option bare
-
-	disable_option multicommit
-	disable_option branch
-	disable_option transport
-}
-citool {
-	enable_option singlecommit
-	enable_option retcode
-
-	disable_option multicommit
-	disable_option branch
-	disable_option transport
+	browser -
+	blame {
+		enable_option bare
+
+		disable_option multicommit
+		disable_option branch
+		disable_option transport
+	}
+	citool {
+		enable_option singlecommit
+		enable_option retcode
+
+		disable_option multicommit
+		disable_option branch
+		disable_option transport
+
+		while {[llength $argv] > 0} {
+			set a [lindex $argv 0]
+			switch -- $a {
+				--amend {
+					enable_option initialamend
+				}
+				--nocommit {
+					enable_option nocommit
+					enable_option nocommitmsg
+				}
+				--commitmsg {
+					disable_option nocommitmsg
+				}
+				default {
+					break
+				}
+			}
 
-	while {[llength $argv] > 0} {
-		set a [lindex $argv 0]
-		switch -- $a {
-		--amend {
-			enable_option initialamend
-		}
-		--nocommit {
-			enable_option nocommit
-			enable_option nocommitmsg
+			set argv [lrange $argv 1 end]
 		}
-		--commitmsg {
-			disable_option nocommitmsg
-		}
-		default {
-			break
-		}
-		}
-
-		set argv [lrange $argv 1 end]
 	}
 }
-}
 
 ######################################################################
 ##
@@ -1653,7 +1653,7 @@ proc prepare_commit_msg_hook_wait {fd_ph} {
 		set pch_error {}
 		catch {file delete [gitdir PREPARE_COMMIT_MSG]}
 		return
-        }
+	}
 	fconfigure $fd_ph -blocking 0
 	catch {file delete [gitdir PREPARE_COMMIT_MSG]}
 }
@@ -2001,72 +2001,72 @@ set filemask {
 #define mask_width 14
 #define mask_height 15
 static unsigned char mask_bits[] = {
-   0xfe, 0x1f, 0xfe, 0x1f, 0xfe, 0x1f, 0xfe, 0x1f, 0xfe, 0x1f, 0xfe, 0x1f,
-   0xfe, 0x1f, 0xfe, 0x1f, 0xfe, 0x1f, 0xfe, 0x1f, 0xfe, 0x1f, 0xfe, 0x1f,
-   0xfe, 0x1f, 0xfe, 0x1f, 0xfe, 0x1f};
+	0xfe, 0x1f, 0xfe, 0x1f, 0xfe, 0x1f, 0xfe, 0x1f, 0xfe, 0x1f, 0xfe, 0x1f,
+	0xfe, 0x1f, 0xfe, 0x1f, 0xfe, 0x1f, 0xfe, 0x1f, 0xfe, 0x1f, 0xfe, 0x1f,
+	0xfe, 0x1f, 0xfe, 0x1f, 0xfe, 0x1f};
 }
 
 image create bitmap file_plain -background white -foreground black -data {
 #define plain_width 14
 #define plain_height 15
 static unsigned char plain_bits[] = {
-   0xfe, 0x01, 0x02, 0x03, 0x02, 0x05, 0x02, 0x09, 0x02, 0x1f, 0x02, 0x10,
-   0x02, 0x10, 0x02, 0x10, 0x02, 0x10, 0x02, 0x10, 0x02, 0x10, 0x02, 0x10,
-   0x02, 0x10, 0x02, 0x10, 0xfe, 0x1f};
+	0xfe, 0x01, 0x02, 0x03, 0x02, 0x05, 0x02, 0x09, 0x02, 0x1f, 0x02, 0x10,
+	0x02, 0x10, 0x02, 0x10, 0x02, 0x10, 0x02, 0x10, 0x02, 0x10, 0x02, 0x10,
+	0x02, 0x10, 0x02, 0x10, 0xfe, 0x1f};
 } -maskdata $filemask
 
 image create bitmap file_mod -background white -foreground blue -data {
 #define mod_width 14
 #define mod_height 15
 static unsigned char mod_bits[] = {
-   0xfe, 0x01, 0x02, 0x03, 0x7a, 0x05, 0x02, 0x09, 0x7a, 0x1f, 0x02, 0x10,
-   0xfa, 0x17, 0x02, 0x10, 0xfa, 0x17, 0x02, 0x10, 0xfa, 0x17, 0x02, 0x10,
-   0xfa, 0x17, 0x02, 0x10, 0xfe, 0x1f};
+	0xfe, 0x01, 0x02, 0x03, 0x7a, 0x05, 0x02, 0x09, 0x7a, 0x1f, 0x02, 0x10,
+	0xfa, 0x17, 0x02, 0x10, 0xfa, 0x17, 0x02, 0x10, 0xfa, 0x17, 0x02, 0x10,
+	0xfa, 0x17, 0x02, 0x10, 0xfe, 0x1f};
 } -maskdata $filemask
 
 image create bitmap file_fulltick -background white -foreground "#007000" -data {
 #define file_fulltick_width 14
 #define file_fulltick_height 15
 static unsigned char file_fulltick_bits[] = {
-   0xfe, 0x01, 0x02, 0x1a, 0x02, 0x0c, 0x02, 0x0c, 0x02, 0x16, 0x02, 0x16,
-   0x02, 0x13, 0x00, 0x13, 0x86, 0x11, 0x8c, 0x11, 0xd8, 0x10, 0xf2, 0x10,
-   0x62, 0x10, 0x02, 0x10, 0xfe, 0x1f};
+	0xfe, 0x01, 0x02, 0x1a, 0x02, 0x0c, 0x02, 0x0c, 0x02, 0x16, 0x02, 0x16,
+	0x02, 0x13, 0x00, 0x13, 0x86, 0x11, 0x8c, 0x11, 0xd8, 0x10, 0xf2, 0x10,
+	0x62, 0x10, 0x02, 0x10, 0xfe, 0x1f};
 } -maskdata $filemask
 
 image create bitmap file_question -background white -foreground black -data {
 #define file_question_width 14
 #define file_question_height 15
 static unsigned char file_question_bits[] = {
-   0xfe, 0x01, 0x02, 0x02, 0xe2, 0x04, 0xf2, 0x09, 0x1a, 0x1b, 0x0a, 0x13,
-   0x82, 0x11, 0xc2, 0x10, 0x62, 0x10, 0x62, 0x10, 0x02, 0x10, 0x62, 0x10,
-   0x62, 0x10, 0x02, 0x10, 0xfe, 0x1f};
+	0xfe, 0x01, 0x02, 0x02, 0xe2, 0x04, 0xf2, 0x09, 0x1a, 0x1b, 0x0a, 0x13,
+	0x82, 0x11, 0xc2, 0x10, 0x62, 0x10, 0x62, 0x10, 0x02, 0x10, 0x62, 0x10,
+	0x62, 0x10, 0x02, 0x10, 0xfe, 0x1f};
 } -maskdata $filemask
 
 image create bitmap file_removed -background white -foreground red -data {
 #define file_removed_width 14
 #define file_removed_height 15
 static unsigned char file_removed_bits[] = {
-   0xfe, 0x01, 0x02, 0x03, 0x02, 0x05, 0x02, 0x09, 0x02, 0x1f, 0x02, 0x10,
-   0x1a, 0x16, 0x32, 0x13, 0xe2, 0x11, 0xc2, 0x10, 0xe2, 0x11, 0x32, 0x13,
-   0x1a, 0x16, 0x02, 0x10, 0xfe, 0x1f};
+	0xfe, 0x01, 0x02, 0x03, 0x02, 0x05, 0x02, 0x09, 0x02, 0x1f, 0x02, 0x10,
+	0x1a, 0x16, 0x32, 0x13, 0xe2, 0x11, 0xc2, 0x10, 0xe2, 0x11, 0x32, 0x13,
+	0x1a, 0x16, 0x02, 0x10, 0xfe, 0x1f};
 } -maskdata $filemask
 
 image create bitmap file_merge -background white -foreground blue -data {
 #define file_merge_width 14
 #define file_merge_height 15
 static unsigned char file_merge_bits[] = {
-   0xfe, 0x01, 0x02, 0x03, 0x62, 0x05, 0x62, 0x09, 0x62, 0x1f, 0x62, 0x10,
-   0xfa, 0x11, 0xf2, 0x10, 0x62, 0x10, 0x02, 0x10, 0xfa, 0x17, 0x02, 0x10,
-   0xfa, 0x17, 0x02, 0x10, 0xfe, 0x1f};
+	0xfe, 0x01, 0x02, 0x03, 0x62, 0x05, 0x62, 0x09, 0x62, 0x1f, 0x62, 0x10,
+	0xfa, 0x11, 0xf2, 0x10, 0x62, 0x10, 0x02, 0x10, 0xfa, 0x17, 0x02, 0x10,
+	0xfa, 0x17, 0x02, 0x10, 0xfe, 0x1f};
 } -maskdata $filemask
 
 image create bitmap file_statechange -background white -foreground green -data {
 #define file_statechange_width 14
 #define file_statechange_height 15
 static unsigned char file_statechange_bits[] = {
-   0xfe, 0x01, 0x02, 0x03, 0x02, 0x05, 0x02, 0x09, 0x02, 0x1f, 0x62, 0x10,
-   0x62, 0x10, 0xba, 0x11, 0xba, 0x11, 0x62, 0x10, 0x62, 0x10, 0x02, 0x10,
-   0x02, 0x10, 0x02, 0x10, 0xfe, 0x1f};
+	0xfe, 0x01, 0x02, 0x03, 0x02, 0x05, 0x02, 0x09, 0x02, 0x1f, 0x62, 0x10,
+	0x62, 0x10, 0xba, 0x11, 0xba, 0x11, 0x62, 0x10, 0x62, 0x10, 0x02, 0x10,
+	0x02, 0x10, 0x02, 0x10, 0xfe, 0x1f};
 } -maskdata $filemask
 
 set ui_index .vpane.files.index.list
@@ -3878,18 +3878,18 @@ proc on_application_mapped {} {
 	set gm $repo_config(gui.geometry)
 	if {$use_ttk} {
 		bind .vpane <Map> \
-		    [list on_ttk_pane_mapped %W 0 [lindex $gm 1]]
+			[list on_ttk_pane_mapped %W 0 [lindex $gm 1]]
 		bind .vpane.files <Map> \
-		    [list on_ttk_pane_mapped %W 0 [lindex $gm 2]]
+			[list on_ttk_pane_mapped %W 0 [lindex $gm 2]]
 	} else {
 		bind .vpane <Map> \
-		    [list on_tk_pane_mapped %W 0 \
-			 [lindex $gm 1] \
-			 [lindex [.vpane sash coord 0] 1]]
+			[list on_tk_pane_mapped %W 0 \
+			[lindex $gm 1] \
+			[lindex [.vpane sash coord 0] 1]]
 		bind .vpane.files <Map> \
-		    [list on_tk_pane_mapped %W 0 \
-			 [lindex [.vpane.files sash coord 0] 0] \
-			 [lindex $gm 2]]
+			[list on_tk_pane_mapped %W 0 \
+			[lindex [.vpane.files sash coord 0] 0] \
+			[lindex $gm 2]]
 	}
 	wm geometry . [lindex $gm 0]
 }
-- 
2.28.0

