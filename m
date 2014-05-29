From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Improve function dir.c:trim_trailing_spaces()
Date: Thu, 29 May 2014 16:13:34 -0400
Message-ID: <20140529201334.GA17355@sigill.intra.peff.net>
References: <1401320757-9360-1-git-send-email-pasha.bolokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Pasha Bolokhov <pasha.bolokhov@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 22:13:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq6ho-0000tg-8f
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 22:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888AbaE2UNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 16:13:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:33679 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755215AbaE2UNg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 16:13:36 -0400
Received: (qmail 19108 invoked by uid 102); 29 May 2014 20:13:36 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 May 2014 15:13:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 May 2014 16:13:34 -0400
Content-Disposition: inline
In-Reply-To: <1401320757-9360-1-git-send-email-pasha.bolokhov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250407>

On Wed, May 28, 2014 at 04:45:57PM -0700, Pasha Bolokhov wrote:

> Move backwards from the end of the string (more efficient for
> lines which do not have trailing spaces or have just a couple).

The original code reads the string from left to right. In theory, that
means we could get away with not calling strlen() at all, over a
right-to-left that must start with a call to strlen().

That being said, I think we already have the length in the calling
function, so you could probably avoid the strlen() altogether, which
makes a right-to-left function more efficient.

However, I doubt it makes that much of a difference in practice, so
unless it's measurable, I would certainly go with the version that is
more readable (and correct, of course).

> Slightly more rare occurrences of 'text  \    ' with a backslash
> in between spaces are handled correctly.

Can you add a test for this?

Also, if you are refactoring this function, I think it makes sense to
check that:

  "foo\\ "

and

  "foo\\\ "

match "foo\" and "foo\ ", respectively (I think they do with your patch,
but it is a tricky case that is not immediately obvious).

-Peff
