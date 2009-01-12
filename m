From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: Help! My ISP blocks repo.or.cz. How to push changes?
Date: Mon, 12 Jan 2009 11:20:07 +0000
Message-ID: <20090112112007.GA3841@bit.office.eurotux.com>
References: <200901120246.28364.jnareb@gmail.com> <81b0412b0901120117mf010317m79874a235e29a439@mail.gmail.com> <200901121213.45858.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 12:28:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMKy0-0007ph-Ng
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 12:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbZALL0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 06:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752233AbZALL0z
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 06:26:55 -0500
Received: from os.eurotux.com ([216.75.63.6]:33935 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218AbZALL0y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 06:26:54 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Jan 2009 06:26:54 EST
Received: (qmail 10802 invoked from network); 12 Jan 2009 11:20:11 -0000
Received: from unknown (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by 0 with AES128-SHA encrypted SMTP; 12 Jan 2009 11:20:11 -0000
Content-Disposition: inline
In-Reply-To: <200901121213.45858.jnareb@gmail.com>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105329>


--uZ3hkaAS1mZxFaxD
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2009 at 12:13:44PM +0100, Jakub Narebski wrote:
> Alex Riesen wrote:
> > 2009/1/12 Jakub Narebski <jnareb@gmail.com>:
>=20
> > > Do you have any suggestions to bypass this block for git? I have acce=
ss
> > > to Linux shell account (no root access, though) which doesn't have
> > > problems with repo.or.cz, so I think I could set up SSH tunnel: but
> > > how? And what to do with access via git:// - move to SSH too?
> >=20
> > See man ssh, look for -L. It works for arbitrary ports, so you can redi=
rect
> > git:// port to anywhere. Same for push over ssh, just give another port=
 when
> > connecting.
>=20
> Currently I have the folowing in my ~/.ssh/config:
>=20
>   # TP S.A. blocks repo.or.cz
>   Host repo.or.cz
> 	NoHostAuthenticationForLocalhost yes
> 	HostName localhost
> 	Port 2222
>=20
> and I can simply use "git push repo" without any changes.
> But I have to run=20
>=20
>  $ ssh -f -N -L 2222:repo.or.cz:22 jnareb@host.example.com
>=20
> first. Is there any way to automate this?

For those cases I use the attached script. Read the first lines, with
information on how to install.

The end result is that I can do:
ssh host1--host2--host3

Or scp, rsync, etc.

Regards,
Luciano Rocha

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ssh_p
Content-Transfer-Encoding: quoted-printable

#!/bin/bash
## SSH connection chaining
##
## (C) 2007, Luciano Rocha <strange@nsk.pt>
##
## This program is free software; you can redistribute it and/or
## modify it under the terms of the GNU General Public License
## as published by the Free Software Foundation; either version 2
## of the License, or (at your option) any later version.
##=20
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##=20
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
## MA 02110-1301, USA.
##=20
## Or check the webpage: http://www.gnu.org/licenses/old-licenses/gpl-2.0.h=
tml
##
## Documentation:
##
## Include in your .ssh/config:
## host *--*
## proxycommand ssh_p %h %p
##
## And then you can do:
## ssh hosta--hostb--hostc
## scp hosta--hostb--hostc:file .
##
## A user specification is also possible, but not for the last host, for
## that one, you'll have to use ssh's standard user specification (user@host
## or -luser):
## ssh usera_hosta--userb_hostb--hostc -luserc
## scp userc@usera_hosta--userb_hostb--hostc:file .
##
## Compression is disable on all proxy sshs, as traffic is already encrypte=
d.
## Activate compression in the master ssh command, if desired.
##
## Environment variable SSH_CONFIG_FILE can point to a ssh configuration
## file for use in the proxy sshs.

## missing hops
h=3D"${1%--*}"
## nc target
rh=3D"${1##*--}"
p=3D"${2:-22}"


## user for next hop
u=3D
n=3D"${h##*--}"
if [ -z "${n##*_*}" ]; then
	u=3D${n%%_*}
	if [ "$h" !=3D "$n" ]; then
		h=3D"${h%--*}--${n##*_}"
	else
		h=3D"${n##*_}"
	fi
fi

echo "${SSH_INDENT}+ connecting to $h for $rh" >&2


exec env SSH_INDENT=3D"${SSH_INDENT} " ssh -o "Compression no" \
	${SSH_CONFIG_FILE:+-F$SSH_CONFIG_FILE} \
	${u:+$u@}$h \
	"echo \"${SSH_INDENT}- connected to $h, forwarding to $rh:$p\" >&2 ; nc -w=
 3600 $rh $p"

--45Z9DzgjV8m4Oswq--

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklrJ2cACgkQinSul6a7oB+THQCfeaDMHxdCGZHWDVo91a5TPIWY
lcwAniFH3avoEbkxKq39kI+4nx4k5Rh9
=lnno
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
