Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6C4EB64DA
	for <git@archiver.kernel.org>; Sat, 24 Jun 2023 21:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjFXVX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jun 2023 17:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjFXVXx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2023 17:23:53 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E6D171D
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 14:23:51 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3f9b1f43bd0so22896791cf.0
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687641830; x=1690233830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03BNQwcz7B7CGRfg2t5OFWXcKjWhOsqvNXZYDecOYiI=;
        b=fRc9WR65y5PC92o6Vj7U4SJTdKfF2QlbEw3pQeMXpM2dirSofET/6xIdXI6u+9uyGj
         UpKl1a7SZgoHFS01Ap+dUPIfgbb+IehBc1H8MfTNTODemZuQv3yLg2gkh+xviRnv+J/B
         uwZ/IJYz/cSu4TRiCx8+kGIj8/j/pgZS+98O08FA3GV3MtqXDQ+7K5sf9nseJoklvM8K
         i1uvbivW46wTz28R6plRsPe4AUQJkGo8q3fv97AUvqD8MnpVz8FoohsrUw7lhqGC9iCG
         4UCb/93zcdwppBuz2szTmsi4PtnjvEaKMZzbw5+gpLARPqKXYzcbKYW9b5PCPiEohF+9
         Q8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687641830; x=1690233830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03BNQwcz7B7CGRfg2t5OFWXcKjWhOsqvNXZYDecOYiI=;
        b=HEHkIHEeGrijc3XK0JRjtnDtcs3tiMOMx9Fzb5oB5/LMZBPiP+lCIupZEW/mpasmoP
         GloV/vO+ZAmSUB1s5G68956xUiV+F9vCiwNw3V5FIoPplWORS38PGfemS4QWw5AbbLCQ
         I6Yw3Zw07mv18nV8u4tqZeIJzVlqA5BNr+GBKnISEm0QT2qxZHvdjucJNo8t+H81WZj4
         IC+f2wh++KNj3kEvhiosgm0tbAGxheBjU53JoXcHjo7z2bYgUBxOmc3pWlgtIoFfkaFn
         eKCpEoqAH/be634erqbldWMTj7slJVHdjZnNAvFiCAD29EVKeWlwoB6iehI9pZ40oQ8g
         BcDA==
X-Gm-Message-State: AC+VfDyhkN5A+GIbyb3Y5Tubg1XVPaL7G8FBAeOuAGU34QkjLBBxAfYM
        mR1InszkRJMX8LNqw0JkHluRTHofokHQ1w==
X-Google-Smtp-Source: ACHHUZ5Ea9TEFJz6eAvZFGUKSTs9F05ryAWIVjbmDACzp4e9iaMLtymDaqQ9V/V45GVKfZfrEzOsKg==
X-Received: by 2002:a05:622a:1910:b0:3f9:3103:cf29 with SMTP id w16-20020a05622a191000b003f93103cf29mr21492447qtc.61.1687641829987;
        Sat, 24 Jun 2023 14:23:49 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:266e:4d00::387])
        by smtp.gmail.com with ESMTPSA id x15-20020ac87ecf000000b003fdd34c6babsm1118182qtj.76.2023.06.24.14.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 14:23:49 -0700 (PDT)
From:   Mark Levedahl <mlevedahl@gmail.com>
To:     git@vger.kernel.org
Cc:     adam@dinwoodie.org, me@yadavpratyush.com,
        johannes.schindelin@gmx.de, Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v0 2/4] git-gui - remove obsolete Cygwin specific code
Date:   Sat, 24 Jun 2023 17:23:45 -0400
Message-ID: <20230624212347.179656-3-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.41.0.99.19
In-Reply-To: <20230624212347.179656-1-mlevedahl@gmail.com>
References: <20230624212347.179656-1-mlevedahl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the current git release, git-gui runs on Cygwin without enabling any
of git-gui's Cygwin specific code.  This happens as the Cygwin specific
code in git-gui was (mostly) written in 2007-2008 to work with Cygwin's
then supplied Tcl/Tk which was an incompletely ported variant of the
8.4.1 Windows Tcl/Tk code.  In March, 2012, that 8.4.1 package was
replaced with a full port based upon the upstream unix/X11 code,
since maintained up to date. The two Tcl/Tk packages are completely
incompatible, and have different sygnatures.

