From: Petr Baudis <pasky@suse.cz>
Subject: Re: FFmpeg considering GIT
Date: Thu, 3 May 2007 22:00:13 +0200
Message-ID: <20070503200013.GG4489@pasky.or.cz>
References: <loom.20070502T111026-882@post.gmane.org> <20070503180016.GB21333@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Panagiotis Issaris <takis.issaris@uhasselt.be>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 22:00:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjhTf-00053y-Ht
	for gcvg-git@gmane.org; Thu, 03 May 2007 22:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbXECUAT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 3 May 2007 16:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752030AbXECUAS
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 16:00:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52949 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753876AbXECUAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 16:00:16 -0400
Received: (qmail 4662 invoked by uid 2001); 3 May 2007 22:00:13 +0200
Content-Disposition: inline
In-Reply-To: <20070503180016.GB21333@informatik.uni-freiburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46101>

  Hi,

On Thu, May 03, 2007 at 08:00:16PM CEST, Uwe Kleine-K=F6nig wrote:
> Panagiotis Issaris wrote:
> > There are some other things the FFmpeg maintainer mentions, namely:
> > * He wants to be able to revert a commit in some way without "wipin=
g" history.
> > That is without committing a patch which reverses the broken commit=
, as this
> > would pollute "git blame". The maintainer sees this as critical fea=
ture for
> > switching to git as it apparently can be doing using Subversion:
> > "in svn we can do this with svn cp from a specific
> > revission git and mercurial lack proper copy support"
> To add more context, Michael Niedermayer (=3DFFmpeg maintainer) wrote=
 (in
> [1]):
>=20
> 	let me explain a little bit why this is critically needed
> 	think of someone misstakely commiting the whole ffmpeg
> 	reindented or mistakely commiting a old ffmpeg version over the
> 	new or another total messup, these things do happen, and
> 	especially if they cannot be corrected and at the time where
> 	none of the developers is around
>=20
> For me this sounds like:  I don't want people with commit access doin=
g
> this, and if they do, I want to be able to revert it.
>=20
> If FFmpeg used a development scheme similar to the linux kernel, ther=
e
> should be no need for revert:  The upstream maintainer only needs to =
pay
> attention to the things he does directly (he probably does in any cas=
e)
> and check the patches he applies and the trees he pulls.  As git give=
s a
> diffstat on pull and he reviews patches before applying the problem i=
s
> maybe gone?
>=20
> Commit access is simply different in a distributed environment, see
> http://thread.gmane.org/gmane.comp.version-control.git/45849/focus=3D=
45956

  I believe that the development scheme is largely independent on the
version control system, except that git makes the "both ways" equally
easy. But that doesn't mean that the "multiple people with commit
access" scheme is wrong or anything. It has important upsides as well -
there's no single human point of failure (_yes_, if the maintainer gets
stuck in hospital for two months you can fork and maintain own
repository, but then it's again just you and it is complicated socially
etc.), the load of the maintainer is significantly lowered, and in many
projects there is simply no "single maintainer" but a team of people
where decisions are made by consensus.

  Still, if this kind of bogus change checkins happens at any frequent
rate in the ffmpeg project, there is a serious problem somewhere. :-)
But I think the git way of alleviating this problem would be to have a
way to hint the pickaxe and blame tools to ignore changes in given
commits. So, you don't _cover up_ the messy things that happened during
the history, but avoid in getting in the way in your view. You can stil=
l
look it up (with git log or something) in case you'd need to (perhaps
the revert patch was a bit complicated because of conflicting with some
other changes, and a subtle bug was introduced; this would be thousand
times harder to track down if you would've rewritten the history).

  Would crafting up a patch to implement something like this help ffmpe=
g
people in their decision?

  Let's say you have .git/info/reverts with one "revert pair" (two
commit ids, one for the bogus change and one for reverting it) per line=
,
and the blame/pickaxe tools take it into account. The downside is that
this isn't preserved over clones and fetches. That's a pretty big one.

  Another way might be to have say a magic "Reverts: commitid" line at
the last paragraph of a commit message recognized by git. The downside
is that the body of commit message might have magic meaning for some
non-core plumbing; I'm not sure how big a downside that is. For adding
it to commit header it might be a little bit too non-core, I might meet
with Linus' ethernal fury, and I'm not sure how big of a compatibility
problem would it be.

  Ideas?

--=20
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
