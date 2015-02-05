From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Makefile: Use the same source directory for "ln -s"
 as for "ln" / "cp"
Date: Thu, 5 Feb 2015 15:45:35 -0500
Message-ID: <20150205204534.GE15326@peff.net>
References: <CAHGBnuOGv4Zn7dz6voEMn=PtMfm=0TQumt9PxV9nYgXyB0Xj=g@mail.gmail.com>
 <D060A1E5-DAF3-49D5-B0B3-F831BCDFD41F@gmail.com>
 <xmqqmw4skvrn.fsf@gitster.dls.corp.google.com>
 <CAHGBnuP5e7NsDrD31otFGZiFYW-vxsOf7kV61=Zt32n3S78RBg@mail.gmail.com>
 <20150205195143.GB15326@peff.net>
 <CAHGBnuPL7NN9J+4xd7xifsmbSPcC5V2ze05ji7P_qnvWHPGV+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 21:45:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJTJ2-00036n-Vb
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 21:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbbBEUpj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2015 15:45:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:45719 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751062AbbBEUph (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 15:45:37 -0500
Received: (qmail 10490 invoked by uid 102); 5 Feb 2015 20:45:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Feb 2015 14:45:37 -0600
Received: (qmail 2460 invoked by uid 107); 5 Feb 2015 20:45:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Feb 2015 15:45:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Feb 2015 15:45:35 -0500
Content-Disposition: inline
In-Reply-To: <CAHGBnuPL7NN9J+4xd7xifsmbSPcC5V2ze05ji7P_qnvWHPGV+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263402>

On Thu, Feb 05, 2015 at 09:29:04PM +0100, Sebastian Schuberth wrote:

> > We would still want an equivalent to 2/2 to set up a relative symli=
nk
> > for $(ALL_PROGRAMS), though, right?
>=20
> Probably. But I'm not sure how to calculate the relative path
> correctly so that it'll work with all possible bin / execdir
> combinations. A simple
>=20
> diff --git a/Makefile b/Makefile
> index 21f23cb..d2849c3 100644
>=20
> --- a/Makefile
> +++ b/Makefile
>=20
> @@ -2258,8 +2258,8 @@
>=20
>  endif
>  =C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7$(RM)=C2=B7"$$execdi=
r/$$p"=C2=B7&&=C2=B7\
>  =C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7test=C2=B7-z=C2=B7"$=
(NO_INSTALL_HARDLINKS)$(NO_CROSS_DIRECTORY_HARDLINKS)"=C2=B7&&=C2=B7\
>  =C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7ln=C2=B7"$$bindir/$$=
p"=C2=B7"$$execdir/$$p"=C2=B72>/dev/null=C2=B7||=C2=B7\
> +=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7ln=C2=B7-s=C2=B7"../=
$$p"=C2=B7"$$execdir/$$p"=C2=B72>/dev/null=C2=B7||=C2=B7\
>  =C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7cp=C2=B7"$$bindir/$$=
p"=C2=B7"$$execdir/$$p"=C2=B7||=C2=B7exit;=C2=B7\
>  =C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7done;=C2=B7\
>  =C2=B7=C2=B7=C2=B7=C2=B7}=C2=B7&&=C2=B7\
> --=C2=B7
>=20
> does not seem to be correct in all cases.

Ah, I see. Yeah, you'd have to calculate that relative path between
$bindir and $execdir. We have C code already to do that (see
relative_path() in path.c), so in theory you could build a wrapper
during the build phase and then run:

  ln -s $(./my-wrapper "$bindir" "$execdir")/$p $execdir/$p

or something during the install phase.

-Peff
