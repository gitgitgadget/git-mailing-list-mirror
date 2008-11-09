From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: [PATCH (GITK) v3 3/6] gitk: Add accelerators to frequently used menu commands.
Date: Sun, 9 Nov 2008 14:21:24 +0300
Organization: HOME
Message-ID: <200811091421.25105.angavrilov@gmail.com>
References: <1225652389-22082-1-git-send-email-angavrilov@gmail.com> <1225652389-22082-4-git-send-email-angavrilov@gmail.com> <18708.11115.293282.71076@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Nov 09 12:25:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kz8QN-0001hV-JU
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 12:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754415AbYKILX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 06:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754505AbYKILX3
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 06:23:29 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:64023 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087AbYKILX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 06:23:28 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1807672fgg.17
        for <git@vger.kernel.org>; Sun, 09 Nov 2008 03:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xpNGpjWRNnYFVMtLIZ9eNgiuIm6FKP2qyT4z8R2bxHs=;
        b=nGjimUXc4DZobOIsAlFnynqPU3sQ5eAsrXJ85UAtUbharQy0OUwcfaH0mTHneFyJaR
         B4cooA/cl/OWK2JJZZCA0dR2WpCfhAOITL32izqIQ7t3SweV13wjfu0qrluLpiKBCCOK
         EtnPbszy2ls+A/GBkzWR0LZY8x5HrznAUkbGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=GFWrkIjoTlJ0Z71zfduMndIMXnfAo+R5fJXk5cFSxiPsSPB9+vczltYGrQaoufAXqP
         WCUmAk4iJVhl0AGHBePa5py13KXa/y2DPD2Fbn/+qJfC941PxX/K+VrdrksgMWk2PJLi
         9H8K5n1aTGxCxQBUJ+h1nEoOOGTSZgOPCsDBw=
Received: by 10.181.224.3 with SMTP id b3mr1685819bkr.183.1226229806081;
        Sun, 09 Nov 2008 03:23:26 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id 31sm8169379fkt.3.2008.11.09.03.23.23
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 09 Nov 2008 03:23:24 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.26.6-79.fc9.i686; KDE/4.1.2; i686; ; )
In-Reply-To: <18708.11115.293282.71076@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100440>

On Friday 07 November 2008 14:50:03 Paul Mackerras wrote:
> Alexander Gavrilov writes:
> 
> > -	eval $m add $params [lrange $i 4 end]
> > +	set tail [lrange $i 4 end]
> > +	regsub -all {\$M1T\y} $tail $M1T tail
> > +	eval $m add $params $tail
> 
> This is solving the problem that the $M1T doesn't get expanded in the
> call below because it's inside {}.  If we are going to have a magic
> string that gets expanded like this, I'd rather it didn't look like a
> variable reference, because that is confusing.

How about "Meta1" then?

> Alternatively, we could define a [meta] function that does this:
> 
> proc meta {x} {
>     if {[tk windowingsystem] eq "aqua"} {
> 	return Cmd-$x
>     }
>     return Ctrl-$x
> }
> 
> and then use -accelerator [meta F5] in the makemenu call, and not have
> any magic string substitution in makemenu.  That will work since the
> eval will evaluate the [].

For some reason it didn't work. Maybe I did something wrong.

--- >8 ---
Subject: [PATCH] gitk: Add accelerators to frequently used menu commands.

This commit documents keyboard accelerators used for menu
commands in the menu, as it is usually done, and adds some
more, e.g. F4 to invoke Edit View.

The changes include a workaround for handling Shift-F4 on
systems where XKB binds special XF86_Switch_VT_* symbols
to Ctrl-Alt-F* combinations. Tk often receives these codes
when Shift-F* is pressed, so it is necessary to bind the
relevant actions to them as well.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |   36 +++++++++++++++++++++++++++++-------
 1 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/gitk b/gitk
index 41d3d2d..a9618dc 100755
--- a/gitk
+++ b/gitk
@@ -1801,6 +1801,11 @@ proc setoptions {} {
 # command to invoke for command, or {variable value} for radiobutton
 proc makemenu {m items} {
     menu $m
+    if {[tk windowingsystem] eq {aqua}} {
+	set Meta1 Cmd
+    } else {
+	set Meta1 Ctrl
+    }
     foreach i $items {
 	set name [mc [lindex $i 1]]
 	set type [lindex $i 2]
@@ -1826,7 +1831,9 @@ proc makemenu {m items} {
 		    -value [lindex $thing 1]
 	    }
 	}
-	eval $m add $params [lrange $i 4 end]
+	set tail [lrange $i 4 end]
+	regsub -all {\yMeta1\y} $tail $Meta1 tail
+	eval $m add $params $tail
 	if {$type eq "cascade"} {
 	    makemenu $m.$submenu $thing
 	}
@@ -1860,17 +1867,17 @@ proc makewindow {} {
     makemenu .bar {
 	{mc "File" cascade {
 	    {mc "Update" command updatecommits -accelerator F5}
-	    {mc "Reload" command reloadcommits}
+	    {mc "Reload" command reloadcommits -accelerator Meta1-F5}
 	    {mc "Reread references" command rereadrefs}
-	    {mc "List references" command showrefs}
-	    {mc "Quit" command doquit}
+	    {mc "List references" command showrefs -accelerator F2}
+	    {mc "Quit" command doquit -accelerator Meta1-Q}
 	}}
 	{mc "Edit" cascade {
 	    {mc "Preferences" command doprefs}
 	}}
 	{mc "View" cascade {
-	    {mc "New view..." command {newview 0}}
-	    {mc "Edit view..." command editview -state disabled}
+	    {mc "New view..." command {newview 0} -accelerator Shift-F4}
+	    {mc "Edit view..." command editview -state disabled -accelerator F4}
 	    {mc "Delete view" command delview -state disabled}
 	    {xx "" separator}
 	    {mc "All files" radiobutton {selectedview 0} -command {showview 0}}
@@ -2232,7 +2239,12 @@ proc makewindow {} {
     bindkey <Key-Return> {dofind 1 1}
     bindkey ? {dofind -1 1}
     bindkey f nextfile
-    bindkey <F5> updatecommits
+    bind . <F5> updatecommits
+    bind . <$M1B-F5> reloadcommits
+    bind . <F2> showrefs
+    bind . <Shift-F4> {newview 0}
+    catch { bind . <Shift-Key-XF86_Switch_VT_4> {newview 0} }
+    bind . <F4> edit_or_newview
     bind . <$M1B-q> doquit
     bind . <$M1B-f> {dofind 1 1}
     bind . <$M1B-g> {dofind 1 0}
@@ -3483,6 +3495,16 @@ proc newview {ishighlight} {
     vieweditor $top $nextviewnum [mc "Gitk view definition"]
 }
 
+proc edit_or_newview {} {
+    global curview
+
+    if {$curview > 0} {
+	editview
+    } else {
+	newview 0
+    }
+}
+
 proc editview {} {
     global curview
     global viewname viewperm newviewname newviewperm
-- 
1.6.0.3.15.gb8d36
