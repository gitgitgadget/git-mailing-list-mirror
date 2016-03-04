From: Kevin Daudt <me@ikke.info>
Subject: Re: Change in .gitignore handling: intended or bug?
Date: Fri, 4 Mar 2016 06:51:17 +0100
Message-ID: <20160304055117.GB26609@ikke.info>
References: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Charles Strahan <charles@cstrahan.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 06:51:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abie4-0008Af-Pq
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 06:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbcCDFvU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Mar 2016 00:51:20 -0500
Received: from ikke.info ([178.21.113.177]:45689 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114AbcCDFvT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 00:51:19 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
	id D281A2D8007; Fri,  4 Mar 2016 06:51:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288233>

On Thu, Mar 03, 2016 at 09:11:56PM -0500, Charles Strahan wrote:
> Hello,
>=20
> I've found a change in the way .gitignore works, and I'm not sure if
> it's a bug
> or intended.
>=20
> Previously, one could use the following .gitignore:
>=20
>     *
>     !/foo
>     !/foo/bar.txt
>     !/baz
>     !/baz/quux
>     !/baz/quux/**/*
>=20
> And these files would be seen by git:
>=20
>     foo/bar.txt
>     baz/quux/grault.txt
>     baz/quux/corge/wibble.txt
>=20
> And these files would be ignored:
>=20
>     foo/garply.txt
>     baz/waldo.txt
>=20
> At some point (between git 2.6.0 and 2.7.0, I think), the behavior
> changed such
> that _none_ of the files above would be ignored. Previously, git woul=
d
> treat
> !/foo as an indication that it should not prune /foo, but that
> _wouldn't_ be
> sufficient to un-ignore the contents thereof. Now, it seems the new
> scheme
> treats !/foo as functionally equivalent to !/foo followed by !/foo/**=
/*
> in the
> old scheme.
>=20
> I manage my home directory by making it a git repo, and using
> ~/.gitignore to
> selectively permit certain files or subdirectories to be seen by git.
> The recent
> change in behavior has resulted in sensitive directories like ~/.gpg
> being
> un-ignored. For reference, I've appended my .gitignore to the end of
> this email.
>=20
> So, is this behavior intended, or is this a bug? If the former, is th=
ere
> an
> announcement explaining this change?
>=20
> -Charles
>=20
> [snip]
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Works as intended for me:

=E2=94=9C=E2=94=80=E2=94=80 baz
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 quux
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 corge
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=
=94=E2=94=80=E2=94=80 wibble.txt
=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80=
 grault.txt
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 waldo.txt
=E2=94=94=E2=94=80=E2=94=80 foo
    =E2=94=9C=E2=94=80=E2=94=80 bar.txt
    =E2=94=94=E2=94=80=E2=94=80 garply.txt

$ git status -s -uall
?? baz/quux/corge/wibble.txt
?? baz/quux/grault.txt
?? foo/bar.txt

garply.txt and waldo.txt are ignore, but the rest is still tracked.

I'm on 2.7.2.
