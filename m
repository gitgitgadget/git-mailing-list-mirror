From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] branch: don't assume the merge filter ref exists
Date: Mon, 27 Feb 2012 14:30:44 -0500
Message-ID: <20120227193044.GD1600@sigill.intra.peff.net>
References: <20120227122609.GA26981@mx.loc>
 <1330355513-22351-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Mon Feb 27 20:30:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S26Ha-0001Zv-PC
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 20:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121Ab2B0Taq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 14:30:46 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58947
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753996Ab2B0Taq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 14:30:46 -0500
Received: (qmail 29779 invoked by uid 107); 27 Feb 2012 19:30:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Feb 2012 14:30:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2012 14:30:44 -0500
Content-Disposition: inline
In-Reply-To: <1330355513-22351-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191657>

On Mon, Feb 27, 2012 at 04:11:53PM +0100, Carlos Mart=C3=ADn Nieto wrot=
e:

> print_ref_list looks up the merge_filter_ref and assumes that a valid
> pointer is returned. When the object doesn't exist, it tries to
> dereference a NULL pointer. This can be the case when git branch
> --merged is given an argument that isn't a valid commit name.
>=20
> Check whether the lookup returns a NULL pointer and die with an error
> if it does. Add a test, while we're at it.
>=20
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
> ---
>=20
> It certainly looks like --merged was only ever supposed to be used
> with branch names, as it assumed that get_sha1() would catch the
> errors.
>=20
> I'm not sure if "bad object" or "invalid object" fits better. "bad
> object" might have a stronger implication that it exists but is
> corrupt.

You would also get NULL if the object exists but is not a commit. Maybe=
:

  die("object '%s' does not point to a commit", ...)

would be better? It covers the wrong-type case, and is still technicall=
y
true when the object does not exist.

-Peff
