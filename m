From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 02/22] try_merge_strategy(): remove redundant lock_file
 allocation
Date: Tue, 1 Apr 2014 15:56:15 -0400
Message-ID: <20140401195615.GB21715@sigill.intra.peff.net>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
 <1396367910-7299-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 01 21:56:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV4nF-0004Mq-Qk
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 21:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbaDAT4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 15:56:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:52014 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751371AbaDAT4R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 15:56:17 -0400
Received: (qmail 20832 invoked by uid 102); 1 Apr 2014 19:56:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Apr 2014 14:56:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Apr 2014 15:56:15 -0400
Content-Disposition: inline
In-Reply-To: <1396367910-7299-3-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245646>

On Tue, Apr 01, 2014 at 05:58:10PM +0200, Michael Haggerty wrote:

> By the time the "if" block is entered, the lock_file instance from the
> main function block is no longer in use, so re-use that one instead of
> allocating a second one.
> 
> Note that the "lock" variable in the "if" block used to shadow the
> "lock" variable at function scope, so the only change needed is to
> remove the inner definition.

I wonder if this would also be simpler if "lock" were simply declared as
a static variable, and we drop the allocation entirely. I suppose that
does create more cognitive load, though, in that it is only correct if
the function is not recursive. On the other hand, the current code makes
a reader unfamiliar with "struct lock" wonder if there is a free(lock)
missing.

-Peff
