From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Mon, 12 Mar 2012 12:22:31 +0100
Message-ID: <1kguf28.1u417v5fn74afM%lists@haller-berlin.de>
References: <vpqzkbmcijl.fsf@bauges.imag.fr>
Cc: gitster@pobox.com (Junio C Hamano),
	marcnarc@xiplink.com (Marc Branchaud),
	cmn@elego.de (=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?=),
	git@vger.kernel.org
To: Matthieu.Moy@grenoble-inp.fr (Matthieu Moy)
X-From: git-owner@vger.kernel.org Mon Mar 12 12:22:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S73Ke-0004bE-UN
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 12:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697Ab2CLLWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 07:22:24 -0400
Received: from server90.greatnet.de ([83.133.96.186]:58586 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185Ab2CLLWY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 07:22:24 -0400
Received: from [192.168.0.42] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id CD9973B0DAF;
	Mon, 12 Mar 2012 12:22:22 +0100 (CET)
In-Reply-To: <vpqzkbmcijl.fsf@bauges.imag.fr>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.7.3 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192853>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:

> lists@haller-berlin.de (Stefan Haller) writes:
> 
> > We're a closed-source company that uses git more or less like an
> > old-style, non-distributed VCS.
> > [...]
> > Also, it is very common for two or more developers to collaborate on a
> > topic branch,
> > [...]
> > Topics are never pushed to master; we have a "merge --no-ff" policy for
> > integration.
> > [...]
> > To sum it up, push.default=current is almost perfect for this kind of
> > workflow; except that you still need to configure your upstream branches
> > so that pull works, and status (and the shell prompt) displays the right
> > information.
> 
> What do you set "upstream" to in your flow?

The remote topic branch with the same name.

> I agree that push.default=current is the best setting for you. But I
> think 'tracking' would not be a silly choice either: if you collaborate
> on topic branches, it makes sense to set the upstream to the remote
> topic branch, so that "git pull" gets changes in the same branch (and
> you may need to "git pull origin master" to sync with the master branch
> from time to time). If you create a new branch with, say
> 
>   git checkout -b new-branch
> 
> then the new branch has no upstream configured, and the next push
> without argument will fail, pointing you to the right command for your
> case:
> 
>   $ git push
>   fatal: The current branch new-branch has no upstream branch.
>   To push the current branch and set the remote as upstream, use
>   
>       git push --set-upstream origin new-branch
> 
> If you do a "git checkout new-branch" when "origin/new-branch" exists
> and "new-branch" doesn't, the upstream is configured to point to the
> remote "new-branch".

Yes, you describe exactly what we are doing.  I am having two problems
with this way of working:

1) After creating a new local topic branch, I must remember to use
"push -u origin new-branch" the first time I push it. I don't want to
have to remember whether this is the first time I push; it would be nice
to be able to say "git push" the first time as well.
(push.default=current does this, but it's not good enough because I
still need the upstream branch configured so that pull works.)

2) I get bitten by commands that configure the "wrong" upstream branch
without me realizing it, like "checkout -b topic origin/master". Again,
push.default=current helps somewhat because it avoids accidentally
pushing to the wrong branch; but it will still let me pull from the
wrong branch; and it will confuse me because my shell prompt tells me
I'm ahead of upstream even though I just pushed.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
