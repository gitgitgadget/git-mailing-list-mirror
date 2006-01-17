From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: RFC: Subprojects
Date: Tue, 17 Jan 2006 00:46:40 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601170001130.25300@iabervon.org>
References: <43C52B1F.8020706@hogyros.de> <Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>
 <7vek3ah8f9.fsf@assigned-by-dhcp.cox.net> <200601161144.48245.Josef.Weidendorfer@gmx.de>
 <7vek37rj83.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 06:44:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyjeG-0003Zw-Mo
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 06:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWAQFot (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 00:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWAQFot
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 00:44:49 -0500
Received: from iabervon.org ([66.92.72.58]:64267 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750996AbWAQFot (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2006 00:44:49 -0500
Received: (qmail 15536 invoked by uid 1000); 17 Jan 2006 00:46:40 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Jan 2006 00:46:40 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek37rj83.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14776>

On Mon, 16 Jan 2006, Junio C Hamano wrote:

>    We could introduce "bind the rest" to make write-tree write
>    out a tree that contains only the containing project part and
>    not any of the subproject part (e.g. Makefile, README and
>    src/ but not linux-2.6/ nor gcc-4.0/ in the earlier example).
>    Essentially the contents of such a tree object would be the
>    same as what "gitlink" approach would have had for the
>    containing project in the index file, minus "gitlink" entries
>    themselves).  This is not so surprising, because the missing
>    information "gitlink" approach recorded in the tree object
>    itself is expressed on "bind" lines in the commit object with
>    this approach.

So why not use the "bind" approach for the "index vs working tree" part, 
but write out "gitlink"-style tree objects? I think putting the info in 
the tree objects in the location the subproject would appear is nicer than 
having tree objects that tell only part of the story, and you don't have 
to worry about commits that stick a subproject on top of something in the 
tree.

In any case, I think it would be good to track where the subprojects are 
in some core state, and probably the right solution is to have special 
index entries for them, in addition to having their contents in the index. 
I'm not seeing a clear way to get from commit objects with "bind" lines to 
an index with the appropriate things read and back otherwise.

One idea I toyed with a while ago for the index/working tree 
implementation is having an index file per bound project, such that each 
project has a completely ordinary index file, and you just need to tell 
checkout-index where to write. This is especially cute because the index 
file for the superproject doesn't need to know about the subprojects at 
all; they're not in that index, and the working tree is just directories 
of untracked files. Not sure if this is a useful idea at this point or 
not.

	-Daniel
*This .sig left intentionally blank*
