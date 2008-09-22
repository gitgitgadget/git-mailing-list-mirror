From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: [PATCH (GIT-GUI,GITK) 6/8] gitk: Port new encoding logic from git-gui.
Date: Mon, 22 Sep 2008 12:01:35 +0400
Organization: HOME
Message-ID: <200809221201.35507.angavrilov@gmail.com>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com> <200809212252.35769.angavrilov@gmail.com> <48D74877.9050607@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 22 10:04:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhgOz-0007bZ-Lb
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 10:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbYIVIDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 04:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbYIVIDE
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 04:03:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:17919 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbYIVIDB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 04:03:01 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1281984fgg.17
        for <git@vger.kernel.org>; Mon, 22 Sep 2008 01:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=zfl+palXQG0GXGiCJn0V8KucfKoMRsUz1LDM2absZ2k=;
        b=ITB+552yfAne0GZj3e5ey1aCBvsJbAGfQy50sb0erksjugh7LMUBGCDNaNw/i/oKVH
         YoeTpZf9P8DFDWECqrlF88T38q0ZrfuEhzY4CMrD+1ViVxnycfXOyuqniCRJjzzIJokQ
         QMCLWSkZrusFBgou0GZE0vfYOLflvobHjs86Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=l/PEUpnAY/sED9kRw78lAEP4dF1KTxmWXCM0m75J9/s0YNc+bhogXHTEr3beMYy7//
         byAh9NnyLiZFa+uHPNxVsYnlsSrmMhdko/uTPAF2GHbxJbRgpp1XqarvEJeZErxGaE6l
         NcBnG3YQK7ajY1gxuGkrwielYqYqB1kpy+5rk=
Received: by 10.180.207.7 with SMTP id e7mr2043956bkg.18.1222070579550;
        Mon, 22 Sep 2008 01:02:59 -0700 (PDT)
Received: from keydesk.localnet ( [92.255.85.78])
        by mx.google.com with ESMTPS id e17sm4244903fke.10.2008.09.22.01.02.57
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Sep 2008 01:02:58 -0700 (PDT)
User-Agent: KMail/1.10.1 (Linux/2.6.26.3-29.fc9.i686; KDE/4.1.0; i686; ; )
In-Reply-To: <48D74877.9050607@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96456>

On Monday 22 September 2008 11:25:43 Johannes Sixt wrote:
> Alexander Gavrilov schrieb:
> > Subject: [PATCH] gitk: Implement batch lookup and caching of encoding attrs.
> > 
> > When the diff contains thousands of files, calling git-check-attr
> > once per file is very slow. With this patch gitk does attribute
> > lookup in batches of 30 files while reading the diff file list,
> > which leads to a very noticeable speedup.
> 
> This one does not work for me: The correct is not picked up anymore,
> neither in Patch mode nor Tree mode. (It works as expected without this
> patch.)
> 

OOPS, I forgot to copy the line that removes leading whitespace:

@@ -9876,6 +9876,7 @@ proc cache_gitattr {attr pathlist} {
                                if {[string index $path 0] eq "\""} {
                                        set path [encoding convertfrom [lindex $path 0]]
                                }
+                               regsub {^ } $value {} value
                                set path_attr_cache($attr,$path) $value
                        }
                }

> > +				set cols [split $row :]
> > +				set path [lindex $cols 0]
> 
> This colon made me nervous (because of the drive-colon combination on
> Windows), but as long as you feed relative paths into 'git check-attr',
> this should not matter (in my case).

I'm afraid there is nothing to be done about it without changing git-check-attr.
For example, it could quote ':' in the path in octal -- current interface allows it.
But since the path is relative, it is not a big deal.


--- >8 ---
From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH v2] gitk: Implement batch lookup and caching of encoding attrs.

When the diff contains thousands of files, calling git-check-attr
once per file is very slow. With this patch gitk does attribute
lookup in batches of 30 files while reading the diff file list,
which leads to a very noticeable speedup.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |   35 ++++++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 1355aa2..cf557c3 100755
--- a/gitk
+++ b/gitk
@@ -6530,6 +6530,7 @@ proc gettreediffline {gdtf ids} {
     global cmitmode vfilelimit curview limitdiffs
 
     set nr 0
+    set sublist {}
     while {[incr nr] <= 1000 && [gets $gdtf line] >= 0} {
 	set i [string first "\t" $line]
 	if {$i >= 0} {
@@ -6539,8 +6540,10 @@ proc gettreediffline {gdtf ids} {
 	    }
 	    set file [encoding convertfrom $file]
 	    lappend treediff $file
+	    lappend sublist $file
 	}
     }
+    cache_gitattr encoding $sublist
     if {![eof $gdtf]} {
 	return [expr {$nr >= 1000? 2: 1}]
     }
@@ -9839,18 +9842,48 @@ proc tcl_encoding {enc} {
 }
 
 proc gitattr {path attr default} {
-	if {[catch {set r [exec git check-attr $attr -- $path]}]} {
+	global path_attr_cache
+	if {[info exists path_attr_cache($attr,$path)]} {
+		set r $path_attr_cache($attr,$path)
+	} elseif {[catch {set r [exec git check-attr $attr -- $path]}]} {
 		set r unspecified
 	} else {
 		set r [join [lrange [split $r :] 2 end] :]
 		regsub {^ } $r {} r
 	}
+	set path_attr_cache($attr,$path) $r
 	if {$r eq {unspecified}} {
 		return $default
 	}
 	return $r
 }
 
+proc cache_gitattr {attr pathlist} {
+	global path_attr_cache
+	set newlist {}
+	foreach path $pathlist {
+		if {[info exists path_attr_cache($attr,$path)]} continue
+		lappend newlist $path
+	}
+	while {$newlist ne {}} {
+		set head [lrange $newlist 0 29]
+		set newlist [lrange $newlist 30 end]
+		if {![catch {set rlist [eval exec git check-attr $attr -- $head]}]} {
+			foreach row [split $rlist "\n"] {
+				set cols [split $row :]
+				set path [lindex $cols 0]
+				set value [join [lrange $cols 2 end] :]
+				if {[string index $path 0] eq "\""} {
+					set path [encoding convertfrom [lindex $path 0]]
+				}
+				regsub {^ } $value {} value
+				set path_attr_cache($attr,$path) $value
+			}
+		}
+		update
+	}
+}
+
 proc get_path_encoding {path} {
 	global gui_encoding
 	set tcl_enc [tcl_encoding $gui_encoding]
-- 
1.6.0.20.g6148bc
