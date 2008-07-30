From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Merging submodules
Date: Wed, 30 Jul 2008 18:59:39 -0400
Message-ID: <20080730225939.GA6471@Hermes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Lars Noschinski <lars-2008-1@usenet.noschinski.de>
To: H Merjin Brand <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Jul 31 01:00:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOKez-0003Pi-Fn
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 01:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbYG3W7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 18:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753252AbYG3W7p
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 18:59:45 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:44934 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074AbYG3W7o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 18:59:44 -0400
Received: from localhost.localdomain (cpe-69-205-127-75.rochester.res.rr.com [69.205.127.75])
	by silverinsanity.com (Postfix) with ESMTP id 644C41FFC02D;
	Wed, 30 Jul 2008 22:59:35 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90870>

This message got eaten by a syntax error somewhere.  This is a re-send, sorry for any duplicate messages.

On Jul 30, 2008, at 9:58 AM, H.Merijn Brand wrote:

> One (very) big disadvantage of  SCCS  is that commits are on a per-file
> basis, and only in a single directory. This drawback still haunts me in
> git, as my first attempts to convert were successful in a single folder
> and git cannot merge folders into a single project.
> 
> Say I now have
> 
> /work/src/project/.git
> /work/src/project/module_a/.git
> /work/src/project/module_b/.git
> /work/src/project/module_c/.git
> 
> Which are all converted repos from SCCS, I'd like to merge the three
> module_# repos into the top level repo.

Following the example of Linus, the following is completely untested.

First you fetch all of the heads/tags/etc into the superproject with commands like

git fetch module_a refs/heads/*:refs/remotes/module_a/*
git fetch module_b
refs/heads/*:refs/remotes/module_b/*
git fetch module_c
refs/heads/*:refs/remotes/module_c/*

Then you do something like:

rm -rf module_{a,b,c}/.git # Do this in a test repository, obviously...
git add module_a module_b module_c
git commit # Needed because '-s ours' uses current HEAD, not index
git merge --no-commit -s ours module_a/master module_b/master module_c/master
git commit --amend

>From this point on, the project repository has a merged history of the sub-projects, and if anyone doesn't catch up and still makes a commit on a subproject you can use "git merge -s subtree" to merge it in anyway.

You may need to "git rm --cached" some files after the "git add" step if your .gitignore files aren't perfect.

~~ Brian
