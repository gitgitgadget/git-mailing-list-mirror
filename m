From: Jeff King <peff@peff.net>
Subject: Re: Re* diff: --quiet does not imply --exit-code if --diff-filter is
 present
Date: Tue, 31 May 2011 13:14:01 -0400
Message-ID: <20110531171401.GA12466@sigill.intra.peff.net>
References: <87wrh7jgzk.wl@dns1.atmark-techno.com>
 <20110531153356.GB2594@sigill.intra.peff.net>
 <7vvcwqkh4a.fsf@alter.siamese.dyndns.org>
 <20110531162546.GA11321@sigill.intra.peff.net>
 <7vd3iykdej.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yasushi SHOJI <yashi@atmark-techno.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 31 19:14:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRSWB-0007Dl-4J
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 19:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757679Ab1EaROF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 13:14:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45097
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756285Ab1EaROE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 13:14:04 -0400
Received: (qmail 28048 invoked by uid 107); 31 May 2011 17:14:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 31 May 2011 13:14:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 May 2011 13:14:01 -0400
Content-Disposition: inline
In-Reply-To: <7vd3iykdej.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174814>

On Tue, May 31, 2011 at 10:06:44AM -0700, Junio C Hamano wrote:

> Add "exiting_early" field to unpack_trees_options structure, to signal the
> unpack_trees() machinery that the negative return value is not signaling
> an error but an early return from the unpack_trees() machinery. As this by
> definition hasn't unpacked everything, discard the resulting index just
> like the failure codepath.

Maybe it is just me, but I would think that it's a little more intuitive
to set exiting_early and then return "0" to indicate "success, but I
didn't look at everything".

I guess you did it this way to better share the discard-the-result
codepath. Maybe it wouldn't be too painful to refactor unpack_failed()
into the failed bits plus a call to a new unpack_discard() that does the
non-error bits. It may not be worth the trouble though.

-Peff
