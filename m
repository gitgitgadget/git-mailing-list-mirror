From: ydirson@free.fr
Subject: Re: Commit notes workflow
Date: Tue, 14 Jun 2011 16:21:24 +0200 (CEST)
Message-ID: <1475517428.913101308061284785.JavaMail.root@zimbra44-e7.priv.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, dirson <dirson@bertin.fr>,
	ydirson <ydirson@free.fr>
To: johan@herland.net
X-From: git-owner@vger.kernel.org Tue Jun 14 16:21:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWUUx-0002Mh-Sh
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 16:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316Ab1FNOVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 10:21:39 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:60594 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977Ab1FNOVi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 10:21:38 -0400
Received: from zimbra44-e7.priv.proxad.net (unknown [172.20.243.194])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 101AC9400F9;
	Tue, 14 Jun 2011 16:21:26 +0200 (CEST)
X-Originating-IP: [80.150.211.114]
X-Mailer: Zimbra 5.0 (ZimbraWebClient - SAF3 (Linux)/5.0.15_GA_2815.UBUNTU8_64)
X-Authenticated-User: ydirson@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175772>

> > Do we really want to "git notes" to ignore everything not in  refs/notes/
> > ? I can think of 2 possibilities out of this situation:
> > 
> > * remove that limitation
> > * decide on a naming convention for remote notes, and teach  "git notes"
> > not to ignore it
> 
> The naming convention I have proposed (in the discussion for 
> [1]) is 
> 
> refs/notes/*:refs/remotes/$remote/notes/*
> 
> (but it obviously depends on reorganizing the entire remote refs  hierarchy)
> > A (minor) problem with the second possibility is that this naming
> > convention could evolve, eg. if we end up with something like was
> > proposed in [1] for 1.8.0. Is there any real drawback with  the first
> > suggestion ?
> > 
> > [1] http://marc.info/?l=git&m=129661334011986&w=4
> 
> My gut feeling is to keep some sort of limit notes refs, and  if/when we get 
> around to implementing my proposal in [1] (or some variation  thereof), we 
> will of course extend the limit to put  "refs/remotes/$remote/notes/*" (or 
> whatever is decided) in the same category as "refs/notes/*".
> 
> In the meantime, I'm unsure if it's a good idea to remove the  limitation 
> altogether (allowing notes refs everywhere), since re- introducing a limit at 
> a later point will then be MUCH harder...

So we could introduce something like refs/remote-notes/<remote>/* today to
start working, and eventually phase it out when refs/remotes/ gets restructured.

Then the next point will be how best to provide git-pull-like support for notes refs.
We have a number of alternatives, like:

* having "git pull" run "git notes merge" on all notes refs with a tracking-branch set to
   the repo from which we pull
* do the same for a configured set of notes refs only
* only have "git pull" and "git status" notify about notes refs being not uptodate, and
   add an explicit "git notes pull" command of some sort (maybe just "git notes merge"
   without an argument, which would be consistent with latest "git merge")
* surely others
