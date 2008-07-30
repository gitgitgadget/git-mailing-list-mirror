From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Merging submodules (was Re: Feature suggestion: git-hist)
Date: Wed, 30 Jul 2008 19:03:37 -0400
Message-ID: <20080730230336.GA6481@Hermes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Lars Noschinski <lars-2008-1@usenet.noschinski.de>
To: H Merjin Brand <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Jul 31 01:04:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOKin-0004M1-DM
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 01:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbYG3XDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 19:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbYG3XDk
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 19:03:40 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:60524 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbYG3XDk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 19:03:40 -0400
Received: from localhost.localdomain (cpe-69-205-127-75.rochester.res.rr.com [69.205.127.75])
	by silverinsanity.com (Postfix) with ESMTP id CF2581FFC02D;
	Wed, 30 Jul 2008 23:03:30 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90872>

This message got eaten by a syntax error somewhere.  This is a re-send, sorry for any duplicate messages.

On Jul 30, 2008, at 12:26 PM, H.Merijn Brand wrote:

> On Wed, 30 Jul 2008 11:15:55 -0400, Brian Gernhardt
> <benji@silverinsanity.com> wrote:
> 
> > Then you do something like:
> > 
> > rm -rf module_{a,b,c}/.git # Do this in a test repository, obviously...
> > git add module_a module_b module_c
> > git commit # Needed because '-s ours' uses current HEAD, not index
> 
> So far so good.
> 
> > git merge --no-commit -s ours module_a/master module_b/master module_c/master
> 
> $ git merge --no-commit -s ours fnc/master i00f000/master
> i99f000/master include/master l00m000/master l01f000/master
> l02f000/master l03f000/master l06f000/master l90z000/master
> leerpl/master mutbev/master prtabel/master rpt/master tabellen/master
> zoomen/master Automatic merge went well; stopped before committing as
> requested
> 
> > git commit --amend
> 
> $ git commit --amend
> fatal: You are in the middle of a merge -- cannot amend.

Hm.  I did mention this was completely untested, yes?  The problem comes
from the fact that '-s ours' wants to use HEAD, not the index.  But you
can't amend a normal commit into a merge, apparently.  And I don't think
you want a commit that adds the files and a commit that "does the merge"
as two separate steps.

Well, I don't know how to make the porcelain do this then. But the
plumbing can definitely do it.  Hopefully someone more used to doing
strange things like this can give a simpler recipe, but this should
work.

# First reset to the commit you made with all the modules added.
vim commit-message # Create a merge message
commit=$(git commit-tree HEAD: -p HEAD^ -p module_a/master -p
		module_b/master -p module_c/master < commit-message)
git update-ref HEAD $commit  # Update your current ref

~~ Brian
