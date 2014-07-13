From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/7] move setting of object->type to alloc_* functions
Date: Sun, 13 Jul 2014 02:41:16 -0400
Message-ID: <20140713064116.GA4768@sigill.intra.peff.net>
References: <20140711084141.GA5521@sigill.intra.peff.net>
 <20140711084611.GB5625@sigill.intra.peff.net>
 <53C149B6.7010705@ramsay1.demon.co.uk>
 <20140712180539.GA13806@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Jul 13 08:41:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6DTR-0007hu-71
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 08:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352AbaGMGlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 02:41:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:32918 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751663AbaGMGlS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 02:41:18 -0400
Received: (qmail 30759 invoked by uid 102); 13 Jul 2014 06:41:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 13 Jul 2014 01:41:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Jul 2014 02:41:16 -0400
Content-Disposition: inline
In-Reply-To: <20140712180539.GA13806@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253436>

On Sat, Jul 12, 2014 at 02:05:39PM -0400, Jeff King wrote:

> > I don't particularly like 'flag' here. (not a massive dislike, mind you:)
> > 
> > Perhaps: flag->object_type, type->node_type?
> > Or, if that's too verbose, maybe just: flag->type, type->node?
> 
> Me either, but as you noticed, type was taken. Your suggestions seem
> fine. We could also just do away with the macro as discussed earlier (we
> already do in the commit_node case, anyway...).

Thinking on this more, writing out the definitions is the only sane
thing to do here, now that alloc_commit_node does not use the macro.
Otherwise you are inviting people to modify the macro, but fail to
notice that the commit allocator also needs updating.

Here's a re-roll. The interesting bit is the addition of the second
patch (but the rest needed to be rebased on top).

  [1/8]: alloc.c: remove the alloc_raw_commit_node() function
  [2/8]: alloc: write out allocator definitions
  [3/8]: move setting of object->type to alloc_* functions
  [4/8]: parse_object_buffer: do not set object type
  [5/8]: add object_as_type helper for casting objects
  [6/8]: alloc: factor out commit index
  [7/8]: object_as_type: set commit index
  [8/8]: diff-tree: avoid lookup_unknown_object

-Peff
