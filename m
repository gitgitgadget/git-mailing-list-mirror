From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/4] reset: use "unpack_trees()" directly instead of "git
 read-tree"
Date: Fri, 11 Sep 2009 02:32:11 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909110136160.28290@iabervon.org>
References: <20090910200334.3722.20140.chriscool@tuxfamily.org> <20090910202333.3722.58409.chriscool@tuxfamily.org> <7v1vme2h2f.fsf@alter.siamese.dyndns.org> <200909110734.13903.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Sep 11 08:32:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlzgB-0004lg-Lw
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 08:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925AbZIKGcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 02:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753895AbZIKGcJ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 02:32:09 -0400
Received: from iabervon.org ([66.92.72.58]:40225 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752404AbZIKGcI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 02:32:08 -0400
Received: (qmail 638 invoked by uid 1000); 11 Sep 2009 06:32:11 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Sep 2009 06:32:11 -0000
In-Reply-To: <200909110734.13903.chriscool@tuxfamily.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128178>

On Fri, 11 Sep 2009, Christian Couder wrote:

> On Friday 11 September 2009, Junio C Hamano wrote:
> > Christian Couder <chriscool@tuxfamily.org> writes:
> > > From: Stephan Beyer <s-beyer@gmx.net>
> > >
> > > This patch makes "reset_index_file()" call "unpack_trees()" directly
> > > instead of forking and execing "git read-tree".
> >
> > And the reason why it is a good idea is...?
> 
> ...that it should be faster.
> 
> Ok, I will add that to the commit message in the next version.

There's also the benefit (IMHO, more significant) that git-read-tree's 
command line parsing is complicated, and using it from git-reset makes it 
hard to see exactly what each option of "git reset" does in terms of 
operations on the index and the working tree.

For example, it's not obvious when reading the code to run read-tree that 
all of the branches lead to the use of the "merge" flag, because some 
branches use "-m" and some use "--reset".

Actually, there's a behavior difference between the old version and the 
new version. The old version gives an error for "git reset --merge" with 
unmerged entries (unlike any other option to "git reset", AFAICT), and the 
new version does not. There's no way you'd know this without a careful 
reading of cmd_read_tree() and cross-reference with reset_index_file(), 
since the documentation doesn't mention it, the code in reset_index_file() 
only replaces "--reset" with "-m", and it seems to be doing that for the 
effect of not ignoring differences in the working tree.

	-Daniel
*This .sig left intentionally blank*
