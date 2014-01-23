From: Jeff King <peff@peff.net>
Subject: [PATCH v2 0/3] unaligned reads from .bitmap files
Date: Thu, 23 Jan 2014 16:20:36 -0500
Message-ID: <20140123212036.GA21299@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
 <20131221135953.GH21145@sigill.intra.peff.net>
 <20140123020536.GP18964@google.com>
 <20140123183320.GA22995@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 22:20:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6Rhb-0000ya-5v
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 22:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088AbaAWVUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 16:20:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:37786 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752862AbaAWVUi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 16:20:38 -0500
Received: (qmail 922 invoked by uid 102); 23 Jan 2014 21:20:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jan 2014 15:20:38 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jan 2014 16:20:36 -0500
Content-Disposition: inline
In-Reply-To: <20140123183320.GA22995@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240956>

On Thu, Jan 23, 2014 at 01:33:20PM -0500, Jeff King wrote:

> Here's a patch series (on top of jk/pack-bitmap, naturally) that lets
> t5310 pass there. I assume the ARM problem is the same, though seeing
> the failure in realloc() is unexpected. Can you try it on both your
> platforms with these patches?
> 
>   [1/2]: compat: move unaligned helpers to bswap.h
>   [2/2]: ewah: support platforms that require aligned reads

Here it is again, fixing the issues we've discussed.

Instead of building on the code in read-cache, it pulls the much more
battle-tested code from block-sha1, and refactors read-cache to use that
instead. So the fix now kicks in automatically, and in theory it is a
slight bit faster (though I still doubt it would even be measurable in
this case).

  [1/3]: block-sha1: factor out get_be and put_be wrappers
  [2/3]: read-cache: use get_be32 instead of hand-rolled ntoh_l
  [3/3]: ewah: support platforms that require aligned reads

-Peff
