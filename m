From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Fri, 15 May 2009 19:52:03 +0200
Message-ID: <20090515175203.GS15420@raven.wolf.lan>
References: <32541b130905061223h7efddeecvcc52a369093a6b50@mail.gmail.com> <20090506225042.GN15420@raven.wolf.lan> <32541b130905081344m634a78d5l984f4903ec1515eb@mail.gmail.com> <20090508235821.GO15420@raven.wolf.lan> <20090513120922.GP15420@raven.wolf.lan> <32541b130905131028i5c4b1a31j7f760f8157507df6@mail.gmail.com> <20090513222243.GQ15420@raven.wolf.lan> <32541b130905132335t3cbd0e7wf29577ee15ba0bac@mail.gmail.com> <20090514214120.GR15420@raven.wolf.lan> <32541b130905141457u196e1a68w8250489b88eb83c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 15 20:00:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M51iE-0007mj-Ee
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 20:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762157AbZEOSAc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2009 14:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762080AbZEOSAa
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 14:00:30 -0400
Received: from quechua.inka.de ([193.197.184.2]:45343 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762005AbZEOSA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 14:00:28 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1M51hs-0002yc-QA; Fri, 15 May 2009 20:00:28 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id E22FC740D5; Fri, 15 May 2009 19:52:03 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <32541b130905141457u196e1a68w8250489b88eb83c4@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119267>

On Thu, May 14, 2009 at 05:57:00PM -0400, Avery Pennarun wrote:
> On Thu, May 14, 2009 at 5:41 PM, Josef Wolf <jw@raven.inka.de> wrote:
> > So here's my second plan:
> > 1. instead of doing the cherry-picking in a single repository, it m=
ight
> > =A0 be helpful to do it in separate repositories: one repository fo=
r each
> > =A0 direction. =A0While there are still two remote svn repositories=
 in each
> > =A0 svn repository, there is no need for criss-cross anymore. =A0Th=
e flow
> > =A0 of the data is in one direction and it seems (at least at first=
 glance)
> > =A0 I can use git-svn-rebase to get a linear history.
>=20
> it's still criss-crossing, it's just less obvious that way.  One
> repository is exactly the same as two repositories in git; all that
> matters is the branch histories.

Yeah, I see...  But this step is here _only_ to get the existing svn
repositories in sync again.  After cherry-picking and dcommitting, thos=
e
cherry-pick repositories would be wiped.  They have no real history.  T=
he
steps I outlined in my previous mail wouldn't even create any files in
the .git/refs subdirectory.

Once that is done, I can declare one of the existing repositories as
public and pull it via git-svn into a freshly created repos.  The other
repos can then be recreated by cloning and applying patches.  No svn
involved anymore here.

> > 2. After the synchronization is done, I would merge the two reposit=
ories
> > =A0 into a third one to create the public repository. =A0Since this=
 will be
> > =A0 a pure git environment, I hope that the problems that are cause=
d svn's
> > =A0 lack of merge support will vanish.
>=20
> I'd say that basically none of your problems have anything to do with
> svn's lack of merge support, and everything to do with the fact that
> you aren't doing all your changes first on a 'public' branch and then
> merging from there into the private branches.  (That's really not so
> hard to do in svn either, and would save a ton of confusion.)

The problem here is that it does not match the work flow.  IMHO, my wor=
k
flow is very similar to the work flow of the kernel, so I fail to see w=
hy
it can not work.  See the analogies:

kernel: Submodule maintainers are committing into private repositories
me:     People are committing into private repositories

kernel: Those commits are forwarded to Linus's repository
me:     Those commits are forwarded to the public repository

kernel: Maintainers receive commits for other submodules from linus
me:     Commits are distributed from public to private repositories

I can't believe all changes spring into life in linus's repository.

The only differences I can see are:
- size of the project (obviously)
- convert from multiple svn repos instead of bitkeeper
- private repostories have to keep local patches (but I guess maintaine=
rs
  do that also)
