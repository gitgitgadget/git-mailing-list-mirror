From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Relative submodule URLs
Date: Thu, 28 Aug 2014 21:35:33 +0200
Message-ID: <20140828193533.GA20040@book.hvoigt.net>
References: <CAHd499CRNjp-UzXiTt=xgDJWGOEqew+AuPFmrF3-VsEGefXiuA@mail.gmail.com>
 <20140818205505.GA20185@google.com>
 <CAHd499DVf4N3Y6m5qoiy-WQGX4K54umefRzehZMsrxiWbaiZ=g@mail.gmail.com>
 <53F76907.1090904@xiplink.com>
 <53FF6A72.50605@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Dailey <rcdailey.lists@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 21:35:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN5U4-00041n-V5
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 21:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbaH1Tfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 15:35:43 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.40]:33535 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbaH1Tfm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 15:35:42 -0400
Received: from [77.21.76.69] (helo=book.hvoigt.net)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1XN5Tu-0005pe-O1; Thu, 28 Aug 2014 21:35:38 +0200
Content-Disposition: inline
In-Reply-To: <53FF6A72.50605@xiplink.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256117>

On Thu, Aug 28, 2014 at 01:44:18PM -0400, Marc Branchaud wrote:
> Heiko also said this:
> > On Fri, Aug 22, 2014 at 12:00:07PM -0400, Marc Branchaud wrote:
> >> With relative-path submodules, the push's target repo *must* also have the
> >> submodules in their proper places, so that they can get updated.
> >> Furthermore, if you clone a repo that has relative-path submodules you
> >> *must* also clone the submodules.
> >
> > That is not true. You can have relative submodules and just clone/fetch
> > some from a different remote. Its just a question of how to
> > specifiy/transport this information.
> 
> I meant that more as a general guideline than some kind of physical law.
> Sure, it's possible to scatter the submodules across all sorts of hosts, but
> it's not a good idea.  When it comes to relative-path submodules, pushing and
> fetching submodule changes in the super-repo should just involve the one
> remote host (whatever way that's determined).  This keeps things tractable,
> because otherwise your branch's changes are scattered among many different
> hosts and you end up considering weird things like "this part of the branch's
> changes are on host A but this other part are on host B, so let's record that
> somewhere, oh but what if host B is down when I'm trying to fetch, but I know
> that host C has the changes too so why don't I just fetch what I want from
> there".
> 
> It's a nightmare.  It's infinitely better to treat a repository and its
> relative-path submodules as an atomic unit, so that any remote that hosts the
> repository also hosts the submodules.  When pushing a branch with submodule
> changes, expect to find those submodules on the target remote and update
> them.  Regardless of how the target remote is determined.  Same thing for
> fetching.  It's just so much simpler to work this way.

You are right, its simpler. But I would not say "better". Depending on
your project it might be "better" to just fork some submodules.

> So please, let's not try to specify submodule remotes per-branch or make that
> info pushable.  It's enough for a branch's local configuration to say that it
> tracks fetch/pull refs on different remotes.  The rest should flow from that.

Why not? Git is all about flexibility. Of course if you organise your
submodules in chaos you will get chaos. But consider this:

You have this big project which consists of submodule (e.g. like Android
with hundreds of submodules). Now you want to develop on something that
involves just a subset of submodules, lets say two submodules.

Now if someone just wants to publish a small change to some submodules
you are demanding to setup a mirror of *all* submodules that are in this
big project. That might not even be feasible depending on the projects
size and the remote quota. Not to speak about having to first create a
fork of hundreds of repositories. So in this situation we should support
just referring some submodules to other places.

Regarding transporting this information. If you ask someone to try out
your change it should be as simple as possible. It should be enough to
say. clone from there and checkout that branch (once recursive checkout
and fetch for submodules is in place). So here we need a way to
transport this configuration for a fork.

Yes for a small project where its feasible to simply clone all
submodules you can just say: please fork everything. But for bigger
projects thats not necessarily an option. So we should at least give the
users that option. Then its a matter of policy how you work with a
project.

I am not saying that everything for this should be implemented in the
first steps but we should keep it in mind and design everything in such
a way that it is still possible to implement such a kind of workflow
later.

Cheers Heiko
