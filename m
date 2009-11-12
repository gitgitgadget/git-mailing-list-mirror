From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Re: Clarify documentation on the "ours" merge strategy.
Date: Thu, 12 Nov 2009 10:55:21 +0100
Message-ID: <20091112095521.GA3666@atjola.homenet>
References: <alpine.DEB.1.00.0911031047510.4985@pacific.mpi-cbg.de>
 <7vskckn5b4.fsf@alter.siamese.dyndns.org>
 <20091111213049.GJ27518@vidovic>
 <200911120037.11901.trast@student.ethz.ch>
 <7vvdhggote.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Baz <brian.ewins@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 10:56:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8WOs-0001sb-4F
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 10:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbZKLJzW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2009 04:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbZKLJzW
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 04:55:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:58936 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752599AbZKLJzV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 04:55:21 -0500
Received: (qmail invoked by alias); 12 Nov 2009 09:55:26 -0000
Received: from i59F56EDB.versanet.de (EHLO atjola.homenet) [89.245.110.219]
  by mail.gmx.net (mp018) with SMTP; 12 Nov 2009 10:55:26 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+oYFx/Rauo1HFxBjSF0B1rhSnGJuM0quNBgnISYg
	GyR73Juy2WIasa
Content-Disposition: inline
In-Reply-To: <7vvdhggote.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132757>

On 2009.11.11 23:55:09 -0800, Junio C Hamano wrote:
> 58634db (rebase: Allow merge strategies to be used when rebasing,
> 2006-06-21) added "-m" and "-s" to rebase to solve the problem of reb=
asing
> against an upstream that has moved files.  What the commit actually d=
id
> was to use recursive (by default) while giving longer rope to the use=
rs by
> choosing other strategies with "-s", without making any judgement as =
to
> why other strategies may possibly be useful.

At least the original reason for 58634db became (partially?) moot half =
a
year later, thanks to 579c9bb19 "Use merge-recursive in git-am -3".
Rebase already falls back to recursive merging in am, so using rebase -=
m
with the recursive strategy just stops it from trying the fast path,
right?

That should probably be reflected in the man page, but honestly I have
no idea what to write there now. The note about recursive should go, bu=
t
keeping only "Use merging strategies to rebase" doesn't actually look
like it's going to be helpful in any way.

> Perhaps there is some different issue at the root of this one.  Why w=
ould
> anybody be tempted to say "-s ours" while running a rebase?  What did=
 the
> user want to see it do (instead of being a no-op because "ours" by
> definition ignores the tree the change is replayed from)?

Given the few requests I've seen of it (here + #git), I'd guess that
the user wants "git rebase -s ours $up" to do either:

MB=3D$(git merge-base $up HEAD)
git filter-branch --parent-filter "sed -e s/$MB/$up/" -- HEAD --not $up

i.e. just re-attach things to upstream, ignoring whatever upstream did
(git-svn users seem to want something like that sometimes to be able to
dcommit. Dunno if they have some hatred against the other users of thei=
r
svn repo ;-))

Or the user wants the infamous "resolve conflicts to want I did", often
enough without thinking about what that actually means and how it can
easily lead to total crap. (Yes, I'm biased...)

Bj=F6rn