When Cygwin's Tcl/Tk signature changed in 2012, git-gui no longer
detected Cygwin, so did not enable Cygwin specific code, and the POSIX
environment provided by Cygwin since 2012 supported git-gui as a generic
unix. Thus, no-one apparently noticed the existence of incompatible
Cygwin specific code.

However, since commit c5766eae6f2b002396b6cd4f85b62317b707174e in
upstream git-gui, the is_Cygwin funcion does detect current Cygwin.  The
Cygwin specific code is enabled, causing use of Windows rather than unix
pathnames, and enabling incorrect warnings about environment variables
that are not relevant for the fully functional unix/X11 Tcl/Tk. The end
result is that git-gui is now incommpatible with Cygwin.

So, delete all Cygwin specific code (code protected by "if is_Cygwin"),
thus restoring the post-2012 behaviour. Note that Cygwin specific code
is required to enable file browsing and shortcut creation (supported
before 2012), but is not addressed in this patch.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh                | 122 +++-----------------------------------
 lib/choose_repository.tcl |  27 +--------
 lib/shortcut.tcl          |  41 -------------
 3 files changed, 9 insertions(+), 181 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index cb92bba..b5dba80 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -84,14 +84,7 @@ proc _which {what args} {
 	global env _search_exe _search_path
 
 	if {$_search_path eq {}} {
-		if {[is_Cygwin] && [regexp {^(/|\.:)} $env(PATH)]} {
-			set _search_path [split [exec cygpath \
-				--windows \
-				--path \
-				--absolute \
-				$env(PATH)] {;}]
-			set _search_exe .exe
-		} elseif {[is_Windows]} {
+		if {[is_Windows]} {
 			set gitguidir [file dirname [info script]]
 			regsub -all ";" $gitguidir "\\;" gitguidir
 			set env(PATH) "$gitguidir;$env(PATH)"
@@ -342,14 +335,7 @@ proc gitexec {args} {
 		if {[catch {set _gitexec [git --exec-path]} err]} {
 			error "Git not installed?\n\n$err"
 		}
-		if {[is_Cygwin]} {
-			set _gitexec [exec cygpath \
-				--windows \
-				--absolute \
-				$_gitexec]
-		} else {
-			set _gitexec [file normalize $_gitexec]
-		}
+		set _gitexec [file normalize $_gitexec]
 	}
 	if {$args eq {}} {
 		return $_gitexec
@@ -364,14 +350,7 @@ proc githtmldir {args} {
 			# Git not installed or option not yet supported
 			return {}
 		}
-		if {[is_Cygwin]} {
-			set _githtmldir [exec cygpath \
-				--windows \
-				--absolute \
-				$_githtmldir]
-		} else {
-			set _githtmldir [file normalize $_githtmldir]
-		}
+		set _githtmldir [file normalize $_githtmldir]
 	}
 	if {$args eq {}} {
 		return $_githtmldir
@@ -1318,9 +1297,6 @@ if {$_gitdir eq "."} {
 	set _gitdir [pwd]
 }
 
-if {![file isdirectory $_gitdir] && [is_Cygwin]} {
-	catch {set _gitdir [exec cygpath --windows $_gitdir]}
-}
 if {![file isdirectory $_gitdir]} {
 	catch {wm withdraw .}
 	error_popup [strcat [mc "Git directory not found:"] "\n\n$_gitdir"]
@@ -1332,11 +1308,7 @@ apply_config
 
 # v1.7.0 introduced --show-toplevel to return the canonical work-tree
 if {[package vcompare $_git_version 1.7.0] >= 0} {
-	if { [is_Cygwin] } {
-		catch {set _gitworktree [exec cygpath --windows [git rev-parse --show-toplevel]]}
-	} else {
-		set _gitworktree [git rev-parse --show-toplevel]
-	}
+	set _gitworktree [git rev-parse --show-toplevel]
 } else {
 	# try to set work tree from environment, core.worktree or use
 	# cdup to obtain a relative path to the top of the worktree. If
@@ -1561,24 +1533,8 @@ proc rescan {after {honor_trustmtime 1}} {
 	}
 }
 
-if {[is_Cygwin]} {
-	set is_git_info_exclude {}
-	proc have_info_exclude {} {
-		global is_git_info_exclude
-
-		if {$is_git_info_exclude eq {}} {
-			if {[catch {exec test -f [gitdir info exclude]}]} {
-				set is_git_info_exclude 0
-			} else {
-				set is_git_info_exclude 1
-			}
-		}
-		return $is_git_info_exclude
-	}
-} else {
-	proc have_info_exclude {} {
-		return [file readable [gitdir info exclude]]
-	}
+proc have_info_exclude {} {
+	return [file readable [gitdir info exclude]]
 }
 
 proc rescan_stage2 {fd after} {
@@ -2318,7 +2274,7 @@ proc do_git_gui {} {
 
 # Get the system-specific explorer app/command.
 proc get_explorer {} {
-	if {[is_Cygwin] || [is_Windows]} {
+	if {[is_Windows]} {
 		set explorer "explorer.exe"
 	} elseif {[is_MacOSX]} {
 		set explorer "open"
@@ -2874,11 +2830,7 @@ if {[is_enabled multicommit]} {
 
 	.mbar.repository add separator
 
-	if {[is_Cygwin]} {
-		.mbar.repository add command \
-			-label [mc "Create Desktop Icon"] \
-			-command do_cygwin_shortcut
-	} elseif {[is_Windows]} {
+	if {[is_Windows]} {
 		.mbar.repository add command \
 			-label [mc "Create Desktop Icon"] \
 			-command do_windows_shortcut
@@ -3112,10 +3064,6 @@ if {[is_MacOSX]} {
 set doc_path [githtmldir]
 if {$doc_path ne {}} {
 	set doc_path [file join $doc_path index.html]
-
-	if {[is_Cygwin]} {
-		set doc_path [exec cygpath --mixed $doc_path]
-	}
 }
 
 if {[file isfile $doc_path]} {
@@ -4087,60 +4035,6 @@ set file_lists($ui_workdir) [list]
 wm title . "[appname] ([reponame]) [file normalize $_gitworktree]"
 focus -force $ui_comm
 
-# -- Warn the user about environmental problems.  Cygwin's Tcl
-#    does *not* pass its env array onto any processes it spawns.
-#    This means that git processes get none of our environment.
-#
-if {[is_Cygwin]} {
-	set ignored_env 0
-	set suggest_user {}
-	set msg [mc "Possible environment issues exist.
-
-The following environment variables are probably
-going to be ignored by any Git subprocess run
-by %s:
-
-" [appname]]
-	foreach name [array names env] {
-		switch -regexp -- $name {
-		{^GIT_INDEX_FILE$} -
-		{^GIT_OBJECT_DIRECTORY$} -
-		{^GIT_ALTERNATE_OBJECT_DIRECTORIES$} -
-		{^GIT_DIFF_OPTS$} -
-		{^GIT_EXTERNAL_DIFF$} -
-		{^GIT_PAGER$} -
-		{^GIT_TRACE$} -
-		{^GIT_CONFIG$} -
-		{^GIT_(AUTHOR|COMMITTER)_DATE$} {
-			append msg " - $name\n"
-			incr ignored_env
-		}
-		{^GIT_(AUTHOR|COMMITTER)_(NAME|EMAIL)$} {
-			append msg " - $name\n"
-			incr ignored_env
-			set suggest_user $name
-		}
-		}
-	}
-	if {$ignored_env > 0} {
-		append msg [mc "
-This is due to a known issue with the
-Tcl binary distributed by Cygwin."]
-
-		if {$suggest_user ne {}} {
-			append msg [mc "
-
-A good replacement for %s
-is placing values for the user.name and
-user.email settings into your personal
-~/.gitconfig file.
-" $suggest_user]
-		}
-		warn_popup $msg
-	}
-	unset ignored_env msg suggest_user name
-}
-
 # -- Only initialize complex UI if we are going to stay running.
 #
 if {[is_enabled transport]} {
diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
index af1fee7..d23abed 100644
--- a/lib/choose_repository.tcl
+++ b/lib/choose_repository.tcl
@@ -174,9 +174,6 @@ constructor pick {} {
 			-foreground blue \
 			-underline 1
 		set home $::env(HOME)
-		if {[is_Cygwin]} {
-			set home [exec cygpath --windows --absolute $home]
-		}
 		set home "[file normalize $home]/"
 		set hlen [string length $home]
 		foreach p $sorted_recent {
@@ -374,18 +371,6 @@ proc _objdir {path} {
 		return $objdir
 	}
 
-	if {[is_Cygwin]} {
-		set objdir [file join $path .git objects.lnk]
-		if {[file isfile $objdir]} {
-			return [win32_read_lnk $objdir]
-		}
-
-		set objdir [file join $path objects.lnk]
-		if {[file isfile $objdir]} {
-			return [win32_read_lnk $objdir]
-		}
-	}
-
 	return {}
 }
 
@@ -623,12 +608,6 @@ method _do_clone2 {} {
 	}
 
 	set giturl $origin_url
-	if {[is_Cygwin] && [file isdirectory $giturl]} {
-		set giturl [exec cygpath --unix --absolute $giturl]
-		if {$clone_type eq {shared}} {
-			set objdir [exec cygpath --unix --absolute $objdir]
-		}
-	}
 
 	if {[file exists $local_path]} {
 		error_popup [mc "Location %s already exists." $local_path]
@@ -668,11 +647,7 @@ method _do_clone2 {} {
 				fconfigure $f_cp -translation binary -encoding binary
 				cd $objdir
 				while {[gets $f_in line] >= 0} {
-					if {[is_Cygwin]} {
-						puts $f_cp [exec cygpath --unix --absolute $line]
-					} else {
-						puts $f_cp [file normalize $line]
-					}
+					puts $f_cp [file normalize $line]
 				}
 				close $f_in
 				close $f_cp
diff --git a/lib/shortcut.tcl b/lib/shortcut.tcl
index 97d1d7a..1d8374b 100644
--- a/lib/shortcut.tcl
+++ b/lib/shortcut.tcl
@@ -26,47 +26,6 @@ proc do_windows_shortcut {} {
 	}
 }
 
-proc do_cygwin_shortcut {} {
-	global argv0 _gitworktree
-
-	if {[catch {
-		set desktop [exec cygpath \
-			--windows \
-			--absolute \
-			--long-name \
-			--desktop]
-		}]} {
-			set desktop .
-	}
-	set fn [tk_getSaveFile \
-		-parent . \
-		-title [mc "%s (%s): Create Desktop Icon" [appname] [reponame]] \
-		-initialdir $desktop \
-		-initialfile "Git [reponame].lnk"]
-	if {$fn != {}} {
-		if {[file extension $fn] ne {.lnk}} {
-			set fn ${fn}.lnk
-		}
-		if {[catch {
-				set sh [exec cygpath \
-					--windows \
-					--absolute \
-					/bin/sh.exe]
-				set me [exec cygpath \
-					--unix \
-					--absolute \
-					$argv0]
-				win32_create_lnk $fn [list \
-					$sh -c \
-					"CHERE_INVOKING=1 source /etc/profile;[sq $me] &" \
-					] \
-					[file normalize $_gitworktree]
-			} err]} {
-			error_popup [strcat [mc "Cannot write shortcut:"] "\n\n$err"]
-		}
-	}
-}
-
 proc do_macosx_app {} {
 	global argv0 env
 
-- 
2.41.0.99.19

