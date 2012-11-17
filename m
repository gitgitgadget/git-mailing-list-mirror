From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record
	option
Date: Sat, 17 Nov 2012 22:31:30 +0100
Message-ID: <20121117213130.GC7695@book.hvoigt.net>
References: <20121117153007.GB7695@book.hvoigt.net> <20121117150441.GA7695@book.hvoigt.net> <20121117192026.GI22234@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sat Nov 17 22:31:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZpzV-0000ZP-M9
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 22:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355Ab2KQVbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2012 16:31:38 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:42109 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137Ab2KQVbh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 16:31:37 -0500
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1TZpz9-0006KM-3F; Sat, 17 Nov 2012 22:31:31 +0100
Content-Disposition: inline
In-Reply-To: <20121117192026.GI22234@odin.tremily.us>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209980>

On Sat, Nov 17, 2012 at 02:20:27PM -0500, W. Trevor King wrote:
> On Sat, Nov 17, 2012 at 04:30:07PM +0100, Heiko Voigt wrote:
> > > >  (2) "git diff [$path]" and friends in the superproject compares the
> > > >      HEAD of thecheckout of the submodule at $path with the tip of
> > > >      the branch named by submodule.$name.branch in .gitmodules of
> > > >      the superproject, instead of the commit that is recorded in the
> > > >      index of the superproject.
> > > > 
> > > 
> > > Hmm.  ???git diff??? compares the working tree with the local HEAD (just a
> > > SHA for submodules), so I don't think it should care about the status
> > > of a remote branch.  This sounds like you want something like:
> > > 
> > >   $ git submodule foreach 'git diff origin/$submodule_branch'
> > > 
> > > Perhaps this is enough motivation for keeping $submodule_* exports?
> > > 
> > > > and the option were called something like "--follow-branch=$branch",
> > > > ???
> > 
> > I am not sure if hiding changes to the recorded SHA1 from the user is
> > such a useful thing. In the first step I would like it if it was kept
> > simple and only the submodule update machinery learned to follow a
> > branch. If that results in local changes that should be shown. The user
> > is still in charge of recording the updated SHA1 in his commit.
> 
> I understand what you're warning against here, or what it has to do
> with "git diff".

Is there a not missing here? Reads somehow like that. What I am talking
about is the suggestion of Junio.  Instead of showing a diff if the
SHA1 is different we show a diff if the checkout in the worktree is
different from the tip of the configured branch. That would hide the
fact that a submodule has changed during a submodule update operation.

> > From what I have heard of projects using this: They usually still have
> > something that records the SHA1s on a regular basis. Thinking further,
> > why not record them in git? We could add an option to update which
> > creates such a commit.
> 
> I think it's best to have users craft their own commit messages
> explaining why the branch was updated.  That said, an auto-generated
> hint (a la "git merge") would probably be a useful extra feature.

I have the same opinion. Commits should always be created by humans so
you have someone to blame/ask why. But I guess there are people that
expect this to be automatic.

One argument somehow goes along the lines:
"I already created a commit in the submodule why do I need to create
another one in the superproject? Just follow the HEAD revision!" They
think in subversions "submodules" which are merely pointers to other svn
repositories without any revision information. I am unsure if its good
to support this the same way.

Another use case is big projects that have so many submodules that
creating superproject commits would create to much maintenance work.
They want to have their integration server make those commits. That
would already be supported with update checking out the branch tips and
the commit is just one extra thing to do by the integration server.

So I think it should be fine just to teach update to checkout the
configured branch tips (or forward them to their tracking branch tips)
and leave the rest to the user.

Cheers Heiko
