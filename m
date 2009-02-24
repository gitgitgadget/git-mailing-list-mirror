From: Jan Kara <jack@suse.cz>
Subject: Re: git bisect goes wild?
Date: Tue, 24 Feb 2009 21:04:16 +0100
Message-ID: <20090224200416.GH22108@duck.suse.cz>
References: <20090224184414.GE22108@duck.suse.cz> <eaa105840902241059y70143c43s7d12b10fe35127e6@mail.gmail.com> <20090224191002.GF22108@duck.suse.cz> <alpine.LNX.1.00.0902241427420.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 21:06:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc3XI-0007Rf-5T
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 21:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762AbZBXUEU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 15:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757678AbZBXUEU
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 15:04:20 -0500
Received: from cantor.suse.de ([195.135.220.2]:51078 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751913AbZBXUET (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 15:04:19 -0500
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 45B22446B5;
	Tue, 24 Feb 2009 21:04:17 +0100 (CET)
Received: from duck.suse.cz (duck.suse.cz [10.20.1.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.suse.cz (Postfix) with ESMTP id C5C9662807F;
	Tue, 24 Feb 2009 21:04:16 +0100 (CET)
Received: by duck.suse.cz (Postfix, from userid 10005)
	id 7E6301F1E2F; Tue, 24 Feb 2009 21:04:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0902241427420.19665@iabervon.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111336>

On Tue 24-02-09 14:46:09, Daniel Barkalow wrote:
> On Tue, 24 Feb 2009, Jan Kara wrote:
>=20
> > On Tue 24-02-09 13:59:16, Peter Harris wrote:
> > > 2009/2/24 Jan Kara:
> > > > =A0Hi,
> > > >
> > > > =A0I've been bisecting some change in Linux kernel. The output =
of
> > > > "git bisect log" is:
> > > ...
> > > > git-bisect bad 419217cb1d0266f62cbea6cdc6b1d1324350bc34
> > > ...
> > > > git-bisect good 3e9830dcabdeb3656855ec1b678b6bcf3b50261c
> > > >
> > > > =A0But after the last command, I was sent to commit
> > > > 9ec76fbf7d6da3e98070a7059699d0ca019b0c9b which is far outside t=
he window
> > > > between the last good and bad commit.
> > >=20
> > > How did you determine that this commit is outside the window?
> > >=20
> > > When I run "gitk 3e9830..419217" it shows that commit, as does "g=
it
> > > log". 9ec76fb appears to be inside the window to me.
> >   Ho, hum, right. But if I do:
> > git describe 9ec76fbf7d6da3e98070a7059699d0ca019b0c9b
> >   I get v2.6.23-rc3-215-g9ec76fb which is a bit strange for bisecti=
ng
> > between 2.6.23 and 2.6.24. Also the kernel gets named 2.6.23-rc3 an=
d kernel
> > config options get also to some pre 2.6.23 state. That's what is co=
nfusing
> > me. It seems like the kernel checked out is some old one. I'm not a=
 git
> > expert so it might be fine but it just seems really strange.
>=20
> If you're trying to find a problem that got into the mainline kernel=20
> between 2.6.23 and 2.6.24, you should expect to find a change that wa=
s=20
> added less than 2 weeks after 2.6.23 was released, and written before=
=20
> 2.6.23 was released. Such a change would probably have been written=20
> against a mainline kernel somewhere in the 2.6.23-rcN range. So the=20
> description you should expect of the version that introduces the bug =
is=20
> "2.6.23-rcN with some patches that hadn't been merged to mainline".
>=20
> In order for your bisect to end up with a commit that looks like it's=
=20
> between 2.6.23 and 2.6.24, Linus would have to have merged a buggy co=
mmit=20
> for 2.6.24 written after 2.6.23 was released, which is against how th=
ings=20
> are supposed to be done.
  Yes, thanks for explanation. I've figured it out as well after readin=
g
the posted link. What makes me a bit afraid is that bugs (or especially
performance regression, which is what I'm hunting right now) can be cau=
sed
by interference of two independent changes. I.e., in a situation like:
  A-B-C-D
   \_E_/

  if I start bisecting between B and D and the problem happens only whe=
n
both C and E are merged, then the best what I can end up with is that t=
he
merge-commit is what causes the regression, isn't it? Which is sometime=
s
useless when the merge commit is a merge of some branch with 1000
patches...
  So it might be useful if git-bisect had a "linear" mode - we would fi=
rst
create a linear history of commits and then bisect in it. Now I underst=
and
that this is not always possible (sometimes changes would not apply) bu=
t it
should be possible when merges are trivial (i.e., all commits apply cle=
anly
to the source just before the merge commit - and this is quite often th=
e
case at least with the Linux kernel). Just my 2 cents.

								Honza
--=20
Jan Kara <jack@suse.cz>
SUSE Labs, CR
