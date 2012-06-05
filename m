From: Jeff King <peff@peff.net>
Subject: Re: [RFC 4/4] Add cat-blob report pipe from fast-import to
 remote-helper.
Date: Tue, 5 Jun 2012 04:14:02 -0400
Message-ID: <20120605081402.GF25809@sigill.intra.peff.net>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1338830455-3091-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1338830455-3091-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1338830455-3091-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1338830455-3091-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <20120605065628.GA25809@sigill.intra.peff.net>
 <CAFfmPPP1koMnYBFbgHt0MGr77okjL5OdAh-TMxFTevj+mDbOZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: David Michael Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 10:14:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbou9-0002yo-LP
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 10:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757903Ab2FEIOL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jun 2012 04:14:11 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:43135
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756595Ab2FEIOF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 04:14:05 -0400
Received: (qmail 14907 invoked by uid 107); 5 Jun 2012 08:14:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Jun 2012 04:14:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jun 2012 04:14:02 -0400
Content-Disposition: inline
In-Reply-To: <CAFfmPPP1koMnYBFbgHt0MGr77okjL5OdAh-TMxFTevj+mDbOZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199215>

On Tue, Jun 05, 2012 at 05:07:53PM +1000, David Michael Barr wrote:

> On Tue, Jun 5, 2012 at 4:56 PM, Jeff King <peff@peff.net> wrote:
> > On Mon, Jun 04, 2012 at 07:20:55PM +0200, Florian Achleitner wrote:
> >> @@ -427,6 +469,11 @@ static int fetch_with_import(struct transport=
 *transport,
> >> =C2=A0 =C2=A0 =C2=A0 if (get_importer(transport, &fastimport))
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("Couldn't run=
 fast-import");
> >>
> >> +
> >> + =C2=A0 =C2=A0 /* in the parent process we close both pipe ends. =
*/
> >> + =C2=A0 =C2=A0 close(data->fast_import_backchannel_pipe[0]);
> >> + =C2=A0 =C2=A0 close(data->fast_import_backchannel_pipe[1]);
> >
> > I'm confused. We close both ends? Who is actually reading and writi=
ng to
> > this pipe, then?
>=20
> One child, git-fast-import writes to one end.
> The other child, git-remote-* reads from the other end.

Ah, thanks. I missed where the write end was going, but now I see it.
Overall, the point of the patch makes sense to me (it would have been
nice if the commit message described the rationale a bit more
completely).

Is there a reason that the patch unconditionally creates the pipe in
get_helper? I.e., isn't it specific to the get_importer code path? It
feels a little hacky to have it infect the other code paths.

-Peff
