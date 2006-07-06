From: Marc Singer <woolie@cac.washington.edu>
Subject: Moving a topic branch forward: rebase vs. resolve
Date: Thu, 6 Jul 2006 14:10:08 -0700
Message-ID: <20060706211008.GA6566@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jul 06 23:10:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fyb70-0003xf-3X
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 23:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWGFVKK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 17:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWGFVKK
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 17:10:10 -0400
Received: from 206-124-142-26.buici.com ([206.124.142.26]:42989 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S1750860AbWGFVKJ
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 6 Jul 2006 17:10:09 -0400
Received: (qmail 7246 invoked by uid 1000); 6 Jul 2006 21:10:08 -0000
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23402>

In moving a topic branch forward from about 2.6.16 to 2.6.18-rc1, I'm
finding little solace in either rebase or resolve.


  REBASE

Rebase is an attractive method as it preserves the change history,
though in the end the only interesting bits are those that are merged
with master.  


  --1---2----3---4   master
     \
      --A--B--C      topic


In rebasing ABC at 4, it looks like git is applying each patch in
turn.  While this is strictly correct, it can make for a tedious merge
if both A and C modify the same piece of code *and* if revision 2
makes both A and C merge with conflicts.  The result was an exhausting
march through the change sets.


  RESOLVE

So, I tried resolve which I would expect to apply the other direction,
merging 234 onto C.  git-resolve finishes in a single pass leaving
conflict markers in a number of files.  However, some of these are
unexpected, conflicts in files that I've not and which I'd expect to
merge cleanly.  For example

    diff --git a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
    index 2975291..fea24ba 100644
    --- a/Documentation/DocBook/Makefile
    +++ b/Documentation/DocBook/Makefile
    @@ -2,15 +2,21 @@ ###
     # This makefile is used to generate the kernel documentation,
     # primarily based on in-line comments in various source files.
     # See Documentation/kernel-doc-nano-HOWTO.txt for instruction in how
    -# to ducument the SRC - and how to read it.
    +# to document the SRC - and how to read it.
     # To add a new book the only step required is to add the book to the
     # list of DOCBOOKS.

     DOCBOOKS := wanbook.xml z8530book.xml mcabook.xml videobook.xml \
		kernel-hacking.xml kernel-locking.xml deviceiobook.xml \
		procfs-guide.xml writing_usb_driver.xml \
    +<<<<<<< .merge_file_arWYZk
		kernel-api.xml journal-api.xml lsm.xml usb.xml \
		gadget.xml libata.xml mtdnand.xml librs.xml rapidio.xml
    +=======
    +           kernel-api.xml journal-api.xml lsm.xml usb.xml \
    +           gadget.xml libata.xml mtdnand.xml librs.xml rapidio.xml \
    +           genericirq.xml
    +>>>>>>> .merge_file_G8cSmh


We have a spelling fix and the addition of genericirq.xml.  What would
cause these sorts of conflicts?  Is there someting I can do to
eliminate them or resolve them properly?

Cheers.
