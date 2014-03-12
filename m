From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] general style: replaces memcmp() with starts_with()
Date: Wed, 12 Mar 2014 14:00:26 -0400
Message-ID: <20140312180026.GB7982@sigill.intra.peff.net>
References: <1394631854-11208-1-git-send-email-quintus.public@gmail.com>
 <5320818C.8070200@web.de>
 <CALs4jVFpr=YVAagJSEkAJ6qGJmYWNdu4ZXXvMYQRd0KYQXcVQA@mail.gmail.com>
 <532097D0.4070909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Quint Guvernator <quintus.public@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 12 19:00:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNnSC-0001QC-S4
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 19:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755871AbaCLSA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 14:00:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:38197 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755566AbaCLSA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 14:00:28 -0400
Received: (qmail 24122 invoked by uid 102); 12 Mar 2014 18:00:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Mar 2014 13:00:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2014 14:00:26 -0400
Content-Disposition: inline
In-Reply-To: <532097D0.4070909@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243950>

On Wed, Mar 12, 2014 at 06:22:24PM +0100, Jens Lehmann wrote:

> > Let me know if you still think the hunk should be dropped there.
> 
> Yes, I think so. That spot uses memcmp() because ce->name may
> not be 0-terminated. If that assumption isn't correct, it should
> be replaced with a plain strcmp() instead (while also dropping
> the ce_namelen() comparison in the line above). But starts_with()
> points into the wrong direction there.

I think the length-check and memcmp is an optimization[1] here. But we
should be able to encapsulate that pattern and avoid magic numbers
entirely with something like mem_equals(). See my other response for
more details.

-Peff

[1] Getting rid of the magic number entirely means we have to call
    strlen(".gitmodules"), which seems like it is working against this
    optimization. But I think past experiments have shown that decent
    compilers will optimize strlen on a string literal to a constant, so
    as long as mem_equals is an inline, it should be equivalent.
