From: Johan Herland <johan@herland.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 14 Feb 2011 00:36:41 +0100
Message-ID: <201102140036.42197.johan@herland.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102080159.02153.johan@herland.net> <m3mxm28v3i.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 00:37:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PolV8-00071U-3W
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 00:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755251Ab1BMXhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 18:37:05 -0500
Received: from smtp.getmail.no ([84.208.15.66]:64479 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754570Ab1BMXhD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 18:37:03 -0500
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LGK00FTLXLEFTB0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 14 Feb 2011 00:36:50 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 5E5841EA55B6_D586B12B	for <git@vger.kernel.org>; Sun,
 13 Feb 2011 23:36:50 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id DFBD31EA3AA0_D586B11F	for <git@vger.kernel.org>; Sun,
 13 Feb 2011 23:36:49 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LGK00E0KXL6VA20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 14 Feb 2011 00:36:49 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <m3mxm28v3i.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166683>

On Friday 11 February 2011, Jakub Narebski wrote:
> Johan Herland <johan@herland.net> writes:
> > - Lack of consistency in the ref namespace (refs/remotes/$remote/* vs.
> > refs/tags/*). Also not clear from the current layout where to add new
> > types of refs (e.g. notes, replace). My proposal tries to address this
> > issue.
> 
> The lack of consistency is there because tags should USUALLY be global
> (there should be only one v1.7.4), while branch names should be local
> (my 'master' branch is not your 'master' branch).
>
> In some cases, like joining or subtree-merging unrelated projects we
> would want local / per-remote tags: 'v1.7.4' in main project is not
> 'v1.7.4' in 'foo' subproject (in 'foo' remote).  Currently we lack a
> way to specify that (the 'autofollow' refspec proposal, default
> behaviour would be equivalent to '~refs/tags/*:refs/tags/*"), and lack
> support from porcelain: MY PROPOSAL is to add '--use-separate-tags'
> (like old '--use-separate-remote') to "git clone" and "git remote add",
> and perhaps '--alternate' as equivalent to '--no-separate-tags' to
> "git remote add".

That requires you to know about the (potential) tag collision (and remember 
to use your option) before fetching from the remote repo.

Also, even with your added option - which we can use when interfacing 
unrelated projects from a single repo - the expectation (common case) is 
still that Git will pollute your local tag namespace with remote tags. Some 
of us consider this a bug/misfeature in its own right. And we hold that 
opinion while still agreeing with you that tags "should USUALLY be global".

> > - Lack of consistency in which fetch refspecs must be listed in the
> > configuration. (i.e. implicit vs. explicit fetch refspecs). My proposal
> > tries to address this as well.
> 
> Could you repeat your proposal?

http://thread.gmane.org/gmane.comp.version-control.git/165799/focus=165885

> Do I remember it correctly that with
> 'autofollow' refspec (valid only for tags... well, perhaps also for
> notes and replacements) you want to specify defaults in config
> explicitely
> 
>   [remote "origin"]
>         url = git://git.example.com/repo.git
>         fetch = +refs/heads/*:refs/remotes/origin/*
>         fetch = ~refs/tags/*:refs/tags/*

Yes, replicating existing behavior w/explicit refspecs would look like this:

  [remote "origin"]
        url = git://git.example.com/repo.git
        fetch = +HEAD:refs/remotes/origin/HEAD
        fetch = +refs/heads/*:refs/remotes/origin/*
        fetch = ~refs/tags/*:refs/tags/*

> Perhaps with
> 
>         fetch = +refs/heads/*:refs/remotes/origin/heads/*

FTR, my new/proposed refspecs would look like this:

  [remote "origin"]
        url = git://git.example.com/repo.git
        fetch = +HEAD:refs/remotes/origin/HEAD
        fetch = +refs/heads/*:refs/remotes/origin/heads*
        fetch = ~+refs/tags/*:refs/remotes/origin/tags/*
      ( fetch = +refs/notes/*:refs/remotes/origin/notes/* )
      ( fetch = +refs/replace/*:refs/remotes/origin/replace/* )

> > - Lack of consistency in porcelain interfaces. Some of these have been
> > fixed in recent Git version, but some are yet to be fixed: E.g. some
> > find the use of FETCH_HEAD confusing (when does fetch update the
> > remote refs, and when does it update FETCH_HEAD instead?).
> 
> One of problems is how to keep the fact that
> 
>   $ git pull <URL> <branch>
> 
> does one-off pull without creating remote or remote-tracking branch.
> But I agree that behavior of
> 
>   $ git pull <remote> <branch>
> 
> can be confusing.

Yes, to me it seems intuitive that when you specify <URL> (even if <URL> 
corresponds to an existing remote) you do NOT update remote-tracking refs, 
but if you use <remote>, you should ALWAYS update remote-tracking refs. 
Others may disagree.

> >  Others (myself included) wonder why 'git push' by default updates
> > 
> > remote branches with matching names, while 'git pull' relies on the
> > explicitly configured upstreams to update the local refs. (FWIW,
> > I've mitigated this last complaint insisting that all users at
> > $dayjob run "git config --global push.default tracking" immediately
> > after installing Git.) There are other UI inconsistencies too that
> > escape me ATM.
> 
> IMHO that's not inconsisnency in Git, this is just reflection of the
> fact that in most common case the situation is *assymetric* with
> respect to fetch and push; you fetch from other people repositories,
> but you push to (usually single, perhaps mirrored) your own publishing
> repository.  For this situation 'push.default = matching' works
> perfectly.

It may seem so, but in my experience it doesn't really work perfectly: Even 
if I fully control the repo I push to, I still want precise control over 
what I push there. Sometimes I may working on 'next' and 'master' in 
parallel, and I might have finished and tested some bugfixes on 'master', 
while I still have unfinished/untested stuff on 'next'. When I 'git push' 
from 'master', I DO NOT want 'next' to be pushed (unless I have explicitly 
asked for it).

If I'm pushing to a shared repo (a very common workplace setup), this 
default is even more potentially damaging (especially if I don't discover 
what's actually happening by scanning the output from 'git push').

This is one area where Git's current default behavior is less conservative 
than I would like.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
