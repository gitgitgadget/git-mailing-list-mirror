From: Charles Bailey <charles@hashpling.org>
Subject: Re: How to find where a branch was taken from.
Date: Fri, 21 Mar 2008 18:32:25 +0000
Message-ID: <20080321183225.GA13583@hashpling.org>
References: <47E37A63.9070209@glidos.net> <7v4pb0qw28.fsf@gitster.siamese.dyndns.org> <32541b130803211039h1f5b8da5k8fb353d46e57b05e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Gardiner <osronline@glidos.net>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 19:33:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jcm3V-0005ik-1R
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 19:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031AbYCUScn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 14:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755846AbYCUScn
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 14:32:43 -0400
Received: from ptb-relay03.plus.net ([212.159.14.214]:59357 "EHLO
	ptb-relay03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbYCUScm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 14:32:42 -0400
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay03.plus.net with esmtp (Exim) id 1Jcm2W-0004Ue-Ch; Fri, 21 Mar 2008 18:32:28 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id m2LIWPtQ014024;
	Fri, 21 Mar 2008 18:32:25 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id m2LIWPlO014023;
	Fri, 21 Mar 2008 18:32:25 GMT
Content-Disposition: inline
In-Reply-To: <32541b130803211039h1f5b8da5k8fb353d46e57b05e@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Plusnet-Relay: fc47712e3e33c323c261b00843463655
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77754>

On Fri, Mar 21, 2008 at 01:39:11PM -0400, Avery Pennarun wrote:
> On Fri, Mar 21, 2008 at 5:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Paul Gardiner <osronline@glidos.net> writes:
> >  > I need a command that will find the remote branch from which
> >  > the currently checked out branch was started. I don't know
> >  > git very well, and the only way I can think to do it so far
> >  > is to iterate over the remote branches and find the one
> >  > for which git-rev-list <branch>..HEAD gives the smallest
> >  > number of objects. I'm guessing there must be a better
> >  > way. Any ideas?
> >
> >  There will be _no_ way.  It is simply impossible.
> >
> >     $ git checkout -b my-new-branch origin/somerandombranch~27^2^2~23
> >
> >  is a perfectly valid way to create a new branch.
> >
> >  You would probably want to re-think in a bigger picture, _why_
> >  you would want to find such information, [...]
> 
> I frequently want to do this.  Basically, I start from "some version"
> of the upstream program, and I put together some patches, then I want
> to use rebase to reorder and recombine them before I send them in.

So you're looking to do a git rebase -i?

> In order to do this, however, I'm forced to remember where I got my
> "original" version from, which isn't even that important.  As the
> developer of a particular patch, all I *really* should have to know
> is: a) here are the things I added since I made my topic branch, and
> b) here is the branch I want to rebase them onto so I can submit my
> cleaned patches upstream.

Why are you forced to remember?

If you don't want to transplant the patches onto where the remote
branch is now, then you just need to pick a commit on your current
branch that is before any commit that you want to reorder/recombine
and do a git rebase -i <sha1>. (It should be easy to pick a commit
from git log. Perhaps it's the first one with and author that isn't
you.  Alternatively, if you don't want to look at the log and you know
you haven't made more than N commits you could just git rebase -i
HEAD~N.)

If you want to rebase them on to the latest version of the remote
branch then it's even simpler. You just do:

git rebase -i remote/branch

I'm not sure I understand why you need to know where your original
branch was made from?

Charles.
