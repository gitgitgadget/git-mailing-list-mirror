From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Wed, 30 Apr 2008 00:31:17 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804300016130.17469@eeepc-johanness>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de> <7vabjm78v2.fsf@gitster.siamese.dyndns.org>
 <20080422095549.GB3752@alea.gnuu.de> <alpine.DEB.1.00.0804221127360.4460@eeepc-johanness> <7vy775ygjm.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804221810180.4460@eeepc-johanness> <7v3ap5a4ny.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804290138170.27457@eeepc-johanness> <7vk5ih8ckp.fsf@gitster.siamese.dyndns.org> <4816CA72.8070405@viscovery.net> <alpine.DEB.1.00.0804291147450.27457@eeepc-johanness> <7vk5ig745b.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804292220120.13650@eeepc-johanness> <7viqy05mhp.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804292355060.17469@eeepc-johanness> <7v63u05khw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 01:32:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqzIl-0001q6-G3
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 01:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755317AbYD2XbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 19:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755059AbYD2XbK
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 19:31:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:32895 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754094AbYD2XbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 19:31:09 -0400
Received: (qmail invoked by alias); 29 Apr 2008 23:31:05 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp017) with SMTP; 30 Apr 2008 01:31:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18kamk7rEEkUk9pSww8+2fqJQd+CEpADfEdWiwjIo
	2TPiWcTnDQIj2L
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7v63u05khw.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80770>

Hi,

On Tue, 29 Apr 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 29 Apr 2008, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> 
> >> > It is a simple matter of the word "acyclic" in the term "DAG".  It 
> >> > means that whenever you need to refer to a commit, it either comes 
> >> > before or after the commit you need it for, not both directions.
> >> 
> >> I fell in the same "acyclic" fallacy before I realized it was a 
> >> mistake, especially after thought about the "rewritten B needs to be 
> >> used more than twice as a merge source" issue.  That's why I earlier 
> >> said the beauty of your approach is attractive but it "unfortunately" 
> >> breaks down.
> >
> > I do not understand.  The topological order assures that you have 
> > rewritten every commit that needs to be rewritten before rewriting the 
> > current commit.
> 
> Perhaps it would help to go back to the message J6t incompletely quoted, 
> and try the example with the parent order of Y swapped (i.e. B == Y^2, C 
> == Y^1)
> 
> Recreating X and Y both need to refer to the rewritten B as the 
> parameter to "merge" insn.  You create X first then you cannot refer to 
> B anymore to recreate Y.  The other way around you cannot name B to 
> recreate X.

If you refer to "B" as the "short name of the original commit which refers 
to the rewritten commit as soon as B was rewritten", then I really do not 
see the problem.

Every commit has 0..n parents.  These are properly identified before 
rebasing.  Some of them have to be rewritten, because they are rebased.

So if you order the commits topologically, so that ancestors come first, 
you will have to jump around a bit with the "reset" command, but you can 
basically make sure that all parents that needed rewriting were 
rewritten already before rewriting that commit.

Now, if you want to split a commit, you may want to refer to the original 
commit instead of an already rewritten commit, but I think that this 
occasion is rare enough, that we can ask the user to tag that commit, and 
refer to that commit by its tag in the todo list.

Or you write down the original's long name and use that one.

But if you use the _default_ todo list, i.e. you want to rebase preserving 
merges without interfering manually with the process, what I said about 
the topological ordering still holds true.

At no point will you need to refer _both_ to the original _and_ to the 
rewritten commit name.

Come to think of it, I cannot think of a (default) case where the 
_original_ name of a to-be-rewritten commit has to be referred to, except 
for the "pick" command.

Ciao,
Dscho
