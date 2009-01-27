From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Tue, 27 Jan 2009 19:08:04 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901271903210.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901242056070.14855@racer> <20090127092117.d13f24e7.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, spearce@spearce.org,
	Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 19:11:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRsNQ-0000IN-AT
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 19:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755785AbZA0SH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 13:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755353AbZA0SH7
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 13:07:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:60826 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755171AbZA0SH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 13:07:58 -0500
Received: (qmail invoked by alias); 27 Jan 2009 18:07:52 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp025) with SMTP; 27 Jan 2009 19:07:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Cdu55tw2C7pPZ0iqRc7w0Gl5D9CbHzZPnqxvp/X
	5RzWXyMwHDBLG0
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090127092117.d13f24e7.stephen@exigencecorp.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107375>

Hi,

On Tue, 27 Jan 2009, Stephen Haberman wrote:

> > I am very sorry if somebody actually scripted rebase -i -p (by setting 
> > GIT_EDITOR with a script), but I am very certain that this cleanup is 
> > absolutely necessary to make rebase -i -p useful.
> 
> I have scripted rebase-i-p, but with GIT_EDITOR=: [1]. I assume this
> will still work and just accept the default script?

Yes, this will still work.  AFAICT this is actually how git 
--no-interactive -p is implemented...

> (Er, maybe I can just use rebase-p...I forget why [1] is using the
> GIT_EDITOR=: with -i.)

See above... :-)

> My primary pain point with rebase-i-p has been rebasing a branch that
> has merged in another branch that has a lot of commits on it. E.g.:
> 
>     a -- b -- c  origin/feature
>       \
>        d -- e    feature
>            /
>       ... g      origin/master
> 
> Where e is merging in, say, a latest release that had a few hundred
> commits in the master branch. After resolving conflicts/etc. in e, I
> want to rebase d..e from a to be on c.
> 
> The two problems have been:
> 
> 1) `git pull` with rebase set uses rebase-i, with no -p, so all of the
>    commits from the latest release branch that got merged in with e are
>    flattened/duplicated.

Maybe teach git pull about --rebase=preserve[-merges] and 
branch.<name>.rebase=preserve[-merges]?

> 2) With manual invocation of `rebase-i-p`, previously you'd get a
>    laundry list of commits from the e merge that are new to the feature
>    branch, but since g and its ancestors aren't changing, you don't need
>    to consider them in the script and so its (potentially a lot of)
>    noise. This is what the parent probing back port from git sequencer
>    addressed.

I always meant to handle that in the fast-forward handling of pick_one().

> So, I don't mean to rehash old complaints, as I'd love to see the 
> rebase-i-p code cleaned up by someone who can really refactor it vs. my 
> hack patches. But I wanted to emphasize the motivation for my hacks over 
> their implementation so that hopefully you can still address these use 
> cases in the new version.

Well, let's see how things turn out once I use the patches for my own 
work...

Thanks,
Dscho
