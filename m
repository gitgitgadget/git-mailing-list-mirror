From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] xdiff: implement a zealous diff3
Date: Wed, 6 Mar 2013 15:46:12 -0500
Message-ID: <20130306204612.GA24535@sigill.intra.peff.net>
References: <20130306200347.GA20312@sigill.intra.peff.net>
 <1362602202-29749-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kernel@pengutronix.de,
	Antoine Pelisse <apelisse@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Mar 06 21:46:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDLEX-000435-6i
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 21:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852Ab3CFUqP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Mar 2013 15:46:15 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38360 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753554Ab3CFUqO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 15:46:14 -0500
Received: (qmail 29557 invoked by uid 107); 6 Mar 2013 20:47:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Mar 2013 15:47:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Mar 2013 15:46:12 -0500
Content-Disposition: inline
In-Reply-To: <1362602202-29749-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217543>

On Wed, Mar 06, 2013 at 09:36:42PM +0100, Uwe Kleine-K=C3=B6nig wrote:

> "zdiff3" is identical to ordinary diff3, only it allows more aggressi=
ve
> compaction than diff3. This way the displayed base isn't necessary
> technically correct, but still this mode might help resolving merge
> conflicts between two near identical additions.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

I think the patch is correct, assuming this is the interface we want.

It would be more flexible instead to have:

  1. user can configure zealous-level of merge via command-line or
     config (they cannot control it at all right now)

  2. when diff3 is used and no level is explicitly given, do not go
     above EAGER

  3. otherwise, respect the level given by the user, even if it is
     ZEALOUS

But that would involve a lot of refactoring. I don't know if it is wort=
h
the effort (the bonus is that people can then set the level
independently, but I do not know that anyone ever wants to do that).

>  builtin/merge-file.c                   | 2 ++
>  contrib/completion/git-completion.bash | 2 +-
>  xdiff-interface.c                      | 2 ++
>  xdiff/xdiff.h                          | 1 +
>  xdiff/xmerge.c                         | 8 +++++++-
>  5 files changed, 13 insertions(+), 2 deletions(-)

I think this would need documentation not only to let users know about
the feature, but also to warn them of the caveats.

-Peff
