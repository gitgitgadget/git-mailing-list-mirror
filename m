From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] run-command: Be more informative about what failed
Date: Thu, 31 Jan 2013 17:35:59 -0500
Message-ID: <20130131223559.GC21729@sigill.intra.peff.net>
References: <1359597666-10108-1-git-send-email-sboyd@codeaurora.org>
 <1359597666-10108-3-git-send-email-sboyd@codeaurora.org>
 <7vfw1hiami.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephen Boyd <sboyd@codeaurora.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 23:36:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U12kO-0006O6-JH
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 23:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931Ab3AaWgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 17:36:04 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54979 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755518Ab3AaWgD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 17:36:03 -0500
Received: (qmail 15608 invoked by uid 107); 31 Jan 2013 22:37:26 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Jan 2013 17:37:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jan 2013 17:35:59 -0500
Content-Disposition: inline
In-Reply-To: <7vfw1hiami.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215179>

On Thu, Jan 31, 2013 at 08:24:21AM -0800, Junio C Hamano wrote:

> Stephen Boyd <sboyd@codeaurora.org> writes:
> 
> > While debugging an error with verify_signed_buffer() the error
> > messages from run-command weren't very useful:
> >
> >  error: cannot create pipe for gpg: Too many open files
> >  error: could not run gpg.
> >
> > because they didn't indicate *which* pipe couldn't be created.
> 
> For the message emitted here with your update (or without for that
> matter) to be useful, it has to hold that there is a single leaker,
> that leaker fails in this codepath, and that there is nobody else
> involved.  Otherwise, you may be able to tell that one caller could
> not create its stdin, but the reason it couldn't may be because
> somebody else consumed all the available file descriptors.
> 
> I am not opposed to this change per-se, but I am not sure that
> saying "stdin" etc. makes the message more useful for the purpose of
> debugging.

Yeah, I had the same feeling. All that failed is pipe(), which does not
have anything to do with what we are going to use the pipe for. So it
gives some context, perhaps, but does not necessarily tell us anything
useful.

But it is not much code, and sometimes it is surprising what information
can be helpful when debugging, so like you, I am not opposed, just
doubtful.

-Peff
