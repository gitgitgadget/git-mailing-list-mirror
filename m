From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] Makefile: use `find` to determine static header
 dependencies
Date: Mon, 25 Aug 2014 16:09:39 -0400
Message-ID: <20140825200939.GK30953@peff.net>
References: <20140822042716.GE27992@peff.net>
 <20140822043303.GB18192@peff.net>
 <20140825194641.GS20185@google.com>
 <20140825200042.GJ30953@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 22:09:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XM0aH-0008Ao-BZ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 22:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756555AbaHYUJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 16:09:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:58678 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754940AbaHYUJl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 16:09:41 -0400
Received: (qmail 1464 invoked by uid 102); 25 Aug 2014 20:09:41 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Aug 2014 15:09:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Aug 2014 16:09:39 -0400
Content-Disposition: inline
In-Reply-To: <20140825200042.GJ30953@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255861>

On Mon, Aug 25, 2014 at 04:00:42PM -0400, Jeff King wrote:

> On Mon, Aug 25, 2014 at 12:46:41PM -0700, Jonathan Nieder wrote:
> 
> > Jeff King wrote:
> > 
> > > -LOCALIZED_C := $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
> > > +LOCALIZED_C = $(C_OBJ:o=c) $(GENERATED_H)
> > 
> > Why is LIB_H dropped here?  This would mean that po/git.pot stops
> > including strings from macros and static inline functions in headers
> > (e.g., in parse-options.h).
> 
> Ick, this is an accidental leftover from the earlier iteration of the
> patch, which moved that part to a separate line (inside my gross
> GIT_REAL_POT conditional). The extra line went away, but I forgot to add
> $(LIB_H) back in here. Thanks for noticing.

As an aside, this makes an interesting case study for our git.git
workflow.

In some workflows, I would have made the original unacceptable patch,
you would have reviewed it, and then I would have made the followup
patch to adjust it, and you would have reviewed that. But it's quite
hard to see my mistake in just the followup patch; the fact that
$(LIB_H) was originally part of $(LOCALIZED_C) does not appear in that
hunk at all.

But in our workflow, we squash out the unacceptable diff, and you review
from scratch the movement from the original working state (assuming the
status quo was working :) ) to the newly proposed state. And there the
mistake is quite a bit more obvious.

Just an interesting observation.

-Peff
