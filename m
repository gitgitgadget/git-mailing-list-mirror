From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: grafts+repack+prune = history at danger
Date: Fri, 26 Jan 2007 16:56:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701261652440.25027@woody.linux-foundation.org>
References: <45B8E61E.C9C5E6C6@eudaptics.com> <7vireu7lj0.fsf@assigned-by-dhcp.cox.net>
 <45B9B80E.E2534F97@eudaptics.com> <7vr6ti183o.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0701260747110.25027@woody.linux-foundation.org>
 <7vtzydtkqu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 27 01:56:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAbsG-0004HX-Lh
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 01:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbXA0A4t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 19:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbXA0A4t
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 19:56:49 -0500
Received: from smtp.osdl.org ([65.172.181.24]:34403 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbXA0A4t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 19:56:49 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0R0ug1m023426
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 26 Jan 2007 16:56:42 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0R0uf5T031184;
	Fri, 26 Jan 2007 16:56:41 -0800
In-Reply-To: <7vtzydtkqu.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.553 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37908>



On Fri, 26 Jan 2007, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> >
> >  - "git prune" would *also* explicitly set it to zero, but would also 
> >    manually look at the grafts file, and mark anything that is set in the 
> >    grafts file as being reachable (the same way it does for index entries 
> >    etc).
> 
> I am not sure why your "git prune" one does that, but will think
> about it for some time first before I ask you to waste your time
> explaining it me.

Simple: the grafts may actually _hide_ history too - not just add it.

Sure, commonly, a graft is used to graft two complete trees together (eg, 
you'd graft the old Linux history into the new Linux history tree). 

However, they _can_ also be used to "fix" history - say that you had one 
tree that has a rough history (with all the releases, but not the full 
history between them), and another "fine-grained" historical tree. You 
could use a graft to replace the rough history version with the 
fine-grained one, so the graft may actually hide stuff that is there in 
the rough history.

So in this case, we wouldn't necessarily want to prune stuff that 
"exists", but is hidden by a graft. So in my suggestion, pruning would 
basically only use the grafts file to *add* refs, never to hide them.

		Linus
