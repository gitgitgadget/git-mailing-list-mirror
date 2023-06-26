Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34264EB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjFZQxO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjFZQxL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:53:11 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D3DC4
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:53:09 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-763c997ee0aso383320985a.3
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687798389; x=1690390389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9Kh4I1NU5g5ULkpi9FnJmSp9iSzEe8O2I6MGzyclcM=;
        b=Wqe/eyT452HY76YFfs5I93VmpaVuItW1PKmFR4RktEkCmTQG7SLH1ja1p8qnGONPja
         SFxhhwio0D9FhJHTh/qpUtfyWAi0JAGZbP+xfbjrAIsy1cYnCfBcIEO8Z/WhDfubYxtc
         eNAcDetTmImJ4l/GFhqFhTj4/xaXXQx/KR9LyTnmEakfa2CzmhEj33xSjvyE8miwf05Y
         vM+ai9EFWKGwomRCgKGZqNycH2wvYlG2wNP6GM7q46VJTNVAt/KUJMRht2k7lvhUsTRW
         fCYVCE8wecYv+clDt8Sa9sc2S6jgWeuLtxnZOaL8RaJHoRrUcc0Y07KMf47+U1cOZepm
         oCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687798389; x=1690390389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9Kh4I1NU5g5ULkpi9FnJmSp9iSzEe8O2I6MGzyclcM=;
        b=bw6eCbdqkH/tpzUfYHqbjIToc11ArcDaCfVmQRAievL0xA7E0mXQ2ZN5FheepatR4M
         lAfPgEWsscwOmWBiravGfaChIatVR9b4s7NDHAItFlnc4whxXHMbW1lEEzgCb9VmvJE1
         ineuyIwtAOhFs1yFhohJu42t7DtDumgxoKOhEeJKAwtqQ16ObHLT/pwOfhPvusRI7ISb
         oGMlWYlLaVJHo0H4coJr7GEED8j8gXgMNXZpqz60Vn0dqWG3ZAVMlmC+YhhLzghmZx02
         xDIBT8gPGInzwgdImgtHqfxnycTdrn+AwbIYfKf7qAIK2rRuvAWbftqn7RRHomhrbbkx
         cm0A==
X-Gm-Message-State: AC+VfDyys+SA5R15NoscAvxOO/+iXzwKvHaA8Mt2M8gAm8eC3iMOpffK
        oGQaWMvEGjpeh5DFB0Naplk=
X-Google-Smtp-Source: ACHHUZ7y53xkpsRyAh0VEQxyelUjnr2zkiuDrfw+rdrTUPEnC04QNRdMwO23bILR2lvn8kRoUiuS3w==
X-Received: by 2002:a05:620a:2891:b0:765:8063:c369 with SMTP id j17-20020a05620a289100b007658063c369mr4894738qkp.74.1687798388830;
        Mon, 26 Jun 2023 09:53:08 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:266e:4d00::387])
        by smtp.gmail.com with ESMTPSA id p5-20020a05620a112500b00765acdc4f56sm922819qkk.60.2023.06.26.09.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:53:08 -0700 (PDT)
From:   Mark Levedahl <mlevedahl@gmail.com>
To:     mdl123@verizon.net, git@vger.kernel.org
Cc:     adam@dinwoodie.org, me@yadavpratyush.com,
        johannes.schindelin@gmx.de, gitster@pobox.com,
        sunshine@sunshineco.com, Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v1 2/4] git-gui - remove obsolete Cygwin specific code
Date:   Mon, 26 Jun 2023 12:53:03 -0400
Message-ID: <20230626165305.37488-3-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.41.0.99.19
In-Reply-To: <20230626165305.37488-1-mlevedahl@gmail.com>
References: <20230624212347.179656-1-mlevedahl@gmail.com>
 <20230626165305.37488-1-mlevedahl@gmail.com>
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
incompatible, and have different signatures.

When Cygwin's Tcl/Tk signature changed in 2012, git-gui no longer
detected Cygwin, so did not enable Cygwin specific code, and the POSIX
environment provided by Cygwin since 2012 supported git-gui as a generic
unix. Thus, no-one apparently noticed the existence of incompatible
Cygwin specific code.

However, since commit c5766eae6f in the git-gui source tree
(https://github.com/prati0100/git-gui, master at a5005ded), and not yet
pulled into the git repository, the is_Cygwin function does detect
Cygwin using the unix/X11 Tcl/Tk.  The Cygwin specific code is enabled,
causing use of Windows rather than unix pathnames, and enabling
incorrect warnings about environment variables that were relevant only
to the old Tcl/Tk.  The end result is that (upstream) git-gui is now
incompatible with Cygwin.

So, delete Cygwin specific code (code protected by "if is_Cygwin") that
is not needed in any form to work with the unix/X11 Tcl/Tk.

Cygwin specific code required to enable file browsing and shortcut
creation is not addressed in this patch, does not currently work, and
invocation of those items may leave git-gui in a confused state.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
changes since v0
 -- do not touch any code fixed in patches 3/4, meaning the browsing
    and shortcut creating menu items do not work.

 git-gui.sh                | 114 ++------------------------------------
 lib/choose_repository.tcl |  27 +--------
 2 files changed, 7 insertions(+), 134 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index cb92bba..3f7c31e 100755
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
@@ -3112,10 +3068,6 @@ if {[is_MacOSX]} {
 set doc_path [githtmldir]
 if {$doc_path ne {}} {
 	set doc_path [file join $doc_path index.html]
-
-	if {[is_Cygwin]} {
-		set doc_path [exec cygpath --mixed $doc_path]
-	}
 }
 
 if {[file isfile $doc_path]} {
@@ -4087,60 +4039,6 @@ set file_lists($ui_workdir) [list]
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
-- 
2.41.0.99.19

