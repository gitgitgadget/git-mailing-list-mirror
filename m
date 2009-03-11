From: Jeff King <peff@peff.net>
Subject: Re: setting up tracking on push
Date: Tue, 10 Mar 2009 22:04:09 -0400
Message-ID: <20090311020409.GA31365@coredump.intra.peff.net>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com> <76718490903052049k217e9c12gb7881f8904fdd9d@mail.gmail.com> <alpine.DEB.1.00.0903061144480.10279@pacific.mpi-cbg.de> <buoy6vi297q.fsf@dhlpc061.dev.necel.com> <49b12ff7.nCWIz4ABJcgwW3BZ%obrien654j@gmail.com> <76718490903060743m425c2d55n6e8737c893c936e8@mail.gmail.com> <87d4cuobrc.fsf@catnip.gol.com> <49B6CCDB.8010305@xiplink.com> <20090310230939.GB14083@sigio.peff.net> <76718490903101852y2c90e0abi8e0e4f71e6f0bc52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marc Branchaud <marcnarc@xiplink.com>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 03:06:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhDpH-0001SI-Po
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 03:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843AbZCKCEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 22:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752627AbZCKCEP
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 22:04:15 -0400
Received: from peff.net ([208.65.91.99]:53018 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbZCKCEO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 22:04:14 -0400
Received: (qmail 15604 invoked by uid 107); 11 Mar 2009 02:04:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Mar 2009 22:04:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Mar 2009 22:04:09 -0400
Content-Disposition: inline
In-Reply-To: <76718490903101852y2c90e0abi8e0e4f71e6f0bc52@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112869>

On Tue, Mar 10, 2009 at 09:52:44PM -0400, Jay Soffian wrote:

> Maybe a new switch, say -u for update:
> 
> -u --track [<branch>] <upstream>
> 
> Update tracking information for an existing branch. <branch> is
> optional and defaults to the current branch. <upstream> is the branch
> you wish to track, e.g. origin/master; normally <upstream> is a remote
> tracking branch, but specifying a local branch is valid as well.
> 
> -u --no-track [<branch>]
> 
> Remove tracking information for an existing branch. <branch> is
> optional and defaults to the current branch.

Hmm. This seems not quite right to me. Specifically:

  1. Would you ever want to use "-u" without "--track"? If so, then why
     are they two separate options?

  2. In your example, if I give only a single non-option argument, it is
     interpreted as the upstream (and presumably the branch defaults to
     HEAD).  But in other branch commands, it is interpreted as the
     branch, and the upstream defaults to HEAD.

For (1), you could just have a single option. Unfortunately --track is
taken. But maybe you could do --track=. And that helps with (2), as
well, since this syntax would only ever have one or zero arguments. And
then you can default zero to HEAD.

IOW:

  # track origin/master with the current branch
  git branch --track=origin/master

  # track origin/master with a different branch
  git branch --track=origin/master other_branch

  # stop tracking
  git branch --track=

The only two problems I can think of are:

  1. It is perhaps a little confusing that --track= means "don't do the
     normal branch operation, but instead do this totally different
     thing. Of course we already have a similar situation with "-m", but
     it is perhaps more confusing since "--track" and "--track=" have
     totally different semantics.

  2. This would be the only branch command to operate on HEAD if given
     no argument. That isn't necessary for this proposal, but I think it
     makes it nicer to use. An alternative would be for git-branch to
     resolve symrefs (which would also be nice for "git branch -m HEAD
     foo").

-Peff
