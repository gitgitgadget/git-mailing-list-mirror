From: Jeff King <peff@peff.net>
Subject: Re: git log - crash and core dump
Date: Wed, 17 Apr 2013 14:02:48 -0400
Message-ID: <20130417180248.GA1839@sigill.intra.peff.net>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com>
 <516D93C4.1000100@lsrfire.ath.cx>
 <7v61zml0ow.fsf@alter.siamese.dyndns.org>
 <516DBE2E.4060201@lsrfire.ath.cx>
 <7vzjwyi0ba.fsf@alter.siamese.dyndns.org>
 <7vli8hhgmn.fsf@alter.siamese.dyndns.org>
 <20130417063942.GA27703@sigill.intra.peff.net>
 <516EE300.7020200@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ivan Lyapunov <dront78@gmail.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Apr 17 20:02:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USWh5-0001YV-O8
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 20:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936310Ab3DQSCv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Apr 2013 14:02:51 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50122 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753093Ab3DQSCv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 14:02:51 -0400
Received: (qmail 2752 invoked by uid 107); 17 Apr 2013 18:04:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 17 Apr 2013 14:04:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Apr 2013 14:02:48 -0400
Content-Disposition: inline
In-Reply-To: <516EE300.7020200@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221558>

On Wed, Apr 17, 2013 at 07:59:28PM +0200, Ren=C3=A9 Scharfe wrote:

> >What about sane_ident_split in builtin/commit.c? It explicitly rejec=
ts a
> >NULL date. The logic in determine_author_info is a little hard to fo=
llow
> >(it assembles the ident line with fmt_ident and then reparses it), b=
ut I
> >believe it should be catching a bogus line from "commit -c", or from
> >GIT_AUTHOR_DATE in the environment.
>=20
> Right, so let's keep the NULLs and fix the individual cases.  A quick
> "git grep -W -e date_begin -e date_end -e tz_begin -e tz_end" reveals
> that there are only the ones we talked about: blame, pretty, commit
> and -- of course -- ident.  And only the first two need fixing.

Yes, that matches the list I came up with in February.

I think we also need to do something about "git cat-file -p", which doe=
s
not use the split_ident_line parser (but has its own problems with the
home-grown parser).

> >As a side note, when determine_author_info sees a bogus ident, it
> >appears to just silently ignore it, which is probably a bad thing.
> >Shouldn't we by complaining?  Or am I mis-reading the code?
>=20
> The code looks complicated, but I just tried it: fmt_ident() dies if
> you give it an invalid date.

It does seem like determine_author_info can be greatly simplified, but =
I
haven't looked all that closely.

-Peff
