From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/22] rollback_lock_file(): set fd to -1
Date: Tue, 1 Apr 2014 15:59:30 -0400
Message-ID: <20140401195930.GC21715@sigill.intra.peff.net>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
 <1396367910-7299-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 01 21:59:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV4qR-0005k4-SO
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 21:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbaDAT7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 15:59:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:52019 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751247AbaDAT7c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 15:59:32 -0400
Received: (qmail 20988 invoked by uid 102); 1 Apr 2014 19:59:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Apr 2014 14:59:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Apr 2014 15:59:30 -0400
Content-Disposition: inline
In-Reply-To: <1396367910-7299-5-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245647>

On Tue, Apr 01, 2014 at 05:58:12PM +0200, Michael Haggerty wrote:

> When rolling back the lockfile, call close_lock_file() so that the
> lock_file's fd field gets set back to -1.  This could help prevent
> confusion in the face of hypothetical future programming errors.

This also solves a race. We could be in the middle of rollback_lock_file
when we get a signal, and double-close. It's probably not a big deal,
though, since nobody could have opened a new descriptor in the interim
that got the same number (so the second close will just fail silently).

Still, this seems like a definite improvement.

-Peff
