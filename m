From: Jeff King <peff@peff.net>
Subject: Re: Auto detaching head options (Re: Working copy revision and
	push pain)
Date: Tue, 25 Mar 2008 19:24:24 -0400
Message-ID: <20080325232424.GB5273@coredump.intra.peff.net>
References: <47E658D3.1060104@jwatt.org> <51419b2c0803230645l5b07bbf5h9cbf9b6f47373efa@mail.gmail.com> <47E6612A.5020408@jwatt.org> <51419b2c0803230706w5ff88fc7oc7e8e34ab8afa1fd@mail.gmail.com> <alpine.LSU.1.00.0803231519380.4353@racer.site> <47E66DAA.4080807@jwatt.org> <alpine.LSU.1.00.0803231555380.4353@racer.site> <47E6765D.2020103@jwatt.org> <alpine.LSU.1.00.0803231658460.4353@racer.site> <20080325192552.GC4857@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Watt <jwatt@jwatt.org>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Mar 26 00:25:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeIVx-0007uG-Ih
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 00:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756165AbYCYXY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 19:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755197AbYCYXY2
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 19:24:28 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1602 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754603AbYCYXY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 19:24:27 -0400
Received: (qmail 8028 invoked by uid 111); 25 Mar 2008 23:24:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 25 Mar 2008 19:24:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Mar 2008 19:24:24 -0400
Content-Disposition: inline
In-Reply-To: <20080325192552.GC4857@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78229>

On Tue, Mar 25, 2008 at 08:25:52PM +0100, Jan Hudec wrote:

> The proponents of this (and I also) think, that meaning of HEAD is, or rather
> should be, "the revision your work tree is derived from". If you think it
> should be defined otherwise, can you please say how, so the merits of the
> definitions can be discussed?

I agree with Johannes. It has traditionally been considered "the ref
that will be advanced by new commits". And that is why I think detaching
the HEAD is just trading one problem for another: your push invisibly
mucks with state that the non-bare repository user relies on. When they
commit on a detached HEAD, their commits suddenly start going "nowhere"
instead of to the branch they thought.

FWIW, I also initially thought this was only a "HEAD" problem, but I
think Junio's recent argument makes a lot of sense: the problem is not
one of working tree and HEAD sync, nor even of detached versus ref HEAD.
The problem is that somebody is using the non-bare repository to do
stuff (why else would it be non-bare), and you are changing the state
behind their back.

> Note, that that definition implies that HEAD makes no sense for bare
> repository. I think HEAD indeed does not make sense there, but you may of
> course provide different definition where it does.

I think HEAD can be more generally considered the context of the
"current" branch. It is the default branch for cloning from bare
repositories, and it is the default branch for most operations (logging,
starting new branches, etc). So it really is a bit overloaded in that
sense.

> Also I believe that it would be very useful to have a ref defined "the
> revision your work tree is derived from", be it HEAD or not. It would:

Isn't this essentially the 'base' index extension that Junio did a
while back? It was eventually reverted (or perhaps never merged, I don't
recall). You should be able to find discussion in the list archives.

But maybe you are referencing it here:

>    It would really be similar to the revision number in index proposal,
>    except less invasive and I actually believe there is a case (some form of
>    checkout or reset), where we want to read-tree, but not change this ref.

I don't recall the reasons the base extension was not accepted, but I
think it would make sense to frame your argument as "this is like X;
people didn't like X for reason Y, but my proposal fixes this by..."

-Peff
