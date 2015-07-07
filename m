From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Change strbuf_read_file() to return ssize_t
Date: Tue, 7 Jul 2015 10:33:50 -0400
Message-ID: <20150707143350.GB629@peff.net>
References: <74f6ccbe74486b1d5589e953c4cf6d39c82c5c05.1435931485.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 07 16:34:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTwo-000377-Cd
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757455AbbGGOd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:33:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:56874 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757436AbbGGOdy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:33:54 -0400
Received: (qmail 24400 invoked by uid 102); 7 Jul 2015 14:33:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jul 2015 09:33:53 -0500
Received: (qmail 9660 invoked by uid 107); 7 Jul 2015 14:34:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jul 2015 10:34:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jul 2015 10:33:50 -0400
Content-Disposition: inline
In-Reply-To: <74f6ccbe74486b1d5589e953c4cf6d39c82c5c05.1435931485.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273566>

On Fri, Jul 03, 2015 at 03:59:32PM +0200, Michael Haggerty wrote:

> It is currently declared to return int, which could overflow for large
> files.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> This patch is against maint, but it also rebases against master
> without conflict.
> 
> I couldn't find any way to exploit this bug. Most callers only use
> this function for locally-generated files in the first place. And the
> correct length of the file is available in strbuf::len, so most
> callers only use the return value for a "< 0" check. And they don't do
> anything risky on the error path.

FWIW, I also looked for problem areas, but couldn't find anything
interesting. But this seems like an obviously good thing to be doing
anyway.

I also wondered if any callers needed to adjust their storage for the
return type to ssize_t (i.e., are we just moving the truncation up one
assignment). But there is only a single caller that assigns the result,
and it uses an ssize_t already.

-Peff
