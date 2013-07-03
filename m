From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] format-patch handling in-body From headers
Date: Wed, 3 Jul 2013 05:03:52 -0400
Message-ID: <20130703090352.GA20749@sigill.intra.peff.net>
References: <20130703070719.GA17638@sigill.intra.peff.net>
 <7vd2r0ggup.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 11:04:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuIym-0004Qm-LE
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 11:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367Ab3GCJD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 05:03:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:36853 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932285Ab3GCJDz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 05:03:55 -0400
Received: (qmail 2417 invoked by uid 102); 3 Jul 2013 09:05:05 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Jul 2013 04:05:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jul 2013 05:03:52 -0400
Content-Disposition: inline
In-Reply-To: <7vd2r0ggup.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229473>

On Wed, Jul 03, 2013 at 01:58:22AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > However, doing it right is kind of tricky due to rfc822 quoting, rfc2047
> > encoding, and handling non-ascii names correctly. Instead, this patch
> > series takes a different approach: it teaches format-patch to do the
> > transformation itself, so that it can be used by my script along with
> > any other non-send-email workflows that exist (e.g., git-imap-send
> > suffers from the same problem).
> 
> I think the original expectation when format-patch was done was to
> use Sender: to identify you while keeping the author on From:, but
> with the current world order to use in-body header, this addition
> makes sense.

Yeah, I think using "Sender" would simply be too confusing, as most MUAs
show only the "From", and authors of patches do not necessarily know or
care about the mailing of their patch. 

> I wonder if we can lose some code from send-email then?

Potentially, as long as we default to "--from" to turn this feature on
all the time (otherwise we are breaking the existing "format-patch &&
send-email" workflow).

It may also confuse people who mark up the patches on disk before
running send-email. I don't know if people actually change the From
header there or not.

-Peff
