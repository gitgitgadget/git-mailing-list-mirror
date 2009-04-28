From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Wed, 29 Apr 2009 00:37:28 +0200
Message-ID: <20090428223728.GE15420@raven.wolf.lan>
References: <20090427201251.GC15420@raven.wolf.lan> <32541b130904281353k572fed5la468de65f73ccd19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 00:40:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyvyQ-00038j-Dy
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 00:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbZD1WkN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Apr 2009 18:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbZD1WkN
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 18:40:13 -0400
Received: from quechua.inka.de ([193.197.184.2]:33351 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752268AbZD1WkM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 18:40:12 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1LyvyE-0002cI-S9; Wed, 29 Apr 2009 00:40:10 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id D55182CC7A; Wed, 29 Apr 2009 00:37:28 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <32541b130904281353k572fed5la468de65f73ccd19@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117824>

Thanks for your answer, Avery!

On Tue, Apr 28, 2009 at 04:53:52PM -0400, Avery Pennarun wrote:
> On Mon, Apr 27, 2009 at 4:12 PM, Josef Wolf <jw@raven.inka.de> wrote:
> > I have two subversion repositories which I would like to synchroniz=
e via
> > git-svn. =A0[...]
>=20
> What you're attempting is rather complicated.  I guess I'd suggest we
> back up a step: why do you want to do this?  In what way does a "pure
> svn" tool like svnsync
> (http://svnbook.red-bean.com/en/1.5/svn.ref.svnsync.html) not do what
> you want?

The explanation to that git somewhat longish, sorry for that.

The project is about configuring networks.  If you think about cfengine=
,
you get pretty close to what it is about.  It started out as a single
repository.  But since configuring networks requires lots of
"localization", it was soon split into two parts: One part are the
"mechanics": generic libraries/scripts.  The other part is the
"policy": the configuration that specifies how the mechanics should
do their task.  The reason for the split was to allow multiple
policies (for independent administrations) to share one common set of
mechanics (as svn:externals).  For security reasons, the mechanics were
imported back into the (multiple) policies later on.

Currently, there exist multiple independent repositories (for security
reasons).  In the past, the repositories were "synchronized" manually.
So technically, the repositories have no common history (at least not
in svn's metadata).  But the contents are actually rather "similar",
since they were synchronized multiple times in the past.

In the long term, I'd like to move everything completely to git.  That
would make it much easier to move changes from one repos to the other
while keeping the (intended) differences in the policy.

So my first goal is to bring the contents into sync.  The next step wou=
ld
be to create a "reference" (the official) git repository, which can be
cloned by the administrations to create their localized repositories.

In the meantime, I need a way to synchronize the contents from time to
time.  I guess it will take some time to create the official repos and
get used to the work flow.

> Are you making changes to *both* svn repositories

Yes.

> and then want to synchronize their histories?

Since synchronization was done manually in the past, I do not (yet) car=
e
about the history very much.  My first goal was to get the contents int=
o
a sane state: I've done lots of criss-cross cherry-picking.  Now that t=
he
contents are in sync (within git branches), I'd like to do two things:

 - Set "markers" to indicate which commits are already synchronized, so
   the next synchronization will be easier.  I thought "git-merge -s ou=
rs"
   would be the correct way to do that.  But as I already wrote: this
   causes the next "git-svn rebase" to apply all the commits of the oth=
er
   branch (which I already cherry-picked)

 - Feed the cherry-picked commits back to the svn repositories.  I've n=
ot
   tried that yet, since I think I should "git-svn rebase" first.

> This is basically impossible, since svn only has a linear history.
> If you add commit A to one repo, and
> commit B to the other, you will never make the histories identical in
> both repos;

Yeah, I see.  But I don't really care about that, as long as the relati=
ve
order of the commits is kept when they are moved to the other repos.
Since the svn repositories will die once the migration is done, this
is not a big deal.

> one will necessarily have A and then B, and the other will
> have B and then A.  That's not really desirable, since one of those
> two histories is a lie.

The current situation is an even bigger lie.

> So, what is it you're *really* trying to do?

I hope my explanation was not too boring...

> Have fun,

Yeah, I am having _lots_ of fun =3D8)
