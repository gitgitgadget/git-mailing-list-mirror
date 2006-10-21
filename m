From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: less -F ubuntu dapper.
Date: Sat, 21 Oct 2006 20:01:10 +0400
Message-ID: <20061021200110.6aef96a4.vsu@altlinux.ru>
References: <cc723f590610210623sbee2075i5f2fd441cceb84ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__21_Oct_2006_20_01_10_+0400_v4Ts/nM8XkX0XX_a"
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 21 18:03:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbJJK-0005jX-Le
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 18:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993124AbWJUQCx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 12:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993127AbWJUQCx
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 12:02:53 -0400
Received: from [213.177.124.23] ([213.177.124.23]:34014 "EHLO procyon.home")
	by vger.kernel.org with ESMTP id S2993124AbWJUQCw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 12:02:52 -0400
Received: by procyon.home (Postfix, from userid 500)
	id 1AFAA4BA52; Sat, 21 Oct 2006 20:01:13 +0400 (MSD)
To: "Aneesh Kumar" <aneesh.kumar@gmail.com>
In-Reply-To: <cc723f590610210623sbee2075i5f2fd441cceb84ae@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.10.2; x86_64-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29628>

--Signature=_Sat__21_Oct_2006_20_01_10_+0400_v4Ts/nM8XkX0XX_a
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 21 Oct 2006 18:53:35 +0530 Aneesh Kumar wrote:

> -F option for less in ubuntu Dapper is broken. It doesn't display
> anyting if the file can be displayed in one page.

Same here in ALT Linux (less-382-alt2).  The problem appears only
when the terminal supports alternate screen, and less uses it.

BTW, try this (needs bash or zsh):

  (for ((i=3D0; i < 20; ++i)) do echo $i; sleep 0.1; done) | less -F

You'll see that the text appears on the screen while the loop
outputs it, but disappears once the output finishes.  If you use
"less -FX" instead, the text will not disappear, but in this case
less will not use the alternate screen, which is inconvenient when
the text is large (e.g., when you browse the text, parts of it
will be put into the scrollback buffer).

Because less must start displaying the text immediately after it
got some data, it cannot decide whether to use the alternate
screen depending on the text size.  Therefore, if you want to use
the -F option on a terminal with alternate screen, you need to
turn off the alternate screen support with -X.  But less cannot do
this automatically, because it does not really know about the
alternate screen (the -X option disables termcap initialization
and deinitialization strings, which can do arbitrary things, and
may actually be required on some obscure terminals).

It should be possible to add yet another option to less to make it
initially display the text on the alternate screen, and on EOF, if
the text fits on the screen, turn off the alternate screen,
_redisplay the text_ and exit.  However, this option will have
even more assumptions about the terminal than -X (if the terminal
does not turn on alternate screen in its termcap initialization
string, there will be a horrible mess on screen), and you will get
flicker when the text is displayed multiple times.

> Because of this the recent chages to
> 96a035d1db9082d244867033020d0ceb571cf94e results in commands
> like git show not showing the changes.

Adding the -X option might break some terminals (and will irritate
users which used alternate screen before), so apparently the only
way to fix this breakage is to remove the -F option again...

--Signature=_Sat__21_Oct_2006_20_01_10_+0400_v4Ts/nM8XkX0XX_a
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFOkRJW82GfkQfsqIRAjhHAJ44wHlYDYTdgjZCIm0dARhXaTEFWQCfZGU2
sUa4VHLrKhK3RS2toL+UJ4c=
=Zh1J
-----END PGP SIGNATURE-----

--Signature=_Sat__21_Oct_2006_20_01_10_+0400_v4Ts/nM8XkX0XX_a--
