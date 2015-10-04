From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 41/68] init: use strbufs to store paths
Date: Sat, 3 Oct 2015 23:37:13 -0400
Message-ID: <20151004033713.GB20876@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
 <20150924210736.GL30946@sigill.intra.peff.net>
 <CAO2U3QjunOPoAbGSRjAmCwfk-TnoMveXOJhpb351eh1a_3Xp3A@mail.gmail.com>
 <20150930002347.GA23406@sigill.intra.peff.net>
 <560F6E98.8030305@web.de>
 <xmqqtwq73nbj.fsf@gitster.mtv.corp.google.com>
 <561044AD.8010803@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Oct 04 05:37:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zia71-00069H-1E
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 05:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbbJDDhR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Oct 2015 23:37:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:39339 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751096AbbJDDhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 23:37:16 -0400
Received: (qmail 8343 invoked by uid 102); 4 Oct 2015 03:37:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 03 Oct 2015 22:37:16 -0500
Received: (qmail 5160 invoked by uid 107); 4 Oct 2015 03:37:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 03 Oct 2015 23:37:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Oct 2015 23:37:13 -0400
Content-Disposition: inline
In-Reply-To: <561044AD.8010803@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278991>

On Sat, Oct 03, 2015 at 11:12:13PM +0200, Torsten B=C3=B6gershausen wro=
te:

> > Hmph, Peff's quick-fix passed the original "CoNfIg" in &buf directl=
y
> > to probe_utf8_pathname_composition() without changing its signature=
=2E
> True, ( I was thinking that the test did only work on case insensitiv=
e FS).
> We can skip that change.
>=20
> Beside that, I later realized, that a better signature could be:
> +void probe_utf8_pathname_composition(const char *path, size_t len)
>=20
> I can send a proper patch the next days.

That is the original signature, before my sprintf series. I do not mind
leaving that as-is, and simply cleaning up probe_utf8_pathname_composit=
ion
by using a strbuf internally there. Though I have to wonder if it even
needs us to pass _anything_ at that point. It could just call
git_path_buf("config%s", auml_nfd) itself. The whole reason to pass
anything was to let it reuse the buffer the caller had.

-Peff
