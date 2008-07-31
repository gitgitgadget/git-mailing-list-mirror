From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: linking libgit.a in C++ projects
Date: Thu, 31 Jul 2008 14:58:18 -0700
Message-ID: <20080731215818.GD24631@spearce.org>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com> <20080731105727.GF7008@dpotapov.dyndns.org> <ac9f0f090807310410u461f5584ved74769d8452c539@mail.gmail.com> <bd6139dc0807311127j57d9ab5ckd6acf16d17621614@mail.gmail.com> <ac9f0f090807311444lb2f02e6ud76463b359184fbd@mail.gmail.com> <bd6139dc0807311451t763aa07bsf9474fce4073babd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: cte <cestreich@gmail.com>, Dmitry Potapov <dpotapov@gmail.com>,
	git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Thu Jul 31 23:59:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOgBA-00061W-BJ
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 23:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758930AbYGaV6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 17:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758902AbYGaV6U
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 17:58:20 -0400
Received: from george.spearce.org ([209.20.77.23]:58849 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758836AbYGaV6T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 17:58:19 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id BBDD4383A4; Thu, 31 Jul 2008 21:58:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <bd6139dc0807311451t763aa07bsf9474fce4073babd@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91003>

Sverre Rabbelier <alturin@gmail.com> wrote:
> On Thu, Jul 31, 2008 at 23:44, cte <cestreich@gmail.com> wrote:
> > Using output from the command line utilities as an API has its own set
> > of problems. For instance, check out some of the difficulties that
> > gitk and qgit have had to deal with:
> > http://kerneltrap.org/mailarchive/git/2007/11/2/379067.
> 
> I beg to differ. If I skimmed the topic correctly, the problems there
> were not related to having to parse git's output, but due to the fact
> that '--topo-order' is a post-processing operation, which takes long.
> Do read the recent discussion between Linus and Roman about that.

And actually if you try to use topo-order internally in C you still
have to wait for the post-processing.  Which is going to cause your
UI to lock up because it is single-threaded as both Git and your UI
toolkit are probably single threaded.  At least by forking out to
git-rev-list your UI can respond while the computation is happening
in a background process.
 
> Especially since that'd mean that integrating it into other languages
> (by means of wrappers), such as Python or Ruby, becomes a lot easier.

I'm going to be shot for saying this, but both Python and Ruby
have implementations that run on the JVM.  So does Git.  Want
to use Git and Python?  Use JGit and Jython.  :)
 
> >> There is, use the plumbing, forward compatibility is 95% assured. With
> >> the exception of major releases, for which any plumbing
> >> output/behavior changes will be announced in the changelog, usually
> >> including an explanation on how to change your code to match.
> >
> > 95% assured != correct, IMO :)
> 
> Why not? Junio has a very good reputation of keeping git backwards
> compatible. The 95% is of course not an actual figure but an
> expression meant to indicate "statement is true, minus a few rare case
> exceptions".

Too many people have scripts based upon plumbing to make incompatible
changes.  We'd have all of our users screaming.  Remember many Git
users are programmers themselves, they will make small home-grown
scripts based upon Git plumbing to simplify their workflow and
everyday tasks.  They use plumbing precisely because they can trust
it won't change or break on them.

-- 
Shawn.
