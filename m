Return-Path: <SRS0=iV/m=CA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D37AC433DF
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 10:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BD352067C
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 10:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFJ4m146"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgHVK4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Aug 2020 06:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgHVK4p (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Aug 2020 06:56:45 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CEEC061573
        for <git@vger.kernel.org>; Sat, 22 Aug 2020 03:56:44 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a15so4142202wrh.10
        for <git@vger.kernel.org>; Sat, 22 Aug 2020 03:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nz+ZiFM4n8u+ntbTXOr+ZETpgXoD/6Fu8F3Nu3rhM3E=;
        b=WFJ4m146uwa7FzSm2jhqT79g8wu4hHJ1RB8cw9v8tLA1C8NiriuYWtcyuOUbNbHlEq
         pURAKnKp0menFHabdglovUWT6rNOYXytNA/IvyiOYTjBJyrM9mXBj97V0zkKoEs9sRzM
         rSVsRvgEwf661H7MXHOnOrjSfXJDxI2Y04/Z3w0m1C4O2YlPQeek9ExJiZ51IbQLby3o
         HyRYJfcG94cYglf9DwrN6z/KaQISkpoBb+e6Ua6ECMCyTWQ5DDN4VElsalwW4DR++d7G
         sFaKNnab2WW1Bsyo2dMFF6eG/f5Uy4lrJ5YsANj9HsLO2ri9KshmFBGZ4JyEkrGAUW2P
         vdog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nz+ZiFM4n8u+ntbTXOr+ZETpgXoD/6Fu8F3Nu3rhM3E=;
        b=JK9Tj4oggJ9f4gnMZjgo2yw0GnaR5Koe9W2M0bdUFqgi/0NJlOlDCiJn+0cIRmqMGz
         zfddRw3K1Hic8o22qpGENdoHw3nfr67712Ykn18axb0MtazjOrK1tswFBPgq+Qtymtre
         APDg+jxTX62DiceokyRflCkihd05OG4sBppPVymHXQw83m2tJPQ3UrRyYE23/7ASrzL2
         jaqJseSxYLVzwYzqf5a1i7//1nQICIAiqZFmidFkFcx2WFNl7TXI64MTTu/RO9ALxE69
         NNlVmbH/jKgcxa7g7qiwWxqYjrOMbMTnDDmD5E9GmGz0s2GxYd4k5BEvdlvrn3eAk34F
         zE2g==
X-Gm-Message-State: AOAM531Y5YFykdERURFhup9umf8ADuE87ngMcR6kXkcV0UPHKbTp5/Yr
        5vC3K2uwE6BDO9LflAZWpiS0GlXwKZfzDg==
X-Google-Smtp-Source: ABdhPJzB786rG03HIWa4ZFJ9xkcJBG2xUruSIiCx2cgbIYPNFMiJhfOPZ3sDrqwD9z5VP85xrQIMZA==
X-Received: by 2002:adf:e84d:: with SMTP id d13mr6517353wrn.126.1598093801729;
        Sat, 22 Aug 2020 03:56:41 -0700 (PDT)
Received: from partizan.lan ([46.98.122.115])
        by smtp.gmail.com with ESMTPSA id b203sm12746636wmc.22.2020.08.22.03.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 03:56:40 -0700 (PDT)
From:   Serg Tereshchenko <serg.partizan@gmail.com>
To:     git@vger.kernel.org
Cc:     Serg Tereshchenko <serg.partizan@gmail.com>
Subject: style(git-gui): Fix mixed tabs & spaces; Always use tabs.
Date:   Sat, 22 Aug 2020 13:56:16 +0300
Message-Id: <20200822105616.68296-1-serg.partizan@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello.

I want to improve styling of git-citool, so it supports dark themes.
But first i want to remove "mixed indent warning" from my editor
modeline.

This patch does not change anything besides indents, and sometimes i
replace

```tcl
if {long ||
    multiline ||
    statement}
```

with more readable

```tcl
if {
    long
    || multiline
    || statement
}
```
But only in lines with mixed indents.


To clearly see changes in this patch, instruct your editor to display
tabs.
I use this in vim:

```vim
set list
set listchars=eol:¬,tab:\ \ ┊,trail:·,nbsp:⎵
```


Btw, at the start of git-gui.sh there is sanity check requiring Tcl 8.5.
And somewhere later legacy code for 8.4.

I would like to clean it up. Should i do this or better leave it as it
is?


diff --git a/git-gui.sh b/git-gui.sh
index 49bd86e..ca66a8e 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1,13 +1,10 @@
 #!/bin/sh
 # Tcl ignores the next line -*- tcl -*- \
