From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 13:33:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505241316490.2307@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org>
 <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org>
 <4292A08A.5050108@cobite.com> <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
 <20050524161745.GA9537@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org>
 <20050524184612.GA23637@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505241236020.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Mansfield <david@cobite.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 22:31:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dag2j-0001Gd-7H
	for gcvg-git@gmane.org; Tue, 24 May 2005 22:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVEXUb4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 May 2005 16:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVEXUb4
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 16:31:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:19923 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262017AbVEXUbp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 16:31:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4OKVbjA020856
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 May 2005 13:31:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4OKVa7w015434;
	Tue, 24 May 2005 13:31:37 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 24 May 2005, Linus Torvalds wrote:
>=20
> Exactly because it's only blobs, it really does smell like a cvsps is=
sue.=20
> My scripts always use "git-update-cache --add -- filename", so it nev=
er=20
> creates any blobs _except_ when it adds them to the index (and thus=20
> write-tree should always pick them up, unless we update the index aga=
in=20
> before the next write-tree happens).

Looking at the contents of these files, all but one of them are changel=
og=20
files, which would be consistent with this theory - if gitps ends up=20
"smushing together" two separate commits (and mutt seems to have the ba=
d=20
habit of having just a simple "# changelog commit" as the commit messag=
e,=20
so it would likely trigger the "same commit message" logic), you'd get=20
exactly this.

The one non-changelog file looks like some kind of message translation
thing:

	# This file was prepared by (in alphabetical order):
	#
	#   Alexey Vyskubov (alexey@pepper.spb.ru)
	#   Andrew W. Nosenko (awn@bcs.zp.ua)
	#   Michael Sobolev (mss@transas.com)
	#   Vsevolod Volkov (vvv@mutt.org.ua)
	#
	# To contact translators, please use mutt-ru mailing list:
	#   http://woe.spb.ru/mailman/listinfo/mutt-ru
	#
	msgid ""
	msgstr ""
	"Project-Id-Version: mutt-1.4i\n"
	"POT-Creation-Date: 2002-05-02 01:08+0200\n"
	"PO-Revision-Date: 2002-05-03 22:53+0300\n"

	...

	#: alias.c:280
	#, c-format
	msgid "[%s =3D %s] Accept?"
	msgstr "[%s =3D %s] =F0=D2=C9=CE=D1=D4=D8?"

	...

and it looks like it is "po/ru.po". Indeed, that's a big clue:

	---------------------
	PatchSet 2869=20
	Date: 2002/05/13 21:17:48
	Author: roessler
	Branch: mutt-1-4-stable
	Tag: (none)=20
	Log:
	From: Vsevolod Volkov <vvv@mutt.org.ua>
=09
	update
=09
	Members:=20
	        po/ru.po:1.129.2.5->1.129.2.6=20
	        po/ru.po:1.129.2.4->1.129.2.5=20
=09
	---------------------

and I thus rest my case. cvs2git is doing the right thing, and this is=20
something that needs to be fixed in cvsps in case anybody cares.

		Linus
