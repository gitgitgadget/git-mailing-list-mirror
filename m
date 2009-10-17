From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Sat, 17 Oct 2009 10:19:01 +0200
Message-ID: <20091017081901.GB5474@atjola.homenet>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <m49nq6-uk5.ln1@burns.bruehl.pontohonk.de>
 <7vr5t2h3do.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christoph Bartoschek <bartoschek@gmx.de>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 10:19:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mz4VQ-0000DV-J2
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 10:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbZJQITD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Oct 2009 04:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbZJQITC
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 04:19:02 -0400
Received: from mail.gmx.net ([213.165.64.20]:49766 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752109AbZJQITA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 04:19:00 -0400
Received: (qmail invoked by alias); 17 Oct 2009 08:19:04 -0000
Received: from i59F5487B.versanet.de (EHLO atjola.homenet) [89.245.72.123]
  by mail.gmx.net (mp054) with SMTP; 17 Oct 2009 10:19:04 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19kHc8MN1hkzcc2BndOXR87jtvDQ/PxaFbIiH95pg
	KuMHEM9uSwvmmY
Content-Disposition: inline
In-Reply-To: <7vr5t2h3do.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130551>

On 2009.10.17 00:43:31 -0700, Junio C Hamano wrote:
> Christoph Bartoschek <bartoschek@gmx.de> writes:
> > Daniel Barkalow wrote:
> >
> >> The upshot of the messages should be:
> >>=20
> >>  $ git checkout origin/master
> >>  Since you can't actually change "origin/master" yourself, you'll =
just
> >>  be sightseeing unless you create a local branch to hold new local=
 work.
> >>=20
> >>  $ git branch
> >>  * (not a local branch, but "origin/master")
> >>=20
> >>  $ git commit
> >>  You've been sightseeing "origin/master". The commit can't change =
that
> >>  value, so your commit isn't held in any branch. If you want to cr=
eate
> >>  a branch to hold it, here's how.

[...]

> The second item in the Daniel's transcript above may be an improvemen=
t but
> I think it is a wrong economy to record and show 'but "origin/master"=
'
> (which cannot be correct forever and has to be invalidated once the u=
ser
> starts committing or resetting) in the message.

I don't think it's entirely wrong to record that information, git just
has to know when to invalidate it, possibly requiring the user to reall=
y
detach HEAD.

git checkout origin/master
git checkout origin/master~3
git checkout HEAD^2~5
git reset --hard HEAD~2

Those commands are all about walking the ancestry of origin/master in
some way. So it seems reasonable to assume that HEAD is still weakly
bound to origin/master. And based upon that, there could be something
like "git update", and things like "git status" could show that you're
browsing through the ancestry of origin/master, and that "git commit"
message could maybe say "You've been sightseeing 'origin/master'
[currently at 'origin/master~3^2~7'] ...".

> I am wondering if a similar effect to help new users can be had by
> rewording the message to:
>=20
>     $ git branch
>     * (not a local branch; see "git reflog" to learn how you got here=
)
>=20
> The user can see how he got there even after doing something else aft=
er
> the checkout (see Nico's write-up in $gmane/130527).  The difference =
is
> between giving fish and teaching how to catch one himself.

That could be used when the user actively detached HEAD, invalidating
the "weak binding". Maybe implicitly by "git commit" or=20
"git reset <something_we_can't_keep_track_of>", or maybe explicitly,
if committing on a "semi-detached HEAD" becomes forbidden.

Or maybe it could always be shown, in addition to "You are here", you
also get told "Do this to find out how you got there". Does seem like a
good idea.

Bj=F6rn
