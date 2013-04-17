From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] blame: handle broken commit headers gracefully
Date: Wed, 17 Apr 2013 17:07:13 -0400
Message-ID: <20130417210713.GB635@sigill.intra.peff.net>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com>
 <516D93C4.1000100@lsrfire.ath.cx>
 <7v61zml0ow.fsf@alter.siamese.dyndns.org>
 <516DBE2E.4060201@lsrfire.ath.cx>
 <7vzjwyi0ba.fsf@alter.siamese.dyndns.org>
 <7vli8hhgmn.fsf@alter.siamese.dyndns.org>
 <20130417063942.GA27703@sigill.intra.peff.net>
 <516EE300.7020200@lsrfire.ath.cx>
 <516EEB12.5050209@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ivan Lyapunov <dront78@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Apr 17 23:07:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USZZZ-0004Wb-ER
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 23:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965571Ab3DQVHR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Apr 2013 17:07:17 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50294 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756067Ab3DQVHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 17:07:16 -0400
Received: (qmail 4712 invoked by uid 107); 17 Apr 2013 21:09:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 17 Apr 2013 17:09:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Apr 2013 17:07:13 -0400
Content-Disposition: inline
In-Reply-To: <516EEB12.5050209@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221572>

On Wed, Apr 17, 2013 at 08:33:54PM +0200, Ren=C3=A9 Scharfe wrote:

> Minimal patch, test case missing.  It's a bit sad that the old commit
> parser of blame handled Ivan's specific corruption (extra "-<>" after
> email) gracefully because it used the spaces as cutting points instea=
d
> of "<" and ">".

That may mean there is room for improvement in split_ident_line to
be more resilient in removing cruft. With something like:

  Name <email@host>-<> 123456789 -0000

it would obviously be nice to find the date timestamp there, but I
wonder what the "email" field should return? The full broken string, or
just "email@host"? One way is convenient for overlooking problems in
broken commits, but I would worry about code paths that are using
split_ident_line to verify the quality of the string (like
determine_author_info). It's possible we would need a strict and a
forgiving mode.

-Peff
