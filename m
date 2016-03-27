From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v3 1/2] gitk: alter the ordering for the "Tags and heads" view
Date: Sun, 27 Mar 2016 11:06:07 -0400
Message-ID: <1459091168-46908-2-git-send-email-rappazzo@gmail.com>
References: <1459091168-46908-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Sun Mar 27 17:06:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akCGs-0005sV-UT
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 17:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291AbcC0PGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2016 11:06:24 -0400
Received: from mail-qg0-f66.google.com ([209.85.192.66]:36702 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbcC0PGW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2016 11:06:22 -0400
Received: by mail-qg0-f66.google.com with SMTP id 14so10559162qgg.3
        for <git@vger.kernel.org>; Sun, 27 Mar 2016 08:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+zCU9aqVnVpngGnGPnDoBd2JnqI6JuaWbJxaxnoElsE=;
        b=0QORHVjVXPGPJf8hj/6Dx7yeEvQkKM2CKpWPk+xOYiJPtNllQhOXQpia3v4UtJYgpQ
         EPmdKQ7qlmRKFOQaRt/Y6mJ6bcRsisG24JMpEzdnTCLgl7BD2a7H5w8lUPyQp4VzUJf+
         Xl02KvFGL9UUElfZYwflHcU2qbRbZBlaUjrWJk6q2euzp4l65WnjkngN0UpSZ+GtMvKH
         aSMGhDTsamgMjns0WucRk6vjDoBaqd8SZAU9JS6Dz/EggHAUMBQJY2pZZKlxUJJdN4jS
         x9KS0FFQPJch9Z78HI90NkMGJJiARdE2FopWjESw+y6LuEfA8KUaNTyRz7uWKOqo3rg/
         /7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+zCU9aqVnVpngGnGPnDoBd2JnqI6JuaWbJxaxnoElsE=;
        b=j+mPJUx6gidlBozMI9OYrzNpSm1u87cl0X0IGgIobKuh3RnU2+5GhkmdNVFaeW/N/u
         NUrB+LQ185MkL60KUGRd9TNJOZF9XjboKYPSRMu0/qPbySYaOe5KCNlQu4EOAyQacMTz
         cW30PYZkfMc0ZrPe4HgK97x3R+VQrcHdouwR/9t3bFMqnJOscZn/xJG27ma0B+NzTtTi
         ysgYOJGGarnd7fWZnGiV0llqNEt/HECSH+ak6yjnqGxzpe/4gF9B6j4by2L9rasT4wZK
         e6yXckioMJd8HcbgrpDu2Sv6itBRrK6LizFY2TdEmf0l+dmDdRCT5E22k8yXqqfnVwxg
         cpHA==
X-Gm-Message-State: AD7BkJLN9YXdui/6XMf8MAJJcADZpBWMv95veyqzVn9kDAUyUKzIGBOk2bFwRCfPK5qzaw==
X-Received: by 10.140.92.15 with SMTP id a15mr11245232qge.93.1459091181449;
        Sun, 27 Mar 2016 08:06:21 -0700 (PDT)
Received: from MRappazzo-8.nycap.info (cpe-74-70-59-36.nycap.res.rr.com. [74.70.59.36])
        by smtp.gmail.com with ESMTPSA id 78sm2312230qhr.4.2016.03.27.08.06.20
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 27 Mar 2016 08:06:20 -0700 (PDT)
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1459091168-46908-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290011>

In the "Tags and heads" view, the list of refs is globally sorted.
Because of this, the list of local refs (heads) can be interrupted by the
list of remote refs.  This change re-orders the view to be: local refs,
remote refs tracked by local refs, remote refs, tags, and then other refs.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 gitk | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 9 deletions(-)

diff --git a/gitk b/gitk
index 805a1c7..3686370 100755
--- a/gitk
+++ b/gitk
@@ -1772,12 +1772,12 @@ proc longid {prefix} {
 }
 
 proc readrefs {} {
-    global tagids idtags headids idheads tagobjid
+    global tagids idtags headids idheads tagobjid localrefs_tracking_remotes
     global otherrefids idotherrefs mainhead mainheadid
     global selecthead selectheadid
     global hideremotes
 
-    foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
+    foreach v {tagids idtags headids idheads otherrefids idotherrefs localrefs_tracking_remotes} {
 	unset -nocomplain $v
     }
     set refd [open [list | git show-ref -d] r]
@@ -1828,6 +1828,21 @@ proc readrefs {} {
 	    set selectheadid [exec git rev-parse --verify $selecthead]
 	}
     }
+    #load the local_branch->upstream mapping
+    # the result of the for-each-ref command produces the local_branch NUL upstream
+    set locals_tracking [open [list | git for-each-ref {--format=%(refname:short)%00%(upstream)} refs/heads/] r]
+    while {[gets $locals_tracking local_tracking] >= 0} {
+	set line [split $local_tracking \0]
+	if {[lindex $line 1] ne {}} {
+	    set upstream_ref [string map {"refs/" ""} [lindex $line 1]];
+	    set upstream_exists {}
+	    catch {set upstream_exists [exec git rev-parse --verify $upstream_ref]}
+	    if {$upstream_exists ne ""} {
+		set localrefs_tracking_remotes([lindex $line 0]) $upstream_ref
+	    }
+	}
+    }
+    catch {close $locals_tracking}
 }
 
 # skip over fake commits
