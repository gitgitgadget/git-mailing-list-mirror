From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Some improvements for git-imap-send
Date: Tue, 9 Feb 2010 11:57:45 -0500
Message-ID: <20100209165745.GA21135@coredump.intra.peff.net>
References: <7vaavj8h1k.fsf@alter.siamese.dyndns.org>
 <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
 <20100209150650.GA15982@sigill.intra.peff.net>
 <40aa078e1002090713h7e7d2f93r4cca9649e98db735@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>, gitster@pobox.com,
	git@vger.kernel.org, jwhite@codeweavers.com,
	robertshearman@gmail.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Feb 09 17:57:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NetPJ-0001Tv-DQ
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 17:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890Ab0BIQ5o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2010 11:57:44 -0500
Received: from peff.net ([208.65.91.99]:44376 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754034Ab0BIQ5n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 11:57:43 -0500
Received: (qmail 22095 invoked by uid 107); 9 Feb 2010 16:57:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 09 Feb 2010 11:57:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Feb 2010 11:57:45 -0500
Content-Disposition: inline
In-Reply-To: <40aa078e1002090713h7e7d2f93r4cca9649e98db735@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139414>

On Tue, Feb 09, 2010 at 04:13:26PM +0100, Erik Faye-Lund wrote:

> On Tue, Feb 9, 2010 at 4:06 PM, Jeff King <peff@peff.net> wrote:
> > On Tue, Feb 09, 2010 at 09:09:01PM +0900, Hitoshi Mitake wrote:
> >
> >> =C2=A0base64.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0122 ++++++++
> >> =C2=A0base64.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 36 +++
> >> =C2=A0md5.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0600 +++++++++++++++++++++++=
++++++++++++++++
> >> =C2=A0md5.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 61 ++++
> >> =C2=A0md5_hmac.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0137 +++++++++
> >> =C2=A0md5_hmac.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 36 +++
> >
> > That's a lot of extra code. Doesn't imap-send already conditionally
> > compile against openssl for starttls support? Can't we just get all
> > three of these algorithms from openssl?
> >
>=20
> I don't think OpenSSL includes SASL-support that is needed for
> STARTTLS. But it might make sense to use something like GSASL[1]
> instead of rolling all the SASL-mechanisms ourselves.

Did you mean "SASL-support that is needed for CRAM-MD5"? The SASL neede=
d
for that is pretty simple. Hitoshi's patch 3/4 does all of that already
in less than 100 lines.  Using a "real" sasl library might get us more
authentication methods than CRAM-MD5, but I don't know that anyone
necessarily cares about them.

But using openssl to replace the low-level routines in patches 1+2 woul=
d
drop almost 1000 lines, and not significantly change his 3/4.

Personally, I don't care either way about using a SASL library. It's an
extra dependency, but one that is optional for this feature. But
somebody will have to do the work to integrate it, whereas I think usin=
g
openssl is only a few lines of change. If somebody wants to do that
work, then great.

-Peff
