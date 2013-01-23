From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] push: further clean up fields of "struct ref"
Date: Wed, 23 Jan 2013 01:43:58 -0500
Message-ID: <20130123064357.GA10306@sigill.intra.peff.net>
References: <20130121234002.GE17156@sigill.intra.peff.net>
 <1358836230-9197-1-git-send-email-gitster@pobox.com>
 <1358836230-9197-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Chris Rorvick <chris@rorvick.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 07:44:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txu4R-0000KT-6V
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 07:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150Ab3AWGoC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 01:44:02 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44646 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753550Ab3AWGoB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 01:44:01 -0500
Received: (qmail 1558 invoked by uid 107); 23 Jan 2013 06:45:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Jan 2013 01:45:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Jan 2013 01:43:58 -0500
Content-Disposition: inline
In-Reply-To: <1358836230-9197-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214290>

On Mon, Jan 21, 2013 at 10:30:28PM -0800, Junio C Hamano wrote:

> The "nonfastforward" and "update" fields are only used while
> deciding what value to assign to the "status" locally in a single
> function.  Remove them from the "struct ref".
> 
> The "requires_force" field is not used to decide if the proposed
> update requires a --force option to succeed, or to record such a
> decision made elsewhere.  It is used by status reporting code that
> the particular update was "forced".  Rename it to "forced_udpate",

Typo.

> and move the code to assign to it around to further clarify how it
> is used and what it is used for.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * The "update" removal in v1 has been moved to this.
> 
>  cache.h     |  4 +---
>  remote.c    | 16 ++++++----------
>  transport.c |  2 +-
>  3 files changed, 8 insertions(+), 14 deletions(-)

Looks much better.

I wondered briefly why nonfastforward was even there, as I recall that I
was the one who added it many years ago. It turns out that it used to
serve the purpose of the new forced_update, but Chris's series from a
few months ago split it out to "nonfastforward" and "not_forwardable",
and then added "requires_force" to give a single flag that is set in
either case.

So I think your simplification is correct; the first two can be local
variables, and the only thing that matters to carry forward is
requires_force (and I agree that forced_update is a better name).

-Peff
