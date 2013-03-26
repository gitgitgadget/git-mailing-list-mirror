From: Jeff King <peff@peff.net>
Subject: Re: [DONOTAPPLY PATCH 2/3] setup: warn about implicit worktree with
 $GIT_DIR
Date: Tue, 26 Mar 2013 16:27:22 -0400
Message-ID: <20130326202722.GA22769@sigill.intra.peff.net>
References: <20130326200851.GA22080@sigill.intra.peff.net>
 <20130326201208.GB22522@sigill.intra.peff.net>
 <20130326202142.GL1414@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Richard Weinberger <richard@nod.at>,
	Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 21:27:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKaTL-0001Nz-O0
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 21:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab3CZU11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 16:27:27 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40658 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155Ab3CZU10 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 16:27:26 -0400
Received: (qmail 7428 invoked by uid 107); 26 Mar 2013 20:29:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 16:29:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 16:27:22 -0400
Content-Disposition: inline
In-Reply-To: <20130326202142.GL1414@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219201>

On Tue, Mar 26, 2013 at 01:21:42PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -437,6 +437,23 @@ const char *read_gitfile(const char *path)
> >  	return path;
> >  }
> >  
> > +static const char warn_implicit_work_tree_msg[] =
> > +N_("You have set GIT_DIR (or used --git-dir) without specifying\n"
> > +   "a working tree. In Git 2.0, the behavior will change
> 
> Please no.  I don't want git 2.0 to be delayed forever.

Please replace "2.0" with some future version, then. I just made up the
number. But...

> If we want this warning, would something like the following do?
> 
> 	warning: You have set GIT_DIR without setting GIT_WORK_TREE
> 	hint: In this case, GIT_WORK_TREE defaults to '.'
> 	hint: To suppress this message, set GIT_WORK_TREE='.'

That can help by teaching people how GIT_DIR behaves in general. But the
warning and hint will be small consolation to somebody who runs
"GIT_DIR=foo.git git clean -f" and sees it for the first time.

If you want to argue that people would see the warning in earlier runs
of git, I can kind of buy that. Although the incident that triggered
this discussion probably wouldn't have (I would usually start a
git-clean session with "git clean" without "-f" or "git status", either
of which would have done equally well as this warning to notify the user
what was going on).

Like I said earlier, though, I'm not really sure this is the direction
we want to go. This series is more about seeing what the fallouts are. I
probably shouldn't have included this middle patch at all, because the
interesting thing is what happens when we do turn it off.

-Peff
