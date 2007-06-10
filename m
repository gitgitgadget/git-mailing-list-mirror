From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 10 Jun 2007 08:44:37 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706100831310.4059@racer.site>
References: <20070603114843.GA14336@artemis> <20070609121244.GA2951@artemis>
 <Pine.LNX.4.64.0706092152180.5848@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Jun 10 09:47:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxI9P-0007C6-RY
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 09:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761924AbXFJHru (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 03:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761959AbXFJHru
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 03:47:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:42781 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761747AbXFJHru (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 03:47:50 -0400
Received: (qmail invoked by alias); 10 Jun 2007 07:47:48 -0000
Received: from rdcg01.wifihubtelecom.net (EHLO [10.140.3.169]) [213.174.113.122]
  by mail.gmx.net (mp050) with SMTP; 10 Jun 2007 09:47:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18BoK5U06cB0J9HkYA8fd+p+QAIF3eTeI8NXv0VPf
	+qNOTbk75peNm9
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0706092152180.5848@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49665>

Hi,

On Sat, 9 Jun 2007, Daniel Barkalow wrote:

> 1) It's probably best to use some new types, rather than trees and 
> commits. This gives you more flexibility to structure things in ways 
> that exactly fit what's going on, which is one of the main reasons git 
> is so good for version control.

I fail to see why this has to be a new type. The flexibility in Git lies 
IMHO therein that it does _not_ have a plethora of objects. Rather, there 
are just 4 object types, which serve their purpose well, indeed. (I would 
even have argued that tag objects could have been simple commit objects, 
with an additional header "tag", but oh well.)

I suspect that you want to introduce a different object type to be able to 
implement a new algorithm. But I think that the appropriate data structure 
is still contained in the existing set of types in Git.

> 2) It's probably best to have the history be per-bug, with each revision 
> being an update to that report, and have the complete database be a 
> refs/ subdirectory.

I don't think that this is a good solution:

>From the implementation view point, a lot of branches sucks 
performance-wise. Especially since we do not pack branch refs.

Side note: I recently kicked around the idea to actually keep 
the refs in the packed-refs file, and for updating refs do a 
lock-mmap-findref-replace-or-rewrite, where a rewrite only happens if we 
delete or insert a ref.

Then, we could even unify the info/refs and packed-refs, so that we don't 
hear bugreports about http transport not working every week or so.

Just an idea.

Ciao,
Dscho
