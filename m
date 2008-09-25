From: Joey Hess <joey@kitenet.net>
Subject: Re: git log and utf-u in filenames
Date: Thu, 25 Sep 2008 18:43:54 -0400
Message-ID: <20080925224354.GA6072@kodama.kitenet.net>
References: <20080925215002.GA30810@kodama.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 26 00:45:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kiza5-0004pG-LF
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 00:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbYIYWn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 18:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753281AbYIYWn5
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 18:43:57 -0400
Received: from wren.kitenet.net ([80.68.85.49]:59275 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752984AbYIYWn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 18:43:57 -0400
Received: from kodama.kitenet.net (fttu-67-223-5-142.btes.tv [67.223.5.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Joey Hess", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 89D273142FE
	for <git@vger.kernel.org>; Thu, 25 Sep 2008 18:43:55 -0400 (EDT)
Received: by kodama.kitenet.net (Postfix, from userid 1000)
	id 29D321142B1; Thu, 25 Sep 2008 18:43:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080925215002.GA30810@kodama.kitenet.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94/8340/Thu Sep 25 16:13:43 2008 on wren.kitenet.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96812>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Joey Hess wrote:
> And did earlier versions of git (circa 2006) perhaps
> not do that escaping? I have code in ikiwiki that apparently used to work=
, but
> is certianly not working with current git, due to this escaping.

No, I guess it's always done that, perhaps something broke on my side
in the meantime.

But it doesn't seem right somehow that gitweb, ikiwiki, and seemingly
any other program that needs to look at git log / commits and figure out
what filename is being changed needs to include their own nasty code[1] to
convert the escaped characters back to normal characters.

And it seems that anyone who uses a lot of utf-8 in filenames would shortly
get tired of git commit, git log, etc displaying obfuscated versions of the=
ir
filenames.

I'm sure it makes sense to use this format internally in git to represent
filenames, to avoid needing to worry about encoding issues. But it's a shame
that that internal detail is exposed so that everything around git has to
worry about it.

Would making git-log and git-commit display de-escaped filenames be likely
to break something?

--=20
see shy jo

[1] Such as this from gitweb:

# git may return quoted and escaped filenames
sub unquote {
        my $str =3D shift;

        sub unq {
                my $seq =3D shift;
                my %es =3D ( # character escape codes, aka escape sequences
                        't' =3D> "\t",   # tab            (HT, TAB)
                        'n' =3D> "\n",   # newline        (NL)
                        'r' =3D> "\r",   # return         (CR)
                        'f' =3D> "\f",   # form feed      (FF)
                        'b' =3D> "\b",   # backspace      (BS)
                        'a' =3D> "\a",   # alarm (bell)   (BEL)
                        'e' =3D> "\e",   # escape         (ESC)
                        'v' =3D> "\013", # vertical tab   (VT)
                );

                if ($seq =3D~ m/^[0-7]{1,3}$/) {
                        # octal char sequence
                        return chr(oct($seq));
                } elsif (exists $es{$seq}) {
                        # C escape sequence, aka character escape code
                        return $es{$seq};
                }
                # quoted ordinary character
                return $seq;
        }

        if ($str =3D~ m/^"(.*)"$/) {
                # needs unquoting
                $str =3D $1;
                $str =3D~ s/\\([^0-7]|[0-7]{1,3})/unq($1)/eg;
        }
        return $str;
}

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFI3BQpd8HHehbQuO8RAuLMAKDYLHGZF1VHmOI568Hw86tH2uTFVACfcv37
hsYSEqMjHbXTJ2bk2vF05R0=
=n66c
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
