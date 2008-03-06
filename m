From: Pekka Kaitaniemi <kaitanie@cc.helsinki.fi>
Subject: [PATCH v2] gitk: Add horizontal scrollbar to the diff view
Date: Thu, 6 Mar 2008 14:38:45 +0200
Message-ID: <20080306123845.GA12115@localdomain>
Reply-To: kaitanie@cc.helsinki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: paulus@samba.org, gitster@pobox.com, newsletter@dirk.my1.cc
X-From: git-owner@vger.kernel.org Thu Mar 06 13:40:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXFNx-0005Gn-Vk
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 13:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760877AbYCFMjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 07:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755857AbYCFMjH
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 07:39:07 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:53436 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022AbYCFMjE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 07:39:04 -0500
Received: by ug-out-1314.google.com with SMTP id z38so3795749ugc.16
        for <git@vger.kernel.org>; Thu, 06 Mar 2008 04:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:reply-to:mime-version:content-type:content-disposition:user-agent:sender;
        bh=cud0vX4UJlAauP3RDYGhOu0j/wcUzRprB+BBKgRVtgM=;
        b=KZcQgQzT7DJtr94ov1mPtoQy2a15HUaJn0O3xk3cXotWFpHWWxN0OBKdQPKdvcA2500e6rMjfVhDpKVtJ3GBEsOnzjiRZgwGWj0RIkdBy+drTzPDqFqQdw9dg6Y/xIt/au5EHDwCOm9DTnkaPOFwALoepjE3efQCMDY/WQWBIHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version:content-type:content-disposition:user-agent:sender;
        b=Y2LvJRzoSMd0MxBM/RA0+u8i0vwJQBOOp9Vyr9gVwke42S9TsiIBkADkXOR560g97kBTtJyEPe8GEAA0GcBrR/dhYX3Pbt57LhMGSK6Ikq3u1Jptad3X9UlZEtRh+nD0aTEfBy9SyIqNMVhh/MaXt8kLqGbUIW2VgaLZ5N6aHrg=
Received: by 10.78.154.14 with SMTP id b14mr9859416hue.55.1204807142449;
        Thu, 06 Mar 2008 04:39:02 -0800 (PST)
Received: from shadow ( [128.214.182.195])
        by mx.google.com with ESMTPS id j2sm8036984mue.3.2008.03.06.04.39.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Mar 2008 04:39:01 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76388>

Adding horizontal scroll bar makes the scrolling feature more
discoverable to the users. The horizontal scrollbar is a bit narrower
than vertical ones so we don't make too big impact on available screen
real estate.

An interesting side effect of Tk scrollbars is that the "elevator"
size changes depending on the visible content. So the horizontal
scrollbar "elevator" changes as the user scrolls the view up and down.

Signed-off-by: Pekka Kaitaniemi <kaitanie@cc.helsinki.fi>
---
This patch adds a relatively narrow horizontal scrollbar to the diff
pane. It might be a bit more complicated to implement an on-demand
one, however...

The patch seems to work fine on Linux and ion3 window manager. I
haven't had a chance to test it with other systems.

 gitk |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index f1f21e9..5340811 100755
--- a/gitk
+++ b/gitk
@@ -857,14 +857,18 @@ proc makewindow {} {
     set ctext .bleft.ctext
     text $ctext -background $bgcolor -foreground $fgcolor \
 	-state disabled -font textfont \
-	-yscrollcommand scrolltext -wrap none
+	-yscrollcommand scrolltext  -wrap none \
+	-xscrollcommand ".bleft.sbhorizontal set"
     if {$have_tk85} {
 	$ctext conf -tabstyle wordprocessor
     }
     scrollbar .bleft.sb -command "$ctext yview"
+    scrollbar .bleft.sbhorizontal -command "$ctext xview" -orient h \
+	-width 10
     pack .bleft.top -side top -fill x
     pack .bleft.mid -side top -fill x
     pack .bleft.sb -side right -fill y
+    pack .bleft.sbhorizontal -side bottom -fill x -in .bleft
     pack $ctext -side left -fill both -expand 1
     lappend bglist $ctext
     lappend fglist $ctext
-- 
1.5.4.3