- if test "z$*" = zversion \
- || test "z$*" = z--version; \
- then \
-	echo 'git-gui version @@GITGUI_VERSION@@'; \
-	exit; \
- fi; \
- argv0=$0; \
- exec wish "$argv0" -- "$@"
+if test "z$*" = zversion || test "z$*" = z--version; \
+	then echo 'git-gui version @@GITGUI_VERSION@@'; exit; \
+fi; \
+argv0=$0; \
+exec wish "$argv0" -- "$@"
 
 set appvers {@@GITGUI_VERSION@@}
 set copyright [string map [list (c) \u00a9] {
@@ -31,7 +28,7 @@ along with this program; if not, see <http://www.gnu.org/licenses/>.}]
 ## Tcl/Tk sanity check
 
 if {[catch {package require Tcl 8.5} err]
- || [catch {package require Tk  8.5} err]
+	|| [catch {package require Tk  8.5} err]
 } {
 	catch {wm withdraw .}
 	tk_messageBox \
@@ -404,9 +401,9 @@ proc _git_cmd {name} {
 
 	if {[catch {set v $_git_cmd_path($name)}]} {
 		switch -- $name {
-		  version   -
-		--version   -
-		--exec-path { return [list $::_git $name] }
+			version     -
+			--version   -
+			--exec-path { return [list $::_git $name] }
 		}
 
 		set p [gitexec git-$name$::_search_exe]
@@ -548,9 +545,10 @@ proc _open_stdout_stderr {cmd} {
 	if {[catch {
 			set fd [open [concat [list | ] $cmd] r]
 		} err]} {
-		if {   [lindex $cmd end] eq {2>@1}
-		    && $err eq {can not find channel named "1"}
-			} {
+		if {
+			[lindex $cmd end] eq {2>@1}
+			&& $err eq {can not find channel named "1"}
+		} {
 			# Older versions of Tcl 8.4 don't have this 2>@1 IO
 			# redirect operator.  Fallback to |& cat for those.
 			# The command was not actually started, so its safe
@@ -947,15 +945,15 @@ if {![regsub {^git version } $_git_version {} _git_version]} {
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
@@ -967,7 +965,7 @@ if {![regexp {^[1-9]+(\.[0-9]+)+$} $_git_version]} {
 		-type yesno \
 		-default no \
 		-title "[appname]: warning" \
-		 -message [mc "Git version cannot be determined.
+		-message [mc "Git version cannot be determined.
 
 %s claims it is version '%s'.
 
@@ -975,7 +973,7 @@ if {![regexp {^[1-9]+(\.[0-9]+)+$} $_git_version]} {
 
 Assume '%s' is version 1.5.0?
 " $_git $_real_git_version [appname] $_real_git_version]] eq {yes}} {
-		set _git_version 1.5.0
+	set _git_version 1.5.0
 	} else {
 		exit 1
 	}
@@ -1181,44 +1179,44 @@ enable_option transport
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
+			set argv [lrange $argv 1 end]
 		}
-		--nocommit {
-			enable_option nocommit
-			enable_option nocommitmsg
-		}
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
@@ -1237,15 +1235,15 @@ if {![info exists env(SSH_ASKPASS)]} {
 
 set picked 0
 if {[catch {
-		set _gitdir $env(GIT_DIR)
-		set _prefix {}
-		}]
-	&& [catch {
-		# beware that from the .git dir this sets _gitdir to .
-		# and _prefix to the empty string
-		set _gitdir [git rev-parse --git-dir]
-		set _prefix [git rev-parse --show-prefix]
-	} err]} {
+	set _gitdir $env(GIT_DIR)
+	set _prefix {}
+}]
+&& [catch {
+	# beware that from the .git dir this sets _gitdir to .
+	# and _prefix to the empty string
+	set _gitdir [git rev-parse --git-dir]
+	set _prefix [git rev-parse --show-prefix]
+} err]} {
 	load_config 1
 	apply_config
 	choose_repository::pick
@@ -1653,7 +1651,7 @@ proc prepare_commit_msg_hook_wait {fd_ph} {
 		set pch_error {}
 		catch {file delete [gitdir PREPARE_COMMIT_MSG]}
 		return
-        }
+	}
 	fconfigure $fd_ph -blocking 0
 	catch {file delete [gitdir PREPARE_COMMIT_MSG]}
 }
@@ -2001,72 +1999,72 @@ set filemask {
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
@@ -2088,36 +2086,36 @@ set all_icons(T$ui_workdir) file_statechange
 
 set max_status_desc 0
 foreach i {
-		{__ {mc "Unmodified"}}
-
-		{_M {mc "Modified, not staged"}}
-		{M_ {mc "Staged for commit"}}
-		{MM {mc "Portions staged for commit"}}
-		{MD {mc "Staged for commit, missing"}}
-
-		{_T {mc "File type changed, not staged"}}
-		{MT {mc "File type changed, old type staged for commit"}}
-		{AT {mc "File type changed, old type staged for commit"}}
-		{T_ {mc "File type changed, staged"}}
-		{TM {mc "File type change staged, modification not staged"}}
-		{TD {mc "File type change staged, file missing"}}
-
-		{_O {mc "Untracked, not staged"}}
-		{A_ {mc "Staged for commit"}}
-		{AM {mc "Portions staged for commit"}}
-		{AD {mc "Staged for commit, missing"}}
-
-		{_D {mc "Missing"}}
-		{D_ {mc "Staged for removal"}}
-		{DO {mc "Staged for removal, still present"}}
-
-		{_U {mc "Requires merge resolution"}}
-		{U_ {mc "Requires merge resolution"}}
-		{UU {mc "Requires merge resolution"}}
-		{UM {mc "Requires merge resolution"}}
-		{UD {mc "Requires merge resolution"}}
-		{UT {mc "Requires merge resolution"}}
-	} {
+	{__ {mc "Unmodified"}}
+
+	{_M {mc "Modified, not staged"}}
+	{M_ {mc "Staged for commit"}}
+	{MM {mc "Portions staged for commit"}}
+	{MD {mc "Staged for commit, missing"}}
+
+	{_T {mc "File type changed, not staged"}}
+	{MT {mc "File type changed, old type staged for commit"}}
+	{AT {mc "File type changed, old type staged for commit"}}
+	{T_ {mc "File type changed, staged"}}
+	{TM {mc "File type change staged, modification not staged"}}
+	{TD {mc "File type change staged, file missing"}}
+
+	{_O {mc "Untracked, not staged"}}
+	{A_ {mc "Staged for commit"}}
+	{AM {mc "Portions staged for commit"}}
+	{AD {mc "Staged for commit, missing"}}
+
+	{_D {mc "Missing"}}
+	{D_ {mc "Staged for removal"}}
+	{DO {mc "Staged for removal, still present"}}
+
+	{_U {mc "Requires merge resolution"}}
+	{U_ {mc "Requires merge resolution"}}
+	{UU {mc "Requires merge resolution"}}
+	{UM {mc "Requires merge resolution"}}
+	{UD {mc "Requires merge resolution"}}
+	{UT {mc "Requires merge resolution"}}
+} {
 	set text [eval [lindex $i 1]]
 	if {$max_status_desc < [string length $text]} {
 		set max_status_desc [string length $text]
@@ -2475,8 +2473,10 @@ proc next_diff_after_action {w path {lno {}} {mmask {}}} {
 proc select_first_diff {after} {
 	global ui_workdir
 
-	if {[find_next_diff $ui_workdir {} 1 {^_?U}] ||
-	    [find_next_diff $ui_workdir {} 1 {[^O]$}]} {
+	if {
+		[find_next_diff $ui_workdir {} 1 {^_?U}]
+		|| [find_next_diff $ui_workdir {} 1 {[^O]$}]
+	} {
 		next_diff $after
 	} else {
 		uplevel #0 $after
@@ -3111,8 +3111,11 @@ proc normalize_relpath {path} {
 	set elements {}
 	foreach item [file split $path] {
 		if {$item eq {.}} continue
-		if {$item eq {..} && [llength $elements] > 0
-		    && [lindex $elements end] ne {..}} {
+		if {
+			$item eq {..}
+			&& [llength $elements] > 0
+			&& [lindex $elements end] ne {..}
+		} {
 			set elements [lrange $elements 0 end-1]
 			continue
 		}
@@ -3878,18 +3881,18 @@ proc on_application_mapped {} {
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
@@ -4145,8 +4148,10 @@ if {[winfo exists $ui_comm]} {
 	lappend spell_cmd --mode=none
 	lappend spell_cmd --encoding=utf-8
 	lappend spell_cmd pipe
-	if {$spell_dict eq {none}
-	 || [catch {set spell_fd [open $spell_cmd r+]} spell_err]} {
+	if {
+		$spell_dict eq {none}
+		|| [catch {set spell_fd [open $spell_cmd r+]} spell_err]
+	} {
 		bind_button3 $ui_comm [list tk_popup $ui_comm_ctxm %X %Y]
 	} else {
 		set ui_comm_spell [spellcheck::init \
