From: Jeff King <peff@peff.net>
Subject: Re: What happens when the repository is bigger than gc.autopacklimit
 * pack.packSizeLimit?
Date: Wed, 27 Aug 2014 15:47:46 -0400
Message-ID: <20140827194746.GE7561@peff.net>
References: <201408271936.s7RJarOh011358@hobgoblin.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 27 21:47:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMjCD-0006xc-9u
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 21:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbaH0Trt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 15:47:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:60305 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S935594AbaH0Trs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 15:47:48 -0400
Received: (qmail 19502 invoked by uid 102); 27 Aug 2014 19:47:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Aug 2014 14:47:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2014 15:47:46 -0400
Content-Disposition: inline
In-Reply-To: <201408271936.s7RJarOh011358@hobgoblin.ariadne.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256033>

On Wed, Aug 27, 2014 at 03:36:53PM -0400, Dale R. Worley wrote:

> And it appears from an experiment that this is what happens.  I have a
> repository with pack.packSizeLimit = 99m, and there are 104 pack
> files, and even when "git gc" is done, if I do "git gc --auto", it
> will do git-repack again.

I agree that "gc --auto" could be smarter here, but I have to wonder:
why are you setting the packsize limit to 99m in the first place? It is
generally much more efficient to place everything in a single pack.
There are more delta opportunities, fewer base objects, lookup is faster
(we binary search each pack index, but linearly move through the list of
indices), and it is required for advanced techniques like bitmaps.

-Peff
