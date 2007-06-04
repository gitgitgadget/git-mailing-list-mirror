From: "Bryan Childs" <godeater@gmail.com>
Subject: Re: Git Vs. Svn for a project which *must* distribute binaries too.
Date: Mon, 4 Jun 2007 16:38:59 +0100
Message-ID: <5971b1ba0706040838nc9ea7c7h54a57d4235d53bcf@mail.gmail.com>
References: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com>
	 <alpine.LFD.0.98.0706040755560.23741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 17:40:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvEfG-000431-Pl
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 17:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757907AbXFDPjE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 11:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757608AbXFDPjE
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 11:39:04 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:6631 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758447AbXFDPjA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 11:39:00 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1060943nzf
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 08:38:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ksIbZGNl9CQisdNwG66/vFjPSO3F3Cx7WzcaWyewptUsxSJDPchOMm0EHJaU26CbkPV2potu7nw4JNk2J1iQ85KT9lkI/4DozY6KQraaZy6BoY/vDxvVvg2ekfjRxti7XLuxczORXtdIdf/ftfVeLIzloCW4C18EltAufy4dnRk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JFeMgb9KUGtizsZUxl6YmSXaE81+RY2dLFhC5/opA1atI/Epk6crYqfBdkGhBxmBHix2n6cmvdn2feGl3/M8FtK5/IUIA04Js8SZqdIQGRB3V+WnEoBGaLvysX+WRMJqOVR0VoInrbZNVEx0eaMZltiVnKBWCTcJgiN3QrnOmNc=
Received: by 10.65.219.20 with SMTP id w20mr7126058qbq.1180971539375;
        Mon, 04 Jun 2007 08:38:59 -0700 (PDT)
Received: by 10.65.196.14 with HTTP; Mon, 4 Jun 2007 08:38:59 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0706040755560.23741@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49108>

On 6/4/07, Linus Torvalds < [send email to
torvalds@linux-foundation.org via gmail]
torvalds@linux-foundation.org> wrote:
> So I *hope* that you want to just have automated build machinery that
> builds the binaries to a *separate* location? You could use git to archive
> them, and you can obviously (and easily) name the resulting binary blobs
> by the versions in the source tree, but I'm just saying that trying to
> track the binaries from within the same git repository as the source code
> is less than optimal.

Oh lord no - I never meant to imply that we'd be checking those
binaries in, I just meant to hi-light that we need a central
repository to build those binaries from - otherwise we'd end up with a
selection of binaries for our users to download which contain a bunch
of different features if they were built from a combination of
repositories. I know you think everyone else is a moron, but we're not
quite dumb enough to think maintaining binaries in a repository is a
good idea :)


> In *practice*, I suspect that once you get used to the git model, you'd
> actually end up with a hybrid scheme, where you might have a *smaller*
> core group with commit access to the central repository (in git, it
> wouldn't be "commit access", it would really be "ability to push", but
> that's a technical difference rather than anything conceptually huge), and
> members in that core group end up pulling from others.

This sounds like what we eventually came up with. I'm not sure how
soon we'll make a switch to a git repository, but when we do, this
seems to be the best model for the conversion in the short term, and
perhaps in the long term too.


> .. and that's exactly how you'd do it with git too. You wouldn't have a
> "commit trigger", but you'd have a "receive trigger", which triggers
> whenever somebody pushes to the central repository.

Yes, after I'd sent my email this morning I found you could do pushes
as well as pulls. That'll teach me to RTFM properly next time.

>  - realize that the git model tends to encourage many small commits
>    (because you *can* make commits without impacting others), so when you
>    fix something, or add a new feature, with git, you can do it as many
>    small steps, and then only "push" when it's ready.

This is what I personally was trying to advocate in our discussion -
but I'm not sure everyone quite understood it. Hopefully your
explanation will do a better job :)

>    IOW, if you encourage people to do small step-wise changes, you
>    probably don't even *want* a build for each commit, you really want a
>    build for the case where "my feature is now ready, I'll push". So you'd
>    effectively get one build not per commit, but per "publication point".

Absolutely.

>                 Linus

Thanks for your time (and everyone else who replied) - it's very much
appreciated!

Bryan
