From: Jeff King <peff@peff.net>
Subject: Re: Funnies with "git fetch"
Date: Fri, 2 Sep 2011 01:03:59 -0400
Message-ID: <20110902050359.GB11678@sigill.intra.peff.net>
References: <7vpqjkw3nb.fsf@alter.siamese.dyndns.org>
 <7vpqjjnau1.fsf@alter.siamese.dyndns.org>
 <20110901233108.GA9339@sigill.intra.peff.net>
 <7vippbmygy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 02 07:04:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzLvI-0006t9-1t
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 07:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287Ab1IBFEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 01:04:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59854
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904Ab1IBFED (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 01:04:03 -0400
Received: (qmail 27944 invoked by uid 107); 2 Sep 2011 05:04:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Sep 2011 01:04:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Sep 2011 01:03:59 -0400
Content-Disposition: inline
In-Reply-To: <7vippbmygy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180596>

On Thu, Sep 01, 2011 at 08:09:49PM -0700, Junio C Hamano wrote:

> You may be slightly misunderstanding the series.
> [...]
> The current code does not try to make sure we really have the objects
> necessary to connect the updated tips to our original refs at all.  Not
> just blobs but neither commits nor trees are traversed. The new check in
> store_updated_refs() is about that. So in that sense, the series is not
> about "just blobs".

Ah, OK, I see. I was too focused on pulling the bits out of quickfetch
into check_everything_connected, and missed the important new call in
store_updated_refs.

So what you are doing makes sense to me. I am curious, though, what the
performance impact is like. In particular, it seems that we will pull
each blob into memory via parse_object. Until now, we were mostly
streaming the blobs straight into packs. That makes me a little nervous
given the discussions recently about large blobs, and not accessing them
unnecessarily. But maybe that is a silly concern, as we will have just
reconstructed and hashed such an object anyway to get its name.

-Peff
