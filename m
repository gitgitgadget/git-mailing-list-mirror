From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Don't search files with an unset "grep" attribute
Date: Wed, 1 Feb 2012 17:14:37 -0500
Message-ID: <20120201221437.GA19044@sigill.intra.peff.net>
References: <7vy5sy8e0y.fsf@alter.siamese.dyndns.org>
 <1327359555-29457-1-git-send-email-conrad.irwin@gmail.com>
 <7vaa5d4mce.fsf@alter.siamese.dyndns.org>
 <20120125214625.GA4666@sigill.intra.peff.net>
 <7vhazb3rtm.fsf@alter.siamese.dyndns.org>
 <20120201082005.GA32348@sigill.intra.peff.net>
 <20120201091009.GA20984@sigill.intra.peff.net>
 <CAOTq_ptj06aNGsQRjV0fVRxnQFBHmU2FFSXwWDUUk9MM77k2LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: =?utf-8?Q?Conrad=C2=A0Irwin?= <conrad.irwin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 23:14:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsiRx-0005bR-O0
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 23:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756255Ab2BAWOl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 17:14:41 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52443
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755417Ab2BAWOk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 17:14:40 -0500
Received: (qmail 13810 invoked by uid 107); 1 Feb 2012 22:21:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Feb 2012 17:21:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Feb 2012 17:14:37 -0500
Content-Disposition: inline
In-Reply-To: <CAOTq_ptj06aNGsQRjV0fVRxnQFBHmU2FFSXwWDUUk9MM77k2LQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189545>

On Wed, Feb 01, 2012 at 01:28:47AM -0800, Conrad=C2=A0Irwin wrote:

> > But there's more. Respecting binary attributes does mean looking up
> > attributes for _every_ file. And that has a noticeable impact. My
> > best-of-five for "git grep foo" on linux-2.6 went from 0.302s to 0.=
392s.
> > Yuck.
>=20
> The first time I introduced this behaviour[1], I made it conditional
> on a preference =E2=80=94 those who wanted "good" grep could set the
> preference, while those who wanted "fast" grep could not. I think
> that's not a good idea, though if the performance issues are
> show-stoppers, I'd suggest the opposite preference (so speed-freaks
> can disable the checks).

I've been able to get somewhat better performance by hoisting the
attribute lookup into the parent thread. That means it happens in order
(which lets the attr code's stack optimizations work), and there's no
lock contention.

I'll post finished patches with numbers in a few minutes.

> Tests from [1] included below in case they're still useful (they pass
> with your change)

Thanks, I'll include them.

-Peff
