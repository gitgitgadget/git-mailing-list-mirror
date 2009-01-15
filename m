From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] checkout: implement "-" shortcut name for last branch
Date: Thu, 15 Jan 2009 19:34:02 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901151922360.3586@pacific.mpi-cbg.de>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch> <200901151501.26394.trast@student.ethz.ch> <alpine.DEB.1.00.0901151510340.3586@pacific.mpi-cbg.de> <200901151805.44747.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 15 19:34:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNX3A-0007bt-Ow
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 19:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757441AbZAOSdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 13:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757062AbZAOSdP
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 13:33:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:34211 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756714AbZAOSdO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 13:33:14 -0500
Received: (qmail invoked by alias); 15 Jan 2009 18:33:10 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp016) with SMTP; 15 Jan 2009 19:33:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+v7LMM/YyvpInkoyT3SEXzGulAvSpDBP96knnGd1
	qzMZXjqD3oKubg
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200901151805.44747.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105865>

Hi,

On Thu, 15 Jan 2009, Thomas Rast wrote:

> Johannes Schindelin wrote:
> > There are a number of issues why I would like to avoid introducing 
> > LAST_HEAD:
> > 
> > - it does not work when you are using different Git versions on the same 
> >   repository,
> > 
> > - it does not work when you switched recently,
> 
> If you switch once, you'll be able to use the feature one checkout
> later than if it was reflog-based.
> 
> If you switch a lot, the feature won't be in your git half the time
> anyway.

But once it is, you could also have something like "git checkout -{5}" 
meaning the 5th last branch you were on.

No, I am not married to that syntax

> > - you are storing redundant information,
> 
> AFAIK it's the first instance of this data in a non-free-form field.
> There's also the precedent of ORIG_HEAD.

See below.

> > - yes, the field is meant for user consumption, but no, it is not 
> >   free-form,
> 
> It's a field of almost arbitrary character data, filled by 70% of the
> update-ref calls I can find in git.git in a "<tool>: <comment>" format
> and by the rest with things such as "initial pull" or
> "refs/remotes/git-svn: updating HEAD".  (The latter is so informative
> that it probably deserves a fix.)  How is that not free-form?

That is not free-form, as the "<tool>:" is a hard convention all obey 
(and therefore, git checkout - only relies on _checkout_ not changing the 
format), and checkout is sufficiently plumbing that we will not change it 
all that lightly, certainly not when "git checkout -" depends on it.

So I think that those free-form concerns are totally unfounded.

Oh, and before you say that people could mess with GIT_REFLOG_ACTION, git 
checkout is no longer a script, and creates the message itself.  So we 
have full control over it.

They could edit the logs directly, but that applies to virtually the whole 
repository, and can safely be ignored as a lemming behavior.

> > - AFAICT your version could never be convinced to resurrect deleted 
> >   branches, without resorting to reflogs anyway.
> 
> Neither can any other use of git-checkout without the user manually
> recovering some valid revspec referring to the old branch tip from the
> reflog.

To the contrary.  The reflog has this information together with the 
message "moved from ...".

> > - the reflog method reflects pretty much exactly how people work around 
> >   the lack of "checkout -" currently, so why not just use the same proven 
> >   approach?
> 
> So you can make me fight an uphill battle against your idea how it
> should be done.

If you can convince me that there are benefits from introducing yet 
another file in $GIT_DIR and duplicating information that is in the 
reflogs already, then no, it's not an uphill battle.

I mean, I _like_ the feature.  Otherwise I would not spend so much time 
suggesting what I think would be a method more in line with what we have 
already.

Ciao,
Dscho
