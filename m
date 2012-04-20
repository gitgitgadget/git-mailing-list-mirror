From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fixed compilation with Visual Studio by including poll.h
Date: Fri, 20 Apr 2012 13:47:23 -0700
Message-ID: <20120420204722.GD13103@sigill.intra.peff.net>
References: <4F91C8FF.7070402@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Fri Apr 20 22:47:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLKjs-0004M8-Nl
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 22:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280Ab2DTUr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 16:47:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39366
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758Ab2DTUr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 16:47:27 -0400
Received: (qmail 14620 invoked by uid 107); 20 Apr 2012 20:47:36 -0000
Received: from c-67-169-43-61.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.43.61)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 Apr 2012 16:47:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Apr 2012 13:47:23 -0700
Content-Disposition: inline
In-Reply-To: <4F91C8FF.7070402@tu-clausthal.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196023>

On Fri, Apr 20, 2012 at 10:37:19PM +0200, Sven Strickroth wrote:

> upload-archive.c and upload-pack.c use pollfd struct and POLLIN constant
> which are defined in poll.h. However, poll.h is not included.

This should already be included by git-compat-util.h:

  $ grep -C1 poll.h git-compat-util.h
  #ifndef NO_SYS_POLL_H
  #include <sys/poll.h>
  #else
  #include <poll.h>
  #endif

It looks like we will prefer sys/poll.h if it exists. The official XSI
location is "poll.h", but I guess in practice they are equivalent on
most systems if you have both (certainly on Linux, poll.h just includes
sys/poll.h).

Does your environments have a sys/poll.h that exists isn't sufficient to
use poll? Maybe we need to tweak git-compat-util to include both if they
both exist.

-Peff
