From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/7] refactor argv_array into generic code
Date: Wed, 14 Sep 2011 19:18:04 -0400
Message-ID: <20110914231804.GB5611@sigill.intra.peff.net>
References: <20110913215026.GA26743@sigill.intra.peff.net>
 <20110913215757.GC24490@sigill.intra.peff.net>
 <CAP8UFD1vxP9ABgJpM99hxDWWLeGO_QW7QLVFq1f-teu1fiCftA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 01:18:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3yib-0007ni-9s
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 01:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178Ab1INXSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 19:18:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37952
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945Ab1INXSG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 19:18:06 -0400
Received: (qmail 15380 invoked by uid 107); 14 Sep 2011 23:18:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Sep 2011 19:18:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2011 19:18:04 -0400
Content-Disposition: inline
In-Reply-To: <CAP8UFD1vxP9ABgJpM99hxDWWLeGO_QW7QLVFq1f-teu1fiCftA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181409>

On Wed, Sep 14, 2011 at 07:54:48AM +0200, Christian Couder wrote:

> In sha1-array you called the "push" function "sha1_array_append"
> instead of "sha1_array_push", so I wonder why here you call them
> "*_push*" instead of "*_append*"?

I dunno. It just seemed natural to write "push" in the context of argv.
Maybe too much perl (push, pop, shift, unshift).

argv_array_append does make sense. One could argue that
sha1_array_append actually doesn't. True, it does append to the end of
the array, but after writing the docs for it yesterday, I realized that
it less of an array, and more of a set container. Because the point of
using it is the optimized lookup/unique function, which is going to sort
it. The array is really just an implementation detail.

So arguably it should be "struct sha1_set", and "sha1_set_insert" or
something. I'm not sure if it's really worth changing (because this is
C, our data structures tend to be a little leaky, anyway, and you _can_
use sha1_array as an ordered list if you want; just don't call the
lookup or sorting functions).

-Peff
