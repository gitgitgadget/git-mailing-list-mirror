From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 7/7] Unicode file name support (gitk and git-gui)
Date: Wed, 11 Jun 2014 11:37:46 +0200
Message-ID: <1402479466-8500-8-git-send-email-kasal@ucw.cz>
References: <1402479466-8500-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRB7OG4COAKGQEU5PATQQ@googlegroups.com Wed Jun 11 11:38:07 2014
Return-path: <msysgit+bncBCU63DXMWULRB7OG4COAKGQEU5PATQQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f191.google.com ([209.85.212.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB7OG4COAKGQEU5PATQQ@googlegroups.com>)
	id 1Wueys-0004Jq-HK
	for gcvm-msysgit@m.gmane.org; Wed, 11 Jun 2014 11:38:06 +0200
Received: by mail-wi0-f191.google.com with SMTP id q5sf64564wiv.18
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Jun 2014 02:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=Eu7kkc7lruRp6fxIiR/zfhlxY6Bpm+DedEdLbw9iq2k=;
        b=gxICd0z99JTi/jKkuCtgMoqcOklmYuuAIYZ/O54EvEWfJYYrjlWmzVFcxgo45m0w/C
         le1SJJcRF31Ss0inLhKb0Ee3VQRkZWhsiIz7hEMAfYIqPfUUbC9MPjRzGTYerMsKVFs2
         iKf+ngHuvG5kDUVOzjRdhFkgdts6xpCVJRs5VmEmQ473GPBeuYEhfTvktTpyN/evRhZH
         8rNbcGrZDhnz6nI/BI8Da8PKQnEO76mcw8AMOr4hlODL84APct9I0HAiVc06hTMF7tQE
         K4AZm7grb5+KFFikpOUBAIfZiQ98rbb5MIzKvfQJkbkqO8v/DD4AhrdvYsQ88ncY6EPu
         nUAA==
X-Received: by 10.152.37.5 with SMTP id u5mr7686laj.23.1402479486138;
        Wed, 11 Jun 2014 02:38:06 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.42.139 with SMTP id o11ls427284lal.82.gmail; Wed, 11 Jun
 2014 02:38:05 -0700 (PDT)
X-Received: by 10.112.200.164 with SMTP id jt4mr170859lbc.14.1402479485008;
        Wed, 11 Jun 2014 02:38:05 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id eh2si1288591wib.2.2014.06.11.02.38.04
        for <msysgit@googlegroups.com>;
        Wed, 11 Jun 2014 02:38:04 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id AA7601C00B1; Wed, 11 Jun 2014 11:38:04 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402479466-8500-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251351>

From: Karsten Blees <blees@dcon.de>
Date: Sat, 4 Feb 2012 21:54:36 +0100

Assumes file names in git tree objects are UTF-8 encoded.

On most unix systems, the system encoding (and thus the TCL system
encoding) will be UTF-8, so file names will be displayed correctly.

On Windows, it is impossible to set the system encoding to UTF-8. Changing
the TCL system encoding (via 'encoding system ...', e.g. in the startup
code) is explicitly discouraged by the TCL docs.

Change gitk and git-gui functions dealing with file names to always convert
from and to UTF-8.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 git-gui/git-gui.sh      | 11 +++++++----
 git-gui/lib/browser.tcl |  2 +-
 git-gui/lib/index.tcl   |  6 +++---
 gitk-git/gitk           | 15 ++++++++-------
 4 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index b186329..f9c942c 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -548,6 +548,9 @@ proc git {args} {
 
 	_trace_exec [concat $opt $cmdp $args]
 	set result [eval exec $opt $cmdp $args]
+	if {[encoding system] != "utf-8"} {
+		set result [encoding convertfrom utf-8 [encoding convertto $result]]
+	}
 	if {$::_trace} {
 		puts stderr "< $result"
 	}
@@ -1104,7 +1107,7 @@ git-version proc _parse_config {arr_name args} {
 				[list git_read config] \
 				$args \
 				[list --null --list]]
-			fconfigure $fd_rc -translation binary
+			fconfigure $fd_rc -translation binary -encoding utf-8
 			set buf [read $fd_rc]
 			close $fd_rc
 		}
@@ -1682,7 +1685,7 @@ proc read_diff_index {fd after} {
 		set i [split [string range $buf_rdi $c [expr {$z1 - 2}]] { }]
 		set p [string range $buf_rdi $z1 [expr {$z2 - 1}]]
 		merge_state \
-			[encoding convertfrom $p] \
+			[encoding convertfrom utf-8 $p] \
 			[lindex $i 4]? \
 			[list [lindex $i 0] [lindex $i 2]] \
 			[list]
@@ -1715,7 +1718,7 @@ proc read_diff_files {fd after} {
 		set i [split [string range $buf_rdf $c [expr {$z1 - 2}]] { }]
 		set p [string range $buf_rdf $z1 [expr {$z2 - 1}]]
 		merge_state \
-			[encoding convertfrom $p] \
+			[encoding convertfrom utf-8 $p] \
 			?[lindex $i 4] \
 			[list] \
 			[list [lindex $i 0] [lindex $i 2]]
@@ -1738,7 +1741,7 @@ proc read_ls_others {fd after} {
 	set pck [split $buf_rlo "\0"]
 	set buf_rlo [lindex $pck end]
 	foreach p [lrange $pck 0 end-1] {
-		set p [encoding convertfrom $p]
+		set p [encoding convertfrom utf-8 $p]
 		if {[string index $p end] eq {/}} {
 			set p [string range $p 0 end-1]
 		}
diff --git a/git-gui/lib/browser.tcl b/git-gui/lib/browser.tcl
index 0328338..555db89 100644
--- a/git-gui/lib/browser.tcl
+++ b/git-gui/lib/browser.tcl
@@ -197,7 +197,7 @@ method _ls {tree_id {name {}}} {
 	$w conf -state disabled
 
 	set fd [git_read ls-tree -z $tree_id]
-	fconfigure $fd -blocking 0 -translation binary -encoding binary
+	fconfigure $fd -blocking 0 -translation binary -encoding utf-8
 	fileevent $fd readable [cb _read $fd]
 }
 
diff --git a/git-gui/lib/index.tcl b/git-gui/lib/index.tcl
index 74a81a7..d10ffe9 100644
--- a/git-gui/lib/index.tcl
+++ b/git-gui/lib/index.tcl
@@ -115,7 +115,7 @@ proc write_update_indexinfo {fd pathList totalCnt batch after} {
 		set info [lindex $s 2]
 		if {$info eq {}} continue
 
-		puts -nonewline $fd "$info\t[encoding convertto $path]\0"
+		puts -nonewline $fd "$info\t[encoding convertto utf-8 $path]\0"
 		display_file $path $new
 	}
 
@@ -186,7 +186,7 @@ proc write_update_index {fd pathList totalCnt batch after} {
 		?M {set new M_}
 		?? {continue}
 		}
-		puts -nonewline $fd "[encoding convertto $path]\0"
+		puts -nonewline $fd "[encoding convertto utf-8 $path]\0"
 		display_file $path $new
 	}
 
@@ -247,7 +247,7 @@ proc write_checkout_index {fd pathList totalCnt batch after} {
 		?M -
 		?T -
 		?D {
-			puts -nonewline $fd "[encoding convertto $path]\0"
+			puts -nonewline $fd "[encoding convertto utf-8 $path]\0"
 			display_file $path ?_
 		}
 		}
diff --git a/gitk-git/gitk b/gitk-git/gitk
index f6efaa6..0301608 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -7529,7 +7529,7 @@ proc gettreeline {gtf id} {
 	if {[string index $fname 0] eq "\""} {
 	    set fname [lindex $fname 0]
 	}
-	set fname [encoding convertfrom $fname]
+	set fname [encoding convertfrom utf-8 $fname]
 	lappend treefilelist($id) $fname
     }
     if {![eof $gtf]} {
@@ -7791,7 +7791,7 @@ proc gettreediffline {gdtf ids} {
 	    if {[string index $file 0] eq "\""} {
 		set file [lindex $file 0]
 	    }
-	    set file [encoding convertfrom $file]
+	    set file [encoding convertfrom utf-8 $file]
 	    if {$file ne [lindex $treediff end]} {
 		lappend treediff $file
 		lappend sublist $file
@@ -7936,7 +7936,7 @@ proc makediffhdr {fname ids} {
     global ctext curdiffstart treediffs diffencoding
     global ctext_file_names jump_to_here targetline diffline
 
-    set fname [encoding convertfrom $fname]
+    set fname [encoding convertfrom utf-8 $fname]
     set diffencoding [get_path_encoding $fname]
     set i [lsearch -exact $treediffs($ids) $fname]
     if {$i >= 0} {
@@ -7993,7 +7993,7 @@ proc parseblobdiffline {ids line} {
 
     if {![string compare -length 5 "diff " $line]} {
 	if {![regexp {^diff (--cc|--git) } $line m type]} {
-	    set line [encoding convertfrom $line]
+	    set line [encoding convertfrom utf-8 $line]
 	    $ctext insert end "$line\n" hunksep
 	    continue
 	}
@@ -8040,7 +8040,7 @@ proc parseblobdiffline {ids line} {
 	makediffhdr $fname $ids
 
     } elseif {![string compare -length 16 "* Unmerged path " $line]} {
-	set fname [encoding convertfrom [string range $line 16 end]]
+	set fname [encoding convertfrom utf-8 [string range $line 16 end]]
 	$ctext insert end "\n"
 	set curdiffstart [$ctext index "end - 1c"]
 	lappend ctext_file_names $fname
@@ -8095,7 +8095,7 @@ proc parseblobdiffline {ids line} {
 	    if {[string index $fname 0] eq "\""} {
 		set fname [lindex $fname 0]
 	    }
-	    set fname [encoding convertfrom $fname]
+	    set fname [encoding convertfrom utf-8 $fname]
 	    set i [lsearch -exact $treediffs($ids) $fname]
 	    if {$i >= 0} {
 		setinlist difffilestart $i $curdiffstart
@@ -8114,6 +8114,7 @@ proc parseblobdiffline {ids line} {
 	    set diffinhdr 0
 	    return
 	}
+	set line [encoding convertfrom utf-8 $line]
 	$ctext insert end "$line\n" filesep
 
     } else {
@@ -11902,7 +11903,7 @@ proc cache_gitattr {attr pathlist} {
 	    foreach row [split $rlist "\n"] {
 		if {[regexp "(.*): $attr: (.*)" $row m path value]} {
 		    if {[string index $path 0] eq "\""} {
-			set path [encoding convertfrom [lindex $path 0]]
+			set path [encoding convertfrom utf-8 [lindex $path 0]]
 		    }
 		    set path_attr_cache($attr,$path) $value
 		}
-- 
2.0.0.9635.g0be03cb

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
