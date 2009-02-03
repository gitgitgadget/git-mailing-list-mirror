From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [wishlist] git-archive -L
Date: Tue, 03 Feb 2009 09:10:43 +0100
Message-ID: <4987FC03.60607@lsrfire.ath.cx>
References: <20090202143425.GA30667@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@madism.org>
X-From: git-owner@vger.kernel.org Tue Feb 03 09:12:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUGOG-0007yh-CM
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 09:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbZBCIKu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Feb 2009 03:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbZBCIKu
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 03:10:50 -0500
Received: from india601.server4you.de ([85.25.151.105]:44256 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbZBCIKt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 03:10:49 -0500
Received: from [10.0.1.101] (p57B7FC97.dip.t-dialin.net [87.183.252.151])
	by india601.server4you.de (Postfix) with ESMTPSA id 855422F8056;
	Tue,  3 Feb 2009 09:10:47 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <20090202143425.GA30667@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108165>

Pierre Habouzit schrieb:
> Hi Rene,
>=20
> I wanted to do that myself, but I sadly miss the time right now, so I
> wonder if you'd know how to do the following.
>=20
> We have in our repository a kind of modular system (for a family of w=
eb
> sites) where each web-site uses a (versionned) symlink farm. IOW it
> works basically that way:
>=20
>     www/module1
>     www/module2
>     product_A/www/module1 -> ../../www/module1
>     product_A/www/module_A
>     product_B/www/module1 -> ../../www/module1
>     product_B/www/module2 -> ../../www/module2
>     product_B/www/module_B
>=20
> Though product_A and _B even if they share a fair amount of code, are
> separate products and when we release, we'd like to be able to perfor=
m
> from inside:
>=20
>     git archive --format=3Dtar -L product_$A
>=20
> where -L basically does what it does in cp: dereference symlinks.  To
> make the thing hairier, we also have symlinks _inside_ www/ (pointing
> into the same subtree) that we'd like to keep if possible (even if it=
's
> not a big deal).
>=20
> So I'd suggest something where -L only dereferences the symlink if it
> goes outside of the list of paths passed to git-archive, and -LL (or =
-L
> -L) dereferences anything. Of course this would only make sense if th=
e
> symlinks resolve to something that is tracked :)

Last April, I was working on making archive follow all symlinks pointin=
g
to internal files.  The goal was a bit different, namely to create
archives for platforms without symlink support (i.e. it would resolve
all symlinks pointing to tracked objects).

IIRC the code had some limitations, e.g. it couldn't follow a symlink t=
o
a path containing symlinked directories.  I'll need to rebase it to
master first, though, as the surrounding code has changed a bit in the
meantime.

To follow only symlinks that point outside of the specified paths sound=
s
like a sensible mode of operation, but I'm not sure that it's worth a
one letter option.

Given your setup you also might want to take a look at submodules and
the recent submodule archival support patches by Lars Hjelmi.

Anyway, I'll try to resurrect my old, incomplete symlink following code=
,
but I don't have much time, either. :-/

Ren=E9
