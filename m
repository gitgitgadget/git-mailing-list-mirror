From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git-svn: Finding the svn-URL of the current branch in git
Date: Wed, 8 Aug 2007 22:57:31 +0200
Message-ID: <20070808205731.GF27470@xp.machine.xx>
References: <46B8BA03.1030809@gmx.de> <20070807205543.GB27703@xp.machine.xx> <f9c0d1$7md$1@sea.gmane.org> <7vy7gm4cdv.fsf@assigned-by-dhcp.cox.net> <f9d3ce$1lo$1@sea.gmane.org> <20070808192537.GB27470@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Matthias Kleine <matthias_kleine@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 22:57:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIsb1-00040q-Hf
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 22:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761937AbXHHU5b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 16:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761652AbXHHU5b
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 16:57:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:36250 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761622AbXHHU5b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 16:57:31 -0400
Received: (qmail invoked by alias); 08 Aug 2007 20:57:29 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp023) with SMTP; 08 Aug 2007 22:57:29 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19tZBAHLLJtdF7IYpSIGbTl5EjAqU1iAaw+9UNLNq
	IpKVK3118GY3G6
Mail-Followup-To: Matthias Kleine <matthias_kleine@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070808192537.GB27470@xp.machine.xx>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55363>

On Wed, Aug 08, 2007 at 09:25:37PM +0200, Peter Baumann wrote:
> On Wed, Aug 08, 2007 at 08:51:55PM +0200, Matthias Kleine wrote:
> > Junio C Hamano wrote:
> >> Parents' order and which branch you are on may not have anything
> >> to do with each other.  Somebody else may have pulled a while on
> >> b, and you might have pulled from him the merge he created by
> >> doing so while you are on branch a.
> >
> > You're right, I didn't think of that. While pondering this I came up with
> > another problem: git-svn currently remembers which svn-branch a commit
> > belongs to by including this information in the git commit log message.
> 
> Thats true.
> 
> > This way it is not possible to have one git-commit appear in more than one
> > svn branch.
> 
> But there is no way that a git commit could appear on several branches
> in SVN, because SVN doesn't have the concept of multiple parents. So you
> can't have a commit which describes a merge of two branches, because SVN
> can't store the 2 parents. But you could have 2 commits which describe
> the same state (e.g. same root tree), but are on seperate branches.
> 
> t:= commits on trunk
> b:= commits on branch 'b'
> 
> repo1:
> 	t    <-trunk
> 	|
> 	t
> 	| \
> 	t  b <- branch
> 	| /
> 	t
> 
> But this graph is only local to the committers repo. Another person
> using git-svn to track the SVN repo sees this
> 
> repo2/SVN repo:
> 
> 	t     <-trunk
> 	|
> 	t
> 	|
> 	t  b  <- branch
> 	| /
> 	t
> 
> So if you do a 'git merge trunk' in repo1 on branch 'branch', git-svn
> should produce something like this:
> 
> repo2/SVN repo:
> 
> trunk->	t  t' <- branch
> 	|  |
> 	t  t'
> 	|  |
> 	t  b
> 	| /
> 	t
> 
> The interesting case is what it will produce in *YOUR* repo. There are 2
                                  ^- should, because both cases aren't
				  implemented yet.
> possibilities:
> 
> repo1 (I):				repo1 (II)
> 	tb   <-trunk <-branch		trunk->	t  b <- branch
> 	|					|  |
> 	tb					t  b
> 	| \					| \|
> 	t  b <- branch				t  b
> 	| /					| /
> 	t					t
> 
> (I)  would be nicer, but propably more difficult the way git-svn works now.
> 
> (II) would also be possible and more in line what other people importing
>      from SVN see.
> 
> These are the possible ways to describe the merge of 2 SVN branches.
> 
-Peter
