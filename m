From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] add '%d' pretty format specifier to show decoration
Date: Wed, 3 Sep 2008 23:51:40 -0400
Message-ID: <20080904035139.GA28123@sigill.intra.peff.net>
References: <alpine.LNX.1.10.0809032036270.32295@pollux> <20080903191217.GA31195@coredump.intra.peff.net> <7v4p4xat3v.fsf@gitster.siamese.dyndns.org> <20080903203616.GB32223@coredump.intra.peff.net> <7vsksh9c9m.fsf@gitster.siamese.dyndns.org> <48BF0A5A.2040502@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Dressel <MichaelTiloDressel@t-online.de>,
	git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Sep 04 05:52:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb5ts-0000KD-Ao
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 05:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709AbYIDDvp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Sep 2008 23:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753688AbYIDDvp
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 23:51:45 -0400
Received: from peff.net ([208.65.91.99]:4873 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753641AbYIDDvp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 23:51:45 -0400
Received: (qmail 5632 invoked by uid 111); 4 Sep 2008 03:51:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 03 Sep 2008 23:51:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Sep 2008 23:51:40 -0400
Content-Disposition: inline
In-Reply-To: <48BF0A5A.2040502@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94886>

On Thu, Sep 04, 2008 at 12:06:18AM +0200, Ren=C3=A9 Scharfe wrote:

> The patch below does that by using a static variable to remember if t=
he
> decorations have already been loaded.  That's not too unreasonable, I
> think, because we currently have no way of unloading them.

Yes, I think lazy loading is a good solution here, since there is no
extra context that needs to be known to load the decorations.

> +	case 'd':
> +		if (add_again(sb, &c->decoration))
> +			return 1;
> +		format_decoration(sb, commit);
> +		c->decoration.len =3D sb->len - c->decoration.off;
> +		return 1;

The add_again chunk code is for things that take a long time (like
finding the shortest abbreviation for some hashes). I'm not sure this
counts as "long", as it is just doing a hash lookup on the decoration.
On the other hand, I doubt the extra couple of bytes used hurts much.

-Peff
