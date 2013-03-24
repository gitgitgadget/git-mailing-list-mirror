From: Jeff King <peff@peff.net>
Subject: Re: propagating repo corruption across clone
Date: Sun, 24 Mar 2013 15:23:50 -0400
Message-ID: <20130324192350.GA20688@sigill.intra.peff.net>
References: <20130324183133.GA11200@sigill.intra.peff.net>
 <CACBZZX6czzJRF9TEsc8c+=LND6SxaVvrZdbcZ+TfUZTWQOpW0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 20:24:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJqWs-000605-SX
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 20:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577Ab3CXTXx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Mar 2013 15:23:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38119 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754556Ab3CXTXw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 15:23:52 -0400
Received: (qmail 18735 invoked by uid 107); 24 Mar 2013 19:25:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 24 Mar 2013 15:25:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Mar 2013 15:23:50 -0400
Content-Disposition: inline
In-Reply-To: <CACBZZX6czzJRF9TEsc8c+=LND6SxaVvrZdbcZ+TfUZTWQOpW0Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218966>

On Sun, Mar 24, 2013 at 08:01:33PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> On Sun, Mar 24, 2013 at 7:31 PM, Jeff King <peff@peff.net> wrote:
> >
> > I don't have details on the KDE corruption, or why it wasn't detect=
ed
> > (if it was one of the cases I mentioned above, or a more subtle iss=
ue).
>=20
> One thing worth mentioning is this part of the article:
>=20
> "Originally, mirrored clones were in fact not used, but non-mirrored
> clones on the anongits come with their own set of issues, and are mor=
e
> prone to getting stopped up by legitimate, authenticated force pushes=
,
> ref deletions, and so on =E2=80=93 and if we set the refspec such tha=
t those
> are allowed through silently, we don=E2=80=99t gain much. "
>=20
> So the only reason they were even using --mirror was because they wer=
e
> running into those problems with fetching.

I think the --mirror thing is a red herring. It should not be changing
the transport used, and that is the part of git that is expected to
catch such corruption.

But I haven't seen exactly what the corruption is, nor exactly what
commands they used to clone. I've invited the blog author to give more
details in this thread.

> So aside from the problems with --mirror I think we should have
> something that updates your local refs to be exactly like they are on
> the other end, i.e. deletes some, non-fast-forwards others etc.
> (obviously behind several --force options and so on). But such an
> option *wouldn't* accept corrupted objects.

That _should_ be how "git fetch --prune +refs/*:refs/*" behaves (and
that refspec is set up when you use "--mirror"; we should probably have
it turn on --prune, too, but I do not think you can do so via a config
option currently).

-Peff
