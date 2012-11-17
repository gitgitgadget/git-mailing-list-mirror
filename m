From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Sat, 17 Nov 2012 16:30:07 +0100
Message-ID: <20121117153007.GB7695@book.hvoigt.net>
References: <cover.1352431674.git.wking@tremily.us> <fb2d915cf60160c200b84df88c6112c1c2d4eefd.1352431674.git.wking@tremily.us> <7v390jqlep.fsf@alter.siamese.dyndns.org> <20121110184437.GC2739@mjolnir> <7vzk2oo2d2.fsf@alter.siamese.dyndns.org> <20121111150047.GA22608@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sat Nov 17 16:30:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZkLo-0002pE-Bb
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 16:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925Ab2KQPaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2012 10:30:15 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.97]:38149 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab2KQPaO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 10:30:14 -0500
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1TZkLQ-0002Cg-QA; Sat, 17 Nov 2012 16:30:08 +0100
Content-Disposition: inline
In-Reply-To: <20121111150047.GA22608@odin.tremily.us>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209963>

Hi,

On Sun, Nov 11, 2012 at 10:00:48AM -0500, W. Trevor King wrote:
> On Sun, Nov 11, 2012 at 02:33:45AM -0800, Junio C Hamano wrote:
> In order to avoid losing (or creating) local-only submodule commits,
> I'll probably bail (with an error) on non-fast-forward pulls.  Can
> anyone else think of other safety concerns?

That sounds like a good thing to do. We can allow more flexibility later
if people come up with usecases.

> This means that I'll probably drop Phil's $submodule_* export in v4,
> because the only explicit use we have for it is this branch tracking.
> I still think it is a useful idea, but it may not be useful enough to
> be worth the complexity.

Yes lets concentrate on the branch following first.

> >  (2) "git diff [$path]" and friends in the superproject compares the
> >      HEAD of the checkout of the submodule at $path with the tip of
> >      the branch named by submodule.$name.branch in .gitmodules of
> >      the superproject, instead of the commit that is recorded in the
> >      index of the superproject.
> > 
> 
> Hmm.  ???git diff??? compares the working tree with the local HEAD (just a
> SHA for submodules), so I don't think it should care about the status
> of a remote branch.  This sounds like you want something like:
> 
>   $ git submodule foreach 'git diff origin/$submodule_branch'
> 
> Perhaps this is enough motivation for keeping $submodule_* exports?
> 
> > and the option were called something like "--follow-branch=$branch",
> > ???

I am not sure if hiding changes to the recorded SHA1 from the user is
such a useful thing. In the first step I would like it if it was kept
simple and only the submodule update machinery learned to follow a
branch. If that results in local changes that should be shown. The user
is still in charge of recording the updated SHA1 in his commit.

>From what I have heard of projects using this: They usually still have
something that records the SHA1s on a regular basis. Thinking further,
why not record them in git? We could add an option to update which
creates such a commit.

Since git is all about changes I am hesitant to hide them from the user.

> I'll replace -r/--record with --follow-branch in v4.

Sounds good.

Cheers Heiko
