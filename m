Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE060C43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 04:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16AC5221E5
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 04:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khLCV3lh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbgIKEhF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 00:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgIKEgy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 00:36:54 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747CAC061757
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 21:36:53 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l191so5722657pgd.5
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 21:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Vkb2dGhGtBtxz0vjaLV4Q/kJiqTZ/IkJUx4/ce9A86o=;
        b=khLCV3lh2V4nBrOakVULND44Ea7YGa5h6pMEBBScFSJ0IhKz1vgtdVBoPtBMN9aUUm
         AlyCyJ+GLuwzn+p0g9cH+q8F43QsuBN/A6+QxzKV6pnhpK2Qult2XIoIme/eKol41fUI
         ID6TQ6yvk0vw+UBjHWcn6plLkqnlZXnvst/eEKl8+8X79gdcGDTp78XfarUILvV1Sau6
         J0ZNxOhlQVR+mPOrDih1ejZIogIAtfI1Ds43DojLUiGujnY7iHCUTwmZMRqulNMdCKPm
         5NqF3bvFCEAwGNVt2gOTAc7qg8qIONivuzlQ/U2+n0JV4pYHb7WZzBfTaFze+ZqmN/RY
         k1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vkb2dGhGtBtxz0vjaLV4Q/kJiqTZ/IkJUx4/ce9A86o=;
        b=Oxj59zzPyg6f6HDAVYCmXmbrilumyiraqniStTrYSoH/FIJ8sXFcei5nYGB8jPzi7/
         7pSLM5xUHDdd7aZ0j5gnzdJ0i3df4wudm/eNjfio3vMeJinN+SPtoyaBeuMv/PZyCDaD
         FPY3OWVHOfCdVUaKvEwNnKpiNz5993rgb+L0GjbIH257/tb9StMHZ5pry8PPLBa8ZdN/
         11p0XvWlABwxLd1uBr2TNR7BwwX0zpvcwlYIEUSLWIl9Fr2sclyFYruXhiHn7T4EQRGd
         9F0e1MubG04YKEHoEZtfcFIdTR76p95hjJT20yGoyf+i03f5dHQDbBTlZjgMruk89ldL
         Q2tg==
X-Gm-Message-State: AOAM530QBMMLl57buWTdaoWrMCH8vRwCYMKwyND/HwWUVUq0GlhVgEuB
        tsIRe2pJjsbIe3qJg6cKesXtvFPVQhE=
X-Google-Smtp-Source: ABdhPJznjrdCd2JiguxYQiNMBo97KHtgDNRpt+rR6cKxZp7XB49NlmY3eXToHnMq78n76KVxIhZLnA==
X-Received: by 2002:a63:4d8:: with SMTP id 207mr371229pge.109.1599799010552;
        Thu, 10 Sep 2020 21:36:50 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:5900:d670::1ab5])
        by smtp.gmail.com with ESMTPSA id x25sm527804pgk.26.2020.09.10.21.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 21:36:49 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH v2 1/2] gitk: replace tabs with spaces
Date:   Thu, 10 Sep 2020 21:36:33 -0700
Message-Id: <ecdede5cf50bdb966f53bcf5171c80b5f8959d4b.1599798976.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <cover.1599798976.git.liu.denton@gmail.com>
References: <cover.1599726439.git.liu.denton@gmail.com> <cover.1599798976.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The source code is a mix of tabs and spaces. The indentation style
currently is four spaces per indent level but uses tabs every other
level (at eight spaces). Fix this inconsistent spacing and tabbing by
just using a space-indent for everything.

This was done mechanically by running:

	$ expand -i gitk >gitk.new
	$ mv gitk.new gitk

This patch should be empty with `--ignore-all-space`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 gitk | 10568 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 5284 insertions(+), 5284 deletions(-)

diff --git a/gitk b/gitk
index da84e22dd4..1dae9861ac 100755
--- a/gitk
+++ b/gitk
@@ -11,14 +11,14 @@ package require Tk
 
 proc hasworktree {} {
     return [expr {[exec git rev-parse --is-bare-repository] == "false" &&
-		  [exec git rev-parse --is-inside-git-dir] == "false"}]
+                  [exec git rev-parse --is-inside-git-dir] == "false"}]
 }
 
 proc reponame {} {
     global gitdir
     set n [file normalize $gitdir]
     if {[string match "*/.git" $n]} {
-	set n [string range $n 0 end-5]
+        set n [string range $n 0 end-5]
     }
     return [file tail $n]
 }
@@ -26,7 +26,7 @@ proc reponame {} {
 proc gitworktree {} {
     variable _gitworktree
     if {[info exists _gitworktree]} {
-	return $_gitworktree
+        return $_gitworktree
     }
     # v1.7.0 introduced --show-toplevel to return the canonical work-tree
     if {[catch {set _gitworktree [exec git rev-parse --show-toplevel]}]} {
@@ -34,10 +34,10 @@ proc gitworktree {} {
         # cdup to obtain a relative path to the top of the worktree. If
         # run from the top, the ./ prefix ensures normalize expands pwd.
         if {[catch { set _gitworktree $env(GIT_WORK_TREE) }]} {
-	    catch {set _gitworktree [exec git config --get core.worktree]}
-	    if {$_gitworktree eq ""} {
-		set _gitworktree [file normalize ./[exec git rev-parse --show-cdup]]
-	    }
+            catch {set _gitworktree [exec git config --get core.worktree]}
+            if {$_gitworktree eq ""} {
+                set _gitworktree [file normalize ./[exec git rev-parse --show-cdup]]
+            }
         }
     }
     return $_gitworktree
@@ -54,7 +54,7 @@ proc run args {
     set script $args
     if {[info exists isonrunq($script)]} return
     if {$runq eq {} && ![info exists currunq]} {
-	after idle dorunq
+        after idle dorunq
     }
     lappend runq [list {} $script]
     set isonrunq($script) 1
@@ -69,7 +69,7 @@ proc filereadable {fd script} {
 
     fileevent $fd readable {}
     if {$runq eq {} && ![info exists currunq]} {
-	after idle dorunq
+        after idle dorunq
     }
     lappend runq [list $fd $script]
 }
@@ -78,11 +78,11 @@ proc nukefile {fd} {
     global runq
 
     for {set i 0} {$i < [llength $runq]} {} {
-	if {[lindex $runq $i 0] eq $fd} {
-	    set runq [lreplace $runq $i $i]
-	} else {
-	    incr i
-	}
+        if {[lindex $runq $i 0] eq $fd} {
+            set runq [lreplace $runq $i $i]
+        } else {
+            incr i
+        }
     }
 }
 
@@ -92,30 +92,30 @@ proc dorunq {} {
     set tstart [clock clicks -milliseconds]
     set t0 $tstart
     while {[llength $runq] > 0} {
-	set fd [lindex $runq 0 0]
-	set script [lindex $runq 0 1]
-	set currunq [lindex $runq 0]
-	set runq [lrange $runq 1 end]
-	set repeat [eval $script]
-	unset currunq
-	set t1 [clock clicks -milliseconds]
-	set t [expr {$t1 - $t0}]
-	if {$repeat ne {} && $repeat} {
-	    if {$fd eq {} || $repeat == 2} {
-		# script returns 1 if it wants to be readded
-		# file readers return 2 if they could do more straight away
-		lappend runq [list $fd $script]
-	    } else {
-		fileevent $fd readable [list filereadable $fd $script]
-	    }
-	} elseif {$fd eq {}} {
-	    unset isonrunq($script)
-	}
-	set t0 $t1
-	if {$t1 - $tstart >= 80} break
+        set fd [lindex $runq 0 0]
+        set script [lindex $runq 0 1]
+        set currunq [lindex $runq 0]
+        set runq [lrange $runq 1 end]
+        set repeat [eval $script]
+        unset currunq
+        set t1 [clock clicks -milliseconds]
+        set t [expr {$t1 - $t0}]
+        if {$repeat ne {} && $repeat} {
+            if {$fd eq {} || $repeat == 2} {
+                # script returns 1 if it wants to be readded
+                # file readers return 2 if they could do more straight away
+                lappend runq [list $fd $script]
+            } else {
+                fileevent $fd readable [list filereadable $fd $script]
+            }
+        } elseif {$fd eq {}} {
+            unset isonrunq($script)
+        }
+        set t0 $t1
+        if {$t1 - $tstart >= 80} break
     }
     if {$runq ne {}} {
-	after idle dorunq
+        after idle dorunq
     }
 }
 
@@ -135,20 +135,20 @@ proc unmerged_files {files} {
     set mlist {}
     set nr_unmerged 0
     if {[catch {
-	set fd [open "| git ls-files -u" r]
+        set fd [open "| git ls-files -u" r]
     } err]} {
-	show_error {} . "[mc "Couldn't get list of unmerged files:"] $err"
-	exit 1
+        show_error {} . "[mc "Couldn't get list of unmerged files:"] $err"
+        exit 1
     }
     while {[gets $fd line] >= 0} {
-	set i [string first "\t" $line]
-	if {$i < 0} continue
-	set fname [string range $line [expr {$i+1}] end]
-	if {[lsearch -exact $mlist $fname] >= 0} continue
-	incr nr_unmerged
-	if {$files eq {} || [path_filter $files $fname]} {
-	    lappend mlist $fname
-	}
+        set i [string first "\t" $line]
+        if {$i < 0} continue
+        set fname [string range $line [expr {$i+1}] end]
+        if {[lsearch -exact $mlist $fname] >= 0} continue
+        incr nr_unmerged
+        if {$files eq {} || [path_filter $files $fname]} {
+            lappend mlist $fname
+        }
     }
     catch {close $fd}
     return $mlist
@@ -171,115 +171,115 @@ proc parseviewargs {n arglist} {
     set filtered 0
     set i -1
     foreach arg $arglist {
-	incr i
-	if {$nextisval} {
-	    lappend glflags $arg
-	    set nextisval 0
-	    continue
-	}
-	switch -glob -- $arg {
-	    "-d" -
-	    "--date-order" {
-		set vdatemode($n) 1
-		# remove from origargs in case we hit an unknown option
-		set origargs [lreplace $origargs $i $i]
-		incr i -1
-	    }
-	    "-[puabwcrRBMC]" -
-	    "--no-renames" - "--full-index" - "--binary" - "--abbrev=*" -
-	    "--find-copies-harder" - "-l*" - "--ext-diff" - "--no-ext-diff" -
-	    "--src-prefix=*" - "--dst-prefix=*" - "--no-prefix" -
-	    "-O*" - "--text" - "--full-diff" - "--ignore-space-at-eol" -
-	    "--ignore-space-change" - "-U*" - "--unified=*" {
-		# These request or affect diff output, which we don't want.
-		# Some could be used to set our defaults for diff display.
-		lappend diffargs $arg
-	    }
-	    "--raw" - "--patch-with-raw" - "--patch-with-stat" -
-	    "--name-only" - "--name-status" - "--color" -
-	    "--log-size" - "--pretty=*" - "--decorate" - "--abbrev-commit" -
-	    "--cc" - "-z" - "--header" - "--parents" - "--boundary" -
-	    "--no-color" - "-g" - "--walk-reflogs" - "--no-walk" -
-	    "--timestamp" - "relative-date" - "--date=*" - "--stdin" -
-	    "--objects" - "--objects-edge" - "--reverse" {
-		# These cause our parsing of git log's output to fail, or else
-		# they're options we want to set ourselves, so ignore them.
-	    }
-	    "--color-words*" - "--word-diff=color" {
-		# These trigger a word diff in the console interface,
-		# so help the user by enabling our own support
-		if {[package vcompare $git_version "1.7.2"] >= 0} {
-		    set worddiff [mc "Color words"]
-		}
-	    }
-	    "--word-diff*" {
-		if {[package vcompare $git_version "1.7.2"] >= 0} {
-		    set worddiff [mc "Markup words"]
-		}
-	    }
-	    "--stat=*" - "--numstat" - "--shortstat" - "--summary" -
-	    "--check" - "--exit-code" - "--quiet" - "--topo-order" -
-	    "--full-history" - "--dense" - "--sparse" -
-	    "--follow" - "--left-right" - "--encoding=*" {
-		# These are harmless, and some are even useful
-		lappend glflags $arg
-	    }
-	    "--diff-filter=*" - "--no-merges" - "--unpacked" -
-	    "--max-count=*" - "--skip=*" - "--since=*" - "--after=*" -
-	    "--until=*" - "--before=*" - "--max-age=*" - "--min-age=*" -
-	    "--author=*" - "--committer=*" - "--grep=*" - "-[iE]" -
-	    "--remove-empty" - "--first-parent" - "--cherry-pick" -
-	    "-S*" - "-G*" - "--pickaxe-all" - "--pickaxe-regex" -
-	    "--simplify-by-decoration" {
-		# These mean that we get a subset of the commits
-		set filtered 1
-		lappend glflags $arg
-	    }
-	    "-L*" {
-		# Line-log with 'stuck' argument (unstuck form is
-		# not supported)
-		set filtered 1
-		set vinlinediff($n) 1
-		set allknown 0
-		lappend glflags $arg
-	    }
-	    "-n" {
-		# This appears to be the only one that has a value as a
-		# separate word following it
-		set filtered 1
-		set nextisval 1
-		lappend glflags $arg
-	    }
-	    "--not" - "--all" {
-		lappend revargs $arg
-	    }
-	    "--merge" {
-		set vmergeonly($n) 1
-		# git rev-parse doesn't understand --merge
-		lappend revargs --gitk-symmetric-diff-marker MERGE_HEAD...HEAD
-	    }
-	    "--no-replace-objects" {
-		set env(GIT_NO_REPLACE_OBJECTS) "1"
-	    }
-	    "-*" {
-		# Other flag arguments including -<n>
-		if {[string is digit -strict [string range $arg 1 end]]} {
-		    set filtered 1
-		} else {
-		    # a flag argument that we don't recognize;
-		    # that means we can't optimize
-		    set allknown 0
-		}
-		lappend glflags $arg
-	    }
-	    default {
-		# Non-flag arguments specify commits or ranges of commits
-		if {[string match "*...*" $arg]} {
-		    lappend revargs --gitk-symmetric-diff-marker
-		}
-		lappend revargs $arg
-	    }
-	}
+        incr i
+        if {$nextisval} {
+            lappend glflags $arg
+            set nextisval 0
+            continue
+        }
+        switch -glob -- $arg {
+            "-d" -
+            "--date-order" {
+                set vdatemode($n) 1
+                # remove from origargs in case we hit an unknown option
+                set origargs [lreplace $origargs $i $i]
+                incr i -1
+            }
+            "-[puabwcrRBMC]" -
+            "--no-renames" - "--full-index" - "--binary" - "--abbrev=*" -
+            "--find-copies-harder" - "-l*" - "--ext-diff" - "--no-ext-diff" -
+            "--src-prefix=*" - "--dst-prefix=*" - "--no-prefix" -
+            "-O*" - "--text" - "--full-diff" - "--ignore-space-at-eol" -
+            "--ignore-space-change" - "-U*" - "--unified=*" {
+                # These request or affect diff output, which we don't want.
+                # Some could be used to set our defaults for diff display.
+                lappend diffargs $arg
+            }
+            "--raw" - "--patch-with-raw" - "--patch-with-stat" -
+            "--name-only" - "--name-status" - "--color" -
+            "--log-size" - "--pretty=*" - "--decorate" - "--abbrev-commit" -
+            "--cc" - "-z" - "--header" - "--parents" - "--boundary" -
+            "--no-color" - "-g" - "--walk-reflogs" - "--no-walk" -
+            "--timestamp" - "relative-date" - "--date=*" - "--stdin" -
+            "--objects" - "--objects-edge" - "--reverse" {
+                # These cause our parsing of git log's output to fail, or else
+                # they're options we want to set ourselves, so ignore them.
+            }
+            "--color-words*" - "--word-diff=color" {
+                # These trigger a word diff in the console interface,
+                # so help the user by enabling our own support
+                if {[package vcompare $git_version "1.7.2"] >= 0} {
+                    set worddiff [mc "Color words"]
+                }
+            }
+            "--word-diff*" {
+                if {[package vcompare $git_version "1.7.2"] >= 0} {
+                    set worddiff [mc "Markup words"]
+                }
+            }
+            "--stat=*" - "--numstat" - "--shortstat" - "--summary" -
+            "--check" - "--exit-code" - "--quiet" - "--topo-order" -
+            "--full-history" - "--dense" - "--sparse" -
+            "--follow" - "--left-right" - "--encoding=*" {
+                # These are harmless, and some are even useful
+                lappend glflags $arg
+            }
+            "--diff-filter=*" - "--no-merges" - "--unpacked" -
+            "--max-count=*" - "--skip=*" - "--since=*" - "--after=*" -
+            "--until=*" - "--before=*" - "--max-age=*" - "--min-age=*" -
+            "--author=*" - "--committer=*" - "--grep=*" - "-[iE]" -
+            "--remove-empty" - "--first-parent" - "--cherry-pick" -
+            "-S*" - "-G*" - "--pickaxe-all" - "--pickaxe-regex" -
+            "--simplify-by-decoration" {
+                # These mean that we get a subset of the commits
+                set filtered 1
+                lappend glflags $arg
+            }
+            "-L*" {
+                # Line-log with 'stuck' argument (unstuck form is
+                # not supported)
+                set filtered 1
+                set vinlinediff($n) 1
+                set allknown 0
+                lappend glflags $arg
+            }
+            "-n" {
+                # This appears to be the only one that has a value as a
+                # separate word following it
+                set filtered 1
+                set nextisval 1
+                lappend glflags $arg
+            }
+            "--not" - "--all" {
+                lappend revargs $arg
+            }
+            "--merge" {
+                set vmergeonly($n) 1
+                # git rev-parse doesn't understand --merge
+                lappend revargs --gitk-symmetric-diff-marker MERGE_HEAD...HEAD
+            }
+            "--no-replace-objects" {
+                set env(GIT_NO_REPLACE_OBJECTS) "1"
+            }
+            "-*" {
+                # Other flag arguments including -<n>
+                if {[string is digit -strict [string range $arg 1 end]]} {
+                    set filtered 1
+                } else {
+                    # a flag argument that we don't recognize;
+                    # that means we can't optimize
+                    set allknown 0
+                }
+                lappend glflags $arg
+            }
+            default {
+                # Non-flag arguments specify commits or ranges of commits
+                if {[string match "*...*" $arg]} {
+                    lappend revargs --gitk-symmetric-diff-marker
+                }
+                lappend revargs $arg
+            }
+        }
     }
     set vdflags($n) $diffargs
     set vflags($n) $glflags
@@ -293,61 +293,61 @@ proc parseviewrevs {view revs} {
     global vposids vnegids
 
     if {$revs eq {}} {
-	set revs HEAD
+        set revs HEAD
     } elseif {[lsearch -exact $revs --all] >= 0} {
-	lappend revs HEAD
+        lappend revs HEAD
     }
     if {[catch {set ids [eval exec git rev-parse $revs]} err]} {
-	# we get stdout followed by stderr in $err
-	# for an unknown rev, git rev-parse echoes it and then errors out
-	set errlines [split $err "\n"]
-	set badrev {}
-	for {set l 0} {$l < [llength $errlines]} {incr l} {
-	    set line [lindex $errlines $l]
-	    if {!([string length $line] == 40 && [string is xdigit $line])} {
-		if {[string match "fatal:*" $line]} {
-		    if {[string match "fatal: ambiguous argument*" $line]
-			&& $badrev ne {}} {
-			if {[llength $badrev] == 1} {
-			    set err "unknown revision $badrev"
-			} else {
-			    set err "unknown revisions: [join $badrev ", "]"
-			}
-		    } else {
-			set err [join [lrange $errlines $l end] "\n"]
-		    }
-		    break
-		}
-		lappend badrev $line
-	    }
-	}
-	error_popup "[mc "Error parsing revisions:"] $err"
-	return {}
+        # we get stdout followed by stderr in $err
+        # for an unknown rev, git rev-parse echoes it and then errors out
+        set errlines [split $err "\n"]
+        set badrev {}
+        for {set l 0} {$l < [llength $errlines]} {incr l} {
+            set line [lindex $errlines $l]
+            if {!([string length $line] == 40 && [string is xdigit $line])} {
+                if {[string match "fatal:*" $line]} {
+                    if {[string match "fatal: ambiguous argument*" $line]
+                        && $badrev ne {}} {
+                        if {[llength $badrev] == 1} {
+                            set err "unknown revision $badrev"
+                        } else {
+                            set err "unknown revisions: [join $badrev ", "]"
+                        }
+                    } else {
+                        set err [join [lrange $errlines $l end] "\n"]
+                    }
+                    break
+                }
+                lappend badrev $line
+            }
+        }
+        error_popup "[mc "Error parsing revisions:"] $err"
+        return {}
     }
     set ret {}
     set pos {}
     set neg {}
     set sdm 0
     foreach id [split $ids "\n"] {
-	if {$id eq "--gitk-symmetric-diff-marker"} {
-	    set sdm 4
-	} elseif {[string match "^*" $id]} {
-	    if {$sdm != 1} {
-		lappend ret $id
-		if {$sdm == 3} {
-		    set sdm 0
-		}
-	    }
-	    lappend neg [string range $id 1 end]
-	} else {
-	    if {$sdm != 2} {
-		lappend ret $id
-	    } else {
-		lset ret end $id...[lindex $ret end]
-	    }
-	    lappend pos $id
-	}
-	incr sdm -1
+        if {$id eq "--gitk-symmetric-diff-marker"} {
+            set sdm 4
+        } elseif {[string match "^*" $id]} {
+            if {$sdm != 1} {
+                lappend ret $id
+                if {$sdm == 3} {
+                    set sdm 0
+                }
+            }
+            lappend neg [string range $id 1 end]
+        } else {
+            if {$sdm != 2} {
+                lappend ret $id
+            } else {
+                lset ret end $id...[lindex $ret end]
+            }
+            lappend pos $id
+        }
+        incr sdm -1
     }
     set vposids($view) $pos
     set vnegids($view) $neg
@@ -374,63 +374,63 @@ proc start_rev_list {view} {
 
     set args $viewargs($view)
     if {$viewargscmd($view) ne {}} {
-	if {[catch {
-	    set str [exec sh -c $viewargscmd($view)]
-	} err]} {
-	    error_popup "[mc "Error executing --argscmd command:"] $err"
-	    return 0
-	}
-	set args [concat $args [split $str "\n"]]
+        if {[catch {
+            set str [exec sh -c $viewargscmd($view)]
+        } err]} {
+            error_popup "[mc "Error executing --argscmd command:"] $err"
+            return 0
+        }
+        set args [concat $args [split $str "\n"]]
     }
     set vcanopt($view) [parseviewargs $view $args]
 
     set files $viewfiles($view)
     if {$vmergeonly($view)} {
-	set files [unmerged_files $files]
-	if {$files eq {}} {
-	    global nr_unmerged
-	    if {$nr_unmerged == 0} {
-		error_popup [mc "No files selected: --merge specified but\
-			     no files are unmerged."]
-	    } else {
-		error_popup [mc "No files selected: --merge specified but\
-			     no unmerged files are within file limit."]
-	    }
-	    return 0
-	}
+        set files [unmerged_files $files]
+        if {$files eq {}} {
+            global nr_unmerged
+            if {$nr_unmerged == 0} {
+                error_popup [mc "No files selected: --merge specified but\
+                             no files are unmerged."]
+            } else {
+                error_popup [mc "No files selected: --merge specified but\
+                             no unmerged files are within file limit."]
+            }
+            return 0
+        }
     }
     set vfilelimit($view) $files
 
     if {$vcanopt($view)} {
-	set revs [parseviewrevs $view $vrevs($view)]
-	if {$revs eq {}} {
-	    return 0
-	}
-	set args [concat $vflags($view) $revs]
+        set revs [parseviewrevs $view $vrevs($view)]
+        if {$revs eq {}} {
+            return 0
+        }
+        set args [concat $vflags($view) $revs]
     } else {
-	set args $vorigargs($view)
+        set args $vorigargs($view)
     }
 
     if {[catch {
-	set fd [open [concat | git log --no-color -z --pretty=raw $show_notes \
-			--parents --boundary $args "--" $files] r]
+        set fd [open [concat | git log --no-color -z --pretty=raw $show_notes \
+                        --parents --boundary $args "--" $files] r]
     } err]} {
-	error_popup "[mc "Error executing git log:"] $err"
-	return 0
+        error_popup "[mc "Error executing git log:"] $err"
+        return 0
     }
     set i [reg_instance $fd]
     set viewinstances($view) [list $i]
     set viewmainheadid($view) $mainheadid
     set viewmainheadid_orig($view) $mainheadid
     if {$files ne {} && $mainheadid ne {}} {
-	get_viewmainhead $view
+        get_viewmainhead $view
     }
     if {$showlocalchanges && $viewmainheadid($view) ne {}} {
-	interestedin $viewmainheadid($view) dodiffindex
+        interestedin $viewmainheadid($view) dodiffindex
     }
     fconfigure $fd -blocking 0 -translation lf -eofchar {}
     if {$tclencoding != {}} {
-	fconfigure $fd -encoding $tclencoding
+        fconfigure $fd -encoding $tclencoding
     }
     filerun $fd [list getcommitlines $fd $i $view 0]
     nowbusy $view [mc "Reading"]
@@ -444,13 +444,13 @@ proc stop_instance {inst} {
 
     set fd $commfd($inst)
     catch {
-	set pid [pid $fd]
+        set pid [pid $fd]
 
-	if {$::tcl_platform(platform) eq {windows}} {
-	    exec taskkill /pid $pid
-	} else {
-	    exec kill $pid
-	}
+        if {$::tcl_platform(platform) eq {windows}} {
+            exec taskkill /pid $pid
+        } else {
+            exec kill $pid
+        }
     }
     catch {close $fd}
     nukefile $fd
@@ -462,7 +462,7 @@ proc stop_backends {} {
     global commfd
 
     foreach inst [array names commfd] {
-	stop_instance $inst
+        stop_instance $inst
     }
 }
 
@@ -470,7 +470,7 @@ proc stop_rev_list {view} {
     global viewinstances
 
     foreach inst $viewinstances($view) {
-	stop_instance $inst
+        stop_instance $inst
     }
     set viewinstances($view) {}
 }
@@ -479,11 +479,11 @@ proc reset_pending_select {selid} {
     global pending_select mainheadid selectheadid
 
     if {$selid ne {}} {
-	set pending_select $selid
+        set pending_select $selid
     } elseif {$selectheadid ne {}} {
-	set pending_select $selectheadid
+        set pending_select $selectheadid
     } else {
-	set pending_select $mainheadid
+        set pending_select $mainheadid
     }
 }
 
@@ -492,11 +492,11 @@ proc getcommits {selid} {
 
     initlayout
     if {[start_rev_list $curview]} {
-	reset_pending_select $selid
-	show_status [mc "Reading commits..."]
-	set need_redisplay 1
+        reset_pending_select $selid
+        show_status [mc "Reading commits..."]
+        set need_redisplay 1
     } else {
-	show_status [mc "No commits selected"]
+        show_status [mc "No commits selected"]
     }
 }
 
@@ -513,67 +513,67 @@ proc updatecommits {} {
     rereadrefs
     set view $curview
     if {$mainheadid ne $viewmainheadid_orig($view)} {
-	if {$showlocalchanges} {
-	    dohidelocalchanges
-	}
-	set viewmainheadid($view) $mainheadid
-	set viewmainheadid_orig($view) $mainheadid
-	if {$vfilelimit($view) ne {}} {
-	    get_viewmainhead $view
-	}
+        if {$showlocalchanges} {
+            dohidelocalchanges
+        }
+        set viewmainheadid($view) $mainheadid
+        set viewmainheadid_orig($view) $mainheadid
+        if {$vfilelimit($view) ne {}} {
+            get_viewmainhead $view
+        }
     }
     if {$showlocalchanges} {
-	doshowlocalchanges
+        doshowlocalchanges
     }
     if {$vcanopt($view)} {
-	set oldpos $vposids($view)
-	set oldneg $vnegids($view)
-	set revs [parseviewrevs $view $vrevs($view)]
-	if {$revs eq {}} {
-	    return
-	}
-	# note: getting the delta when negative refs change is hard,
-	# and could require multiple git log invocations, so in that
-	# case we ask git log for all the commits (not just the delta)
-	if {$oldneg eq $vnegids($view)} {
-	    set newrevs {}
-	    set npos 0
-	    # take out positive refs that we asked for before or
-	    # that we have already seen
-	    foreach rev $revs {
-		if {[string length $rev] == 40} {
-		    if {[lsearch -exact $oldpos $rev] < 0
-			&& ![info exists varcid($view,$rev)]} {
-			lappend newrevs $rev
-			incr npos
-		    }
-		} else {
-		    lappend $newrevs $rev
-		}
-	    }
-	    if {$npos == 0} return
-	    set revs $newrevs
-	    set vposids($view) [lsort -unique [concat $oldpos $vposids($view)]]
-	}
-	set args [concat $vflags($view) $revs --not $oldpos]
+        set oldpos $vposids($view)
+        set oldneg $vnegids($view)
+        set revs [parseviewrevs $view $vrevs($view)]
+        if {$revs eq {}} {
+            return
+        }
+        # note: getting the delta when negative refs change is hard,
+        # and could require multiple git log invocations, so in that
+        # case we ask git log for all the commits (not just the delta)
+        if {$oldneg eq $vnegids($view)} {
+            set newrevs {}
+            set npos 0
+            # take out positive refs that we asked for before or
+            # that we have already seen
+            foreach rev $revs {
+                if {[string length $rev] == 40} {
+                    if {[lsearch -exact $oldpos $rev] < 0
+                        && ![info exists varcid($view,$rev)]} {
+                        lappend newrevs $rev
+                        incr npos
+                    }
+                } else {
+                    lappend $newrevs $rev
+                }
+            }
+            if {$npos == 0} return
+            set revs $newrevs
+            set vposids($view) [lsort -unique [concat $oldpos $vposids($view)]]
+        }
+        set args [concat $vflags($view) $revs --not $oldpos]
     } else {
-	set args $vorigargs($view)
+        set args $vorigargs($view)
     }
     if {[catch {
-	set fd [open [concat | git log --no-color -z --pretty=raw $show_notes \
-			--parents --boundary $args "--" $vfilelimit($view)] r]
+        set fd [open [concat | git log --no-color -z --pretty=raw $show_notes \
+                        --parents --boundary $args "--" $vfilelimit($view)] r]
     } err]} {
-	error_popup "[mc "Error executing git log:"] $err"
-	return
+        error_popup "[mc "Error executing git log:"] $err"
+        return
     }
     if {$viewactive($view) == 0} {
-	set startmsecs [clock clicks -milliseconds]
+        set startmsecs [clock clicks -milliseconds]
     }
     set i [reg_instance $fd]
     lappend viewinstances($view) $i
     fconfigure $fd -blocking 0 -translation lf -eofchar {}
     if {$tclencoding != {}} {
-	fconfigure $fd -encoding $tclencoding
+        fconfigure $fd -encoding $tclencoding
     }
     filerun $fd [list getcommitlines $fd $i $view 1]
     incr viewactive($view)
@@ -581,7 +581,7 @@ proc updatecommits {} {
     reset_pending_select {}
     nowbusy $view [mc "Reading"]
     if {$showneartags} {
-	getallcommits
+        getallcommits
     }
 }
 
@@ -592,11 +592,11 @@ proc reloadcommits {} {
 
     set selid {}
     if {$selectedline ne {}} {
-	set selid $currentid
+        set selid $currentid
     }
 
     if {!$viewcomplete($curview)} {
-	stop_rev_list $curview
+        stop_rev_list $curview
     }
     resetvarcs $curview
     set selectedline {}
@@ -606,7 +606,7 @@ proc reloadcommits {} {
     readrefs
     changedrefs
     if {$showneartags} {
-	getallcommits
+        getallcommits
     }
     clear_display
     unset -nocomplain commitinfo
@@ -622,11 +622,11 @@ proc reloadcommits {} {
 # sorts as a string in numerical order
 proc strrep {n} {
     if {$n < 16} {
-	return [format "%x" $n]
+        return [format "%x" $n]
     } elseif {$n < 256} {
-	return [format "x%.2x" $n]
+        return [format "x%.2x" $n]
     } elseif {$n < 65536} {
-	return [format "y%.4x" $n]
+        return [format "y%.4x" $n]
     }
     return [format "z%.8x" $n]
 }
@@ -657,22 +657,22 @@ proc resetvarcs {view} {
     global vshortids
 
     foreach vid [array names varcid $view,*] {
-	unset varcid($vid)
-	unset children($vid)
-	unset parents($vid)
+        unset varcid($vid)
+        unset children($vid)
+        unset parents($vid)
     }
     foreach vid [array names vshortids $view,*] {
-	unset vshortids($vid)
+        unset vshortids($vid)
     }
     # some commits might have children but haven't been seen yet
     foreach vid [array names children $view,*] {
-	unset children($vid)
+        unset children($vid)
     }
     foreach va [array names varccommits $view,*] {
-	unset varccommits($va)
+        unset varccommits($va)
     }
     foreach vd [array names vseedcount $view,*] {
-	unset vseedcount($vd)
+        unset vseedcount($vd)
     }
     unset -nocomplain ordertok
 }
@@ -684,8 +684,8 @@ proc seeds {v} {
     set ret {}
     set a [lindex $vdownptr($v) 0]
     while {$a != 0} {
-	lappend ret [lindex $varcstart($v) $a]
-	set a [lindex $vleftptr($v) $a]
+        lappend ret [lindex $varcstart($v) $a]
+        set a [lindex $vleftptr($v) $a]
     }
     return $ret
 }
@@ -698,60 +698,60 @@ proc newvarc {view id} {
     set a [llength $varctok($view)]
     set vid $view,$id
     if {[llength $children($vid)] == 0 || $vdatemode($view)} {
-	if {![info exists commitinfo($id)]} {
-	    parsecommit $id $commitdata($id) 1
-	}
-	set cdate [lindex [lindex $commitinfo($id) 4] 0]
-	if {![string is integer -strict $cdate]} {
-	    set cdate 0
-	}
-	if {![info exists vseedcount($view,$cdate)]} {
-	    set vseedcount($view,$cdate) -1
-	}
-	set c [incr vseedcount($view,$cdate)]
-	set cdate [expr {$cdate ^ 0xffffffff}]
-	set tok "s[strrep $cdate][strrep $c]"
+        if {![info exists commitinfo($id)]} {
+            parsecommit $id $commitdata($id) 1
+        }
+        set cdate [lindex [lindex $commitinfo($id) 4] 0]
+        if {![string is integer -strict $cdate]} {
+            set cdate 0
+        }
+        if {![info exists vseedcount($view,$cdate)]} {
+            set vseedcount($view,$cdate) -1
+        }
+        set c [incr vseedcount($view,$cdate)]
+        set cdate [expr {$cdate ^ 0xffffffff}]
+        set tok "s[strrep $cdate][strrep $c]"
     } else {
-	set tok {}
+        set tok {}
     }
     set ka 0
     if {[llength $children($vid)] > 0} {
-	set kid [lindex $children($vid) end]
-	set k $varcid($view,$kid)
-	if {[string compare [lindex $varctok($view) $k] $tok] > 0} {
-	    set ki $kid
-	    set ka $k
-	    set tok [lindex $varctok($view) $k]
-	}
+        set kid [lindex $children($vid) end]
+        set k $varcid($view,$kid)
+        if {[string compare [lindex $varctok($view) $k] $tok] > 0} {
+            set ki $kid
+            set ka $k
+            set tok [lindex $varctok($view) $k]
+        }
     }
     if {$ka != 0} {
-	set i [lsearch -exact $parents($view,$ki) $id]
-	set j [expr {[llength $parents($view,$ki)] - 1 - $i}]
-	append tok [strrep $j]
+        set i [lsearch -exact $parents($view,$ki) $id]
+        set j [expr {[llength $parents($view,$ki)] - 1 - $i}]
+        append tok [strrep $j]
     }
     set c [lindex $vlastins($view) $ka]
     if {$c == 0 || [string compare $tok [lindex $varctok($view) $c]] < 0} {
-	set c $ka
-	set b [lindex $vdownptr($view) $ka]
+        set c $ka
+        set b [lindex $vdownptr($view) $ka]
     } else {
-	set b [lindex $vleftptr($view) $c]
+        set b [lindex $vleftptr($view) $c]
     }
     while {$b != 0 && [string compare $tok [lindex $varctok($view) $b]] >= 0} {
-	set c $b
-	set b [lindex $vleftptr($view) $c]
+        set c $b
+        set b [lindex $vleftptr($view) $c]
     }
     if {$c == $ka} {
-	lset vdownptr($view) $ka $a
-	lappend vbackptr($view) 0
+        lset vdownptr($view) $ka $a
+        lappend vbackptr($view) 0
     } else {
-	lset vleftptr($view) $c $a
-	lappend vbackptr($view) $c
+        lset vleftptr($view) $c $a
+        lappend vbackptr($view) $c
     }
     lset vlastins($view) $ka $a
     lappend vupptr($view) $ka
     lappend vleftptr($view) $b
     if {$b != 0} {
-	lset vbackptr($view) $b $a
+        lset vbackptr($view) $b $a
     }
     lappend varctok($view) $tok
     lappend varcstart($view) $id
@@ -782,7 +782,7 @@ proc splitvarc {p v} {
     set varccommits($v,$na) [lrange $ac $i end]
     lappend varcstart($v) $p
     foreach id $varccommits($v,$na) {
-	set varcid($v,$id) $na
+        set varcid($v,$id) $na
     }
     lappend vdownptr($v) [lindex $vdownptr($v) $oa]
     lappend vlastins($v) [lindex $vlastins($v) $oa]
@@ -792,10 +792,10 @@ proc splitvarc {p v} {
     lappend vleftptr($v) 0
     lappend vbackptr($v) 0
     for {set b [lindex $vdownptr($v) $na]} {$b != 0} {set b [lindex $vleftptr($v) $b]} {
-	lset vupptr($v) $b $na
+        lset vupptr($v) $b $na
     }
     if {[string compare $otok $vtokmod($v)] <= 0} {
-	modify_arc $v $oa
+        modify_arc $v $oa
     }
 }
 
@@ -809,120 +809,120 @@ proc renumbervarc {a v} {
     set kidchanged($a) 1
     set ntot 0
     while {$a != 0} {
-	if {[info exists isrelated($a)]} {
-	    lappend todo $a
-	    set id [lindex $varccommits($v,$a) end]
-	    foreach p $parents($v,$id) {
-		if {[info exists varcid($v,$p)]} {
-		    set isrelated($varcid($v,$p)) 1
-		}
-	    }
-	}
-	incr ntot
-	set b [lindex $vdownptr($v) $a]
-	if {$b == 0} {
-	    while {$a != 0} {
-		set b [lindex $vleftptr($v) $a]
-		if {$b != 0} break
-		set a [lindex $vupptr($v) $a]
-	    }
-	}
-	set a $b
+        if {[info exists isrelated($a)]} {
+            lappend todo $a
+            set id [lindex $varccommits($v,$a) end]
+            foreach p $parents($v,$id) {
+                if {[info exists varcid($v,$p)]} {
+                    set isrelated($varcid($v,$p)) 1
+                }
+            }
+        }
+        incr ntot
+        set b [lindex $vdownptr($v) $a]
+        if {$b == 0} {
+            while {$a != 0} {
+                set b [lindex $vleftptr($v) $a]
+                if {$b != 0} break
+                set a [lindex $vupptr($v) $a]
+            }
+        }
+        set a $b
     }
     foreach a $todo {
-	if {![info exists kidchanged($a)]} continue
-	set id [lindex $varcstart($v) $a]
-	if {[llength $children($v,$id)] > 1} {
-	    set children($v,$id) [lsort -command [list vtokcmp $v] \
-				      $children($v,$id)]
-	}
-	set oldtok [lindex $varctok($v) $a]
-	if {!$vdatemode($v)} {
-	    set tok {}
-	} else {
-	    set tok $oldtok
-	}
-	set ka 0
-	set kid [last_real_child $v,$id]
-	if {$kid ne {}} {
-	    set k $varcid($v,$kid)
-	    if {[string compare [lindex $varctok($v) $k] $tok] > 0} {
-		set ki $kid
-		set ka $k
-		set tok [lindex $varctok($v) $k]
-	    }
-	}
-	if {$ka != 0} {
-	    set i [lsearch -exact $parents($v,$ki) $id]
-	    set j [expr {[llength $parents($v,$ki)] - 1 - $i}]
-	    append tok [strrep $j]
-	}
-	if {$tok eq $oldtok} {
-	    continue
-	}
-	set id [lindex $varccommits($v,$a) end]
-	foreach p $parents($v,$id) {
-	    if {[info exists varcid($v,$p)]} {
-		set kidchanged($varcid($v,$p)) 1
-	    } else {
-		set sortkids($p) 1
-	    }
-	}
-	lset varctok($v) $a $tok
-	set b [lindex $vupptr($v) $a]
-	if {$b != $ka} {
-	    if {[string compare [lindex $varctok($v) $ka] $vtokmod($v)] < 0} {
-		modify_arc $v $ka
-	    }
-	    if {[string compare [lindex $varctok($v) $b] $vtokmod($v)] < 0} {
-		modify_arc $v $b
-	    }
-	    set c [lindex $vbackptr($v) $a]
-	    set d [lindex $vleftptr($v) $a]
-	    if {$c == 0} {
-		lset vdownptr($v) $b $d
-	    } else {
-		lset vleftptr($v) $c $d
-	    }
-	    if {$d != 0} {
-		lset vbackptr($v) $d $c
-	    }
-	    if {[lindex $vlastins($v) $b] == $a} {
-		lset vlastins($v) $b $c
-	    }
-	    lset vupptr($v) $a $ka
-	    set c [lindex $vlastins($v) $ka]
-	    if {$c == 0 || \
-		    [string compare $tok [lindex $varctok($v) $c]] < 0} {
-		set c $ka
-		set b [lindex $vdownptr($v) $ka]
-	    } else {
-		set b [lindex $vleftptr($v) $c]
-	    }
-	    while {$b != 0 && \
-		      [string compare $tok [lindex $varctok($v) $b]] >= 0} {
-		set c $b
-		set b [lindex $vleftptr($v) $c]
-	    }
-	    if {$c == $ka} {
- 		lset vdownptr($v) $ka $a
-		lset vbackptr($v) $a 0
-	    } else {
-		lset vleftptr($v) $c $a
-		lset vbackptr($v) $a $c
-	    }
-	    lset vleftptr($v) $a $b
-	    if {$b != 0} {
-		lset vbackptr($v) $b $a
-	    }
-	    lset vlastins($v) $ka $a
-	}
+        if {![info exists kidchanged($a)]} continue
+        set id [lindex $varcstart($v) $a]
+        if {[llength $children($v,$id)] > 1} {
+            set children($v,$id) [lsort -command [list vtokcmp $v] \
+                                      $children($v,$id)]
+        }
+        set oldtok [lindex $varctok($v) $a]
+        if {!$vdatemode($v)} {
+            set tok {}
+        } else {
+            set tok $oldtok
+        }
+        set ka 0
+        set kid [last_real_child $v,$id]
+        if {$kid ne {}} {
+            set k $varcid($v,$kid)
+            if {[string compare [lindex $varctok($v) $k] $tok] > 0} {
+                set ki $kid
+                set ka $k
+                set tok [lindex $varctok($v) $k]
+            }
+        }
+        if {$ka != 0} {
+            set i [lsearch -exact $parents($v,$ki) $id]
+            set j [expr {[llength $parents($v,$ki)] - 1 - $i}]
+            append tok [strrep $j]
+        }
+        if {$tok eq $oldtok} {
+            continue
+        }
+        set id [lindex $varccommits($v,$a) end]
+        foreach p $parents($v,$id) {
+            if {[info exists varcid($v,$p)]} {
+                set kidchanged($varcid($v,$p)) 1
+            } else {
+                set sortkids($p) 1
+            }
+        }
+        lset varctok($v) $a $tok
+        set b [lindex $vupptr($v) $a]
+        if {$b != $ka} {
+            if {[string compare [lindex $varctok($v) $ka] $vtokmod($v)] < 0} {
+                modify_arc $v $ka
+            }
+            if {[string compare [lindex $varctok($v) $b] $vtokmod($v)] < 0} {
+                modify_arc $v $b
+            }
+            set c [lindex $vbackptr($v) $a]
+            set d [lindex $vleftptr($v) $a]
+            if {$c == 0} {
+                lset vdownptr($v) $b $d
+            } else {
+                lset vleftptr($v) $c $d
+            }
+            if {$d != 0} {
+                lset vbackptr($v) $d $c
+            }
+            if {[lindex $vlastins($v) $b] == $a} {
+                lset vlastins($v) $b $c
+            }
+            lset vupptr($v) $a $ka
+            set c [lindex $vlastins($v) $ka]
+            if {$c == 0 || \
+                    [string compare $tok [lindex $varctok($v) $c]] < 0} {
+                set c $ka
+                set b [lindex $vdownptr($v) $ka]
+            } else {
+                set b [lindex $vleftptr($v) $c]
+            }
+            while {$b != 0 && \
+                      [string compare $tok [lindex $varctok($v) $b]] >= 0} {
+                set c $b
+                set b [lindex $vleftptr($v) $c]
+            }
+            if {$c == $ka} {
+                lset vdownptr($v) $ka $a
+                lset vbackptr($v) $a 0
+            } else {
+                lset vleftptr($v) $c $a
+                lset vbackptr($v) $a $c
+            }
+            lset vleftptr($v) $a $b
+            if {$b != 0} {
+                lset vbackptr($v) $b $a
+            }
+            lset vlastins($v) $ka $a
+        }
     }
     foreach id [array names sortkids] {
-	if {[llength $children($v,$id)] > 1} {
-	    set children($v,$id) [lsort -command [list vtokcmp $v] \
-				      $children($v,$id)]
-	}
+        if {[llength $children($v,$id)] > 1} {
+            set children($v,$id) [lsort -command [list vtokcmp $v] \
+                                      $children($v,$id)]
+        }
     }
     set t2 [clock clicks -milliseconds]
     #puts "renumbervarc did [llength $todo] of $ntot arcs in [expr {$t2-$t1}]ms"
@@ -936,14 +936,14 @@ proc fix_reversal {p a v} {
 
     set pa $varcid($v,$p)
     if {$p ne [lindex $varcstart($v) $pa]} {
-	splitvarc $p $v
-	set pa $varcid($v,$p)
+        splitvarc $p $v
+        set pa $varcid($v,$p)
     }
     # seeds always need to be renumbered
     if {[lindex $vupptr($v) $pa] == 0 ||
-	[string compare [lindex $varctok($v) $a] \
-	     [lindex $varctok($v) $pa]] > 0} {
-	renumbervarc $pa $v
+        [string compare [lindex $varctok($v) $a] \
+             [lindex $varctok($v) $pa]] > 0} {
+        renumbervarc $pa $v
     }
 }
 
@@ -961,24 +961,24 @@ proc insertrow {id p v} {
     set varcid($vid) $a
     lappend vshortids($v,[string range $id 0 3]) $id
     if {[string compare [lindex $varctok($v) $a] $vtokmod($v)] < 0} {
-	modify_arc $v $a
+        modify_arc $v $a
     }
     lappend varccommits($v,$a) $id
     set vp $v,$p
     if {[llength [lappend children($vp) $id]] > 1} {
-	set children($vp) [lsort -command [list vtokcmp $v] $children($vp)]
-	unset -nocomplain ordertok
+        set children($vp) [lsort -command [list vtokcmp $v] $children($vp)]
+        unset -nocomplain ordertok
     }
     fix_reversal $p $a $v
     incr commitidx($v)
     if {$v == $curview} {
-	set numcommits $commitidx($v)
-	setcanvscroll
-	if {[info exists targetid]} {
-	    if {![comes_before $targetid $p]} {
-		incr targetrow
-	    }
-	}
+        set numcommits $commitidx($v)
+        setcanvscroll
+        if {[info exists targetid]} {
+            if {![comes_before $targetid $p]} {
+                incr targetrow
+            }
+        }
     }
 }
 
@@ -990,8 +990,8 @@ proc insertfakerow {id p} {
     set a $varcid($v,$p)
     set i [lsearch -exact $varccommits($v,$a) $p]
     if {$i < 0} {
-	puts "oops: insertfakerow can't find [shortids $p] on arc $a"
-	return
+        puts "oops: insertfakerow can't find [shortids $p] on arc $a"
+        return
     }
     set children($v,$id) {}
     set parents($v,$id) [list $p]
@@ -1003,9 +1003,9 @@ proc insertfakerow {id p} {
     set varccommits($v,$a) [linsert $varccommits($v,$a) $i $id]
     modify_arc $v $a $i
     if {[info exists targetid]} {
-	if {![comes_before $targetid $p]} {
-	    incr targetrow
-	}
+        if {![comes_before $targetid $p]} {
+            incr targetrow
+        }
     }
     setcanvscroll
     drawvisible
@@ -1018,15 +1018,15 @@ proc removefakerow {id} {
 
     set v $curview
     if {[llength $parents($v,$id)] != 1} {
-	puts "oops: removefakerow [shortids $id] has [llength $parents($v,$id)] parents"
-	return
+        puts "oops: removefakerow [shortids $id] has [llength $parents($v,$id)] parents"
+        return
     }
     set p [lindex $parents($v,$id) 0]
     set a $varcid($v,$id)
     set i [lsearch -exact $varccommits($v,$a) $id]
     if {$i < 0} {
-	puts "oops: removefakerow can't find [shortids $id] on arc $a"
-	return
+        puts "oops: removefakerow can't find [shortids $id] on arc $a"
+        return
     }
     unset varcid($v,$id)
     set varccommits($v,$a) [lreplace $varccommits($v,$a) $i $i]
@@ -1036,15 +1036,15 @@ proc removefakerow {id} {
     set numcommits [incr commitidx($v) -1]
     set j [lsearch -exact $children($v,$p) $id]
     if {$j >= 0} {
-	set children($v,$p) [lreplace $children($v,$p) $j $j]
+        set children($v,$p) [lreplace $children($v,$p) $j $j]
     }
     modify_arc $v $a $i
     if {[info exist currentid] && $id eq $currentid} {
-	unset currentid
-	set selectedline {}
+        unset currentid
+        set selectedline {}
     }
     if {[info exists targetid] && $targetid eq $id} {
-	set targetid $p
+        set targetid $p
     }
     setcanvscroll
     drawvisible
@@ -1055,9 +1055,9 @@ proc real_children {vp} {
 
     set kids {}
     foreach id $children($vp) {
-	if {$id ne $nullid && $id ne $nullid2} {
-	    lappend kids $id
-	}
+        if {$id ne $nullid && $id ne $nullid2} {
+            lappend kids $id
+        }
     }
     return $kids
 }
@@ -1066,9 +1066,9 @@ proc first_real_child {vp} {
     global children nullid nullid2
 
     foreach id $children($vp) {
-	if {$id ne $nullid && $id ne $nullid2} {
-	    return $id
-	}
+        if {$id ne $nullid && $id ne $nullid2} {
+            return $id
+        }
     }
     return {}
 }
@@ -1078,10 +1078,10 @@ proc last_real_child {vp} {
 
     set kids $children($vp)
     for {set i [llength $kids]} {[incr i -1] >= 0} {} {
-	set id [lindex $kids $i]
-	if {$id ne $nullid && $id ne $nullid2} {
-	    return $id
-	}
+        set id [lindex $kids $i]
+        if {$id ne $nullid && $id ne $nullid2} {
+            return $id
+        }
     }
     return {}
 }
@@ -1090,7 +1090,7 @@ proc vtokcmp {v a b} {
     global varctok varcid
 
     return [string compare [lindex $varctok($v) $varcid($v,$a)] \
-		[lindex $varctok($v) $varcid($v,$b)]]
+                [lindex $varctok($v) $varcid($v,$b)]]
 }
 
 # This assumes that if lim is not given, the caller has checked that
@@ -1099,29 +1099,29 @@ proc modify_arc {v a {lim {}}} {
     global varctok vtokmod varcmod varcrow vupptr curview vrowmod varccommits
 
     if {$lim ne {}} {
-	set c [string compare [lindex $varctok($v) $a] $vtokmod($v)]
-	if {$c > 0} return
-	if {$c == 0} {
-	    set r [lindex $varcrow($v) $a]
-	    if {$r ne {} && $vrowmod($v) <= $r + $lim} return
-	}
+        set c [string compare [lindex $varctok($v) $a] $vtokmod($v)]
+        if {$c > 0} return
+        if {$c == 0} {
+            set r [lindex $varcrow($v) $a]
+            if {$r ne {} && $vrowmod($v) <= $r + $lim} return
+        }
     }
     set vtokmod($v) [lindex $varctok($v) $a]
     set varcmod($v) $a
     if {$v == $curview} {
-	while {$a != 0 && [lindex $varcrow($v) $a] eq {}} {
-	    set a [lindex $vupptr($v) $a]
-	    set lim {}
-	}
-	set r 0
-	if {$a != 0} {
-	    if {$lim eq {}} {
-		set lim [llength $varccommits($v,$a)]
-	    }
-	    set r [expr {[lindex $varcrow($v) $a] + $lim}]
-	}
-	set vrowmod($v) $r
-	undolayout $r
+        while {$a != 0 && [lindex $varcrow($v) $a] eq {}} {
+            set a [lindex $vupptr($v) $a]
+            set lim {}
+        }
+        set r 0
+        if {$a != 0} {
+            if {$lim eq {}} {
+                set lim [llength $varccommits($v,$a)]
+            }
+            set r [expr {[lindex $varcrow($v) $a] + $lim}]
+        }
+        set vrowmod($v) $r
+        undolayout $r
     }
 }
 
@@ -1133,62 +1133,62 @@ proc update_arcrows {v} {
 
     if {$vrowmod($v) == $commitidx($v)} return
     if {$v == $curview} {
-	if {[llength $displayorder] > $vrowmod($v)} {
-	    set displayorder [lrange $displayorder 0 [expr {$vrowmod($v) - 1}]]
-	    set parentlist [lrange $parentlist 0 [expr {$vrowmod($v) - 1}]]
-	}
-	unset -nocomplain cached_commitrow
+        if {[llength $displayorder] > $vrowmod($v)} {
+            set displayorder [lrange $displayorder 0 [expr {$vrowmod($v) - 1}]]
+            set parentlist [lrange $parentlist 0 [expr {$vrowmod($v) - 1}]]
+        }
+        unset -nocomplain cached_commitrow
     }
     set narctot [expr {[llength $varctok($v)] - 1}]
     set a $varcmod($v)
     while {$a != 0 && [lindex $varcix($v) $a] eq {}} {
-	# go up the tree until we find something that has a row number,
-	# or we get to a seed
-	set a [lindex $vupptr($v) $a]
+        # go up the tree until we find something that has a row number,
+        # or we get to a seed
+        set a [lindex $vupptr($v) $a]
     }
     if {$a == 0} {
-	set a [lindex $vdownptr($v) 0]
-	if {$a == 0} return
-	set vrownum($v) {0}
-	set varcorder($v) [list $a]
-	lset varcix($v) $a 0
-	lset varcrow($v) $a 0
-	set arcn 0
-	set row 0
+        set a [lindex $vdownptr($v) 0]
+        if {$a == 0} return
+        set vrownum($v) {0}
+        set varcorder($v) [list $a]
+        lset varcix($v) $a 0
+        lset varcrow($v) $a 0
+        set arcn 0
+        set row 0
     } else {
-	set arcn [lindex $varcix($v) $a]
-	if {[llength $vrownum($v)] > $arcn + 1} {
-	    set vrownum($v) [lrange $vrownum($v) 0 $arcn]
-	    set varcorder($v) [lrange $varcorder($v) 0 $arcn]
-	}
-	set row [lindex $varcrow($v) $a]
+        set arcn [lindex $varcix($v) $a]
+        if {[llength $vrownum($v)] > $arcn + 1} {
+            set vrownum($v) [lrange $vrownum($v) 0 $arcn]
+            set varcorder($v) [lrange $varcorder($v) 0 $arcn]
+        }
+        set row [lindex $varcrow($v) $a]
     }
     while {1} {
-	set p $a
-	incr row [llength $varccommits($v,$a)]
-	# go down if possible
-	set b [lindex $vdownptr($v) $a]
-	if {$b == 0} {
-	    # if not, go left, or go up until we can go left
-	    while {$a != 0} {
-		set b [lindex $vleftptr($v) $a]
-		if {$b != 0} break
-		set a [lindex $vupptr($v) $a]
-	    }
-	    if {$a == 0} break
-	}
-	set a $b
-	incr arcn
-	lappend vrownum($v) $row
-	lappend varcorder($v) $a
-	lset varcix($v) $a $arcn
-	lset varcrow($v) $a $row
+        set p $a
+        incr row [llength $varccommits($v,$a)]
+        # go down if possible
+        set b [lindex $vdownptr($v) $a]
+        if {$b == 0} {
+            # if not, go left, or go up until we can go left
+            while {$a != 0} {
+                set b [lindex $vleftptr($v) $a]
+                if {$b != 0} break
+                set a [lindex $vupptr($v) $a]
+            }
+            if {$a == 0} break
+        }
+        set a $b
+        incr arcn
+        lappend vrownum($v) $row
+        lappend varcorder($v) $a
+        lset varcix($v) $a $arcn
+        lset varcrow($v) $a $row
     }
     set vtokmod($v) [lindex $varctok($v) $p]
     set varcmod($v) $p
     set vrowmod($v) $row
     if {[info exists currentid]} {
-	set selectedline [rowofcommit $currentid]
+        set selectedline [rowofcommit $currentid]
     }
 }
 
@@ -1206,20 +1206,20 @@ proc rowofcommit {id} {
 
     set v $curview
     if {![info exists varcid($v,$id)]} {
-	puts "oops rowofcommit no arc for [shortids $id]"
-	return {}
+        puts "oops rowofcommit no arc for [shortids $id]"
+        return {}
     }
     set a $varcid($v,$id)
     if {[string compare [lindex $varctok($v) $a] $vtokmod($v)] >= 0} {
-	update_arcrows $v
+        update_arcrows $v
     }
     if {[info exists cached_commitrow($id)]} {
-	return $cached_commitrow($id)
+        return $cached_commitrow($id)
     }
     set i [lsearch -exact $varccommits($v,$a) $id]
     if {$i < 0} {
-	puts "oops didn't find commit [shortids $id] in arc $a"
-	return {}
+        puts "oops didn't find commit [shortids $id] in arc $a"
+        return {}
     }
     incr i [lindex $varcrow($v) $a]
     set cached_commitrow($id) $i
@@ -1232,32 +1232,32 @@ proc comes_before {a b} {
 
     set v $curview
     if {$a eq $b || ![info exists varcid($v,$a)] || \
-	    ![info exists varcid($v,$b)]} {
-	return 0
+            ![info exists varcid($v,$b)]} {
+        return 0
     }
     if {$varcid($v,$a) != $varcid($v,$b)} {
-	return [expr {[string compare [lindex $varctok($v) $varcid($v,$a)] \
-			   [lindex $varctok($v) $varcid($v,$b)]] < 0}]
+        return [expr {[string compare [lindex $varctok($v) $varcid($v,$a)] \
+                           [lindex $varctok($v) $varcid($v,$b)]] < 0}]
     }
     return [expr {[rowofcommit $a] < [rowofcommit $b]}]
 }
 
 proc bsearch {l elt} {
     if {[llength $l] == 0 || $elt <= [lindex $l 0]} {
-	return 0
+        return 0
     }
     set lo 0
     set hi [llength $l]
     while {$hi - $lo > 1} {
-	set mid [expr {int(($lo + $hi) / 2)}]
-	set t [lindex $l $mid]
-	if {$elt < $t} {
-	    set hi $mid
-	} elseif {$elt > $t} {
-	    set lo $mid
-	} else {
-	    return $mid
-	}
+        set mid [expr {int(($lo + $hi) / 2)}]
+        set t [lindex $l $mid]
+        if {$elt < $t} {
+            set hi $mid
+        } elseif {$elt > $t} {
+            set lo $mid
+        } else {
+            return $mid
+        }
     }
     return $lo
 }
@@ -1269,37 +1269,37 @@ proc make_disporder {start end} {
     global d_valid_start d_valid_end
 
     if {$end > $vrowmod($curview)} {
-	update_arcrows $curview
+        update_arcrows $curview
     }
     set ai [bsearch $vrownum($curview) $start]
     set start [lindex $vrownum($curview) $ai]
     set narc [llength $vrownum($curview)]
     for {set r $start} {$ai < $narc && $r < $end} {incr ai} {
-	set a [lindex $varcorder($curview) $ai]
-	set l [llength $displayorder]
-	set al [llength $varccommits($curview,$a)]
-	if {$l < $r + $al} {
-	    if {$l < $r} {
-		set pad [ntimes [expr {$r - $l}] {}]
-		set displayorder [concat $displayorder $pad]
-		set parentlist [concat $parentlist $pad]
-	    } elseif {$l > $r} {
-		set displayorder [lrange $displayorder 0 [expr {$r - 1}]]
-		set parentlist [lrange $parentlist 0 [expr {$r - 1}]]
-	    }
-	    foreach id $varccommits($curview,$a) {
-		lappend displayorder $id
-		lappend parentlist $parents($curview,$id)
-	    }
-	} elseif {[lindex $displayorder [expr {$r + $al - 1}]] eq {}} {
-	    set i $r
-	    foreach id $varccommits($curview,$a) {
-		lset displayorder $i $id
-		lset parentlist $i $parents($curview,$id)
-		incr i
-	    }
-	}
-	incr r $al
+        set a [lindex $varcorder($curview) $ai]
+        set l [llength $displayorder]
+        set al [llength $varccommits($curview,$a)]
+        if {$l < $r + $al} {
+            if {$l < $r} {
+                set pad [ntimes [expr {$r - $l}] {}]
+                set displayorder [concat $displayorder $pad]
+                set parentlist [concat $parentlist $pad]
+            } elseif {$l > $r} {
+                set displayorder [lrange $displayorder 0 [expr {$r - 1}]]
+                set parentlist [lrange $parentlist 0 [expr {$r - 1}]]
+            }
+            foreach id $varccommits($curview,$a) {
+                lappend displayorder $id
+                lappend parentlist $parents($curview,$id)
+            }
+        } elseif {[lindex $displayorder [expr {$r + $al - 1}]] eq {}} {
+            set i $r
+            foreach id $varccommits($curview,$a) {
+                lset displayorder $i $id
+                lset parentlist $i $parents($curview,$id)
+                incr i
+            }
+        }
+        incr r $al
     }
 }
 
@@ -1308,8 +1308,8 @@ proc commitonrow {row} {
 
     set id [lindex $displayorder $row]
     if {$id eq {}} {
-	make_disporder $row [expr {$row + 1}]
-	set id [lindex $displayorder $row]
+        make_disporder $row [expr {$row + 1}]
+        set id [lindex $displayorder $row]
     }
     return $id
 }
@@ -1322,35 +1322,35 @@ proc closevarcs {v} {
     set scripts {}
     set narcs [llength $varctok($v)]
     for {set a 1} {$a < $narcs} {incr a} {
-	set id [lindex $varccommits($v,$a) end]
-	foreach p $parents($v,$id) {
-	    if {[info exists varcid($v,$p)]} continue
-	    # add p as a new commit
-	    incr missing_parents
-	    set cmitlisted($v,$p) 0
-	    set parents($v,$p) {}
-	    if {[llength $children($v,$p)] == 1 &&
-		[llength $parents($v,$id)] == 1} {
-		set b $a
-	    } else {
-		set b [newvarc $v $p]
-	    }
-	    set varcid($v,$p) $b
-	    if {[string compare [lindex $varctok($v) $b] $vtokmod($v)] < 0} {
-		modify_arc $v $b
-	    }
-	    lappend varccommits($v,$b) $p
-	    incr commitidx($v)
-	    if {$v == $curview} {
-		set numcommits $commitidx($v)
-	    }
-	    set scripts [check_interest $p $scripts]
-	}
+        set id [lindex $varccommits($v,$a) end]
+        foreach p $parents($v,$id) {
+            if {[info exists varcid($v,$p)]} continue
+            # add p as a new commit
+            incr missing_parents
+            set cmitlisted($v,$p) 0
+            set parents($v,$p) {}
+            if {[llength $children($v,$p)] == 1 &&
+                [llength $parents($v,$id)] == 1} {
+                set b $a
+            } else {
+                set b [newvarc $v $p]
+            }
+            set varcid($v,$p) $b
+            if {[string compare [lindex $varctok($v) $b] $vtokmod($v)] < 0} {
+                modify_arc $v $b
+            }
+            lappend varccommits($v,$b) $p
+            incr commitidx($v)
+            if {$v == $curview} {
+                set numcommits $commitidx($v)
+            }
+            set scripts [check_interest $p $scripts]
+        }
     }
     if {$missing_parents > 0} {
-	foreach s $scripts {
-	    eval $s
-	}
+        foreach s $scripts {
+            eval $s
+        }
     }
 }
 
@@ -1360,23 +1360,23 @@ proc rewrite_commit {v id rwid} {
     global children parents varcid varctok vtokmod varccommits
 
     foreach ch $children($v,$id) {
-	# make $rwid be $ch's parent in place of $id
-	set i [lsearch -exact $parents($v,$ch) $id]
-	if {$i < 0} {
-	    puts "oops rewrite_commit didn't find $id in parent list for $ch"
-	}
-	set parents($v,$ch) [lreplace $parents($v,$ch) $i $i $rwid]
-	# add $ch to $rwid's children and sort the list if necessary
-	if {[llength [lappend children($v,$rwid) $ch]] > 1} {
-	    set children($v,$rwid) [lsort -command [list vtokcmp $v] \
-					$children($v,$rwid)]
-	}
-	# fix the graph after joining $id to $rwid
-	set a $varcid($v,$ch)
-	fix_reversal $rwid $a $v
-	# parentlist is wrong for the last element of arc $a
-	# even if displayorder is right, hence the 3rd arg here
-	modify_arc $v $a [expr {[llength $varccommits($v,$a)] - 1}]
+        # make $rwid be $ch's parent in place of $id
+        set i [lsearch -exact $parents($v,$ch) $id]
+        if {$i < 0} {
+            puts "oops rewrite_commit didn't find $id in parent list for $ch"
+        }
+        set parents($v,$ch) [lreplace $parents($v,$ch) $i $i $rwid]
+        # add $ch to $rwid's children and sort the list if necessary
+        if {[llength [lappend children($v,$rwid) $ch]] > 1} {
+            set children($v,$rwid) [lsort -command [list vtokcmp $v] \
+                                        $children($v,$rwid)]
+        }
+        # fix the graph after joining $id to $rwid
+        set a $varcid($v,$ch)
+        fix_reversal $rwid $a $v
+        # parentlist is wrong for the last element of arc $a
+        # even if displayorder is right, hence the 3rd arg here
+        modify_arc $v $a [expr {[llength $varccommits($v,$a)] - 1}]
     }
 }
 
@@ -1396,19 +1396,19 @@ proc check_interest {id scripts} {
 
     set prefix [string range $id 0 3]
     if {[info exists commitinterest($prefix)]} {
-	set newlist {}
-	foreach {i script} $commitinterest($prefix) {
-	    if {[string match "$i*" $id]} {
-		lappend scripts [string map [list "%I" $id "%P" $i] $script]
-	    } else {
-		lappend newlist $i $script
-	    }
-	}
-	if {$newlist ne {}} {
-	    set commitinterest($prefix) $newlist
-	} else {
-	    unset commitinterest($prefix)
-	}
+        set newlist {}
+        foreach {i script} $commitinterest($prefix) {
+            if {[string match "$i*" $id]} {
+                lappend scripts [string map [list "%I" $id "%P" $i] $script]
+            } else {
+                lappend newlist $i $script
+            }
+        }
+        if {$newlist ne {}} {
+            set commitinterest($prefix) $newlist
+        } else {
+            unset commitinterest($prefix)
+        }
     }
     return $scripts
 }
@@ -1423,192 +1423,192 @@ proc getcommitlines {fd inst view updating}  {
     set stuff [read $fd 500000]
     # git log doesn't terminate the last commit with a null...
     if {$stuff == {} && $leftover($inst) ne {} && [eof $fd]} {
-	set stuff "\0"
+        set stuff "\0"
     }
     if {$stuff == {}} {
-	if {![eof $fd]} {
-	    return 1
-	}
-	global commfd viewcomplete viewactive viewname
-	global viewinstances
-	unset commfd($inst)
-	set i [lsearch -exact $viewinstances($view) $inst]
-	if {$i >= 0} {
-	    set viewinstances($view) [lreplace $viewinstances($view) $i $i]
-	}
-	# set it blocking so we wait for the process to terminate
-	fconfigure $fd -blocking 1
-	if {[catch {close $fd} err]} {
-	    set fv {}
-	    if {$view != $curview} {
-		set fv " for the \"$viewname($view)\" view"
-	    }
-	    if {[string range $err 0 4] == "usage"} {
-		set err "Gitk: error reading commits$fv:\
-			bad arguments to git log."
-		if {$viewname($view) eq [mc "Command line"]} {
-		    append err \
-			"  (Note: arguments to gitk are passed to git log\
-			 to allow selection of commits to be displayed.)"
-		}
-	    } else {
-		set err "Error reading commits$fv: $err"
-	    }
-	    error_popup $err
-	}
-	if {[incr viewactive($view) -1] <= 0} {
-	    set viewcomplete($view) 1
-	    # Check if we have seen any ids listed as parents that haven't
-	    # appeared in the list
-	    closevarcs $view
-	    notbusy $view
-	}
-	if {$view == $curview} {
-	    run chewcommits
-	}
-	return 0
+        if {![eof $fd]} {
+            return 1
+        }
+        global commfd viewcomplete viewactive viewname
+        global viewinstances
+        unset commfd($inst)
+        set i [lsearch -exact $viewinstances($view) $inst]
+        if {$i >= 0} {
+            set viewinstances($view) [lreplace $viewinstances($view) $i $i]
+        }
+        # set it blocking so we wait for the process to terminate
+        fconfigure $fd -blocking 1
+        if {[catch {close $fd} err]} {
+            set fv {}
+            if {$view != $curview} {
+                set fv " for the \"$viewname($view)\" view"
+            }
+            if {[string range $err 0 4] == "usage"} {
+                set err "Gitk: error reading commits$fv:\
+                        bad arguments to git log."
+                if {$viewname($view) eq [mc "Command line"]} {
+                    append err \
+                        "  (Note: arguments to gitk are passed to git log\
+                         to allow selection of commits to be displayed.)"
+                }
+            } else {
+                set err "Error reading commits$fv: $err"
+            }
+            error_popup $err
+        }
+        if {[incr viewactive($view) -1] <= 0} {
+            set viewcomplete($view) 1
+            # Check if we have seen any ids listed as parents that haven't
+            # appeared in the list
+            closevarcs $view
+            notbusy $view
+        }
+        if {$view == $curview} {
+            run chewcommits
+        }
+        return 0
     }
     set start 0
     set gotsome 0
     set scripts {}
     while 1 {
-	set i [string first "\0" $stuff $start]
-	if {$i < 0} {
-	    append leftover($inst) [string range $stuff $start end]
-	    break
-	}
-	if {$start == 0} {
-	    set cmit $leftover($inst)
-	    append cmit [string range $stuff 0 [expr {$i - 1}]]
-	    set leftover($inst) {}
-	} else {
-	    set cmit [string range $stuff $start [expr {$i - 1}]]
-	}
-	set start [expr {$i + 1}]
-	set j [string first "\n" $cmit]
-	set ok 0
-	set listed 1
-	if {$j >= 0 && [string match "commit *" $cmit]} {
-	    set ids [string range $cmit 7 [expr {$j - 1}]]
-	    if {[string match {[-^<>]*} $ids]} {
-		switch -- [string index $ids 0] {
-		    "-" {set listed 0}
-		    "^" {set listed 2}
-		    "<" {set listed 3}
-		    ">" {set listed 4}
-		}
-		set ids [string range $ids 1 end]
-	    }
-	    set ok 1
-	    foreach id $ids {
-		if {[string length $id] != 40} {
-		    set ok 0
-		    break
-		}
-	    }
-	}
-	if {!$ok} {
-	    set shortcmit $cmit
-	    if {[string length $shortcmit] > 80} {
-		set shortcmit "[string range $shortcmit 0 80]..."
-	    }
-	    error_popup "[mc "Can't parse git log output:"] {$shortcmit}"
-	    exit 1
-	}
-	set id [lindex $ids 0]
-	set vid $view,$id
+        set i [string first "\0" $stuff $start]
+        if {$i < 0} {
+            append leftover($inst) [string range $stuff $start end]
+            break
+        }
+        if {$start == 0} {
+            set cmit $leftover($inst)
+            append cmit [string range $stuff 0 [expr {$i - 1}]]
+            set leftover($inst) {}
+        } else {
+            set cmit [string range $stuff $start [expr {$i - 1}]]
+        }
+        set start [expr {$i + 1}]
+        set j [string first "\n" $cmit]
+        set ok 0
+        set listed 1
+        if {$j >= 0 && [string match "commit *" $cmit]} {
+            set ids [string range $cmit 7 [expr {$j - 1}]]
+            if {[string match {[-^<>]*} $ids]} {
+                switch -- [string index $ids 0] {
+                    "-" {set listed 0}
+                    "^" {set listed 2}
+                    "<" {set listed 3}
+                    ">" {set listed 4}
+                }
+                set ids [string range $ids 1 end]
+            }
+            set ok 1
+            foreach id $ids {
+                if {[string length $id] != 40} {
+                    set ok 0
+                    break
+                }
+            }
+        }
+        if {!$ok} {
+            set shortcmit $cmit
+            if {[string length $shortcmit] > 80} {
+                set shortcmit "[string range $shortcmit 0 80]..."
+            }
+            error_popup "[mc "Can't parse git log output:"] {$shortcmit}"
+            exit 1
+        }
+        set id [lindex $ids 0]
+        set vid $view,$id
 
-	lappend vshortids($view,[string range $id 0 3]) $id
+        lappend vshortids($view,[string range $id 0 3]) $id
 
-	if {!$listed && $updating && ![info exists varcid($vid)] &&
-	    $vfilelimit($view) ne {}} {
-	    # git log doesn't rewrite parents for unlisted commits
-	    # when doing path limiting, so work around that here
-	    # by working out the rewritten parent with git rev-list
-	    # and if we already know about it, using the rewritten
-	    # parent as a substitute parent for $id's children.
-	    if {![catch {
-		set rwid [exec git rev-list --first-parent --max-count=1 \
-			      $id -- $vfilelimit($view)]
-	    }]} {
-		if {$rwid ne {} && [info exists varcid($view,$rwid)]} {
-		    # use $rwid in place of $id
-		    rewrite_commit $view $id $rwid
-		    continue
-		}
-	    }
-	}
+        if {!$listed && $updating && ![info exists varcid($vid)] &&
+            $vfilelimit($view) ne {}} {
+            # git log doesn't rewrite parents for unlisted commits
+            # when doing path limiting, so work around that here
+            # by working out the rewritten parent with git rev-list
+            # and if we already know about it, using the rewritten
+            # parent as a substitute parent for $id's children.
+            if {![catch {
+                set rwid [exec git rev-list --first-parent --max-count=1 \
+                              $id -- $vfilelimit($view)]
+            }]} {
+                if {$rwid ne {} && [info exists varcid($view,$rwid)]} {
+                    # use $rwid in place of $id
+                    rewrite_commit $view $id $rwid
+                    continue
+                }
+            }
+        }
 
-	set a 0
-	if {[info exists varcid($vid)]} {
-	    if {$cmitlisted($vid) || !$listed} continue
-	    set a $varcid($vid)
-	}
-	if {$listed} {
-	    set olds [lrange $ids 1 end]
-	} else {
-	    set olds {}
-	}
-	set commitdata($id) [string range $cmit [expr {$j + 1}] end]
-	set cmitlisted($vid) $listed
-	set parents($vid) $olds
-	if {![info exists children($vid)]} {
-	    set children($vid) {}
-	} elseif {$a == 0 && [llength $children($vid)] == 1} {
-	    set k [lindex $children($vid) 0]
-	    if {[llength $parents($view,$k)] == 1 &&
-		(!$vdatemode($view) ||
-		 $varcid($view,$k) == [llength $varctok($view)] - 1)} {
-		set a $varcid($view,$k)
-	    }
-	}
-	if {$a == 0} {
-	    # new arc
-	    set a [newvarc $view $id]
-	}
-	if {[string compare [lindex $varctok($view) $a] $vtokmod($view)] < 0} {
-	    modify_arc $view $a
-	}
-	if {![info exists varcid($vid)]} {
-	    set varcid($vid) $a
-	    lappend varccommits($view,$a) $id
-	    incr commitidx($view)
-	}
+        set a 0
+        if {[info exists varcid($vid)]} {
+            if {$cmitlisted($vid) || !$listed} continue
+            set a $varcid($vid)
+        }
+        if {$listed} {
+            set olds [lrange $ids 1 end]
+        } else {
+            set olds {}
+        }
+        set commitdata($id) [string range $cmit [expr {$j + 1}] end]
+        set cmitlisted($vid) $listed
+        set parents($vid) $olds
+        if {![info exists children($vid)]} {
+            set children($vid) {}
+        } elseif {$a == 0 && [llength $children($vid)] == 1} {
+            set k [lindex $children($vid) 0]
+            if {[llength $parents($view,$k)] == 1 &&
+                (!$vdatemode($view) ||
+                 $varcid($view,$k) == [llength $varctok($view)] - 1)} {
+                set a $varcid($view,$k)
+            }
+        }
+        if {$a == 0} {
+            # new arc
+            set a [newvarc $view $id]
+        }
+        if {[string compare [lindex $varctok($view) $a] $vtokmod($view)] < 0} {
+            modify_arc $view $a
+        }
+        if {![info exists varcid($vid)]} {
+            set varcid($vid) $a
+            lappend varccommits($view,$a) $id
+            incr commitidx($view)
+        }
 
-	set i 0
-	foreach p $olds {
-	    if {$i == 0 || [lsearch -exact $olds $p] >= $i} {
-		set vp $view,$p
-		if {[llength [lappend children($vp) $id]] > 1 &&
-		    [vtokcmp $view [lindex $children($vp) end-1] $id] > 0} {
-		    set children($vp) [lsort -command [list vtokcmp $view] \
-					   $children($vp)]
-		    unset -nocomplain ordertok
-		}
-		if {[info exists varcid($view,$p)]} {
-		    fix_reversal $p $a $view
-		}
-	    }
-	    incr i
-	}
+        set i 0
+        foreach p $olds {
+            if {$i == 0 || [lsearch -exact $olds $p] >= $i} {
+                set vp $view,$p
+                if {[llength [lappend children($vp) $id]] > 1 &&
+                    [vtokcmp $view [lindex $children($vp) end-1] $id] > 0} {
+                    set children($vp) [lsort -command [list vtokcmp $view] \
+                                           $children($vp)]
+                    unset -nocomplain ordertok
+                }
+                if {[info exists varcid($view,$p)]} {
+                    fix_reversal $p $a $view
+                }
+            }
+            incr i
+        }
 
-	set scripts [check_interest $id $scripts]
-	set gotsome 1
+        set scripts [check_interest $id $scripts]
+        set gotsome 1
     }
     if {$gotsome} {
-	global numcommits hlview
+        global numcommits hlview
 
-	if {$view == $curview} {
-	    set numcommits $commitidx($view)
-	    run chewcommits
-	}
-	if {[info exists hlview] && $view == $hlview} {
-	    # we never actually get here...
-	    run vhighlightmore
-	}
-	foreach s $scripts {
-	    eval $s
-	}
+        if {$view == $curview} {
+            set numcommits $commitidx($view)
+            run chewcommits
+        }
+        if {[info exists hlview] && $view == $hlview} {
+            # we never actually get here...
+            run vhighlightmore
+        }
+        foreach s $scripts {
+            eval $s
+        }
     }
     return 2
 }
@@ -1619,28 +1619,28 @@ proc chewcommits {} {
 
     layoutmore
     if {$viewcomplete($curview)} {
-	global commitidx varctok
-	global numcommits startmsecs
+        global commitidx varctok
+        global numcommits startmsecs
 
-	if {[info exists pending_select]} {
-	    update
-	    reset_pending_select {}
+        if {[info exists pending_select]} {
+            update
+            reset_pending_select {}
 
-	    if {[commitinview $pending_select $curview]} {
-		selectline [rowofcommit $pending_select] 1
-	    } else {
-		set row [first_real_row]
-		selectline $row 1
-	    }
-	}
-	if {$commitidx($curview) > 0} {
-	    #set ms [expr {[clock clicks -milliseconds] - $startmsecs}]
-	    #puts "overall $ms ms for $numcommits commits"
-	    #puts "[llength $varctok($view)] arcs, $commitidx($view) commits"
-	} else {
-	    show_status [mc "No commits selected"]
-	}
-	notbusy layout
+            if {[commitinview $pending_select $curview]} {
+                selectline [rowofcommit $pending_select] 1
+            } else {
+                set row [first_real_row]
+                selectline $row 1
+            }
+        }
+        if {$commitidx($curview) > 0} {
+            #set ms [expr {[clock clicks -milliseconds] - $startmsecs}]
+            #puts "overall $ms ms for $numcommits commits"
+            #puts "[llength $varctok($view)] arcs, $commitidx($view) commits"
+        } else {
+            show_status [mc "No commits selected"]
+        }
+        notbusy layout
     }
     return 0
 }
@@ -1653,7 +1653,7 @@ proc do_readcommit {id} {
     # Read the results using i18n.logoutputencoding
     fconfigure $fd -translation lf -eofchar {}
     if {$tclencoding != {}} {
-	fconfigure $fd -encoding $tclencoding
+        fconfigure $fd -encoding $tclencoding
     }
     set contents [read $fd]
     close $fd
@@ -1680,44 +1680,44 @@ proc parsecommit {id contents listed} {
     set comdate {}
     set hdrend [string first "\n\n" $contents]
     if {$hdrend < 0} {
-	# should never happen...
-	set hdrend [string length $contents]
+        # should never happen...
+        set hdrend [string length $contents]
     }
     set header [string range $contents 0 [expr {$hdrend - 1}]]
     set comment [string range $contents [expr {$hdrend + 2}] end]
     foreach line [split $header "\n"] {
-	set line [split $line " "]
-	set tag [lindex $line 0]
-	if {$tag == "author"} {
-	    set audate [lrange $line end-1 end]
-	    set auname [join [lrange $line 1 end-2] " "]
-	} elseif {$tag == "committer"} {
-	    set comdate [lrange $line end-1 end]
-	    set comname [join [lrange $line 1 end-2] " "]
-	}
+        set line [split $line " "]
+        set tag [lindex $line 0]
+        if {$tag == "author"} {
+            set audate [lrange $line end-1 end]
+            set auname [join [lrange $line 1 end-2] " "]
+        } elseif {$tag == "committer"} {
+            set comdate [lrange $line end-1 end]
+            set comname [join [lrange $line 1 end-2] " "]
+        }
     }
     set headline {}
     # take the first non-blank line of the comment as the headline
     set headline [string trimleft $comment]
     set i [string first "\n" $headline]
     if {$i >= 0} {
-	set headline [string range $headline 0 $i]
+        set headline [string range $headline 0 $i]
     }
     set headline [string trimright $headline]
     set i [string first "\r" $headline]
     if {$i >= 0} {
-	set headline [string trimright [string range $headline 0 $i]]
+        set headline [string trimright [string range $headline 0 $i]]
     }
     if {!$listed} {
-	# git log indents the comment by 4 spaces;
-	# if we got this via git cat-file, add the indentation
-	set newcomment {}
-	foreach line [split $comment "\n"] {
-	    append newcomment "    "
-	    append newcomment $line
-	    append newcomment "\n"
-	}
-	set comment $newcomment
+        # git log indents the comment by 4 spaces;
+        # if we got this via git cat-file, add the indentation
+        set newcomment {}
+        foreach line [split $comment "\n"] {
+            append newcomment "    "
+            append newcomment $line
+            append newcomment "\n"
+        }
+        set comment $newcomment
     }
     set hasnote [string first "\nNotes:\n" $contents]
     set diff ""
@@ -1726,23 +1726,23 @@ proc parsecommit {id contents listed} {
     # diff.
     set i [string first "\n\ndiff" $comment]
     if {$i >= 0} {
-	set diff [string range $comment $i+1 end]
-	set comment [string range $comment 0 $i-1]
+        set diff [string range $comment $i+1 end]
+        set comment [string range $comment 0 $i-1]
     }
     set commitinfo($id) [list $headline $auname $audate \
-			     $comname $comdate $comment $hasnote $diff]
+                             $comname $comdate $comment $hasnote $diff]
 }
 
 proc getcommit {id} {
     global commitdata commitinfo
 
     if {[info exists commitdata($id)]} {
-	parsecommit $id $commitdata($id) 1
+        parsecommit $id $commitdata($id) 1
     } else {
-	readcommit $id
-	if {![info exists commitinfo($id)]} {
-	    set commitinfo($id) [list [mc "No commit information available"]]
-	}
+        readcommit $id
+        if {![info exists commitinfo($id)]} {
+            set commitinfo($id) [list [mc "No commit information available"]]
+        }
     }
     return 1
 }
@@ -1755,22 +1755,22 @@ proc longid {prefix} {
 
     set ids {}
     if {[string length $prefix] >= 4} {
-	set vshortid $curview,[string range $prefix 0 3]
-	if {[info exists vshortids($vshortid)]} {
-	    foreach id $vshortids($vshortid) {
-		if {[string match "$prefix*" $id]} {
-		    if {[lsearch -exact $ids $id] < 0} {
-			lappend ids $id
-			if {[llength $ids] >= 2} break
-		    }
-		}
-	    }
-	}
+        set vshortid $curview,[string range $prefix 0 3]
+        if {[info exists vshortids($vshortid)]} {
+            foreach id $vshortids($vshortid) {
+                if {[string match "$prefix*" $id]} {
+                    if {[lsearch -exact $ids $id] < 0} {
+                        lappend ids $id
+                        if {[llength $ids] >= 2} break
+                    }
+                }
+            }
+        }
     } else {
-	foreach match [array names varcid "$curview,$prefix*"] {
-	    lappend ids [lindex [split $match ","] 1]
-	    if {[llength $ids] >= 2} break
-	}
+        foreach match [array names varcid "$curview,$prefix*"] {
+            lappend ids [lindex [split $match ","] 1]
+            if {[llength $ids] >= 2} break
+        }
     }
     return $ids
 }
@@ -1783,58 +1783,58 @@ proc readrefs {} {
     global tclencoding
 
     foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
-	unset -nocomplain $v
+        unset -nocomplain $v
     }
     set refd [open [list | git show-ref -d] r]
     if {$tclencoding != {}} {
-	fconfigure $refd -encoding $tclencoding
+        fconfigure $refd -encoding $tclencoding
     }
     while {[gets $refd line] >= 0} {
-	if {[string index $line 40] ne " "} continue
-	set id [string range $line 0 39]
-	set ref [string range $line 41 end]
-	if {![string match "refs/*" $ref]} continue
-	set name [string range $ref 5 end]
-	if {[string match "remotes/*" $name]} {
-	    if {![string match "*/HEAD" $name] && !$hideremotes} {
-		set headids($name) $id
-		lappend idheads($id) $name
-	    }
-	} elseif {[string match "heads/*" $name]} {
-	    set name [string range $name 6 end]
-	    set headids($name) $id
-	    lappend idheads($id) $name
-	} elseif {[string match "tags/*" $name]} {
-	    # this lets refs/tags/foo^{} overwrite refs/tags/foo,
-	    # which is what we want since the former is the commit ID
-	    set name [string range $name 5 end]
-	    if {[string match "*^{}" $name]} {
-		set name [string range $name 0 end-3]
-	    } else {
-		set tagobjid($name) $id
-	    }
-	    set tagids($name) $id
-	    lappend idtags($id) $name
-	} else {
-	    set otherrefids($name) $id
-	    lappend idotherrefs($id) $name
-	}
+        if {[string index $line 40] ne " "} continue
+        set id [string range $line 0 39]
+        set ref [string range $line 41 end]
+        if {![string match "refs/*" $ref]} continue
+        set name [string range $ref 5 end]
+        if {[string match "remotes/*" $name]} {
+            if {![string match "*/HEAD" $name] && !$hideremotes} {
+                set headids($name) $id
+                lappend idheads($id) $name
+            }
+        } elseif {[string match "heads/*" $name]} {
+            set name [string range $name 6 end]
+            set headids($name) $id
+            lappend idheads($id) $name
+        } elseif {[string match "tags/*" $name]} {
+            # this lets refs/tags/foo^{} overwrite refs/tags/foo,
+            # which is what we want since the former is the commit ID
+            set name [string range $name 5 end]
+            if {[string match "*^{}" $name]} {
+                set name [string range $name 0 end-3]
+            } else {
+                set tagobjid($name) $id
+            }
+            set tagids($name) $id
+            lappend idtags($id) $name
+        } else {
+            set otherrefids($name) $id
+            lappend idotherrefs($id) $name
+        }
     }
     catch {close $refd}
     set mainhead {}
     set mainheadid {}
     catch {
-	set mainheadid [exec git rev-parse HEAD]
-	set thehead [exec git symbolic-ref HEAD]
-	if {[string match "refs/heads/*" $thehead]} {
-	    set mainhead [string range $thehead 11 end]
-	}
+        set mainheadid [exec git rev-parse HEAD]
+        set thehead [exec git symbolic-ref HEAD]
+        if {[string match "refs/heads/*" $thehead]} {
+            set mainhead [string range $thehead 11 end]
+        }
     }
     set selectheadid {}
     if {$selecthead ne {}} {
-	catch {
-	    set selectheadid [exec git rev-parse --verify $selecthead]
-	}
+        catch {
+            set selectheadid [exec git rev-parse --verify $selecthead]
+        }
     }
 }
 
@@ -1843,10 +1843,10 @@ proc first_real_row {} {
     global nullid nullid2 numcommits
 
     for {set row 0} {$row < $numcommits} {incr row} {
-	set id [commitonrow $row]
-	if {$id ne $nullid && $id ne $nullid2} {
-	    break
-	}
+        set id [commitonrow $row]
+        if {$id ne $nullid && $id ne $nullid2} {
+            break
+        }
     }
     return $row
 }
@@ -1865,12 +1865,12 @@ proc removehead {id name} {
     global headids idheads
 
     if {$idheads($id) eq $name} {
-	unset idheads($id)
+        unset idheads($id)
     } else {
-	set i [lsearch -exact $idheads($id) $name]
-	if {$i >= 0} {
-	    set idheads($id) [lreplace $idheads($id) $i $i]
-	}
+        set i [lsearch -exact $idheads($id) $name]
+        if {$i >= 0} {
+            set idheads($id) [lreplace $idheads($id) $i $i]
+        }
     }
     unset headids($name)
 }
@@ -1898,7 +1898,7 @@ proc make_transient {window origin} {
     # Windows fails to place transient windows normally, so
     # schedule a callback to center them on the parent.
     if {[tk windowingsystem] eq {win32}} {
-	after idle [list tk::PlaceWindow $window widget $origin]
+        after idle [list tk::PlaceWindow $window widget $origin]
     }
 }
 
@@ -1998,41 +1998,41 @@ proc setttkstyle {} {
 proc makemenu {m items} {
     menu $m
     if {[tk windowingsystem] eq {aqua}} {
-	set Meta1 Cmd
+        set Meta1 Cmd
     } else {
-	set Meta1 Ctrl
+        set Meta1 Ctrl
     }
     foreach i $items {
-	set name [mc [lindex $i 1]]
-	set type [lindex $i 2]
-	set thing [lindex $i 3]
-	set params [list $type]
-	if {$name ne {}} {
-	    set u [string first "&" [string map {&& x} $name]]
-	    lappend params -label [string map {&& & & {}} $name]
-	    if {$u >= 0} {
-		lappend params -underline $u
-	    }
-	}
-	switch -- $type {
-	    "cascade" {
-		set submenu [string tolower [string map {& ""} [lindex $i 1]]]
-		lappend params -menu $m.$submenu
-	    }
-	    "command" {
-		lappend params -command $thing
-	    }
-	    "radiobutton" {
-		lappend params -variable [lindex $thing 0] \
-		    -value [lindex $thing 1]
-	    }
-	}
-	set tail [lrange $i 4 end]
-	regsub -all {\yMeta1\y} $tail $Meta1 tail
-	eval $m add $params $tail
-	if {$type eq "cascade"} {
-	    makemenu $m.$submenu $thing
-	}
+        set name [mc [lindex $i 1]]
+        set type [lindex $i 2]
+        set thing [lindex $i 3]
+        set params [list $type]
+        if {$name ne {}} {
+            set u [string first "&" [string map {&& x} $name]]
+            lappend params -label [string map {&& & & {}} $name]
+            if {$u >= 0} {
+                lappend params -underline $u
+            }
+        }
+        switch -- $type {
+            "cascade" {
+                set submenu [string tolower [string map {& ""} [lindex $i 1]]]
+                lappend params -menu $m.$submenu
+            }
+            "command" {
+                lappend params -command $thing
+            }
+            "radiobutton" {
+                lappend params -variable [lindex $thing 0] \
+                    -value [lindex $thing 1]
+            }
+        }
+        set tail [lrange $i 4 end]
+        regsub -all {\yMeta1\y} $tail $Meta1 tail
+        eval $m add $params $tail
+        if {$type eq "cascade"} {
+            makemenu $m.$submenu $thing
+        }
     }
 }
 
@@ -2052,12 +2052,12 @@ proc makedroplist {w varname args} {
             set cx [string length $label]
             if {$cx > $width} {set width $cx}
         }
-	set gm [ttk::combobox $w -width $width -state readonly\
-		    -textvariable $varname -values $args \
-		    -exportselection false]
-	bind $gm <<ComboboxSelected>> [list $gm selection clear]
+        set gm [ttk::combobox $w -width $width -state readonly\
+                    -textvariable $varname -values $args \
+                    -exportselection false]
+        bind $gm <<ComboboxSelected>> [list $gm selection clear]
     } else {
-	set gm [eval [linsert $args 0 tk_optionMenu $w $varname]]
+        set gm [eval [linsert $args 0 tk_optionMenu $w $varname]]
     }
     return $gm
 }
@@ -2087,49 +2087,49 @@ proc makewindow {} {
     # The "mc" arguments here are purely so that xgettext
     # sees the following string as needing to be translated
     set file {
-	mc "&File" cascade {
-	    {mc "&Update" command updatecommits -accelerator F5}
-	    {mc "&Reload" command reloadcommits -accelerator Shift-F5}
-	    {mc "Reread re&ferences" command rereadrefs}
-	    {mc "&List references" command showrefs -accelerator F2}
-	    {xx "" separator}
-	    {mc "Start git &gui" command {exec git gui &}}
-	    {xx "" separator}
-	    {mc "&Quit" command doquit -accelerator Meta1-Q}
-	}}
+        mc "&File" cascade {
+            {mc "&Update" command updatecommits -accelerator F5}
+            {mc "&Reload" command reloadcommits -accelerator Shift-F5}
+            {mc "Reread re&ferences" command rereadrefs}
+            {mc "&List references" command showrefs -accelerator F2}
+            {xx "" separator}
+            {mc "Start git &gui" command {exec git gui &}}
+            {xx "" separator}
+            {mc "&Quit" command doquit -accelerator Meta1-Q}
+        }}
     set edit {
-	mc "&Edit" cascade {
-	    {mc "&Preferences" command doprefs}
-	}}
+        mc "&Edit" cascade {
+            {mc "&Preferences" command doprefs}
+        }}
     set view {
-	mc "&View" cascade {
-	    {mc "&New view..." command {newview 0} -accelerator Shift-F4}
-	    {mc "&Edit view..." command editview -state disabled -accelerator F4}
-	    {mc "&Delete view" command delview -state disabled}
-	    {xx "" separator}
-	    {mc "&All files" radiobutton {selectedview 0} -command {showview 0}}
-	}}
+        mc "&View" cascade {
+            {mc "&New view..." command {newview 0} -accelerator Shift-F4}
+            {mc "&Edit view..." command editview -state disabled -accelerator F4}
+            {mc "&Delete view" command delview -state disabled}
+            {xx "" separator}
+            {mc "&All files" radiobutton {selectedview 0} -command {showview 0}}
+        }}
     if {[tk windowingsystem] ne "aqua"} {
-	set help {
-	mc "&Help" cascade {
-	    {mc "&About gitk" command about}
-	    {mc "&Key bindings" command keys}
-	}}
-	set bar [list $file $edit $view $help]
+        set help {
+        mc "&Help" cascade {
+            {mc "&About gitk" command about}
+            {mc "&Key bindings" command keys}
+        }}
+        set bar [list $file $edit $view $help]
     } else {
-	proc ::tk::mac::ShowPreferences {} {doprefs}
-	proc ::tk::mac::Quit {} {doquit}
-	lset file end [lreplace [lindex $file end] end-1 end]
-	set apple {
-	xx "&Apple" cascade {
-	    {mc "&About gitk" command about}
-	    {xx "" separator}
-	}}
-	set help {
-	mc "&Help" cascade {
-	    {mc "&Key bindings" command keys}
-	}}
-	set bar [list $apple $file $view $help]
+        proc ::tk::mac::ShowPreferences {} {doprefs}
+        proc ::tk::mac::Quit {} {doquit}
+        lset file end [lreplace [lindex $file end] end-1 end]
+        set apple {
+        xx "&Apple" cascade {
+            {mc "&About gitk" command about}
+            {xx "" separator}
+        }}
+        set help {
+        mc "&Help" cascade {
+            {mc "&Key bindings" command keys}
+        }}
+        set bar [list $apple $file $view $help]
     }
     makemenu .bar $bar
     . configure -menu .bar
@@ -2157,36 +2157,36 @@ proc makewindow {} {
     ${NS}::frame .tf.histframe
     ${NS}::panedwindow .tf.histframe.pwclist -orient horizontal
     if {!$use_ttk} {
-	.tf.histframe.pwclist configure -sashpad 0 -handlesize 4
+        .tf.histframe.pwclist configure -sashpad 0 -handlesize 4
     }
 
     # create three canvases
     set cscroll .tf.histframe.csb
     set canv .tf.histframe.pwclist.canv
     canvas $canv \
-	-selectbackground $selectbgcolor \
-	-background $bgcolor -bd 0 \
-	-yscrollincr $linespc -yscrollcommand "scrollcanv $cscroll"
+        -selectbackground $selectbgcolor \
+        -background $bgcolor -bd 0 \
+        -yscrollincr $linespc -yscrollcommand "scrollcanv $cscroll"
     .tf.histframe.pwclist add $canv
     set canv2 .tf.histframe.pwclist.canv2
     canvas $canv2 \
-	-selectbackground $selectbgcolor \
-	-background $bgcolor -bd 0 -yscrollincr $linespc
+        -selectbackground $selectbgcolor \
+        -background $bgcolor -bd 0 -yscrollincr $linespc
     .tf.histframe.pwclist add $canv2
     set canv3 .tf.histframe.pwclist.canv3
     canvas $canv3 \
-	-selectbackground $selectbgcolor \
-	-background $bgcolor -bd 0 -yscrollincr $linespc
+        -selectbackground $selectbgcolor \
+        -background $bgcolor -bd 0 -yscrollincr $linespc
     .tf.histframe.pwclist add $canv3
     if {$use_ttk} {
-	bind .tf.histframe.pwclist <Map> {
-	    bind %W <Map> {}
-	    .tf.histframe.pwclist sashpos 1 [lindex $::geometry(pwsash1) 0]
-	    .tf.histframe.pwclist sashpos 0 [lindex $::geometry(pwsash0) 0]
-	}
+        bind .tf.histframe.pwclist <Map> {
+            bind %W <Map> {}
+            .tf.histframe.pwclist sashpos 1 [lindex $::geometry(pwsash1) 0]
+            .tf.histframe.pwclist sashpos 0 [lindex $::geometry(pwsash0) 0]
+        }
     } else {
-	eval .tf.histframe.pwclist sash place 0 $geometry(pwsash0)
-	eval .tf.histframe.pwclist sash place 1 $geometry(pwsash1)
+        eval .tf.histframe.pwclist sash place 0 $geometry(pwsash0)
+        eval .tf.histframe.pwclist sash place 1 $geometry(pwsash1)
     }
 
     # a scroll bar to rule them
@@ -2205,7 +2205,7 @@ proc makewindow {} {
     set entries $sha1entry
     set sha1but .tf.bar.sha1label
     button $sha1but -text "[mc "SHA1 ID:"] " -state disabled -relief flat \
-	-command gotocommit -width 8
+        -command gotocommit -width 8
     $sha1but conf -disabledforeground [$sha1but cget -foreground]
     pack .tf.bar.sha1label -side left
     ${NS}::entry $sha1entry -width 40 -font textfont -textvariable sha1string
@@ -2213,20 +2213,20 @@ proc makewindow {} {
     pack $sha1entry -side left -pady 2
 
     set bm_left_data {
-	#define left_width 16
-	#define left_height 16
-	static unsigned char left_bits[] = {
-	0x00, 0x00, 0xc0, 0x01, 0xe0, 0x00, 0x70, 0x00, 0x38, 0x00, 0x1c, 0x00,
-	0x0e, 0x00, 0xff, 0x7f, 0xff, 0x7f, 0xff, 0x7f, 0x0e, 0x00, 0x1c, 0x00,
-	0x38, 0x00, 0x70, 0x00, 0xe0, 0x00, 0xc0, 0x01};
+        #define left_width 16
+        #define left_height 16
+        static unsigned char left_bits[] = {
+        0x00, 0x00, 0xc0, 0x01, 0xe0, 0x00, 0x70, 0x00, 0x38, 0x00, 0x1c, 0x00,
+        0x0e, 0x00, 0xff, 0x7f, 0xff, 0x7f, 0xff, 0x7f, 0x0e, 0x00, 0x1c, 0x00,
+        0x38, 0x00, 0x70, 0x00, 0xe0, 0x00, 0xc0, 0x01};
     }
     set bm_right_data {
-	#define right_width 16
-	#define right_height 16
-	static unsigned char right_bits[] = {
-	0x00, 0x00, 0xc0, 0x01, 0x80, 0x03, 0x00, 0x07, 0x00, 0x0e, 0x00, 0x1c,
-	0x00, 0x38, 0xff, 0x7f, 0xff, 0x7f, 0xff, 0x7f, 0x00, 0x38, 0x00, 0x1c,
-	0x00, 0x0e, 0x00, 0x07, 0x80, 0x03, 0xc0, 0x01};
+        #define right_width 16
+        #define right_height 16
+        static unsigned char right_bits[] = {
+        0x00, 0x00, 0xc0, 0x01, 0x80, 0x03, 0x00, 0x07, 0x00, 0x0e, 0x00, 0x1c,
+        0x00, 0x38, 0xff, 0x7f, 0xff, 0x7f, 0xff, 0x7f, 0x00, 0x38, 0x00, 0x1c,
+        0x00, 0x0e, 0x00, 0x07, 0x80, 0x03, 0xc0, 0x01};
     }
     image create bitmap bm-left -data $bm_left_data -foreground $uifgcolor
     image create bitmap bm-left-gray -data $bm_left_data -foreground $uifgdisabledcolor
@@ -2235,28 +2235,28 @@ proc makewindow {} {
 
     ${NS}::button .tf.bar.leftbut -command goback -state disabled -width 26
     if {$use_ttk} {
-	.tf.bar.leftbut configure -image [list bm-left disabled bm-left-gray]
+        .tf.bar.leftbut configure -image [list bm-left disabled bm-left-gray]
     } else {
-	.tf.bar.leftbut configure -image bm-left
+        .tf.bar.leftbut configure -image bm-left
     }
     pack .tf.bar.leftbut -side left -fill y
     ${NS}::button .tf.bar.rightbut -command goforw -state disabled -width 26
     if {$use_ttk} {
-	.tf.bar.rightbut configure -image [list bm-right disabled bm-right-gray]
+        .tf.bar.rightbut configure -image [list bm-right disabled bm-right-gray]
     } else {
-	.tf.bar.rightbut configure -image bm-right
+        .tf.bar.rightbut configure -image bm-right
     }
     pack .tf.bar.rightbut -side left -fill y
 
     ${NS}::label .tf.bar.rowlabel -text [mc "Row"]
     set rownumsel {}
     ${NS}::label .tf.bar.rownum -width 7 -textvariable rownumsel \
-	-relief sunken -anchor e
+        -relief sunken -anchor e
     ${NS}::label .tf.bar.rowlabel2 -text "/"
     ${NS}::label .tf.bar.numcommits -width 7 -textvariable numcommits \
-	-relief sunken -anchor e
+        -relief sunken -anchor e
     pack .tf.bar.rowlabel .tf.bar.rownum .tf.bar.rowlabel2 .tf.bar.numcommits \
-	-side left
+        -side left
     if {!$use_ttk} {
         foreach w {rownum numcommits} {.tf.bar.$w configure -font textfont}
     }
@@ -2268,14 +2268,14 @@ proc makewindow {} {
     ${NS}::label $statusw -width 15 -relief sunken
     pack $statusw -side left -padx 5
     if {$use_ttk} {
-	set progresscanv [ttk::progressbar .tf.bar.progress]
+        set progresscanv [ttk::progressbar .tf.bar.progress]
     } else {
-	set h [expr {[font metrics uifont -linespace] + 2}]
-	set progresscanv .tf.bar.progress
-	canvas $progresscanv -relief sunken -height $h -borderwidth 2
-	set progressitem [$progresscanv create rect -1 0 0 $h -fill "#00ff00"]
-	set fprogitem [$progresscanv create rect -1 0 0 $h -fill yellow]
-	set rprogitem [$progresscanv create rect -1 0 0 $h -fill red]
+        set h [expr {[font metrics uifont -linespace] + 2}]
+        set progresscanv .tf.bar.progress
+        canvas $progresscanv -relief sunken -height $h -borderwidth 2
+        set progressitem [$progresscanv create rect -1 0 0 $h -fill "#00ff00"]
+        set fprogitem [$progresscanv create rect -1 0 0 $h -fill yellow]
+        set rprogitem [$progresscanv create rect -1 0 0 $h -fill red]
     }
     pack $progresscanv -side right -expand 1 -fill x -padx {0 2}
     set progresscoords {0 0}
@@ -2289,26 +2289,26 @@ proc makewindow {} {
     ${NS}::label .tf.lbar.flabel -text "[mc "Find"] "
 
     set bm_down_data {
-	#define down_width 16
-	#define down_height 16
-	static unsigned char down_bits[] = {
-	0x80, 0x01, 0x80, 0x01, 0x80, 0x01, 0x80, 0x01,
-	0x80, 0x01, 0x80, 0x01, 0x80, 0x01, 0x80, 0x01,
-	0x87, 0xe1, 0x8e, 0x71, 0x9c, 0x39, 0xb8, 0x1d,
-	0xf0, 0x0f, 0xe0, 0x07, 0xc0, 0x03, 0x80, 0x01};
+        #define down_width 16
+        #define down_height 16
+        static unsigned char down_bits[] = {
+        0x80, 0x01, 0x80, 0x01, 0x80, 0x01, 0x80, 0x01,
+        0x80, 0x01, 0x80, 0x01, 0x80, 0x01, 0x80, 0x01,
+        0x87, 0xe1, 0x8e, 0x71, 0x9c, 0x39, 0xb8, 0x1d,
+        0xf0, 0x0f, 0xe0, 0x07, 0xc0, 0x03, 0x80, 0x01};
     }
     image create bitmap bm-down -data $bm_down_data -foreground $uifgcolor
     ${NS}::button .tf.lbar.fnext -width 26 -command {dofind 1 1}
     .tf.lbar.fnext configure -image bm-down
 
     set bm_up_data {
-	#define up_width 16
-	#define up_height 16
-	static unsigned char up_bits[] = {
-	0x80, 0x01, 0xc0, 0x03, 0xe0, 0x07, 0xf0, 0x0f,
-	0xb8, 0x1d, 0x9c, 0x39, 0x8e, 0x71, 0x87, 0xe1,
-	0x80, 0x01, 0x80, 0x01, 0x80, 0x01, 0x80, 0x01,
-	0x80, 0x01, 0x80, 0x01, 0x80, 0x01, 0x80, 0x01};
+        #define up_width 16
+        #define up_height 16
+        static unsigned char up_bits[] = {
+        0x80, 0x01, 0xc0, 0x03, 0xe0, 0x07, 0xf0, 0x0f,
+        0xb8, 0x1d, 0x9c, 0x39, 0x8e, 0x71, 0x87, 0xe1,
+        0x80, 0x01, 0x80, 0x01, 0x80, 0x01, 0x80, 0x01,
+        0x80, 0x01, 0x80, 0x01, 0x80, 0x01, 0x80, 0x01};
     }
     image create bitmap bm-up -data $bm_up_data -foreground $uifgcolor
     ${NS}::button .tf.lbar.fprev -width 26 -command {dofind -1 1}
@@ -2317,13 +2317,13 @@ proc makewindow {} {
     ${NS}::label .tf.lbar.flab2 -text " [mc "commit"] "
 
     pack .tf.lbar.flabel .tf.lbar.fnext .tf.lbar.fprev .tf.lbar.flab2 \
-	-side left -fill y
+        -side left -fill y
     set gdttype [mc "containing:"]
     set gm [makedroplist .tf.lbar.gdttype gdttype \
-		[mc "containing:"] \
-		[mc "touching paths:"] \
-		[mc "adding/removing string:"] \
-		[mc "changing lines matching:"]]
+                [mc "containing:"] \
+                [mc "touching paths:"] \
+                [mc "adding/removing string:"] \
+                [mc "changing lines matching:"]]
     trace add variable gdttype write gdttype_change
     pack .tf.lbar.gdttype -side left -fill y
 
@@ -2334,11 +2334,11 @@ proc makewindow {} {
     trace add variable findstring write find_change
     set findtype [mc "Exact"]
     set findtypemenu [makedroplist .tf.lbar.findtype \
-			  findtype [mc "Exact"] [mc "IgnCase"] [mc "Regexp"]]
+                          findtype [mc "Exact"] [mc "IgnCase"] [mc "Regexp"]]
     trace add variable findtype write findcom_change
     set findloc [mc "All fields"]
     makedroplist .tf.lbar.findloc findloc [mc "All fields"] [mc "Headline"] \
-	[mc "Comments"] [mc "Author"] [mc "Committer"]
+        [mc "Comments"] [mc "Author"] [mc "Committer"]
     trace add variable findloc write find_change
     pack .tf.lbar.findloc -side right
     pack .tf.lbar.findtype -side right
@@ -2350,8 +2350,8 @@ proc makewindow {} {
     pack .tf.histframe -fill both -side top -expand 1
     .ctop add .tf
     if {!$use_ttk} {
-	.ctop paneconfigure .tf -height $geometry(topheight)
-	.ctop paneconfigure .tf -width $geometry(topwidth)
+        .ctop paneconfigure .tf -height $geometry(topheight)
+        .ctop paneconfigure .tf -width $geometry(topwidth)
     }
 
     # now build up the bottom
@@ -2361,9 +2361,9 @@ proc makewindow {} {
     # if we know window height, then that will set the lower text height, otherwise
     # we set lower text height which will drive window height
     if {[info exists geometry(main)]} {
-	${NS}::frame .bleft -width $geometry(botwidth)
+        ${NS}::frame .bleft -width $geometry(botwidth)
     } else {
-	${NS}::frame .bleft -width $geometry(botwidth) -height $geometry(botheight)
+        ${NS}::frame .bleft -width $geometry(botwidth) -height $geometry(botheight)
     }
     ${NS}::frame .bleft.top
     ${NS}::frame .bleft.mid
@@ -2381,41 +2381,41 @@ proc makewindow {} {
     trace add variable searchstring write incrsearch
     pack $sstring -side left -expand 1 -fill x
     ${NS}::radiobutton .bleft.mid.diff -text [mc "Diff"] \
-	-command changediffdisp -variable diffelide -value {0 0}
+        -command changediffdisp -variable diffelide -value {0 0}
     ${NS}::radiobutton .bleft.mid.old -text [mc "Old version"] \
-	-command changediffdisp -variable diffelide -value {0 1}
+        -command changediffdisp -variable diffelide -value {0 1}
     ${NS}::radiobutton .bleft.mid.new -text [mc "New version"] \
-	-command changediffdisp -variable diffelide -value {1 0}
+        -command changediffdisp -variable diffelide -value {1 0}
 
     ${NS}::label .bleft.mid.labeldiffcontext -text "      [mc "Lines of context"]: "
     pack .bleft.mid.diff .bleft.mid.old .bleft.mid.new -side left -ipadx $wgap
     spinbox .bleft.mid.diffcontext -width 5 \
-	-from 0 -increment 1 -to 10000000 \
-	-validate all -validatecommand "diffcontextvalidate %P" \
-	-textvariable diffcontextstring
+        -from 0 -increment 1 -to 10000000 \
+        -validate all -validatecommand "diffcontextvalidate %P" \
+        -textvariable diffcontextstring
     .bleft.mid.diffcontext set $diffcontext
     trace add variable diffcontextstring write diffcontextchange
     lappend entries .bleft.mid.diffcontext
     pack .bleft.mid.labeldiffcontext .bleft.mid.diffcontext -side left -ipadx $wgap
     ${NS}::checkbutton .bleft.mid.ignspace -text [mc "Ignore space change"] \
-	-command changeignorespace -variable ignorespace
+        -command changeignorespace -variable ignorespace
     pack .bleft.mid.ignspace -side left -padx 5
 
     set worddiff [mc "Line diff"]
     if {[package vcompare $git_version "1.7.2"] >= 0} {
-	makedroplist .bleft.mid.worddiff worddiff [mc "Line diff"] \
-	    [mc "Markup words"] [mc "Color words"]
-	trace add variable worddiff write changeworddiff
-	pack .bleft.mid.worddiff -side left -padx 5
+        makedroplist .bleft.mid.worddiff worddiff [mc "Line diff"] \
+            [mc "Markup words"] [mc "Color words"]
+        trace add variable worddiff write changeworddiff
+        pack .bleft.mid.worddiff -side left -padx 5
     }
 
     set ctext .bleft.bottom.ctext
     text $ctext -background $bgcolor -foreground $fgcolor \
-	-state disabled -undo 0 -font textfont \
-	-yscrollcommand scrolltext -wrap none \
-	-xscrollcommand ".bleft.bottom.sbhorizontal set"
+        -state disabled -undo 0 -font textfont \
+        -yscrollcommand scrolltext -wrap none \
+        -xscrollcommand ".bleft.bottom.sbhorizontal set"
     if {$have_tk85} {
-	$ctext conf -tabstyle wordprocessor
+        $ctext conf -tabstyle wordprocessor
     }
     ${NS}::scrollbar .bleft.bottom.sb -command "$ctext yview"
     ${NS}::scrollbar .bleft.bottom.sbhorizontal -command "$ctext xview" -orient h
@@ -2462,35 +2462,35 @@ proc makewindow {} {
 
     .pwbottom add .bleft
     if {!$use_ttk} {
-	.pwbottom paneconfigure .bleft -width $geometry(botwidth)
+        .pwbottom paneconfigure .bleft -width $geometry(botwidth)
     }
 
     # lower right
     ${NS}::frame .bright
     ${NS}::frame .bright.mode
     ${NS}::radiobutton .bright.mode.patch -text [mc "Patch"] \
-	-command reselectline -variable cmitmode -value "patch"
+        -command reselectline -variable cmitmode -value "patch"
     ${NS}::radiobutton .bright.mode.tree -text [mc "Tree"] \
-	-command reselectline -variable cmitmode -value "tree"
+        -command reselectline -variable cmitmode -value "tree"
     grid .bright.mode.patch .bright.mode.tree -sticky ew
     pack .bright.mode -side top -fill x
     set cflist .bright.cfiles
     set indent [font measure mainfont "nn"]
     text $cflist \
-	-selectbackground $selectbgcolor \
-	-background $bgcolor -foreground $fgcolor \
-	-font mainfont \
-	-tabs [list $indent [expr {2 * $indent}]] \
-	-yscrollcommand ".bright.sb set" \
-	-cursor [. cget -cursor] \
-	-spacing1 1 -spacing3 1
+        -selectbackground $selectbgcolor \
+        -background $bgcolor -foreground $fgcolor \
+        -font mainfont \
+        -tabs [list $indent [expr {2 * $indent}]] \
+        -yscrollcommand ".bright.sb set" \
+        -cursor [. cget -cursor] \
+        -spacing1 1 -spacing3 1
     lappend bglist $cflist
     lappend fglist $cflist
     ${NS}::scrollbar .bright.sb -command "$cflist yview"
     pack .bright.sb -side right -fill y
     pack $cflist -side left -fill both -expand 1
     $cflist tag configure highlight \
-	-background [$cflist cget -selectbackground]
+        -background [$cflist cget -selectbackground]
     $cflist tag configure bold -font mainfontbold
 
     .pwbottom add .bright
@@ -2498,15 +2498,15 @@ proc makewindow {} {
 
     # restore window width & height if known
     if {[info exists geometry(main)]} {
-	if {[scan $geometry(main) "%dx%d" w h] >= 2} {
-	    if {$w > [winfo screenwidth .]} {
-		set w [winfo screenwidth .]
-	    }
-	    if {$h > [winfo screenheight .]} {
-		set h [winfo screenheight .]
-	    }
-	    wm geometry . "${w}x$h"
-	}
+        if {[scan $geometry(main) "%dx%d" w h] >= 2} {
+            if {$w > [winfo screenwidth .]} {
+                set w [winfo screenwidth .]
+            }
+            if {$h > [winfo screenheight .]} {
+                set h [winfo screenheight .]
+            }
+            wm geometry . "${w}x$h"
+        }
     }
 
     if {[info exists geometry(state)] && $geometry(state) eq "zoomed"} {
@@ -2530,25 +2530,25 @@ proc makewindow {} {
             bind %W <Map> {}
             %W sashpos 0 $::geometry(botwidth)
         }
-	bind .pwbottom <Configure> {resizecdetpanes %W %w}
+        bind .pwbottom <Configure> {resizecdetpanes %W %w}
     }
 
     pack .ctop -fill both -expand 1
     bindall <1> {selcanvline %W %x %y}
     #bindall <B1-Motion> {selcanvline %W %x %y}
     if {[tk windowingsystem] == "win32"} {
-	bind . <MouseWheel> { windows_mousewheel_redirector %W %X %Y %D }
-	bind $ctext <MouseWheel> { windows_mousewheel_redirector %W %X %Y %D ; break }
+        bind . <MouseWheel> { windows_mousewheel_redirector %W %X %Y %D }
+        bind $ctext <MouseWheel> { windows_mousewheel_redirector %W %X %Y %D ; break }
     } else {
-	bindall <ButtonRelease-4> "allcanvs yview scroll -5 units"
-	bindall <ButtonRelease-5> "allcanvs yview scroll 5 units"
-	bind $ctext <Button> {
-	    if {"%b" eq 6} {
-		$ctext xview scroll -5 units
-	    } elseif {"%b" eq 7} {
-		$ctext xview scroll 5 units
-	    }
-	}
+        bindall <ButtonRelease-4> "allcanvs yview scroll -5 units"
+        bindall <ButtonRelease-5> "allcanvs yview scroll 5 units"
+        bind $ctext <Button> {
+            if {"%b" eq 6} {
+                $ctext xview scroll -5 units
+            } elseif {"%b" eq 7} {
+                $ctext xview scroll 5 units
+            }
+        }
         if {[tk windowingsystem] eq "aqua"} {
             bindall <MouseWheel> {
                 set delta [expr {- (%D)}]
@@ -2631,7 +2631,7 @@ proc makewindow {} {
     bind $ctext <Button-1> {focus %W}
     bind $ctext <<Selection>> rehighlight_search_results
     for {set i 1} {$i < 10} {incr i} {
-	bind . <$M1B-Key-$i> [list go_to_parent $i]
+        bind . <$M1B-Key-$i> [list go_to_parent $i]
     }
 
     set maincursor [. cget -cursor]
@@ -2640,60 +2640,60 @@ proc makewindow {} {
 
     set rowctxmenu .rowctxmenu
     makemenu $rowctxmenu {
-	{mc "Diff this -> selected" command {diffvssel 0}}
-	{mc "Diff selected -> this" command {diffvssel 1}}
-	{mc "Make patch" command mkpatch}
-	{mc "Create tag" command mktag}
-	{mc "Copy commit reference" command copyreference}
-	{mc "Write commit to file" command writecommit}
-	{mc "Create new branch" command mkbranch}
-	{mc "Cherry-pick this commit" command cherrypick}
-	{mc "Reset HEAD branch to here" command resethead}
-	{mc "Mark this commit" command markhere}
-	{mc "Return to mark" command gotomark}
-	{mc "Find descendant of this and mark" command find_common_desc}
-	{mc "Compare with marked commit" command compare_commits}
-	{mc "Diff this -> marked commit" command {diffvsmark 0}}
-	{mc "Diff marked commit -> this" command {diffvsmark 1}}
-	{mc "Revert this commit" command revert}
+        {mc "Diff this -> selected" command {diffvssel 0}}
+        {mc "Diff selected -> this" command {diffvssel 1}}
+        {mc "Make patch" command mkpatch}
+        {mc "Create tag" command mktag}
+        {mc "Copy commit reference" command copyreference}
+        {mc "Write commit to file" command writecommit}
+        {mc "Create new branch" command mkbranch}
+        {mc "Cherry-pick this commit" command cherrypick}
+        {mc "Reset HEAD branch to here" command resethead}
+        {mc "Mark this commit" command markhere}
+        {mc "Return to mark" command gotomark}
+        {mc "Find descendant of this and mark" command find_common_desc}
+        {mc "Compare with marked commit" command compare_commits}
+        {mc "Diff this -> marked commit" command {diffvsmark 0}}
+        {mc "Diff marked commit -> this" command {diffvsmark 1}}
+        {mc "Revert this commit" command revert}
     }
     $rowctxmenu configure -tearoff 0
 
     set fakerowmenu .fakerowmenu
     makemenu $fakerowmenu {
-	{mc "Diff this -> selected" command {diffvssel 0}}
-	{mc "Diff selected -> this" command {diffvssel 1}}
-	{mc "Make patch" command mkpatch}
-	{mc "Diff this -> marked commit" command {diffvsmark 0}}
-	{mc "Diff marked commit -> this" command {diffvsmark 1}}
+        {mc "Diff this -> selected" command {diffvssel 0}}
+        {mc "Diff selected -> this" command {diffvssel 1}}
+        {mc "Make patch" command mkpatch}
+        {mc "Diff this -> marked commit" command {diffvsmark 0}}
+        {mc "Diff marked commit -> this" command {diffvsmark 1}}
     }
     $fakerowmenu configure -tearoff 0
 
     set headctxmenu .headctxmenu
     makemenu $headctxmenu {
-	{mc "Check out this branch" command cobranch}
-	{mc "Rename this branch" command mvbranch}
-	{mc "Remove this branch" command rmbranch}
-	{mc "Copy branch name" command {clipboard clear; clipboard append $headmenuhead}}
+        {mc "Check out this branch" command cobranch}
+        {mc "Rename this branch" command mvbranch}
+        {mc "Remove this branch" command rmbranch}
+        {mc "Copy branch name" command {clipboard clear; clipboard append $headmenuhead}}
     }
     $headctxmenu configure -tearoff 0
 
     global flist_menu
     set flist_menu .flistctxmenu
     makemenu $flist_menu {
-	{mc "Highlight this too" command {flist_hl 0}}
-	{mc "Highlight this only" command {flist_hl 1}}
-	{mc "External diff" command {external_diff}}
-	{mc "Blame parent commit" command {external_blame 1}}
-	{mc "Copy path" command {clipboard clear; clipboard append $flist_menu_file}}
+        {mc "Highlight this too" command {flist_hl 0}}
+        {mc "Highlight this only" command {flist_hl 1}}
+        {mc "External diff" command {external_diff}}
+        {mc "Blame parent commit" command {external_blame 1}}
+        {mc "Copy path" command {clipboard clear; clipboard append $flist_menu_file}}
     }
     $flist_menu configure -tearoff 0
 
     global diff_menu
     set diff_menu .diffctxmenu
     makemenu $diff_menu {
-	{mc "Show origin of this line" command show_line_source}
-	{mc "Run git gui blame on this line" command {external_blame_diff}}
+        {mc "Show origin of this line" command show_line_source}
+        {mc "Run git gui blame on this line" command {external_blame_diff}}
     }
     $diff_menu configure -tearoff 0
 }
@@ -2705,14 +2705,14 @@ proc windows_mousewheel_redirector {W X Y D} {
     global canv canv2 canv3
     set w [winfo containing -displayof $W $X $Y]
     if {$w ne ""} {
-	set u [expr {$D < 0 ? 5 : -5}]
-	if {$w == $canv || $w == $canv2 || $w == $canv3} {
-	    allcanvs yview scroll $u units
-	} else {
-	    catch {
-		$w yview scroll $u units
-	    }
-	}
+        set u [expr {$D < 0 ? 5 : -5}]
+        if {$w == $canv || $w == $canv2 || $w == $canv3} {
+            allcanvs yview scroll $u units
+        } else {
+            catch {
+                $w yview scroll $u units
+            }
+        }
     }
 }
 
@@ -2721,9 +2721,9 @@ proc selectedline_change {n1 n2 op} {
     global selectedline rownumsel
 
     if {$selectedline eq {}} {
-	set rownumsel {}
+        set rownumsel {}
     } else {
-	set rownumsel [expr {$selectedline + 1}]
+        set rownumsel [expr {$selectedline + 1}]
     }
 }
 
@@ -2732,11 +2732,11 @@ proc selectedline_change {n1 n2 op} {
 proc canvscan {op w x y} {
     global canv canv2 canv3
     foreach c [list $canv $canv2 $canv3] {
-	if {$c == $w} {
-	    $c scan $op $x $y
-	} else {
-	    $c scan $op 0 $y
-	}
+        if {$c == $w} {
+            $c scan $op $x $y
+        } else {
+            $c scan $op 0 $y
+        }
     }
 }
 
@@ -2754,10 +2754,10 @@ proc bindkey {ev script} {
     bind . $ev $script
     set escript [bind Entry $ev]
     if {$escript == {}} {
-	set escript [bind Entry <Key>]
+        set escript [bind Entry <Key>]
     }
     foreach e $entries {
-	bind $e $ev "$escript; break"
+        bind $e $ev "$escript; break"
     }
 }
 
@@ -2771,7 +2771,7 @@ proc bindmodfunctionkey {mod n script} {
 proc click {w} {
     global ctext entries
     foreach e [concat $entries $ctext] {
-	if {$w == $e} return
+        if {$w == $e} return
     }
     focus .
 }
@@ -2783,8 +2783,8 @@ proc adjustprogress {} {
     global rprogitem rprogcoord use_ttk
 
     if {$use_ttk} {
-	$progresscanv configure -value [expr {int($fprogcoord * 100)}]
-	return
+        $progresscanv configure -value [expr {int($fprogcoord * 100)}]
+        return
     }
 
     set w [expr {[winfo width $progresscanv] - 4}]
@@ -2796,11 +2796,11 @@ proc adjustprogress {} {
     $progresscanv coords $rprogitem 0 0 [expr {$w * $rprogcoord}] $h
     set now [clock clicks -milliseconds]
     if {$now >= $lastprogupdate + 100} {
-	set progupdatepending 0
-	update
+        set progupdatepending 0
+        update
     } elseif {!$progupdatepending} {
-	set progupdatepending 1
-	after [expr {$lastprogupdate + 100 - $now}] doprogupdate
+        set progupdatepending 1
+        after [expr {$lastprogupdate + 100 - $now}] doprogupdate
     }
 }
 
@@ -2808,9 +2808,9 @@ proc doprogupdate {} {
     global lastprogupdate progupdatepending
 
     if {$progupdatepending} {
-	set progupdatepending 0
-	set lastprogupdate [clock clicks -milliseconds]
-	update
+        set progupdatepending 0
+        set lastprogupdate [clock clicks -milliseconds]
+        update
     }
 }
 
@@ -2818,14 +2818,14 @@ proc config_check_tmp_exists {tries_left} {
     global config_file_tmp
 
     if {[file exists $config_file_tmp]} {
-	incr tries_left -1
-	if {$tries_left > 0} {
-	    after 100 [list config_check_tmp_exists $tries_left]
-	} else {
-	    error_popup "There appears to be a stale $config_file_tmp\
+        incr tries_left -1
+        if {$tries_left > 0} {
+            after 100 [list config_check_tmp_exists $tries_left]
+        } else {
+            error_popup "There appears to be a stale $config_file_tmp\
  file, which will prevent gitk from saving its configuration on exit.\
  Please remove it if it is not being used by any existing gitk process."
-	}
+        }
     }
 }
 
@@ -2842,9 +2842,9 @@ proc config_variable_change_cb {name name2 op} {
 
     upvar #0 $name var
     if {$op eq "write" &&
-	(![info exists config_variable_original($name)] ||
-	 $config_variable_original($name) ne $var)} {
-	set config_variable_changed($name) 1
+        (![info exists config_variable_original($name)] ||
+         $config_variable_original($name) ne $var)} {
+        set config_variable_changed($name) 1
     }
 }
 
@@ -2866,81 +2866,81 @@ proc savestuff {w} {
     if {![winfo viewable .]} return
     set remove_tmp 0
     if {[catch {
-	set try_count 0
-	while {[catch {set f [open $config_file_tmp {WRONLY CREAT EXCL}]}]} {
-	    if {[incr try_count] > 50} {
-		error "Unable to write config file: $config_file_tmp exists"
-	    }
-	    after 100
-	}
-	set remove_tmp 1
-	if {$::tcl_platform(platform) eq {windows}} {
-	    file attributes $config_file_tmp -hidden true
-	}
-	if {[file exists $config_file]} {
-	    source $config_file
-	}
-	foreach var_name $config_variables {
-	    upvar #0 $var_name var
-	    upvar 0 $var_name old_var
-	    if {!$config_variable_changed($var_name) && [info exists old_var]} {
-		puts $f [list set $var_name $old_var]
-	    } else {
-		puts $f [list set $var_name $var]
-	    }
-	}
+        set try_count 0
+        while {[catch {set f [open $config_file_tmp {WRONLY CREAT EXCL}]}]} {
+            if {[incr try_count] > 50} {
+                error "Unable to write config file: $config_file_tmp exists"
+            }
+            after 100
+        }
+        set remove_tmp 1
+        if {$::tcl_platform(platform) eq {windows}} {
+            file attributes $config_file_tmp -hidden true
+        }
+        if {[file exists $config_file]} {
+            source $config_file
+        }
+        foreach var_name $config_variables {
+            upvar #0 $var_name var
+            upvar 0 $var_name old_var
+            if {!$config_variable_changed($var_name) && [info exists old_var]} {
+                puts $f [list set $var_name $old_var]
+            } else {
+                puts $f [list set $var_name $var]
+            }
+        }
 
-	puts $f "set geometry(main) [wm geometry .]"
-	puts $f "set geometry(state) [wm state .]"
-	puts $f "set geometry(topwidth) [winfo width .tf]"
-	puts $f "set geometry(topheight) [winfo height .tf]"
-	if {$current_use_ttk} {
-	    puts $f "set geometry(pwsash0) \"[.tf.histframe.pwclist sashpos 0] 1\""
-	    puts $f "set geometry(pwsash1) \"[.tf.histframe.pwclist sashpos 1] 1\""
-	} else {
-	    puts $f "set geometry(pwsash0) \"[.tf.histframe.pwclist sash coord 0]\""
-	    puts $f "set geometry(pwsash1) \"[.tf.histframe.pwclist sash coord 1]\""
-	}
-	puts $f "set geometry(botwidth) [winfo width .bleft]"
-	puts $f "set geometry(botheight) [winfo height .bleft]"
+        puts $f "set geometry(main) [wm geometry .]"
+        puts $f "set geometry(state) [wm state .]"
+        puts $f "set geometry(topwidth) [winfo width .tf]"
+        puts $f "set geometry(topheight) [winfo height .tf]"
+        if {$current_use_ttk} {
+            puts $f "set geometry(pwsash0) \"[.tf.histframe.pwclist sashpos 0] 1\""
+            puts $f "set geometry(pwsash1) \"[.tf.histframe.pwclist sashpos 1] 1\""
+        } else {
+            puts $f "set geometry(pwsash0) \"[.tf.histframe.pwclist sash coord 0]\""
+            puts $f "set geometry(pwsash1) \"[.tf.histframe.pwclist sash coord 1]\""
+        }
+        puts $f "set geometry(botwidth) [winfo width .bleft]"
+        puts $f "set geometry(botheight) [winfo height .bleft]"
 
-	array set view_save {}
-	array set views {}
-	if {![info exists permviews]} { set permviews {} }
-	foreach view $permviews {
-	    set view_save([lindex $view 0]) 1
-	    set views([lindex $view 0]) $view
-	}
-	puts -nonewline $f "set permviews {"
-	for {set v 1} {$v < $current_nextviewnum} {incr v} {
-	    if {$viewchanged($v)} {
-		if {$current_viewperm($v)} {
-		    set views($current_viewname($v)) [list $current_viewname($v) $current_viewfiles($v) $current_viewargs($v) $current_viewargscmd($v)]
-		} else {
-		    set view_save($current_viewname($v)) 0
-		}
-	    }
-	}
-	# write old and updated view to their places and append remaining to the end
-	foreach view $permviews {
-	    set view_name [lindex $view 0]
-	    if {$view_save($view_name)} {
-		puts $f "{$views($view_name)}"
-	    }
-	    unset views($view_name)
-	}
-	foreach view_name [array names views] {
-	    puts $f "{$views($view_name)}"
-	}
-	puts $f "}"
-	close $f
-	file rename -force $config_file_tmp $config_file
-	set remove_tmp 0
+        array set view_save {}
+        array set views {}
+        if {![info exists permviews]} { set permviews {} }
+        foreach view $permviews {
+            set view_save([lindex $view 0]) 1
+            set views([lindex $view 0]) $view
+        }
+        puts -nonewline $f "set permviews {"
+        for {set v 1} {$v < $current_nextviewnum} {incr v} {
+            if {$viewchanged($v)} {
+                if {$current_viewperm($v)} {
+                    set views($current_viewname($v)) [list $current_viewname($v) $current_viewfiles($v) $current_viewargs($v) $current_viewargscmd($v)]
+                } else {
+                    set view_save($current_viewname($v)) 0
+                }
+            }
+        }
+        # write old and updated view to their places and append remaining to the end
+        foreach view $permviews {
+            set view_name [lindex $view 0]
+            if {$view_save($view_name)} {
+                puts $f "{$views($view_name)}"
+            }
+            unset views($view_name)
+        }
+        foreach view_name [array names views] {
+            puts $f "{$views($view_name)}"
+        }
+        puts $f "}"
+        close $f
+        file rename -force $config_file_tmp $config_file
+        set remove_tmp 0
     } err]} {
         puts "Error saving config: $err"
     }
     if {$remove_tmp} {
-	file delete -force $config_file_tmp
+        file delete -force $config_file_tmp
     }
     set stuffsaved 1
 }
@@ -2948,40 +2948,40 @@ proc savestuff {w} {
 proc resizeclistpanes {win w} {
     global oldwidth use_ttk
     if {[info exists oldwidth($win)]} {
-	if {$use_ttk} {
-	    set s0 [$win sashpos 0]
-	    set s1 [$win sashpos 1]
-	} else {
-	    set s0 [$win sash coord 0]
-	    set s1 [$win sash coord 1]
-	}
-	if {$w < 60} {
-	    set sash0 [expr {int($w/2 - 2)}]
-	    set sash1 [expr {int($w*5/6 - 2)}]
-	} else {
-	    set factor [expr {1.0 * $w / $oldwidth($win)}]
-	    set sash0 [expr {int($factor * [lindex $s0 0])}]
-	    set sash1 [expr {int($factor * [lindex $s1 0])}]
-	    if {$sash0 < 30} {
-		set sash0 30
-	    }
-	    if {$sash1 < $sash0 + 20} {
-		set sash1 [expr {$sash0 + 20}]
-	    }
-	    if {$sash1 > $w - 10} {
-		set sash1 [expr {$w - 10}]
-		if {$sash0 > $sash1 - 20} {
-		    set sash0 [expr {$sash1 - 20}]
-		}
-	    }
-	}
-	if {$use_ttk} {
-	    $win sashpos 0 $sash0
-	    $win sashpos 1 $sash1
-	} else {
-	    $win sash place 0 $sash0 [lindex $s0 1]
-	    $win sash place 1 $sash1 [lindex $s1 1]
-	}
+        if {$use_ttk} {
+            set s0 [$win sashpos 0]
+            set s1 [$win sashpos 1]
+        } else {
+            set s0 [$win sash coord 0]
+            set s1 [$win sash coord 1]
+        }
+        if {$w < 60} {
+            set sash0 [expr {int($w/2 - 2)}]
+            set sash1 [expr {int($w*5/6 - 2)}]
+        } else {
+            set factor [expr {1.0 * $w / $oldwidth($win)}]
+            set sash0 [expr {int($factor * [lindex $s0 0])}]
+            set sash1 [expr {int($factor * [lindex $s1 0])}]
+            if {$sash0 < 30} {
+                set sash0 30
+            }
+            if {$sash1 < $sash0 + 20} {
+                set sash1 [expr {$sash0 + 20}]
+            }
+            if {$sash1 > $w - 10} {
+                set sash1 [expr {$w - 10}]
+                if {$sash0 > $sash1 - 20} {
+                    set sash0 [expr {$sash1 - 20}]
+                }
+            }
+        }
+        if {$use_ttk} {
+            $win sashpos 0 $sash0
+            $win sashpos 1 $sash1
+        } else {
+            $win sash place 0 $sash0 [lindex $s0 1]
+            $win sash place 1 $sash1 [lindex $s1 1]
+        }
     }
     set oldwidth($win) $w
 }
@@ -2989,28 +2989,28 @@ proc resizeclistpanes {win w} {
 proc resizecdetpanes {win w} {
     global oldwidth use_ttk
     if {[info exists oldwidth($win)]} {
-	if {$use_ttk} {
-	    set s0 [$win sashpos 0]
-	} else {
-	    set s0 [$win sash coord 0]
-	}
-	if {$w < 60} {
-	    set sash0 [expr {int($w*3/4 - 2)}]
-	} else {
-	    set factor [expr {1.0 * $w / $oldwidth($win)}]
-	    set sash0 [expr {int($factor * [lindex $s0 0])}]
-	    if {$sash0 < 45} {
-		set sash0 45
-	    }
-	    if {$sash0 > $w - 15} {
-		set sash0 [expr {$w - 15}]
-	    }
-	}
-	if {$use_ttk} {
-	    $win sashpos 0 $sash0
-	} else {
-	    $win sash place 0 $sash0 [lindex $s0 1]
-	}
+        if {$use_ttk} {
+            set s0 [$win sashpos 0]
+        } else {
+            set s0 [$win sash coord 0]
+        }
+        if {$w < 60} {
+            set sash0 [expr {int($w*3/4 - 2)}]
+        } else {
+            set factor [expr {1.0 * $w / $oldwidth($win)}]
+            set sash0 [expr {int($factor * [lindex $s0 0])}]
+            if {$sash0 < 45} {
+                set sash0 45
+            }
+            if {$sash0 > $w - 15} {
+                set sash0 [expr {$w - 15}]
+            }
+        }
+        if {$use_ttk} {
+            $win sashpos 0 $sash0
+        } else {
+            $win sash place 0 $sash0 [lindex $s0 1]
+        }
     }
     set oldwidth($win) $w
 }
@@ -3033,8 +3033,8 @@ proc about {} {
     global bgcolor NS
     set w .about
     if {[winfo exists $w]} {
-	raise $w
-	return
+        raise $w
+        return
     }
     ttk_toplevel $w
     wm title $w [mc "About gitk"]
@@ -3045,7 +3045,7 @@ Gitk - a commit viewer for git
 Copyright \u00a9 2005-2016 Paul Mackerras
 
 Use and redistribute under the terms of the GNU General Public License"] \
-	    -justify center -aspect 400 -border 2 -bg $bgcolor -relief groove
+            -justify center -aspect 400 -border 2 -bg $bgcolor -relief groove
     pack $w.m -side top -fill x -padx 2 -pady 2
     ${NS}::button $w.ok -text [mc "Close"] -command "destroy $w" -default active
     pack $w.ok -side bottom
@@ -3059,13 +3059,13 @@ proc keys {} {
     global bgcolor NS
     set w .keys
     if {[winfo exists $w]} {
-	raise $w
-	return
+        raise $w
+        return
     }
     if {[tk windowingsystem] eq {aqua}} {
-	set M1T Cmd
+        set M1T Cmd
     } else {
-	set M1T Ctrl
+        set M1T Ctrl
     }
     ttk_toplevel $w
     wm title $w [mc "Gitk key bindings"]
@@ -3112,7 +3112,7 @@ proc keys {} {
 [mc "<%s-minus>	Decrease font size" $M1T]
 [mc "<F5>		Update"]
 " \
-	    -justify left -bg $bgcolor -border 2 -relief groove
+            -justify left -bg $bgcolor -border 2 -relief groove
     pack $w.m -side top -fill both -padx 2 -pady 2
     ${NS}::button $w.ok -text [mc "Close"] -command "destroy $w" -default active
     bind $w <Key-Escape> [list destroy $w]
@@ -3139,68 +3139,68 @@ proc treeview {w l openlevs} {
     set treecontents() {}
     $w conf -state normal
     foreach f $l {
-	while {[string range $f 0 $prefixend] ne $prefix} {
-	    if {$lev <= $openlevs} {
-		$w mark set e:$treeindex($prefix) "end -1c"
-		$w mark gravity e:$treeindex($prefix) left
-	    }
-	    set treeheight($prefix) $ht
-	    incr ht [lindex $htstack end]
-	    set htstack [lreplace $htstack end end]
-	    set prefixend [lindex $prefendstack end]
-	    set prefendstack [lreplace $prefendstack end end]
-	    set prefix [string range $prefix 0 $prefixend]
-	    incr lev -1
-	}
-	set tail [string range $f [expr {$prefixend+1}] end]
-	while {[set slash [string first "/" $tail]] >= 0} {
-	    lappend htstack $ht
-	    set ht 0
-	    lappend prefendstack $prefixend
-	    incr prefixend [expr {$slash + 1}]
-	    set d [string range $tail 0 $slash]
-	    lappend treecontents($prefix) $d
-	    set oldprefix $prefix
-	    append prefix $d
-	    set treecontents($prefix) {}
-	    set treeindex($prefix) [incr ix]
-	    set treeparent($prefix) $oldprefix
-	    set tail [string range $tail [expr {$slash+1}] end]
-	    if {$lev <= $openlevs} {
-		set ht 1
-		set treediropen($prefix) [expr {$lev < $openlevs}]
-		set bm [expr {$lev == $openlevs? "tri-rt": "tri-dn"}]
-		$w mark set d:$ix "end -1c"
-		$w mark gravity d:$ix left
-		set str "\n"
-		for {set i 0} {$i < $lev} {incr i} {append str "\t"}
-		$w insert end $str
-		$w image create end -align center -image $bm -padx 1 \
-		    -name a:$ix
-		$w insert end $d [highlight_tag $prefix]
-		$w mark set s:$ix "end -1c"
-		$w mark gravity s:$ix left
-	    }
-	    incr lev
-	}
-	if {$tail ne {}} {
-	    if {$lev <= $openlevs} {
-		incr ht
-		set str "\n"
-		for {set i 0} {$i < $lev} {incr i} {append str "\t"}
-		$w insert end $str
-		$w insert end $tail [highlight_tag $f]
-	    }
-	    lappend treecontents($prefix) $tail
-	}
+        while {[string range $f 0 $prefixend] ne $prefix} {
+            if {$lev <= $openlevs} {
+                $w mark set e:$treeindex($prefix) "end -1c"
+                $w mark gravity e:$treeindex($prefix) left
+            }
+            set treeheight($prefix) $ht
+            incr ht [lindex $htstack end]
+            set htstack [lreplace $htstack end end]
+            set prefixend [lindex $prefendstack end]
+            set prefendstack [lreplace $prefendstack end end]
+            set prefix [string range $prefix 0 $prefixend]
+            incr lev -1
+        }
+        set tail [string range $f [expr {$prefixend+1}] end]
+        while {[set slash [string first "/" $tail]] >= 0} {
+            lappend htstack $ht
+            set ht 0
+            lappend prefendstack $prefixend
+            incr prefixend [expr {$slash + 1}]
+            set d [string range $tail 0 $slash]
+            lappend treecontents($prefix) $d
+            set oldprefix $prefix
+            append prefix $d
+            set treecontents($prefix) {}
+            set treeindex($prefix) [incr ix]
+            set treeparent($prefix) $oldprefix
+            set tail [string range $tail [expr {$slash+1}] end]
+            if {$lev <= $openlevs} {
+                set ht 1
+                set treediropen($prefix) [expr {$lev < $openlevs}]
+                set bm [expr {$lev == $openlevs? "tri-rt": "tri-dn"}]
+                $w mark set d:$ix "end -1c"
+                $w mark gravity d:$ix left
+                set str "\n"
+                for {set i 0} {$i < $lev} {incr i} {append str "\t"}
+                $w insert end $str
+                $w image create end -align center -image $bm -padx 1 \
+                    -name a:$ix
+                $w insert end $d [highlight_tag $prefix]
+                $w mark set s:$ix "end -1c"
+                $w mark gravity s:$ix left
+            }
+            incr lev
+        }
+        if {$tail ne {}} {
+            if {$lev <= $openlevs} {
+                incr ht
+                set str "\n"
+                for {set i 0} {$i < $lev} {incr i} {append str "\t"}
+                $w insert end $str
+                $w insert end $tail [highlight_tag $f]
+            }
+            lappend treecontents($prefix) $tail
+        }
     }
     while {$htstack ne {}} {
-	set treeheight($prefix) $ht
-	incr ht [lindex $htstack end]
-	set htstack [lreplace $htstack end end]
-	set prefixend [lindex $prefendstack end]
-	set prefendstack [lreplace $prefendstack end end]
-	set prefix [string range $prefix 0 $prefixend]
+        set treeheight($prefix) $ht
+        incr ht [lindex $htstack end]
+        set htstack [lreplace $htstack end end]
+        set prefixend [lindex $prefendstack end]
+        set prefendstack [lreplace $prefendstack end end]
+        set prefix [string range $prefix 0 $prefixend]
     }
     $w conf -state disabled
 }
@@ -3211,21 +3211,21 @@ proc linetoelt {l} {
     set y 2
     set prefix {}
     while {1} {
-	foreach e $treecontents($prefix) {
-	    if {$y == $l} {
-		return "$prefix$e"
-	    }
-	    set n 1
-	    if {[string index $e end] eq "/"} {
-		set n $treeheight($prefix$e)
-		if {$y + $n > $l} {
-		    append prefix $e
-		    incr y
-		    break
-		}
-	    }
-	    incr y $n
-	}
+        foreach e $treecontents($prefix) {
+            if {$y == $l} {
+                return "$prefix$e"
+            }
+            set n 1
+            if {[string index $e end] eq "/"} {
+                set n $treeheight($prefix$e)
+                if {$y + $n > $l} {
+                    append prefix $e
+                    incr y
+                    break
+                }
+            }
+            incr y $n
+        }
     }
 }
 
@@ -3233,14 +3233,14 @@ proc highlight_tree {y prefix} {
     global treeheight treecontents cflist
 
     foreach e $treecontents($prefix) {
-	set path $prefix$e
-	if {[highlight_tag $path] ne {}} {
-	    $cflist tag add bold $y.0 "$y.0 lineend"
-	}
-	incr y
-	if {[string index $e end] eq "/" && $treeheight($path) > 1} {
-	    set y [highlight_tree $y $path]
-	}
+        set path $prefix$e
+        if {[highlight_tag $path] ne {}} {
+            $cflist tag add bold $y.0 "$y.0 lineend"
+        }
+        incr y
+        if {[string index $e end] eq "/" && $treeheight($path) > 1} {
+            set y [highlight_tree $y $path]
+        }
     }
     return $y
 }
@@ -3256,8 +3256,8 @@ proc treeclosedir {w dir} {
     $w conf -state disabled
     set n [expr {1 - $treeheight($dir)}]
     while {$dir ne {}} {
-	incr treeheight($dir) $n
-	set dir $treeparent($dir)
+        incr treeheight($dir) $n
+        set dir $treeparent($dir)
     }
 }
 
@@ -3273,28 +3273,28 @@ proc treeopendir {w dir} {
     set str "\n"
     set n [llength $treecontents($dir)]
     for {set x $dir} {$x ne {}} {set x $treeparent($x)} {
-	incr lev
-	append str "\t"
-	incr treeheight($x) $n
+        incr lev
+        append str "\t"
+        incr treeheight($x) $n
     }
     foreach e $treecontents($dir) {
-	set de $dir$e
-	if {[string index $e end] eq "/"} {
-	    set iy $treeindex($de)
-	    $w mark set d:$iy e:$ix
-	    $w mark gravity d:$iy left
-	    $w insert e:$ix $str
-	    set treediropen($de) 0
-	    $w image create e:$ix -align center -image tri-rt -padx 1 \
-		-name a:$iy
-	    $w insert e:$ix $e [highlight_tag $de]
-	    $w mark set s:$iy e:$ix
-	    $w mark gravity s:$iy left
-	    set treeheight($de) 1
-	} else {
-	    $w insert e:$ix $str
-	    $w insert e:$ix $e [highlight_tag $de]
-	}
+        set de $dir$e
+        if {[string index $e end] eq "/"} {
+            set iy $treeindex($de)
+            $w mark set d:$iy e:$ix
+            $w mark gravity d:$iy left
+            $w insert e:$ix $str
+            set treediropen($de) 0
+            $w image create e:$ix -align center -image tri-rt -padx 1 \
+                -name a:$iy
+            $w insert e:$ix $e [highlight_tag $de]
+            $w mark set s:$iy e:$ix
+            $w mark gravity s:$iy left
+            set treeheight($de) 1
+        } else {
+            $w insert e:$ix $str
+            $w insert e:$ix $e [highlight_tag $de]
+        }
     }
     $w mark gravity e:$ix right
     $w conf -state disabled
@@ -3303,13 +3303,13 @@ proc treeopendir {w dir} {
     set ht [$w cget -height]
     set l [lindex [split [$w index s:$ix] .] 0]
     if {$l < $top} {
-	$w yview $l.0
+        $w yview $l.0
     } elseif {$l + $n + 1 > $top + $ht} {
-	set top [expr {$l + $n + 2 - $ht}]
-	if {$l < $top} {
-	    set top $l
-	}
-	$w yview $top.0
+        set top [expr {$l + $n + 2 - $ht}]
+        if {$l < $top} {
+            set top $l
+        }
+        $w yview $top.0
     }
 }
 
@@ -3323,16 +3323,16 @@ proc treeclick {w x y} {
     $cflist tag add highlight $l.0 "$l.0 lineend"
     set cflist_top $l
     if {$l == 1} {
-	$ctext yview 1.0
-	return
+        $ctext yview 1.0
+        return
     }
     set e [linetoelt $l]
     if {[string index $e end] ne "/"} {
-	showfile $e
+        showfile $e
     } elseif {$treediropen($e)} {
-	treeclosedir $w $e
+        treeclosedir $w $e
     } else {
-	treeopendir $w $e
+        treeopendir $w $e
     }
 }
 
@@ -3341,10 +3341,10 @@ proc setfilelist {id} {
 
     treeview $cflist $treefilelist($id) 0
     if {$jump_to_here ne {}} {
-	set f [lindex $jump_to_here 0]
-	if {[lsearch -exact $treefilelist($id) $f] >= 0} {
-	    showfile $f
-	}
+        set f [lindex $jump_to_here 0]
+        if {[lsearch -exact $treefilelist($id) $f] >= 0} {
+            showfile $f
+        }
     }
 }
 
@@ -3419,11 +3419,11 @@ proc init_flist {first} {
     $cflist conf -state normal
     $cflist delete 0.0 end
     if {$first ne {}} {
-	$cflist insert end $first
-	set cflist_top 1
-	$cflist tag add highlight 1.0 "1.0 lineend"
+        $cflist insert end $first
+        set cflist_top 1
+        $cflist tag add highlight 1.0 "1.0 lineend"
     } else {
-	unset -nocomplain cflist_top
+        unset -nocomplain cflist_top
     }
     $cflist conf -state disabled
     set difffilestart {}
@@ -3433,9 +3433,9 @@ proc highlight_tag {f} {
     global highlight_paths
 
     foreach p $highlight_paths {
-	if {[string match $p $f]} {
-	    return "bold"
-	}
+        if {[string match $p $f]} {
+            return "bold"
+        }
     }
     return {}
 }
@@ -3445,15 +3445,15 @@ proc highlight_filelist {} {
 
     $cflist conf -state normal
     if {$cmitmode ne "tree"} {
-	set end [lindex [split [$cflist index end] .] 0]
-	for {set l 2} {$l < $end} {incr l} {
-	    set line [$cflist get $l.0 "$l.0 lineend"]
-	    if {[highlight_tag $line] ne {}} {
-		$cflist tag add bold $l.0 "$l.0 lineend"
-	    }
-	}
+        set end [lindex [split [$cflist index end] .] 0]
+        for {set l 2} {$l < $end} {incr l} {
+            set line [$cflist get $l.0 "$l.0 lineend"]
+            if {[highlight_tag $line] ne {}} {
+                $cflist tag add bold $l.0 "$l.0 lineend"
+            }
+        }
     } else {
-	highlight_tree 2 {}
+        highlight_tree 2 {}
     }
     $cflist conf -state disabled
 }
@@ -3471,8 +3471,8 @@ proc add_flist {fl} {
 
     $cflist conf -state normal
     foreach f $fl {
-	$cflist insert end "\n"
-	$cflist insert end $f [highlight_tag $f]
+        $cflist insert end "\n"
+        $cflist insert end $f [highlight_tag $f]
     }
     $cflist conf -state disabled
 }
@@ -3487,9 +3487,9 @@ proc sel_flist {w x y} {
     $cflist tag add highlight $l.0 "$l.0 lineend"
     set cflist_top $l
     if {$l == 1} {
-	$ctext yview 1.0
+        $ctext yview 1.0
     } else {
-	catch {$ctext yview [lindex $difffilestart [expr {$l - 2}]]}
+        catch {$ctext yview [lindex $difffilestart [expr {$l - 2}]]}
     }
     suppress_highlighting_file_for_current_scrollpos
 }
@@ -3502,15 +3502,15 @@ proc pop_flist_menu {w X Y x y} {
     set l [lindex [split [$w index "@$x,$y"] "."] 0]
     if {$l <= 1} return
     if {$cmitmode eq "tree"} {
-	set e [linetoelt $l]
-	if {[string index $e end] eq "/"} return
+        set e [linetoelt $l]
+        if {[string index $e end] eq "/"} return
     } else {
-	set e [lindex $treediffs($diffids) [expr {$l-2}]]
+        set e [lindex $treediffs($diffids) [expr {$l-2}]]
     }
     set flist_menu_file $e
     set xdiffstate "normal"
     if {$cmitmode eq "tree"} {
-	set xdiffstate "disabled"
+        set xdiffstate "disabled"
     }
     # Disable "External diff" item in tree mode
     $flist_menu entryconf 2 -state $xdiffstate
@@ -3539,7 +3539,7 @@ proc pop_diff_menu {w X Y x y} {
     set diff_menu_line [lindex $diff_menu_txtpos 0]
     # don't pop up the menu on hunk-separator or file-separator lines
     if {[lsearch -glob [$ctext tag names $diff_menu_line.0] "*sep"] >= 0} {
-	return
+        return
     }
     stopfinding
     set f [find_ctext_fileinfo $diff_menu_line]
@@ -3554,9 +3554,9 @@ proc flist_hl {only} {
 
     set x [shellquote $flist_menu_file]
     if {$only || $findstring eq {} || $gdttype ne [mc "touching paths:"]} {
-	set findstring $x
+        set findstring $x
     } else {
-	append findstring " " $x
+        append findstring " " $x
     }
     set gdttype [mc "touching paths:"]
 }
@@ -3565,29 +3565,29 @@ proc gitknewtmpdir {} {
     global diffnum gitktmpdir gitdir env
 
     if {![info exists gitktmpdir]} {
-	if {[info exists env(GITK_TMPDIR)]} {
-	    set tmpdir $env(GITK_TMPDIR)
-	} elseif {[info exists env(TMPDIR)]} {
-	    set tmpdir $env(TMPDIR)
-	} else {
-	    set tmpdir $gitdir
-	}
-	set gitktmpformat [file join $tmpdir ".gitk-tmp.XXXXXX"]
-	if {[catch {set gitktmpdir [exec mktemp -d $gitktmpformat]}]} {
-	    set gitktmpdir [file join $gitdir [format ".gitk-tmp.%s" [pid]]]
-	}
-	if {[catch {file mkdir $gitktmpdir} err]} {
-	    error_popup "[mc "Error creating temporary directory %s:" $gitktmpdir] $err"
-	    unset gitktmpdir
-	    return {}
-	}
-	set diffnum 0
+        if {[info exists env(GITK_TMPDIR)]} {
+            set tmpdir $env(GITK_TMPDIR)
+        } elseif {[info exists env(TMPDIR)]} {
+            set tmpdir $env(TMPDIR)
+        } else {
+            set tmpdir $gitdir
+        }
+        set gitktmpformat [file join $tmpdir ".gitk-tmp.XXXXXX"]
+        if {[catch {set gitktmpdir [exec mktemp -d $gitktmpformat]}]} {
+            set gitktmpdir [file join $gitdir [format ".gitk-tmp.%s" [pid]]]
+        }
+        if {[catch {file mkdir $gitktmpdir} err]} {
+            error_popup "[mc "Error creating temporary directory %s:" $gitktmpdir] $err"
+            unset gitktmpdir
+            return {}
+        }
+        set diffnum 0
     }
     incr diffnum
     set diffdir [file join $gitktmpdir $diffnum]
     if {[catch {file mkdir $diffdir} err]} {
-	error_popup "[mc "Error creating temporary directory %s:" $diffdir] $err"
-	return {}
+        error_popup "[mc "Error creating temporary directory %s:" $diffdir] $err"
+        return {}
     }
     return $diffdir
 }
@@ -3596,11 +3596,11 @@ proc save_file_from_commit {filename output what} {
     global nullfile
 
     if {[catch {exec git show $filename -- > $output} err]} {
-	if {[string match "fatal: bad revision *" $err]} {
-	    return $nullfile
-	}
-	error_popup "[mc "Error getting \"%s\" from %s:" $filename $what] $err"
-	return {}
+        if {[string match "fatal: bad revision *" $err]} {
+            return $nullfile
+        }
+        error_popup "[mc "Error getting \"%s\" from %s:" $filename $what] $err"
+        return {}
     }
     return $output
 }
@@ -3611,10 +3611,10 @@ proc external_diff_get_one_file {diffid filename diffdir} {
 
     if {$diffid == $nullid} {
         set difffile [file join $worktree $filename]
-	if {[file exists $difffile]} {
-	    return $difffile
-	}
-	return $nullfile
+        if {[file exists $difffile]} {
+            return $difffile
+        }
+        return $nullfile
     }
     if {$diffid == $nullid2} {
         set difffile [file join $diffdir "\[index\] [file tail $filename]"]
@@ -3622,7 +3622,7 @@ proc external_diff_get_one_file {diffid filename diffdir} {
     }
     set difffile [file join $diffdir "\[$diffid\] [file tail $filename]"]
     return [save_file_from_commit $diffid:$filename $difffile \
-	       "revision $diffid"]
+               "revision $diffid"]
 }
 
 proc external_diff {} {
@@ -3679,18 +3679,18 @@ proc find_hunk_blamespec {base line} {
 
     set s_line [$ctext get $s_lix "$s_lix + 1 lines"]
     if {![regexp {^@@@*(( -\d+(,\d+)?)+) \+(\d+)(,\d+)? @@} $s_line \
-	    s_line old_specs osz osz1 new_line nsz]} {
-	return
+            s_line old_specs osz osz1 new_line nsz]} {
+        return
     }
 
     # base lines for the parents
     set base_lines [list $new_line]
     foreach old_spec [lrange [split $old_specs " "] 1 end] {
-	if {![regexp -- {-(\d+)(,\d+)?} $old_spec \
-	        old_spec old_line osz]} {
-	    return
-	}
-	lappend base_lines $old_line
+        if {![regexp -- {-(\d+)(,\d+)?} $old_spec \
+                old_spec old_line osz]} {
+            return
+        }
+        lappend base_lines $old_line
     }
 
     # Now scan the lines to determine offset within the hunk
@@ -3701,38 +3701,38 @@ proc find_hunk_blamespec {base line} {
     # Determine if the line is removed
     set chunk [$ctext get $line.0 "$line.1 + $max_parent chars"]
     if {[string match {[-+ ]*} $chunk]} {
-	set removed_idx [string first "-" $chunk]
-	# Choose a parent index
-	if {$removed_idx >= 0} {
-	    set parent $removed_idx
-	} else {
-	    set unchanged_idx [string first " " $chunk]
-	    if {$unchanged_idx >= 0} {
-		set parent $unchanged_idx
-	    } else {
-		# blame the current commit
-		set parent -1
-	    }
-	}
-	# then count other lines that belong to it
-	for {set i $line} {[incr i -1] > $s_lno} {} {
-	    set chunk [$ctext get $i.0 "$i.1 + $max_parent chars"]
-	    # Determine if the line is removed
-	    set removed_idx [string first "-" $chunk]
-	    if {$parent >= 0} {
-		set code [string index $chunk $parent]
-		if {$code eq "-" || ($removed_idx < 0 && $code ne "+")} {
-		    incr dline
-		}
-	    } else {
-		if {$removed_idx < 0} {
-		    incr dline
-		}
-	    }
-	}
-	incr parent
+        set removed_idx [string first "-" $chunk]
+        # Choose a parent index
+        if {$removed_idx >= 0} {
+            set parent $removed_idx
+        } else {
+            set unchanged_idx [string first " " $chunk]
+            if {$unchanged_idx >= 0} {
+                set parent $unchanged_idx
+            } else {
+                # blame the current commit
+                set parent -1
+            }
+        }
+        # then count other lines that belong to it
+        for {set i $line} {[incr i -1] > $s_lno} {} {
+            set chunk [$ctext get $i.0 "$i.1 + $max_parent chars"]
+            # Determine if the line is removed
+            set removed_idx [string first "-" $chunk]
+            if {$parent >= 0} {
+                set code [string index $chunk $parent]
+                if {$code eq "-" || ($removed_idx < 0 && $code ne "+")} {
+                    incr dline
+                }
+            } else {
+                if {$removed_idx < 0} {
+                    incr dline
+                }
+            }
+        }
+        incr parent
     } else {
-	set parent 0
+        set parent 0
     }
 
     incr dline [lindex $base_lines $parent]
@@ -3745,17 +3745,17 @@ proc external_blame_diff {} {
     global diff_menu_filebase flist_menu_file
 
     if {$cmitmode eq "tree"} {
-	set parent_idx 0
-	set line [expr {$diff_menu_line - $diff_menu_filebase}]
+        set parent_idx 0
+        set line [expr {$diff_menu_line - $diff_menu_filebase}]
     } else {
-	set hinfo [find_hunk_blamespec $diff_menu_filebase $diff_menu_line]
-	if {$hinfo ne {}} {
-	    set parent_idx [lindex $hinfo 0]
-	    set line [lindex $hinfo 1]
-	} else {
-	    set parent_idx 0
-	    set line 0
-	}
+        set hinfo [find_hunk_blamespec $diff_menu_filebase $diff_menu_line]
+        if {$hinfo ne {}} {
+            set parent_idx [lindex $hinfo 0]
+            set line [lindex $hinfo 1]
+        } else {
+            set parent_idx 0
+            set line 0
+        }
     }
 
     external_blame $parent_idx $line
@@ -3766,12 +3766,12 @@ proc external_blame_diff {} {
 proc index_sha1 {fname} {
     set f [open [list | git ls-files -s $fname] r]
     while {[gets $f line] >= 0} {
-	set info [lindex [split $line "\t"] 0]
-	set stage [lindex $info 2]
-	if {$stage eq "0" || $stage eq "2"} {
-	    close $f
-	    return [lindex $info 1]
-	}
+        set info [lindex [split $line "\t"] 0]
+        set stage [lindex $info 2]
+        if {$stage eq "0" || $stage eq "2"} {
+            close $f
+            return [lindex $info 1]
+        }
     }
     close $f
     return {}
@@ -3780,7 +3780,7 @@ proc index_sha1 {fname} {
 # Turn an absolute path into one relative to the current directory
 proc make_relative {f} {
     if {[file pathtype $f] eq "relative"} {
-	return $f
+        return $f
     }
     set elts [file split $f]
     set here [file split [pwd]]
@@ -3788,12 +3788,12 @@ proc make_relative {f} {
     set hi 0
     set res {}
     foreach d $here {
-	if {$ei < $hi || $ei >= [llength $elts] || [lindex $elts $ei] ne $d} {
-	    lappend res ".."
-	} else {
-	    incr ei
-	}
-	incr hi
+        if {$ei < $hi || $ei >= [llength $elts] || [lindex $elts $ei] ne $d} {
+            lappend res ".."
+        } else {
+            incr ei
+        }
+        incr hi
     }
     set elts [concat $res [lrange $elts $ei end]]
     return [eval file join $elts]
@@ -3805,19 +3805,19 @@ proc external_blame {parent_idx {line {}}} {
     global parentlist selectedline currentid
 
     if {$parent_idx > 0} {
-	set base_commit [lindex $parentlist $selectedline [expr {$parent_idx-1}]]
+        set base_commit [lindex $parentlist $selectedline [expr {$parent_idx-1}]]
     } else {
-	set base_commit $currentid
+        set base_commit $currentid
     }
 
     if {$base_commit eq {} || $base_commit eq $nullid || $base_commit eq $nullid2} {
-	error_popup [mc "No such commit"]
-	return
+        error_popup [mc "No such commit"]
+        return
     }
 
     set cmdline [list git gui blame]
     if {$line ne {} && $line > 1} {
-	lappend cmdline "--line=$line"
+        lappend cmdline "--line=$line"
     }
     set f [file join $cdup $flist_menu_file]
     # Unfortunately it seems git gui blame doesn't like
@@ -3825,7 +3825,7 @@ proc external_blame {parent_idx {line {}}} {
     set f [make_relative $f]
     lappend cmdline $base_commit $f
     if {[catch {eval exec $cmdline &} err]} {
-	error_popup "[mc "git gui blame: command failed:"] $err"
+        error_popup "[mc "git gui blame: command failed:"] $err"
     }
 }
 
@@ -3836,61 +3836,61 @@ proc show_line_source {} {
 
     set from_index {}
     if {$cmitmode eq "tree"} {
-	set id $currentid
-	set line [expr {$diff_menu_line - $diff_menu_filebase}]
+        set id $currentid
+        set line [expr {$diff_menu_line - $diff_menu_filebase}]
     } else {
-	set h [find_hunk_blamespec $diff_menu_filebase $diff_menu_line]
-	if {$h eq {}} return
-	set pi [lindex $h 0]
-	if {$pi == 0} {
-	    mark_ctext_line $diff_menu_line
-	    return
-	}
-	incr pi -1
-	if {$currentid eq $nullid} {
-	    if {$pi > 0} {
-		# must be a merge in progress...
-		if {[catch {
-		    # get the last line from .git/MERGE_HEAD
-		    set f [open [file join $gitdir MERGE_HEAD] r]
-		    set id [lindex [split [read $f] "\n"] end-1]
-		    close $f
-		} err]} {
-		    error_popup [mc "Couldn't read merge head: %s" $err]
-		    return
-		}
-	    } elseif {$parents($curview,$currentid) eq $nullid2} {
-		# need to do the blame from the index
-		if {[catch {
-		    set from_index [index_sha1 $flist_menu_file]
-		} err]} {
-		    error_popup [mc "Error reading index: %s" $err]
-		    return
-		}
-	    } else {
-		set id $parents($curview,$currentid)
-	    }
-	} else {
-	    set id [lindex $parents($curview,$currentid) $pi]
-	}
-	set line [lindex $h 1]
+        set h [find_hunk_blamespec $diff_menu_filebase $diff_menu_line]
+        if {$h eq {}} return
+        set pi [lindex $h 0]
+        if {$pi == 0} {
+            mark_ctext_line $diff_menu_line
+            return
+        }
+        incr pi -1
+        if {$currentid eq $nullid} {
+            if {$pi > 0} {
+                # must be a merge in progress...
+                if {[catch {
+                    # get the last line from .git/MERGE_HEAD
+                    set f [open [file join $gitdir MERGE_HEAD] r]
+                    set id [lindex [split [read $f] "\n"] end-1]
+                    close $f
+                } err]} {
+                    error_popup [mc "Couldn't read merge head: %s" $err]
+                    return
+                }
+            } elseif {$parents($curview,$currentid) eq $nullid2} {
+                # need to do the blame from the index
+                if {[catch {
+                    set from_index [index_sha1 $flist_menu_file]
+                } err]} {
+                    error_popup [mc "Error reading index: %s" $err]
+                    return
+                }
+            } else {
+                set id $parents($curview,$currentid)
+            }
+        } else {
+            set id [lindex $parents($curview,$currentid) $pi]
+        }
+        set line [lindex $h 1]
     }
     set blameargs {}
     if {$from_index ne {}} {
-	lappend blameargs | git cat-file blob $from_index
+        lappend blameargs | git cat-file blob $from_index
     }
     lappend blameargs | git blame -p -L$line,+1
     if {$from_index ne {}} {
-	lappend blameargs --contents -
+        lappend blameargs --contents -
     } else {
-	lappend blameargs $id
+        lappend blameargs $id
     }
     lappend blameargs -- [file join $cdup $flist_menu_file]
     if {[catch {
-	set f [open $blameargs r]
+        set f [open $blameargs r]
     } err]} {
-	error_popup [mc "Couldn't start git blame: %s" $err]
-	return
+        error_popup [mc "Couldn't start git blame: %s" $err]
+        return
     }
     nowbusy blaming [mc "Searching"]
     fconfigure $f -blocking 0
@@ -3904,9 +3904,9 @@ proc stopblaming {} {
     global blameinst
 
     if {[info exists blameinst]} {
-	stop_instance $blameinst
-	unset blameinst
-	notbusy blaming
+        stop_instance $blameinst
+        unset blameinst
+        notbusy blaming
     }
 }
 
@@ -3914,18 +3914,18 @@ proc read_line_source {fd inst} {
     global blamestuff curview commfd blameinst nullid nullid2
 
     while {[gets $fd line] >= 0} {
-	lappend blamestuff($inst) $line
+        lappend blamestuff($inst) $line
     }
     if {![eof $fd]} {
-	return 1
+        return 1
     }
     unset commfd($inst)
     unset blameinst
     notbusy blaming
     fconfigure $fd -blocking 1
     if {[catch {close $fd} err]} {
-	error_popup [mc "Error running git blame: %s" $err]
-	return 0
+        error_popup [mc "Error running git blame: %s" $err]
+        return 0
     }
 
     set fname {}
@@ -3933,30 +3933,30 @@ proc read_line_source {fd inst} {
     set id [lindex $line 0]
     set lnum [lindex $line 1]
     if {[string length $id] == 40 && [string is xdigit $id] &&
-	[string is digit -strict $lnum]} {
-	# look for "filename" line
-	foreach l $blamestuff($inst) {
-	    if {[string match "filename *" $l]} {
-		set fname [string range $l 9 end]
-		break
-	    }
-	}
+        [string is digit -strict $lnum]} {
+        # look for "filename" line
+        foreach l $blamestuff($inst) {
+            if {[string match "filename *" $l]} {
+                set fname [string range $l 9 end]
+                break
+            }
+        }
     }
     if {$fname ne {}} {
-	# all looks good, select it
-	if {$id eq $nullid} {
-	    # blame uses all-zeroes to mean not committed,
-	    # which would mean a change in the index
-	    set id $nullid2
-	}
-	if {[commitinview $id $curview]} {
-	    selectline [rowofcommit $id] 1 [list $fname $lnum] 1
-	} else {
-	    error_popup [mc "That line comes from commit %s, \
-			     which is not in this view" [shortids $id]]
-	}
+        # all looks good, select it
+        if {$id eq $nullid} {
+            # blame uses all-zeroes to mean not committed,
+            # which would mean a change in the index
+            set id $nullid2
+        }
+        if {[commitinview $id $curview]} {
+            selectline [rowofcommit $id] 1 [list $fname $lnum] 1
+        } else {
+            error_popup [mc "That line comes from commit %s, \
+                             which is not in this view" [shortids $id]]
+        }
     } else {
-	puts "oops couldn't parse git blame output"
+        puts "oops couldn't parse git blame output"
     }
     return 0
 }
@@ -3965,11 +3965,11 @@ proc read_line_source {fd inst} {
 proc delete_at_eof {f dir} {
     while {[gets $f line] >= 0} {}
     if {[eof $f]} {
-	if {[catch {close $f} err]} {
-	    error_popup "[mc "External diff viewer failed:"] $err"
-	}
-	file delete -force $dir
-	return 0
+        if {[catch {close $f} err]} {
+            error_popup "[mc "External diff viewer failed:"] $err"
+        }
+        file delete -force $dir
+        return 0
     }
     return 1
 }
@@ -3978,13 +3978,13 @@ proc delete_at_eof {f dir} {
 
 proc shellquote {str} {
     if {![string match "*\['\"\\ \t]*" $str]} {
-	return $str
+        return $str
     }
     if {![string match "*\['\"\\]*" $str]} {
-	return "\"$str\""
+        return "\"$str\""
     }
     if {![string match "*'*" $str]} {
-	return "'$str'"
+        return "'$str'"
     }
     return "\"[string map {\" \\\" \\ \\\\} $str]\""
 }
@@ -3992,10 +3992,10 @@ proc shellquote {str} {
 proc shellarglist {l} {
     set str {}
     foreach a $l {
-	if {$str ne {}} {
-	    append str " "
-	}
-	append str [shellquote $a]
+        if {$str ne {}} {
+            append str " "
+        }
+        append str [shellquote $a]
     }
     return $str
 }
@@ -4004,52 +4004,52 @@ proc shelldequote {str} {
     set ret {}
     set used -1
     while {1} {
-	incr used
-	if {![regexp -start $used -indices "\['\"\\\\ \t]" $str first]} {
-	    append ret [string range $str $used end]
-	    set used [string length $str]
-	    break
-	}
-	set first [lindex $first 0]
-	set ch [string index $str $first]
-	if {$first > $used} {
-	    append ret [string range $str $used [expr {$first - 1}]]
-	    set used $first
-	}
-	if {$ch eq " " || $ch eq "\t"} break
-	incr used
-	if {$ch eq "'"} {
-	    set first [string first "'" $str $used]
-	    if {$first < 0} {
-		error "unmatched single-quote"
-	    }
-	    append ret [string range $str $used [expr {$first - 1}]]
-	    set used $first
-	    continue
-	}
-	if {$ch eq "\\"} {
-	    if {$used >= [string length $str]} {
-		error "trailing backslash"
-	    }
-	    append ret [string index $str $used]
-	    continue
-	}
-	# here ch == "\""
-	while {1} {
-	    if {![regexp -start $used -indices "\[\"\\\\]" $str first]} {
-		error "unmatched double-quote"
-	    }
-	    set first [lindex $first 0]
-	    set ch [string index $str $first]
-	    if {$first > $used} {
-		append ret [string range $str $used [expr {$first - 1}]]
-		set used $first
-	    }
-	    if {$ch eq "\""} break
-	    incr used
-	    append ret [string index $str $used]
-	    incr used
-	}
+        incr used
+        if {![regexp -start $used -indices "\['\"\\\\ \t]" $str first]} {
+            append ret [string range $str $used end]
+            set used [string length $str]
+            break
+        }
+        set first [lindex $first 0]
+        set ch [string index $str $first]
+        if {$first > $used} {
+            append ret [string range $str $used [expr {$first - 1}]]
+            set used $first
+        }
+        if {$ch eq " " || $ch eq "\t"} break
+        incr used
+        if {$ch eq "'"} {
+            set first [string first "'" $str $used]
+            if {$first < 0} {
+                error "unmatched single-quote"
+            }
+            append ret [string range $str $used [expr {$first - 1}]]
+            set used $first
+            continue
+        }
+        if {$ch eq "\\"} {
+            if {$used >= [string length $str]} {
+                error "trailing backslash"
+            }
+            append ret [string index $str $used]
+            continue
+        }
+        # here ch == "\""
+        while {1} {
+            if {![regexp -start $used -indices "\[\"\\\\]" $str first]} {
+                error "unmatched double-quote"
+            }
+            set first [lindex $first 0]
+            set ch [string index $str $first]
+            if {$first > $used} {
+                append ret [string range $str $used [expr {$first - 1}]]
+                set used $first
+            }
+            if {$ch eq "\""} break
+            incr used
+            append ret [string index $str $used]
+            incr used
+        }
     }
     return [list $used $ret]
 }
@@ -4057,13 +4057,13 @@ proc shelldequote {str} {
 proc shellsplit {str} {
     set l {}
     while {1} {
-	set str [string trimleft $str]
-	if {$str eq {}} break
-	set dq [shelldequote $str]
-	set n [lindex $dq 0]
-	set word [lindex $dq 1]
-	set str [string range $str $n end]
-	lappend l $word
+        set str [string trimleft $str]
+        if {$str eq {}} break
+        set dq [shelldequote $str]
+        set n [lindex $dq 0]
+        set word [lindex $dq 1]
+        set str [string range $str $n end]
+        lappend l $word
     }
     return $l
 }
@@ -4072,11 +4072,11 @@ proc set_window_title {} {
     global appname curview viewname vrevs
     set rev [mc "All files"]
     if {$curview ne 0} {
-	if {$viewname($curview) eq [mc "Command line"]} {
-	    set rev [string map {"--gitk-symmetric-diff-marker" "--merge"} $vrevs($curview)]
-	} else {
-	    set rev $viewname($curview)
-	}
+        if {$viewname($curview) eq [mc "Command line"]} {
+            set rev [string map {"--gitk-symmetric-diff-marker" "--merge"} $vrevs($curview)]
+        } else {
+            set rev $viewname($curview)
+        }
     }
     wm title . "[reponame]: $rev - $appname"
 }
@@ -4090,8 +4090,8 @@ proc newview {ishighlight} {
     set newishighlight $ishighlight
     set top .gitkview
     if {[winfo exists $top]} {
-	raise $top
-	return
+        raise $top
+        return
     }
     decode_view_opts $nextviewnum $revtreeargs
     set newviewname($nextviewnum) "[mc "View"] $nextviewnum"
@@ -4140,29 +4140,29 @@ proc encode_view_opts {n} {
 
     set rargs [list]
     foreach opt $known_view_options {
-	set patterns [lindex $opt 3]
-	if {$patterns eq {}} continue
-	set pattern [lindex $patterns 0]
+        set patterns [lindex $opt 3]
+        if {$patterns eq {}} continue
+        set pattern [lindex $patterns 0]
 
-	if {[lindex $opt 1] eq "b"} {
-	    set val $newviewopts($n,[lindex $opt 0])
-	    if {$val} {
-		lappend rargs $pattern
-	    }
-	} elseif {[regexp {^r(\d+)$} [lindex $opt 1] type value]} {
-	    regexp {^(.*_)} [lindex $opt 0] uselessvar button_id
-	    set val $newviewopts($n,$button_id)
-	    if {$val eq $value} {
-		lappend rargs $pattern
-	    }
-	} else {
-	    set val $newviewopts($n,[lindex $opt 0])
-	    set val [string trim $val]
-	    if {$val ne {}} {
-		set pfix [string range $pattern 0 end-1]
-		lappend rargs $pfix$val
-	    }
-	}
+        if {[lindex $opt 1] eq "b"} {
+            set val $newviewopts($n,[lindex $opt 0])
+            if {$val} {
+                lappend rargs $pattern
+            }
+        } elseif {[regexp {^r(\d+)$} [lindex $opt 1] type value]} {
+            regexp {^(.*_)} [lindex $opt 0] uselessvar button_id
+            set val $newviewopts($n,$button_id)
+            if {$val eq $value} {
+                lappend rargs $pattern
+            }
+        } else {
+            set val $newviewopts($n,[lindex $opt 0])
+            set val [string trim $val]
+            if {$val ne {}} {
+                set pfix [string range $pattern 0 end-1]
+                lappend rargs $pfix$val
+            }
+        }
     }
     set rargs [concat $rargs [shellsplit $newviewopts($n,refs)]]
     return [concat $rargs [shellsplit $newviewopts($n,args)]]
@@ -4173,59 +4173,59 @@ proc decode_view_opts {n view_args} {
     global known_view_options newviewopts
 
     foreach opt $known_view_options {
-	set id [lindex $opt 0]
-	if {[lindex $opt 1] eq "b"} {
-	    # Checkboxes
-	    set val 0
+        set id [lindex $opt 0]
+        if {[lindex $opt 1] eq "b"} {
+            # Checkboxes
+            set val 0
         } elseif {[regexp {^r(\d+)$} [lindex $opt 1]]} {
-	    # Radiobuttons
-	    regexp {^(.*_)} $id uselessvar id
-	    set val 0
-	} else {
-	    # Text fields
-	    set val {}
-	}
-	set newviewopts($n,$id) $val
+            # Radiobuttons
+            regexp {^(.*_)} $id uselessvar id
+            set val 0
+        } else {
+            # Text fields
+            set val {}
+        }
+        set newviewopts($n,$id) $val
     }
     set oargs [list]
     set refargs [list]
     foreach arg $view_args {
-	if {[regexp -- {^-([0-9]+)$} $arg arg cnt]
-	    && ![info exists found(limit)]} {
-	    set newviewopts($n,limit) $cnt
-	    set found(limit) 1
-	    continue
-	}
-	catch { unset val }
-	foreach opt $known_view_options {
-	    set id [lindex $opt 0]
-	    if {[info exists found($id)]} continue
-	    foreach pattern [lindex $opt 3] {
-		if {![string match $pattern $arg]} continue
-		if {[lindex $opt 1] eq "b"} {
-		    # Check buttons
-		    set val 1
-		} elseif {[regexp {^r(\d+)$} [lindex $opt 1] match num]} {
-		    # Radio buttons
-		    regexp {^(.*_)} $id uselessvar id
-		    set val $num
-		} else {
-		    # Text input fields
-		    set size [string length $pattern]
-		    set val [string range $arg [expr {$size-1}] end]
-		}
-		set newviewopts($n,$id) $val
-		set found($id) 1
-		break
-	    }
-	    if {[info exists val]} break
-	}
-	if {[info exists val]} continue
-	if {[regexp {^-} $arg]} {
-	    lappend oargs $arg
-	} else {
-	    lappend refargs $arg
-	}
+        if {[regexp -- {^-([0-9]+)$} $arg arg cnt]
+            && ![info exists found(limit)]} {
+            set newviewopts($n,limit) $cnt
+            set found(limit) 1
+            continue
+        }
+        catch { unset val }
+        foreach opt $known_view_options {
+            set id [lindex $opt 0]
+            if {[info exists found($id)]} continue
+            foreach pattern [lindex $opt 3] {
+                if {![string match $pattern $arg]} continue
+                if {[lindex $opt 1] eq "b"} {
+                    # Check buttons
+                    set val 1
+                } elseif {[regexp {^r(\d+)$} [lindex $opt 1] match num]} {
+                    # Radio buttons
+                    regexp {^(.*_)} $id uselessvar id
+                    set val $num
+                } else {
+                    # Text input fields
+                    set size [string length $pattern]
+                    set val [string range $arg [expr {$size-1}] end]
+                }
+                set newviewopts($n,$id) $val
+                set found($id) 1
+                break
+            }
+            if {[info exists val]} break
+        }
+        if {[info exists val]} continue
+        if {[regexp {^-} $arg]} {
+            lappend oargs $arg
+        } else {
+            lappend refargs $arg
+        }
     }
     set newviewopts($n,refs) [shellarglist $refargs]
     set newviewopts($n,args) [shellarglist $oargs]
@@ -4235,9 +4235,9 @@ proc edit_or_newview {} {
     global curview
 
     if {$curview > 0} {
-	editview
+        editview
     } else {
-	newview 0
+        newview 0
     }
 }
 
@@ -4248,8 +4248,8 @@ proc editview {} {
 
     set top .gitkvedit-$curview
     if {[winfo exists $top]} {
-	raise $top
-	return
+        raise $top
+        return
     }
     decode_view_opts $curview $viewargs($curview)
     set newviewname($curview)      $viewname($curview)
@@ -4279,66 +4279,66 @@ proc vieweditor {top n title} {
     set cexpand 0
     set cnt 0
     foreach opt $known_view_options {
-	set id [lindex $opt 0]
-	set type [lindex $opt 1]
-	set flags [lindex $opt 2]
-	set title [eval [lindex $opt 4]]
-	set lxpad 0
+        set id [lindex $opt 0]
+        set type [lindex $opt 1]
+        set flags [lindex $opt 2]
+        set title [eval [lindex $opt 4]]
+        set lxpad 0
 
-	if {$flags eq "+" || $flags eq "*"} {
-	    set cframe $top.fr$cnt
-	    incr cnt
-	    ${NS}::frame $cframe
-	    pack $cframe -in $top -fill x -pady 3 -padx 3
-	    set cexpand [expr {$flags eq "*"}]
+        if {$flags eq "+" || $flags eq "*"} {
+            set cframe $top.fr$cnt
+            incr cnt
+            ${NS}::frame $cframe
+            pack $cframe -in $top -fill x -pady 3 -padx 3
+            set cexpand [expr {$flags eq "*"}]
         } elseif {$flags eq ".." || $flags eq "*."} {
-	    set cframe $top.fr$cnt
-	    incr cnt
-	    ${NS}::frame $cframe
-	    pack $cframe -in $top -fill x -pady 3 -padx [list 15 3]
-	    set cexpand [expr {$flags eq "*."}]
-	} else {
-	    set lxpad 5
-	}
+            set cframe $top.fr$cnt
+            incr cnt
+            ${NS}::frame $cframe
+            pack $cframe -in $top -fill x -pady 3 -padx [list 15 3]
+            set cexpand [expr {$flags eq "*."}]
+        } else {
+            set lxpad 5
+        }
 
-	if {$type eq "l"} {
+        if {$type eq "l"} {
             ${NS}::label $cframe.l_$id -text $title
             pack $cframe.l_$id -in $cframe -side left -pady [list 3 0] -anchor w
-	} elseif {$type eq "b"} {
-	    ${NS}::checkbutton $cframe.c_$id -text $title -variable newviewopts($n,$id)
-	    pack $cframe.c_$id -in $cframe -side left \
-		-padx [list $lxpad 0] -expand $cexpand -anchor w
-	} elseif {[regexp {^r(\d+)$} $type type sz]} {
-	    regexp {^(.*_)} $id uselessvar button_id
-	    ${NS}::radiobutton $cframe.c_$id -text $title -variable newviewopts($n,$button_id) -value $sz
-	    pack $cframe.c_$id -in $cframe -side left \
-		-padx [list $lxpad 0] -expand $cexpand -anchor w
-	} elseif {[regexp {^t(\d+)$} $type type sz]} {
-	    ${NS}::label $cframe.l_$id -text $title
-	    ${NS}::entry $cframe.e_$id -width $sz -background $bgcolor \
-		-textvariable newviewopts($n,$id)
-	    pack $cframe.l_$id -in $cframe -side left -padx [list $lxpad 0]
-	    pack $cframe.e_$id -in $cframe -side left -expand 1 -fill x
-	} elseif {[regexp {^t(\d+)=$} $type type sz]} {
-	    ${NS}::label $cframe.l_$id -text $title
-	    ${NS}::entry $cframe.e_$id -width $sz -background $bgcolor \
-		-textvariable newviewopts($n,$id)
-	    pack $cframe.l_$id -in $cframe -side top -pady [list 3 0] -anchor w
-	    pack $cframe.e_$id -in $cframe -side top -fill x
-	} elseif {$type eq "path"} {
-	    ${NS}::label $top.l -text $title
-	    pack $top.l -in $top -side top -pady [list 3 0] -anchor w -padx 3
-	    text $top.t -width 40 -height 5 -background $bgcolor
-	    if {[info exists viewfiles($n)]} {
-		foreach f $viewfiles($n) {
-		    $top.t insert end $f
-		    $top.t insert end "\n"
-		}
-		$top.t delete {end - 1c} end
-		$top.t mark set insert 0.0
-	    }
-	    pack $top.t -in $top -side top -pady [list 0 5] -fill both -expand 1 -padx 3
-	}
+        } elseif {$type eq "b"} {
+            ${NS}::checkbutton $cframe.c_$id -text $title -variable newviewopts($n,$id)
+            pack $cframe.c_$id -in $cframe -side left \
+                -padx [list $lxpad 0] -expand $cexpand -anchor w
+        } elseif {[regexp {^r(\d+)$} $type type sz]} {
+            regexp {^(.*_)} $id uselessvar button_id
+            ${NS}::radiobutton $cframe.c_$id -text $title -variable newviewopts($n,$button_id) -value $sz
+            pack $cframe.c_$id -in $cframe -side left \
+                -padx [list $lxpad 0] -expand $cexpand -anchor w
+        } elseif {[regexp {^t(\d+)$} $type type sz]} {
+            ${NS}::label $cframe.l_$id -text $title
+            ${NS}::entry $cframe.e_$id -width $sz -background $bgcolor \
+                -textvariable newviewopts($n,$id)
+            pack $cframe.l_$id -in $cframe -side left -padx [list $lxpad 0]
+            pack $cframe.e_$id -in $cframe -side left -expand 1 -fill x
+        } elseif {[regexp {^t(\d+)=$} $type type sz]} {
+            ${NS}::label $cframe.l_$id -text $title
+            ${NS}::entry $cframe.e_$id -width $sz -background $bgcolor \
+                -textvariable newviewopts($n,$id)
+            pack $cframe.l_$id -in $cframe -side top -pady [list 3 0] -anchor w
+            pack $cframe.e_$id -in $cframe -side top -fill x
+        } elseif {$type eq "path"} {
+            ${NS}::label $top.l -text $title
+            pack $top.l -in $top -side top -pady [list 3 0] -anchor w -padx 3
+            text $top.t -width 40 -height 5 -background $bgcolor
+            if {[info exists viewfiles($n)]} {
+                foreach f $viewfiles($n) {
+                    $top.t insert end $f
+                    $top.t insert end "\n"
+                }
+                $top.t delete {end - 1c} end
+                $top.t mark set insert 0.0
+            }
+            pack $top.t -in $top -side top -pady [list 0 5] -fill both -expand 1 -padx 3
+        }
     }
 
     ${NS}::frame $top.buts
@@ -4359,10 +4359,10 @@ proc vieweditor {top n title} {
 proc doviewmenu {m first cmd op argv} {
     set nmenu [$m index end]
     for {set i $first} {$i <= $nmenu} {incr i} {
-	if {[$m entrycget $i -command] eq $cmd} {
-	    eval $m $op $i $argv
-	    break
-	}
+        if {[$m entrycget $i -command] eq $cmd} {
+            eval $m $op $i $argv
+            break
+        }
     }
 }
 
@@ -4379,53 +4379,53 @@ proc newviewok {top n {apply 0}} {
     global viewargs viewargscmd newviewopts viewhlmenu
 
     if {[catch {
-	set newargs [encode_view_opts $n]
+        set newargs [encode_view_opts $n]
     } err]} {
-	error_popup "[mc "Error in commit selection arguments:"] $err" $top
-	return
+        error_popup "[mc "Error in commit selection arguments:"] $err" $top
+        return
     }
     set files {}
     foreach f [split [$top.t get 0.0 end] "\n"] {
-	set ft [string trim $f]
-	if {$ft ne {}} {
-	    lappend files $ft
-	}
+        set ft [string trim $f]
+        if {$ft ne {}} {
+            lappend files $ft
+        }
     }
     if {![info exists viewfiles($n)]} {
-	# creating a new view
-	incr nextviewnum
-	set viewname($n) $newviewname($n)
-	set viewperm($n) $newviewopts($n,perm)
-	set viewchanged($n) 1
-	set viewfiles($n) $files
-	set viewargs($n) $newargs
-	set viewargscmd($n) $newviewopts($n,cmd)
-	addviewmenu $n
-	if {!$newishighlight} {
-	    run showview $n
-	} else {
-	    run addvhighlight $n
-	}
+        # creating a new view
+        incr nextviewnum
+        set viewname($n) $newviewname($n)
+        set viewperm($n) $newviewopts($n,perm)
+        set viewchanged($n) 1
+        set viewfiles($n) $files
+        set viewargs($n) $newargs
+        set viewargscmd($n) $newviewopts($n,cmd)
+        addviewmenu $n
+        if {!$newishighlight} {
+            run showview $n
+        } else {
+            run addvhighlight $n
+        }
     } else {
-	# editing an existing view
-	set viewperm($n) $newviewopts($n,perm)
-	set viewchanged($n) 1
-	if {$newviewname($n) ne $viewname($n)} {
-	    set viewname($n) $newviewname($n)
-	    doviewmenu .bar.view 5 [list showview $n] \
-		entryconf [list -label $viewname($n)]
-	    # doviewmenu $viewhlmenu 1 [list addvhighlight $n] \
-		# entryconf [list -label $viewname($n) -value $viewname($n)]
-	}
-	if {$files ne $viewfiles($n) || $newargs ne $viewargs($n) || \
-		$newviewopts($n,cmd) ne $viewargscmd($n)} {
-	    set viewfiles($n) $files
-	    set viewargs($n) $newargs
-	    set viewargscmd($n) $newviewopts($n,cmd)
-	    if {$curview == $n} {
-		run reloadcommits
-	    }
-	}
+        # editing an existing view
+        set viewperm($n) $newviewopts($n,perm)
+        set viewchanged($n) 1
+        if {$newviewname($n) ne $viewname($n)} {
+            set viewname($n) $newviewname($n)
+            doviewmenu .bar.view 5 [list showview $n] \
+                entryconf [list -label $viewname($n)]
+            # doviewmenu $viewhlmenu 1 [list addvhighlight $n] \
+                # entryconf [list -label $viewname($n) -value $viewname($n)]
+        }
+        if {$files ne $viewfiles($n) || $newargs ne $viewargs($n) || \
+                $newviewopts($n,cmd) ne $viewargscmd($n)} {
+            set viewfiles($n) $files
+            set viewargs($n) $newargs
+            set viewargscmd($n) $newviewopts($n,cmd)
+            if {$curview == $n} {
+                run reloadcommits
+            }
+        }
     }
     if {$apply} return
     catch {destroy $top}
@@ -4436,8 +4436,8 @@ proc delview {} {
 
     if {$curview == 0} return
     if {[info exists hlview] && $hlview == $curview} {
-	set selectedhlview [mc "None"]
-	unset hlview
+        set selectedhlview [mc "None"]
+        unset hlview
     }
     allviewmenus $curview delete
     set viewperm($curview) 0
@@ -4449,7 +4449,7 @@ proc addviewmenu {n} {
     global viewname viewhlmenu
 
     .bar.view add radiobutton -label $viewname($n) \
-	-command [list showview $n] -variable selectedview -value $n
+        -command [list showview $n] -variable selectedview -value $n
     #$viewhlmenu add radiobutton -label $viewname($n) \
     #	-command [list addvhighlight $n] -variable selectedhlview
 }
@@ -4474,22 +4474,22 @@ proc showview {n} {
     set ybot [expr {[lindex $span 1] * $ymax}]
     set yscreen [expr {($ybot - $ytop) / 2}]
     if {$selectedline ne {}} {
-	set selid $currentid
-	set y [yc $selectedline]
-	if {$ytop < $y && $y < $ybot} {
-	    set yscreen [expr {$y - $ytop}]
-	}
+        set selid $currentid
+        set y [yc $selectedline]
+        if {$ytop < $y && $y < $ybot} {
+            set yscreen [expr {$y - $ytop}]
+        }
     } elseif {[info exists pending_select]} {
-	set selid $pending_select
-	unset pending_select
+        set selid $pending_select
+        unset pending_select
     }
     unselectline
     normalline
     unset -nocomplain treediffs
     clear_display
     if {[info exists hlview] && $hlview == $n} {
-	unset hlview
-	set selectedhlview [mc "None"]
+        unset hlview
+        set selectedhlview [mc "None"]
     }
     unset -nocomplain commitinterest
     unset -nocomplain cached_commitrow
@@ -4502,8 +4502,8 @@ proc showview {n} {
 
     run refill_reflist
     if {![info exists viewcomplete($n)]} {
-	getcommits $selid
-	return
+        getcommits $selid
+        return
     }
 
     set displayorder {}
@@ -4523,39 +4523,39 @@ proc showview {n} {
     set yf 0
     set row {}
     if {$selid ne {} && [commitinview $selid $n]} {
-	set row [rowofcommit $selid]
-	# try to get the selected row in the same position on the screen
-	set ymax [lindex [$canv cget -scrollregion] 3]
-	set ytop [expr {[yc $row] - $yscreen}]
-	if {$ytop < 0} {
-	    set ytop 0
-	}
-	set yf [expr {$ytop * 1.0 / $ymax}]
+        set row [rowofcommit $selid]
+        # try to get the selected row in the same position on the screen
+        set ymax [lindex [$canv cget -scrollregion] 3]
+        set ytop [expr {[yc $row] - $yscreen}]
+        if {$ytop < 0} {
+            set ytop 0
+        }
+        set yf [expr {$ytop * 1.0 / $ymax}]
     }
     allcanvs yview moveto $yf
     drawvisible
     if {$row ne {}} {
-	selectline $row 0
+        selectline $row 0
     } elseif {!$viewcomplete($n)} {
-	reset_pending_select $selid
+        reset_pending_select $selid
     } else {
-	reset_pending_select {}
+        reset_pending_select {}
 
-	if {[commitinview $pending_select $curview]} {
-	    selectline [rowofcommit $pending_select] 1
-	} else {
-	    set row [first_real_row]
-	    if {$row < $numcommits} {
-		selectline $row 0
-	    }
-	}
+        if {[commitinview $pending_select $curview]} {
+            selectline [rowofcommit $pending_select] 1
+        } else {
+            set row [first_real_row]
+            if {$row < $numcommits} {
+                selectline $row 0
+            }
+        }
     }
     if {!$viewcomplete($n)} {
-	if {$numcommits == 0} {
-	    show_status [mc "Reading commits..."]
-	}
+        if {$numcommits == 0} {
+            show_status [mc "Reading commits..."]
+        }
     } elseif {$numcommits == 0} {
-	show_status [mc "No commits selected"]
+        show_status [mc "No commits selected"]
     }
     set_window_title
 }
@@ -4566,16 +4566,16 @@ proc ishighlighted {id} {
     global vhighlights fhighlights nhighlights rhighlights
 
     if {[info exists nhighlights($id)] && $nhighlights($id) > 0} {
-	return $nhighlights($id)
+        return $nhighlights($id)
     }
     if {[info exists vhighlights($id)] && $vhighlights($id) > 0} {
-	return $vhighlights($id)
+        return $vhighlights($id)
     }
     if {[info exists fhighlights($id)] && $fhighlights($id) > 0} {
-	return $fhighlights($id)
+        return $fhighlights($id)
     }
     if {[info exists rhighlights($id)] && $rhighlights($id) > 0} {
-	return $rhighlights($id)
+        return $rhighlights($id)
     }
     return 0
 }
@@ -4588,14 +4588,14 @@ proc bolden {id font} {
     lappend boldids $id
     $canv itemconf $linehtag($id) -font $font
     if {[info exists currentid] && $id eq $currentid} {
-	$canv delete secsel
-	set t [eval $canv create rect [$canv bbox $linehtag($id)] \
-		   -outline {{}} -tags secsel \
-		   -fill [$canv cget -selectbackground]]
-	$canv lower $t
+        $canv delete secsel
+        set t [eval $canv create rect [$canv bbox $linehtag($id)] \
+                   -outline {{}} -tags secsel \
+                   -fill [$canv cget -selectbackground]]
+        $canv lower $t
     }
     if {[info exists markedid] && $id eq $markedid} {
-	make_idmark $id
+        make_idmark $id
     }
 }
 
@@ -4606,11 +4606,11 @@ proc bolden_name {id font} {
     lappend boldnameids $id
     $canv2 itemconf $linentag($id) -font $font
     if {[info exists currentid] && $id eq $currentid} {
-	$canv2 delete secsel
-	set t [eval $canv2 create rect [$canv2 bbox $linentag($id)] \
-		   -outline {{}} -tags secsel \
-		   -fill [$canv2 cget -selectbackground]]
-	$canv2 lower $t
+        $canv2 delete secsel
+        set t [eval $canv2 create rect [$canv2 bbox $linentag($id)] \
+                   -outline {{}} -tags secsel \
+                   -fill [$canv2 cget -selectbackground]]
+        $canv2 lower $t
     }
 }
 
@@ -4619,11 +4619,11 @@ proc unbolden {} {
 
     set stillbold {}
     foreach id $boldids {
-	if {![ishighlighted $id]} {
-	    bolden $id mainfont
-	} else {
-	    lappend stillbold $id
-	}
+        if {![ishighlighted $id]} {
+            bolden $id mainfont
+        } else {
+            lappend stillbold $id
+        }
     }
     set boldids $stillbold
 }
@@ -4632,15 +4632,15 @@ proc addvhighlight {n} {
     global hlview viewcomplete curview vhl_done commitidx
 
     if {[info exists hlview]} {
-	delvhighlight
+        delvhighlight
     }
     set hlview $n
     if {$n != $curview && ![info exists viewcomplete($n)]} {
-	start_rev_list $n
+        start_rev_list $n
     }
     set vhl_done $commitidx($hlview)
     if {$vhl_done > 0} {
-	drawvisible
+        drawvisible
     }
 }
 
@@ -4661,16 +4661,16 @@ proc vhighlightmore {} {
     set r0 [lindex $vr 0]
     set r1 [lindex $vr 1]
     for {set i $vhl_done} {$i < $max} {incr i} {
-	set id [commitonrow $i $hlview]
-	if {[commitinview $id $curview]} {
-	    set row [rowofcommit $id]
-	    if {$r0 <= $row && $row <= $r1} {
-		if {![highlighted $row]} {
-		    bolden $id mainfontbold
-		}
-		set vhighlights($id) 1
-	    }
-	}
+        set id [commitonrow $i $hlview]
+        if {[commitinview $id $curview]} {
+            set row [rowofcommit $id]
+            if {$r0 <= $row && $row <= $r1} {
+                if {![highlighted $row]} {
+                    bolden $id mainfontbold
+                }
+                set vhighlights($id) 1
+            }
+        }
     }
     set vhl_done $max
     return 0
@@ -4680,12 +4680,12 @@ proc askvhighlight {row id} {
     global hlview vhighlights iddrawn
 
     if {[commitinview $id $hlview]} {
-	if {[info exists iddrawn($id)] && ![ishighlighted $id]} {
-	    bolden $id mainfontbold
-	}
-	set vhighlights($id) 1
+        if {[info exists iddrawn($id)] && ![ishighlighted $id]} {
+            bolden $id mainfontbold
+        }
+        set vhighlights($id) 1
     } else {
-	set vhighlights($id) 0
+        set vhighlights($id) 0
     }
 }
 
@@ -4694,18 +4694,18 @@ proc hfiles_change {} {
     global highlight_paths
 
     if {[info exists filehighlight]} {
-	# delete previous highlights
-	catch {close $filehighlight}
-	unset filehighlight
-	unset -nocomplain fhighlights
-	unbolden
-	unhighlight_filelist
+        # delete previous highlights
+        catch {close $filehighlight}
+        unset filehighlight
+        unset -nocomplain fhighlights
+        unbolden
+        unhighlight_filelist
     }
     set highlight_paths {}
     after cancel do_file_hl $fh_serial
     incr fh_serial
     if {$highlight_files ne {}} {
-	after 300 do_file_hl $fh_serial
+        after 300 do_file_hl $fh_serial
     }
 }
 
@@ -4714,21 +4714,21 @@ proc gdttype_change {name ix op} {
 
     stopfinding
     if {$findstring ne {}} {
-	if {$gdttype eq [mc "containing:"]} {
-	    if {$highlight_files ne {}} {
-		set highlight_files {}
-		hfiles_change
-	    }
-	    findcom_change
-	} else {
-	    if {$findpattern ne {}} {
-		set findpattern {}
-		findcom_change
-	    }
-	    set highlight_files $findstring
-	    hfiles_change
-	}
-	drawvisible
+        if {$gdttype eq [mc "containing:"]} {
+            if {$highlight_files ne {}} {
+                set highlight_files {}
+                hfiles_change
+            }
+            findcom_change
+        } else {
+            if {$findpattern ne {}} {
+                set findpattern {}
+                findcom_change
+            }
+            set highlight_files $findstring
+            hfiles_change
+        }
+        drawvisible
     }
     # enable/disable findtype/findloc menus too
 }
@@ -4738,12 +4738,12 @@ proc find_change {name ix op} {
 
     stopfinding
     if {$gdttype eq [mc "containing:"]} {
-	findcom_change
+        findcom_change
     } else {
-	if {$highlight_files ne $findstring} {
-	    set highlight_files $findstring
-	    hfiles_change
-	}
+        if {$highlight_files ne $findstring} {
+            set highlight_files $findstring
+            hfiles_change
+        }
     }
     drawvisible
 }
@@ -4755,33 +4755,33 @@ proc findcom_change args {
     stopfinding
     # delete previous highlights, if any
     foreach id $boldnameids {
-	bolden_name $id mainfont
+        bolden_name $id mainfont
     }
     set boldnameids {}
     unset -nocomplain nhighlights
     unbolden
     unmarkmatches
     if {$gdttype ne [mc "containing:"] || $findstring eq {}} {
-	set findpattern {}
+        set findpattern {}
     } elseif {$findtype eq [mc "Regexp"]} {
-	set findpattern $findstring
+        set findpattern $findstring
     } else {
-	set e [string map {"*" "\\*" "?" "\\?" "\[" "\\\[" "\\" "\\\\"} \
-		   $findstring]
-	set findpattern "*$e*"
+        set e [string map {"*" "\\*" "?" "\\?" "\[" "\\\[" "\\" "\\\\"} \
+                   $findstring]
+        set findpattern "*$e*"
     }
 }
 
 proc makepatterns {l} {
     set ret {}
     foreach e $l {
-	set ee [string map {"*" "\\*" "?" "\\?" "\[" "\\\[" "\\" "\\\\"} $e]
-	if {[string index $ee end] eq "/"} {
-	    lappend ret "$ee*"
-	} else {
-	    lappend ret $ee
-	    lappend ret "$ee/*"
-	}
+        set ee [string map {"*" "\\*" "?" "\\?" "\[" "\\\[" "\\" "\\\\"} $e]
+        if {[string index $ee end] eq "/"} {
+            lappend ret "$ee*"
+        } else {
+            lappend ret $ee
+            lappend ret "$ee/*"
+        }
     }
     return $ret
 }
@@ -4791,26 +4791,26 @@ proc do_file_hl {serial} {
     global cdup findtype
 
     if {$gdttype eq [mc "touching paths:"]} {
-	# If "exact" match then convert backslashes to forward slashes.
-	# Most useful to support Windows-flavoured file paths.
-	if {$findtype eq [mc "Exact"]} {
-	    set highlight_files [string map {"\\" "/"} $highlight_files]
-	}
-	if {[catch {set paths [shellsplit $highlight_files]}]} return
-	set highlight_paths [makepatterns $paths]
-	highlight_filelist
-	set relative_paths {}
-	foreach path $paths {
-	    lappend relative_paths [file join $cdup $path]
-	}
-	set gdtargs [concat -- $relative_paths]
+        # If "exact" match then convert backslashes to forward slashes.
+        # Most useful to support Windows-flavoured file paths.
+        if {$findtype eq [mc "Exact"]} {
+            set highlight_files [string map {"\\" "/"} $highlight_files]
+        }
+        if {[catch {set paths [shellsplit $highlight_files]}]} return
+        set highlight_paths [makepatterns $paths]
+        highlight_filelist
+        set relative_paths {}
+        foreach path $paths {
+            lappend relative_paths [file join $cdup $path]
+        }
+        set gdtargs [concat -- $relative_paths]
     } elseif {$gdttype eq [mc "adding/removing string:"]} {
-	set gdtargs [list "-S$highlight_files"]
+        set gdtargs [list "-S$highlight_files"]
     } elseif {$gdttype eq [mc "changing lines matching:"]} {
-	set gdtargs [list "-G$highlight_files"]
+        set gdtargs [list "-G$highlight_files"]
     } else {
-	# must be "containing:", i.e. we're searching commit info
-	return
+        # must be "containing:", i.e. we're searching commit info
+        return
     }
     set cmd [concat | git diff-tree -r -s --stdin $gdtargs]
     set filehighlight [open $cmd r+]
@@ -4825,9 +4825,9 @@ proc flushhighlights {} {
     global filehighlight fhl_list
 
     if {[info exists filehighlight]} {
-	lappend fhl_list {}
-	puts $filehighlight ""
-	flush $filehighlight
+        lappend fhl_list {}
+        puts $filehighlight ""
+        flush $filehighlight
     }
 }
 
@@ -4844,34 +4844,34 @@ proc readfhighlight {} {
     global fhl_list find_dirn
 
     if {![info exists filehighlight]} {
-	return 0
+        return 0
     }
     set nr 0
     while {[incr nr] <= 100 && [gets $filehighlight line] >= 0} {
-	set line [string trim $line]
-	set i [lsearch -exact $fhl_list $line]
-	if {$i < 0} continue
-	for {set j 0} {$j < $i} {incr j} {
-	    set id [lindex $fhl_list $j]
-	    set fhighlights($id) 0
-	}
-	set fhl_list [lrange $fhl_list [expr {$i+1}] end]
-	if {$line eq {}} continue
-	if {![commitinview $line $curview]} continue
-	if {[info exists iddrawn($line)] && ![ishighlighted $line]} {
-	    bolden $line mainfontbold
-	}
-	set fhighlights($line) 1
+        set line [string trim $line]
+        set i [lsearch -exact $fhl_list $line]
+        if {$i < 0} continue
+        for {set j 0} {$j < $i} {incr j} {
+            set id [lindex $fhl_list $j]
+            set fhighlights($id) 0
+        }
+        set fhl_list [lrange $fhl_list [expr {$i+1}] end]
+        if {$line eq {}} continue
+        if {![commitinview $line $curview]} continue
+        if {[info exists iddrawn($line)] && ![ishighlighted $line]} {
+            bolden $line mainfontbold
+        }
+        set fhighlights($line) 1
     }
     if {[eof $filehighlight]} {
-	# strange...
-	puts "oops, git diff-tree died"
-	catch {close $filehighlight}
-	unset filehighlight
-	return 0
+        # strange...
+        puts "oops, git diff-tree died"
+        catch {close $filehighlight}
+        unset filehighlight
+        return 0
     }
     if {[info exists find_dirn]} {
-	run findmore
+        run findmore
     }
     return 1
 }
@@ -4880,11 +4880,11 @@ proc doesmatch {f} {
     global findtype findpattern
 
     if {$findtype eq [mc "Regexp"]} {
-	return [regexp $findpattern $f]
+        return [regexp $findpattern $f]
     } elseif {$findtype eq [mc "IgnCase"]} {
-	return [string match -nocase $findpattern $f]
+        return [string match -nocase $findpattern $f]
     } else {
-	return [string match $findpattern $f]
+        return [string match $findpattern $f]
     }
 }
 
@@ -4894,32 +4894,32 @@ proc askfindhighlight {row id} {
     global markingmatches
 
     if {![info exists commitinfo($id)]} {
-	getcommit $id
+        getcommit $id
     }
     set info $commitinfo($id)
     set isbold 0
     set fldtypes [list [mc Headline] [mc Author] "" [mc Committer] "" [mc Comments]]
     foreach f $info ty $fldtypes {
-	if {$ty eq ""} continue
-	if {($findloc eq [mc "All fields"] || $findloc eq $ty) &&
-	    [doesmatch $f]} {
-	    if {$ty eq [mc "Author"]} {
-		set isbold 2
-		break
-	    }
-	    set isbold 1
-	}
+        if {$ty eq ""} continue
+        if {($findloc eq [mc "All fields"] || $findloc eq $ty) &&
+            [doesmatch $f]} {
+            if {$ty eq [mc "Author"]} {
+                set isbold 2
+                break
+            }
+            set isbold 1
+        }
     }
     if {$isbold && [info exists iddrawn($id)]} {
-	if {![ishighlighted $id]} {
-	    bolden $id mainfontbold
-	    if {$isbold > 1} {
-		bolden_name $id mainfontbold
-	    }
-	}
-	if {$markingmatches} {
-	    markrowmatches $row $id
-	}
+        if {![ishighlighted $id]} {
+            bolden $id mainfontbold
+            if {$isbold > 1} {
+                bolden_name $id mainfontbold
+            }
+        }
+        if {$markingmatches} {
+            markrowmatches $row $id
+        }
     }
     set nhighlights($id) $isbold
 }
@@ -4932,18 +4932,18 @@ proc markrowmatches {row id} {
     $canv delete match$row
     $canv2 delete match$row
     if {$findloc eq [mc "All fields"] || $findloc eq [mc "Headline"]} {
-	set m [findmatches $headline]
-	if {$m ne {}} {
-	    markmatches $canv $row $headline $linehtag($id) $m \
-		[$canv itemcget $linehtag($id) -font] $row
-	}
+        set m [findmatches $headline]
+        if {$m ne {}} {
+            markmatches $canv $row $headline $linehtag($id) $m \
+                [$canv itemcget $linehtag($id) -font] $row
+        }
     }
     if {$findloc eq [mc "All fields"] || $findloc eq [mc "Author"]} {
-	set m [findmatches $author]
-	if {$m ne {}} {
-	    markmatches $canv2 $row $author $linentag($id) $m \
-		[$canv2 itemcget $linentag($id) -font] $row
-	}
+        set m [findmatches $author]
+        if {$m ne {}} {
+            markmatches $canv2 $row $author $linentag($id) $m \
+                [$canv2 itemcget $linentag($id) -font] $row
+        }
     }
 }
 
@@ -4952,7 +4952,7 @@ proc vrel_change {name ix op} {
 
     rhighlight_none
     if {$highlight_related ne [mc "None"]} {
-	run drawvisible
+        run drawvisible
     }
 }
 
@@ -4966,8 +4966,8 @@ proc rhighlight_sel {a} {
     unset -nocomplain ancestor
     set anc_todo [list $a]
     if {$highlight_related ne [mc "None"]} {
-	rhighlight_none
-	run drawvisible
+        rhighlight_none
+        run drawvisible
     }
 }
 
@@ -4987,24 +4987,24 @@ proc is_descendent {a} {
     set leftover {}
     set done 0
     for {set i 0} {$i < [llength $todo]} {incr i} {
-	set do [lindex $todo $i]
-	if {[rowofcommit $do] < $la} {
-	    lappend leftover $do
-	    continue
-	}
-	foreach nk $children($v,$do) {
-	    if {![info exists descendent($nk)]} {
-		set descendent($nk) 1
-		lappend todo $nk
-		if {$nk eq $a} {
-		    set done 1
-		}
-	    }
-	}
-	if {$done} {
-	    set desc_todo [concat $leftover [lrange $todo [expr {$i+1}] end]]
-	    return
-	}
+        set do [lindex $todo $i]
+        if {[rowofcommit $do] < $la} {
+            lappend leftover $do
+            continue
+        }
+        foreach nk $children($v,$do) {
+            if {![info exists descendent($nk)]} {
+                set descendent($nk) 1
+                lappend todo $nk
+                if {$nk eq $a} {
+                    set done 1
+                }
+            }
+        }
+        if {$done} {
+            set desc_todo [concat $leftover [lrange $todo [expr {$i+1}] end]]
+            return
+        }
     }
     set descendent($a) 0
     set desc_todo $leftover
@@ -5019,24 +5019,24 @@ proc is_ancestor {a} {
     set leftover {}
     set done 0
     for {set i 0} {$i < [llength $todo]} {incr i} {
-	set do [lindex $todo $i]
-	if {![commitinview $do $v] || [rowofcommit $do] > $la} {
-	    lappend leftover $do
-	    continue
-	}
-	foreach np $parents($v,$do) {
-	    if {![info exists ancestor($np)]} {
-		set ancestor($np) 1
-		lappend todo $np
-		if {$np eq $a} {
-		    set done 1
-		}
-	    }
-	}
-	if {$done} {
-	    set anc_todo [concat $leftover [lrange $todo [expr {$i+1}] end]]
-	    return
-	}
+        set do [lindex $todo $i]
+        if {![commitinview $do $v] || [rowofcommit $do] > $la} {
+            lappend leftover $do
+            continue
+        }
+        foreach np $parents($v,$do) {
+            if {![info exists ancestor($np)]} {
+                set ancestor($np) 1
+                lappend todo $np
+                if {$np eq $a} {
+                    set done 1
+                }
+            }
+        }
+        if {$done} {
+            set anc_todo [concat $leftover [lrange $todo [expr {$i+1}] end]]
+            return
+        }
     }
     set ancestor($a) 0
     set anc_todo $leftover
@@ -5049,26 +5049,26 @@ proc askrelhighlight {row id} {
     if {$selectedline eq {}} return
     set isbold 0
     if {$highlight_related eq [mc "Descendant"] ||
-	$highlight_related eq [mc "Not descendant"]} {
-	if {![info exists descendent($id)]} {
-	    is_descendent $id
-	}
-	if {$descendent($id) == ($highlight_related eq [mc "Descendant"])} {
-	    set isbold 1
-	}
+        $highlight_related eq [mc "Not descendant"]} {
+        if {![info exists descendent($id)]} {
+            is_descendent $id
+        }
+        if {$descendent($id) == ($highlight_related eq [mc "Descendant"])} {
+            set isbold 1
+        }
     } elseif {$highlight_related eq [mc "Ancestor"] ||
-	      $highlight_related eq [mc "Not ancestor"]} {
-	if {![info exists ancestor($id)]} {
-	    is_ancestor $id
-	}
-	if {$ancestor($id) == ($highlight_related eq [mc "Ancestor"])} {
-	    set isbold 1
-	}
+              $highlight_related eq [mc "Not ancestor"]} {
+        if {![info exists ancestor($id)]} {
+            is_ancestor $id
+        }
+        if {$ancestor($id) == ($highlight_related eq [mc "Ancestor"])} {
+            set isbold 1
+        }
     }
     if {[info exists iddrawn($id)]} {
-	if {$isbold && ![ishighlighted $id]} {
-	    bolden $id mainfontbold
-	}
+        if {$isbold && ![ishighlighted $id]} {
+            bolden $id mainfontbold
+        }
     }
     set rhighlights($id) $isbold
 }
@@ -5078,13 +5078,13 @@ proc askrelhighlight {row id} {
 proc shortids {ids} {
     set res {}
     foreach id $ids {
-	if {[llength $id] > 1} {
-	    lappend res [shortids $id]
-	} elseif {[regexp {^[0-9a-f]{40}$} $id]} {
-	    lappend res [string range $id 0 7]
-	} else {
-	    lappend res $id
-	}
+        if {[llength $id] > 1} {
+            lappend res [shortids $id]
+        } elseif {[regexp {^[0-9a-f]{40}$} $id]} {
+            lappend res [string range $id 0 7]
+        } else {
+            lappend res $id
+        }
     }
     return $res
 }
@@ -5093,10 +5093,10 @@ proc ntimes {n o} {
     set ret {}
     set o [list $o]
     for {set mask 1} {$mask <= $n} {incr mask $mask} {
-	if {($n & $mask) != 0} {
-	    set ret [concat $ret $o]
-	}
-	set o [concat $o $o]
+        if {($n & $mask) != 0} {
+            set ret [concat $ret $o]
+        }
+        set o [concat $o $o]
     }
     return $ret
 }
@@ -5106,41 +5106,41 @@ proc ordertoken {id} {
     global nullid nullid2
 
     if {[info exists ordertok($id)]} {
-	return $ordertok($id)
+        return $ordertok($id)
     }
     set origid $id
     set todo {}
     while {1} {
-	if {[info exists varcid($curview,$id)]} {
-	    set a $varcid($curview,$id)
-	    set p [lindex $varcstart($curview) $a]
-	} else {
-	    set p [lindex $children($curview,$id) 0]
-	}
-	if {[info exists ordertok($p)]} {
-	    set tok $ordertok($p)
-	    break
-	}
-	set id [first_real_child $curview,$p]
-	if {$id eq {}} {
-	    # it's a root
-	    set tok [lindex $varctok($curview) $varcid($curview,$p)]
-	    break
-	}
-	if {[llength $parents($curview,$id)] == 1} {
-	    lappend todo [list $p {}]
-	} else {
-	    set j [lsearch -exact $parents($curview,$id) $p]
-	    if {$j < 0} {
-		puts "oops didn't find [shortids $p] in parents of [shortids $id]"
-	    }
-	    lappend todo [list $p [strrep $j]]
-	}
+        if {[info exists varcid($curview,$id)]} {
+            set a $varcid($curview,$id)
+            set p [lindex $varcstart($curview) $a]
+        } else {
+            set p [lindex $children($curview,$id) 0]
+        }
+        if {[info exists ordertok($p)]} {
+            set tok $ordertok($p)
+            break
+        }
+        set id [first_real_child $curview,$p]
+        if {$id eq {}} {
+            # it's a root
+            set tok [lindex $varctok($curview) $varcid($curview,$p)]
+            break
+        }
+        if {[llength $parents($curview,$id)] == 1} {
+            lappend todo [list $p {}]
+        } else {
+            set j [lsearch -exact $parents($curview,$id) $p]
+            if {$j < 0} {
+                puts "oops didn't find [shortids $p] in parents of [shortids $id]"
+            }
+            lappend todo [list $p [strrep $j]]
+        }
     }
     for {set i [llength $todo]} {[incr i -1] >= 0} {} {
-	set p [lindex $todo $i 0]
-	append tok [lindex $todo $i 1]
-	set ordertok($p) $tok
+        set p [lindex $todo $i 0]
+        append tok [lindex $todo $i 1]
+        set ordertok($p) $tok
     }
     set ordertok($origid) $tok
     return $tok
@@ -5151,19 +5151,19 @@ proc ordertoken {id} {
 proc idcol {idlist id {i 0}} {
     set t [ordertoken $id]
     if {$i < 0} {
-	set i 0
+        set i 0
     }
     if {$i >= [llength $idlist] || $t < [ordertoken [lindex $idlist $i]]} {
-	if {$i > [llength $idlist]} {
-	    set i [llength $idlist]
-	}
-	while {[incr i -1] >= 0 && $t < [ordertoken [lindex $idlist $i]]} {}
-	incr i
+        if {$i > [llength $idlist]} {
+            set i [llength $idlist]
+        }
+        while {[incr i -1] >= 0 && $t < [ordertoken [lindex $idlist $i]]} {}
+        incr i
     } else {
-	if {$t > [ordertoken [lindex $idlist $i]]} {
-	    while {[incr i] < [llength $idlist] &&
-		   $t >= [ordertoken [lindex $idlist $i]]} {}
-	}
+        if {$t > [ordertoken [lindex $idlist $i]]} {
+            while {[incr i] < [llength $idlist] &&
+                   $t >= [ordertoken [lindex $idlist $i]]} {}
+        }
     }
     return $i
 }
@@ -5208,12 +5208,12 @@ proc visiblerows {} {
     set y0 [expr {int([lindex $f 0] * $ymax)}]
     set r0 [expr {int(($y0 - 3) / $linespc) - 1}]
     if {$r0 < 0} {
-	set r0 0
+        set r0 0
     }
     set y1 [expr {int([lindex $f 1] * $ymax)}]
     set r1 [expr {int(($y1 - 3) / $linespc) + 1}]
     if {$r1 >= $numcommits} {
-	set r1 [expr {$numcommits - 1}]
+        set r1 [expr {$numcommits - 1}]
     }
     return [list $r0 $r1]
 }
@@ -5224,13 +5224,13 @@ proc layoutmore {} {
     global lastscrollset lastscrollrows
 
     if {$lastscrollrows < 100 || $viewcomplete($curview) ||
-	[clock clicks -milliseconds] - $lastscrollset > 500} {
-	setcanvscroll
+        [clock clicks -milliseconds] - $lastscrollset > 500} {
+        setcanvscroll
     }
     if {[info exists pending_select] &&
-	[commitinview $pending_select $curview]} {
-	update
-	selectline [rowofcommit $pending_select] 1
+        [commitinview $pending_select $curview]} {
+        update
+        selectline [rowofcommit $pending_select] 1
     }
     drawvisible
 }
@@ -5242,13 +5242,13 @@ proc get_viewmainhead {view} {
     global viewmainheadid vfilelimit viewinstances mainheadid
 
     catch {
-	set rfd [open [concat | git rev-list -1 $mainheadid \
-			   -- $vfilelimit($view)] r]
-	set j [reg_instance $rfd]
-	lappend viewinstances($view) $j
-	fconfigure $rfd -blocking 0
-	filerun $rfd [list getviewhead $rfd $j $view]
-	set viewmainheadid($curview) {}
+        set rfd [open [concat | git rev-list -1 $mainheadid \
+                           -- $vfilelimit($view)] r]
+        set j [reg_instance $rfd]
+        lappend viewinstances($view) $j
+        fconfigure $rfd -blocking 0
+        filerun $rfd [list getviewhead $rfd $j $view]
+        set viewmainheadid($curview) {}
     }
 }
 
@@ -5258,21 +5258,21 @@ proc getviewhead {fd inst view} {
 
     set id {}
     if {[gets $fd line] < 0} {
-	if {![eof $fd]} {
-	    return 1
-	}
+        if {![eof $fd]} {
+            return 1
+        }
     } elseif {[string length $line] == 40 && [string is xdigit $line]} {
-	set id $line
+        set id $line
     }
     set viewmainheadid($view) $id
     close $fd
     unset commfd($inst)
     set i [lsearch -exact $viewinstances($view) $inst]
     if {$i >= 0} {
-	set viewinstances($view) [lreplace $viewinstances($view) $i $i]
+        set viewinstances($view) [lreplace $viewinstances($view) $i $i]
     }
     if {$showlocalchanges && $id ne {} && $view == $curview} {
-	doshowlocalchanges
+        doshowlocalchanges
     }
     return 0
 }
@@ -5282,9 +5282,9 @@ proc doshowlocalchanges {} {
 
     if {$viewmainheadid($curview) eq {}} return
     if {[commitinview $viewmainheadid($curview) $curview]} {
-	dodiffindex
+        dodiffindex
     } else {
-	interestedin $viewmainheadid($curview) dodiffindex
+        interestedin $viewmainheadid($curview) dodiffindex
     }
 }
 
@@ -5292,10 +5292,10 @@ proc dohidelocalchanges {} {
     global nullid nullid2 lserial curview
 
     if {[commitinview $nullid $curview]} {
-	removefakerow $nullid
+        removefakerow $nullid
     }
     if {[commitinview $nullid2 $curview]} {
-	removefakerow $nullid2
+        removefakerow $nullid2
     }
     incr lserial
 }
@@ -5308,12 +5308,12 @@ proc dodiffindex {} {
     if {!$showlocalchanges || !$hasworktree} return
     incr lserial
     if {[package vcompare $git_version "1.7.2"] >= 0} {
-	set cmd "|git diff-index --cached --ignore-submodules=dirty HEAD"
+        set cmd "|git diff-index --cached --ignore-submodules=dirty HEAD"
     } else {
-	set cmd "|git diff-index --cached HEAD"
+        set cmd "|git diff-index --cached HEAD"
     }
     if {$vfilelimit($curview) ne {}} {
-	set cmd [concat $cmd -- $vfilelimit($curview)]
+        set cmd [concat $cmd -- $vfilelimit($curview)]
     }
     set fd [open $cmd r]
     fconfigure $fd -blocking 0
@@ -5327,22 +5327,22 @@ proc readdiffindex {fd serial inst} {
 
     set isdiff 1
     if {[gets $fd line] < 0} {
-	if {![eof $fd]} {
-	    return 1
-	}
-	set isdiff 0
+        if {![eof $fd]} {
+            return 1
+        }
+        set isdiff 0
     }
     # we only need to see one line and we don't really care what it says...
     stop_instance $inst
 
     if {$serial != $lserial} {
-	return 0
+        return 0
     }
 
     # now see if there are any local changes not checked in to the index
     set cmd "|git diff-files"
     if {$vfilelimit($curview) ne {}} {
-	set cmd [concat $cmd -- $vfilelimit($curview)]
+        set cmd [concat $cmd -- $vfilelimit($curview)]
     }
     set fd [open $cmd r]
     fconfigure $fd -blocking 0
@@ -5350,19 +5350,19 @@ proc readdiffindex {fd serial inst} {
     filerun $fd [list readdifffiles $fd $serial $i]
 
     if {$isdiff && ![commitinview $nullid2 $curview]} {
-	# add the line for the changes in the index to the graph
-	set hl [mc "Local changes checked in to index but not committed"]
-	set commitinfo($nullid2) [list  $hl {} {} {} {} "    $hl\n"]
-	set commitdata($nullid2) "\n    $hl\n"
-	if {[commitinview $nullid $curview]} {
-	    removefakerow $nullid
-	}
-	insertfakerow $nullid2 $viewmainheadid($curview)
+        # add the line for the changes in the index to the graph
+        set hl [mc "Local changes checked in to index but not committed"]
+        set commitinfo($nullid2) [list  $hl {} {} {} {} "    $hl\n"]
+        set commitdata($nullid2) "\n    $hl\n"
+        if {[commitinview $nullid $curview]} {
+            removefakerow $nullid
+        }
+        insertfakerow $nullid2 $viewmainheadid($curview)
     } elseif {!$isdiff && [commitinview $nullid2 $curview]} {
-	if {[commitinview $nullid $curview]} {
-	    removefakerow $nullid
-	}
-	removefakerow $nullid2
+        if {[commitinview $nullid $curview]} {
+            removefakerow $nullid
+        }
+        removefakerow $nullid2
     }
     return 0
 }
@@ -5373,31 +5373,31 @@ proc readdifffiles {fd serial inst} {
 
     set isdiff 1
     if {[gets $fd line] < 0} {
-	if {![eof $fd]} {
-	    return 1
-	}
-	set isdiff 0
+        if {![eof $fd]} {
+            return 1
+        }
+        set isdiff 0
     }
     # we only need to see one line and we don't really care what it says...
     stop_instance $inst
 
     if {$serial != $lserial} {
-	return 0
+        return 0
     }
 
     if {$isdiff && ![commitinview $nullid $curview]} {
-	# add the line for the local diff to the graph
-	set hl [mc "Local uncommitted changes, not checked in to index"]
-	set commitinfo($nullid) [list  $hl {} {} {} {} "    $hl\n"]
-	set commitdata($nullid) "\n    $hl\n"
-	if {[commitinview $nullid2 $curview]} {
-	    set p $nullid2
-	} else {
-	    set p $viewmainheadid($curview)
-	}
-	insertfakerow $nullid $p
+        # add the line for the local diff to the graph
+        set hl [mc "Local uncommitted changes, not checked in to index"]
+        set commitinfo($nullid) [list  $hl {} {} {} {} "    $hl\n"]
+        set commitdata($nullid) "\n    $hl\n"
+        if {[commitinview $nullid2 $curview]} {
+            set p $nullid2
+        } else {
+            set p $viewmainheadid($curview)
+        }
+        insertfakerow $nullid $p
     } elseif {!$isdiff && [commitinview $nullid $curview]} {
-	removefakerow $nullid
+        removefakerow $nullid
     }
     return 0
 }
@@ -5406,17 +5406,17 @@ proc nextuse {id row} {
     global curview children
 
     if {[info exists children($curview,$id)]} {
-	foreach kid $children($curview,$id) {
-	    if {![commitinview $kid $curview]} {
-		return -1
-	    }
-	    if {[rowofcommit $kid] > $row} {
-		return [rowofcommit $kid]
-	    }
-	}
+        foreach kid $children($curview,$id) {
+            if {![commitinview $kid $curview]} {
+                return -1
+            }
+            if {[rowofcommit $kid] > $row} {
+                return [rowofcommit $kid]
+            }
+        }
     }
     if {[commitinview $id $curview]} {
-	return [rowofcommit $id]
+        return [rowofcommit $id]
     }
     return -1
 }
@@ -5426,12 +5426,12 @@ proc prevuse {id row} {
 
     set ret -1
     if {[info exists children($curview,$id)]} {
-	foreach kid $children($curview,$id) {
-	    if {![commitinview $kid $curview]} break
-	    if {[rowofcommit $kid] < $row} {
-		set ret [rowofcommit $kid]
-	    }
-	}
+        foreach kid $children($curview,$id) {
+            if {![commitinview $kid $curview]} break
+            if {[rowofcommit $kid] < $row} {
+                set ret [rowofcommit $kid]
+            }
+        }
     }
     return $ret
 }
@@ -5442,70 +5442,70 @@ proc make_idlist {row} {
 
     set r [expr {$row - $mingaplen - $downarrowlen - 1}]
     if {$r < 0} {
-	set r 0
+        set r 0
     }
     set ra [expr {$row - $downarrowlen}]
     if {$ra < 0} {
-	set ra 0
+        set ra 0
     }
     set rb [expr {$row + $uparrowlen}]
     if {$rb > $commitidx($curview)} {
-	set rb $commitidx($curview)
+        set rb $commitidx($curview)
     }
     make_disporder $r [expr {$rb + 1}]
     set ids {}
     for {} {$r < $ra} {incr r} {
-	set nextid [lindex $displayorder [expr {$r + 1}]]
-	foreach p [lindex $parentlist $r] {
-	    if {$p eq $nextid} continue
-	    set rn [nextuse $p $r]
-	    if {$rn >= $row &&
-		$rn <= $r + $downarrowlen + $mingaplen + $uparrowlen} {
-		lappend ids [list [ordertoken $p] $p]
-	    }
-	}
+        set nextid [lindex $displayorder [expr {$r + 1}]]
+        foreach p [lindex $parentlist $r] {
+            if {$p eq $nextid} continue
+            set rn [nextuse $p $r]
+            if {$rn >= $row &&
+                $rn <= $r + $downarrowlen + $mingaplen + $uparrowlen} {
+                lappend ids [list [ordertoken $p] $p]
+            }
+        }
     }
     for {} {$r < $row} {incr r} {
-	set nextid [lindex $displayorder [expr {$r + 1}]]
-	foreach p [lindex $parentlist $r] {
-	    if {$p eq $nextid} continue
-	    set rn [nextuse $p $r]
-	    if {$rn < 0 || $rn >= $row} {
-		lappend ids [list [ordertoken $p] $p]
-	    }
-	}
+        set nextid [lindex $displayorder [expr {$r + 1}]]
+        foreach p [lindex $parentlist $r] {
+            if {$p eq $nextid} continue
+            set rn [nextuse $p $r]
+            if {$rn < 0 || $rn >= $row} {
+                lappend ids [list [ordertoken $p] $p]
+            }
+        }
     }
     set id [lindex $displayorder $row]
     lappend ids [list [ordertoken $id] $id]
     while {$r < $rb} {
-	foreach p [lindex $parentlist $r] {
-	    set firstkid [lindex $children($curview,$p) 0]
-	    if {[rowofcommit $firstkid] < $row} {
-		lappend ids [list [ordertoken $p] $p]
-	    }
-	}
-	incr r
-	set id [lindex $displayorder $r]
-	if {$id ne {}} {
-	    set firstkid [lindex $children($curview,$id) 0]
-	    if {$firstkid ne {} && [rowofcommit $firstkid] < $row} {
-		lappend ids [list [ordertoken $id] $id]
-	    }
-	}
+        foreach p [lindex $parentlist $r] {
+            set firstkid [lindex $children($curview,$p) 0]
+            if {[rowofcommit $firstkid] < $row} {
+                lappend ids [list [ordertoken $p] $p]
+            }
+        }
+        incr r
+        set id [lindex $displayorder $r]
+        if {$id ne {}} {
+            set firstkid [lindex $children($curview,$id) 0]
+            if {$firstkid ne {} && [rowofcommit $firstkid] < $row} {
+                lappend ids [list [ordertoken $id] $id]
+            }
+        }
     }
     set idlist {}
     foreach idx [lsort -unique $ids] {
-	lappend idlist [lindex $idx 1]
+        lappend idlist [lindex $idx 1]
     }
     return $idlist
 }
 
 proc rowsequal {a b} {
     while {[set i [lsearch -exact $a {}]] >= 0} {
-	set a [lreplace $a $i $i]
+        set a [lreplace $a $i $i]
     }
     while {[set i [lsearch -exact $b {}]] >= 0} {
-	set b [lreplace $b $i $i]
+        set b [lreplace $b $i $i]
     }
     return [expr {$a eq $b}]
 }
@@ -5514,20 +5514,20 @@ proc makeupline {id row rend col} {
     global rowidlist uparrowlen downarrowlen mingaplen
 
     for {set r $rend} {1} {set r $rstart} {
-	set rstart [prevuse $id $r]
-	if {$rstart < 0} return
-	if {$rstart < $row} break
+        set rstart [prevuse $id $r]
+        if {$rstart < 0} return
+        if {$rstart < $row} break
     }
     if {$rstart + $uparrowlen + $mingaplen + $downarrowlen < $rend} {
-	set rstart [expr {$rend - $uparrowlen - 1}]
+        set rstart [expr {$rend - $uparrowlen - 1}]
     }
     for {set r $rstart} {[incr r] <= $row} {} {
-	set idlist [lindex $rowidlist $r]
-	if {$idlist ne {} && [lsearch -exact $idlist $id] < 0} {
-	    set col [idcol $idlist $id $col]
-	    lset rowidlist $r [linsert $idlist $col $id]
-	    changedrow $r
-	}
+        set idlist [lindex $rowidlist $r]
+        if {$idlist ne {} && [lsearch -exact $idlist $id] < 0} {
+            set col [idcol $idlist $id $col]
+            lset rowidlist $r [linsert $idlist $col $id]
+            changedrow $r
+        }
     }
 }
 
@@ -5540,100 +5540,100 @@ proc layoutrows {row endrow} {
     make_disporder [expr {$row - 1}] [expr {$endrow + $uparrowlen}]
     set idlist {}
     if {$row > 0} {
-	set rm1 [expr {$row - 1}]
-	foreach id [lindex $rowidlist $rm1] {
-	    if {$id ne {}} {
-		lappend idlist $id
-	    }
-	}
-	set final [lindex $rowfinal $rm1]
+        set rm1 [expr {$row - 1}]
+        foreach id [lindex $rowidlist $rm1] {
+            if {$id ne {}} {
+                lappend idlist $id
+            }
+        }
+        set final [lindex $rowfinal $rm1]
     }
     for {} {$row < $endrow} {incr row} {
-	set rm1 [expr {$row - 1}]
-	if {$rm1 < 0 || $idlist eq {}} {
-	    set idlist [make_idlist $row]
-	    set final 1
-	} else {
-	    set id [lindex $displayorder $rm1]
-	    set col [lsearch -exact $idlist $id]
-	    set idlist [lreplace $idlist $col $col]
-	    foreach p [lindex $parentlist $rm1] {
-		if {[lsearch -exact $idlist $p] < 0} {
-		    set col [idcol $idlist $p $col]
-		    set idlist [linsert $idlist $col $p]
-		    # if not the first child, we have to insert a line going up
-		    if {$id ne [lindex $children($curview,$p) 0]} {
-			makeupline $p $rm1 $row $col
-		    }
-		}
-	    }
-	    set id [lindex $displayorder $row]
-	    if {$row > $downarrowlen} {
-		set termrow [expr {$row - $downarrowlen - 1}]
-		foreach p [lindex $parentlist $termrow] {
-		    set i [lsearch -exact $idlist $p]
-		    if {$i < 0} continue
-		    set nr [nextuse $p $termrow]
-		    if {$nr < 0 || $nr >= $row + $mingaplen + $uparrowlen} {
-			set idlist [lreplace $idlist $i $i]
-		    }
-		}
-	    }
-	    set col [lsearch -exact $idlist $id]
-	    if {$col < 0} {
-		set col [idcol $idlist $id]
-		set idlist [linsert $idlist $col $id]
-		if {$children($curview,$id) ne {}} {
-		    makeupline $id $rm1 $row $col
-		}
-	    }
-	    set r [expr {$row + $uparrowlen - 1}]
-	    if {$r < $commitidx($curview)} {
-		set x $col
-		foreach p [lindex $parentlist $r] {
-		    if {[lsearch -exact $idlist $p] >= 0} continue
-		    set fk [lindex $children($curview,$p) 0]
-		    if {[rowofcommit $fk] < $row} {
-			set x [idcol $idlist $p $x]
-			set idlist [linsert $idlist $x $p]
-		    }
-		}
-		if {[incr r] < $commitidx($curview)} {
-		    set p [lindex $displayorder $r]
-		    if {[lsearch -exact $idlist $p] < 0} {
-			set fk [lindex $children($curview,$p) 0]
-			if {$fk ne {} && [rowofcommit $fk] < $row} {
-			    set x [idcol $idlist $p $x]
-			    set idlist [linsert $idlist $x $p]
-			}
-		    }
-		}
-	    }
-	}
-	if {$final && !$viewcomplete($curview) &&
-	    $row + $uparrowlen + $mingaplen + $downarrowlen
-		>= $commitidx($curview)} {
-	    set final 0
-	}
-	set l [llength $rowidlist]
-	if {$row == $l} {
-	    lappend rowidlist $idlist
-	    lappend rowisopt 0
-	    lappend rowfinal $final
-	} elseif {$row < $l} {
-	    if {![rowsequal $idlist [lindex $rowidlist $row]]} {
-		lset rowidlist $row $idlist
-		changedrow $row
-	    }
-	    lset rowfinal $row $final
-	} else {
-	    set pad [ntimes [expr {$row - $l}] {}]
-	    set rowidlist [concat $rowidlist $pad]
-	    lappend rowidlist $idlist
-	    set rowfinal [concat $rowfinal $pad]
-	    lappend rowfinal $final
-	    set rowisopt [concat $rowisopt [ntimes [expr {$row - $l + 1}] 0]]
-	}
+        set rm1 [expr {$row - 1}]
+        if {$rm1 < 0 || $idlist eq {}} {
+            set idlist [make_idlist $row]
+            set final 1
+        } else {
+            set id [lindex $displayorder $rm1]
+            set col [lsearch -exact $idlist $id]
+            set idlist [lreplace $idlist $col $col]
+            foreach p [lindex $parentlist $rm1] {
+                if {[lsearch -exact $idlist $p] < 0} {
+                    set col [idcol $idlist $p $col]
+                    set idlist [linsert $idlist $col $p]
+                    # if not the first child, we have to insert a line going up
+                    if {$id ne [lindex $children($curview,$p) 0]} {
+                        makeupline $p $rm1 $row $col
+                    }
+                }
+            }
+            set id [lindex $displayorder $row]
+            if {$row > $downarrowlen} {
+                set termrow [expr {$row - $downarrowlen - 1}]
+                foreach p [lindex $parentlist $termrow] {
+                    set i [lsearch -exact $idlist $p]
+                    if {$i < 0} continue
+                    set nr [nextuse $p $termrow]
+                    if {$nr < 0 || $nr >= $row + $mingaplen + $uparrowlen} {
+                        set idlist [lreplace $idlist $i $i]
+                    }
+                }
+            }
+            set col [lsearch -exact $idlist $id]
+            if {$col < 0} {
+                set col [idcol $idlist $id]
+                set idlist [linsert $idlist $col $id]
+                if {$children($curview,$id) ne {}} {
+                    makeupline $id $rm1 $row $col
+                }
+            }
+            set r [expr {$row + $uparrowlen - 1}]
+            if {$r < $commitidx($curview)} {
+                set x $col
+                foreach p [lindex $parentlist $r] {
+                    if {[lsearch -exact $idlist $p] >= 0} continue
+                    set fk [lindex $children($curview,$p) 0]
+                    if {[rowofcommit $fk] < $row} {
+                        set x [idcol $idlist $p $x]
+                        set idlist [linsert $idlist $x $p]
+                    }
+                }
+                if {[incr r] < $commitidx($curview)} {
+                    set p [lindex $displayorder $r]
+                    if {[lsearch -exact $idlist $p] < 0} {
+                        set fk [lindex $children($curview,$p) 0]
+                        if {$fk ne {} && [rowofcommit $fk] < $row} {
+                            set x [idcol $idlist $p $x]
+                            set idlist [linsert $idlist $x $p]
+                        }
+                    }
+                }
+            }
+        }
+        if {$final && !$viewcomplete($curview) &&
+            $row + $uparrowlen + $mingaplen + $downarrowlen
+                >= $commitidx($curview)} {
+            set final 0
+        }
+        set l [llength $rowidlist]
+        if {$row == $l} {
+            lappend rowidlist $idlist
+            lappend rowisopt 0
+            lappend rowfinal $final
+        } elseif {$row < $l} {
+            if {![rowsequal $idlist [lindex $rowidlist $row]]} {
+                lset rowidlist $row $idlist
+                changedrow $row
+            }
+            lset rowfinal $row $final
+        } else {
+            set pad [ntimes [expr {$row - $l}] {}]
+            set rowidlist [concat $rowidlist $pad]
+            lappend rowidlist $idlist
+            set rowfinal [concat $rowfinal $pad]
+            lappend rowfinal $final
+            set rowisopt [concat $rowisopt [ntimes [expr {$row - $l + 1}] 0]]
+        }
     }
     return $row
 }
@@ -5643,17 +5643,17 @@ proc changedrow {row} {
 
     set l [llength $rowisopt]
     if {$row < $l} {
-	lset rowisopt $row 0
-	if {$row + 1 < $l} {
-	    lset rowisopt [expr {$row + 1}] 0
-	    if {$row + 2 < $l} {
-		lset rowisopt [expr {$row + 2}] 0
-	    }
-	}
+        lset rowisopt $row 0
+        if {$row + 1 < $l} {
+            lset rowisopt [expr {$row + 1}] 0
+            if {$row + 2 < $l} {
+                lset rowisopt [expr {$row + 2}] 0
+            }
+        }
     }
     set id [lindex $displayorder $row]
     if {[info exists iddrawn($id)]} {
-	set need_redisplay 1
+        set need_redisplay 1
     }
 }
 
@@ -5666,7 +5666,7 @@ proc insert_pad {row col npad} {
     set aft [lrange $idlist $col end]
     set i [lsearch -exact $aft {}]
     if {$i > 0} {
-	set aft [lreplace $aft $i $i]
+        set aft [lreplace $aft $i $i]
     }
     lset rowidlist $row [concat $bef $pad $aft]
     changedrow $row
@@ -5676,123 +5676,123 @@ proc optimize_rows {row col endrow} {
     global rowidlist rowisopt displayorder curview children
 
     if {$row < 1} {
-	set row 1
+        set row 1
     }
     for {} {$row < $endrow} {incr row; set col 0} {
-	if {[lindex $rowisopt $row]} continue
-	set haspad 0
-	set y0 [expr {$row - 1}]
-	set ym [expr {$row - 2}]
-	set idlist [lindex $rowidlist $row]
-	set previdlist [lindex $rowidlist $y0]
-	if {$idlist eq {} || $previdlist eq {}} continue
-	if {$ym >= 0} {
-	    set pprevidlist [lindex $rowidlist $ym]
-	    if {$pprevidlist eq {}} continue
-	} else {
-	    set pprevidlist {}
-	}
-	set x0 -1
-	set xm -1
-	for {} {$col < [llength $idlist]} {incr col} {
-	    set id [lindex $idlist $col]
-	    if {[lindex $previdlist $col] eq $id} continue
-	    if {$id eq {}} {
-		set haspad 1
-		continue
-	    }
-	    set x0 [lsearch -exact $previdlist $id]
-	    if {$x0 < 0} continue
-	    set z [expr {$x0 - $col}]
-	    set isarrow 0
-	    set z0 {}
-	    if {$ym >= 0} {
-		set xm [lsearch -exact $pprevidlist $id]
-		if {$xm >= 0} {
-		    set z0 [expr {$xm - $x0}]
-		}
-	    }
-	    if {$z0 eq {}} {
-		# if row y0 is the first child of $id then it's not an arrow
-		if {[lindex $children($curview,$id) 0] ne
-		    [lindex $displayorder $y0]} {
-		    set isarrow 1
-		}
-	    }
-	    if {!$isarrow && $id ne [lindex $displayorder $row] &&
-		[lsearch -exact [lindex $rowidlist [expr {$row+1}]] $id] < 0} {
-		set isarrow 1
-	    }
-	    # Looking at lines from this row to the previous row,
-	    # make them go straight up if they end in an arrow on
-	    # the previous row; otherwise make them go straight up
-	    # or at 45 degrees.
-	    if {$z < -1 || ($z < 0 && $isarrow)} {
-		# Line currently goes left too much;
-		# insert pads in the previous row, then optimize it
-		set npad [expr {-1 - $z + $isarrow}]
-		insert_pad $y0 $x0 $npad
-		if {$y0 > 0} {
-		    optimize_rows $y0 $x0 $row
-		}
-		set previdlist [lindex $rowidlist $y0]
-		set x0 [lsearch -exact $previdlist $id]
-		set z [expr {$x0 - $col}]
-		if {$z0 ne {}} {
-		    set pprevidlist [lindex $rowidlist $ym]
-		    set xm [lsearch -exact $pprevidlist $id]
-		    set z0 [expr {$xm - $x0}]
-		}
-	    } elseif {$z > 1 || ($z > 0 && $isarrow)} {
-		# Line currently goes right too much;
-		# insert pads in this line
-		set npad [expr {$z - 1 + $isarrow}]
-		insert_pad $row $col $npad
-		set idlist [lindex $rowidlist $row]
-		incr col $npad
-		set z [expr {$x0 - $col}]
-		set haspad 1
-	    }
-	    if {$z0 eq {} && !$isarrow && $ym >= 0} {
-		# this line links to its first child on row $row-2
-		set id [lindex $displayorder $ym]
-		set xc [lsearch -exact $pprevidlist $id]
-		if {$xc >= 0} {
-		    set z0 [expr {$xc - $x0}]
-		}
-	    }
-	    # avoid lines jigging left then immediately right
-	    if {$z0 ne {} && $z < 0 && $z0 > 0} {
-		insert_pad $y0 $x0 1
-		incr x0
-		optimize_rows $y0 $x0 $row
-		set previdlist [lindex $rowidlist $y0]
-	    }
-	}
-	if {!$haspad} {
-	    # Find the first column that doesn't have a line going right
-	    for {set col [llength $idlist]} {[incr col -1] >= 0} {} {
-		set id [lindex $idlist $col]
-		if {$id eq {}} break
-		set x0 [lsearch -exact $previdlist $id]
-		if {$x0 < 0} {
-		    # check if this is the link to the first child
-		    set kid [lindex $displayorder $y0]
-		    if {[lindex $children($curview,$id) 0] eq $kid} {
-			# it is, work out offset to child
-			set x0 [lsearch -exact $previdlist $kid]
-		    }
-		}
-		if {$x0 <= $col} break
-	    }
-	    # Insert a pad at that column as long as it has a line and
-	    # isn't the last column
-	    if {$x0 >= 0 && [incr col] < [llength $idlist]} {
-		set idlist [linsert $idlist $col {}]
-		lset rowidlist $row $idlist
-		changedrow $row
-	    }
-	}
+        if {[lindex $rowisopt $row]} continue
+        set haspad 0
+        set y0 [expr {$row - 1}]
+        set ym [expr {$row - 2}]
+        set idlist [lindex $rowidlist $row]
+        set previdlist [lindex $rowidlist $y0]
+        if {$idlist eq {} || $previdlist eq {}} continue
+        if {$ym >= 0} {
+            set pprevidlist [lindex $rowidlist $ym]
+            if {$pprevidlist eq {}} continue
+        } else {
+            set pprevidlist {}
+        }
+        set x0 -1
+        set xm -1
+        for {} {$col < [llength $idlist]} {incr col} {
+            set id [lindex $idlist $col]
+            if {[lindex $previdlist $col] eq $id} continue
+            if {$id eq {}} {
+                set haspad 1
+                continue
+            }
+            set x0 [lsearch -exact $previdlist $id]
+            if {$x0 < 0} continue
+            set z [expr {$x0 - $col}]
+            set isarrow 0
+            set z0 {}
+            if {$ym >= 0} {
+                set xm [lsearch -exact $pprevidlist $id]
+                if {$xm >= 0} {
+                    set z0 [expr {$xm - $x0}]
+                }
+            }
+            if {$z0 eq {}} {
+                # if row y0 is the first child of $id then it's not an arrow
+                if {[lindex $children($curview,$id) 0] ne
+                    [lindex $displayorder $y0]} {
+                    set isarrow 1
+                }
+            }
+            if {!$isarrow && $id ne [lindex $displayorder $row] &&
+                [lsearch -exact [lindex $rowidlist [expr {$row+1}]] $id] < 0} {
+                set isarrow 1
+            }
+            # Looking at lines from this row to the previous row,
+            # make them go straight up if they end in an arrow on
+            # the previous row; otherwise make them go straight up
+            # or at 45 degrees.
+            if {$z < -1 || ($z < 0 && $isarrow)} {
+                # Line currently goes left too much;
+                # insert pads in the previous row, then optimize it
+                set npad [expr {-1 - $z + $isarrow}]
+                insert_pad $y0 $x0 $npad
+                if {$y0 > 0} {
+                    optimize_rows $y0 $x0 $row
+                }
+                set previdlist [lindex $rowidlist $y0]
+                set x0 [lsearch -exact $previdlist $id]
+                set z [expr {$x0 - $col}]
+                if {$z0 ne {}} {
+                    set pprevidlist [lindex $rowidlist $ym]
+                    set xm [lsearch -exact $pprevidlist $id]
+                    set z0 [expr {$xm - $x0}]
+                }
+            } elseif {$z > 1 || ($z > 0 && $isarrow)} {
+                # Line currently goes right too much;
+                # insert pads in this line
+                set npad [expr {$z - 1 + $isarrow}]
+                insert_pad $row $col $npad
+                set idlist [lindex $rowidlist $row]
+                incr col $npad
+                set z [expr {$x0 - $col}]
+                set haspad 1
+            }
+            if {$z0 eq {} && !$isarrow && $ym >= 0} {
+                # this line links to its first child on row $row-2
+                set id [lindex $displayorder $ym]
+                set xc [lsearch -exact $pprevidlist $id]
+                if {$xc >= 0} {
+                    set z0 [expr {$xc - $x0}]
+                }
+            }
+            # avoid lines jigging left then immediately right
+            if {$z0 ne {} && $z < 0 && $z0 > 0} {
+                insert_pad $y0 $x0 1
+                incr x0
+                optimize_rows $y0 $x0 $row
+                set previdlist [lindex $rowidlist $y0]
+            }
+        }
+        if {!$haspad} {
+            # Find the first column that doesn't have a line going right
+            for {set col [llength $idlist]} {[incr col -1] >= 0} {} {
+                set id [lindex $idlist $col]
+                if {$id eq {}} break
+                set x0 [lsearch -exact $previdlist $id]
+                if {$x0 < 0} {
+                    # check if this is the link to the first child
+                    set kid [lindex $displayorder $y0]
+                    if {[lindex $children($curview,$id) 0] eq $kid} {
+                        # it is, work out offset to child
+                        set x0 [lsearch -exact $previdlist $kid]
+                    }
+                }
+                if {$x0 <= $col} break
+            }
+            # Insert a pad at that column as long as it has a line and
+            # isn't the last column
+            if {$x0 >= 0 && [incr col] < [llength $idlist]} {
+                set idlist [linsert $idlist $col {}]
+                lset rowidlist $row $idlist
+                changedrow $row
+            }
+        }
     }
 }
 
@@ -5811,7 +5811,7 @@ proc linewidth {id} {
 
     set wid $lthickness
     if {[info exists thickerline] && $id eq $thickerline} {
-	set wid [expr {2 * $lthickness}]
+        set wid [expr {2 * $lthickness}]
     }
     return $wid
 }
@@ -5822,52 +5822,52 @@ proc rowranges {id} {
 
     set kids $children($curview,$id)
     if {$kids eq {}} {
-	return {}
+        return {}
     }
     set ret {}
     lappend kids $id
     foreach child $kids {
-	if {![commitinview $child $curview]} break
-	set row [rowofcommit $child]
-	if {![info exists prev]} {
-	    lappend ret [expr {$row + 1}]
-	} else {
-	    if {$row <= $prevrow} {
-		puts "oops children of [shortids $id] out of order [shortids $child] $row <= [shortids $prev] $prevrow"
-	    }
-	    # see if the line extends the whole way from prevrow to row
-	    if {$row > $prevrow + $uparrowlen + $downarrowlen &&
-		[lsearch -exact [lindex $rowidlist \
-			    [expr {int(($row + $prevrow) / 2)}]] $id] < 0} {
-		# it doesn't, see where it ends
-		set r [expr {$prevrow + $downarrowlen}]
-		if {[lsearch -exact [lindex $rowidlist $r] $id] < 0} {
-		    while {[incr r -1] > $prevrow &&
-			   [lsearch -exact [lindex $rowidlist $r] $id] < 0} {}
-		} else {
-		    while {[incr r] <= $row &&
-			   [lsearch -exact [lindex $rowidlist $r] $id] >= 0} {}
-		    incr r -1
-		}
-		lappend ret $r
-		# see where it starts up again
-		set r [expr {$row - $uparrowlen}]
-		if {[lsearch -exact [lindex $rowidlist $r] $id] < 0} {
-		    while {[incr r] < $row &&
-			   [lsearch -exact [lindex $rowidlist $r] $id] < 0} {}
-		} else {
-		    while {[incr r -1] >= $prevrow &&
-			   [lsearch -exact [lindex $rowidlist $r] $id] >= 0} {}
-		    incr r
-		}
-		lappend ret $r
-	    }
-	}
-	if {$child eq $id} {
-	    lappend ret $row
-	}
-	set prev $child
-	set prevrow $row
+        if {![commitinview $child $curview]} break
+        set row [rowofcommit $child]
+        if {![info exists prev]} {
+            lappend ret [expr {$row + 1}]
+        } else {
+            if {$row <= $prevrow} {
+                puts "oops children of [shortids $id] out of order [shortids $child] $row <= [shortids $prev] $prevrow"
+            }
+            # see if the line extends the whole way from prevrow to row
+            if {$row > $prevrow + $uparrowlen + $downarrowlen &&
+                [lsearch -exact [lindex $rowidlist \
+                            [expr {int(($row + $prevrow) / 2)}]] $id] < 0} {
+                # it doesn't, see where it ends
+                set r [expr {$prevrow + $downarrowlen}]
+                if {[lsearch -exact [lindex $rowidlist $r] $id] < 0} {
+                    while {[incr r -1] > $prevrow &&
+                           [lsearch -exact [lindex $rowidlist $r] $id] < 0} {}
+                } else {
+                    while {[incr r] <= $row &&
+                           [lsearch -exact [lindex $rowidlist $r] $id] >= 0} {}
+                    incr r -1
+                }
+                lappend ret $r
+                # see where it starts up again
+                set r [expr {$row - $uparrowlen}]
+                if {[lsearch -exact [lindex $rowidlist $r] $id] < 0} {
+                    while {[incr r] < $row &&
+                           [lsearch -exact [lindex $rowidlist $r] $id] < 0} {}
+                } else {
+                    while {[incr r -1] >= $prevrow &&
+                           [lsearch -exact [lindex $rowidlist $r] $id] >= 0} {}
+                    incr r
+                }
+                lappend ret $r
+            }
+        }
+        if {$child eq $id} {
+            lappend ret $row
+        }
+        set prev $child
+        set prevrow $row
     }
     return $ret
 }
@@ -5880,158 +5880,158 @@ proc drawlineseg {id row endrow arrowlow} {
     set le [expr {$row + 1}]
     set arrowhigh 1
     while {1} {
-	set c [lsearch -exact [lindex $rowidlist $le] $id]
-	if {$c < 0} {
-	    incr le -1
-	    break
-	}
-	lappend cols $c
-	set x [lindex $displayorder $le]
-	if {$x eq $id} {
-	    set arrowhigh 0
-	    break
-	}
-	if {[info exists iddrawn($x)] || $le == $endrow} {
-	    set c [lsearch -exact [lindex $rowidlist [expr {$le+1}]] $id]
-	    if {$c >= 0} {
-		lappend cols $c
-		set arrowhigh 0
-	    }
-	    break
-	}
-	incr le
+        set c [lsearch -exact [lindex $rowidlist $le] $id]
+        if {$c < 0} {
+            incr le -1
+            break
+        }
+        lappend cols $c
+        set x [lindex $displayorder $le]
+        if {$x eq $id} {
+            set arrowhigh 0
+            break
+        }
+        if {[info exists iddrawn($x)] || $le == $endrow} {
+            set c [lsearch -exact [lindex $rowidlist [expr {$le+1}]] $id]
+            if {$c >= 0} {
+                lappend cols $c
+                set arrowhigh 0
+            }
+            break
+        }
+        incr le
     }
     if {$le <= $row} {
-	return $row
+        return $row
     }
 
     set lines {}
     set i 0
     set joinhigh 0
     if {[info exists linesegs($id)]} {
-	set lines $linesegs($id)
-	foreach li $lines {
-	    set r0 [lindex $li 0]
-	    if {$r0 > $row} {
-		if {$r0 == $le && [lindex $li 1] - $row <= $maxlinelen} {
-		    set joinhigh 1
-		}
-		break
-	    }
-	    incr i
-	}
+        set lines $linesegs($id)
+        foreach li $lines {
+            set r0 [lindex $li 0]
+            if {$r0 > $row} {
+                if {$r0 == $le && [lindex $li 1] - $row <= $maxlinelen} {
+                    set joinhigh 1
+                }
+                break
+            }
+            incr i
+        }
     }
     set joinlow 0
     if {$i > 0} {
-	set li [lindex $lines [expr {$i-1}]]
-	set r1 [lindex $li 1]
-	if {$r1 == $row && $le - [lindex $li 0] <= $maxlinelen} {
-	    set joinlow 1
-	}
+        set li [lindex $lines [expr {$i-1}]]
+        set r1 [lindex $li 1]
+        if {$r1 == $row && $le - [lindex $li 0] <= $maxlinelen} {
+            set joinlow 1
+        }
     }
 
     set x [lindex $cols [expr {$le - $row}]]
     set xp [lindex $cols [expr {$le - 1 - $row}]]
     set dir [expr {$xp - $x}]
     if {$joinhigh} {
-	set ith [lindex $lines $i 2]
-	set coords [$canv coords $ith]
-	set ah [$canv itemcget $ith -arrow]
-	set arrowhigh [expr {$ah eq "first" || $ah eq "both"}]
-	set x2 [lindex $cols [expr {$le + 1 - $row}]]
-	if {$x2 ne {} && $x - $x2 == $dir} {
-	    set coords [lrange $coords 0 end-2]
-	}
+        set ith [lindex $lines $i 2]
+        set coords [$canv coords $ith]
+        set ah [$canv itemcget $ith -arrow]
+        set arrowhigh [expr {$ah eq "first" || $ah eq "both"}]
+        set x2 [lindex $cols [expr {$le + 1 - $row}]]
+        if {$x2 ne {} && $x - $x2 == $dir} {
+            set coords [lrange $coords 0 end-2]
+        }
     } else {
-	set coords [list [xc $le $x] [yc $le]]
+        set coords [list [xc $le $x] [yc $le]]
     }
     if {$joinlow} {
-	set itl [lindex $lines [expr {$i-1}] 2]
-	set al [$canv itemcget $itl -arrow]
-	set arrowlow [expr {$al eq "last" || $al eq "both"}]
+        set itl [lindex $lines [expr {$i-1}] 2]
+        set al [$canv itemcget $itl -arrow]
+        set arrowlow [expr {$al eq "last" || $al eq "both"}]
     } elseif {$arrowlow} {
-	if {[lsearch -exact [lindex $rowidlist [expr {$row-1}]] $id] >= 0 ||
-	    [lsearch -exact [lindex $parentlist [expr {$row-1}]] $id] >= 0} {
-	    set arrowlow 0
-	}
+        if {[lsearch -exact [lindex $rowidlist [expr {$row-1}]] $id] >= 0 ||
+            [lsearch -exact [lindex $parentlist [expr {$row-1}]] $id] >= 0} {
+            set arrowlow 0
+        }
     }
     set arrow [lindex {none first last both} [expr {$arrowhigh + 2*$arrowlow}]]
     for {set y $le} {[incr y -1] > $row} {} {
-	set x $xp
-	set xp [lindex $cols [expr {$y - 1 - $row}]]
-	set ndir [expr {$xp - $x}]
-	if {$dir != $ndir || $xp < 0} {
-	    lappend coords [xc $y $x] [yc $y]
-	}
-	set dir $ndir
+        set x $xp
+        set xp [lindex $cols [expr {$y - 1 - $row}]]
+        set ndir [expr {$xp - $x}]
+        if {$dir != $ndir || $xp < 0} {
+            lappend coords [xc $y $x] [yc $y]
+        }
+        set dir $ndir
     }
     if {!$joinlow} {
-	if {$xp < 0} {
-	    # join parent line to first child
-	    set ch [lindex $displayorder $row]
-	    set xc [lsearch -exact [lindex $rowidlist $row] $ch]
-	    if {$xc < 0} {
-		puts "oops: drawlineseg: child $ch not on row $row"
-	    } elseif {$xc != $x} {
-		if {($arrowhigh && $le == $row + 1) || $dir == 0} {
-		    set d [expr {int(0.5 * $linespc)}]
-		    set x1 [xc $row $x]
-		    if {$xc < $x} {
-			set x2 [expr {$x1 - $d}]
-		    } else {
-			set x2 [expr {$x1 + $d}]
-		    }
-		    set y2 [yc $row]
-		    set y1 [expr {$y2 + $d}]
-		    lappend coords $x1 $y1 $x2 $y2
-		} elseif {$xc < $x - 1} {
-		    lappend coords [xc $row [expr {$x-1}]] [yc $row]
-		} elseif {$xc > $x + 1} {
-		    lappend coords [xc $row [expr {$x+1}]] [yc $row]
-		}
-		set x $xc
-	    }
-	    lappend coords [xc $row $x] [yc $row]
-	} else {
-	    set xn [xc $row $xp]
-	    set yn [yc $row]
-	    lappend coords $xn $yn
-	}
-	if {!$joinhigh} {
-	    assigncolor $id
-	    set t [$canv create line $coords -width [linewidth $id] \
-		       -fill $colormap($id) -tags lines.$id -arrow $arrow]
-	    $canv lower $t
-	    bindline $t $id
-	    set lines [linsert $lines $i [list $row $le $t]]
-	} else {
-	    $canv coords $ith $coords
-	    if {$arrow ne $ah} {
-		$canv itemconf $ith -arrow $arrow
-	    }
-	    lset lines $i 0 $row
-	}
+        if {$xp < 0} {
+            # join parent line to first child
+            set ch [lindex $displayorder $row]
+            set xc [lsearch -exact [lindex $rowidlist $row] $ch]
+            if {$xc < 0} {
+                puts "oops: drawlineseg: child $ch not on row $row"
+            } elseif {$xc != $x} {
+                if {($arrowhigh && $le == $row + 1) || $dir == 0} {
+                    set d [expr {int(0.5 * $linespc)}]
+                    set x1 [xc $row $x]
+                    if {$xc < $x} {
+                        set x2 [expr {$x1 - $d}]
+                    } else {
+                        set x2 [expr {$x1 + $d}]
+                    }
+                    set y2 [yc $row]
+                    set y1 [expr {$y2 + $d}]
+                    lappend coords $x1 $y1 $x2 $y2
+                } elseif {$xc < $x - 1} {
+                    lappend coords [xc $row [expr {$x-1}]] [yc $row]
+                } elseif {$xc > $x + 1} {
+                    lappend coords [xc $row [expr {$x+1}]] [yc $row]
+                }
+                set x $xc
+            }
+            lappend coords [xc $row $x] [yc $row]
+        } else {
+            set xn [xc $row $xp]
+            set yn [yc $row]
+            lappend coords $xn $yn
+        }
+        if {!$joinhigh} {
+            assigncolor $id
+            set t [$canv create line $coords -width [linewidth $id] \
+                       -fill $colormap($id) -tags lines.$id -arrow $arrow]
+            $canv lower $t
+            bindline $t $id
+            set lines [linsert $lines $i [list $row $le $t]]
+        } else {
+            $canv coords $ith $coords
+            if {$arrow ne $ah} {
+                $canv itemconf $ith -arrow $arrow
+            }
+            lset lines $i 0 $row
+        }
     } else {
-	set xo [lsearch -exact [lindex $rowidlist [expr {$row - 1}]] $id]
-	set ndir [expr {$xo - $xp}]
-	set clow [$canv coords $itl]
-	if {$dir == $ndir} {
-	    set clow [lrange $clow 2 end]
-	}
-	set coords [concat $coords $clow]
-	if {!$joinhigh} {
-	    lset lines [expr {$i-1}] 1 $le
-	} else {
-	    # coalesce two pieces
-	    $canv delete $ith
-	    set b [lindex $lines [expr {$i-1}] 0]
-	    set e [lindex $lines $i 1]
-	    set lines [lreplace $lines [expr {$i-1}] $i [list $b $e $itl]]
-	}
-	$canv coords $itl $coords
-	if {$arrow ne $al} {
-	    $canv itemconf $itl -arrow $arrow
-	}
+        set xo [lsearch -exact [lindex $rowidlist [expr {$row - 1}]] $id]
+        set ndir [expr {$xo - $xp}]
+        set clow [$canv coords $itl]
+        if {$dir == $ndir} {
+            set clow [lrange $clow 2 end]
+        }
+        set coords [concat $coords $clow]
+        if {!$joinhigh} {
+            lset lines [expr {$i-1}] 1 $le
+        } else {
+            # coalesce two pieces
+            $canv delete $ith
+            set b [lindex $lines [expr {$i-1}] 0]
+            set e [lindex $lines $i 1]
+            set lines [lreplace $lines [expr {$i-1}] $i [list $b $e $itl]]
+        }
+        $canv coords $itl $coords
+        if {$arrow ne $al} {
+            $canv itemconf $itl -arrow $arrow
+        }
     }
 
     set linesegs($id) $lines
@@ -6056,54 +6056,54 @@ proc drawparentlinks {id row} {
     # rmx = right-most X coord used
     set rmx 0
     foreach p $olds {
-	set i [lsearch -exact $ids $p]
-	if {$i < 0} {
-	    puts "oops, parent $p of $id not in list"
-	    continue
-	}
-	set x2 [xc $row2 $i]
-	if {$x2 > $rmx} {
-	    set rmx $x2
-	}
-	set j [lsearch -exact $rowids $p]
-	if {$j < 0} {
-	    # drawlineseg will do this one for us
-	    continue
-	}
-	assigncolor $p
-	# should handle duplicated parents here...
-	set coords [list $x $y]
-	if {$i != $col} {
-	    # if attaching to a vertical segment, draw a smaller
-	    # slant for visual distinctness
-	    if {$i == $j} {
-		if {$i < $col} {
-		    lappend coords [expr {$x2 + $d}] $y $x2 $ymid
-		} else {
-		    lappend coords [expr {$x2 - $d}] $y $x2 $ymid
-		}
-	    } elseif {$i < $col && $i < $j} {
-		# segment slants towards us already
-		lappend coords [xc $row $j] $y
-	    } else {
-		if {$i < $col - 1} {
-		    lappend coords [expr {$x2 + $linespc}] $y
-		} elseif {$i > $col + 1} {
-		    lappend coords [expr {$x2 - $linespc}] $y
-		}
-		lappend coords $x2 $y2
-	    }
-	} else {
-	    lappend coords $x2 $y2
-	}
-	set t [$canv create line $coords -width [linewidth $p] \
-		   -fill $colormap($p) -tags lines.$p]
-	$canv lower $t
-	bindline $t $p
+        set i [lsearch -exact $ids $p]
+        if {$i < 0} {
+            puts "oops, parent $p of $id not in list"
+            continue
+        }
+        set x2 [xc $row2 $i]
+        if {$x2 > $rmx} {
+            set rmx $x2
+        }
+        set j [lsearch -exact $rowids $p]
+        if {$j < 0} {
+            # drawlineseg will do this one for us
+            continue
+        }
+        assigncolor $p
+        # should handle duplicated parents here...
+        set coords [list $x $y]
+        if {$i != $col} {
+            # if attaching to a vertical segment, draw a smaller
+            # slant for visual distinctness
+            if {$i == $j} {
+                if {$i < $col} {
+                    lappend coords [expr {$x2 + $d}] $y $x2 $ymid
+                } else {
+                    lappend coords [expr {$x2 - $d}] $y $x2 $ymid
+                }
+            } elseif {$i < $col && $i < $j} {
+                # segment slants towards us already
+                lappend coords [xc $row $j] $y
+            } else {
+                if {$i < $col - 1} {
+                    lappend coords [expr {$x2 + $linespc}] $y
+                } elseif {$i > $col + 1} {
+                    lappend coords [expr {$x2 - $linespc}] $y
+                }
+                lappend coords $x2 $y2
+            }
+        } else {
+            lappend coords $x2 $y2
+        }
+        set t [$canv create line $coords -width [linewidth $p] \
+                   -fill $colormap($p) -tags lines.$p]
+        $canv lower $t
+        bindline $t $p
     }
     if {$rmx > [lindex $idpos($id) 1]} {
-	lset idpos($id) 1 $rmx
-	redrawtags $id
+        lset idpos($id) 1 $rmx
+        redrawtags $id
     }
 }
 
@@ -6126,35 +6126,35 @@ proc drawcmittext {id row col} {
     # listed is 0 for boundary, 1 for normal, 2 for negative, 3 for left, 4 for right
     set listed $cmitlisted($curview,$id)
     if {$id eq $nullid} {
-	set ofill $workingfilescirclecolor
+        set ofill $workingfilescirclecolor
     } elseif {$id eq $nullid2} {
-	set ofill $indexcirclecolor
+        set ofill $indexcirclecolor
     } elseif {$id eq $mainheadid} {
-	set ofill $mainheadcirclecolor
+        set ofill $mainheadcirclecolor
     } else {
-	set ofill [lindex $circlecolors $listed]
+        set ofill [lindex $circlecolors $listed]
     }
     set x [xc $row $col]
     set y [yc $row]
     set orad [expr {$linespc / 3}]
     if {$listed <= 2} {
-	set t [$canv create oval [expr {$x - $orad}] [expr {$y - $orad}] \
-		   [expr {$x + $orad - 1}] [expr {$y + $orad - 1}] \
-		   -fill $ofill -outline $circleoutlinecolor -width 1 -tags circle]
+        set t [$canv create oval [expr {$x - $orad}] [expr {$y - $orad}] \
+                   [expr {$x + $orad - 1}] [expr {$y + $orad - 1}] \
+                   -fill $ofill -outline $circleoutlinecolor -width 1 -tags circle]
     } elseif {$listed == 3} {
-	# triangle pointing left for left-side commits
-	set t [$canv create polygon \
-		   [expr {$x - $orad}] $y \
-		   [expr {$x + $orad - 1}] [expr {$y - $orad}] \
-		   [expr {$x + $orad - 1}] [expr {$y + $orad - 1}] \
-		   -fill $ofill -outline $circleoutlinecolor -width 1 -tags circle]
+        # triangle pointing left for left-side commits
+        set t [$canv create polygon \
+                   [expr {$x - $orad}] $y \
+                   [expr {$x + $orad - 1}] [expr {$y - $orad}] \
+                   [expr {$x + $orad - 1}] [expr {$y + $orad - 1}] \
+                   -fill $ofill -outline $circleoutlinecolor -width 1 -tags circle]
     } else {
-	# triangle pointing right for right-side commits
-	set t [$canv create polygon \
-		   [expr {$x + $orad - 1}] $y \
-		   [expr {$x - $orad}] [expr {$y - $orad}] \
-		   [expr {$x - $orad}] [expr {$y + $orad - 1}] \
-		   -fill $ofill -outline $circleoutlinecolor -width 1 -tags circle]
+        # triangle pointing right for right-side commits
+        set t [$canv create polygon \
+                   [expr {$x + $orad - 1}] $y \
+                   [expr {$x - $orad}] [expr {$y - $orad}] \
+                   [expr {$x - $orad}] [expr {$y + $orad - 1}] \
+                   -fill $ofill -outline $circleoutlinecolor -width 1 -tags circle]
     }
     set circleitem($row) $t
     $canv raise $t
@@ -6162,23 +6162,23 @@ proc drawcmittext {id row col} {
     set rmx [llength [lindex $rowidlist $row]]
     set olds [lindex $parentlist $row]
     if {$olds ne {}} {
-	set nextids [lindex $rowidlist [expr {$row + 1}]]
-	foreach p $olds {
-	    set i [lsearch -exact $nextids $p]
-	    if {$i > $rmx} {
-		set rmx $i
-	    }
-	}
+        set nextids [lindex $rowidlist [expr {$row + 1}]]
+        foreach p $olds {
+            set i [lsearch -exact $nextids $p]
+            if {$i > $rmx} {
+                set rmx $i
+            }
+        }
     }
     set xt [xc $row $rmx]
     set rowtextx($row) $xt
     set idpos($id) [list $x $xt $y]
     if {[info exists idtags($id)] || [info exists idheads($id)]
-	|| [info exists idotherrefs($id)]} {
-	set xt [drawtags $id $x $xt $y]
+        || [info exists idotherrefs($id)]} {
+        set xt [drawtags $id $x $xt $y]
     }
     if {[lindex $commitinfo($id) 6] > 0} {
-	set xt [drawnotesign $xt $y]
+        set xt [drawnotesign $xt $y]
     }
     set headline [lindex $commitinfo($id) 0]
     set name [lindex $commitinfo($id) 1]
@@ -6188,30 +6188,30 @@ proc drawcmittext {id row col} {
     set nfont mainfont
     set isbold [ishighlighted $id]
     if {$isbold > 0} {
-	lappend boldids $id
-	set font mainfontbold
-	if {$isbold > 1} {
-	    lappend boldnameids $id
-	    set nfont mainfontbold
-	}
+        lappend boldids $id
+        set font mainfontbold
+        if {$isbold > 1} {
+            lappend boldnameids $id
+            set nfont mainfontbold
+        }
     }
     set linehtag($id) [$canv create text $xt $y -anchor w -fill $fgcolor \
-			   -text $headline -font $font -tags text]
+                           -text $headline -font $font -tags text]
     $canv bind $linehtag($id) $ctxbut "rowmenu %X %Y $id"
     set linentag($id) [$canv2 create text 3 $y -anchor w -fill $fgcolor \
-			   -text $name -font $nfont -tags text]
+                           -text $name -font $nfont -tags text]
     set linedtag($id) [$canv3 create text 3 $y -anchor w -fill $fgcolor \
-			   -text $date -font mainfont -tags text]
+                           -text $date -font mainfont -tags text]
     if {$selectedline == $row} {
-	make_secsel $id
+        make_secsel $id
     }
     if {[info exists markedid] && $markedid eq $id} {
-	make_idmark $id
+        make_idmark $id
     }
     set xr [expr {$xt + [font measure $font $headline]}]
     if {$xr > $canvxmax} {
-	set canvxmax $xr
-	setcanvscroll
+        set canvxmax $xr
+        setcanvscroll
     }
 }
 
@@ -6227,33 +6227,33 @@ proc drawcmitrow {row} {
 
     set id [lindex $displayorder $row]
     if {[info exists hlview] && ![info exists vhighlights($id)]} {
-	askvhighlight $row $id
+        askvhighlight $row $id
     }
     if {[info exists filehighlight] && ![info exists fhighlights($id)]} {
-	askfilehighlight $row $id
+        askfilehighlight $row $id
     }
     if {$findpattern ne {} && ![info exists nhighlights($id)]} {
-	askfindhighlight $row $id
+        askfindhighlight $row $id
     }
     if {$highlight_related ne [mc "None"] && ![info exists rhighlights($id)]} {
-	askrelhighlight $row $id
+        askrelhighlight $row $id
     }
     if {![info exists iddrawn($id)]} {
-	set col [lsearch -exact [lindex $rowidlist $row] $id]
-	if {$col < 0} {
-	    puts "oops, row $row id $id not in list"
-	    return
-	}
-	if {![info exists commitinfo($id)]} {
-	    getcommit $id
-	}
-	assigncolor $id
-	drawcmittext $id $row $col
-	set iddrawn($id) 1
-	incr nrows_drawn
+        set col [lsearch -exact [lindex $rowidlist $row] $id]
+        if {$col < 0} {
+            puts "oops, row $row id $id not in list"
+            return
+        }
+        if {![info exists commitinfo($id)]} {
+            getcommit $id
+        }
+        assigncolor $id
+        drawcmittext $id $row $col
+        set iddrawn($id) 1
+        incr nrows_drawn
     }
     if {$markingmatches} {
-	markrowmatches $row $id
+        markrowmatches $row $id
     }
 }
 
@@ -6262,78 +6262,78 @@ proc drawcommits {row {endrow {}}} {
     global parentlist rowidlist rowfinal uparrowlen downarrowlen nrows_drawn
 
     if {$row < 0} {
-	set row 0
+        set row 0
     }
     if {$endrow eq {}} {
-	set endrow $row
+        set endrow $row
     }
     if {$endrow >= $numcommits} {
-	set endrow [expr {$numcommits - 1}]
+        set endrow [expr {$numcommits - 1}]
     }
 
     set rl1 [expr {$row - $downarrowlen - 3}]
     if {$rl1 < 0} {
-	set rl1 0
+        set rl1 0
     }
     set ro1 [expr {$row - 3}]
     if {$ro1 < 0} {
-	set ro1 0
+        set ro1 0
     }
     set r2 [expr {$endrow + $uparrowlen + 3}]
     if {$r2 > $numcommits} {
-	set r2 $numcommits
+        set r2 $numcommits
     }
     for {set r $rl1} {$r < $r2} {incr r} {
-	if {[lindex $rowidlist $r] ne {} && [lindex $rowfinal $r]} {
-	    if {$rl1 < $r} {
-		layoutrows $rl1 $r
-	    }
-	    set rl1 [expr {$r + 1}]
-	}
+        if {[lindex $rowidlist $r] ne {} && [lindex $rowfinal $r]} {
+            if {$rl1 < $r} {
+                layoutrows $rl1 $r
+            }
+            set rl1 [expr {$r + 1}]
+        }
     }
     if {$rl1 < $r} {
-	layoutrows $rl1 $r
+        layoutrows $rl1 $r
     }
     optimize_rows $ro1 0 $r2
     if {$need_redisplay || $nrows_drawn > 2000} {
-	clear_display
+        clear_display
     }
 
     # make the lines join to already-drawn rows either side
     set r [expr {$row - 1}]
     if {$r < 0 || ![info exists iddrawn([lindex $displayorder $r])]} {
-	set r $row
+        set r $row
     }
     set er [expr {$endrow + 1}]
     if {$er >= $numcommits ||
-	![info exists iddrawn([lindex $displayorder $er])]} {
-	set er $endrow
+        ![info exists iddrawn([lindex $displayorder $er])]} {
+        set er $endrow
     }
     for {} {$r <= $er} {incr r} {
-	set id [lindex $displayorder $r]
-	set wasdrawn [info exists iddrawn($id)]
-	drawcmitrow $r
-	if {$r == $er} break
-	set nextid [lindex $displayorder [expr {$r + 1}]]
-	if {$wasdrawn && [info exists iddrawn($nextid)]} continue
-	drawparentlinks $id $r
+        set id [lindex $displayorder $r]
+        set wasdrawn [info exists iddrawn($id)]
+        drawcmitrow $r
+        if {$r == $er} break
+        set nextid [lindex $displayorder [expr {$r + 1}]]
+        if {$wasdrawn && [info exists iddrawn($nextid)]} continue
+        drawparentlinks $id $r
 
-	set rowids [lindex $rowidlist $r]
-	foreach lid $rowids {
-	    if {$lid eq {}} continue
-	    if {[info exists lineend($lid)] && $lineend($lid) > $r} continue
-	    if {$lid eq $id} {
-		# see if this is the first child of any of its parents
-		foreach p [lindex $parentlist $r] {
-		    if {[lsearch -exact $rowids $p] < 0} {
-			# make this line extend up to the child
-			set lineend($p) [drawlineseg $p $r $er 0]
-		    }
-		}
-	    } else {
-		set lineend($lid) [drawlineseg $lid $r $er 1]
-	    }
-	}
+        set rowids [lindex $rowidlist $r]
+        foreach lid $rowids {
+            if {$lid eq {}} continue
+            if {[info exists lineend($lid)] && $lineend($lid) > $r} continue
+            if {$lid eq $id} {
+                # see if this is the first child of any of its parents
+                foreach p [lindex $parentlist $r] {
+                    if {[lsearch -exact $rowids $p] < 0} {
+                        # make this line extend up to the child
+                        set lineend($p) [drawlineseg $p $r $er 0]
+                    }
+                }
+            } else {
+                set lineend($lid) [drawlineseg $lid $r $er 1]
+            }
+        }
     }
 }
 
@@ -6343,15 +6343,15 @@ proc undolayout {row} {
 
     set r [expr {$row - ($uparrowlen + $mingaplen + $downarrowlen)}]
     if {$r < 0} {
-	set r 0
+        set r 0
     }
     if {[llength $rowidlist] > $r} {
-	incr r -1
-	set rowidlist [lrange $rowidlist 0 $r]
-	set rowfinal [lrange $rowfinal 0 $r]
-	set rowisopt [lrange $rowisopt 0 $r]
-	set need_redisplay 1
-	run drawvisible
+        incr r -1
+        set rowidlist [lrange $rowidlist 0 $r]
+        set rowfinal [lrange $rowfinal 0 $r]
+        set rowisopt [lrange $rowisopt 0 $r]
+        set need_redisplay 1
+        run drawvisible
     }
 }
 
@@ -6368,44 +6368,44 @@ proc drawvisible {} {
     set y1 [expr {int($f1 * $ymax)}]
 
     if {[info exists targetid]} {
-	if {[commitinview $targetid $curview]} {
-	    set r [rowofcommit $targetid]
-	    if {$r != $targetrow} {
-		# Fix up the scrollregion and change the scrolling position
-		# now that our target row has moved.
-		set diff [expr {($r - $targetrow) * $linespc}]
-		set targetrow $r
-		setcanvscroll
-		set ymax [lindex [$canv cget -scrollregion] 3]
-		incr y0 $diff
-		incr y1 $diff
-		set f0 [expr {$y0 / $ymax}]
-		set f1 [expr {$y1 / $ymax}]
-		allcanvs yview moveto $f0
-		$cscroll set $f0 $f1
-		set need_redisplay 1
-	    }
-	} else {
-	    unset targetid
-	}
+        if {[commitinview $targetid $curview]} {
+            set r [rowofcommit $targetid]
+            if {$r != $targetrow} {
+                # Fix up the scrollregion and change the scrolling position
+                # now that our target row has moved.
+                set diff [expr {($r - $targetrow) * $linespc}]
+                set targetrow $r
+                setcanvscroll
+                set ymax [lindex [$canv cget -scrollregion] 3]
+                incr y0 $diff
+                incr y1 $diff
+                set f0 [expr {$y0 / $ymax}]
+                set f1 [expr {$y1 / $ymax}]
+                allcanvs yview moveto $f0
+                $cscroll set $f0 $f1
+                set need_redisplay 1
+            }
+        } else {
+            unset targetid
+        }
     }
 
     set row [expr {int(($y0 - 3) / $linespc) - 1}]
     set endrow [expr {int(($y1 - 3) / $linespc) + 1}]
     if {$endrow >= $vrowmod($curview)} {
-	update_arcrows $curview
+        update_arcrows $curview
     }
     if {$selectedline ne {} &&
-	$row <= $selectedline && $selectedline <= $endrow} {
-	set targetrow $selectedline
+        $row <= $selectedline && $selectedline <= $endrow} {
+        set targetrow $selectedline
     } elseif {[info exists targetid]} {
-	set targetrow [expr {int(($row + $endrow) / 2)}]
+        set targetrow [expr {int(($row + $endrow) / 2)}]
     }
     if {[info exists targetrow]} {
-	if {$targetrow >= $numcommits} {
-	    set targetrow [expr {$numcommits - 1}]
-	}
-	set targetid [commitonrow $targetrow]
+        if {$targetrow >= $numcommits} {
+            set targetrow [expr {$numcommits - 1}]
+        }
+        set targetid [commitonrow $targetrow]
     }
     drawcommits $row $endrow
 }
@@ -6437,31 +6437,31 @@ proc findcrossings {id} {
     set cross {}
     set ccross {}
     foreach {s e} [rowranges $id] {
-	if {$e >= $numcommits} {
-	    set e [expr {$numcommits - 1}]
-	}
-	if {$e <= $s} continue
-	for {set row $e} {[incr row -1] >= $s} {} {
-	    set x [lsearch -exact [lindex $rowidlist $row] $id]
-	    if {$x < 0} break
-	    set olds [lindex $parentlist $row]
-	    set kid [lindex $displayorder $row]
-	    set kidx [lsearch -exact [lindex $rowidlist $row] $kid]
-	    if {$kidx < 0} continue
-	    set nextrow [lindex $rowidlist [expr {$row + 1}]]
-	    foreach p $olds {
-		set px [lsearch -exact $nextrow $p]
-		if {$px < 0} continue
-		if {($kidx < $x && $x < $px) || ($px < $x && $x < $kidx)} {
-		    if {[lsearch -exact $ccross $p] >= 0} continue
-		    if {$x == $px + ($kidx < $px? -1: 1)} {
-			lappend ccross $p
-		    } elseif {[lsearch -exact $cross $p] < 0} {
-			lappend cross $p
-		    }
-		}
-	    }
-	}
+        if {$e >= $numcommits} {
+            set e [expr {$numcommits - 1}]
+        }
+        if {$e <= $s} continue
+        for {set row $e} {[incr row -1] >= $s} {} {
+            set x [lsearch -exact [lindex $rowidlist $row] $id]
+            if {$x < 0} break
+            set olds [lindex $parentlist $row]
+            set kid [lindex $displayorder $row]
+            set kidx [lsearch -exact [lindex $rowidlist $row] $kid]
+            if {$kidx < 0} continue
+            set nextrow [lindex $rowidlist [expr {$row + 1}]]
+            foreach p $olds {
+                set px [lsearch -exact $nextrow $p]
+                if {$px < 0} continue
+                if {($kidx < $x && $x < $px) || ($px < $x && $x < $kidx)} {
+                    if {[lsearch -exact $ccross $p] >= 0} continue
+                    if {$x == $px + ($kidx < $px? -1: 1)} {
+                        lappend ccross $p
+                    } elseif {[lsearch -exact $cross $p] < 0} {
+                        lappend cross $p
+                    }
+                }
+            }
+        }
     }
     return [concat $ccross {{}} $cross]
 }
@@ -6473,58 +6473,58 @@ proc assigncolor {id} {
     if {[info exists colormap($id)]} return
     set ncolors [llength $colors]
     if {[info exists children($curview,$id)]} {
-	set kids $children($curview,$id)
+        set kids $children($curview,$id)
     } else {
-	set kids {}
+        set kids {}
     }
     if {[llength $kids] == 1} {
-	set child [lindex $kids 0]
-	if {[info exists colormap($child)]
-	    && [llength $parents($curview,$child)] == 1} {
-	    set colormap($id) $colormap($child)
-	    return
-	}
+        set child [lindex $kids 0]
+        if {[info exists colormap($child)]
+            && [llength $parents($curview,$child)] == 1} {
+            set colormap($id) $colormap($child)
+            return
+        }
     }
     set badcolors {}
     set origbad {}
     foreach x [findcrossings $id] {
-	if {$x eq {}} {
-	    # delimiter between corner crossings and other crossings
-	    if {[llength $badcolors] >= $ncolors - 1} break
-	    set origbad $badcolors
-	}
-	if {[info exists colormap($x)]
-	    && [lsearch -exact $badcolors $colormap($x)] < 0} {
-	    lappend badcolors $colormap($x)
-	}
+        if {$x eq {}} {
+            # delimiter between corner crossings and other crossings
+            if {[llength $badcolors] >= $ncolors - 1} break
+            set origbad $badcolors
+        }
+        if {[info exists colormap($x)]
+            && [lsearch -exact $badcolors $colormap($x)] < 0} {
+            lappend badcolors $colormap($x)
+        }
     }
     if {[llength $badcolors] >= $ncolors} {
-	set badcolors $origbad
+        set badcolors $origbad
     }
     set origbad $badcolors
     if {[llength $badcolors] < $ncolors - 1} {
-	foreach child $kids {
-	    if {[info exists colormap($child)]
-		&& [lsearch -exact $badcolors $colormap($child)] < 0} {
-		lappend badcolors $colormap($child)
-	    }
-	    foreach p $parents($curview,$child) {
-		if {[info exists colormap($p)]
-		    && [lsearch -exact $badcolors $colormap($p)] < 0} {
-		    lappend badcolors $colormap($p)
-		}
-	    }
-	}
-	if {[llength $badcolors] >= $ncolors} {
-	    set badcolors $origbad
-	}
+        foreach child $kids {
+            if {[info exists colormap($child)]
+                && [lsearch -exact $badcolors $colormap($child)] < 0} {
+                lappend badcolors $colormap($child)
+            }
+            foreach p $parents($curview,$child) {
+                if {[info exists colormap($p)]
+                    && [lsearch -exact $badcolors $colormap($p)] < 0} {
+                    lappend badcolors $colormap($p)
+                }
+            }
+        }
+        if {[llength $badcolors] >= $ncolors} {
+            set badcolors $origbad
+        }
     }
     for {set i 0} {$i <= $ncolors} {incr i} {
-	set c [lindex $colors $nextcolor]
-	if {[incr nextcolor] >= $ncolors} {
-	    set nextcolor 0
-	}
-	if {[lsearch -exact $badcolors $c]} break
+        set c [lindex $colors $nextcolor]
+        if {[incr nextcolor] >= $ncolors} {
+            set nextcolor 0
+        }
+        if {[lsearch -exact $badcolors $c]} break
     }
     set colormap($id) $c
 }
@@ -6542,9 +6542,9 @@ proc graph_pane_width {} {
     global use_ttk
 
     if {$use_ttk} {
-	set g [.tf.histframe.pwclist sashpos 0]
+        set g [.tf.histframe.pwclist sashpos 0]
     } else {
-	set g [.tf.histframe.pwclist sash coord 0]
+        set g [.tf.histframe.pwclist sash coord 0]
     }
     return [lindex $g 0]
 }
@@ -6552,7 +6552,7 @@ proc graph_pane_width {} {
 proc totalwidth {l font extra} {
     set tot 0
     foreach str $l {
-	set tot [expr {$tot + [font measure $font $str] + $extra}]
+        set tot [expr {$tot + [font measure $font $str] + $extra}]
     }
     return $tot
 }
@@ -6576,29 +6576,29 @@ proc drawtags {id x xt y1} {
     set extra [expr {$delta + $lthickness + $linespc}]
 
     if {[info exists idtags($id)]} {
-	set marks $idtags($id)
-	set ntags [llength $marks]
-	if {$ntags > $maxtags ||
-	    [totalwidth $marks mainfont $extra] > $maxwidth} {
-	    # show just a single "n tags..." tag
-	    set singletag 1
-	    if {$ntags == 1} {
-		set marks [list "tag..."]
-	    } else {
-		set marks [list [format "%d tags..." $ntags]]
-	    }
-	    set ntags 1
-	}
+        set marks $idtags($id)
+        set ntags [llength $marks]
+        if {$ntags > $maxtags ||
+            [totalwidth $marks mainfont $extra] > $maxwidth} {
+            # show just a single "n tags..." tag
+            set singletag 1
+            if {$ntags == 1} {
+                set marks [list "tag..."]
+            } else {
+                set marks [list [format "%d tags..." $ntags]]
+            }
+            set ntags 1
+        }
     }
     if {[info exists idheads($id)]} {
-	set marks [concat $marks $idheads($id)]
-	set nheads [llength $idheads($id)]
+        set marks [concat $marks $idheads($id)]
+        set nheads [llength $idheads($id)]
     }
     if {[info exists idotherrefs($id)]} {
-	set marks [concat $marks $idotherrefs($id)]
+        set marks [concat $marks $idotherrefs($id)]
     }
     if {$marks eq {}} {
-	return $xt
+        return $xt
     }
 
     set yt [expr {$y1 - 0.5 * $linespc}]
@@ -6607,66 +6607,66 @@ proc drawtags {id x xt y1} {
     set wvals {}
     set i -1
     foreach tag $marks {
-	incr i
-	if {$i >= $ntags && $i < $ntags + $nheads && $tag eq $mainhead} {
-	    set wid [font measure mainfontbold $tag]
-	} else {
-	    set wid [font measure mainfont $tag]
-	}
-	lappend xvals $xt
-	lappend wvals $wid
-	set xt [expr {$xt + $wid + $extra}]
+        incr i
+        if {$i >= $ntags && $i < $ntags + $nheads && $tag eq $mainhead} {
+            set wid [font measure mainfontbold $tag]
+        } else {
+            set wid [font measure mainfont $tag]
+        }
+        lappend xvals $xt
+        lappend wvals $wid
+        set xt [expr {$xt + $wid + $extra}]
     }
     set t [$canv create line $x $y1 [lindex $xvals end] $y1 \
-	       -width $lthickness -fill $reflinecolor -tags tag.$id]
+               -width $lthickness -fill $reflinecolor -tags tag.$id]
     $canv lower $t
     foreach tag $marks x $xvals wid $wvals {
-	set tag_quoted [string map {% %%} $tag]
-	set xl [expr {$x + $delta}]
-	set xr [expr {$x + $delta + $wid + $lthickness}]
-	set font mainfont
-	if {[incr ntags -1] >= 0} {
-	    # draw a tag
-	    set t [$canv create polygon $x [expr {$yt + $delta}] $xl $yt \
-		       $xr $yt $xr $yb $xl $yb $x [expr {$yb - $delta}] \
-		       -width 1 -outline $tagoutlinecolor -fill $tagbgcolor \
-		       -tags tag.$id]
-	    if {$singletag} {
-		set tagclick [list showtags $id 1]
-	    } else {
-		set tagclick [list showtag $tag_quoted 1]
-	    }
-	    $canv bind $t <1> $tagclick
-	    set rowtextx([rowofcommit $id]) [expr {$xr + $linespc}]
-	} else {
-	    # draw a head or other ref
-	    if {[incr nheads -1] >= 0} {
-		set col $headbgcolor
-		if {$tag eq $mainhead} {
-		    set font mainfontbold
-		}
-	    } else {
-		set col "#ddddff"
-	    }
-	    set xl [expr {$xl - $delta/2}]
-	    $canv create polygon $x $yt $xr $yt $xr $yb $x $yb \
-		-width 1 -outline black -fill $col -tags tag.$id
-	    if {[regexp {^(remotes/.*/|remotes/)} $tag match remoteprefix]} {
-	        set rwid [font measure mainfont $remoteprefix]
-		set xi [expr {$x + 1}]
-		set yti [expr {$yt + 1}]
-		set xri [expr {$x + $rwid}]
-		$canv create polygon $xi $yti $xri $yti $xri $yb $xi $yb \
-			-width 0 -fill $remotebgcolor -tags tag.$id
-	    }
-	}
-	set t [$canv create text $xl $y1 -anchor w -text $tag -fill $headfgcolor \
-		   -font $font -tags [list tag.$id text]]
-	if {$ntags >= 0} {
-	    $canv bind $t <1> $tagclick
-	} elseif {$nheads >= 0} {
-	    $canv bind $t $ctxbut [list headmenu %X %Y $id $tag_quoted]
-	}
+        set tag_quoted [string map {% %%} $tag]
+        set xl [expr {$x + $delta}]
+        set xr [expr {$x + $delta + $wid + $lthickness}]
+        set font mainfont
+        if {[incr ntags -1] >= 0} {
+            # draw a tag
+            set t [$canv create polygon $x [expr {$yt + $delta}] $xl $yt \
+                       $xr $yt $xr $yb $xl $yb $x [expr {$yb - $delta}] \
+                       -width 1 -outline $tagoutlinecolor -fill $tagbgcolor \
+                       -tags tag.$id]
+            if {$singletag} {
+                set tagclick [list showtags $id 1]
+            } else {
+                set tagclick [list showtag $tag_quoted 1]
+            }
+            $canv bind $t <1> $tagclick
+            set rowtextx([rowofcommit $id]) [expr {$xr + $linespc}]
+        } else {
+            # draw a head or other ref
+            if {[incr nheads -1] >= 0} {
+                set col $headbgcolor
+                if {$tag eq $mainhead} {
+                    set font mainfontbold
+                }
+            } else {
+                set col "#ddddff"
+            }
+            set xl [expr {$xl - $delta/2}]
+            $canv create polygon $x $yt $xr $yt $xr $yb $x $yb \
+                -width 1 -outline black -fill $col -tags tag.$id
+            if {[regexp {^(remotes/.*/|remotes/)} $tag match remoteprefix]} {
+                set rwid [font measure mainfont $remoteprefix]
+                set xi [expr {$x + 1}]
+                set yti [expr {$yt + 1}]
+                set xri [expr {$x + $rwid}]
+                $canv create polygon $xi $yti $xri $yti $xri $yb $xi $yb \
+                        -width 0 -fill $remotebgcolor -tags tag.$id
+            }
+        }
+        set t [$canv create text $xl $y1 -anchor w -text $tag -fill $headfgcolor \
+                   -font $font -tags [list tag.$id text]]
+        if {$ntags >= 0} {
+            $canv bind $t <1> $tagclick
+        } elseif {$nheads >= 0} {
+            $canv bind $t $ctxbut [list headmenu %X %Y $id $tag_quoted]
+        }
     }
     return $xt
 }
@@ -6676,8 +6676,8 @@ proc drawnotesign {xt y} {
 
     set orad [expr {$linespc / 3}]
     set t [$canv create rectangle [expr {$xt - $orad}] [expr {$y - $orad}] \
-	       [expr {$xt + $orad - 1}] [expr {$y + $orad - 1}] \
-	       -fill yellow -outline $fgcolor -width 1 -tags circle]
+               [expr {$xt + $orad - 1}] [expr {$y + $orad - 1}] \
+               -fill yellow -outline $fgcolor -width 1 -tags circle]
     set xt [expr {$xt + $orad * 3}]
     return $xt
 }
@@ -6687,9 +6687,9 @@ proc xcoord {i level ln} {
 
     set x [expr {$canvx0 + $i * $xspc1($ln)}]
     if {$i > 0 && $i == $level} {
-	set x [expr {$x + 0.5 * ($xspc2 - $xspc1($ln))}]
+        set x [expr {$x + 0.5 * ($xspc2 - $xspc1($ln))}]
     } elseif {$i > $level} {
-	set x [expr {$x + $xspc2 - $xspc1($ln)}]
+        set x [expr {$x + $xspc2 - $xspc1($ln)}]
     }
     return $x
 }
@@ -6700,7 +6700,7 @@ proc show_status {msg} {
     clear_display
     set_window_title
     $canv create text 3 3 -anchor nw -text $msg -font mainfont \
-	-tags text -fill $fgcolor
+        -tags text -fill $fgcolor
 }
 
 # Don't change the text pane cursor if it is currently the hand cursor,
@@ -6709,7 +6709,7 @@ proc settextcursor {c} {
     global ctext curtextcursor
 
     if {[$ctext cget -cursor] == $curtextcursor} {
-	$ctext config -cursor $c
+        $ctext config -cursor $c
     }
     set curtextcursor $c
 }
@@ -6718,13 +6718,13 @@ proc nowbusy {what {name {}}} {
     global isbusy busyname statusw
 
     if {[array names isbusy] eq {}} {
-	. config -cursor watch
-	settextcursor watch
+        . config -cursor watch
+        settextcursor watch
     }
     set isbusy($what) 1
     set busyname($what) $name
     if {$name ne {}} {
-	$statusw conf -text $name
+        $statusw conf -text $name
     }
 }
 
@@ -6732,35 +6732,35 @@ proc notbusy {what} {
     global isbusy maincursor textcursor busyname statusw
 
     catch {
-	unset isbusy($what)
-	if {$busyname($what) ne {} &&
-	    [$statusw cget -text] eq $busyname($what)} {
-	    $statusw conf -text {}
-	}
+        unset isbusy($what)
+        if {$busyname($what) ne {} &&
+            [$statusw cget -text] eq $busyname($what)} {
+            $statusw conf -text {}
+        }
     }
     if {[array names isbusy] eq {}} {
-	. config -cursor $maincursor
-	settextcursor $textcursor
+        . config -cursor $maincursor
+        settextcursor $textcursor
     }
 }
 
 proc findmatches {f} {
     global findtype findstring
     if {$findtype == [mc "Regexp"]} {
-	set matches [regexp -indices -all -inline $findstring $f]
+        set matches [regexp -indices -all -inline $findstring $f]
     } else {
-	set fs $findstring
-	if {$findtype == [mc "IgnCase"]} {
-	    set f [string tolower $f]
-	    set fs [string tolower $fs]
-	}
-	set matches {}
-	set i 0
-	set l [string length $fs]
-	while {[set j [string first $fs $f $i]] >= 0} {
-	    lappend matches [list $j [expr {$j+$l-1}]]
-	    set i [expr {$j + $l}]
-	}
+        set fs $findstring
+        if {$findtype == [mc "IgnCase"]} {
+            set f [string tolower $f]
+            set fs [string tolower $fs]
+        }
+        set matches {}
+        set i 0
+        set l [string length $fs]
+        while {[set j [string first $fs $f $i]] >= 0} {
+            lappend matches [list $j [expr {$j+$l-1}]]
+            set i [expr {$j + $l}]
+        }
     }
     return $matches
 }
@@ -6770,21 +6770,21 @@ proc dofind {{dirn 1} {wrap 1}} {
     global gdttype filehighlight fh_serial find_dirn findallowwrap
 
     if {[info exists find_dirn]} {
-	if {$find_dirn == $dirn} return
-	stopfinding
+        if {$find_dirn == $dirn} return
+        stopfinding
     }
     focus .
     if {$findstring eq {} || $numcommits == 0} return
     if {$selectedline eq {}} {
-	set findstartline [lindex [visiblerows] [expr {$dirn < 0}]]
+        set findstartline [lindex [visiblerows] [expr {$dirn < 0}]]
     } else {
-	set findstartline $selectedline
+        set findstartline $selectedline
     }
     set findcurline $findstartline
     nowbusy finding [mc "Searching"]
     if {$gdttype ne [mc "containing:"] && ![info exists filehighlight]} {
-	after cancel do_file_hl $fh_serial
-	do_file_hl $fh_serial
+        after cancel do_file_hl $fh_serial
+        do_file_hl $fh_serial
     }
     set find_dirn $dirn
     set findallowwrap $wrap
@@ -6795,11 +6795,11 @@ proc stopfinding {} {
     global find_dirn findcurline fprogcoord
 
     if {[info exists find_dirn]} {
-	unset find_dirn
-	unset findcurline
-	notbusy finding
-	set fprogcoord 0
-	adjustprogress
+        unset find_dirn
+        unset findcurline
+        notbusy finding
+        set fprogcoord 0
+        adjustprogress
     }
     stopblaming
 }
@@ -6811,41 +6811,41 @@ proc findmore {} {
     global curview varcorder vrownum varccommits vrowmod
 
     if {![info exists find_dirn]} {
-	return 0
+        return 0
     }
     set fldtypes [list [mc "Headline"] [mc "Author"] "" [mc "Committer"] "" [mc "Comments"]]
     set l $findcurline
     set moretodo 0
     if {$find_dirn > 0} {
-	incr l
-	if {$l >= $numcommits} {
-	    set l 0
-	}
-	if {$l <= $findstartline} {
-	    set lim [expr {$findstartline + 1}]
-	} else {
-	    set lim $numcommits
-	    set moretodo $findallowwrap
-	}
+        incr l
+        if {$l >= $numcommits} {
+            set l 0
+        }
+        if {$l <= $findstartline} {
+            set lim [expr {$findstartline + 1}]
+        } else {
+            set lim $numcommits
+            set moretodo $findallowwrap
+        }
     } else {
-	if {$l == 0} {
-	    set l $numcommits
-	}
-	incr l -1
-	if {$l >= $findstartline} {
-	    set lim [expr {$findstartline - 1}]
-	} else {
-	    set lim -1
-	    set moretodo $findallowwrap
-	}
+        if {$l == 0} {
+            set l $numcommits
+        }
+        incr l -1
+        if {$l >= $findstartline} {
+            set lim [expr {$findstartline - 1}]
+        } else {
+            set lim -1
+            set moretodo $findallowwrap
+        }
     }
     set n [expr {($lim - $l) * $find_dirn}]
     if {$n > 500} {
-	set n 500
-	set moretodo 1
+        set n 500
+        set moretodo 1
     }
     if {$l + ($find_dirn > 0? $n: 1) > $vrowmod($curview)} {
-	update_arcrows $curview
+        update_arcrows $curview
     }
     set found 0
     set domore 1
@@ -6855,81 +6855,81 @@ proc findmore {} {
     set ids [lindex $varccommits($curview,$a)]
     set arowend [expr {$arow + [llength $ids]}]
     if {$gdttype eq [mc "containing:"]} {
-	for {} {$n > 0} {incr n -1; incr l $find_dirn} {
-	    if {$l < $arow || $l >= $arowend} {
-		incr ai $find_dirn
-		set a [lindex $varcorder($curview) $ai]
-		set arow [lindex $vrownum($curview) $ai]
-		set ids [lindex $varccommits($curview,$a)]
-		set arowend [expr {$arow + [llength $ids]}]
-	    }
-	    set id [lindex $ids [expr {$l - $arow}]]
-	    # shouldn't happen unless git log doesn't give all the commits...
-	    if {![info exists commitdata($id)] ||
-		![doesmatch $commitdata($id)]} {
-		continue
-	    }
-	    if {![info exists commitinfo($id)]} {
-		getcommit $id
-	    }
-	    set info $commitinfo($id)
-	    foreach f $info ty $fldtypes {
-		if {$ty eq ""} continue
-		if {($findloc eq [mc "All fields"] || $findloc eq $ty) &&
-		    [doesmatch $f]} {
-		    set found 1
-		    break
-		}
-	    }
-	    if {$found} break
-	}
+        for {} {$n > 0} {incr n -1; incr l $find_dirn} {
+            if {$l < $arow || $l >= $arowend} {
+                incr ai $find_dirn
+                set a [lindex $varcorder($curview) $ai]
+                set arow [lindex $vrownum($curview) $ai]
+                set ids [lindex $varccommits($curview,$a)]
+                set arowend [expr {$arow + [llength $ids]}]
+            }
+            set id [lindex $ids [expr {$l - $arow}]]
+            # shouldn't happen unless git log doesn't give all the commits...
+            if {![info exists commitdata($id)] ||
+                ![doesmatch $commitdata($id)]} {
+                continue
+            }
+            if {![info exists commitinfo($id)]} {
+                getcommit $id
+            }
+            set info $commitinfo($id)
+            foreach f $info ty $fldtypes {
+                if {$ty eq ""} continue
+                if {($findloc eq [mc "All fields"] || $findloc eq $ty) &&
+                    [doesmatch $f]} {
+                    set found 1
+                    break
+                }
+            }
+            if {$found} break
+        }
     } else {
-	for {} {$n > 0} {incr n -1; incr l $find_dirn} {
-	    if {$l < $arow || $l >= $arowend} {
-		incr ai $find_dirn
-		set a [lindex $varcorder($curview) $ai]
-		set arow [lindex $vrownum($curview) $ai]
-		set ids [lindex $varccommits($curview,$a)]
-		set arowend [expr {$arow + [llength $ids]}]
-	    }
-	    set id [lindex $ids [expr {$l - $arow}]]
-	    if {![info exists fhighlights($id)]} {
-		# this sets fhighlights($id) to -1
-		askfilehighlight $l $id
-	    }
-	    if {$fhighlights($id) > 0} {
-		set found $domore
-		break
-	    }
-	    if {$fhighlights($id) < 0} {
-		if {$domore} {
-		    set domore 0
-		    set findcurline [expr {$l - $find_dirn}]
-		}
-	    }
-	}
+        for {} {$n > 0} {incr n -1; incr l $find_dirn} {
+            if {$l < $arow || $l >= $arowend} {
+                incr ai $find_dirn
+                set a [lindex $varcorder($curview) $ai]
+                set arow [lindex $vrownum($curview) $ai]
+                set ids [lindex $varccommits($curview,$a)]
+                set arowend [expr {$arow + [llength $ids]}]
+            }
+            set id [lindex $ids [expr {$l - $arow}]]
+            if {![info exists fhighlights($id)]} {
+                # this sets fhighlights($id) to -1
+                askfilehighlight $l $id
+            }
+            if {$fhighlights($id) > 0} {
+                set found $domore
+                break
+            }
+            if {$fhighlights($id) < 0} {
+                if {$domore} {
+                    set domore 0
+                    set findcurline [expr {$l - $find_dirn}]
+                }
+            }
+        }
     }
     if {$found || ($domore && !$moretodo)} {
-	unset findcurline
-	unset find_dirn
-	notbusy finding
-	set fprogcoord 0
-	adjustprogress
-	if {$found} {
-	    findselectline $l
-	} else {
-	    bell
-	}
-	return 0
+        unset findcurline
+        unset find_dirn
+        notbusy finding
+        set fprogcoord 0
+        adjustprogress
+        if {$found} {
+            findselectline $l
+        } else {
+            bell
+        }
+        return 0
     }
     if {!$domore} {
-	flushhighlights
+        flushhighlights
     } else {
-	set findcurline [expr {$l - $find_dirn}]
+        set findcurline [expr {$l - $find_dirn}]
     }
     set n [expr {($findcurline - $findstartline) * $find_dirn - 1}]
     if {$n < 0} {
-	incr n $numcommits
+        incr n $numcommits
     }
     set fprogcoord [expr {$n * 1.0 / $numcommits}]
     adjustprogress
@@ -6943,15 +6943,15 @@ proc findselectline {l} {
     set findcurline $l
     selectline $l 1
     if {$markingmatches &&
-	($findloc eq [mc "All fields"] || $findloc eq [mc "Comments"])} {
-	# highlight the matches in the comments
-	set f [$ctext get 1.0 $commentend]
-	set matches [findmatches $f]
-	foreach match $matches {
-	    set start [lindex $match 0]
-	    set end [expr {[lindex $match 1] + 1}]
-	    $ctext tag add found "1.0 + $start c" "1.0 + $end c"
-	}
+        ($findloc eq [mc "All fields"] || $findloc eq [mc "Comments"])} {
+        # highlight the matches in the comments
+        set f [$ctext get 1.0 $commentend]
+        set matches [findmatches $f]
+        foreach match $matches {
+            set start [lindex $match 0]
+            set end [expr {[lindex $match 1] + 1}]
+            $ctext tag add found "1.0 + $start c" "1.0 + $end c"
+        }
     }
     drawvisible
 }
@@ -6965,18 +6965,18 @@ proc markmatches {canv l str tag matches font row} {
     set y0 [lindex $bbox 1]
     set y1 [lindex $bbox 3]
     foreach match $matches {
-	set start [lindex $match 0]
-	set end [lindex $match 1]
-	if {$start > $end} continue
-	set xoff [font measure $font [string range $str 0 [expr {$start-1}]]]
-	set xlen [font measure $font [string range $str 0 [expr {$end}]]]
-	set t [$canv create rect [expr {$x0+$xoff}] $y0 \
-		   [expr {$x0+$xlen+2}] $y1 \
-		   -outline {} -tags [list match$l matches] -fill yellow]
-	$canv lower $t
-	if {$row == $selectedline} {
-	    $canv raise $t secsel
-	}
+        set start [lindex $match 0]
+        set end [lindex $match 1]
+        if {$start > $end} continue
+        set xoff [font measure $font [string range $str 0 [expr {$start-1}]]]
+        set xlen [font measure $font [string range $str 0 [expr {$end}]]]
+        set t [$canv create rect [expr {$x0+$xoff}] $y0 \
+                   [expr {$x0+$xlen+2}] $y1 \
+                   -outline {} -tags [list match$l matches] -fill yellow]
+        $canv lower $t
+        if {$row == $selectedline} {
+            $canv raise $t secsel
+        }
     }
 }
 
@@ -6997,12 +6997,12 @@ proc selcanvline {w x y} {
     set y [expr {$y + $yfrac * $ymax}]
     set l [expr {int(($y - $canvy0) / $linespc + 0.5)}]
     if {$l < 0} {
-	set l 0
+        set l 0
     }
     if {$w eq $canv} {
-	set xmax [lindex [$canv cget -scrollregion] 2]
-	set xleft [expr {[lindex [$canv xview] 0] * $xmax}]
-	if {![info exists rowtextx($l)] || $xleft + $x < $rowtextx($l)} return
+        set xmax [lindex [$canv cget -scrollregion] 2]
+        set xleft [expr {[lindex [$canv xview] 0] * $xmax}]
+        if {![info exists rowtextx($l)] || $xleft + $x < $rowtextx($l)} return
     }
     unmarkmatches
     selectline $l 1
@@ -7011,11 +7011,11 @@ proc selcanvline {w x y} {
 proc commit_descriptor {p} {
     global commitinfo
     if {![info exists commitinfo($p)]} {
-	getcommit $p
+        getcommit $p
     }
     set l "..."
     if {[llength $commitinfo($p)] > 1} {
-	set l [lindex $commitinfo($p) 0]
+        set l [lindex $commitinfo($p) 0]
     }
     return "$p ($l)\n"
 }
@@ -7030,26 +7030,26 @@ proc appendwithlinks {text tags} {
     $ctext insert end $text $tags
     set links [regexp -indices -all -inline {(?:\m|-g)[0-9a-f]{6,40}\M} $text]
     foreach l $links {
-	set s [lindex $l 0]
-	set e [lindex $l 1]
-	set linkid [string range $text $s $e]
-	incr e
-	$ctext tag delete link$linknum
-	$ctext tag add link$linknum "$start + $s c" "$start + $e c"
-	setlink $linkid link$linknum
-	incr linknum
+        set s [lindex $l 0]
+        set e [lindex $l 1]
+        set linkid [string range $text $s $e]
+        incr e
+        $ctext tag delete link$linknum
+        $ctext tag add link$linknum "$start + $s c" "$start + $e c"
+        setlink $linkid link$linknum
+        incr linknum
     }
     set wlinks [regexp -indices -all -inline -line \
-		    {https?://[^[:space:]]+} $text]
+                    {https?://[^[:space:]]+} $text]
     foreach l $wlinks {
-	set s2 [lindex $l 0]
-	set e2 [lindex $l 1]
-	set url [string range $text $s2 $e2]
-	incr e2
-	$ctext tag delete link$linknum
-	$ctext tag add link$linknum "$start + $s2 c" "$start + $e2 c"
-	setwlink $url link$linknum
-	incr linknum
+        set s2 [lindex $l 0]
+        set e2 [lindex $l 1]
+        set url [string range $text $s2 $e2]
+        incr e2
+        $ctext tag delete link$linknum
+        $ctext tag add link$linknum "$start + $s2 c" "$start + $e2 c"
+        setwlink $url link$linknum
+        incr linknum
     }
 }
 
@@ -7063,23 +7063,23 @@ proc setlink {id lk} {
 
     set known 0
     if {[string length $id] < 40} {
-	set matches [longid $id]
-	if {[llength $matches] > 0} {
-	    if {[llength $matches] > 1} return
-	    set known 1
-	    set id [lindex $matches 0]
-	}
+        set matches [longid $id]
+        if {[llength $matches] > 0} {
+            if {[llength $matches] > 1} return
+            set known 1
+            set id [lindex $matches 0]
+        }
     } else {
-	set known [commitinview $id $curview]
+        set known [commitinview $id $curview]
     }
     if {$known} {
-	$ctext tag conf $lk -foreground $linkfgcolor -underline 1
-	$ctext tag bind $lk <1> [list selbyid $id]
-	$ctext tag bind $lk <Enter> {linkcursor %W 1}
-	$ctext tag bind $lk <Leave> {linkcursor %W -1}
+        $ctext tag conf $lk -foreground $linkfgcolor -underline 1
+        $ctext tag bind $lk <1> [list selbyid $id]
+        $ctext tag bind $lk <Enter> {linkcursor %W 1}
+        $ctext tag bind $lk <Leave> {linkcursor %W -1}
     } else {
-	lappend pendinglinks($id) $lk
-	interestedin $id {makelink %P}
+        lappend pendinglinks($id) $lk
+        interestedin $id {makelink %P}
     }
 }
 
@@ -7111,7 +7111,7 @@ proc makelink {id} {
 
     if {![info exists pendinglinks($id)]} return
     foreach lk $pendinglinks($id) {
-	setlink $id $lk
+        setlink $id $lk
     }
     unset pendinglinks($id)
 }
@@ -7120,12 +7120,12 @@ proc linkcursor {w inc} {
     global linkentercount curtextcursor
 
     if {[incr linkentercount $inc] > 0} {
-	$w configure -cursor hand2
+        $w configure -cursor hand2
     } else {
-	$w configure -cursor $curtextcursor
-	if {$linkentercount < 0} {
-	    set linkentercount 0
-	}
+        $w configure -cursor $curtextcursor
+        if {$linkentercount < 0} {
+            set linkentercount 0
+        }
     }
 }
 
@@ -7135,7 +7135,7 @@ proc browseweb {url} {
     if {$web_browser eq {}} return
     # Use eval here in case $web_browser is a command plus some arguments
     if {[catch {eval exec $web_browser [list $url] &} err]} {
-	error_popup "[mc "Error starting web browser:"] $err"
+        error_popup "[mc "Error starting web browser:"] $err"
     }
 }
 
@@ -7148,9 +7148,9 @@ proc viewnextline {dir} {
     set wtop [expr {[lindex $wnow 0] * $ymax}]
     set newtop [expr {$wtop + $dir * $linespc}]
     if {$newtop < 0} {
-	set newtop 0
+        set newtop 0
     } elseif {$newtop > $ymax} {
-	set newtop $ymax
+        set newtop $ymax
     }
     allcanvs yview moveto [expr {$newtop * 1.0 / $ymax}]
 }
@@ -7161,15 +7161,15 @@ proc appendrefs {pos ids var} {
     global ctext linknum curview $var maxrefs visiblerefs mainheadid
 
     if {[catch {$ctext index $pos}]} {
-	return 0
+        return 0
     }
     $ctext conf -state normal
     $ctext delete $pos "$pos lineend"
     set tags {}
     foreach id $ids {
-	foreach tag [set $var\($id\)] {
-	    lappend tags [list $tag $id]
-	}
+        foreach tag [set $var\($id\)] {
+            lappend tags [list $tag $id]
+        }
     }
 
     set sep {}
@@ -7177,44 +7177,44 @@ proc appendrefs {pos ids var} {
     set nutags 0
 
     if {[llength $tags] > $maxrefs} {
-	# If we are displaying heads, and there are too many,
-	# see if there are some important heads to display.
-	# Currently that are the current head and heads listed in $visiblerefs option
-	set itags {}
-	if {$var eq "idheads"} {
-	    set utags {}
-	    foreach ti $tags {
-		set hname [lindex $ti 0]
-		set id [lindex $ti 1]
-		if {([lsearch -exact $visiblerefs $hname] != -1 || $id eq $mainheadid) &&
-		    [llength $itags] < $maxrefs} {
-		    lappend itags $ti
-		} else {
-		    lappend utags $ti
-		}
-	    }
-	    set tags $utags
-	}
-	if {$itags ne {}} {
-	    set str [mc "and many more"]
-	    set sep " "
-	} else {
-	    set str [mc "many"]
-	}
-	$ctext insert $pos "$str ([llength $tags])"
-	set nutags [llength $tags]
-	set tags $itags
+        # If we are displaying heads, and there are too many,
+        # see if there are some important heads to display.
+        # Currently that are the current head and heads listed in $visiblerefs option
+        set itags {}
+        if {$var eq "idheads"} {
+            set utags {}
+            foreach ti $tags {
+                set hname [lindex $ti 0]
+                set id [lindex $ti 1]
+                if {([lsearch -exact $visiblerefs $hname] != -1 || $id eq $mainheadid) &&
+                    [llength $itags] < $maxrefs} {
+                    lappend itags $ti
+                } else {
+                    lappend utags $ti
+                }
+            }
+            set tags $utags
+        }
+        if {$itags ne {}} {
+            set str [mc "and many more"]
+            set sep " "
+        } else {
+            set str [mc "many"]
+        }
+        $ctext insert $pos "$str ([llength $tags])"
+        set nutags [llength $tags]
+        set tags $itags
     }
 
     foreach ti $tags {
-	set id [lindex $ti 1]
-	set lk link$linknum
-	incr linknum
-	$ctext tag delete $lk
-	$ctext insert $pos $sep
-	$ctext insert $pos [lindex $ti 0] $lk
-	setlink $id $lk
-	set sep ", "
+        set id [lindex $ti 1]
+        set lk link$linknum
+        incr linknum
+        $ctext tag delete $lk
+        $ctext insert $pos $sep
+        $ctext insert $pos [lindex $ti 0] $lk
+        setlink $id $lk
+        set sep ", "
     }
     $ctext tag add wwrap "$pos linestart" "$pos lineend"
     $ctext conf -state disabled
@@ -7228,11 +7228,11 @@ proc dispneartags {delay} {
     if {$selectedline eq {} || !$showneartags} return
     after cancel dispnexttag
     if {$delay} {
-	after 200 dispnexttag
-	set tagphase -1
+        after 200 dispnexttag
+        set tagphase -1
     } else {
-	after idle dispnexttag
-	set tagphase 0
+        after idle dispnexttag
+        set tagphase 0
     }
 }
 
@@ -7241,33 +7241,33 @@ proc dispnexttag {} {
 
     if {$selectedline eq {} || !$showneartags} return
     switch -- $tagphase {
-	0 {
-	    set dtags [desctags $currentid]
-	    if {$dtags ne {}} {
-		appendrefs precedes $dtags idtags
-	    }
-	}
-	1 {
-	    set atags [anctags $currentid]
-	    if {$atags ne {}} {
-		appendrefs follows $atags idtags
-	    }
-	}
-	2 {
-	    set dheads [descheads $currentid]
-	    if {$dheads ne {}} {
-		if {[appendrefs branch $dheads idheads] > 1
-		    && [$ctext get "branch -3c"] eq "h"} {
-		    # turn "Branch" into "Branches"
-		    $ctext conf -state normal
-		    $ctext insert "branch -2c" "es"
-		    $ctext conf -state disabled
-		}
-	    }
-	}
+        0 {
+            set dtags [desctags $currentid]
+            if {$dtags ne {}} {
+                appendrefs precedes $dtags idtags
+            }
+        }
+        1 {
+            set atags [anctags $currentid]
+            if {$atags ne {}} {
+                appendrefs follows $atags idtags
+            }
+        }
+        2 {
+            set dheads [descheads $currentid]
+            if {$dheads ne {}} {
+                if {[appendrefs branch $dheads idheads] > 1
+                    && [$ctext get "branch -3c"] eq "h"} {
+                    # turn "Branch" into "Branches"
+                    $ctext conf -state normal
+                    $ctext insert "branch -2c" "es"
+                    $ctext conf -state disabled
+                }
+            }
+        }
     }
     if {[incr tagphase] <= 2} {
-	after idle dispnexttag
+        after idle dispnexttag
     }
 }
 
@@ -7277,15 +7277,15 @@ proc make_secsel {id} {
     if {![info exists linehtag($id)]} return
     $canv delete secsel
     set t [eval $canv create rect [$canv bbox $linehtag($id)] -outline {{}} \
-	       -tags secsel -fill [$canv cget -selectbackground]]
+               -tags secsel -fill [$canv cget -selectbackground]]
     $canv lower $t
     $canv2 delete secsel
     set t [eval $canv2 create rect [$canv2 bbox $linentag($id)] -outline {{}} \
-	       -tags secsel -fill [$canv2 cget -selectbackground]]
+               -tags secsel -fill [$canv2 cget -selectbackground]]
     $canv2 lower $t
     $canv3 delete secsel
     set t [eval $canv3 create rect [$canv3 bbox $linedtag($id)] -outline {{}} \
-	       -tags secsel -fill [$canv3 cget -selectbackground]]
+               -tags secsel -fill [$canv3 cget -selectbackground]]
     $canv3 lower $t
 }
 
@@ -7295,7 +7295,7 @@ proc make_idmark {id} {
     if {![info exists linehtag($id)]} return
     $canv delete markid
     set t [eval $canv create rect [$canv bbox $linehtag($id)] \
-	       -tags markid -outline $fgcolor]
+               -tags markid -outline $fgcolor]
     $canv raise $t
 }
 
@@ -7322,7 +7322,7 @@ proc selectline {l isnew {desired_loc {}} {switch_to_patch 0}} {
     set selectedline $l
     set currentid $id
     if {$lastscrollrows < $numcommits} {
-	setcanvscroll
+        setcanvscroll
     }
 
     if {$cmitmode ne "patch" && $switch_to_patch} {
@@ -7339,42 +7339,42 @@ proc selectline {l isnew {desired_loc {}} {switch_to_patch 0}} {
     set wh [expr {$wbot - $wtop}]
     set newtop $wtop
     if {$ytop < $wtop} {
-	if {$ybot < $wtop} {
-	    set newtop [expr {$y - $wh / 2.0}]
-	} else {
-	    set newtop $ytop
-	    if {$newtop > $wtop - $linespc} {
-		set newtop [expr {$wtop - $linespc}]
-	    }
-	}
+        if {$ybot < $wtop} {
+            set newtop [expr {$y - $wh / 2.0}]
+        } else {
+            set newtop $ytop
+            if {$newtop > $wtop - $linespc} {
+                set newtop [expr {$wtop - $linespc}]
+            }
+        }
     } elseif {$ybot > $wbot} {
-	if {$ytop > $wbot} {
-	    set newtop [expr {$y - $wh / 2.0}]
-	} else {
-	    set newtop [expr {$ybot - $wh}]
-	    if {$newtop < $wtop + $linespc} {
-		set newtop [expr {$wtop + $linespc}]
-	    }
-	}
+        if {$ytop > $wbot} {
+            set newtop [expr {$y - $wh / 2.0}]
+        } else {
+            set newtop [expr {$ybot - $wh}]
+            if {$newtop < $wtop + $linespc} {
+                set newtop [expr {$wtop + $linespc}]
+            }
+        }
     }
     if {$newtop != $wtop} {
-	if {$newtop < 0} {
-	    set newtop 0
-	}
-	allcanvs yview moveto [expr {$newtop * 1.0 / $ymax}]
-	drawvisible
+        if {$newtop < 0} {
+            set newtop 0
+        }
+        allcanvs yview moveto [expr {$newtop * 1.0 / $ymax}]
+        drawvisible
     }
 
     make_secsel $id
 
     if {$isnew} {
-	addtohistory [list selbyid $id 0] savecmitpos
+        addtohistory [list selbyid $id 0] savecmitpos
     }
 
     $sha1entry delete 0 end
     $sha1entry insert 0 $id
     if {$autoselect} {
-	$sha1entry selection range 0 $autosellen
+        $sha1entry selection range 0 $autosellen
     }
     rhighlight_sel $id
 
@@ -7382,7 +7382,7 @@ proc selectline {l isnew {desired_loc {}} {switch_to_patch 0}} {
     clear_ctext
     set linknum 0
     if {![info exists commitinfo($id)]} {
-	getcommit $id
+        getcommit $id
     }
     set info $commitinfo($id)
     set date [formatdate [lindex $info 2]]
@@ -7390,59 +7390,59 @@ proc selectline {l isnew {desired_loc {}} {switch_to_patch 0}} {
     set date [formatdate [lindex $info 4]]
     $ctext insert end "[mc "Committer"]: [lindex $info 3]  $date\n"
     if {[info exists idtags($id)]} {
-	$ctext insert end [mc "Tags:"]
-	foreach tag $idtags($id) {
-	    $ctext insert end " $tag"
-	}
-	$ctext insert end "\n"
+        $ctext insert end [mc "Tags:"]
+        foreach tag $idtags($id) {
+            $ctext insert end " $tag"
+        }
+        $ctext insert end "\n"
     }
 
     set headers {}
     set olds $parents($curview,$id)
     if {[llength $olds] > 1} {
-	set np 0
-	foreach p $olds {
-	    if {$np >= $mergemax} {
-		set tag mmax
-	    } else {
-		set tag m$np
-	    }
-	    $ctext insert end "[mc "Parent"]: " $tag
-	    appendwithlinks [commit_descriptor $p] {}
-	    incr np
-	}
+        set np 0
+        foreach p $olds {
+            if {$np >= $mergemax} {
+                set tag mmax
+            } else {
+                set tag m$np
+            }
+            $ctext insert end "[mc "Parent"]: " $tag
+            appendwithlinks [commit_descriptor $p] {}
+            incr np
+        }
     } else {
-	foreach p $olds {
-	    append headers "[mc "Parent"]: [commit_descriptor $p]"
-	}
+        foreach p $olds {
+            append headers "[mc "Parent"]: [commit_descriptor $p]"
+        }
     }
 
     foreach c $children($curview,$id) {
-	append headers "[mc "Child"]:  [commit_descriptor $c]"
+        append headers "[mc "Child"]:  [commit_descriptor $c]"
     }
 
     # make anything that looks like a SHA1 ID be a clickable link
     appendwithlinks $headers {}
     if {$showneartags} {
-	if {![info exists allcommits]} {
-	    getallcommits
-	}
-	$ctext insert end "[mc "Branch"]: "
-	$ctext mark set branch "end -1c"
-	$ctext mark gravity branch left
-	$ctext insert end "\n[mc "Follows"]: "
-	$ctext mark set follows "end -1c"
-	$ctext mark gravity follows left
-	$ctext insert end "\n[mc "Precedes"]: "
-	$ctext mark set precedes "end -1c"
-	$ctext mark gravity precedes left
-	$ctext insert end "\n"
-	dispneartags 1
+        if {![info exists allcommits]} {
+            getallcommits
+        }
+        $ctext insert end "[mc "Branch"]: "
+        $ctext mark set branch "end -1c"
+        $ctext mark gravity branch left
+        $ctext insert end "\n[mc "Follows"]: "
+        $ctext mark set follows "end -1c"
+        $ctext mark gravity follows left
+        $ctext insert end "\n[mc "Precedes"]: "
+        $ctext mark set precedes "end -1c"
+        $ctext mark gravity precedes left
+        $ctext insert end "\n"
+        dispneartags 1
     }
     $ctext insert end "\n"
     set comment [lindex $info 5]
     if {[string first "\r" $comment] >= 0} {
-	set comment [string map {"\r" "\n    "} $comment]
+        set comment [string map {"\r" "\n    "} $comment]
     }
     appendwithlinks $comment {comment}
 
@@ -7453,13 +7453,13 @@ proc selectline {l isnew {desired_loc {}} {switch_to_patch 0}} {
     set jump_to_here $desired_loc
     init_flist [mc "Comments"]
     if {$cmitmode eq "tree"} {
-	gettree $id
+        gettree $id
     } elseif {$vinlinediff($curview) == 1} {
-	showinlinediff $id
+        showinlinediff $id
     } elseif {[llength $olds] <= 1} {
-	startdiff $id
+        startdiff $id
     } else {
-	mergediff $id
+        mergediff $id
     }
 }
 
@@ -7489,14 +7489,14 @@ proc selnextpage {dir} {
 
     set lpp [expr {([winfo height $canv] - 2) / $linespc}]
     if {$lpp < 1} {
-	set lpp 1
+        set lpp 1
     }
     allcanvs yview scroll [expr {$dir * $lpp}] units
     drawvisible
     if {$selectedline eq {}} return
     set l [expr {$selectedline + $dir * $lpp}]
     if {$l < 0} {
-	set l 0
+        set l 0
     } elseif {$l >= $numcommits} {
         set l [expr $numcommits - 1]
     }
@@ -7517,7 +7517,7 @@ proc reselectline {} {
     global selectedline
 
     if {$selectedline ne {}} {
-	selectline $selectedline 0
+        selectline $selectedline 0
     }
 }
 
@@ -7528,20 +7528,20 @@ proc addtohistory {cmd {saveproc {}}} {
     save_position
     set elt [list $curview $cmd $saveproc {}]
     if {$historyindex > 0
-	&& [lindex $history [expr {$historyindex - 1}]] == $elt} {
-	return
+        && [lindex $history [expr {$historyindex - 1}]] == $elt} {
+        return
     }
 
     if {$historyindex < [llength $history]} {
-	set history [lreplace $history $historyindex end $elt]
+        set history [lreplace $history $historyindex end $elt]
     } else {
-	lappend history $elt
+        lappend history $elt
     }
     incr historyindex
     if {$historyindex > 1} {
-	.tf.bar.leftbut conf -state normal
+        .tf.bar.leftbut conf -state normal
     } else {
-	.tf.bar.leftbut conf -state disabled
+        .tf.bar.leftbut conf -state disabled
     }
     .tf.bar.rightbut conf -state disabled
 }
@@ -7554,7 +7554,7 @@ proc save_position {} {
     set hi [expr {$historyindex - 1}]
     set fn [lindex $history $hi 2]
     if {$fn ne {}} {
-	lset history $hi 3 [eval $fn]
+        lset history $hi 3 [eval $fn]
     }
 }
 
@@ -7562,11 +7562,11 @@ proc unset_posvars {} {
     global last_posvars
 
     if {[info exists last_posvars]} {
-	foreach {var val} $last_posvars {
-	    global $var
-	    unset -nocomplain $var
-	}
-	unset last_posvars
+        foreach {var val} $last_posvars {
+            global $var
+            unset -nocomplain $var
+        }
+        unset last_posvars
     }
 }
 
@@ -7577,12 +7577,12 @@ proc godo {elt} {
     set cmd [lindex $elt 1]
     set pv [lindex $elt 3]
     if {$curview != $view} {
-	showview $view
+        showview $view
     }
     unset_posvars
     foreach {var val} $pv {
-	global $var
-	set $var $val
+        global $var
+        set $var $val
     }
     set last_posvars $pv
     eval $cmd
@@ -7593,13 +7593,13 @@ proc goback {} {
     focus .
 
     if {$historyindex > 1} {
-	save_position
-	incr historyindex -1
-	godo [lindex $history [expr {$historyindex - 1}]]
-	.tf.bar.rightbut conf -state normal
+        save_position
+        incr historyindex -1
+        godo [lindex $history [expr {$historyindex - 1}]]
+        .tf.bar.rightbut conf -state normal
     }
     if {$historyindex <= 1} {
-	.tf.bar.leftbut conf -state disabled
+        .tf.bar.leftbut conf -state disabled
     }
 }
 
@@ -7608,14 +7608,14 @@ proc goforw {} {
     focus .
 
     if {$historyindex < [llength $history]} {
-	save_position
-	set cmd [lindex $history $historyindex]
-	incr historyindex
-	godo $cmd
-	.tf.bar.leftbut conf -state normal
+        save_position
+        set cmd [lindex $history $historyindex]
+        incr historyindex
+        godo $cmd
+        .tf.bar.leftbut conf -state normal
     }
     if {$historyindex >= [llength $history]} {
-	.tf.bar.rightbut conf -state disabled
+        .tf.bar.rightbut conf -state disabled
     }
 }
 
@@ -7623,7 +7623,7 @@ proc go_to_parent {i} {
     global parents curview targetid
     set ps $parents($curview,$targetid)
     if {[llength $ps] >= $i} {
-	selbyid [lindex $ps [expr $i - 1]]
+        selbyid [lindex $ps [expr $i - 1]]
     }
 }
 
@@ -7634,25 +7634,25 @@ proc gettree {id} {
     set diffids $id
     unset -nocomplain diffmergeid
     if {![info exists treefilelist($id)]} {
-	if {![info exists treepending]} {
-	    if {$id eq $nullid} {
-		set cmd [list | git ls-files]
-	    } elseif {$id eq $nullid2} {
-		set cmd [list | git ls-files --stage -t]
-	    } else {
-		set cmd [list | git ls-tree -r $id]
-	    }
-	    if {[catch {set gtf [open $cmd r]}]} {
-		return
-	    }
-	    set treepending $id
-	    set treefilelist($id) {}
-	    set treeidlist($id) {}
-	    fconfigure $gtf -blocking 0 -encoding binary
-	    filerun $gtf [list gettreeline $gtf $id]
-	}
+        if {![info exists treepending]} {
+            if {$id eq $nullid} {
+                set cmd [list | git ls-files]
+            } elseif {$id eq $nullid2} {
+                set cmd [list | git ls-files --stage -t]
+            } else {
+                set cmd [list | git ls-tree -r $id]
+            }
+            if {[catch {set gtf [open $cmd r]}]} {
+                return
+            }
+            set treepending $id
+            set treefilelist($id) {}
+            set treeidlist($id) {}
+            fconfigure $gtf -blocking 0 -encoding binary
+            filerun $gtf [list gettreeline $gtf $id]
+        }
     } else {
-	setfilelist $id
+        setfilelist $id
     }
 }
 
@@ -7661,36 +7661,36 @@ proc gettreeline {gtf id} {
 
     set nl 0
     while {[incr nl] <= 1000 && [gets $gtf line] >= 0} {
-	if {$diffids eq $nullid} {
-	    set fname $line
-	} else {
-	    set i [string first "\t" $line]
-	    if {$i < 0} continue
-	    set fname [string range $line [expr {$i+1}] end]
-	    set line [string range $line 0 [expr {$i-1}]]
-	    if {$diffids ne $nullid2 && [lindex $line 1] ne "blob"} continue
-	    set sha1 [lindex $line 2]
-	    lappend treeidlist($id) $sha1
-	}
-	if {[string index $fname 0] eq "\""} {
-	    set fname [lindex $fname 0]
-	}
-	set fname [encoding convertfrom $fname]
-	lappend treefilelist($id) $fname
+        if {$diffids eq $nullid} {
+            set fname $line
+        } else {
+            set i [string first "\t" $line]
+            if {$i < 0} continue
+            set fname [string range $line [expr {$i+1}] end]
+            set line [string range $line 0 [expr {$i-1}]]
+            if {$diffids ne $nullid2 && [lindex $line 1] ne "blob"} continue
+            set sha1 [lindex $line 2]
+            lappend treeidlist($id) $sha1
+        }
+        if {[string index $fname 0] eq "\""} {
+            set fname [lindex $fname 0]
+        }
+        set fname [encoding convertfrom $fname]
+        lappend treefilelist($id) $fname
     }
     if {![eof $gtf]} {
-	return [expr {$nl >= 1000? 2: 1}]
+        return [expr {$nl >= 1000? 2: 1}]
     }
     close $gtf
     unset treepending
     if {$cmitmode ne "tree"} {
-	if {![info exists diffmergeid]} {
-	    gettreediffs $diffids
-	}
+        if {![info exists diffmergeid]} {
+            gettreediffs $diffids
+        }
     } elseif {$id ne $diffids} {
-	gettree $diffids
+        gettree $diffids
     } else {
-	setfilelist $id
+        setfilelist $id
     }
     return 0
 }
@@ -7702,20 +7702,20 @@ proc showfile {f} {
 
     set i [lsearch -exact $treefilelist($diffids) $f]
     if {$i < 0} {
-	puts "oops, $f not in list for id $diffids"
-	return
+        puts "oops, $f not in list for id $diffids"
+        return
     }
     if {$diffids eq $nullid} {
-	if {[catch {set bf [open $f r]} err]} {
-	    puts "oops, can't read $f: $err"
-	    return
-	}
+        if {[catch {set bf [open $f r]} err]} {
+            puts "oops, can't read $f: $err"
+            return
+        }
     } else {
-	set blob [lindex $treeidlist($diffids) $i]
-	if {[catch {set bf [open [concat | git cat-file blob $blob] r]} err]} {
-	    puts "oops, error reading blob $blob: $err"
-	    return
-	}
+        set blob [lindex $treeidlist($diffids) $i]
+        if {[catch {set bf [open [concat | git cat-file blob $blob] r]} err]} {
+            puts "oops, error reading blob $blob: $err"
+            return
+        }
     }
     fconfigure $bf -blocking 0 -encoding [get_path_encoding $f]
     filerun $bf [list getblobline $bf $diffids]
@@ -7734,28 +7734,28 @@ proc getblobline {bf id} {
     global diffids cmitmode ctext
 
     if {$id ne $diffids || $cmitmode ne "tree"} {
-	catch {close $bf}
-	return 0
+        catch {close $bf}
+        return 0
     }
     $ctext config -state normal
     set nl 0
     while {[incr nl] <= 1000 && [gets $bf line] >= 0} {
-	$ctext insert end "$line\n"
+        $ctext insert end "$line\n"
     }
     if {[eof $bf]} {
-	global jump_to_here ctext_file_names commentend
+        global jump_to_here ctext_file_names commentend
 
-	# delete last newline
-	$ctext delete "end - 2c" "end - 1c"
-	close $bf
-	if {$jump_to_here ne {} &&
-	    [lindex $jump_to_here 0] eq [lindex $ctext_file_names 0]} {
-	    set lnum [expr {[lindex $jump_to_here 1] +
-			    [lindex [split $commentend .] 0]}]
-	    mark_ctext_line $lnum
-	}
-	$ctext config -state disabled
-	return 0
+        # delete last newline
+        $ctext delete "end - 2c" "end - 1c"
+        close $bf
+        if {$jump_to_here ne {} &&
+            [lindex $jump_to_here 0] eq [lindex $ctext_file_names 0]} {
+            set lnum [expr {[lindex $jump_to_here 1] +
+                            [lindex [split $commentend .] 0]}]
+            mark_ctext_line $lnum
+        }
+        $ctext config -state disabled
+        return 0
     }
     $ctext config -state disabled
     return [expr {$nl >= 1000? 2: 1}]
@@ -7790,13 +7790,13 @@ proc startdiff {ids} {
     set diffids $ids
     unset -nocomplain diffmergeid
     if {![info exists treediffs($ids)] ||
-	[lsearch -exact $ids $nullid] >= 0 ||
-	[lsearch -exact $ids $nullid2] >= 0} {
-	if {![info exists treepending]} {
-	    gettreediffs $ids
-	}
+        [lsearch -exact $ids $nullid] >= 0 ||
+        [lsearch -exact $ids $nullid2] >= 0} {
+        if {![info exists treepending]} {
+            gettreediffs $ids
+        }
     } else {
-	addtocflist $ids
+        addtocflist $ids
     }
 }
 
@@ -7813,13 +7813,13 @@ proc showinlinediff {ids} {
 
     set inhdr 0
     foreach line $difflines {
-	if {![string compare -length 5 "diff " $line]} {
-	    set inhdr 1
-	} elseif {$inhdr && ![string compare -length 4 "+++ " $line]} {
-	    # offset also accounts for the b/ prefix
-	    lappend treediff [string range $line 6 end]
-	    set inhdr 0
-	}
+        if {![string compare -length 5 "diff " $line]} {
+            set inhdr 1
+        } elseif {$inhdr && ![string compare -length 4 "+++ " $line]} {
+            # offset also accounts for the b/ prefix
+            lappend treediff [string range $line 6 end]
+            set inhdr 0
+        }
     }
 
     set treediffs($ids) $treediff
@@ -7827,7 +7827,7 @@ proc showinlinediff {ids} {
 
     $ctext conf -state normal
     foreach line $difflines {
-	parseblobdiffline $ids $line
+        parseblobdiffline $ids $line
     }
     maybe_scroll_ctext 1
     $ctext conf -state disabled
@@ -7838,11 +7838,11 @@ proc showinlinediff {ids} {
 proc path_filter {filter name} {
     set worktree [gitworktree]
     foreach p $filter {
-	set fq_p [file normalize $p]
-	set fq_n [file normalize [file join $worktree $name]]
-	if {[string match [file normalize $fq_p]* $fq_n]} {
-	    return 1
-	}
+        set fq_p [file normalize $p]
+        set fq_n [file normalize [file join $worktree $name]]
+        if {[string match [file normalize $fq_p]* $fq_n]} {
+            return 1
+        }
     }
     return 0
 }
@@ -7860,42 +7860,42 @@ proc diffcmd {ids flags} {
     set i [lsearch -exact $ids $nullid]
     set j [lsearch -exact $ids $nullid2]
     if {$i >= 0} {
-	if {[llength $ids] > 1 && $j < 0} {
-	    # comparing working directory with some specific revision
-	    set cmd [concat | git diff-index $flags]
-	    if {$i == 0} {
-		lappend cmd -R [lindex $ids 1]
-	    } else {
-		lappend cmd [lindex $ids 0]
-	    }
-	} else {
-	    # comparing working directory with index
-	    set cmd [concat | git diff-files $flags]
-	    if {$j == 1} {
-		lappend cmd -R
-	    }
-	}
+        if {[llength $ids] > 1 && $j < 0} {
+            # comparing working directory with some specific revision
+            set cmd [concat | git diff-index $flags]
+            if {$i == 0} {
+                lappend cmd -R [lindex $ids 1]
+            } else {
+                lappend cmd [lindex $ids 0]
+            }
+        } else {
+            # comparing working directory with index
+            set cmd [concat | git diff-files $flags]
+            if {$j == 1} {
+                lappend cmd -R
+            }
+        }
     } elseif {$j >= 0} {
-	if {[package vcompare $git_version "1.7.2"] >= 0} {
-	    set flags "$flags --ignore-submodules=dirty"
-	}
-	set cmd [concat | git diff-index --cached $flags]
-	if {[llength $ids] > 1} {
-	    # comparing index with specific revision
-	    if {$j == 0} {
-		lappend cmd -R [lindex $ids 1]
-	    } else {
-		lappend cmd [lindex $ids 0]
-	    }
-	} else {
-	    # comparing index with HEAD
-	    lappend cmd HEAD
-	}
+        if {[package vcompare $git_version "1.7.2"] >= 0} {
+            set flags "$flags --ignore-submodules=dirty"
+        }
+        set cmd [concat | git diff-index --cached $flags]
+        if {[llength $ids] > 1} {
+            # comparing index with specific revision
+            if {$j == 0} {
+                lappend cmd -R [lindex $ids 1]
+            } else {
+                lappend cmd [lindex $ids 0]
+            }
+        } else {
+            # comparing index with HEAD
+            lappend cmd HEAD
+        }
     } else {
-	if {$log_showroot} {
-	    lappend flags --root
-	}
-	set cmd [concat | git diff-tree -r $flags $ids]
+        if {$log_showroot} {
+            lappend flags --root
+        }
+        set cmd [concat | git diff-tree -r $flags $ids]
     }
     return $cmd
 }
@@ -7905,7 +7905,7 @@ proc gettreediffs {ids} {
 
     set cmd [diffcmd $ids {--no-commit-id}]
     if {$limitdiffs && $vfilelimit($curview) ne {}} {
-	    set cmd [concat $cmd -- $vfilelimit($curview)]
+            set cmd [concat $cmd -- $vfilelimit($curview)]
     }
     if {[catch {set gdtf [open $cmd r]}]} return
 
@@ -7923,44 +7923,44 @@ proc gettreediffline {gdtf ids} {
     set sublist {}
     set max 1000
     if {$perfile_attrs} {
-	# cache_gitattr is slow, and even slower on win32 where we
-	# have to invoke it for only about 30 paths at a time
-	set max 500
-	if {[tk windowingsystem] == "win32"} {
-	    set max 120
-	}
+        # cache_gitattr is slow, and even slower on win32 where we
+        # have to invoke it for only about 30 paths at a time
+        set max 500
+        if {[tk windowingsystem] == "win32"} {
+            set max 120
+        }
     }
     while {[incr nr] <= $max && [gets $gdtf line] >= 0} {
-	set i [string first "\t" $line]
-	if {$i >= 0} {
-	    set file [string range $line [expr {$i+1}] end]
-	    if {[string index $file 0] eq "\""} {
-		set file [lindex $file 0]
-	    }
-	    set file [encoding convertfrom $file]
-	    if {$file ne [lindex $treediff end]} {
-		lappend treediff $file
-		lappend sublist $file
-	    }
-	}
+        set i [string first "\t" $line]
+        if {$i >= 0} {
+            set file [string range $line [expr {$i+1}] end]
+            if {[string index $file 0] eq "\""} {
+                set file [lindex $file 0]
+            }
+            set file [encoding convertfrom $file]
+            if {$file ne [lindex $treediff end]} {
+                lappend treediff $file
+                lappend sublist $file
+            }
+        }
     }
     if {$perfile_attrs} {
-	cache_gitattr encoding $sublist
+        cache_gitattr encoding $sublist
     }
     if {![eof $gdtf]} {
-	return [expr {$nr >= $max? 2: 1}]
+        return [expr {$nr >= $max? 2: 1}]
     }
     close $gdtf
     set treediffs($ids) $treediff
     unset treepending
     if {$cmitmode eq "tree" && [llength $diffids] == 1} {
-	gettree $diffids
+        gettree $diffids
     } elseif {$ids != $diffids} {
-	if {![info exists diffmergeid]} {
-	    gettreediffs $diffids
-	}
+        if {![info exists diffmergeid]} {
+            gettreediffs $diffids
+        }
     } else {
-	addtocflist $ids
+        addtocflist $ids
     }
     return 0
 }
@@ -7974,10 +7974,10 @@ proc diffcontextchange {n1 n2 op} {
     global diffcontextstring diffcontext
 
     if {[string is integer -strict $diffcontextstring]} {
-	if {$diffcontextstring >= 0} {
-	    set diffcontext $diffcontextstring
-	    reselectline
-	}
+        if {$diffcontextstring >= 0} {
+            set diffcontext $diffcontextstring
+            reselectline
+        }
     }
 }
 
@@ -8011,25 +8011,25 @@ proc getblobdiffs {ids} {
 
     set textconv {}
     if {[package vcompare $git_version "1.6.1"] >= 0} {
-	set textconv "--textconv"
+        set textconv "--textconv"
     }
     set submodule {}
     if {[package vcompare $git_version "1.6.6"] >= 0} {
-	set submodule "--submodule"
+        set submodule "--submodule"
     }
     set cmd [diffcmd $ids "-p $textconv $submodule  -C --cc --no-commit-id -U$diffcontext"]
     if {$ignorespace} {
-	append cmd " -w"
+        append cmd " -w"
     }
     if {$worddiff ne [mc "Line diff"]} {
-	append cmd " --word-diff=porcelain"
+        append cmd " --word-diff=porcelain"
     }
     if {$limitdiffs && $vfilelimit($curview) ne {}} {
-	set cmd [concat $cmd -- $vfilelimit($curview)]
+        set cmd [concat $cmd -- $vfilelimit($curview)]
     }
     if {[catch {set bdf [open $cmd r]} err]} {
-	error_popup [mc "Error getting diffs: %s" $err]
-	return
+        error_popup [mc "Error getting diffs: %s" $err]
+        return
     }
     fconfigure $bdf -blocking 0 -encoding binary -eofchar {}
     set blobdifffd($ids) $bdf
@@ -8041,7 +8041,7 @@ proc savecmitpos {} {
     global ctext cmitmode
 
     if {$cmitmode eq "tree"} {
-	return {}
+        return {}
     }
     return [list target_scrollpos [$ctext index @0,0]]
 }
@@ -8057,9 +8057,9 @@ proc maybe_scroll_ctext {ateof} {
 
     if {![info exists target_scrollpos]} return
     if {!$ateof} {
-	set nlines [expr {[winfo height $ctext]
-			  / [font metrics textfont -linespace]}]
-	if {[$ctext compare "$target_scrollpos + $nlines lines" <= end]} return
+        set nlines [expr {[winfo height $ctext]
+                          / [font metrics textfont -linespace]}]
+        if {[$ctext compare "$target_scrollpos + $nlines lines" <= end]} return
     }
     $ctext yview $target_scrollpos
     unset target_scrollpos
@@ -8069,12 +8069,12 @@ proc setinlist {var i val} {
     global $var
 
     while {[llength [set $var]] < $i} {
-	lappend $var {}
+        lappend $var {}
     }
     if {[llength [set $var]] == $i} {
-	lappend $var $val
+        lappend $var $val
     } else {
-	lset $var $i $val
+        lset $var $i $val
     }
 }
 
@@ -8086,7 +8086,7 @@ proc makediffhdr {fname ids} {
     set diffencoding [get_path_encoding $fname]
     set i [lsearch -exact $treediffs($ids) $fname]
     if {$i >= 0} {
-	setinlist difffilestart $i $curdiffstart
+        setinlist difffilestart $i $curdiffstart
     }
     lset ctext_file_names end $fname
     set l [expr {(78 - [string length $fname]) / 2}]
@@ -8094,7 +8094,7 @@ proc makediffhdr {fname ids} {
     $ctext insert $curdiffstart "$pad $fname $pad" filesep
     set targetline {}
     if {$jump_to_here ne {} && [lindex $jump_to_here 0] eq $fname} {
-	set targetline [lindex $jump_to_here 1]
+        set targetline [lindex $jump_to_here 1]
     }
     set diffline 0
 }
@@ -8102,7 +8102,7 @@ proc makediffhdr {fname ids} {
 proc blobdiffmaybeseehere {ateof} {
     global diffseehere
     if {$diffseehere >= 0} {
-	mark_ctext_line [lindex [split $diffseehere .] 0]
+        mark_ctext_line [lindex [split $diffseehere .] 0]
     }
     maybe_scroll_ctext $ateof
 }
@@ -8114,22 +8114,22 @@ proc getblobdiffline {bdf ids} {
     set nr 0
     $ctext conf -state normal
     while {[incr nr] <= 1000 && [gets $bdf line] >= 0} {
-	if {$ids != $diffids || $bdf != $blobdifffd($ids)} {
-	    # Older diff read. Abort it.
-	    catch {close $bdf}
-	    if {$ids != $diffids} {
-		array unset blobdifffd $ids
-	    }
-	    return 0
-	}
-	parseblobdiffline $ids $line
+        if {$ids != $diffids || $bdf != $blobdifffd($ids)} {
+            # Older diff read. Abort it.
+            catch {close $bdf}
+            if {$ids != $diffids} {
+                array unset blobdifffd $ids
+            }
+            return 0
+        }
+        parseblobdiffline $ids $line
     }
     $ctext conf -state disabled
     blobdiffmaybeseehere [eof $bdf]
     if {[eof $bdf]} {
-	catch {close $bdf}
-	array unset blobdifffd $ids
-	return 0
+        catch {close $bdf}
+        array unset blobdifffd $ids
+        return 0
     }
     return [expr {$nr >= 1000? 2: 1}]
 }
@@ -8143,199 +8143,199 @@ proc parseblobdiffline {ids line} {
     global worddiff diffseehere
 
     if {![string compare -length 5 "diff " $line]} {
-	if {![regexp {^diff (--cc|--git) } $line m type]} {
-	    set line [encoding convertfrom $line]
-	    $ctext insert end "$line\n" hunksep
-	    continue
-	}
-	# start of a new file
-	set diffinhdr 1
-	set currdiffsubmod ""
+        if {![regexp {^diff (--cc|--git) } $line m type]} {
+            set line [encoding convertfrom $line]
+            $ctext insert end "$line\n" hunksep
+            continue
+        }
+        # start of a new file
+        set diffinhdr 1
+        set currdiffsubmod ""
 
-	$ctext insert end "\n"
-	set curdiffstart [$ctext index "end - 1c"]
-	lappend ctext_file_names ""
-	lappend ctext_file_lines [lindex [split $curdiffstart "."] 0]
-	$ctext insert end "\n" filesep
+        $ctext insert end "\n"
+        set curdiffstart [$ctext index "end - 1c"]
+        lappend ctext_file_names ""
+        lappend ctext_file_lines [lindex [split $curdiffstart "."] 0]
+        $ctext insert end "\n" filesep
 
-	if {$type eq "--cc"} {
-	    # start of a new file in a merge diff
-	    set fname [string range $line 10 end]
-	    if {[lsearch -exact $treediffs($ids) $fname] < 0} {
-		lappend treediffs($ids) $fname
-		add_flist [list $fname]
-	    }
+        if {$type eq "--cc"} {
+            # start of a new file in a merge diff
+            set fname [string range $line 10 end]
+            if {[lsearch -exact $treediffs($ids) $fname] < 0} {
+                lappend treediffs($ids) $fname
+                add_flist [list $fname]
+            }
 
-	} else {
-	    set line [string range $line 11 end]
-	    # If the name hasn't changed the length will be odd,
-	    # the middle char will be a space, and the two bits either
-	    # side will be a/name and b/name, or "a/name" and "b/name".
-	    # If the name has changed we'll get "rename from" and
-	    # "rename to" or "copy from" and "copy to" lines following
-	    # this, and we'll use them to get the filenames.
-	    # This complexity is necessary because spaces in the
-	    # filename(s) don't get escaped.
-	    set l [string length $line]
-	    set i [expr {$l / 2}]
-	    if {!(($l & 1) && [string index $line $i] eq " " &&
-		  [string range $line 2 [expr {$i - 1}]] eq \
-		      [string range $line [expr {$i + 3}] end])} {
-		return
-	    }
-	    # unescape if quoted and chop off the a/ from the front
-	    if {[string index $line 0] eq "\""} {
-		set fname [string range [lindex $line 0] 2 end]
-	    } else {
-		set fname [string range $line 2 [expr {$i - 1}]]
-	    }
-	}
-	makediffhdr $fname $ids
+        } else {
+            set line [string range $line 11 end]
+            # If the name hasn't changed the length will be odd,
+            # the middle char will be a space, and the two bits either
+            # side will be a/name and b/name, or "a/name" and "b/name".
+            # If the name has changed we'll get "rename from" and
+            # "rename to" or "copy from" and "copy to" lines following
+            # this, and we'll use them to get the filenames.
+            # This complexity is necessary because spaces in the
+            # filename(s) don't get escaped.
+            set l [string length $line]
+            set i [expr {$l / 2}]
+            if {!(($l & 1) && [string index $line $i] eq " " &&
+                  [string range $line 2 [expr {$i - 1}]] eq \
+                      [string range $line [expr {$i + 3}] end])} {
+                return
+            }
+            # unescape if quoted and chop off the a/ from the front
+            if {[string index $line 0] eq "\""} {
+                set fname [string range [lindex $line 0] 2 end]
+            } else {
+                set fname [string range $line 2 [expr {$i - 1}]]
+            }
+        }
+        makediffhdr $fname $ids
 
     } elseif {![string compare -length 16 "* Unmerged path " $line]} {
-	set fname [encoding convertfrom [string range $line 16 end]]
-	$ctext insert end "\n"
-	set curdiffstart [$ctext index "end - 1c"]
-	lappend ctext_file_names $fname
-	lappend ctext_file_lines [lindex [split $curdiffstart "."] 0]
-	$ctext insert end "$line\n" filesep
-	set i [lsearch -exact $treediffs($ids) $fname]
-	if {$i >= 0} {
-	    setinlist difffilestart $i $curdiffstart
-	}
+        set fname [encoding convertfrom [string range $line 16 end]]
+        $ctext insert end "\n"
+        set curdiffstart [$ctext index "end - 1c"]
+        lappend ctext_file_names $fname
+        lappend ctext_file_lines [lindex [split $curdiffstart "."] 0]
+        $ctext insert end "$line\n" filesep
+        set i [lsearch -exact $treediffs($ids) $fname]
+        if {$i >= 0} {
+            setinlist difffilestart $i $curdiffstart
+        }
 
     } elseif {![string compare -length 2 "@@" $line]} {
-	regexp {^@@+} $line ats
-	set line [encoding convertfrom $diffencoding $line]
-	$ctext insert end "$line\n" hunksep
-	if {[regexp { \+(\d+),\d+ @@} $line m nl]} {
-	    set diffline $nl
-	}
-	set diffnparents [expr {[string length $ats] - 1}]
-	set diffinhdr 0
+        regexp {^@@+} $line ats
+        set line [encoding convertfrom $diffencoding $line]
+        $ctext insert end "$line\n" hunksep
+        if {[regexp { \+(\d+),\d+ @@} $line m nl]} {
+            set diffline $nl
+        }
+        set diffnparents [expr {[string length $ats] - 1}]
+        set diffinhdr 0
 
     } elseif {![string compare -length 10 "Submodule " $line]} {
-	# start of a new submodule
-	if {[regexp -indices "\[0-9a-f\]+\\.\\." $line nameend]} {
-	    set fname [string range $line 10 [expr [lindex $nameend 0] - 2]]
-	} else {
-	    set fname [string range $line 10 [expr [string first "contains " $line] - 2]]
-	}
-	if {$currdiffsubmod != $fname} {
-	    $ctext insert end "\n";     # Add newline after commit message
-	}
-	set curdiffstart [$ctext index "end - 1c"]
-	lappend ctext_file_names ""
-	if {$currdiffsubmod != $fname} {
-	    lappend ctext_file_lines $fname
-	    makediffhdr $fname $ids
-	    set currdiffsubmod $fname
-	    $ctext insert end "\n$line\n" filesep
-	} else {
-	    $ctext insert end "$line\n" filesep
-	}
+        # start of a new submodule
+        if {[regexp -indices "\[0-9a-f\]+\\.\\." $line nameend]} {
+            set fname [string range $line 10 [expr [lindex $nameend 0] - 2]]
+        } else {
+            set fname [string range $line 10 [expr [string first "contains " $line] - 2]]
+        }
+        if {$currdiffsubmod != $fname} {
+            $ctext insert end "\n";     # Add newline after commit message
+        }
+        set curdiffstart [$ctext index "end - 1c"]
+        lappend ctext_file_names ""
+        if {$currdiffsubmod != $fname} {
+            lappend ctext_file_lines $fname
+            makediffhdr $fname $ids
+            set currdiffsubmod $fname
+            $ctext insert end "\n$line\n" filesep
+        } else {
+            $ctext insert end "$line\n" filesep
+        }
     } elseif {$currdiffsubmod != "" && ![string compare -length 3 "  >" $line]} {
-	set line [encoding convertfrom $diffencoding $line]
-	$ctext insert end "$line\n" dresult
+        set line [encoding convertfrom $diffencoding $line]
+        $ctext insert end "$line\n" dresult
     } elseif {$currdiffsubmod != "" && ![string compare -length 3 "  <" $line]} {
-	set line [encoding convertfrom $diffencoding $line]
-	$ctext insert end "$line\n" d0
+        set line [encoding convertfrom $diffencoding $line]
+        $ctext insert end "$line\n" d0
     } elseif {$diffinhdr} {
-	if {![string compare -length 12 "rename from " $line]} {
-	    set fname [string range $line [expr 6 + [string first " from " $line] ] end]
-	    if {[string index $fname 0] eq "\""} {
-		set fname [lindex $fname 0]
-	    }
-	    set fname [encoding convertfrom $fname]
-	    set i [lsearch -exact $treediffs($ids) $fname]
-	    if {$i >= 0} {
-		setinlist difffilestart $i $curdiffstart
-	    }
-	} elseif {![string compare -length 10 $line "rename to "] ||
-		  ![string compare -length 8 $line "copy to "]} {
-	    set fname [string range $line [expr 4 + [string first " to " $line] ] end]
-	    if {[string index $fname 0] eq "\""} {
-		set fname [lindex $fname 0]
-	    }
-	    makediffhdr $fname $ids
-	} elseif {[string compare -length 3 $line "---"] == 0} {
-	    # do nothing
-	    return
-	} elseif {[string compare -length 3 $line "+++"] == 0} {
-	    set diffinhdr 0
-	    return
-	}
-	$ctext insert end "$line\n" filesep
+        if {![string compare -length 12 "rename from " $line]} {
+            set fname [string range $line [expr 6 + [string first " from " $line] ] end]
+            if {[string index $fname 0] eq "\""} {
+                set fname [lindex $fname 0]
+            }
+            set fname [encoding convertfrom $fname]
+            set i [lsearch -exact $treediffs($ids) $fname]
+            if {$i >= 0} {
+                setinlist difffilestart $i $curdiffstart
+            }
+        } elseif {![string compare -length 10 $line "rename to "] ||
+                  ![string compare -length 8 $line "copy to "]} {
+            set fname [string range $line [expr 4 + [string first " to " $line] ] end]
+            if {[string index $fname 0] eq "\""} {
+                set fname [lindex $fname 0]
+            }
+            makediffhdr $fname $ids
+        } elseif {[string compare -length 3 $line "---"] == 0} {
+            # do nothing
+            return
+        } elseif {[string compare -length 3 $line "+++"] == 0} {
+            set diffinhdr 0
+            return
+        }
+        $ctext insert end "$line\n" filesep
 
     } else {
-	set line [string map {\x1A ^Z} \
-		      [encoding convertfrom $diffencoding $line]]
-	# parse the prefix - one ' ', '-' or '+' for each parent
-	set prefix [string range $line 0 [expr {$diffnparents - 1}]]
-	set tag [expr {$diffnparents > 1? "m": "d"}]
-	set dowords [expr {$worddiff ne [mc "Line diff"] && $diffnparents == 1}]
-	set words_pre_markup ""
-	set words_post_markup ""
-	if {[string trim $prefix " -+"] eq {}} {
-	    # prefix only has " ", "-" and "+" in it: normal diff line
-	    set num [string first "-" $prefix]
-	    if {$dowords} {
-		set line [string range $line 1 end]
-	    }
-	    if {$num >= 0} {
-		# removed line, first parent with line is $num
-		if {$num >= $mergemax} {
-		    set num "max"
-		}
-		if {$dowords && $worddiff eq [mc "Markup words"]} {
-		    $ctext insert end "\[-$line-\]" $tag$num
-		} else {
-		    $ctext insert end "$line" $tag$num
-		}
-		if {!$dowords} {
-		    $ctext insert end "\n" $tag$num
-		}
-	    } else {
-		set tags {}
-		if {[string first "+" $prefix] >= 0} {
-		    # added line
-		    lappend tags ${tag}result
-		    if {$diffnparents > 1} {
-			set num [string first " " $prefix]
-			if {$num >= 0} {
-			    if {$num >= $mergemax} {
-				set num "max"
-			    }
-			    lappend tags m$num
-			}
-		    }
-		    set words_pre_markup "{+"
-		    set words_post_markup "+}"
-		}
-		if {$targetline ne {}} {
-		    if {$diffline == $targetline} {
-			set diffseehere [$ctext index "end - 1 chars"]
-			set targetline {}
-		    } else {
-			incr diffline
-		    }
-		}
-		if {$dowords && $worddiff eq [mc "Markup words"]} {
-		    $ctext insert end "$words_pre_markup$line$words_post_markup" $tags
-		} else {
-		    $ctext insert end "$line" $tags
-		}
-		if {!$dowords} {
-		    $ctext insert end "\n" $tags
-		}
-	    }
-	} elseif {$dowords && $prefix eq "~"} {
-	    $ctext insert end "\n" {}
-	} else {
-	    # "\ No newline at end of file",
-	    # or something else we don't recognize
-	    $ctext insert end "$line\n" hunksep
-	}
+        set line [string map {\x1A ^Z} \
+                      [encoding convertfrom $diffencoding $line]]
+        # parse the prefix - one ' ', '-' or '+' for each parent
+        set prefix [string range $line 0 [expr {$diffnparents - 1}]]
+        set tag [expr {$diffnparents > 1? "m": "d"}]
+        set dowords [expr {$worddiff ne [mc "Line diff"] && $diffnparents == 1}]
+        set words_pre_markup ""
+        set words_post_markup ""
+        if {[string trim $prefix " -+"] eq {}} {
+            # prefix only has " ", "-" and "+" in it: normal diff line
+            set num [string first "-" $prefix]
+            if {$dowords} {
+                set line [string range $line 1 end]
+            }
+            if {$num >= 0} {
+                # removed line, first parent with line is $num
+                if {$num >= $mergemax} {
+                    set num "max"
+                }
+                if {$dowords && $worddiff eq [mc "Markup words"]} {
+                    $ctext insert end "\[-$line-\]" $tag$num
+                } else {
+                    $ctext insert end "$line" $tag$num
+                }
+                if {!$dowords} {
+                    $ctext insert end "\n" $tag$num
+                }
+            } else {
+                set tags {}
+                if {[string first "+" $prefix] >= 0} {
+                    # added line
+                    lappend tags ${tag}result
+                    if {$diffnparents > 1} {
+                        set num [string first " " $prefix]
+                        if {$num >= 0} {
+                            if {$num >= $mergemax} {
+                                set num "max"
+                            }
+                            lappend tags m$num
+                        }
+                    }
+                    set words_pre_markup "{+"
+                    set words_post_markup "+}"
+                }
+                if {$targetline ne {}} {
+                    if {$diffline == $targetline} {
+                        set diffseehere [$ctext index "end - 1 chars"]
+                        set targetline {}
+                    } else {
+                        incr diffline
+                    }
+                }
+                if {$dowords && $worddiff eq [mc "Markup words"]} {
+                    $ctext insert end "$words_pre_markup$line$words_post_markup" $tags
+                } else {
+                    $ctext insert end "$line" $tags
+                }
+                if {!$dowords} {
+                    $ctext insert end "\n" $tags
+                }
+            }
+        } elseif {$dowords && $prefix eq "~"} {
+            $ctext insert end "\n" {}
+        } else {
+            # "\ No newline at end of file",
+            # or something else we don't recognize
+            $ctext insert end "$line\n" hunksep
+        }
     }
 }
 
@@ -8365,9 +8365,9 @@ proc highlightfile_for_scrollpos {topidx} {
 
     set top [lindex [split $topidx .] 0]
     if {$difffilestart eq {} || $top < [lindex $difffilestart 0]} {
-	highlightfile 0
+        highlightfile 0
     } else {
-	highlightfile [expr {[bsearch $difffilestart $top] + 2}]
+        highlightfile [expr {[bsearch $difffilestart $top] + 2}]
     }
 }
 
@@ -8378,11 +8378,11 @@ proc prevfile {} {
     set prev 0.0
     set here [$ctext index @0,0]
     foreach loc $difffilestart {
-	if {[$ctext compare $loc >= $here]} {
-	    $ctext yview $prev
-	    return
-	}
-	set prev $loc
+        if {[$ctext compare $loc >= $here]} {
+            $ctext yview $prev
+            return
+        }
+        set prev $loc
     }
     $ctext yview $prev
 }
@@ -8393,10 +8393,10 @@ proc nextfile {} {
     if {$cmitmode eq "tree"} return
     set here [$ctext index @0,0]
     foreach loc $difffilestart {
-	if {[$ctext compare $loc > $here]} {
-	    $ctext yview $loc
-	    return
-	}
+        if {[$ctext compare $loc > $here]} {
+            $ctext yview $loc
+            return
+        }
     }
 }
 
@@ -8407,14 +8407,14 @@ proc clear_ctext {{first 1.0}} {
 
     set l [lindex [split $first .] 0]
     if {![info exists smarktop] || [$ctext compare $first < $smarktop.0]} {
-	set smarktop $l
+        set smarktop $l
     }
     if {![info exists smarkbot] || [$ctext compare $first < $smarkbot.0]} {
-	set smarkbot $l
+        set smarkbot $l
     }
     $ctext delete $first end
     if {$first eq "1.0"} {
-	unset -nocomplain pendinglinks
+        unset -nocomplain pendinglinks
     }
     set ctext_file_names {}
     set ctext_file_lines {}
@@ -8424,16 +8424,16 @@ proc settabs {{firstab {}}} {
     global firsttabstop tabstop ctext have_tk85
 
     if {$firstab ne {} && $have_tk85} {
-	set firsttabstop $firstab
+        set firsttabstop $firstab
     }
     set w [font measure textfont "0"]
     if {$firsttabstop != 0} {
-	$ctext conf -tabs [list [expr {($firsttabstop + $tabstop) * $w}] \
-			       [expr {($firsttabstop + 2 * $tabstop) * $w}]]
+        $ctext conf -tabs [list [expr {($firsttabstop + $tabstop) * $w}] \
+                               [expr {($firsttabstop + 2 * $tabstop) * $w}]]
     } elseif {$have_tk85 || $tabstop != 8} {
-	$ctext conf -tabs [expr {$tabstop * $w}]
+        $ctext conf -tabs [expr {$tabstop * $w}]
     } else {
-	$ctext conf -tabs {}
+        $ctext conf -tabs {}
     }
 }
 
@@ -8441,26 +8441,26 @@ proc incrsearch {name ix op} {
     global ctext searchstring searchdirn
 
     if {[catch {$ctext index anchor}]} {
-	# no anchor set, use start of selection, or of visible area
-	set sel [$ctext tag ranges sel]
-	if {$sel ne {}} {
-	    $ctext mark set anchor [lindex $sel 0]
-	} elseif {$searchdirn eq "-forwards"} {
-	    $ctext mark set anchor @0,0
-	} else {
-	    $ctext mark set anchor @0,[winfo height $ctext]
-	}
+        # no anchor set, use start of selection, or of visible area
+        set sel [$ctext tag ranges sel]
+        if {$sel ne {}} {
+            $ctext mark set anchor [lindex $sel 0]
+        } elseif {$searchdirn eq "-forwards"} {
+            $ctext mark set anchor @0,0
+        } else {
+            $ctext mark set anchor @0,[winfo height $ctext]
+        }
     }
     if {$searchstring ne {}} {
-	set here [$ctext search -count mlen $searchdirn -- $searchstring anchor]
-	if {$here ne {}} {
-	    $ctext see $here
-	    set mend "$here + $mlen c"
-	    $ctext tag remove sel 1.0 end
-	    $ctext tag add sel $here $mend
-	    suppress_highlighting_file_for_current_scrollpos
-	    highlightfile_for_scrollpos $here
-	}
+        set here [$ctext search -count mlen $searchdirn -- $searchstring anchor]
+        if {$here ne {}} {
+            $ctext see $here
+            set mend "$here + $mlen c"
+            $ctext tag remove sel 1.0 end
+            $ctext tag add sel $here $mend
+            suppress_highlighting_file_for_current_scrollpos
+            highlightfile_for_scrollpos $here
+        }
     }
     rehighlight_search_results
 }
@@ -8472,25 +8472,25 @@ proc dosearch {} {
     $sstring icursor end
     set searchdirn -forwards
     if {$searchstring ne {}} {
-	set sel [$ctext tag ranges sel]
-	if {$sel ne {}} {
-	    set start "[lindex $sel 0] + 1c"
-	} elseif {[catch {set start [$ctext index anchor]}]} {
-	    set start "@0,0"
-	}
-	set match [$ctext search -count mlen -- $searchstring $start]
-	$ctext tag remove sel 1.0 end
-	if {$match eq {}} {
-	    bell
-	    return
-	}
-	$ctext see $match
-	suppress_highlighting_file_for_current_scrollpos
-	highlightfile_for_scrollpos $match
-	set mend "$match + $mlen c"
-	$ctext tag add sel $match $mend
-	$ctext mark unset anchor
-	rehighlight_search_results
+        set sel [$ctext tag ranges sel]
+        if {$sel ne {}} {
+            set start "[lindex $sel 0] + 1c"
+        } elseif {[catch {set start [$ctext index anchor]}]} {
+            set start "@0,0"
+        }
+        set match [$ctext search -count mlen -- $searchstring $start]
+        $ctext tag remove sel 1.0 end
+        if {$match eq {}} {
+            bell
+            return
+        }
+        $ctext see $match
+        suppress_highlighting_file_for_current_scrollpos
+        highlightfile_for_scrollpos $match
+        set mend "$match + $mlen c"
+        $ctext tag add sel $match $mend
+        $ctext mark unset anchor
+        rehighlight_search_results
     }
 }
 
@@ -8501,25 +8501,25 @@ proc dosearchback {} {
     $sstring icursor end
     set searchdirn -backwards
     if {$searchstring ne {}} {
-	set sel [$ctext tag ranges sel]
-	if {$sel ne {}} {
-	    set start [lindex $sel 0]
-	} elseif {[catch {set start [$ctext index anchor]}]} {
-	    set start @0,[winfo height $ctext]
-	}
-	set match [$ctext search -backwards -count ml -- $searchstring $start]
-	$ctext tag remove sel 1.0 end
-	if {$match eq {}} {
-	    bell
-	    return
-	}
-	$ctext see $match
-	suppress_highlighting_file_for_current_scrollpos
-	highlightfile_for_scrollpos $match
-	set mend "$match + $ml c"
-	$ctext tag add sel $match $mend
-	$ctext mark unset anchor
-	rehighlight_search_results
+        set sel [$ctext tag ranges sel]
+        if {$sel ne {}} {
+            set start [lindex $sel 0]
+        } elseif {[catch {set start [$ctext index anchor]}]} {
+            set start @0,[winfo height $ctext]
+        }
+        set match [$ctext search -backwards -count ml -- $searchstring $start]
+        $ctext tag remove sel 1.0 end
+        if {$match eq {}} {
+            bell
+            return
+        }
+        $ctext see $match
+        suppress_highlighting_file_for_current_scrollpos
+        highlightfile_for_scrollpos $match
+        set mend "$match + $ml c"
+        $ctext tag add sel $match $mend
+        $ctext mark unset anchor
+        rehighlight_search_results
     }
 }
 
@@ -8530,7 +8530,7 @@ proc rehighlight_search_results {} {
     $ctext tag remove currentsearchhit 1.0 end
 
     if {$searchstring ne {}} {
-	searchmarkvisible 1
+        searchmarkvisible 1
     }
 }
 
@@ -8541,14 +8541,14 @@ proc searchmark {first last} {
 
     set mend $first.0
     while {1} {
-	set match [$ctext search -count mlen -- $searchstring $mend $last.end]
-	if {$match eq {}} break
-	set mend "$match + $mlen c"
-	if {$sel ne {} && [$ctext compare $match == [lindex $sel 0]]} {
-	    $ctext tag add currentsearchhit $match $mend
-	} else {
-	    $ctext tag add found $match $mend
-	}
+        set match [$ctext search -count mlen -- $searchstring $mend $last.end]
+        if {$match eq {}} break
+        set mend "$match + $mlen c"
+        if {$sel ne {} && [$ctext compare $match == [lindex $sel 0]]} {
+            $ctext tag add currentsearchhit $match $mend
+        } else {
+            $ctext tag add found $match $mend
+        }
     }
 }
 
@@ -8558,19 +8558,19 @@ proc searchmarkvisible {doall} {
     set topline [lindex [split [$ctext index @0,0] .] 0]
     set botline [lindex [split [$ctext index @0,[winfo height $ctext]] .] 0]
     if {$doall || $botline < $smarktop || $topline > $smarkbot} {
-	# no overlap with previous
-	searchmark $topline $botline
-	set smarktop $topline
-	set smarkbot $botline
+        # no overlap with previous
+        searchmark $topline $botline
+        set smarktop $topline
+        set smarkbot $botline
     } else {
-	if {$topline < $smarktop} {
-	    searchmark $topline [expr {$smarktop-1}]
-	    set smarktop $topline
-	}
-	if {$botline > $smarkbot} {
-	    searchmark [expr {$smarkbot+1}] $botline
-	    set smarkbot $botline
-	}
+        if {$topline < $smarktop} {
+            searchmark $topline [expr {$smarktop-1}]
+            set smarktop $topline
+        }
+        if {$botline > $smarkbot} {
+            searchmark [expr {$smarkbot+1}] $botline
+            set smarkbot $botline
+        }
     }
 }
 
@@ -8586,15 +8586,15 @@ proc scrolltext {f0 f1} {
 
     set topidx [$ctext index @0,0]
     if {![info exists suppress_highlighting_file_for_this_scrollpos]
-	|| $topidx ne $suppress_highlighting_file_for_this_scrollpos} {
-	highlightfile_for_scrollpos $topidx
+        || $topidx ne $suppress_highlighting_file_for_this_scrollpos} {
+        highlightfile_for_scrollpos $topidx
     }
 
     unset -nocomplain suppress_highlighting_file_for_this_scrollpos
 
     .bleft.bottom.sb set $f0 $f1
     if {$searchstring ne {}} {
-	searchmarkvisible 0
+        searchmarkvisible 0
     }
 }
 
@@ -8623,8 +8623,8 @@ proc redisplay {} {
     allcanvs yview moveto [lindex $span 0]
     drawvisible
     if {$selectedline ne {}} {
-	selectline $selectedline 0
-	allcanvs yview moveto [lindex $span 0]
+        selectline $selectedline 0
+        allcanvs yview moveto [lindex $span 0]
     }
 }
 
@@ -8634,20 +8634,20 @@ proc parsefont {f n} {
     set fontattr($f,family) [lindex $n 0]
     set s [lindex $n 1]
     if {$s eq {} || $s == 0} {
-	set s 10
+        set s 10
     } elseif {$s < 0} {
-	set s [expr {int(-$s / [winfo fpixels . 1p] + 0.5)}]
+        set s [expr {int(-$s / [winfo fpixels . 1p] + 0.5)}]
     }
     set fontattr($f,size) $s
     set fontattr($f,weight) normal
     set fontattr($f,slant) roman
     foreach style [lrange $n 2 end] {
-	switch -- $style {
-	    "normal" -
-	    "bold"   {set fontattr($f,weight) $style}
-	    "roman" -
-	    "italic" {set fontattr($f,slant) $style}
-	}
+        switch -- $style {
+            "normal" -
+            "bold"   {set fontattr($f,weight) $style}
+            "roman" -
+            "italic" {set fontattr($f,slant) $style}
+        }
     }
 }
 
@@ -8655,8 +8655,8 @@ proc fontflags {f {isbold 0}} {
     global fontattr
 
     return [list -family $fontattr($f,family) -size $fontattr($f,size) \
-		-weight [expr {$isbold? "bold": $fontattr($f,weight)}] \
-		-slant $fontattr($f,slant)]
+                -weight [expr {$isbold? "bold": $fontattr($f,weight)}] \
+                -slant $fontattr($f,slant)]
 }
 
 proc fontname {f} {
@@ -8664,10 +8664,10 @@ proc fontname {f} {
 
     set n [list $fontattr($f,family) $fontattr($f,size)]
     if {$fontattr($f,weight) eq "bold"} {
-	lappend n "bold"
+        lappend n "bold"
     }
     if {$fontattr($f,slant) eq "italic"} {
-	lappend n "italic"
+        lappend n "italic"
     }
     return $n
 }
@@ -8680,7 +8680,7 @@ proc incrfont {inc} {
     set s $fontattr(mainfont,size)
     incr s $inc
     if {$s < 1} {
-	set s 1
+        set s 1
     }
     set fontattr(mainfont,size) $s
     font config mainfont -size $s
@@ -8689,7 +8689,7 @@ proc incrfont {inc} {
     set s $fontattr(textfont,size)
     incr s $inc
     if {$s < 1} {
-	set s 1
+        set s 1
     }
     set fontattr(textfont,size) $s
     font config textfont -size $s
@@ -8703,23 +8703,23 @@ proc incrfont {inc} {
 proc clearsha1 {} {
     global sha1entry sha1string
     if {[string length $sha1string] == 40} {
-	$sha1entry delete 0 end
+        $sha1entry delete 0 end
     }
 }
 
 proc sha1change {n1 n2 op} {
     global sha1string currentid sha1but
     if {$sha1string == {}
-	|| ([info exists currentid] && $sha1string == $currentid)} {
-	set state disabled
+        || ([info exists currentid] && $sha1string == $currentid)} {
+        set state disabled
     } else {
-	set state normal
+        set state normal
     }
     if {[$sha1but cget -state] == $state} return
     if {$state == "normal"} {
-	$sha1but conf -state normal -relief raised -text "[mc "Goto:"] "
+        $sha1but conf -state normal -relief raised -text "[mc "Goto:"] "
     } else {
-	$sha1but conf -state disabled -relief flat -text "[mc "SHA1 ID:"] "
+        $sha1but conf -state disabled -relief flat -text "[mc "SHA1 ID:"] "
     }
 }
 
@@ -8727,37 +8727,37 @@ proc gotocommit {} {
     global sha1string tagids headids curview varcid
 
     if {$sha1string == {}
-	|| ([info exists currentid] && $sha1string == $currentid)} return
+        || ([info exists currentid] && $sha1string == $currentid)} return
     if {[info exists tagids($sha1string)]} {
-	set id $tagids($sha1string)
+        set id $tagids($sha1string)
     } elseif {[info exists headids($sha1string)]} {
-	set id $headids($sha1string)
+        set id $headids($sha1string)
     } else {
-	set id [string tolower $sha1string]
-	if {[regexp {^[0-9a-f]{4,39}$} $id]} {
-	    set matches [longid $id]
-	    if {$matches ne {}} {
-		if {[llength $matches] > 1} {
-		    error_popup [mc "Short SHA1 id %s is ambiguous" $id]
-		    return
-		}
-		set id [lindex $matches 0]
-	    }
-	} else {
-	    if {[catch {set id [exec git rev-parse --verify $sha1string]}]} {
-		error_popup [mc "Revision %s is not known" $sha1string]
-		return
-	    }
-	}
+        set id [string tolower $sha1string]
+        if {[regexp {^[0-9a-f]{4,39}$} $id]} {
+            set matches [longid $id]
+            if {$matches ne {}} {
+                if {[llength $matches] > 1} {
+                    error_popup [mc "Short SHA1 id %s is ambiguous" $id]
+                    return
+                }
+                set id [lindex $matches 0]
+            }
+        } else {
+            if {[catch {set id [exec git rev-parse --verify $sha1string]}]} {
+                error_popup [mc "Revision %s is not known" $sha1string]
+                return
+            }
+        }
     }
     if {[commitinview $id $curview]} {
-	selectline [rowofcommit $id] 1
-	return
+        selectline [rowofcommit $id] 1
+        return
     }
     if {[regexp {^[0-9a-fA-F]{4,}$} $sha1string]} {
-	set msg [mc "SHA1 id %s is not known" $sha1string]
+        set msg [mc "SHA1 id %s is not known" $sha1string]
     } else {
-	set msg [mc "Revision %s is not in the current view" $sha1string]
+        set msg [mc "Revision %s is not in the current view" $sha1string]
     }
     error_popup $msg
 }
@@ -8771,7 +8771,7 @@ proc lineenter {x y id} {
     set hovery $y
     set hoverid $id
     if {[info exists hovertimer]} {
-	after cancel $hovertimer
+        after cancel $hovertimer
     }
     set hovertimer [after 500 linehover]
     $canv delete hover
@@ -8781,12 +8781,12 @@ proc linemotion {x y id} {
     global hoverx hovery hoverid hovertimer
 
     if {[info exists hoverid] && $id == $hoverid} {
-	set hoverx $x
-	set hovery $y
-	if {[info exists hovertimer]} {
-	    after cancel $hovertimer
-	}
-	set hovertimer [after 500 linehover]
+        set hoverx $x
+        set hovery $y
+        if {[info exists hovertimer]} {
+            after cancel $hovertimer
+        }
+        set hovertimer [after 500 linehover]
     }
 }
 
@@ -8794,12 +8794,12 @@ proc lineleave {id} {
     global hoverid hovertimer canv
 
     if {[info exists hoverid] && $id == $hoverid} {
-	$canv delete hover
-	if {[info exists hovertimer]} {
-	    after cancel $hovertimer
-	    unset hovertimer
-	}
-	unset hoverid
+        $canv delete hover
+        if {[info exists hovertimer]} {
+            after cancel $hovertimer
+            unset hovertimer
+        }
+        unset hoverid
     }
 }
 
@@ -8821,11 +8821,11 @@ proc linehover {} {
     set x1 [expr {$x + [font measure mainfont $text] + 2 * $lthickness}]
     set y1 [expr {$y + $linespc + 2 * $lthickness}]
     set t [$canv create rectangle $x0 $y0 $x1 $y1 \
-	       -fill $linehoverbgcolor -outline $linehoveroutlinecolor \
-	       -width 1 -tags hover]
+               -fill $linehoverbgcolor -outline $linehoveroutlinecolor \
+               -width 1 -tags hover]
     $canv raise $t
     set t [$canv create text $x $y -anchor nw -text $text -tags hover \
-	       -font mainfont -fill $linehoverfgcolor]
+               -font mainfont -fill $linehoverfgcolor]
     $canv raise $t
 }
 
@@ -8836,10 +8836,10 @@ proc clickisonarrow {id y} {
     set thresh [expr {2 * $lthickness + 6}]
     set n [expr {[llength $ranges] - 1}]
     for {set i 1} {$i < $n} {incr i} {
-	set row [lindex $ranges $i]
-	if {abs([yc $row] - $y) < $thresh} {
-	    return $i
-	}
+        set row [lindex $ranges $i]
+        if {abs([yc $row] - $y) < $thresh} {
+            return $i
+        }
     }
     return {}
 }
@@ -8857,7 +8857,7 @@ proc arrowjump {id n y} {
     set yspan [expr {[lindex $view 1] - [lindex $view 0]}]
     set yfrac [expr {$yt / $ymax - $yspan / 2}]
     if {$yfrac < 0} {
-	set yfrac 0
+        set yfrac 0
     }
     allcanvs yview moveto $yfrac
 }
@@ -8874,19 +8874,19 @@ proc lineclick {x y id isnew} {
     set thickerline $id
     drawlines $id
     if {$isnew} {
-	set ymax [lindex [$canv cget -scrollregion] 3]
-	if {$ymax eq {}} return
-	set yfrac [lindex [$canv yview] 0]
-	set y [expr {$y + $yfrac * $ymax}]
+        set ymax [lindex [$canv cget -scrollregion] 3]
+        if {$ymax eq {}} return
+        set yfrac [lindex [$canv yview] 0]
+        set y [expr {$y + $yfrac * $ymax}]
     }
     set dirn [clickisonarrow $id $y]
     if {$dirn ne {}} {
-	arrowjump $id $dirn $y
-	return
+        arrowjump $id $dirn $y
+        return
     }
 
     if {$isnew} {
-	addtohistory [list lineclick $x $y $id 0] savectextpos
+        addtohistory [list lineclick $x $y $id 0] savectextpos
     }
     # fill the details pane with info about this line
     $ctext conf -state normal
@@ -8902,20 +8902,20 @@ proc lineclick {x y id isnew} {
     $ctext insert end "\t[mc "Date"]:\t$date\n"
     set kids $children($curview,$id)
     if {$kids ne {}} {
-	$ctext insert end "\n[mc "Children"]:"
-	set i 0
-	foreach child $kids {
-	    incr i
-	    if {![info exists commitinfo($child)] && ![getcommit $child]} continue
-	    set info $commitinfo($child)
-	    $ctext insert end "\n\t"
-	    $ctext insert end $child link$i
-	    setlink $child link$i
-	    $ctext insert end "\n\t[lindex $info 0]"
-	    $ctext insert end "\n\t[mc "Author"]:\t[lindex $info 1]"
-	    set date [formatdate [lindex $info 2]]
-	    $ctext insert end "\n\t[mc "Date"]:\t$date\n"
-	}
+        $ctext insert end "\n[mc "Children"]:"
+        set i 0
+        foreach child $kids {
+            incr i
+            if {![info exists commitinfo($child)] && ![getcommit $child]} continue
+            set info $commitinfo($child)
+            $ctext insert end "\n\t"
+            $ctext insert end $child link$i
+            setlink $child link$i
+            $ctext insert end "\n\t[lindex $info 0]"
+            $ctext insert end "\n\t[mc "Author"]:\t[lindex $info 1]"
+            set date [formatdate [lindex $info 2]]
+            $ctext insert end "\n\t[mc "Date"]:\t$date\n"
+        }
     }
     maybe_scroll_ctext 1
     $ctext conf -state disabled
@@ -8925,23 +8925,23 @@ proc lineclick {x y id isnew} {
 proc normalline {} {
     global thickerline
     if {[info exists thickerline]} {
-	set id $thickerline
-	unset thickerline
-	drawlines $id
+        set id $thickerline
+        unset thickerline
+        drawlines $id
     }
 }
 
 proc selbyid {id {isnew 1}} {
     global curview
     if {[commitinview $id $curview]} {
-	selectline [rowofcommit $id] $isnew
+        selectline [rowofcommit $id] $isnew
     }
 }
 
 proc mstime {} {
     global startmstime
     if {![info exists startmstime]} {
-	set startmstime [clock clicks -milliseconds]
+        set startmstime [clock clicks -milliseconds]
     }
     return [format "%.3f" [expr {([clock click -milliseconds] - $startmstime) / 1000.0}]]
 }
@@ -8953,27 +8953,27 @@ proc rowmenu {x y id} {
     stopfinding
     set rowmenuid $id
     if {$selectedline eq {} || [rowofcommit $id] eq $selectedline} {
-	set state disabled
+        set state disabled
     } else {
-	set state normal
+        set state normal
     }
     if {[info exists markedid] && $markedid ne $id} {
-	set mstate normal
+        set mstate normal
     } else {
-	set mstate disabled
+        set mstate disabled
     }
     if {$id ne $nullid && $id ne $nullid2} {
-	set menu $rowctxmenu
-	if {$mainhead ne {}} {
-	    $menu entryconfigure 8 -label [mc "Reset %s branch to here" $mainhead] -state normal
-	} else {
-	    $menu entryconfigure 8 -label [mc "Detached head: can't reset" $mainhead] -state disabled
-	}
-	$menu entryconfigure 10 -state $mstate
-	$menu entryconfigure 11 -state $mstate
-	$menu entryconfigure 12 -state $mstate
+        set menu $rowctxmenu
+        if {$mainhead ne {}} {
+            $menu entryconfigure 8 -label [mc "Reset %s branch to here" $mainhead] -state normal
+        } else {
+            $menu entryconfigure 8 -label [mc "Detached head: can't reset" $mainhead] -state disabled
+        }
+        $menu entryconfigure 10 -state $mstate
+        $menu entryconfigure 11 -state $mstate
+        $menu entryconfigure 12 -state $mstate
     } else {
-	set menu $fakerowmenu
+        set menu $fakerowmenu
     }
     $menu entryconfigure [mca "Diff this -> selected"] -state $state
     $menu entryconfigure [mca "Diff selected -> this"] -state $state
@@ -8994,7 +8994,7 @@ proc gotomark {} {
     global markedid
 
     if {[info exists markedid]} {
-	selbyid $markedid
+        selbyid $markedid
     }
 }
 
@@ -9004,7 +9004,7 @@ proc replace_by_kids {l r} {
     set id [commitonrow $r]
     set l [lreplace $l 0 0]
     foreach kid $children($curview,$id) {
-	lappend l [rowofcommit $kid]
+        lappend l [rowofcommit $kid]
     }
     return [lsort -integer -decreasing -unique $l]
 }
@@ -9014,23 +9014,23 @@ proc find_common_desc {} {
 
     if {![info exists markedid]} return
     if {![commitinview $markedid $curview] ||
-	![commitinview $rowmenuid $curview]} return
+        ![commitinview $rowmenuid $curview]} return
     #set t1 [clock clicks -milliseconds]
     set l1 [list [rowofcommit $markedid]]
     set l2 [list [rowofcommit $rowmenuid]]
     while 1 {
-	set r1 [lindex $l1 0]
-	set r2 [lindex $l2 0]
-	if {$r1 eq {} || $r2 eq {}} break
-	if {$r1 == $r2} {
-	    selectline $r1 1
-	    break
-	}
-	if {$r1 > $r2} {
-	    set l1 [replace_by_kids $l1 $r1]
-	} else {
-	    set l2 [replace_by_kids $l2 $r2]
-	}
+        set r1 [lindex $l1 0]
+        set r2 [lindex $l2 0]
+        if {$r1 eq {} || $r2 eq {}} break
+        if {$r1 == $r2} {
+            selectline $r1 1
+            break
+        }
+        if {$r1 > $r2} {
+            set l1 [replace_by_kids $l1 $r1]
+        } else {
+            set l2 [replace_by_kids $l2 $r2]
+        }
     }
     #set t2 [clock clicks -milliseconds]
     #puts "took [expr {$t2-$t1}]ms"
@@ -9049,15 +9049,15 @@ proc getpatchid {id} {
     global patchids
 
     if {![info exists patchids($id)]} {
-	set cmd [diffcmd [list $id] {-p --root}]
-	# trim off the initial "|"
-	set cmd [lrange $cmd 1 end]
-	if {[catch {
-	    set x [eval exec $cmd | git patch-id]
-	    set patchids($id) [lindex $x 0]
-	}]} {
-	    set patchids($id) "error"
-	}
+        set cmd [diffcmd [list $id] {-p --root}]
+        # trim off the initial "|"
+        set cmd [lrange $cmd 1 end]
+        if {[catch {
+            set x [eval exec $cmd | git patch-id]
+            set patchids($id) [lindex $x 0]
+        }]} {
+            set patchids($id) "error"
+        }
     }
     return $patchids($id)
 }
@@ -9069,75 +9069,75 @@ proc do_cmp_commits {a b} {
     clear_ctext
     init_flist {}
     for {set i 0} {$i < 100} {incr i} {
-	set skipa 0
-	set skipb 0
-	if {[llength $parents($curview,$a)] > 1} {
-	    appendshortlink $a [mc "Skipping merge commit "] "\n"
-	    set skipa 1
-	} else {
-	    set patcha [getpatchid $a]
-	}
-	if {[llength $parents($curview,$b)] > 1} {
-	    appendshortlink $b [mc "Skipping merge commit "] "\n"
-	    set skipb 1
-	} else {
-	    set patchb [getpatchid $b]
-	}
-	if {!$skipa && !$skipb} {
-	    set heada [lindex $commitinfo($a) 0]
-	    set headb [lindex $commitinfo($b) 0]
-	    if {$patcha eq "error"} {
-		appendshortlink $a [mc "Error getting patch ID for "] \
-		    [mc " - stopping\n"]
-		break
-	    }
-	    if {$patchb eq "error"} {
-		appendshortlink $b [mc "Error getting patch ID for "] \
-		    [mc " - stopping\n"]
-		break
-	    }
-	    if {$patcha eq $patchb} {
-		if {$heada eq $headb} {
-		    appendshortlink $a [mc "Commit "]
-		    appendshortlink $b " == " "  $heada\n"
-		} else {
-		    appendshortlink $a [mc "Commit "] "  $heada\n"
-		    appendshortlink $b [mc " is the same patch as\n       "] \
-			"  $headb\n"
-		}
-		set skipa 1
-		set skipb 1
-	    } else {
-		$ctext insert end "\n"
-		appendshortlink $a [mc "Commit "] "  $heada\n"
-		appendshortlink $b [mc " differs from\n       "] \
-		    "  $headb\n"
-		$ctext insert end [mc "Diff of commits:\n\n"]
-		$ctext conf -state disabled
-		update
-		diffcommits $a $b
-		return
-	    }
-	}
-	if {$skipa} {
-	    set kids [real_children $curview,$a]
-	    if {[llength $kids] != 1} {
-		$ctext insert end "\n"
-		appendshortlink $a [mc "Commit "] \
-		    [mc " has %s children - stopping\n" [llength $kids]]
-		break
-	    }
-	    set a [lindex $kids 0]
-	}
-	if {$skipb} {
-	    set kids [real_children $curview,$b]
-	    if {[llength $kids] != 1} {
-		appendshortlink $b [mc "Commit "] \
-		    [mc " has %s children - stopping\n" [llength $kids]]
-		break
-	    }
-	    set b [lindex $kids 0]
-	}
+        set skipa 0
+        set skipb 0
+        if {[llength $parents($curview,$a)] > 1} {
+            appendshortlink $a [mc "Skipping merge commit "] "\n"
+            set skipa 1
+        } else {
+            set patcha [getpatchid $a]
+        }
+        if {[llength $parents($curview,$b)] > 1} {
+            appendshortlink $b [mc "Skipping merge commit "] "\n"
+            set skipb 1
+        } else {
+            set patchb [getpatchid $b]
+        }
+        if {!$skipa && !$skipb} {
+            set heada [lindex $commitinfo($a) 0]
+            set headb [lindex $commitinfo($b) 0]
+            if {$patcha eq "error"} {
+                appendshortlink $a [mc "Error getting patch ID for "] \
+                    [mc " - stopping\n"]
+                break
+            }
+            if {$patchb eq "error"} {
+                appendshortlink $b [mc "Error getting patch ID for "] \
+                    [mc " - stopping\n"]
+                break
+            }
+            if {$patcha eq $patchb} {
+                if {$heada eq $headb} {
+                    appendshortlink $a [mc "Commit "]
+                    appendshortlink $b " == " "  $heada\n"
+                } else {
+                    appendshortlink $a [mc "Commit "] "  $heada\n"
+                    appendshortlink $b [mc " is the same patch as\n       "] \
+                        "  $headb\n"
+                }
+                set skipa 1
+                set skipb 1
+            } else {
+                $ctext insert end "\n"
+                appendshortlink $a [mc "Commit "] "  $heada\n"
+                appendshortlink $b [mc " differs from\n       "] \
+                    "  $headb\n"
+                $ctext insert end [mc "Diff of commits:\n\n"]
+                $ctext conf -state disabled
+                update
+                diffcommits $a $b
+                return
+            }
+        }
+        if {$skipa} {
+            set kids [real_children $curview,$a]
+            if {[llength $kids] != 1} {
+                $ctext insert end "\n"
+                appendshortlink $a [mc "Commit "] \
+                    [mc " has %s children - stopping\n" [llength $kids]]
+                break
+            }
+            set a [lindex $kids 0]
+        }
+        if {$skipb} {
+            set kids [real_children $curview,$b]
+            if {[llength $kids] != 1} {
+                appendshortlink $b [mc "Commit "] \
+                    [mc " has %s children - stopping\n" [llength $kids]]
+                break
+            }
+            set b [lindex $kids 0]
+        }
     }
     $ctext conf -state disabled
 }
@@ -9149,17 +9149,17 @@ proc diffcommits {a b} {
     set fna [file join $tmpdir "commit-[string range $a 0 7]"]
     set fnb [file join $tmpdir "commit-[string range $b 0 7]"]
     if {[catch {
-	exec git diff-tree -p --pretty $a >$fna
-	exec git diff-tree -p --pretty $b >$fnb
+        exec git diff-tree -p --pretty $a >$fna
+        exec git diff-tree -p --pretty $b >$fnb
     } err]} {
-	error_popup [mc "Error writing commit to file: %s" $err]
-	return
+        error_popup [mc "Error writing commit to file: %s" $err]
+        return
     }
     if {[catch {
-	set fd [open "| diff -U$diffcontext $fna $fnb" r]
+        set fd [open "| diff -U$diffcontext $fna $fnb" r]
     } err]} {
-	error_popup [mc "Error diffing commits: %s" $err]
-	return
+        error_popup [mc "Error diffing commits: %s" $err]
+        return
     }
     set diffids [list commits $a $b]
     set blobdifffd($diffids) $fd
@@ -9173,11 +9173,11 @@ proc diffvssel {dirn} {
 
     if {$selectedline eq {}} return
     if {$dirn} {
-	set oldid [commitonrow $selectedline]
-	set newid $rowmenuid
+        set oldid [commitonrow $selectedline]
+        set newid $rowmenuid
     } else {
-	set oldid $rowmenuid
-	set newid [commitonrow $selectedline]
+        set oldid $rowmenuid
+        set newid [commitonrow $selectedline]
     }
     addtohistory [list doseldiff $oldid $newid] savectextpos
     doseldiff $oldid $newid
@@ -9188,11 +9188,11 @@ proc diffvsmark {dirn} {
 
     if {![info exists markedid]} return
     if {$dirn} {
-	set oldid $markedid
-	set newid $rowmenuid
+        set oldid $markedid
+        set newid $rowmenuid
     } else {
-	set oldid $rowmenuid
-	set newid $markedid
+        set oldid $rowmenuid
+        set newid $markedid
     }
     addtohistory [list doseldiff $oldid $newid] savectextpos
     doseldiff $oldid $newid
@@ -9281,11 +9281,11 @@ proc mkpatchrev {} {
     set newid [$patchtop.tosha1 get]
     set newhead [$patchtop.tohead get]
     foreach e [list fromsha1 fromhead tosha1 tohead] \
-	    v [list $newid $newhead $oldid $oldhead] {
-	$patchtop.$e conf -state normal
-	$patchtop.$e delete 0 end
-	$patchtop.$e insert 0 $v
-	$patchtop.$e conf -state readonly
+            v [list $newid $newhead $oldid $oldhead] {
+        $patchtop.$e conf -state normal
+        $patchtop.$e delete 0 end
+        $patchtop.$e insert 0 $v
+        $patchtop.$e conf -state readonly
     }
 }
 
@@ -9300,7 +9300,7 @@ proc mkpatchgo {} {
     set cmd [lrange $cmd 1 end]
     lappend cmd >$fname &
     if {[catch {eval exec $cmd} err]} {
-	error_popup "[mc "Error creating patch:"] $err" $patchtop
+        error_popup "[mc "Error creating patch:"] $err" $patchtop
     }
     catch {destroy $patchtop}
     unset patchtop
@@ -9359,22 +9359,22 @@ proc domktag {} {
     set tag [$mktagtop.tag get]
     set msg [$mktagtop.msg get]
     if {$tag == {}} {
-	error_popup [mc "No tag name specified"] $mktagtop
-	return 0
+        error_popup [mc "No tag name specified"] $mktagtop
+        return 0
     }
     if {[info exists tagids($tag)]} {
-	error_popup [mc "Tag \"%s\" already exists" $tag] $mktagtop
-	return 0
+        error_popup [mc "Tag \"%s\" already exists" $tag] $mktagtop
+        return 0
     }
     if {[catch {
-	if {$msg != {}} {
-	    exec git tag -a -m $msg $tag $id
-	} else {
-	    exec git tag $tag $id
-	}
+        if {$msg != {}} {
+            exec git tag -a -m $msg $tag $id
+        } else {
+            exec git tag $tag $id
+        }
     } err]} {
-	error_popup "[mc "Error creating tag:"] $err" $mktagtop
-	return 0
+        error_popup "[mc "Error creating tag:"] $err" $mktagtop
+        return 0
     }
 
     set tagids($tag) $id
@@ -9395,9 +9395,9 @@ proc redrawtags {id} {
     if {![info exists iddrawn($id)]} return
     set row [rowofcommit $id]
     if {$id eq $mainheadid} {
-	set ofill $mainheadcirclecolor
+        set ofill $mainheadcirclecolor
     } else {
-	set ofill [lindex $circlecolors $cmitlisted($curview,$id)]
+        set ofill [lindex $circlecolors $cmitlisted($curview,$id)]
     }
     $canv itemconf $circleitem($row) -fill $ofill
     $canv delete tag.$id
@@ -9407,14 +9407,14 @@ proc redrawtags {id} {
     set font [$canv itemcget $linehtag($id) -font]
     set xr [expr {$xt + [font measure $font $text]}]
     if {$xr > $canvxmax} {
-	set canvxmax $xr
-	setcanvscroll
+        set canvxmax $xr
+        setcanvscroll
     }
     if {[info exists currentid] && $currentid == $id} {
-	make_secsel $id
+        make_secsel $id
     }
     if {[info exists markedid] && $markedid eq $id} {
-	make_idmark $id
+        make_idmark $id
     }
 }
 
@@ -9489,7 +9489,7 @@ proc wrcomgo {} {
     set cmd "echo $id | [$wrcomtop.cmd get]"
     set fname [$wrcomtop.fname get]
     if {[catch {exec sh -c $cmd >$fname &} err]} {
-	error_popup "[mc "Error writing commit:"] $err" $wrcomtop
+        error_popup "[mc "Error writing commit:"] $err" $wrcomtop
     }
     catch {destroy $wrcomtop}
     unset wrcomtop
@@ -9576,41 +9576,41 @@ proc mkbrgo {top} {
     set cmdargs {}
     set old_id {}
     if {$name eq {}} {
-	error_popup [mc "Please specify a name for the new branch"] $top
-	return
+        error_popup [mc "Please specify a name for the new branch"] $top
+        return
     }
     if {[info exists headids($name)]} {
-	if {![confirm_popup [mc \
-		"Branch '%s' already exists. Overwrite?" $name] $top]} {
-	    return
-	}
-	set old_id $headids($name)
-	lappend cmdargs -f
+        if {![confirm_popup [mc \
+                "Branch '%s' already exists. Overwrite?" $name] $top]} {
+            return
+        }
+        set old_id $headids($name)
+        lappend cmdargs -f
     }
     catch {destroy $top}
     lappend cmdargs $name $id
     nowbusy newbranch
     update
     if {[catch {
-	eval exec git branch $cmdargs
+        eval exec git branch $cmdargs
     } err]} {
-	notbusy newbranch
-	error_popup $err
+        notbusy newbranch
+        error_popup $err
     } else {
-	notbusy newbranch
-	if {$old_id ne {}} {
-	    movehead $id $name
-	    movedhead $id $name
-	    redrawtags $old_id
-	    redrawtags $id
-	} else {
-	    set headids($name) $id
-	    lappend idheads($id) $name
-	    addedhead $id $name
-	    redrawtags $id
-	}
-	dispneartags 0
-	run refill_reflist
+        notbusy newbranch
+        if {$old_id ne {}} {
+            movehead $id $name
+            movedhead $id $name
+            redrawtags $old_id
+            redrawtags $id
+        } else {
+            set headids($name) $id
+            lappend idheads($id) $name
+            addedhead $id $name
+            redrawtags $id
+        }
+        dispneartags 0
+        run refill_reflist
     }
 }
 
@@ -9621,36 +9621,36 @@ proc mvbrgo {top prevname} {
     set id [$top.sha1 get]
     set cmdargs {}
     if {$name eq $prevname} {
-	catch {destroy $top}
-	return
+        catch {destroy $top}
+        return
     }
     if {$name eq {}} {
-	error_popup [mc "Please specify a new name for the branch"] $top
-	return
+        error_popup [mc "Please specify a new name for the branch"] $top
+        return
     }
     catch {destroy $top}
     lappend cmdargs -m $prevname $name
     nowbusy renamebranch
     update
     if {[catch {
-	eval exec git branch $cmdargs
+        eval exec git branch $cmdargs
     } err]} {
-	notbusy renamebranch
-	error_popup $err
+        notbusy renamebranch
+        error_popup $err
     } else {
-	notbusy renamebranch
-	removehead $id $prevname
-	removedhead $id $prevname
-	set headids($name) $id
-	lappend idheads($id) $name
-	addedhead $id $name
-	if {$prevname eq $mainhead} {
-	    set mainhead $name
-	    set mainheadid $id
-	}
-	redrawtags $id
-	dispneartags 0
-	run refill_reflist
+        notbusy renamebranch
+        removehead $id $prevname
+        removedhead $id $prevname
+        set headids($name) $id
+        lappend idheads($id) $name
+        addedhead $id $name
+        if {$prevname eq $mainhead} {
+            set mainhead $name
+            set mainheadid $id
+        }
+        redrawtags $id
+        dispneartags 0
+        run refill_reflist
     }
 }
 
@@ -9660,18 +9660,18 @@ proc exec_citool {tool_args {baseid {}}} {
     set save_env [array get env GIT_AUTHOR_*]
 
     if {$baseid ne {}} {
-	if {![info exists commitinfo($baseid)]} {
-	    getcommit $baseid
-	}
-	set author [lindex $commitinfo($baseid) 1]
-	set date [lindex $commitinfo($baseid) 2]
-	if {[regexp {^\s*(\S.*\S|\S)\s*<(.*)>\s*$} \
-	            $author author name email]
-	    && $date ne {}} {
-	    set env(GIT_AUTHOR_NAME) $name
-	    set env(GIT_AUTHOR_EMAIL) $email
-	    set env(GIT_AUTHOR_DATE) $date
-	}
+        if {![info exists commitinfo($baseid)]} {
+            getcommit $baseid
+        }
+        set author [lindex $commitinfo($baseid) 1]
+        set date [lindex $commitinfo($baseid) 2]
+        if {[regexp {^\s*(\S.*\S|\S)\s*<(.*)>\s*$} \
+                    $author author name email]
+            && $date ne {}} {
+            set env(GIT_AUTHOR_NAME) $name
+            set env(GIT_AUTHOR_EMAIL) $email
+            set env(GIT_AUTHOR_DATE) $date
+        }
     }
 
     eval exec git citool $tool_args &
@@ -9688,57 +9688,57 @@ proc cherrypick {} {
     set oldhead [exec git rev-parse HEAD]
     set dheads [descheads $rowmenuid]
     if {$dheads ne {} && [lsearch -exact $dheads $oldhead] >= 0} {
-	set ok [confirm_popup [mc "Commit %s is already\
-		included in branch %s -- really re-apply it?" \
-				   [string range $rowmenuid 0 7] $mainhead]]
-	if {!$ok} return
+        set ok [confirm_popup [mc "Commit %s is already\
+                included in branch %s -- really re-apply it?" \
+                                   [string range $rowmenuid 0 7] $mainhead]]
+        if {!$ok} return
     }
     nowbusy cherrypick [mc "Cherry-picking"]
     update
     # Unfortunately git-cherry-pick writes stuff to stderr even when
     # no error occurs, and exec takes that as an indication of error...
     if {[catch {exec sh -c "git cherry-pick -r $rowmenuid 2>&1"} err]} {
-	notbusy cherrypick
-	if {[regexp -line \
-		 {Entry '(.*)' (would be overwritten by merge|not uptodate)} \
-		 $err msg fname]} {
-	    error_popup [mc "Cherry-pick failed because of local changes\
-			to file '%s'.\nPlease commit, reset or stash\
-			your changes and try again." $fname]
-	} elseif {[regexp -line \
-		       {^(CONFLICT \(.*\):|Automatic cherry-pick failed|error: could not apply)} \
-		       $err]} {
-	    if {[confirm_popup [mc "Cherry-pick failed because of merge\
-			conflict.\nDo you wish to run git citool to\
-			resolve it?"]]} {
-		# Force citool to read MERGE_MSG
-		file delete [file join $gitdir "GITGUI_MSG"]
-		exec_citool {} $rowmenuid
-	    }
-	} else {
-	    error_popup $err
-	}
-	run updatecommits
-	return
+        notbusy cherrypick
+        if {[regexp -line \
+                 {Entry '(.*)' (would be overwritten by merge|not uptodate)} \
+                 $err msg fname]} {
+            error_popup [mc "Cherry-pick failed because of local changes\
+                        to file '%s'.\nPlease commit, reset or stash\
+                        your changes and try again." $fname]
+        } elseif {[regexp -line \
+                       {^(CONFLICT \(.*\):|Automatic cherry-pick failed|error: could not apply)} \
+                       $err]} {
+            if {[confirm_popup [mc "Cherry-pick failed because of merge\
+                        conflict.\nDo you wish to run git citool to\
+                        resolve it?"]]} {
+                # Force citool to read MERGE_MSG
+                file delete [file join $gitdir "GITGUI_MSG"]
+                exec_citool {} $rowmenuid
+            }
+        } else {
+            error_popup $err
+        }
+        run updatecommits
+        return
     }
     set newhead [exec git rev-parse HEAD]
     if {$newhead eq $oldhead} {
-	notbusy cherrypick
-	error_popup [mc "No changes committed"]
-	return
+        notbusy cherrypick
+        error_popup [mc "No changes committed"]
+        return
     }
     addnewchild $newhead $oldhead
     if {[commitinview $oldhead $curview]} {
-	# XXX this isn't right if we have a path limit...
-	insertrow $newhead $oldhead $curview
-	if {$mainhead ne {}} {
-	    movehead $newhead $mainhead
-	    movedhead $newhead $mainhead
-	}
-	set mainheadid $newhead
-	redrawtags $oldhead
-	redrawtags $newhead
-	selbyid $newhead
+        # XXX this isn't right if we have a path limit...
+        insertrow $newhead $oldhead $curview
+        if {$mainhead ne {}} {
+            movehead $newhead $mainhead
+            movedhead $newhead $mainhead
+        }
+        set mainheadid $newhead
+        redrawtags $oldhead
+        redrawtags $newhead
+        selbyid $newhead
     }
     notbusy cherrypick
 }
@@ -9813,18 +9813,18 @@ proc resethead {} {
     make_transient $w .
     wm title $w [mc "Confirm reset"]
     ${NS}::label $w.m -text \
-	[mc "Reset branch %s to %s?" $mainhead [string range $rowmenuid 0 7]]
+        [mc "Reset branch %s to %s?" $mainhead [string range $rowmenuid 0 7]]
     pack $w.m -side top -fill x -padx 20 -pady 20
     ${NS}::labelframe $w.f -text [mc "Reset type:"]
     set resettype mixed
     ${NS}::radiobutton $w.f.soft -value soft -variable resettype \
-	-text [mc "Soft: Leave working tree and index untouched"]
+        -text [mc "Soft: Leave working tree and index untouched"]
     grid $w.f.soft -sticky w
     ${NS}::radiobutton $w.f.mixed -value mixed -variable resettype \
-	-text [mc "Mixed: Leave working tree untouched, reset index"]
+        -text [mc "Mixed: Leave working tree untouched, reset index"]
     grid $w.f.mixed -sticky w
     ${NS}::radiobutton $w.f.hard -value hard -variable resettype \
-	-text [mc "Hard: Reset working tree and index\n(discard ALL local changes)"]
+        -text [mc "Hard: Reset working tree and index\n(discard ALL local changes)"]
     grid $w.f.hard -sticky w
     pack $w.f -side top -fill x -padx 4
     ${NS}::button $w.ok -text [mc OK] -command "set confirm_ok 1; destroy $w"
@@ -9836,13 +9836,13 @@ proc resethead {} {
     tkwait window $w
     if {!$confirm_ok} return
     if {[catch {set fd [open \
-	    [list | git reset --$resettype $rowmenuid 2>@1] r]} err]} {
-	error_popup $err
+            [list | git reset --$resettype $rowmenuid 2>@1] r]} err]} {
+        error_popup $err
     } else {
-	dohidelocalchanges
-	filerun $fd [list readresetstat $fd]
-	nowbusy reset [mc "Resetting"]
-	selbyid $rowmenuid
+        dohidelocalchanges
+        filerun $fd [list readresetstat $fd]
+        nowbusy reset [mc "Resetting"]
+        selbyid $rowmenuid
     }
 }
 
@@ -9850,29 +9850,29 @@ proc readresetstat {fd} {
     global mainhead mainheadid showlocalchanges rprogcoord
 
     if {[gets $fd line] >= 0} {
-	if {[regexp {([0-9]+)% \(([0-9]+)/([0-9]+)\)} $line match p m n]} {
-	    set rprogcoord [expr {1.0 * $m / $n}]
-	    adjustprogress
-	}
-	return 1
+        if {[regexp {([0-9]+)% \(([0-9]+)/([0-9]+)\)} $line match p m n]} {
+            set rprogcoord [expr {1.0 * $m / $n}]
+            adjustprogress
+        }
+        return 1
     }
     set rprogcoord 0
     adjustprogress
     notbusy reset
     if {[catch {close $fd} err]} {
-	error_popup $err
+        error_popup $err
     }
     set oldhead $mainheadid
     set newhead [exec git rev-parse HEAD]
     if {$newhead ne $oldhead} {
-	movehead $newhead $mainhead
-	movedhead $newhead $mainhead
-	set mainheadid $newhead
-	redrawtags $oldhead
-	redrawtags $newhead
+        movehead $newhead $mainhead
+        movedhead $newhead $mainhead
+        set mainheadid $newhead
+        redrawtags $oldhead
+        redrawtags $newhead
     }
     if {$showlocalchanges} {
-	doshowlocalchanges
+        doshowlocalchanges
     }
     return 0
 }
@@ -9886,17 +9886,17 @@ proc headmenu {x y id head} {
     set headmenuhead $head
     array set state {0 normal 1 normal 2 normal}
     if {[string match "remotes/*" $head]} {
-	set localhead [string range $head [expr [string last / $head] + 1] end]
-	if {[info exists headids($localhead)]} {
-	    set state(0) disabled
-	}
-	array set state {1 disabled 2 disabled}
+        set localhead [string range $head [expr [string last / $head] + 1] end]
+        if {[info exists headids($localhead)]} {
+            set state(0) disabled
+        }
+        array set state {1 disabled 2 disabled}
     }
     if {$head eq $mainhead} {
-	array set state {0 disabled 2 disabled}
+        array set state {0 disabled 2 disabled}
     }
     foreach i {0 1 2} {
-	$headctxmenu entryconfigure $i -state $state($i)
+        $headctxmenu entryconfigure $i -state $state($i)
     }
     tk_popup $headctxmenu $x $y
 }
@@ -9909,32 +9909,32 @@ proc cobranch {} {
     set newhead $headmenuhead
     set command [list | git checkout]
     if {[string match "remotes/*" $newhead]} {
-	set remote $newhead
-	set newhead [string range $newhead [expr [string last / $newhead] + 1] end]
-	# The following check is redundant - the menu option should
-	# be disabled to begin with...
-	if {[info exists headids($newhead)]} {
-	    error_popup [mc "A local branch named %s exists already" $newhead]
-	    return
-	}
-	lappend command -b $newhead --track $remote
+        set remote $newhead
+        set newhead [string range $newhead [expr [string last / $newhead] + 1] end]
+        # The following check is redundant - the menu option should
+        # be disabled to begin with...
+        if {[info exists headids($newhead)]} {
+            error_popup [mc "A local branch named %s exists already" $newhead]
+            return
+        }
+        lappend command -b $newhead --track $remote
     } else {
-	lappend command $newhead
+        lappend command $newhead
     }
     lappend command 2>@1
     nowbusy checkout [mc "Checking out"]
     update
     dohidelocalchanges
     if {[catch {
-	set fd [open $command r]
+        set fd [open $command r]
     } err]} {
-	notbusy checkout
-	error_popup $err
-	if {$showlocalchanges} {
-	    dodiffindex
-	}
+        notbusy checkout
+        error_popup $err
+        if {$showlocalchanges} {
+            dodiffindex
+        }
     } else {
-	filerun $fd [list readcheckoutstat $fd $newhead $headmenuid]
+        filerun $fd [list readcheckoutstat $fd $newhead $headmenuid]
     }
 }
 
@@ -9943,24 +9943,24 @@ proc readcheckoutstat {fd newhead newheadid} {
     global viewmainheadid curview
 
     if {[gets $fd line] >= 0} {
-	if {[regexp {([0-9]+)% \(([0-9]+)/([0-9]+)\)} $line match p m n]} {
-	    set progresscoords [list 0 [expr {1.0 * $m / $n}]]
-	    adjustprogress
-	}
-	return 1
+        if {[regexp {([0-9]+)% \(([0-9]+)/([0-9]+)\)} $line match p m n]} {
+            set progresscoords [list 0 [expr {1.0 * $m / $n}]]
+            adjustprogress
+        }
+        return 1
     }
     set progresscoords {0 0}
     adjustprogress
     notbusy checkout
     if {[catch {close $fd} err]} {
-	error_popup $err
-	return
+        error_popup $err
+        return
     }
     set oldmainid $mainheadid
     if {! [info exists headids($newhead)]} {
-	set headids($newhead) $newheadid
-	lappend idheads($newheadid) $newhead
-	addedhead $newheadid $newhead
+        set headids($newhead) $newheadid
+        lappend idheads($newheadid) $newhead
+        addedhead $newheadid $newhead
     }
     set mainhead $newhead
     set mainheadid $newheadid
@@ -9969,7 +9969,7 @@ proc readcheckoutstat {fd newhead newheadid} {
     redrawtags $newheadid
     selbyid $newheadid
     if {$showlocalchanges} {
-	dodiffindex
+        dodiffindex
     }
 }
 
@@ -9981,21 +9981,21 @@ proc rmbranch {} {
     set id $headmenuid
     # this check shouldn't be needed any more...
     if {$head eq $mainhead} {
-	error_popup [mc "Cannot delete the currently checked-out branch"]
-	return
+        error_popup [mc "Cannot delete the currently checked-out branch"]
+        return
     }
     set dheads [descheads $id]
     if {[llength $dheads] == 1 && $idheads($dheads) eq $head} {
-	# the stuff on this branch isn't on any other branch
-	if {![confirm_popup [mc "The commits on branch %s aren't on any other\
-			branch.\nReally delete branch %s?" $head $head]]} return
+        # the stuff on this branch isn't on any other branch
+        if {![confirm_popup [mc "The commits on branch %s aren't on any other\
+                        branch.\nReally delete branch %s?" $head $head]]} return
     }
     nowbusy rmbranch
     update
     if {[catch {exec git branch -D $head} err]} {
-	notbusy rmbranch
-	error_popup $err
-	return
+        notbusy rmbranch
+        error_popup $err
+        return
     }
     removehead $id $head
     removedhead $id $head
@@ -10013,22 +10013,22 @@ proc showrefs {} {
     set top .showrefs
     set showrefstop $top
     if {[winfo exists $top]} {
-	raise $top
-	refill_reflist
-	return
+        raise $top
+        refill_reflist
+        return
     }
     ttk_toplevel $top
     wm title $top [mc "Tags and heads: %s" [file tail [pwd]]]
     make_transient $top .
     text $top.list -background $bgcolor -foreground $fgcolor \
-	-selectbackground $selectbgcolor -font mainfont \
-	-xscrollcommand "$top.xsb set" -yscrollcommand "$top.ysb set" \
-	-width 30 -height 20 -cursor $maincursor \
-	-spacing1 1 -spacing3 1 -state disabled
+        -selectbackground $selectbgcolor -font mainfont \
+        -xscrollcommand "$top.xsb set" -yscrollcommand "$top.ysb set" \
+        -width 30 -height 20 -cursor $maincursor \
+        -spacing1 1 -spacing3 1 -state disabled
     $top.list tag configure highlight -background $selectbgcolor
     if {![lsearch -exact $bglist $top.list]} {
-	lappend bglist $top.list
-	lappend fglist $top.list
+        lappend bglist $top.list
+        lappend fglist $top.list
     }
     ${NS}::scrollbar $top.ysb -command "$top.list yview" -orient vertical
     ${NS}::scrollbar $top.xsb -command "$top.list xview" -orient horizontal
@@ -10062,10 +10062,10 @@ proc sel_reflist {w x y} {
     set ref [lindex $reflist [expr {$l-1}]]
     set n [lindex $ref 0]
     switch -- [lindex $ref 1] {
-	"H" {selbyid $headids($n)}
-	"R" {selbyid $headids($n)}
-	"T" {selbyid $tagids($n)}
-	"o" {selbyid $otherrefids($n)}
+        "H" {selbyid $headids($n)}
+        "R" {selbyid $headids($n)}
+        "T" {selbyid $tagids($n)}
+        "o" {selbyid $otherrefids($n)}
     }
     $showrefstop.list tag add highlight $l.0 "$l.0 lineend"
 }
@@ -10091,35 +10091,35 @@ proc refill_reflist {} {
     if {![info exists showrefstop] || ![winfo exists $showrefstop]} return
     set refs {}
     foreach n [array names headids] {
-	if {[string match $reflistfilter $n]} {
-	    if {[commitinview $headids($n) $curview]} {
-		if {[string match "remotes/*" $n]} {
-		    lappend refs [list $n R]
-		} else {
-		    lappend refs [list $n H]
-		}
-	    } else {
-		interestedin $headids($n) {run refill_reflist}
-	    }
-	}
+        if {[string match $reflistfilter $n]} {
+            if {[commitinview $headids($n) $curview]} {
+                if {[string match "remotes/*" $n]} {
+                    lappend refs [list $n R]
+                } else {
+                    lappend refs [list $n H]
+                }
+            } else {
+                interestedin $headids($n) {run refill_reflist}
+            }
+        }
     }
     foreach n [array names tagids] {
-	if {[string match $reflistfilter $n]} {
-	    if {[commitinview $tagids($n) $curview]} {
-		lappend refs [list $n T]
-	    } else {
-		interestedin $tagids($n) {run refill_reflist}
-	    }
-	}
+        if {[string match $reflistfilter $n]} {
+            if {[commitinview $tagids($n) $curview]} {
+                lappend refs [list $n T]
+            } else {
+                interestedin $tagids($n) {run refill_reflist}
+            }
+        }
     }
     foreach n [array names otherrefids] {
-	if {[string match $reflistfilter $n]} {
-	    if {[commitinview $otherrefids($n) $curview]} {
-		lappend refs [list $n o]
-	    } else {
-		interestedin $otherrefids($n) {run refill_reflist}
-	    }
-	}
+        if {[string match $reflistfilter $n]} {
+            if {[commitinview $otherrefids($n) $curview]} {
+                lappend refs [list $n o]
+            } else {
+                interestedin $otherrefids($n) {run refill_reflist}
+            }
+        }
     }
     set refs [lsort -index 0 $refs]
     if {$refs eq $reflist} return
@@ -10131,37 +10131,37 @@ proc refill_reflist {} {
     set i 0
     set j 0
     while {$i < [llength $reflist] || $j < [llength $refs]} {
-	if {$i < [llength $reflist]} {
-	    if {$j < [llength $refs]} {
-		set cmp [string compare [lindex $reflist $i 0] \
-			     [lindex $refs $j 0]]
-		if {$cmp == 0} {
-		    set cmp [string compare [lindex $reflist $i 1] \
-				 [lindex $refs $j 1]]
-		}
-	    } else {
-		set cmp -1
-	    }
-	} else {
-	    set cmp 1
-	}
-	switch -- $cmp {
-	    -1 {
-		$showrefstop.list delete "[expr {$j+1}].0" "[expr {$j+2}].0"
-		incr i
-	    }
-	    0 {
-		incr i
-		incr j
-	    }
-	    1 {
-		set l [expr {$j + 1}]
-		$showrefstop.list image create $l.0 -align baseline \
-		    -image reficon-[lindex $refs $j 1] -padx 2
-		$showrefstop.list insert $l.1 "[lindex $refs $j 0]\n"
-		incr j
-	    }
-	}
+        if {$i < [llength $reflist]} {
+            if {$j < [llength $refs]} {
+                set cmp [string compare [lindex $reflist $i 0] \
+                             [lindex $refs $j 0]]
+                if {$cmp == 0} {
+                    set cmp [string compare [lindex $reflist $i 1] \
+                                 [lindex $refs $j 1]]
+                }
+            } else {
+                set cmp -1
+            }
+        } else {
+            set cmp 1
+        }
+        switch -- $cmp {
+            -1 {
+                $showrefstop.list delete "[expr {$j+1}].0" "[expr {$j+2}].0"
+                incr i
+            }
+            0 {
+                incr i
+                incr j
+            }
+            1 {
+                set l [expr {$j + 1}]
+                $showrefstop.list image create $l.0 -align baseline \
+                    -image reficon-[lindex $refs $j 1] -padx 2
+                $showrefstop.list insert $l.1 "[lindex $refs $j 0]\n"
+                incr j
+            }
+        }
     }
     set reflist $refs
     # delete last newline
@@ -10176,54 +10176,54 @@ proc getallcommits {} {
     global gitdir
 
     if {![info exists allcommits]} {
-	set nextarc 0
-	set allcommits 0
-	set seeds {}
-	set allcwait 0
-	set cachedarcs 0
-	set allccache [file join $gitdir "gitk.cache"]
-	if {![catch {
-	    set f [open $allccache r]
-	    set allcwait 1
-	    getcache $f
-	}]} return
+        set nextarc 0
+        set allcommits 0
+        set seeds {}
+        set allcwait 0
+        set cachedarcs 0
+        set allccache [file join $gitdir "gitk.cache"]
+        if {![catch {
+            set f [open $allccache r]
+            set allcwait 1
+            getcache $f
+        }]} return
     }
 
     if {$allcwait} {
-	return
+        return
     }
     set cmd [list | git rev-list --parents]
     set allcupdate [expr {$seeds ne {}}]
     if {!$allcupdate} {
-	set ids "--all"
+        set ids "--all"
     } else {
-	set refs [concat [array names idheads] [array names idtags] \
-		      [array names idotherrefs]]
-	set ids {}
-	set tagobjs {}
-	foreach name [array names tagobjid] {
-	    lappend tagobjs $tagobjid($name)
-	}
-	foreach id [lsort -unique $refs] {
-	    if {![info exists allparents($id)] &&
-		[lsearch -exact $tagobjs $id] < 0} {
-		lappend ids $id
-	    }
-	}
-	if {$ids ne {}} {
-	    foreach id $seeds {
-		lappend ids "^$id"
-	    }
-	}
+        set refs [concat [array names idheads] [array names idtags] \
+                      [array names idotherrefs]]
+        set ids {}
+        set tagobjs {}
+        foreach name [array names tagobjid] {
+            lappend tagobjs $tagobjid($name)
+        }
+        foreach id [lsort -unique $refs] {
+            if {![info exists allparents($id)] &&
+                [lsearch -exact $tagobjs $id] < 0} {
+                lappend ids $id
+            }
+        }
+        if {$ids ne {}} {
+            foreach id $seeds {
+                lappend ids "^$id"
+            }
+        }
     }
     if {$ids ne {}} {
-	set fd [open [concat $cmd $ids] r]
-	fconfigure $fd -blocking 0
-	incr allcommits
-	nowbusy allcommits
-	filerun $fd [list getallclines $fd]
+        set fd [open [concat $cmd $ids] r]
+        fconfigure $fd -blocking 0
+        incr allcommits
+        nowbusy allcommits
+        filerun $fd [list getallclines $fd]
     } else {
-	dispneartags 0
+        dispneartags 0
     }
 }
 
@@ -10249,103 +10249,103 @@ proc getallclines {fd} {
 
     set nid 0
     while {[incr nid] <= 1000 && [gets $fd line] >= 0} {
-	set id [lindex $line 0]
-	if {[info exists allparents($id)]} {
-	    # seen it already
-	    continue
-	}
-	set cachedarcs 0
-	set olds [lrange $line 1 end]
-	set allparents($id) $olds
-	if {![info exists allchildren($id)]} {
-	    set allchildren($id) {}
-	    set arcnos($id) {}
-	    lappend seeds $id
-	} else {
-	    set a $arcnos($id)
-	    if {[llength $olds] == 1 && [llength $a] == 1} {
-		lappend arcids($a) $id
-		if {[info exists idtags($id)]} {
-		    lappend arctags($a) $id
-		}
-		if {[info exists idheads($id)]} {
-		    lappend archeads($a) $id
-		}
-		if {[info exists allparents($olds)]} {
-		    # seen parent already
-		    if {![info exists arcout($olds)]} {
-			splitarc $olds
-		    }
-		    lappend arcids($a) $olds
-		    set arcend($a) $olds
-		    unset growing($a)
-		}
-		lappend allchildren($olds) $id
-		lappend arcnos($olds) $a
-		continue
-	    }
-	}
-	foreach a $arcnos($id) {
-	    lappend arcids($a) $id
-	    set arcend($a) $id
-	    unset growing($a)
-	}
+        set id [lindex $line 0]
+        if {[info exists allparents($id)]} {
+            # seen it already
+            continue
+        }
+        set cachedarcs 0
+        set olds [lrange $line 1 end]
+        set allparents($id) $olds
+        if {![info exists allchildren($id)]} {
+            set allchildren($id) {}
+            set arcnos($id) {}
+            lappend seeds $id
+        } else {
+            set a $arcnos($id)
+            if {[llength $olds] == 1 && [llength $a] == 1} {
+                lappend arcids($a) $id
+                if {[info exists idtags($id)]} {
+                    lappend arctags($a) $id
+                }
+                if {[info exists idheads($id)]} {
+                    lappend archeads($a) $id
+                }
+                if {[info exists allparents($olds)]} {
+                    # seen parent already
+                    if {![info exists arcout($olds)]} {
+                        splitarc $olds
+                    }
+                    lappend arcids($a) $olds
+                    set arcend($a) $olds
+                    unset growing($a)
+                }
+                lappend allchildren($olds) $id
+                lappend arcnos($olds) $a
+                continue
+            }
+        }
+        foreach a $arcnos($id) {
+            lappend arcids($a) $id
+            set arcend($a) $id
+            unset growing($a)
+        }
 
-	set ao {}
-	foreach p $olds {
-	    lappend allchildren($p) $id
-	    set a [incr nextarc]
-	    set arcstart($a) $id
-	    set archeads($a) {}
-	    set arctags($a) {}
-	    set archeads($a) {}
-	    set arcids($a) {}
-	    lappend ao $a
-	    set growing($a) 1
-	    if {[info exists allparents($p)]} {
-		# seen it already, may need to make a new branch
-		if {![info exists arcout($p)]} {
-		    splitarc $p
-		}
-		lappend arcids($a) $p
-		set arcend($a) $p
-		unset growing($a)
-	    }
-	    lappend arcnos($p) $a
-	}
-	set arcout($id) $ao
+        set ao {}
+        foreach p $olds {
+            lappend allchildren($p) $id
+            set a [incr nextarc]
+            set arcstart($a) $id
+            set archeads($a) {}
+            set arctags($a) {}
+            set archeads($a) {}
+            set arcids($a) {}
+            lappend ao $a
+            set growing($a) 1
+            if {[info exists allparents($p)]} {
+                # seen it already, may need to make a new branch
+                if {![info exists arcout($p)]} {
+                    splitarc $p
+                }
+                lappend arcids($a) $p
+                set arcend($a) $p
+                unset growing($a)
+            }
+            lappend arcnos($p) $a
+        }
+        set arcout($id) $ao
     }
     if {$nid > 0} {
-	global cached_dheads cached_dtags cached_atags
-	unset -nocomplain cached_dheads
-	unset -nocomplain cached_dtags
-	unset -nocomplain cached_atags
+        global cached_dheads cached_dtags cached_atags
+        unset -nocomplain cached_dheads
+        unset -nocomplain cached_dtags
+        unset -nocomplain cached_atags
     }
     if {![eof $fd]} {
-	return [expr {$nid >= 1000? 2: 1}]
+        return [expr {$nid >= 1000? 2: 1}]
     }
     set cacheok 1
     if {[catch {
-	fconfigure $fd -blocking 1
-	close $fd
+        fconfigure $fd -blocking 1
+        close $fd
     } err]} {
-	# got an error reading the list of commits
-	# if we were updating, try rereading the whole thing again
-	if {$allcupdate} {
-	    incr allcommits -1
-	    dropcache $err
-	    return
-	}
-	error_popup "[mc "Error reading commit topology information;\
-		branch and preceding/following tag information\
-	        will be incomplete."]\n($err)"
-	set cacheok 0
+        # got an error reading the list of commits
+        # if we were updating, try rereading the whole thing again
+        if {$allcupdate} {
+            incr allcommits -1
+            dropcache $err
+            return
+        }
+        error_popup "[mc "Error reading commit topology information;\
+                branch and preceding/following tag information\
+                will be incomplete."]\n($err)"
+        set cacheok 0
     }
     if {[incr allcommits -1] == 0} {
-	notbusy allcommits
-	if {$cacheok} {
-	    run savecache
-	}
+        notbusy allcommits
+        if {$cacheok} {
+            run savecache
+        }
     }
     dispneartags 0
     return 0
@@ -10357,12 +10357,12 @@ proc recalcarc {a} {
     set at {}
     set ah {}
     foreach id [lrange $arcids($a) 0 end-1] {
-	if {[info exists idtags($id)]} {
-	    lappend at $id
-	}
-	if {[info exists idheads($id)]} {
-	    lappend ah $id
-	}
+        if {[info exists idtags($id)]} {
+            lappend at $id
+        }
+        if {[info exists idheads($id)]} {
+            lappend ah $id
+        }
     }
     set arctags($a) $at
     set archeads($a) $ah
@@ -10374,22 +10374,22 @@ proc splitarc {p} {
 
     set a $arcnos($p)
     if {[llength $a] != 1} {
-	puts "oops splitarc called but [llength $a] arcs already"
-	return
+        puts "oops splitarc called but [llength $a] arcs already"
+        return
     }
     set a [lindex $a 0]
     set i [lsearch -exact $arcids($a) $p]
     if {$i < 0} {
-	puts "oops splitarc $p not in arc $a"
-	return
+        puts "oops splitarc $p not in arc $a"
+        return
     }
     set na [incr nextarc]
     if {[info exists arcend($a)]} {
-	set arcend($na) $arcend($a)
+        set arcend($na) $arcend($a)
     } else {
-	set l [lindex $allparents([lindex $arcids($a) end]) 0]
-	set j [lsearch -exact $arcnos($l) $a]
-	set arcnos($l) [lreplace $arcnos($l) $j $j $na]
+        set l [lindex $allparents([lindex $arcids($a) end]) 0]
+        set j [lsearch -exact $arcnos($l) $a]
+        set arcnos($l) [lreplace $arcnos($l) $j $j $na]
     }
     set tail [lrange $arcids($a) [expr {$i+1}] end]
     set arcids($a) [lrange $arcids($a) 0 $i]
@@ -10398,26 +10398,26 @@ proc splitarc {p} {
     set arcout($p) $na
     set arcids($na) $tail
     if {[info exists growing($a)]} {
-	set growing($na) 1
-	unset growing($a)
+        set growing($na) 1
+        unset growing($a)
     }
 
     foreach id $tail {
-	if {[llength $arcnos($id)] == 1} {
-	    set arcnos($id) $na
-	} else {
-	    set j [lsearch -exact $arcnos($id) $a]
-	    set arcnos($id) [lreplace $arcnos($id) $j $j $na]
-	}
+        if {[llength $arcnos($id)] == 1} {
+            set arcnos($id) $na
+        } else {
+            set j [lsearch -exact $arcnos($id) $a]
+            set arcnos($id) [lreplace $arcnos($id) $j $j $na]
+        }
     }
 
     # reconstruct tags and heads lists
     if {$arctags($a) ne {} || $archeads($a) ne {}} {
-	recalcarc $a
-	recalcarc $na
+        recalcarc $a
+        recalcarc $na
     } else {
-	set arctags($na) {}
-	set archeads($na) {}
+        set arctags($na) {}
+        set archeads($na) {}
     }
 }
 
@@ -10441,7 +10441,7 @@ proc addnewchild {id p} {
     set arcids($a) [list $p]
     set arcend($a) $p
     if {![info exists arcout($p)]} {
-	splitarc $p
+        splitarc $p
     }
     lappend arcnos($p) $a
     set arcout($id) [list $a]
@@ -10458,78 +10458,78 @@ proc readcache {f} {
     set a $nextarc
     set lim $cachedarcs
     if {$lim - $a > 500} {
-	set lim [expr {$a + 500}]
+        set lim [expr {$a + 500}]
     }
     if {[catch {
-	if {$a == $lim} {
-	    # finish reading the cache and setting up arctags, etc.
-	    set line [gets $f]
-	    if {$line ne "1"} {error "bad final version"}
-	    close $f
-	    foreach id [array names idtags] {
-		if {[info exists arcnos($id)] && [llength $arcnos($id)] == 1 &&
-		    [llength $allparents($id)] == 1} {
-		    set a [lindex $arcnos($id) 0]
-		    if {$arctags($a) eq {}} {
-			recalcarc $a
-		    }
-		}
-	    }
-	    foreach id [array names idheads] {
-		if {[info exists arcnos($id)] && [llength $arcnos($id)] == 1 &&
-		    [llength $allparents($id)] == 1} {
-		    set a [lindex $arcnos($id) 0]
-		    if {$archeads($a) eq {}} {
-			recalcarc $a
-		    }
-		}
-	    }
-	    foreach id [lsort -unique $possible_seeds] {
-		if {$arcnos($id) eq {}} {
-		    lappend seeds $id
-		}
-	    }
-	    set allcwait 0
-	} else {
-	    while {[incr a] <= $lim} {
-		set line [gets $f]
-		if {[llength $line] != 3} {error "bad line"}
-		set s [lindex $line 0]
-		set arcstart($a) $s
-		lappend arcout($s) $a
-		if {![info exists arcnos($s)]} {
-		    lappend possible_seeds $s
-		    set arcnos($s) {}
-		}
-		set e [lindex $line 1]
-		if {$e eq {}} {
-		    set growing($a) 1
-		} else {
-		    set arcend($a) $e
-		    if {![info exists arcout($e)]} {
-			set arcout($e) {}
-		    }
-		}
-		set arcids($a) [lindex $line 2]
-		foreach id $arcids($a) {
-		    lappend allparents($s) $id
-		    set s $id
-		    lappend arcnos($id) $a
-		}
-		if {![info exists allparents($s)]} {
-		    set allparents($s) {}
-		}
-		set arctags($a) {}
-		set archeads($a) {}
-	    }
-	    set nextarc [expr {$a - 1}]
-	}
+        if {$a == $lim} {
+            # finish reading the cache and setting up arctags, etc.
+            set line [gets $f]
+            if {$line ne "1"} {error "bad final version"}
+            close $f
+            foreach id [array names idtags] {
+                if {[info exists arcnos($id)] && [llength $arcnos($id)] == 1 &&
+                    [llength $allparents($id)] == 1} {
+                    set a [lindex $arcnos($id) 0]
+                    if {$arctags($a) eq {}} {
+                        recalcarc $a
+                    }
+                }
+            }
+            foreach id [array names idheads] {
+                if {[info exists arcnos($id)] && [llength $arcnos($id)] == 1 &&
+                    [llength $allparents($id)] == 1} {
+                    set a [lindex $arcnos($id) 0]
+                    if {$archeads($a) eq {}} {
+                        recalcarc $a
+                    }
+                }
+            }
+            foreach id [lsort -unique $possible_seeds] {
+                if {$arcnos($id) eq {}} {
+                    lappend seeds $id
+                }
+            }
+            set allcwait 0
+        } else {
+            while {[incr a] <= $lim} {
+                set line [gets $f]
+                if {[llength $line] != 3} {error "bad line"}
+                set s [lindex $line 0]
+                set arcstart($a) $s
+                lappend arcout($s) $a
+                if {![info exists arcnos($s)]} {
+                    lappend possible_seeds $s
+                    set arcnos($s) {}
+                }
+                set e [lindex $line 1]
+                if {$e eq {}} {
+                    set growing($a) 1
+                } else {
+                    set arcend($a) $e
+                    if {![info exists arcout($e)]} {
+                        set arcout($e) {}
+                    }
+                }
+                set arcids($a) [lindex $line 2]
+                foreach id $arcids($a) {
+                    lappend allparents($s) $id
+                    set s $id
+                    lappend arcnos($id) $a
+                }
+                if {![info exists allparents($s)]} {
+                    set allparents($s) {}
+                }
+                set arctags($a) {}
+                set archeads($a) {}
+            }
+            set nextarc [expr {$a - 1}]
+        }
     } err]} {
-	dropcache $err
-	return 0
+        dropcache $err
+        return 0
     }
     if {!$allcwait} {
-	getallcommits
+        getallcommits
     }
     return $allcwait
 }
@@ -10538,16 +10538,16 @@ proc getcache {f} {
     global nextarc cachedarcs possible_seeds
 
     if {[catch {
-	set line [gets $f]
-	if {[llength $line] != 2 || [lindex $line 0] ne "1"} {error "bad version"}
-	# make sure it's an integer
-	set cachedarcs [expr {int([lindex $line 1])}]
-	if {$cachedarcs < 0} {error "bad number of arcs"}
-	set nextarc 0
-	set possible_seeds {}
-	run readcache $f
+        set line [gets $f]
+        if {[llength $line] != 2 || [lindex $line 0] ne "1"} {error "bad version"}
+        # make sure it's an integer
+        set cachedarcs [expr {int([lindex $line 1])}]
+        if {$cachedarcs < 0} {error "bad number of arcs"}
+        set nextarc 0
+        set possible_seeds {}
+        run readcache $f
     } err]} {
-	dropcache $err
+        dropcache $err
     }
     return 0
 }
@@ -10557,9 +10557,9 @@ proc dropcache {err} {
 
     #puts "dropping cache ($err)"
     foreach v {arcnos arcout arcids arcstart arcend growing \
-		   arctags archeads allparents allchildren} {
-	global $v
-	unset -nocomplain $v
+                   arctags archeads allparents allchildren} {
+        global $v
+        unset -nocomplain $v
     }
     set allcwait 0
     set nextarc 0
@@ -10575,27 +10575,27 @@ proc writecache {f} {
     set a $cachearc
     set lim $cachedarcs
     if {$lim - $a > 1000} {
-	set lim [expr {$a + 1000}]
+        set lim [expr {$a + 1000}]
     }
     if {[catch {
-	while {[incr a] <= $lim} {
-	    if {[info exists arcend($a)]} {
-		puts $f [list $arcstart($a) $arcend($a) $arcids($a)]
-	    } else {
-		puts $f [list $arcstart($a) {} $arcids($a)]
-	    }
-	}
+        while {[incr a] <= $lim} {
+            if {[info exists arcend($a)]} {
+                puts $f [list $arcstart($a) $arcend($a) $arcids($a)]
+            } else {
+                puts $f [list $arcstart($a) {} $arcids($a)]
+            }
+        }
     } err]} {
-	catch {close $f}
-	catch {file delete $allccache}
-	#puts "writing cache failed ($err)"
-	return 0
+        catch {close $f}
+        catch {file delete $allccache}
+        #puts "writing cache failed ($err)"
+        return 0
     }
     set cachearc [expr {$a - 1}]
     if {$a > $cachedarcs} {
-	puts $f "1"
-	close $f
-	return 0
+        puts $f "1"
+        close $f
+        return 0
     }
     return 1
 }
@@ -10607,9 +10607,9 @@ proc savecache {} {
     set cachearc 0
     set cachedarcs $nextarc
     catch {
-	set f [open $allccache w]
-	puts $f [list 1 $cachedarcs]
-	run writecache $f
+        set f [open $allccache w]
+        puts $f [list 1 $cachedarcs]
+        run writecache $f
     }
 }
 
@@ -10619,92 +10619,92 @@ proc anc_or_desc {a b} {
     global arcout arcstart arcend arcnos cached_isanc
 
     if {$arcnos($a) eq $arcnos($b)} {
-	# Both are on the same arc(s); either both are the same BMP,
-	# or if one is not a BMP, the other is also not a BMP or is
-	# the BMP at end of the arc (and it only has 1 incoming arc).
-	# Or both can be BMPs with no incoming arcs.
-	if {$a eq $b || $arcnos($a) eq {}} {
-	    return 0
-	}
-	# assert {[llength $arcnos($a)] == 1}
-	set arc [lindex $arcnos($a) 0]
-	set i [lsearch -exact $arcids($arc) $a]
-	set j [lsearch -exact $arcids($arc) $b]
-	if {$i < 0 || $i > $j} {
-	    return 1
-	} else {
-	    return -1
-	}
+        # Both are on the same arc(s); either both are the same BMP,
+        # or if one is not a BMP, the other is also not a BMP or is
+        # the BMP at end of the arc (and it only has 1 incoming arc).
+        # Or both can be BMPs with no incoming arcs.
+        if {$a eq $b || $arcnos($a) eq {}} {
+            return 0
+        }
+        # assert {[llength $arcnos($a)] == 1}
+        set arc [lindex $arcnos($a) 0]
+        set i [lsearch -exact $arcids($arc) $a]
+        set j [lsearch -exact $arcids($arc) $b]
+        if {$i < 0 || $i > $j} {
+            return 1
+        } else {
+            return -1
+        }
     }
 
     if {![info exists arcout($a)]} {
-	set arc [lindex $arcnos($a) 0]
-	if {[info exists arcend($arc)]} {
-	    set aend $arcend($arc)
-	} else {
-	    set aend {}
-	}
-	set a $arcstart($arc)
+        set arc [lindex $arcnos($a) 0]
+        if {[info exists arcend($arc)]} {
+            set aend $arcend($arc)
+        } else {
+            set aend {}
+        }
+        set a $arcstart($arc)
     } else {
-	set aend $a
+        set aend $a
     }
     if {![info exists arcout($b)]} {
-	set arc [lindex $arcnos($b) 0]
-	if {[info exists arcend($arc)]} {
-	    set bend $arcend($arc)
-	} else {
-	    set bend {}
-	}
-	set b $arcstart($arc)
+        set arc [lindex $arcnos($b) 0]
+        if {[info exists arcend($arc)]} {
+            set bend $arcend($arc)
+        } else {
+            set bend {}
+        }
+        set b $arcstart($arc)
     } else {
-	set bend $b
+        set bend $b
     }
     if {$a eq $bend} {
-	return 1
+        return 1
     }
     if {$b eq $aend} {
-	return -1
+        return -1
     }
     if {[info exists cached_isanc($a,$bend)]} {
-	if {$cached_isanc($a,$bend)} {
-	    return 1
-	}
+        if {$cached_isanc($a,$bend)} {
+            return 1
+        }
     }
     if {[info exists cached_isanc($b,$aend)]} {
-	if {$cached_isanc($b,$aend)} {
-	    return -1
-	}
-	if {[info exists cached_isanc($a,$bend)]} {
-	    return 0
-	}
+        if {$cached_isanc($b,$aend)} {
+            return -1
+        }
+        if {[info exists cached_isanc($a,$bend)]} {
+            return 0
+        }
     }
 
     set todo [list $a $b]
     set anc($a) a
     set anc($b) b
     for {set i 0} {$i < [llength $todo]} {incr i} {
-	set x [lindex $todo $i]
-	if {$anc($x) eq {}} {
-	    continue
-	}
-	foreach arc $arcnos($x) {
-	    set xd $arcstart($arc)
-	    if {$xd eq $bend} {
-		set cached_isanc($a,$bend) 1
-		set cached_isanc($b,$aend) 0
-		return 1
-	    } elseif {$xd eq $aend} {
-		set cached_isanc($b,$aend) 1
-		set cached_isanc($a,$bend) 0
-		return -1
-	    }
-	    if {![info exists anc($xd)]} {
-		set anc($xd) $anc($x)
-		lappend todo $xd
-	    } elseif {$anc($xd) ne $anc($x)} {
-		set anc($xd) {}
-	    }
-	}
+        set x [lindex $todo $i]
+        if {$anc($x) eq {}} {
+            continue
+        }
+        foreach arc $arcnos($x) {
+            set xd $arcstart($arc)
+            if {$xd eq $bend} {
+                set cached_isanc($a,$bend) 1
+                set cached_isanc($b,$aend) 0
+                return 1
+            } elseif {$xd eq $aend} {
+                set cached_isanc($b,$aend) 1
+                set cached_isanc($a,$bend) 0
+                return -1
+            }
+            if {![info exists anc($xd)]} {
+                set anc($xd) $anc($x)
+                lappend todo $xd
+            } elseif {$anc($xd) ne $anc($x)} {
+                set anc($xd) {}
+            }
+        }
     }
     set cached_isanc($a,$bend) 0
     set cached_isanc($b,$aend) 0
@@ -10727,90 +10727,90 @@ proc is_certain {desc anc} {
 
     set certain {}
     if {[llength $arcnos($anc)] == 1} {
-	# tags on the same arc are certain
-	if {$arcnos($desc) eq $arcnos($anc)} {
-	    return 1
-	}
-	if {![info exists arcout($anc)]} {
-	    # if $anc is partway along an arc, use the start of the arc instead
-	    set a [lindex $arcnos($anc) 0]
-	    set anc $arcstart($a)
-	}
+        # tags on the same arc are certain
+        if {$arcnos($desc) eq $arcnos($anc)} {
+            return 1
+        }
+        if {![info exists arcout($anc)]} {
+            # if $anc is partway along an arc, use the start of the arc instead
+            set a [lindex $arcnos($anc) 0]
+            set anc $arcstart($a)
+        }
     }
     if {[llength $arcnos($desc)] > 1 || [info exists arcout($desc)]} {
-	set x $desc
+        set x $desc
     } else {
-	set a [lindex $arcnos($desc) 0]
-	set x $arcend($a)
+        set a [lindex $arcnos($desc) 0]
+        set x $arcend($a)
     }
     if {$x == $anc} {
-	return 1
+        return 1
     }
     set anclist [list $x]
     set dl($x) 1
     set nnh 1
     set ngrowanc 0
     for {set i 0} {$i < [llength $anclist] && ($nnh > 0 || $ngrowanc > 0)} {incr i} {
-	set x [lindex $anclist $i]
-	if {$dl($x)} {
-	    incr nnh -1
-	}
-	set done($x) 1
-	foreach a $arcout($x) {
-	    if {[info exists growing($a)]} {
-		if {![info exists growanc($x)] && $dl($x)} {
-		    set growanc($x) 1
-		    incr ngrowanc
-		}
-	    } else {
-		set y $arcend($a)
-		if {[info exists dl($y)]} {
-		    if {$dl($y)} {
-			if {!$dl($x)} {
-			    set dl($y) 0
-			    if {![info exists done($y)]} {
-				incr nnh -1
-			    }
-			    if {[info exists growanc($x)]} {
-				incr ngrowanc -1
-			    }
-			    set xl [list $y]
-			    for {set k 0} {$k < [llength $xl]} {incr k} {
-				set z [lindex $xl $k]
-				foreach c $arcout($z) {
-				    if {[info exists arcend($c)]} {
-					set v $arcend($c)
-					if {[info exists dl($v)] && $dl($v)} {
-					    set dl($v) 0
-					    if {![info exists done($v)]} {
-						incr nnh -1
-					    }
-					    if {[info exists growanc($v)]} {
-						incr ngrowanc -1
-					    }
-					    lappend xl $v
-					}
-				    }
-				}
-			    }
-			}
-		    }
-		} elseif {$y eq $anc || !$dl($x)} {
-		    set dl($y) 0
-		    lappend anclist $y
-		} else {
-		    set dl($y) 1
-		    lappend anclist $y
-		    incr nnh
-		}
-	    }
-	}
+        set x [lindex $anclist $i]
+        if {$dl($x)} {
+            incr nnh -1
+        }
+        set done($x) 1
+        foreach a $arcout($x) {
+            if {[info exists growing($a)]} {
+                if {![info exists growanc($x)] && $dl($x)} {
+                    set growanc($x) 1
+                    incr ngrowanc
+                }
+            } else {
+                set y $arcend($a)
+                if {[info exists dl($y)]} {
+                    if {$dl($y)} {
+                        if {!$dl($x)} {
+                            set dl($y) 0
+                            if {![info exists done($y)]} {
+                                incr nnh -1
+                            }
+                            if {[info exists growanc($x)]} {
+                                incr ngrowanc -1
+                            }
+                            set xl [list $y]
+                            for {set k 0} {$k < [llength $xl]} {incr k} {
+                                set z [lindex $xl $k]
+                                foreach c $arcout($z) {
+                                    if {[info exists arcend($c)]} {
+                                        set v $arcend($c)
+                                        if {[info exists dl($v)] && $dl($v)} {
+                                            set dl($v) 0
+                                            if {![info exists done($v)]} {
+                                                incr nnh -1
+                                            }
+                                            if {[info exists growanc($v)]} {
+                                                incr ngrowanc -1
+                                            }
+                                            lappend xl $v
+                                        }
+                                    }
+                                }
+                            }
+                        }
+                    }
+                } elseif {$y eq $anc || !$dl($x)} {
+                    set dl($y) 0
+                    lappend anclist $y
+                } else {
+                    set dl($y) 1
+                    lappend anclist $y
+                    incr nnh
+                }
+            }
+        }
     }
     foreach x [array names growanc] {
-	if {$dl($x)} {
-	    return 0
-	}
-	return 0
+        if {$dl($x)} {
+            return 0
+        }
+        return 0
     }
     return 1
 }
@@ -10821,11 +10821,11 @@ proc validate_arctags {a} {
     set i -1
     set na $arctags($a)
     foreach id $arctags($a) {
-	incr i
-	if {![info exists idtags($id)]} {
-	    set na [lreplace $na $i $i]
-	    incr i -1
-	}
+        incr i
+        if {![info exists idtags($id)]} {
+            set na [lreplace $na $i $i]
+            incr i -1
+        }
     }
     set arctags($a) $na
 }
@@ -10836,11 +10836,11 @@ proc validate_archeads {a} {
     set i -1
     set na $archeads($a)
     foreach id $archeads($a) {
-	incr i
-	if {![info exists idheads($id)]} {
-	    set na [lreplace $na $i $i]
-	    incr i -1
-	}
+        incr i
+        if {![info exists idheads($id)]} {
+            set na [lreplace $na $i $i]
+            incr i -1
+        }
     }
     set archeads($a) $na
 }
@@ -10852,33 +10852,33 @@ proc desctags {id} {
     global growing cached_dtags
 
     if {![info exists allparents($id)]} {
-	return {}
+        return {}
     }
     set t1 [clock clicks -milliseconds]
     set argid $id
     if {[llength $arcnos($id)] == 1 && [llength $allparents($id)] == 1} {
-	# part-way along an arc; check that arc first
-	set a [lindex $arcnos($id) 0]
-	if {$arctags($a) ne {}} {
-	    validate_arctags $a
-	    set i [lsearch -exact $arcids($a) $id]
-	    set tid {}
-	    foreach t $arctags($a) {
-		set j [lsearch -exact $arcids($a) $t]
-		if {$j >= $i} break
-		set tid $t
-	    }
-	    if {$tid ne {}} {
-		return $tid
-	    }
-	}
-	set id $arcstart($a)
-	if {[info exists idtags($id)]} {
-	    return $id
-	}
+        # part-way along an arc; check that arc first
+        set a [lindex $arcnos($id) 0]
+        if {$arctags($a) ne {}} {
+            validate_arctags $a
+            set i [lsearch -exact $arcids($a) $id]
+            set tid {}
+            foreach t $arctags($a) {
+                set j [lsearch -exact $arcids($a) $t]
+                if {$j >= $i} break
+                set tid $t
+            }
+            if {$tid ne {}} {
+                return $tid
+            }
+        }
+        set id $arcstart($a)
+        if {[info exists idtags($id)]} {
+            return $id
+        }
     }
     if {[info exists cached_dtags($id)]} {
-	return $cached_dtags($id)
+        return $cached_dtags($id)
     }
 
     set origid $id
@@ -10886,111 +10886,111 @@ proc desctags {id} {
     set queued($id) 1
     set nc 1
     for {set i 0} {$i < [llength $todo] && $nc > 0} {incr i} {
-	set id [lindex $todo $i]
-	set done($id) 1
-	set ta [info exists hastaggedancestor($id)]
-	if {!$ta} {
-	    incr nc -1
-	}
-	# ignore tags on starting node
-	if {!$ta && $i > 0} {
-	    if {[info exists idtags($id)]} {
-		set tagloc($id) $id
-		set ta 1
-	    } elseif {[info exists cached_dtags($id)]} {
-		set tagloc($id) $cached_dtags($id)
-		set ta 1
-	    }
-	}
-	foreach a $arcnos($id) {
-	    set d $arcstart($a)
-	    if {!$ta && $arctags($a) ne {}} {
-		validate_arctags $a
-		if {$arctags($a) ne {}} {
-		    lappend tagloc($id) [lindex $arctags($a) end]
-		}
-	    }
-	    if {$ta || $arctags($a) ne {}} {
-		set tomark [list $d]
-		for {set j 0} {$j < [llength $tomark]} {incr j} {
-		    set dd [lindex $tomark $j]
-		    if {![info exists hastaggedancestor($dd)]} {
-			if {[info exists done($dd)]} {
-			    foreach b $arcnos($dd) {
-				lappend tomark $arcstart($b)
-			    }
-			    if {[info exists tagloc($dd)]} {
-				unset tagloc($dd)
-			    }
-			} elseif {[info exists queued($dd)]} {
-			    incr nc -1
-			}
-			set hastaggedancestor($dd) 1
-		    }
-		}
-	    }
-	    if {![info exists queued($d)]} {
-		lappend todo $d
-		set queued($d) 1
-		if {![info exists hastaggedancestor($d)]} {
-		    incr nc
-		}
-	    }
-	}
+        set id [lindex $todo $i]
+        set done($id) 1
+        set ta [info exists hastaggedancestor($id)]
+        if {!$ta} {
+            incr nc -1
+        }
+        # ignore tags on starting node
+        if {!$ta && $i > 0} {
+            if {[info exists idtags($id)]} {
+                set tagloc($id) $id
+                set ta 1
+            } elseif {[info exists cached_dtags($id)]} {
+                set tagloc($id) $cached_dtags($id)
+                set ta 1
+            }
+        }
+        foreach a $arcnos($id) {
+            set d $arcstart($a)
+            if {!$ta && $arctags($a) ne {}} {
+                validate_arctags $a
+                if {$arctags($a) ne {}} {
+                    lappend tagloc($id) [lindex $arctags($a) end]
+                }
+            }
+            if {$ta || $arctags($a) ne {}} {
+                set tomark [list $d]
+                for {set j 0} {$j < [llength $tomark]} {incr j} {
+                    set dd [lindex $tomark $j]
+                    if {![info exists hastaggedancestor($dd)]} {
+                        if {[info exists done($dd)]} {
+                            foreach b $arcnos($dd) {
+                                lappend tomark $arcstart($b)
+                            }
+                            if {[info exists tagloc($dd)]} {
+                                unset tagloc($dd)
+                            }
+                        } elseif {[info exists queued($dd)]} {
+                            incr nc -1
+                        }
+                        set hastaggedancestor($dd) 1
+                    }
+                }
+            }
+            if {![info exists queued($d)]} {
+                lappend todo $d
+                set queued($d) 1
+                if {![info exists hastaggedancestor($d)]} {
+                    incr nc
+                }
+            }
+        }
     }
     set tags {}
     foreach id [array names tagloc] {
-	if {![info exists hastaggedancestor($id)]} {
-	    foreach t $tagloc($id) {
-		if {[lsearch -exact $tags $t] < 0} {
-		    lappend tags $t
-		}
-	    }
-	}
+        if {![info exists hastaggedancestor($id)]} {
+            foreach t $tagloc($id) {
+                if {[lsearch -exact $tags $t] < 0} {
+                    lappend tags $t
+                }
+            }
+        }
     }
     set t2 [clock clicks -milliseconds]
     set loopix $i
 
     # remove tags that are descendents of other tags
     for {set i 0} {$i < [llength $tags]} {incr i} {
-	set a [lindex $tags $i]
-	for {set j 0} {$j < $i} {incr j} {
-	    set b [lindex $tags $j]
-	    set r [anc_or_desc $a $b]
-	    if {$r == 1} {
-		set tags [lreplace $tags $j $j]
-		incr j -1
-		incr i -1
-	    } elseif {$r == -1} {
-		set tags [lreplace $tags $i $i]
-		incr i -1
-		break
-	    }
-	}
+        set a [lindex $tags $i]
+        for {set j 0} {$j < $i} {incr j} {
+            set b [lindex $tags $j]
+            set r [anc_or_desc $a $b]
+            if {$r == 1} {
+                set tags [lreplace $tags $j $j]
+                incr j -1
+                incr i -1
+            } elseif {$r == -1} {
+                set tags [lreplace $tags $i $i]
+                incr i -1
+                break
+            }
+        }
     }
 
     if {[array names growing] ne {}} {
-	# graph isn't finished, need to check if any tag could get
-	# eclipsed by another tag coming later.  Simply ignore any
-	# tags that could later get eclipsed.
-	set ctags {}
-	foreach t $tags {
-	    if {[is_certain $t $origid]} {
-		lappend ctags $t
-	    }
-	}
-	if {$tags eq $ctags} {
-	    set cached_dtags($origid) $tags
-	} else {
-	    set tags $ctags
-	}
+        # graph isn't finished, need to check if any tag could get
+        # eclipsed by another tag coming later.  Simply ignore any
+        # tags that could later get eclipsed.
+        set ctags {}
+        foreach t $tags {
+            if {[is_certain $t $origid]} {
+                lappend ctags $t
+            }
+        }
+        if {$tags eq $ctags} {
+            set cached_dtags($origid) $tags
+        } else {
+            set tags $ctags
+        }
     } else {
-	set cached_dtags($origid) $tags
+        set cached_dtags($origid) $tags
     }
     set t3 [clock clicks -milliseconds]
     if {0 && $t3 - $t1 >= 100} {
-	puts "iterating descendents ($loopix/[llength $todo] nodes) took\
-    	    [expr {$t2-$t1}]+[expr {$t3-$t2}]ms, $nc candidates left"
+        puts "iterating descendents ($loopix/[llength $todo] nodes) took\
+            [expr {$t2-$t1}]+[expr {$t3-$t2}]ms, $nc candidates left"
     }
     return $tags
 }
@@ -11000,33 +11000,33 @@ proc anctags {id} {
     global growing cached_atags
 
     if {![info exists allparents($id)]} {
-	return {}
+        return {}
     }
     set t1 [clock clicks -milliseconds]
     set argid $id
     if {[llength $arcnos($id)] == 1 && [llength $allparents($id)] == 1} {
-	# part-way along an arc; check that arc first
-	set a [lindex $arcnos($id) 0]
-	if {$arctags($a) ne {}} {
-	    validate_arctags $a
-	    set i [lsearch -exact $arcids($a) $id]
-	    foreach t $arctags($a) {
-		set j [lsearch -exact $arcids($a) $t]
-		if {$j > $i} {
-		    return $t
-		}
-	    }
-	}
-	if {![info exists arcend($a)]} {
-	    return {}
-	}
-	set id $arcend($a)
-	if {[info exists idtags($id)]} {
-	    return $id
-	}
+        # part-way along an arc; check that arc first
+        set a [lindex $arcnos($id) 0]
+        if {$arctags($a) ne {}} {
+            validate_arctags $a
+            set i [lsearch -exact $arcids($a) $id]
+            foreach t $arctags($a) {
+                set j [lsearch -exact $arcids($a) $t]
+                if {$j > $i} {
+                    return $t
+                }
+            }
+        }
+        if {![info exists arcend($a)]} {
+            return {}
+        }
+        set id $arcend($a)
+        if {[info exists idtags($id)]} {
+            return $id
+        }
     }
     if {[info exists cached_atags($id)]} {
-	return $cached_atags($id)
+        return $cached_atags($id)
     }
 
     set origid $id
@@ -11035,114 +11035,114 @@ proc anctags {id} {
     set taglist {}
     set nc 1
     for {set i 0} {$i < [llength $todo] && $nc > 0} {incr i} {
-	set id [lindex $todo $i]
-	set done($id) 1
-	set td [info exists hastaggeddescendent($id)]
-	if {!$td} {
-	    incr nc -1
-	}
-	# ignore tags on starting node
-	if {!$td && $i > 0} {
-	    if {[info exists idtags($id)]} {
-		set tagloc($id) $id
-		set td 1
-	    } elseif {[info exists cached_atags($id)]} {
-		set tagloc($id) $cached_atags($id)
-		set td 1
-	    }
-	}
-	foreach a $arcout($id) {
-	    if {!$td && $arctags($a) ne {}} {
-		validate_arctags $a
-		if {$arctags($a) ne {}} {
-		    lappend tagloc($id) [lindex $arctags($a) 0]
-		}
-	    }
-	    if {![info exists arcend($a)]} continue
-	    set d $arcend($a)
-	    if {$td || $arctags($a) ne {}} {
-		set tomark [list $d]
-		for {set j 0} {$j < [llength $tomark]} {incr j} {
-		    set dd [lindex $tomark $j]
-		    if {![info exists hastaggeddescendent($dd)]} {
-			if {[info exists done($dd)]} {
-			    foreach b $arcout($dd) {
-				if {[info exists arcend($b)]} {
-				    lappend tomark $arcend($b)
-				}
-			    }
-			    if {[info exists tagloc($dd)]} {
-				unset tagloc($dd)
-			    }
-			} elseif {[info exists queued($dd)]} {
-			    incr nc -1
-			}
-			set hastaggeddescendent($dd) 1
-		    }
-		}
-	    }
-	    if {![info exists queued($d)]} {
-		lappend todo $d
-		set queued($d) 1
-		if {![info exists hastaggeddescendent($d)]} {
-		    incr nc
-		}
-	    }
-	}
+        set id [lindex $todo $i]
+        set done($id) 1
+        set td [info exists hastaggeddescendent($id)]
+        if {!$td} {
+            incr nc -1
+        }
+        # ignore tags on starting node
+        if {!$td && $i > 0} {
+            if {[info exists idtags($id)]} {
+                set tagloc($id) $id
+                set td 1
+            } elseif {[info exists cached_atags($id)]} {
+                set tagloc($id) $cached_atags($id)
+                set td 1
+            }
+        }
+        foreach a $arcout($id) {
+            if {!$td && $arctags($a) ne {}} {
+                validate_arctags $a
+                if {$arctags($a) ne {}} {
+                    lappend tagloc($id) [lindex $arctags($a) 0]
+                }
+            }
+            if {![info exists arcend($a)]} continue
+            set d $arcend($a)
+            if {$td || $arctags($a) ne {}} {
+                set tomark [list $d]
+                for {set j 0} {$j < [llength $tomark]} {incr j} {
+                    set dd [lindex $tomark $j]
+                    if {![info exists hastaggeddescendent($dd)]} {
+                        if {[info exists done($dd)]} {
+                            foreach b $arcout($dd) {
+                                if {[info exists arcend($b)]} {
+                                    lappend tomark $arcend($b)
+                                }
+                            }
+                            if {[info exists tagloc($dd)]} {
+                                unset tagloc($dd)
+                            }
+                        } elseif {[info exists queued($dd)]} {
+                            incr nc -1
+                        }
+                        set hastaggeddescendent($dd) 1
+                    }
+                }
+            }
+            if {![info exists queued($d)]} {
+                lappend todo $d
+                set queued($d) 1
+                if {![info exists hastaggeddescendent($d)]} {
+                    incr nc
+                }
+            }
+        }
     }
     set t2 [clock clicks -milliseconds]
     set loopix $i
     set tags {}
     foreach id [array names tagloc] {
-	if {![info exists hastaggeddescendent($id)]} {
-	    foreach t $tagloc($id) {
-		if {[lsearch -exact $tags $t] < 0} {
-		    lappend tags $t
-		}
-	    }
-	}
+        if {![info exists hastaggeddescendent($id)]} {
+            foreach t $tagloc($id) {
+                if {[lsearch -exact $tags $t] < 0} {
+                    lappend tags $t
+                }
+            }
+        }
     }
 
     # remove tags that are ancestors of other tags
     for {set i 0} {$i < [llength $tags]} {incr i} {
-	set a [lindex $tags $i]
-	for {set j 0} {$j < $i} {incr j} {
-	    set b [lindex $tags $j]
-	    set r [anc_or_desc $a $b]
-	    if {$r == -1} {
-		set tags [lreplace $tags $j $j]
-		incr j -1
-		incr i -1
-	    } elseif {$r == 1} {
-		set tags [lreplace $tags $i $i]
-		incr i -1
-		break
-	    }
-	}
+        set a [lindex $tags $i]
+        for {set j 0} {$j < $i} {incr j} {
+            set b [lindex $tags $j]
+            set r [anc_or_desc $a $b]
+            if {$r == -1} {
+                set tags [lreplace $tags $j $j]
+                incr j -1
+                incr i -1
+            } elseif {$r == 1} {
+                set tags [lreplace $tags $i $i]
+                incr i -1
+                break
+            }
+        }
     }
 
     if {[array names growing] ne {}} {
-	# graph isn't finished, need to check if any tag could get
-	# eclipsed by another tag coming later.  Simply ignore any
-	# tags that could later get eclipsed.
-	set ctags {}
-	foreach t $tags {
-	    if {[is_certain $origid $t]} {
-		lappend ctags $t
-	    }
-	}
-	if {$tags eq $ctags} {
-	    set cached_atags($origid) $tags
-	} else {
-	    set tags $ctags
-	}
+        # graph isn't finished, need to check if any tag could get
+        # eclipsed by another tag coming later.  Simply ignore any
+        # tags that could later get eclipsed.
+        set ctags {}
+        foreach t $tags {
+            if {[is_certain $origid $t]} {
+                lappend ctags $t
+            }
+        }
+        if {$tags eq $ctags} {
+            set cached_atags($origid) $tags
+        } else {
+            set tags $ctags
+        }
     } else {
-	set cached_atags($origid) $tags
+        set cached_atags($origid) $tags
     }
     set t3 [clock clicks -milliseconds]
     if {0 && $t3 - $t1 >= 100} {
-	puts "iterating ancestors ($loopix/[llength $todo] nodes) took\
-    	    [expr {$t2-$t1}]+[expr {$t3-$t2}]ms, $nc candidates left"
+        puts "iterating ancestors ($loopix/[llength $todo] nodes) took\
+            [expr {$t2-$t1}]+[expr {$t3-$t2}]ms, $nc candidates left"
     }
     return $tags
 }
@@ -11154,49 +11154,49 @@ proc descheads {id} {
     global allparents arcout
 
     if {![info exists allparents($id)]} {
-	return {}
+        return {}
     }
     set aret {}
     if {![info exists arcout($id)]} {
-	# part-way along an arc; check it first
-	set a [lindex $arcnos($id) 0]
-	if {$archeads($a) ne {}} {
-	    validate_archeads $a
-	    set i [lsearch -exact $arcids($a) $id]
-	    foreach t $archeads($a) {
-		set j [lsearch -exact $arcids($a) $t]
-		if {$j > $i} break
-		lappend aret $t
-	    }
-	}
-	set id $arcstart($a)
+        # part-way along an arc; check it first
+        set a [lindex $arcnos($id) 0]
+        if {$archeads($a) ne {}} {
+            validate_archeads $a
+            set i [lsearch -exact $arcids($a) $id]
+            foreach t $archeads($a) {
+                set j [lsearch -exact $arcids($a) $t]
+                if {$j > $i} break
+                lappend aret $t
+            }
+        }
+        set id $arcstart($a)
     }
     set origid $id
     set todo [list $id]
     set seen($id) 1
     set ret {}
     for {set i 0} {$i < [llength $todo]} {incr i} {
-	set id [lindex $todo $i]
-	if {[info exists cached_dheads($id)]} {
-	    set ret [concat $ret $cached_dheads($id)]
-	} else {
-	    if {[info exists idheads($id)]} {
-		lappend ret $id
-	    }
-	    foreach a $arcnos($id) {
-		if {$archeads($a) ne {}} {
-		    validate_archeads $a
-		    if {$archeads($a) ne {}} {
-			set ret [concat $ret $archeads($a)]
-		    }
-		}
-		set d $arcstart($a)
-		if {![info exists seen($d)]} {
-		    lappend todo $d
-		    set seen($d) 1
-		}
-	    }
-	}
+        set id [lindex $todo $i]
+        if {[info exists cached_dheads($id)]} {
+            set ret [concat $ret $cached_dheads($id)]
+        } else {
+            if {[info exists idheads($id)]} {
+                lappend ret $id
+            }
+            foreach a $arcnos($id) {
+                if {$archeads($a) ne {}} {
+                    validate_archeads $a
+                    if {$archeads($a) ne {}} {
+                        set ret [concat $ret $archeads($a)]
+                    }
+                }
+                set d $arcstart($a)
+                if {![info exists seen($d)]} {
+                    lappend todo $d
+                    set seen($d) 1
+                }
+            }
+        }
     }
     set ret [lsort -unique $ret]
     set cached_dheads($origid) $ret
@@ -11208,7 +11208,7 @@ proc addedtag {id} {
 
     if {![info exists arcnos($id)]} return
     if {![info exists arcout($id)]} {
-	recalcarc [lindex $arcnos($id) 0]
+        recalcarc [lindex $arcnos($id) 0]
     }
     unset -nocomplain cached_dtags
     unset -nocomplain cached_atags
@@ -11219,7 +11219,7 @@ proc addedhead {hid head} {
 
     if {![info exists arcnos($hid)]} return
     if {![info exists arcout($hid)]} {
-	recalcarc [lindex $arcnos($hid) 0]
+        recalcarc [lindex $arcnos($hid) 0]
     }
     unset -nocomplain cached_dheads
 }
@@ -11235,7 +11235,7 @@ proc movedhead {hid head} {
 
     if {![info exists arcnos($hid)]} return
     if {![info exists arcout($hid)]} {
-	recalcarc [lindex $arcnos($hid) 0]
+        recalcarc [lindex $arcnos($hid) 0]
     }
     unset -nocomplain cached_dheads
 }
@@ -11245,13 +11245,13 @@ proc changedrefs {} {
     global arctags archeads arcnos arcout idheads idtags
 
     foreach id [concat [array names idheads] [array names idtags]] {
-	if {[info exists arcnos($id)] && ![info exists arcout($id)]} {
-	    set a [lindex $arcnos($id) 0]
-	    if {![info exists donearc($a)]} {
-		recalcarc $a
-		set donearc($a) 1
-	    }
-	}
+        if {[info exists arcnos($id)] && ![info exists arcout($id)]} {
+            set a [lindex $arcnos($id) 0]
+            if {![info exists donearc($a)]} {
+                recalcarc $a
+                set donearc($a) 1
+            }
+        }
     }
     unset -nocomplain cached_tagcontent
     unset -nocomplain cached_dtags
@@ -11263,26 +11263,26 @@ proc rereadrefs {} {
     global idtags idheads idotherrefs mainheadid
 
     set refids [concat [array names idtags] \
-		    [array names idheads] [array names idotherrefs]]
+                    [array names idheads] [array names idotherrefs]]
     foreach id $refids {
-	if {![info exists ref($id)]} {
-	    set ref($id) [listrefs $id]
-	}
+        if {![info exists ref($id)]} {
+            set ref($id) [listrefs $id]
+        }
     }
     set oldmainhead $mainheadid
     readrefs
     changedrefs
     set refids [lsort -unique [concat $refids [array names idtags] \
-			[array names idheads] [array names idotherrefs]]]
+                        [array names idheads] [array names idotherrefs]]]
     foreach id $refids {
-	set v [listrefs $id]
-	if {![info exists ref($id)] || $ref($id) != $v} {
-	    redrawtags $id
-	}
+        set v [listrefs $id]
+        if {![info exists ref($id)] || $ref($id) != $v} {
+            redrawtags $id
+        }
     }
     if {$oldmainhead ne $mainheadid} {
-	redrawtags $oldmainhead
-	redrawtags $mainheadid
+        redrawtags $oldmainhead
+        redrawtags $mainheadid
     }
     run refill_reflist
 }
@@ -11292,15 +11292,15 @@ proc listrefs {id} {
 
     set x {}
     if {[info exists idtags($id)]} {
-	set x $idtags($id)
+        set x $idtags($id)
     }
     set y {}
     if {[info exists idheads($id)]} {
-	set y $idheads($id)
+        set y $idheads($id)
     }
     set z {}
     if {[info exists idotherrefs($id)]} {
-	set z $idotherrefs($id)
+        set z $idotherrefs($id)
     }
     return [list $x $y $z]
 }
@@ -11309,15 +11309,15 @@ proc add_tag_ctext {tag} {
     global ctext cached_tagcontent tagids
 
     if {![info exists cached_tagcontent($tag)]} {
-	catch {
-	    set cached_tagcontent($tag) [exec git cat-file -p $tag]
-	}
+        catch {
+            set cached_tagcontent($tag) [exec git cat-file -p $tag]
+        }
     }
     $ctext insert end "[mc "Tag"]: $tag\n" bold
     if {[info exists cached_tagcontent($tag)]} {
-	set text $cached_tagcontent($tag)
+        set text $cached_tagcontent($tag)
     } else {
-	set text "[mc "Id"]:  $tagids($tag)"
+        set text "[mc "Id"]:  $tagids($tag)"
     }
     appendwithlinks $text {}
 }
@@ -11326,7 +11326,7 @@ proc showtag {tag isnew} {
     global ctext cached_tagcontent tagids linknum tagobjid
 
     if {$isnew} {
-	addtohistory [list showtag $tag 0] savectextpos
+        addtohistory [list showtag $tag 0] savectextpos
     }
     $ctext conf -state normal
     clear_ctext
@@ -11342,7 +11342,7 @@ proc showtags {id isnew} {
     global idtags ctext linknum
 
     if {$isnew} {
-	addtohistory [list showtags $id 0] savectextpos
+        addtohistory [list showtags $id 0] savectextpos
     }
     $ctext conf -state normal
     clear_ctext
@@ -11350,9 +11350,9 @@ proc showtags {id isnew} {
     set linknum 0
     set sep {}
     foreach tag $idtags($id) {
-	$ctext insert end $sep
-	add_tag_ctext $tag
-	set sep "\n\n"
+        $ctext insert end $sep
+        add_tag_ctext $tag
+        set sep "\n\n"
     }
     maybe_scroll_ctext 1
     $ctext conf -state disabled
@@ -11368,7 +11368,7 @@ proc doquit {} {
     destroy .
 
     if {[info exists gitktmpdir]} {
-	catch {file delete -force $gitktmpdir}
+        catch {file delete -force $gitktmpdir}
     }
 }
 
@@ -11377,9 +11377,9 @@ proc mkfontdisp {font top which} {
 
     set fontpref($font) [set $font]
     ${NS}::button $top.${font}but -text $which \
-	-command [list choosefont $font $which]
+        -command [list choosefont $font $which]
     ${NS}::label $top.$font -relief flat -font $font \
-	-text $fontattr($font,family) -justify left
+        -text $fontattr($font,family) -justify left
     grid x $top.${font}but $top.$font -sticky w
 }
 
@@ -11396,58 +11396,58 @@ proc choosefont {font which} {
     set top .gitkfont
     set fonttop $top
     if {![winfo exists $top]} {
-	font create sample
-	eval font config sample [font actual $font]
-	ttk_toplevel $top
-	make_transient $top $prefstop
-	wm title $top [mc "Gitk font chooser"]
-	${NS}::label $top.l -textvariable fontparam(which)
-	pack $top.l -side top
-	set fontlist [lsort [font families]]
-	${NS}::frame $top.f
-	listbox $top.f.fam -listvariable fontlist \
-	    -yscrollcommand [list $top.f.sb set]
-	bind $top.f.fam <<ListboxSelect>> selfontfam
-	${NS}::scrollbar $top.f.sb -command [list $top.f.fam yview]
-	pack $top.f.sb -side right -fill y
-	pack $top.f.fam -side left -fill both -expand 1
-	pack $top.f -side top -fill both -expand 1
-	${NS}::frame $top.g
-	spinbox $top.g.size -from 4 -to 40 -width 4 \
-	    -textvariable fontparam(size) \
-	    -validatecommand {string is integer -strict %s}
-	checkbutton $top.g.bold -padx 5 \
-	    -font {{Times New Roman} 12 bold} -text [mc "B"] -indicatoron 0 \
-	    -variable fontparam(weight) -onvalue bold -offvalue normal
-	checkbutton $top.g.ital -padx 5 \
-	    -font {{Times New Roman} 12 italic} -text [mc "I"] -indicatoron 0  \
-	    -variable fontparam(slant) -onvalue italic -offvalue roman
-	pack $top.g.size $top.g.bold $top.g.ital -side left
-	pack $top.g -side top
-	canvas $top.c -width 150 -height 50 -border 2 -relief sunk \
-	    -background white
-	$top.c create text 100 25 -anchor center -text $which -font sample \
-	    -fill black -tags text
-	bind $top.c <Configure> [list centertext $top.c]
-	pack $top.c -side top -fill x
-	${NS}::frame $top.buts
-	${NS}::button $top.buts.ok -text [mc "OK"] -command fontok -default active
-	${NS}::button $top.buts.can -text [mc "Cancel"] -command fontcan -default normal
-	bind $top <Key-Return> fontok
-	bind $top <Key-Escape> fontcan
-	grid $top.buts.ok $top.buts.can
-	grid columnconfigure $top.buts 0 -weight 1 -uniform a
-	grid columnconfigure $top.buts 1 -weight 1 -uniform a
-	pack $top.buts -side bottom -fill x
-	trace add variable fontparam write chg_fontparam
+        font create sample
+        eval font config sample [font actual $font]
+        ttk_toplevel $top
+        make_transient $top $prefstop
+        wm title $top [mc "Gitk font chooser"]
+        ${NS}::label $top.l -textvariable fontparam(which)
+        pack $top.l -side top
+        set fontlist [lsort [font families]]
+        ${NS}::frame $top.f
+        listbox $top.f.fam -listvariable fontlist \
+            -yscrollcommand [list $top.f.sb set]
+        bind $top.f.fam <<ListboxSelect>> selfontfam
+        ${NS}::scrollbar $top.f.sb -command [list $top.f.fam yview]
+        pack $top.f.sb -side right -fill y
+        pack $top.f.fam -side left -fill both -expand 1
+        pack $top.f -side top -fill both -expand 1
+        ${NS}::frame $top.g
+        spinbox $top.g.size -from 4 -to 40 -width 4 \
+            -textvariable fontparam(size) \
+            -validatecommand {string is integer -strict %s}
+        checkbutton $top.g.bold -padx 5 \
+            -font {{Times New Roman} 12 bold} -text [mc "B"] -indicatoron 0 \
+            -variable fontparam(weight) -onvalue bold -offvalue normal
+        checkbutton $top.g.ital -padx 5 \
+            -font {{Times New Roman} 12 italic} -text [mc "I"] -indicatoron 0  \
+            -variable fontparam(slant) -onvalue italic -offvalue roman
+        pack $top.g.size $top.g.bold $top.g.ital -side left
+        pack $top.g -side top
+        canvas $top.c -width 150 -height 50 -border 2 -relief sunk \
+            -background white
+        $top.c create text 100 25 -anchor center -text $which -font sample \
+            -fill black -tags text
+        bind $top.c <Configure> [list centertext $top.c]
+        pack $top.c -side top -fill x
+        ${NS}::frame $top.buts
+        ${NS}::button $top.buts.ok -text [mc "OK"] -command fontok -default active
+        ${NS}::button $top.buts.can -text [mc "Cancel"] -command fontcan -default normal
+        bind $top <Key-Return> fontok
+        bind $top <Key-Escape> fontcan
+        grid $top.buts.ok $top.buts.can
+        grid columnconfigure $top.buts 0 -weight 1 -uniform a
+        grid columnconfigure $top.buts 1 -weight 1 -uniform a
+        pack $top.buts -side bottom -fill x
+        trace add variable fontparam write chg_fontparam
     } else {
-	raise $top
-	$top.c itemconf text -text $which
+        raise $top
+        $top.c itemconf text -text $which
     }
     set i [lsearch -exact $fontlist $fontparam(family)]
     if {$i >= 0} {
-	$top.f.fam selection set $i
-	$top.f.fam see $i
+        $top.f.fam selection set $i
+        $top.f.fam see $i
     }
 }
 
@@ -11461,10 +11461,10 @@ proc fontok {} {
     set f $fontparam(font)
     set fontpref($f) [list $fontparam(family) $fontparam(size)]
     if {$fontparam(weight) eq "bold"} {
-	lappend fontpref($f) "bold"
+        lappend fontpref($f) "bold"
     }
     if {$fontparam(slant) eq "italic"} {
-	lappend fontpref($f) "italic"
+        lappend fontpref($f) "italic"
     }
     set w $prefstop.notebook.fonts.$f
     $w conf -text $fontparam(family) -font $fontpref($f)
@@ -11476,10 +11476,10 @@ proc fontcan {} {
     global fonttop fontparam
 
     if {[info exists fonttop]} {
-	catch {destroy $fonttop}
-	catch {font delete sample}
-	unset fonttop
-	unset fontparam
+        catch {destroy $fonttop}
+        catch {font delete sample}
+        unset fonttop
+        unset fontparam
     }
 }
 
@@ -11487,21 +11487,21 @@ if {[package vsatisfies [package provide Tk] 8.6]} {
     # In Tk 8.6 we have a native font chooser dialog. Overwrite the above
     # function to make use of it.
     proc choosefont {font which} {
-	tk fontchooser configure -title $which -font $font \
-	    -command [list on_choosefont $font $which]
-	tk fontchooser show
+        tk fontchooser configure -title $which -font $font \
+            -command [list on_choosefont $font $which]
+        tk fontchooser show
     }
     proc on_choosefont {font which newfont} {
-	global fontparam
-	puts stderr "$font $newfont"
-	array set f [font actual $newfont]
-	set fontparam(which) $which
-	set fontparam(font) $font
-	set fontparam(family) $f(-family)
-	set fontparam(size) $f(-size)
-	set fontparam(weight) $f(-weight)
-	set fontparam(slant) $f(-slant)
-	fontok
+        global fontparam
+        puts stderr "$font $newfont"
+        array set f [font actual $newfont]
+        set fontparam(which) $which
+        set fontparam(font) $font
+        set fontparam(family) $f(-family)
+        set fontparam(size) $f(-size)
+        set fontparam(weight) $f(-weight)
+        set fontparam(slant) $f(-slant)
+        fontok
     }
 }
 
@@ -11510,7 +11510,7 @@ proc selfontfam {} {
 
     set i [$fonttop.f.fam curselection]
     if {$i ne {}} {
-	set fontparam(family) [$fonttop.f.fam get $i]
+        set fontparam(family) [$fonttop.f.fam get $i]
     }
 }
 
@@ -11525,9 +11525,9 @@ proc create_prefs_page {w} {
     global NS
     set parent [join [lrange [split $w .] 0 end-1] .]
     if {[winfo class $parent] eq "TNotebook"} {
-	${NS}::frame $w
+        ${NS}::frame $w
     } else {
-	${NS}::labelframe $w
+        ${NS}::labelframe $w
     }
 }
 
@@ -11549,14 +11549,14 @@ proc prefspage_general {notebook} {
     spinbox $page.maxpct -from 1 -to 100 -width 4 -textvariable maxgraphpct
     grid x $page.maxpctl $page.maxpct -sticky w
     ${NS}::checkbutton $page.showlocal -text [mc "Show local changes"] \
-	-variable showlocalchanges
+        -variable showlocalchanges
     grid x $page.showlocal -sticky w
     ${NS}::checkbutton $page.autoselect -text [mc "Auto-select SHA1 (length)"] \
-	-variable autoselect
+        -variable autoselect
     spinbox $page.autosellen -from 1 -to 40 -width 4 -textvariable autosellen
     grid x $page.autoselect $page.autosellen -sticky w
     ${NS}::checkbutton $page.hideremotes -text [mc "Hide remote refs"] \
-	-variable hideremotes
+        -variable hideremotes
     grid x $page.hideremotes -sticky w
 
     ${NS}::label $page.ddisp -text [mc "Diff display options"]
@@ -11565,16 +11565,16 @@ proc prefspage_general {notebook} {
     spinbox $page.tabstop -from 1 -to 20 -width 4 -textvariable tabstop
     grid x $page.tabstopl $page.tabstop -sticky w
     ${NS}::checkbutton $page.ntag -text [mc "Display nearby tags/heads"] \
-	-variable showneartags
+        -variable showneartags
     grid x $page.ntag -sticky w
     ${NS}::label $page.maxrefsl -text [mc "Maximum # tags/heads to show"]
     spinbox $page.maxrefs -from 1 -to 1000 -width 4 -textvariable maxrefs
     grid x $page.maxrefsl $page.maxrefs -sticky w
     ${NS}::checkbutton $page.ldiff -text [mc "Limit diffs to listed paths"] \
-	-variable limitdiffs
+        -variable limitdiffs
     grid x $page.ldiff -sticky w
     ${NS}::checkbutton $page.lattr -text [mc "Support per-file encodings"] \
-	-variable perfile_attrs
+        -variable perfile_attrs
     grid x $page.lattr -sticky w
 
     ${NS}::entry $page.extdifft -textvariable extdifftool
@@ -11595,11 +11595,11 @@ proc prefspage_general {notebook} {
     ${NS}::label $page.lgen -text [mc "General options"]
     grid $page.lgen - -sticky w -pady 10
     ${NS}::checkbutton $page.want_ttk -variable want_ttk \
-	-text [mc "Use themed widgets"]
+        -text [mc "Use themed widgets"]
     if {$have_ttk} {
-	${NS}::label $page.ttk_note -text [mc "(change requires restart)"]
+        ${NS}::label $page.ttk_note -text [mc "(change requires restart)"]
     } else {
-	${NS}::label $page.ttk_note -text [mc "(currently unavailable)"]
+        ${NS}::label $page.ttk_note -text [mc "(currently unavailable)"]
     }
     grid x $page.want_ttk $page.ttk_note -sticky w
     return $page
@@ -11618,37 +11618,37 @@ proc prefspage_colors {notebook} {
     grid x $page.uibut $page.ui -sticky w
     label $page.bg -padx 40 -relief sunk -background $bgcolor
     ${NS}::button $page.bgbut -text [mc "Background"] \
-	-command [list choosecolor bgcolor {} $page.bg [mc "background"] setbg]
+        -command [list choosecolor bgcolor {} $page.bg [mc "background"] setbg]
     grid x $page.bgbut $page.bg -sticky w
     label $page.fg -padx 40 -relief sunk -background $fgcolor
     ${NS}::button $page.fgbut -text [mc "Foreground"] \
-	-command [list choosecolor fgcolor {} $page.fg [mc "foreground"] setfg]
+        -command [list choosecolor fgcolor {} $page.fg [mc "foreground"] setfg]
     grid x $page.fgbut $page.fg -sticky w
     label $page.diffold -padx 40 -relief sunk -background [lindex $diffcolors 0]
     ${NS}::button $page.diffoldbut -text [mc "Diff: old lines"] \
-	-command [list choosecolor diffcolors 0 $page.diffold [mc "diff old lines"] \
-		      [list $ctext tag conf d0 -foreground]]
+        -command [list choosecolor diffcolors 0 $page.diffold [mc "diff old lines"] \
+                      [list $ctext tag conf d0 -foreground]]
     grid x $page.diffoldbut $page.diffold -sticky w
     label $page.diffnew -padx 40 -relief sunk -background [lindex $diffcolors 1]
     ${NS}::button $page.diffnewbut -text [mc "Diff: new lines"] \
-	-command [list choosecolor diffcolors 1 $page.diffnew [mc "diff new lines"] \
-		      [list $ctext tag conf dresult -foreground]]
+        -command [list choosecolor diffcolors 1 $page.diffnew [mc "diff new lines"] \
+                      [list $ctext tag conf dresult -foreground]]
     grid x $page.diffnewbut $page.diffnew -sticky w
     label $page.hunksep -padx 40 -relief sunk -background [lindex $diffcolors 2]
     ${NS}::button $page.hunksepbut -text [mc "Diff: hunk header"] \
-	-command [list choosecolor diffcolors 2 $page.hunksep \
-		      [mc "diff hunk header"] \
-		      [list $ctext tag conf hunksep -foreground]]
+        -command [list choosecolor diffcolors 2 $page.hunksep \
+                      [mc "diff hunk header"] \
+                      [list $ctext tag conf hunksep -foreground]]
     grid x $page.hunksepbut $page.hunksep -sticky w
     label $page.markbgsep -padx 40 -relief sunk -background $markbgcolor
     ${NS}::button $page.markbgbut -text [mc "Marked line bg"] \
-	-command [list choosecolor markbgcolor {} $page.markbgsep \
-		      [mc "marked line background"] \
-		      [list $ctext tag conf omark -background]]
+        -command [list choosecolor markbgcolor {} $page.markbgsep \
+                      [mc "marked line background"] \
+                      [list $ctext tag conf omark -background]]
     grid x $page.markbgbut $page.markbgsep -sticky w
     label $page.selbgsep -padx 40 -relief sunk -background $selectbgcolor
     ${NS}::button $page.selbgbut -text [mc "Select bg"] \
-	-command [list choosecolor selectbgcolor {} $page.selbgsep [mc "background"] setselbg]
+        -command [list choosecolor selectbgcolor {} $page.selbgsep [mc "background"] setselbg]
     grid x $page.selbgbut $page.selbgsep -sticky w
     return $page
 }
@@ -11674,21 +11674,21 @@ proc doprefs {} {
     set top .gitkprefs
     set prefstop $top
     if {[winfo exists $top]} {
-	raise $top
-	return
+        raise $top
+        return
     }
     foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
-		   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
-	set oldprefs($v) [set $v]
+                   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
+        set oldprefs($v) [set $v]
     }
     ttk_toplevel $top
     wm title $top [mc "Gitk preferences"]
     make_transient $top .
 
     if {[set use_notebook [expr {$use_ttk && [info command ::ttk::notebook] ne ""}]]} {
-	set notebook [ttk::notebook $top.notebook]
+        set notebook [ttk::notebook $top.notebook]
     } else {
-	set notebook [${NS}::frame $top.notebook -borderwidth 0 -relief flat]
+        set notebook [${NS}::frame $top.notebook -borderwidth 0 -relief flat]
     }
 
     lappend pages [prefspage_general $notebook] [mc "General"]
@@ -11696,21 +11696,21 @@ proc doprefs {} {
     lappend pages [prefspage_fonts $notebook] [mc "Fonts"]
     set col 0
     foreach {page title} $pages {
-	if {$use_notebook} {
-	    $notebook add $page -text $title
-	} else {
-	    set btn [${NS}::button $notebook.b_[string map {. X} $page] \
-			 -text $title -command [list raise $page]]
-	    $page configure -text $title
-	    grid $btn -row 0 -column [incr col] -sticky w
-	    grid $page -row 1 -column 0 -sticky news -columnspan 100
-	}
+        if {$use_notebook} {
+            $notebook add $page -text $title
+        } else {
+            set btn [${NS}::button $notebook.b_[string map {. X} $page] \
+                         -text $title -command [list raise $page]]
+            $page configure -text $title
+            grid $btn -row 0 -column [incr col] -sticky w
+            grid $page -row 1 -column 0 -sticky news -columnspan 100
+        }
     }
 
     if {!$use_notebook} {
-	grid columnconfigure $notebook 0 -weight 1
-	grid rowconfigure $notebook 1 -weight 1
-	raise [lindex $pages 0]
+        grid columnconfigure $notebook 0 -weight 1
+        grid rowconfigure $notebook 1 -weight 1
+        raise [lindex $pages 0]
     }
 
     grid $notebook -sticky news -padx 2 -pady 2
@@ -11735,7 +11735,7 @@ proc choose_extdiff {} {
 
     set prog [tk_getOpenFile -title [mc "External diff tool"] -multiple false]
     if {$prog ne {}} {
-	set extdifftool $prog
+        set extdifftool $prog
     }
 }
 
@@ -11743,7 +11743,7 @@ proc choosecolor {v vi w x cmd} {
     global $v
 
     set c [tk_chooseColor -initialcolor [lindex [set $v] $vi] \
-	       -title [mc "Gitk: choose color for %s" $x]]
+               -title [mc "Gitk: choose color for %s" $x]]
     if {$c eq {}} return
     $w conf -background $c
     lset $v $vi $c
@@ -11753,12 +11753,12 @@ proc choosecolor {v vi w x cmd} {
 proc setselbg {c} {
     global bglist cflist
     foreach w $bglist {
-	if {[winfo exists $w]} {
-	    $w configure -selectbackground $c
-	}
+        if {[winfo exists $w]} {
+            $w configure -selectbackground $c
+        }
     }
     $cflist tag configure highlight \
-	-background [$cflist cget -selectbackground]
+        -background [$cflist cget -selectbackground]
     allcanvs itemconf secsel -fill $c
 }
 
@@ -11772,7 +11772,7 @@ proc setui {c} {
     set bg [winfo rgb . $c]
     set selc black
     if {[lindex $bg 0] + 1.5 * [lindex $bg 1] + 0.5 * [lindex $bg 2] > 100000} {
-	set selc white
+        set selc white
     }
     tk_setPalette background $c selectColor $selc
 }
@@ -11781,9 +11781,9 @@ proc setbg {c} {
     global bglist
 
     foreach w $bglist {
-	if {[winfo exists $w]} {
-	    $w conf -background $c
-	}
+        if {[winfo exists $w]} {
+            $w conf -background $c
+        }
     }
 }
 
@@ -11791,9 +11791,9 @@ proc setfg {c} {
     global fglist canv
 
     foreach w $fglist {
-	if {[winfo exists $w]} {
-	    $w conf -foreground $c
-	}
+        if {[winfo exists $w]} {
+            $w conf -foreground $c
+        }
     }
     allcanvs itemconf text -fill $c
     $canv itemconf circle -outline $c
@@ -11804,9 +11804,9 @@ proc prefscan {} {
     global oldprefs prefstop
 
     foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
-		   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
-	global $v
-	set $v $oldprefs($v)
+                   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
+        global $v
+        set $v $oldprefs($v)
     }
     catch {destroy $prefstop}
     unset prefstop
@@ -11825,76 +11825,76 @@ proc prefsok {} {
     fontcan
     set fontchanged 0
     if {$mainfont ne $fontpref(mainfont)} {
-	set mainfont $fontpref(mainfont)
-	parsefont mainfont $mainfont
-	eval font configure mainfont [fontflags mainfont]
-	eval font configure mainfontbold [fontflags mainfont 1]
-	setcoords
-	set fontchanged 1
+        set mainfont $fontpref(mainfont)
+        parsefont mainfont $mainfont
+        eval font configure mainfont [fontflags mainfont]
+        eval font configure mainfontbold [fontflags mainfont 1]
+        setcoords
+        set fontchanged 1
     }
     if {$textfont ne $fontpref(textfont)} {
-	set textfont $fontpref(textfont)
-	parsefont textfont $textfont
-	eval font configure textfont [fontflags textfont]
-	eval font configure textfontbold [fontflags textfont 1]
+        set textfont $fontpref(textfont)
+        parsefont textfont $textfont
+        eval font configure textfont [fontflags textfont]
+        eval font configure textfontbold [fontflags textfont 1]
     }
     if {$uifont ne $fontpref(uifont)} {
-	set uifont $fontpref(uifont)
-	parsefont uifont $uifont
-	eval font configure uifont [fontflags uifont]
+        set uifont $fontpref(uifont)
+        parsefont uifont $uifont
+        eval font configure uifont [fontflags uifont]
     }
     settabs
     if {$showlocalchanges != $oldprefs(showlocalchanges)} {
-	if {$showlocalchanges} {
-	    doshowlocalchanges
-	} else {
-	    dohidelocalchanges
-	}
+        if {$showlocalchanges} {
+            doshowlocalchanges
+        } else {
+            dohidelocalchanges
+        }
     }
     if {$limitdiffs != $oldprefs(limitdiffs) ||
-	($perfile_attrs && !$oldprefs(perfile_attrs))} {
-	# treediffs elements are limited by path;
-	# won't have encodings cached if perfile_attrs was just turned on
-	unset -nocomplain treediffs
+        ($perfile_attrs && !$oldprefs(perfile_attrs))} {
+        # treediffs elements are limited by path;
+        # won't have encodings cached if perfile_attrs was just turned on
+        unset -nocomplain treediffs
     }
     if {$fontchanged || $maxwidth != $oldprefs(maxwidth)
-	|| $maxgraphpct != $oldprefs(maxgraphpct)} {
-	redisplay
+        || $maxgraphpct != $oldprefs(maxgraphpct)} {
+        redisplay
     } elseif {$showneartags != $oldprefs(showneartags) ||
-	  $limitdiffs != $oldprefs(limitdiffs)} {
-	reselectline
+          $limitdiffs != $oldprefs(limitdiffs)} {
+        reselectline
     }
     if {$hideremotes != $oldprefs(hideremotes)} {
-	rereadrefs
+        rereadrefs
     }
 }
 
 proc formatdate {d} {
     global datetimeformat
     if {$d ne {}} {
-	# If $datetimeformat includes a timezone, display in the
-	# timezone of the argument.  Otherwise, display in local time.
-	if {[string match {*%[zZ]*} $datetimeformat]} {
-	    if {[catch {set d [clock format [lindex $d 0] -timezone [lindex $d 1] -format $datetimeformat]}]} {
-		# Tcl < 8.5 does not support -timezone.  Emulate it by
-		# setting TZ (e.g. TZ=<-0430>+04:30).
-		global env
-		if {[info exists env(TZ)]} {
-		    set savedTZ $env(TZ)
-		}
-		set zone [lindex $d 1]
-		set sign [string map {+ - - +} [string index $zone 0]]
-		set env(TZ) <$zone>$sign[string range $zone 1 2]:[string range $zone 3 4]
-		set d [clock format [lindex $d 0] -format $datetimeformat]
-		if {[info exists savedTZ]} {
-		    set env(TZ) $savedTZ
-		} else {
-		    unset env(TZ)
-		}
-	    }
-	} else {
-	    set d [clock format [lindex $d 0] -format $datetimeformat]
-	}
+        # If $datetimeformat includes a timezone, display in the
+        # timezone of the argument.  Otherwise, display in local time.
+        if {[string match {*%[zZ]*} $datetimeformat]} {
+            if {[catch {set d [clock format [lindex $d 0] -timezone [lindex $d 1] -format $datetimeformat]}]} {
+                # Tcl < 8.5 does not support -timezone.  Emulate it by
+                # setting TZ (e.g. TZ=<-0430>+04:30).
+                global env
+                if {[info exists env(TZ)]} {
+                    set savedTZ $env(TZ)
+                }
+                set zone [lindex $d 1]
+                set sign [string map {+ - - +} [string index $zone 0]]
+                set env(TZ) <$zone>$sign[string range $zone 1 2]:[string range $zone 3 4]
+                set d [clock format [lindex $d 0] -format $datetimeformat]
+                if {[info exists savedTZ]} {
+                    set env(TZ) $savedTZ
+                } else {
+                    unset env(TZ)
+                }
+            }
+        } else {
+            set d [clock format [lindex $d 0] -format $datetimeformat]
+        }
     }
     return $d
 }
@@ -12140,38 +12140,38 @@ set encoding_aliases {
 proc tcl_encoding {enc} {
     global encoding_aliases tcl_encoding_cache
     if {[info exists tcl_encoding_cache($enc)]} {
-	return $tcl_encoding_cache($enc)
+        return $tcl_encoding_cache($enc)
     }
     set names [encoding names]
     set lcnames [string tolower $names]
     set enc [string tolower $enc]
     set i [lsearch -exact $lcnames $enc]
     if {$i < 0} {
-	# look for "isonnn" instead of "iso-nnn" or "iso_nnn"
-	if {[regsub {^(iso|cp|ibm|jis)[-_]} $enc {\1} encx]} {
-	    set i [lsearch -exact $lcnames $encx]
-	}
+        # look for "isonnn" instead of "iso-nnn" or "iso_nnn"
+        if {[regsub {^(iso|cp|ibm|jis)[-_]} $enc {\1} encx]} {
+            set i [lsearch -exact $lcnames $encx]
+        }
     }
     if {$i < 0} {
-	foreach l $encoding_aliases {
-	    set ll [string tolower $l]
-	    if {[lsearch -exact $ll $enc] < 0} continue
-	    # look through the aliases for one that tcl knows about
-	    foreach e $ll {
-		set i [lsearch -exact $lcnames $e]
-		if {$i < 0} {
-		    if {[regsub {^(iso|cp|ibm|jis)[-_]} $e {\1} ex]} {
-			set i [lsearch -exact $lcnames $ex]
-		    }
-		}
-		if {$i >= 0} break
-	    }
-	    break
-	}
+        foreach l $encoding_aliases {
+            set ll [string tolower $l]
+            if {[lsearch -exact $ll $enc] < 0} continue
+            # look through the aliases for one that tcl knows about
+            foreach e $ll {
+                set i [lsearch -exact $lcnames $e]
+                if {$i < 0} {
+                    if {[regsub {^(iso|cp|ibm|jis)[-_]} $e {\1} ex]} {
+                        set i [lsearch -exact $lcnames $ex]
+                    }
+                }
+                if {$i >= 0} break
+            }
+            break
+        }
     }
     set tclenc {}
     if {$i >= 0} {
-	set tclenc [lindex $names $i]
+        set tclenc [lindex $names $i]
     }
     set tcl_encoding_cache($enc) $tclenc
     return $tclenc
@@ -12180,16 +12180,16 @@ proc tcl_encoding {enc} {
 proc gitattr {path attr default} {
     global path_attr_cache
     if {[info exists path_attr_cache($attr,$path)]} {
-	set r $path_attr_cache($attr,$path)
+        set r $path_attr_cache($attr,$path)
     } else {
-	set r "unspecified"
-	if {![catch {set line [exec git check-attr $attr -- $path]}]} {
-	    regexp "(.*): $attr: (.*)" $line m f r
-	}
-	set path_attr_cache($attr,$path) $r
+        set r "unspecified"
+        if {![catch {set line [exec git check-attr $attr -- $path]}]} {
+            regexp "(.*): $attr: (.*)" $line m f r
+        }
+        set path_attr_cache($attr,$path) $r
     }
     if {$r eq "unspecified"} {
-	return $default
+        return $default
     }
     return $r
 }
@@ -12198,28 +12198,28 @@ proc cache_gitattr {attr pathlist} {
     global path_attr_cache
     set newlist {}
     foreach path $pathlist {
-	if {![info exists path_attr_cache($attr,$path)]} {
-	    lappend newlist $path
-	}
+        if {![info exists path_attr_cache($attr,$path)]} {
+            lappend newlist $path
+        }
     }
     set lim 1000
     if {[tk windowingsystem] == "win32"} {
-	# windows has a 32k limit on the arguments to a command...
-	set lim 30
+        # windows has a 32k limit on the arguments to a command...
+        set lim 30
     }
     while {$newlist ne {}} {
-	set head [lrange $newlist 0 [expr {$lim - 1}]]
-	set newlist [lrange $newlist $lim end]
-	if {![catch {set rlist [eval exec git check-attr $attr -- $head]}]} {
-	    foreach row [split $rlist "\n"] {
-		if {[regexp "(.*): $attr: (.*)" $row m path value]} {
-		    if {[string index $path 0] eq "\""} {
-			set path [encoding convertfrom [lindex $path 0]]
-		    }
-		    set path_attr_cache($attr,$path) $value
-		}
-	    }
-	}
+        set head [lrange $newlist 0 [expr {$lim - 1}]]
+        set newlist [lrange $newlist $lim end]
+        if {![catch {set rlist [eval exec git check-attr $attr -- $head]}]} {
+            foreach row [split $rlist "\n"] {
+                if {[regexp "(.*): $attr: (.*)" $row m path value]} {
+                    if {[string index $path 0] eq "\""} {
+                        set path [encoding convertfrom [lindex $path 0]]
+                    }
+                    set path_attr_cache($attr,$path) $value
+                }
+            }
+        }
     }
 }
 
@@ -12227,10 +12227,10 @@ proc get_path_encoding {path} {
     global gui_encoding perfile_attrs
     set tcl_enc $gui_encoding
     if {$path ne {} && $perfile_attrs} {
-	set enc2 [tcl_encoding [gitattr $path encoding $tcl_enc]]
-	if {$enc2 ne {}} {
-	    set tcl_enc $enc2
-	}
+        set enc2 [tcl_encoding [gitattr $path encoding $tcl_enc]]
+        if {$enc2 ne {}} {
+            set tcl_enc $enc2
+        }
     }
     return $tcl_enc
 }
@@ -12257,7 +12257,7 @@ namespace import ::msgcat::mc
 # First check that Tcl/Tk is recent enough
 if {[catch {package require Tk 8.4} err]} {
     show_error {} . [mc "Sorry, gitk cannot run with this version of Tcl/Tk.\n\
-			 Gitk requires at least Tcl/Tk 8.4."]
+                         Gitk requires at least Tcl/Tk 8.4."]
     exit 1
 }
 
@@ -12297,12 +12297,12 @@ set gui_encoding [encoding system]
 catch {
     set enc [exec git config --get gui.encoding]
     if {$enc ne {}} {
-	set tclenc [tcl_encoding $enc]
-	if {$tclenc ne {}} {
-	    set gui_encoding $tclenc
-	} else {
-	    puts stderr "Warning: encoding $enc is not supported by Tcl/Tk"
-	}
+        set tclenc [tcl_encoding $enc]
+        if {$tclenc ne {}} {
+            set gui_encoding $tclenc
+        } else {
+            puts stderr "Warning: encoding $enc is not supported by Tcl/Tk"
+        }
     }
 }
 
@@ -12372,9 +12372,9 @@ if {[tk windowingsystem] eq "win32"} {
     set fgcolor black
     set selectbgcolor gray85
     if {[tk windowingsystem] eq "aqua"} {
-	set web_browser "open"
+        set web_browser "open"
     } else {
-	set web_browser "xdg-open"
+        set web_browser "xdg-open"
     }
 }
 set diffcolors {red "#00a000" blue}
@@ -12417,22 +12417,22 @@ catch {
     # follow the XDG base directory specification by default. See
     # http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
     if {[info exists env(XDG_CONFIG_HOME)] && $env(XDG_CONFIG_HOME) ne ""} {
-	# XDG_CONFIG_HOME environment variable is set
-	set config_file [file join $env(XDG_CONFIG_HOME) git gitk]
-	set config_file_tmp [file join $env(XDG_CONFIG_HOME) git gitk-tmp]
+        # XDG_CONFIG_HOME environment variable is set
+        set config_file [file join $env(XDG_CONFIG_HOME) git gitk]
+        set config_file_tmp [file join $env(XDG_CONFIG_HOME) git gitk-tmp]
     } else {
-	# default XDG_CONFIG_HOME
-	set config_file "~/.config/git/gitk"
-	set config_file_tmp "~/.config/git/gitk-tmp"
+        # default XDG_CONFIG_HOME
+        set config_file "~/.config/git/gitk"
+        set config_file_tmp "~/.config/git/gitk-tmp"
     }
     if {![file exists $config_file]} {
-	# for backward compatibility use the old config file if it exists
-	if {[file exists "~/.gitk"]} {
-	    set config_file "~/.gitk"
-	    set config_file_tmp "~/.gitk-tmp"
-	} elseif {![file exists [file dirname $config_file]]} {
-	    file mkdir [file dirname $config_file]
-	}
+        # for backward compatibility use the old config file if it exists
+        if {[file exists "~/.gitk"]} {
+            set config_file "~/.gitk"
+            set config_file_tmp "~/.gitk-tmp"
+        } elseif {![file exists [file dirname $config_file]]} {
+            file mkdir [file dirname $config_file]
+        }
     }
     source $config_file
 }
@@ -12486,20 +12486,20 @@ set i 0
 set revtreeargscmd {}
 foreach arg $argv {
     switch -glob -- $arg {
-	"" { }
-	"--" {
-	    set cmdline_files [lrange $argv [expr {$i + 1}] end]
-	    break
-	}
-	"--select-commit=*" {
-	    set selecthead [string range $arg 16 end]
-	}
-	"--argscmd=*" {
-	    set revtreeargscmd [string range $arg 10 end]
-	}
-	default {
-	    lappend revtreeargs $arg
-	}
+        "" { }
+        "--" {
+            set cmdline_files [lrange $argv [expr {$i + 1}] end]
+            break
+        }
+        "--select-commit=*" {
+            set selecthead [string range $arg 16 end]
+        }
+        "--argscmd=*" {
+            set revtreeargscmd [string range $arg 10 end]
+        }
+        default {
+            lappend revtreeargs $arg
+        }
     }
     incr i
 }
@@ -12511,29 +12511,29 @@ if {$selecthead eq "HEAD"} {
 if {$i >= [llength $argv] && $revtreeargs ne {}} {
     # no -- on command line, but some arguments (other than --argscmd)
     if {[catch {
-	set f [eval exec git rev-parse --no-revs --no-flags $revtreeargs]
-	set cmdline_files [split $f "\n"]
-	set n [llength $cmdline_files]
-	set revtreeargs [lrange $revtreeargs 0 end-$n]
-	# Unfortunately git rev-parse doesn't produce an error when
-	# something is both a revision and a filename.  To be consistent
-	# with git log and git rev-list, check revtreeargs for filenames.
-	foreach arg $revtreeargs {
-	    if {[file exists $arg]} {
-		show_error {} . [mc "Ambiguous argument '%s': both revision\
-				 and filename" $arg]
-		exit 1
-	    }
-	}
+        set f [eval exec git rev-parse --no-revs --no-flags $revtreeargs]
+        set cmdline_files [split $f "\n"]
+        set n [llength $cmdline_files]
+        set revtreeargs [lrange $revtreeargs 0 end-$n]
+        # Unfortunately git rev-parse doesn't produce an error when
+        # something is both a revision and a filename.  To be consistent
+        # with git log and git rev-list, check revtreeargs for filenames.
+        foreach arg $revtreeargs {
+            if {[file exists $arg]} {
+                show_error {} . [mc "Ambiguous argument '%s': both revision\
+                                 and filename" $arg]
+                exit 1
+            }
+        }
     } err]} {
-	# unfortunately we get both stdout and stderr in $err,
-	# so look for "fatal:".
-	set i [string first "fatal:" $err]
-	if {$i > 0} {
-	    set err [string range $err [expr {$i + 6}] end]
-	}
-	show_error {} . "[mc "Bad arguments to gitk:"]\n$err"
-	exit 1
+        # unfortunately we get both stdout and stderr in $err,
+        # so look for "fatal:".
+        set i [string first "fatal:" $err]
+        if {$i > 0} {
+            set err [string range $err [expr {$i + 6}] end]
+        }
+        show_error {} . "[mc "Bad arguments to gitk:"]\n$err"
+        exit 1
     }
 }
 
@@ -12654,15 +12654,15 @@ if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {}} {
 
 if {[info exists permviews]} {
     foreach v $permviews {
-	set n $nextviewnum
-	incr nextviewnum
-	set viewname($n) [lindex $v 0]
-	set viewfiles($n) [lindex $v 1]
-	set viewargs($n) [lindex $v 2]
-	set viewargscmd($n) [lindex $v 3]
-	set viewperm($n) 1
-	set viewchanged($n) 0
-	addviewmenu $n
+        set n $nextviewnum
+        incr nextviewnum
+        set viewname($n) [lindex $v 0]
+        set viewfiles($n) [lindex $v 1]
+        set viewargs($n) [lindex $v 2]
+        set viewargscmd($n) [lindex $v 3]
+        set viewperm($n) 1
+        set viewchanged($n) 0
+        addviewmenu $n
     }
 }
 
-- 
2.28.0.618.gf4bc123cb7

