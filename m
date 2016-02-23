From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] credential-cache--daemon: change to the socket dir
 on startup
Date: Tue, 23 Feb 2016 16:07:26 -0500
Message-ID: <20160223210725.GA25854@sigill.intra.peff.net>
References: <20160223071427.GA7489@sigill.intra.peff.net>
 <20160223071604.GC8395@sigill.intra.peff.net>
 <xmqqfuwjyw59.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jon Griffiths <jon_p_griffiths@yahoo.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:07:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYKBE-0005vI-BC
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 22:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755455AbcBWVH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 16:07:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:47795 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755279AbcBWVH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 16:07:29 -0500
Received: (qmail 24262 invoked by uid 102); 23 Feb 2016 21:07:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 16:07:28 -0500
Received: (qmail 32193 invoked by uid 107); 23 Feb 2016 21:07:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 16:07:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Feb 2016 16:07:26 -0500
Content-Disposition: inline
In-Reply-To: <xmqqfuwjyw59.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287123>

On Tue, Feb 23, 2016 at 01:06:10PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +	/*
> > +	 * We don't actually care what our cwd is; we chdir here just to
> > +	 * be a friendly daemon and avoid tying up our original cwd.
> > +	 * If this fails, it's OK to just continue without that benefit.
> > +	 */
> > +	chdir(dir);
> 
> I fully do agree with this comment, but my copy of gcc and system
> headers doesn't, unfortunately.
> 
> credential-cache--daemon.c: In function 'init_socket_directory':
> credential-cache--daemon.c:245:7: error: ignoring return value of 'chdir', declared with attribute warn_unused_result [-Werror=unused-result]
>   chdir(dir);
>        ^
> cc1: all warnings being treated as errors
> make: *** [credential-cache--daemon.o] Error 1

Ugh. Is:

  (void)chdir(dir);

enough? Or do we have to do:

  if (chdir(dir))
	; /* nothing */

?

-Peff
