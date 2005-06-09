From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitk-1.1 out
Date: Thu, 9 Jun 2005 07:58:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506090728280.2286@ppc970.osdl.org>
References: <17053.35147.52729.794561@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0506080743040.2286@ppc970.osdl.org>
 <17064.15104.847009.390149@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 17:07:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgOOY-0006J8-DF
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 16:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVFIO4j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 10:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVFIO4j
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 10:56:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59008 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261350AbVFIO4h (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 10:56:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j59EuWjA007900
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 9 Jun 2005 07:56:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j59EuUtp005326;
	Thu, 9 Jun 2005 07:56:31 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17064.15104.847009.390149@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 9 Jun 2005, Paul Mackerras wrote:
> 
> Try this patch against gitk-1.1 and let me know what you think.  I
> draw the heads as a green rectangle with a black border.

Works for me. My cvs-import testing "syslinux" tree now has the heads of
the different branches nicely named.

However, I also changed it to allow the "direct" kinds of tags which the 
cvs2git thing creates, where the tag file contains just a direct pointer 
to the commit, rather than a pointer to a tag object.

I'm not a TCL weenie, so this is just a very quick hack, and you may want 
to re-do things properly, but something like the appended works for me..

> I also added a -t option to gitk which makes it use gitk-rev-tree
> instead of git-rev-list, so that you can do
> 
> 	gitk -t $(ls .git/refs/heads)

No need, I think yoy may have an old version of git.

		Linus

--- hacky hack hack ---
--- gitk	2005-06-09 07:26:50.000000000 -0700
+++ gitk	2005-06-09 07:55:00.000000000 -0700
@@ -151,6 +151,11 @@
 	    set fd [open $f r]
 	    set line [read $fd]
 	    if {[regexp {^[0-9a-f]{40}} $line id]} {
+		if {[regexp {[^/]*$} $f direct]} {
+		    set tagids($direct) $id
+		    lappend idtags($id) $direct
+		}
+
 		set contents [split [exec git-cat-file tag $id] "\n"]
 		set obj {}
 		set type {}
