From: Jan Hudec <bulb@ucw.cz>
Subject: Re: How to bypass the post-commit hook?
Date: Mon, 31 Dec 2007 11:55:14 +0100
Message-ID: <20071231105514.GA9214@efreet.light.src>
References: <46dff0320712300712l78c1cdaeya5fa105be01f6b74@mail.gmail.com> <20071230215008.GB20098@efreet.light.src> <46dff0320712302108i61f3b868obb93f89c1c24062c@mail.gmail.com> <20071231093152.GC20098@efreet.light.src> <46dff0320712310222m64d86e95l1499a7ffb1fff65c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 31 11:55:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9IJB-0007lF-0p
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 11:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756576AbXLaKzV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Dec 2007 05:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756314AbXLaKzV
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 05:55:21 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:55184 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754280AbXLaKzU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 05:55:20 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id EE78C57472;
	Mon, 31 Dec 2007 11:55:18 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id YwyjhC5AIGts; Mon, 31 Dec 2007 11:55:16 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 916D4572BA;
	Mon, 31 Dec 2007 11:55:16 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1J9IId-0002Pc-0h; Mon, 31 Dec 2007 11:55:15 +0100
Content-Disposition: inline
In-Reply-To: <46dff0320712310222m64d86e95l1499a7ffb1fff65c@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69398>

On Mon, Dec 31, 2007 at 18:22:37 +0800, Ping Yin wrote:
> On Dec 31, 2007 5:31 PM, Jan Hudec <bulb@ucw.cz> wrote:
> > On Mon, Dec 31, 2007 at 13:08:05 +0800, Ping Yin wrote:
> > > On Dec 31, 2007 5:50 AM, Jan Hudec <bulb@ucw.cz> wrote:
> > Well, I guess noone thought it would be useful to disable it.
> >
> > > I use post-commit because i don't find a better way to update imp=
orted
> > > css version automatically
> > >
> > > $ cat foo.css
> > > @import url(bar.css?57e708)
> > > ...
> > >
> > > When i modify bar.css and then commit it ( with blob sha1 bf7059)=
=EF=BC=8CI
> > > use post-commit to modify foo.css
> > > $ cat foo.css
> > > @import url(bar.css?bf7059)
> > > ...
> >
> > But that file is not versioned, is it?
> >
> No, bar.css is also versioned
>=20
> > Because if it is, you want to commit it in the very same commit as =
bar.css
> > and therefore want to do it in the *pre*-commit hook. Since obvious=
ly the
> > foo.css wants to include the current version of bar.css, not the pr=
evious
> > one.
>=20
> If this happens, i have to commit twice (the last is amend)

Therefore the refered commit is dropped on the floor and will be eventu=
ally
expired. So using commit id of an amended commit was an error.

> > Note, that while you don't know the commit sha1 before the commit, =
you do
> > know the *blob* sha1s. So you can do this change in pre-commit hook=
=2E
>=20
> I chose post-commit because i used commit sha1 instead of blob sha1 a=
s
> file version in the first time, and now pre-commit seems better. One
> more question,  I use 'git ls-files' to fetch the blob sha1, so is th=
e
> got sha1  the same when pre-commit and post-commit?

Yes, it should be.

Commit might be preparing the index to commit under different name than
default, but it will export GIT_INDEX_FILE environment variable to the
pre-commit hook and git commands you call will know to take the index f=
rom
there.

Note, that you can -- and should -- add the foo.css to the commit. But =
the
file might contain other changes in tree, that are not about to be comm=
ited,
so prefered way would be to get the content from the index, modify that=
 and
update the index manually (with git update-index).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
