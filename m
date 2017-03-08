Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC014202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 21:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932070AbdCHVBv (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 16:01:51 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34832 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754203AbdCHVBt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 16:01:49 -0500
Received: by mail-wm0-f66.google.com with SMTP id z63so8025350wmg.2
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 13:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=REy+/DzwpDzFrHSQVQB0ZOPxC9UewiOtIVZ2lrNo0ec=;
        b=Q2RL/lGn3rfdqQjB0R/7S7dRLDrhGAbGsxKOl5VLpUzG/hXlT7up7Hi6GBxxd9wnCC
         Q7+qVc/J0fY4emsbEU6klMZTP10b75K+7zaq900nGisxx3cveJ2Up4P+Nh5xkhQXCUTh
         +4nfK+qEktjJl0YmUChcg9HjxFFaw91rIDtIxC2M0WkRkDJnsKh1xBJ06JcPqxC+MViu
         RUmDD7Ksy481rlGJA+gDbuImfOx/vtjjSs+HCCG4bDRvm6jgLdZ7QFWwrYm/bpnGJ3An
         nq2BIcXbxvKhejtPb1yz7dbgKyHPYG2ci+A83WnN15fLIiw5M5I3wknGm6D1Bc9CnNX4
         rqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=REy+/DzwpDzFrHSQVQB0ZOPxC9UewiOtIVZ2lrNo0ec=;
        b=Y/lhUCc21G919uLa7BzlESktK/gj0VhaQTF4Q9AMwrJ3Ns8hwveDExiu2uOeqG0VYc
         bsoz2hNp5g9SO6/sFzAdnJbjWpnG44C2PyBXlgWYQvH48G/o/Wvtax1rWzB2DyfXBHVQ
         3HtGFzFM2OGW36SrivzxMJlXrUlS0oplImmjoBrEqjtWPMxBM7/Bss63Ug/dieKPuT5i
         CXdHUnQBZF60vPGNCyZmuk/g2jP1jrOnNVzU+2TDFC1aYnFrMRJbKnUCJrmmfRkujRhQ
         zTBJJvaRanqeBQQiwL4cR41IzIKuTWBdQVTB0BPRt3o8bLNUaxABikoiqTV83wjkImeE
         dxKA==
X-Gm-Message-State: AMke39m5uFAc0ksDx7EbCe6GTI6WJS2nyoBbSCeniydgd8hVfBAkOFywEaxWmp7IUBba1A==
X-Received: by 10.28.88.2 with SMTP id m2mr26452458wmb.12.1489006396698;
        Wed, 08 Mar 2017 12:53:16 -0800 (PST)
Received: from localhost.localdomain (2a02-8388-0b40-0580-f50d-465b-b746-dc93.cable.dynamic.v6.surfer.at. [2a02:8388:b40:580:f50d:465b:b746:dc93])
        by smtp.gmail.com with ESMTPSA id 40sm5604065wry.22.2017.03.08.12.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Mar 2017 12:53:16 -0800 (PST)
From:   =?UTF-8?q?Florian=20Sch=C3=BCller?= <florian.schueller@gmail.com>
To:     paulus@ozlabs.org, git@vger.kernel.org
Cc:     =?UTF-8?q?Florian=20Sch=C3=BCller?= <florian.schueller@gmail.com>
Subject: [PATCH 1/4] Inotify Support
Date:   Wed,  8 Mar 2017 21:52:52 +0100
Message-Id: <20170308205255.18976-2-florian.schueller@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170308205255.18976-1-florian.schueller@gmail.com>
References: <20170308205255.18976-1-florian.schueller@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just automatically update gitk when working in a terminal on the same repo

Features:
* Detects inotify support
  if inotify is not detected the options is not available
  in the preferences
* Enable/Disable auto update in the preferences
* Select "debounce" time for redraw
  i.e. the redraw will be postponed for the given time.
  if a new change is detected in this time the redraw is postponed
  even more
* Automatically scroll to the new HEAD after redrawing
* Depending on the type of change the UI is "Updated" or "Reloaded"

Open points for now:
* release watches for deleted directories seems to
  cause problems in tcl-inotify (so I don't)
  I'm not sure how often that happens in ".git/"

Signed-off-by: Florian Schüller <florian.schueller@gmail.com>
---
 gitk | 171 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 170 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index a14d7a1..a2850d7 100755
--- a/gitk
+++ b/gitk
@@ -8,6 +8,12 @@ exec wish "$0" -- "$@"
 # either version 2, or (at your option) any later version.
 
 package require Tk
+try {
+    package require inotify
+    set have_inotify true
+} on error {em} {
+    set have_inotify false
+}
 
 proc hasworktree {} {
     return [expr {[exec git rev-parse --is-bare-repository] == "false" &&
@@ -11489,6 +11495,7 @@ proc prefspage_general {notebook} {
     global NS maxwidth maxgraphpct showneartags showlocalchanges
     global tabstop limitdiffs autoselect autosellen extdifftool perfile_attrs
     global hideremotes want_ttk have_ttk maxrefs
+    global autoupdate have_inotify autoupdatedebounce
 
     set page [create_prefs_page $notebook.general]
 
@@ -11505,13 +11512,21 @@ proc prefspage_general {notebook} {
     ${NS}::checkbutton $page.showlocal -text [mc "Show local changes"] \
 	-variable showlocalchanges
     grid x $page.showlocal -sticky w
+
     ${NS}::checkbutton $page.autoselect -text [mc "Auto-select SHA1 (length)"] \
 	-variable autoselect
     spinbox $page.autosellen -from 1 -to 40 -width 4 -textvariable autosellen
     grid x $page.autoselect $page.autosellen -sticky w
+
     ${NS}::checkbutton $page.hideremotes -text [mc "Hide remote refs"] \
 	-variable hideremotes
     grid x $page.hideremotes -sticky w
+    if { $have_inotify } {
+        ${NS}::checkbutton $page.autoupdate -text [mc "Auto-update upon change (ms)"] \
+            -variable autoupdate
+        spinbox $page.autoupdatedebounce -from 10 -to 60000 -width 7 -textvariable autoupdatedebounce
+        grid x $page.autoupdate $page.autoupdatedebounce -sticky w
+    }
 
     ${NS}::label $page.ddisp -text [mc "Diff display options"]
     grid $page.ddisp - -sticky w -pady 10
@@ -11765,7 +11780,8 @@ proc prefsok {} {
     global oldprefs prefstop showneartags showlocalchanges
     global fontpref mainfont textfont uifont
     global limitdiffs treediffs perfile_attrs
-    global hideremotes
+    global hideremotes autoupdate
+    global gitdir
 
     catch {destroy $prefstop}
     unset prefstop
@@ -11814,6 +11830,8 @@ proc prefsok {} {
     if {$hideremotes != $oldprefs(hideremotes)} {
 	rereadrefs
     }
+
+    handle_inotify $gitdir true
 }
 
 proc formatdate {d} {
@@ -12295,6 +12313,13 @@ set autoselect 1
 set autosellen 40
 set perfile_attrs 0
 set want_ttk 1
+set autoupdate 1
+set autoupdatedebounce 100
+#timer id for inotify reloading
+set reload_id -1
+#timer id for inotify updating (less than reload)
+set update_id -1
+set inotify_instance -1
 
 if {[tk windowingsystem] eq "aqua"} {
     set extdifftool "opendiff"
@@ -12390,6 +12415,7 @@ set config_variables {
     filesepbgcolor filesepfgcolor linehoverbgcolor linehoverfgcolor
     linehoveroutlinecolor mainheadcirclecolor workingfilescirclecolor
     indexcirclecolor circlecolors linkfgcolor circleoutlinecolor
+    autoupdate autoupdatedebounce
 }
 foreach var $config_variables {
     config_init_trace $var
@@ -12477,6 +12503,149 @@ if {$i >= [llength $argv] && $revtreeargs ne {}} {
     }
 }
 
+#function to be called after inotify reload-timeout
+proc reload_helper {} {
+    #puts "RELOAD"
+    global reload_id
+    set reload_id -1
+    reloadcommits
+    set head [exec git rev-parse HEAD]
+    selbyid $head
+}
+
+#function to be called after inotify update-timeout
+proc update_helper {} {
+    #puts "UPDATE"
+    global update_id
+    set update_id -1
+    updatecommits
+    set head [exec git rev-parse HEAD]
+    selbyid $head
+}
+
+proc inotify_handler { fd } {
+    global autoupdate reload_id update_id autoupdatedebounce
+    set events [inotify_watch read]
+    set watch_info [inotify_watch info]
+    set update_view false
+    set reloadcommits false
+
+    #cancel pending timer
+    if { $reload_id ne -1 } {
+        #puts "cancel a reload"
+        after cancel $reload_id
+        set reload_id -1
+        set update_view true
+        set reloadcommits true
+    }
+
+    if { $update_id ne -1 } {
+        #puts "cancel an update"
+        after cancel $update_id
+        set update_id -1
+        set update_view true
+    }
+
+    foreach {event} $events {
+        set current_watchid [dict get $event watchid]
+        set flags [dict get $event flags]
+        set event_filename [dict get $event filename]
+
+        foreach {path watchid watch_flags} $watch_info {
+            if {$watchid eq $current_watchid} {
+                set watch_path $path
+            }
+        }
+
+        set full_filename [file join $watch_path $event_filename]
+        #check wether we should do update or reload below
+        #puts "Got: $full_filename / $event_filename ($flags)"
+
+        if {$flags eq "nD"} {
+            inotify_watch add $full_filename "nwds"
+        }
+        if {![string match *.lock $event_filename]} {
+            if { $flags eq "d" } {
+                #stuff like deleting branches should result in reloading
+                set reloadcommits true
+            }
+            set update_view true
+        }
+
+        #simple commit just needs updating right?
+        #if { $event_filename eq "COMMIT_EDITMSG" } {
+        #    set reloadcommits true
+        #}
+    }
+
+    #reloadcommits or updatecommits - depending on file and operation?
+    if { $update_view } {
+        if { $reloadcommits } {
+            #puts "schedule reload"
+            set reload_id [after $autoupdatedebounce reload_helper]
+        } else {
+            #puts "schedule update"
+            set update_id [after $autoupdatedebounce update_helper]
+        }
+    }
+}
+
+proc watch_recursive { dir } {
+    inotify_watch add $dir "nwaCmMds"
+
+    foreach i [glob -nocomplain -dir $dir *] {
+        if {[file type $i] eq {directory}} {
+            watch_recursive $i
+        }
+    }
+}
+
+proc enable_inotify { dir redraw} {
+    global inotify_instance autoupdatedebounce reload_id
+
+    if { $inotify_instance ne -1 } {
+        updatecommits
+    } else {
+        set inotify_instance [inotify create "inotify_watch" "::inotify_handler"]
+        watch_recursive $dir
+        if { $redraw } {
+            set reload_id [after $autoupdatedebounce reload_helper]
+        }
+    }
+}
+
+proc disable_inotify {} {
+    global inotify_instance reload_id update_id
+
+    if { $inotify_instance ne -1 } {
+        rename inotify_watch {}
+        set inotify_instance -1
+    }
+
+    if { $reload_id ne -1 } {
+        after cancel $reload_id
+        set reload_id -1
+    }
+
+    if { $update_id ne -1 } {
+        after cancel $update_id
+        set update_id -1
+    }
+}
+
+proc handle_inotify { dir redraw } {
+    global have_inotify autoupdate
+    if { $have_inotify } {
+        if { $autoupdate } {
+            enable_inotify $dir $redraw
+        } else {
+            disable_inotify
+        }
+    }
+}
+
+handle_inotify $gitdir false
+
 set nullid "0000000000000000000000000000000000000000"
 set nullid2 "0000000000000000000000000000000000000001"
 set nullfile "/dev/null"
-- 
2.9.3

