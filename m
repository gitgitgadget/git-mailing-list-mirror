From: Jeff King <peff@peff.net>
Subject: [PATCHv2 0/6] duplicate objects and delta cycles, oh my!
Date: Thu, 22 Aug 2013 19:12:15 -0400
Message-ID: <20130822231215.GA16978@sigill.intra.peff.net>
References: <20130821204955.GA28025@sigill.intra.peff.net>
 <20130821205220.GB28165@sigill.intra.peff.net>
 <CACsJy8DkUeS3s+X=gKX4ZAi82g_D_9t=bBVs8NNY2EeqM9W-rQ@mail.gmail.com>
 <20130822144305.GA21219@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 23 01:12:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCe3D-0005P9-Vj
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 01:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456Ab3HVXMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 19:12:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:59989 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753963Ab3HVXMT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 19:12:19 -0400
Received: (qmail 23692 invoked by uid 102); 22 Aug 2013 23:12:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Aug 2013 18:12:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Aug 2013 19:12:15 -0400
Content-Disposition: inline
In-Reply-To: <20130822144305.GA21219@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232785>

On Thu, Aug 22, 2013 at 10:43:05AM -0400, Jeff King wrote:

> > write_idx_file() is called after index-pack processes all delta
> > objects. Could resolve_deltas() go cyclic with certain duplicate
> > object setup?
> 
> Good question. I'm not sure. I'll check it out.

I think the answer is "no", based on both reasoning and testing (both of
which are included in patches 3-4 of the series below).

So here's my re-roll of the series.

  [1/6]: test-sha1: add a binary output mode

    New in this iteration; the previous version piped test-sha1 into
    perl to create the pack trailer, but with this simple change we can
    drop the perl dependency.

  [2/6]: sha1-lookup: handle duplicate keys with GIT_USE_LOOKUP

    Same code as before. I've factored the pack-creation bits from the
    tests into lib-pack.sh, so they can be reused elsewhere when we want
    to create bogus packs (and patches 3-4 reuse them here).

  [3/6]: add tests for indexing packs with delta cycles
  [4/6]: test index-pack on packs with recoverable delta cycles

    New tests covering delta cycles.

  [5/6]: index-pack: optionally reject packs with duplicate objects

    Similar to before, but I converted the config flag to a simple
    boolean (since we scrapped the "fix" of the tri-state "allow,
    reject, fix").

  [6/6]: default pack.indexDuplicates to false

    This flips the safety check on by default everywhere (before, it was
    left off for index-pack).

-Peff