@@ -9929,39 +9944,66 @@ proc reflistfilter_change {n1 n2 op} {
 }
 
 proc refill_reflist {} {
-    global reflist reflistfilter showrefstop headids tagids otherrefids
+    global reflist reflistfilter showrefstop headids tagids otherrefids localrefs_tracking_remotes
     global curview
 
     if {![info exists showrefstop] || ![winfo exists $showrefstop]} return
-    set refs {}
+    set localrefs {}
+    set remoterefs {}
+    set locally_tracked_remote_refs {}
+    set tagrefs {}
+    set otherrefs {}
+
     foreach n [array names headids] {
-	if {[string match $reflistfilter $n]} {
+	if {![string match "remotes/*" $n] && [string match $reflistfilter $n]} {
 	    if {[commitinview $headids($n) $curview]} {
-		lappend refs [list $n H]
+		lappend localrefs [list $n H]
+		if {[info exists localrefs_tracking_remotes($n)]} {
+		    lappend locally_tracked_remote_refs [list $localrefs_tracking_remotes($n) H]
+		}
 	    } else {
 		interestedin $headids($n) {run refill_reflist}
 	    }
 	}
     }
+    set locally_tracked_remote_refs [lsort -index 0 $locally_tracked_remote_refs]
+    set localrefs [lsort -index 0 $localrefs]
+
+    foreach n [array names headids] {
+	if {[string match "remotes/*" $n] && [string match $reflistfilter $n]} {
+	    if {[commitinview $headids($n) $curview]} {
+		if {[lsearch -exact $locally_tracked_remote_refs [list $n H]] < 0} {
+		    lappend remoterefs [list $n H]
+		}
+	    } else {
+		interestedin $headids($n) {run refill_reflist}
+	    }
+	}
+    }
+    set remoterefs [lsort -index 0 $remoterefs]
+
     foreach n [array names tagids] {
 	if {[string match $reflistfilter $n]} {
 	    if {[commitinview $tagids($n) $curview]} {
-		lappend refs [list $n T]
+		lappend tagrefs [list $n T]
 	    } else {
 		interestedin $tagids($n) {run refill_reflist}
 	    }
 	}
     }
+    set tagrefs [lsort -index 0 $tagrefs]
+
     foreach n [array names otherrefids] {
 	if {[string match $reflistfilter $n]} {
 	    if {[commitinview $otherrefids($n) $curview]} {
-		lappend refs [list $n o]
+		lappend otherrefs [list "$n" o]
 	    } else {
 		interestedin $otherrefids($n) {run refill_reflist}
 	    }
 	}
     }
-    set refs [lsort -index 0 $refs]
+    set otherrefs [lsort -index 0 $otherrefs]
+    lappend refs {*}$localrefs {*}$locally_tracked_remote_refs {*}$remoterefs {*}$tagrefs {*}$otherrefs
     if {$refs eq $reflist} return
 
     # Update the contents of $showrefstop.list according to the
-- 
2.7.4
