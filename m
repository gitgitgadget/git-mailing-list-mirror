From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] gpg: add support for gpgsm
Date: Thu, 31 Mar 2016 11:57:53 -0400
Message-ID: <20160331155753.GA1006@sigill.intra.peff.net>
References: <1459432304-35779-1-git-send-email-cmn@dwim.me>
 <xmqqa8ler6pu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 17:58:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aleyv-0004C3-FS
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 17:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757284AbcCaP55 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2016 11:57:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:41600 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752251AbcCaP55 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 11:57:57 -0400
Received: (qmail 24950 invoked by uid 102); 31 Mar 2016 15:57:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 11:57:56 -0400
Received: (qmail 14081 invoked by uid 107); 31 Mar 2016 15:57:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 11:57:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2016 11:57:53 -0400
Content-Disposition: inline
In-Reply-To: <xmqqa8ler6pu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290406>

On Thu, Mar 31, 2016 at 08:46:05AM -0700, Junio C Hamano wrote:

> Carlos Mart=C3=ADn Nieto <cmn@dwim.me> writes:
>=20
> > Detect the gpgsm block header and run this command instead of gpg.
> > On the signing side, ask gpgsm if it knows the signing key we're tr=
ying
> > to use and fall back to gpg if it does not.
> >
> > This lets the user more easily combine signing and verifying X509 a=
nd
> > PGP signatures without having to choose a default for a particular
> > repository that may need to be occasionally overridden.
> >
> > Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@dwim.me>
> >
> > ---
> >
> > Out there in the so-called "real world", companies like using X509 =
to
> > sign things. Currently you can set 'gpg.program' to gpgsm to get
> > gpg-compatible verification,...
>=20
> I notice that you had to add GPGSM_MESSAGE string constant; does the
> current code without any change really work correctly if you set
> 'gpg.program' to gpgsm and do nothing else?

It has been a few months since I fooled around with gpgsm, but IIRC, it
works for tags but not commits. Because verify-tag just blindly dumps
the tag to gpg.program, and gpgsm finds the correct signature. Whereas
the --show-signature option of git-log does not bother to call gpg if w=
e
didn't see a signature.

Which makes me wonder whether verify-tag would send a gpgsm-signed tag
to the right place with Carlos's patch (I didn't check).

-Peff
