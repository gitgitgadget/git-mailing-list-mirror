From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [RFD] make rebase abort to original branch, not rebased branch
Date: Sun, 13 Mar 2011 10:58:08 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1103131013370.15442@debian>
References: <alpine.DEB.2.00.1103122253560.15442@debian> <7vmxkzijpt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 13 15:58:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PymkN-0004T0-6x
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 15:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143Ab1CMO6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2011 10:58:13 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54168 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab1CMO6M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2011 10:58:12 -0400
Received: by vxi39 with SMTP id 39so3738577vxi.19
        for <git@vger.kernel.org>; Sun, 13 Mar 2011 07:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=jNVmpMqkDwvaRbMDA3isPQiQ7H3a2GsIgToiveUSOGs=;
        b=oF2CfRzmGbfbRKyrbTGjisHC9wIwiLg8iSF81PCF60XJWNpOw8sCKGp73etvR5XJDB
         qepqO3gV7OFjww9ZVIypjNnV3FtBWX6rLCMvEWQUqNiU910Fel5n+YV3vbyzyjHCEreP
         gKOuKtx2zRmLDgQrsyvuBr8RZ87lVCld2TK5U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=fLROuDHXt2+FnhBi4oQqsBDhV+gxK7Pt3xwfAMK3bukFgmt8B/FbThKYyO4IKyTFs1
         i7CF1vAR5QKadxxK/RBXAtDoOWo3lsMxJbz9lMlfVxonSdnYV9dbgeAXS8OwcS9UQNhG
         Lg+qQ1ACLAb9koR8JAFEHZq8V0caEIlamG8ME=
Received: by 10.52.0.237 with SMTP id 13mr926341vdh.281.1300028291844;
        Sun, 13 Mar 2011 07:58:11 -0700 (PDT)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id n13sm2018631vcr.17.2011.03.13.07.58.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Mar 2011 07:58:10 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <7vmxkzijpt.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168968>

On Sat, 12 Mar 2011, Junio C Hamano wrote:

> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
> 
> > In most cases, this is just a small annoyance, since it's usually
> > quick and easy to manually switch back to the original
> > branch. However, I have run into at least two cases where it has been
> > a bit more annoying:
> >
> >  1. When on a detached HEAD and running "git rebase HEAD topic", if
> >     you abort the rebase, you will have to look up the old commit in
> >     the reflog.
> 
> Doesn't this merely show a bad discipline? What were you envisioning to
> do to your detached HEAD state if the rebase were to succeed? IOW, if the
> state was so precious, why did you decide to switch to topic and rebase it
> onto that state, without marking?

This usually happens when I see something that looks a bit suspicious
in one of my own commits on my topic branch. I then check out that
commit to have a look and perhaps run some test. If I find something
broken, I would fix it and either amend the commit or create a new
commit on top. I would then run "git rebase --onto HEAD HEAD~1 topic"
or "git rebase HEAD topic", respectively. If the merge conflicts turn
out to be bigger than I expected, I may decide to abort and to instead
create a new branch for the commit(s) until I find time/energy.

> > Are there valid cases where the current behavior is bettter?
> 
> I don't particularly like the "when aborted it returns to the original
> location" behaviour even for a single argument "git rebase A" case

This has sometimes annoyed me as well. Maybe a --stop/discard would be
a nice alternative to "rf -r .git/(rebase-apply|rebase-merge)"?

> At least going back to B conceptually makes more sense in one use case I
> have, which was the original reason I invented rebase with the "checkout B
> and rebase it ono A" shorthand in the first place (see 59e6b23), back when
> I was an active contributor throwing patches at Linus (note that back then
> I didn't have "abort then go back" in the code--and that is why I don't
> care too deeply about this "which branch should I be after aborting?"
> myself).
> 
> The reason I tried to rebase B on A with the short-hand form was because I
> wanted to clean up what is on B; I may say "abort" when my first attempt
> to rebase failed because it was a bit too much to bite at once (e.g. the
> history diverged a bit too much since B forked from A's ancestor).
> 
> But then, the next thing I would want to do in such a case after aborting
> is not to give up and forget about what I needed to do, which is to clean
> up B into a shape easier to merge with the updated codebase that leads to
> A.  I would want to stay on B and examine the situation a bit deeper, and
> try to figuire out a different base (e.g. a bit older commit in the
> history leading to A) to rebase to, so that I can keep up with the other
> branch incrementally without lagging too far behind.  Switching away from
> the original B would be majorly annoying in such a case.

Certainly a valid use case. Maybe the best solution would be to
introduce a new kind of --abort (say --abort-to-branch-before-rebase,
but with a better name)?


/Martin
