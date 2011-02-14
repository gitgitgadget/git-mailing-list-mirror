From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 14 Feb 2011 10:40:32 +0100
Message-ID: <201102141040.35819.jnareb@gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com> <m3mxm28v3i.fsf@localhost.localdomain> <201102140036.42197.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 10:41:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PouvX-0005YB-6V
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 10:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607Ab1BNJkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 04:40:51 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47777 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab1BNJku (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 04:40:50 -0500
Received: by ywo7 with SMTP id 7so1962866ywo.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 01:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=GBqLJ1hee61FpSzKOd83uA5GEp8lG1K+cNMd8i1yHdk=;
        b=XdfQ3N5oaXC6bWXUPREwd82n3CQYXwkc6nk1InwhH9g52gCWwnJEiwYoG4YzWiYpdm
         sdA/Y2/CZdFdpprLfGa/ptaQ2SDsmh5iutjGZozDtaYPnAnsoXYUYKGfJBULlWvQk9gt
         hYN61ohEfYJRfPp5s1XKNA8lP55JluRBoftck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=U1QY8XS5Q1cSrjBbNk+ko8wI4kQaCl7EZonPus/sBaor+oeTEyOXlx40Lf5sYgwb1Y
         wq8A2GYzlUNvoMOg1YGVn2lzeysssXnkIvIQl/+yagKQqVuL5uuso9fPfUVtu9ajjNKM
         CvnR1IVBqMowvwKp57eWsOZ+i9RpznPrZc4rY=
Received: by 10.147.170.19 with SMTP id x19mr4752295yao.3.1297676449403;
        Mon, 14 Feb 2011 01:40:49 -0800 (PST)
Received: from [192.168.1.13] (abvr76.neoplus.adsl.tpnet.pl [83.8.215.76])
        by mx.google.com with ESMTPS id f73sm1438690yhc.4.2011.02.14.01.40.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Feb 2011 01:40:47 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201102140036.42197.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166700>

On Mon, 14 Feb 2011, Johan Herland wrote:
> On Friday 11 February 2011, Jakub Narebski wrote:
> > Johan Herland <johan@herland.net> writes:

> > > - Lack of consistency in the ref namespace (refs/remotes/$remote/* vs.
> > > refs/tags/*). Also not clear from the current layout where to add new
> > > types of refs (e.g. notes, replace). My proposal tries to address this
> > > issue.
> > 
> > The lack of consistency is there because tags should USUALLY be global
> > (there should be only one v1.7.4), while branch names should be local
> > (my 'master' branch is not your 'master' branch).
> >
> > In some cases, like joining or subtree-merging unrelated projects we
> > would want local / per-remote tags: 'v1.7.4' in main project is not
> > 'v1.7.4' in 'foo' subproject (in 'foo' remote).  Currently we lack a
> > way to specify that (the 'autofollow' refspec proposal, default
> > behaviour would be equivalent to '~refs/tags/*:refs/tags/*"), and lack
> > support from porcelain: MY PROPOSAL is to add '--use-separate-tags'
> > (like old '--use-separate-remote') to "git clone" and "git remote add",
> > and perhaps '--alternate' as equivalent to '--no-separate-tags' to
> > "git remote add".
> 
> That requires you to know about the (potential) tag collision (and remember 
> to use your option) before fetching from the remote repo.

No, what you need to know at te point of adding remote with "git remote add"
is to know whether the repository is alternative / extra repository of the
same project (common tags), or whether it is separate project (separate
tags).

Which you should know at this point.
 
> Also, even with your added option - which we can use when interfacing 
> unrelated projects from a single repo - the expectation (common case) is 
> still that Git will pollute your local tag namespace with remote tags. Some 
> of us consider this a bug/misfeature in its own right. And we hold that 
> opinion while still agreeing with you that tags "should USUALLY be global".

I don't think the distinction is between local and per-remote tags.  It
is about local (your own) bookmarking tags versus global repository tags
(_not_ per-remote) for marking releases.

I guess that current layout might be not best, but per-remote tags isn't it
either, in my opinion.


Please consider this use case:

Let's assume that current maintainer steps aside for a bit, and new interim
temporary maintainer takes mantle.  One would add new remote _temporarily_,
but one would want for tags that temporary maintainer created to be as good
as tags from 'origin' remote... and not be deleted when you remove temp
remote and its remote-tracking branches.

[...]
> > Do I remember it correctly that with
> > 'autofollow' refspec (valid only for tags... well, perhaps also for
> > notes and replacements) you want to specify defaults in config
> > explicitely
> > 
> >   [remote "origin"]
> >         url = git://git.example.com/repo.git
> >         fetch = +refs/heads/*:refs/remotes/origin/*
> >         fetch = ~refs/tags/*:refs/tags/*
> 
> Yes, replicating existing behavior w/explicit refspecs would look like this:
> 
>   [remote "origin"]
>         url = git://git.example.com/repo.git
>         fetch = +HEAD:refs/remotes/origin/HEAD
>         fetch = +refs/heads/*:refs/remotes/origin/*
>         fetch = ~refs/tags/*:refs/tags/*

I'm not sure about HEAD refspec; we don't have one for transferring symrefs.
"git push <remote> HEAD" doesn't push HEAD ut the current branch.

[...]
> > > - Lack of consistency in porcelain interfaces. Some of these have been
> > > fixed in recent Git version, but some are yet to be fixed: E.g. some
> > > find the use of FETCH_HEAD confusing (when does fetch update the
> > > remote refs, and when does it update FETCH_HEAD instead?).
> > 
> > One of problems is how to keep the fact that
> > 
> >   $ git pull <URL> <branch>
> > 
> > does one-off pull without creating remote or remote-tracking branch.
> > But I agree that behavior of
> > 
> >   $ git pull <remote> <branch>
> > 
> > can be confusing.
> 
> Yes, to me it seems intuitive that when you specify <URL> (even if <URL> 
> corresponds to an existing remote) you do NOT update remote-tracking refs, 
> but if you use <remote>, you should ALWAYS update remote-tracking refs. 
> Others may disagree.

I agree.  Keeping remote-tracking branches stale on purpose doesn't look
for me like a sane workflow.

> > >  Others (myself included) wonder why 'git push' by default updates
> > > 
> > > remote branches with matching names, while 'git pull' relies on the
> > > explicitly configured upstreams to update the local refs. (FWIW,
> > > I've mitigated this last complaint insisting that all users at
> > > $dayjob run "git config --global push.default tracking" immediately
> > > after installing Git.) There are other UI inconsistencies too that
> > > escape me ATM.
> > 
> > IMHO that's not inconsistency in Git, this is just reflection of the
> > fact that in most common case the situation is *assymetric* with
> > respect to fetch and push; you fetch from other people repositories,
> > but you push to (usually single, perhaps mirrored) your own publishing
> > repository.  For this situation 'push.default = matching' works
> > perfectly.
> 
> It may seem so, but in my experience it doesn't really work perfectly: Even 
> if I fully control the repo I push to, I still want precise control over 
> what I push there. Sometimes I may working on 'next' and 'master' in 
> parallel, and I might have finished and tested some bugfixes on 'master', 
> while I still have unfinished/untested stuff on 'next'. When I 'git push' 
> from 'master', I DO NOT want 'next' to be pushed (unless I have explicitly 
> asked for it).

Then do "git push <remote> HEAD" to push current branch only in this
*special case* (I think there was proposal to have "git push HEAD" to
push to default remote, but I don't know if it was accepted; well, this
idea can be resurrected if it isn't in).

> If I'm pushing to a shared repo (a very common workplace setup), this 
> default is even more potentially damaging (especially if I don't discover 
> what's actually happening by scanning the output from 'git push').
> 
> This is one area where Git's current default behavior is less conservative 
> than I would like.

I think that it would be good idea to have "git push --ask", which when on
terminal would present you with the list of branches that would be pushed,
and ask for confirmation if you push more than one branch or something
(or perhaps even "git push --interactive").

But this requires some discipline to *not* do work in progress on 
published branches (matching).

-- 
Jakub Narebski
Poland
