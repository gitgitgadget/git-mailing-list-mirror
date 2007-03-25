From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Understanding version 4 packs
Date: Sun, 25 Mar 2007 10:09:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703251004580.6730@woody.linux-foundation.org>
References: <20070324202356.GA20734@bohr.gbar.dtu.dk>
 <alpine.LFD.0.83.0703241913110.18328@xanadu.home> <20070325083530.GA25523@bohr.gbar.dtu.dk>
 <20070325091806.GH25863@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Eriksen <s022018@student.dtu.dk>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Mar 25 19:09:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVWDx-0007X9-FC
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 19:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbXCYRJm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 13:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbXCYRJm
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 13:09:42 -0400
Received: from smtp.osdl.org ([65.172.181.24]:49375 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951AbXCYRJl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 13:09:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2PH9F1o019720
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 25 Mar 2007 10:09:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2PH9EMR031981;
	Sun, 25 Mar 2007 10:09:14 -0700
In-Reply-To: <20070325091806.GH25863@spearce.org>
X-Spam-Status: No, hits=-0.473 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43059>



On Sun, 25 Mar 2007, Shawn O. Pearce wrote:
> >
> > What happens to the paths, that do not have a correponding entry in the
> > path name table, because they are not among the 65535 most frequent
> > paths in the pack?
> 
> They don't appear in the table.  And any tree that uses them is
> forced to use the "legacy" OBJ_TREE encoding.  Which is what we
> have now in pack v2, and in loose objects.

Would it hurt too much to just make it four bytes, and avoid that issue?

Special cases - and *especially* special cases that are hard to trigger in 
the first place - equal bugs. And bugs are much much worse than trying to 
save a little bit of space.

> The author_time field is not present if flags & 128 is true.
> If flags & 128 is false, its present, and uses the same encoding
> as commit_time.  Why is this field optional?  Because its not
> uncommon for it to match commit_time!  ;-)

If the author time is the same as the commit time, most of the time the 
author is the same as the committer too, no? So the field should be 
conditional not for the author_time, but for the combination, no?

Our email-parsing tools (which is the most common reason for a committer 
not being the same as the author) all take the author date from the email. 
So I don't think author_time == committer_time except when the committer 
and the author are one and the same person.

			Linus
