From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] config: do not ungetc EOF
Date: Sun, 8 Feb 2015 22:22:20 +0100
Message-ID: <20150208212220.GB3796@book.hvoigt.net>
References: <20150205065327.GA7807@peff.net>
 <20150205210024.GA30724@peff.net>
 <xmqqr3u4jbyj.fsf@gitster.dls.corp.google.com>
 <20150205212847.GA2360@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 08 22:22:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKZJS-0006RM-Th
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 22:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758935AbbBHVW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 16:22:26 -0500
Received: from smtprelay06.ispgateway.de ([80.67.31.96]:47288 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858AbbBHVW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 16:22:26 -0500
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Feb 2015 16:22:25 EST
Received: from [77.20.146.160] (helo=book.hvoigt.net)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1YKZJ8-00015H-5z; Sun, 08 Feb 2015 22:22:22 +0100
Content-Disposition: inline
In-Reply-To: <20150205212847.GA2360@peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263532>

On Thu, Feb 05, 2015 at 04:28:47PM -0500, Jeff King wrote:
> On Thu, Feb 05, 2015 at 01:16:36PM -0800, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > On Thu, Feb 05, 2015 at 01:53:27AM -0500, Jeff King wrote:
> > >
> > >> I also notice that config_buf_ungetc does not actually ungetc the
> > >> character we give it; it just rewinds one character in the stream. This
> > >> is fine, because we always feed the last-retrieved character. I dunno if
> > >> it is worth fixing (it also would have fixed this infinite loop, but for
> > >> the wrong reason; we would have stuck "-1" back into the stream, and
> > >> retrieved it on the next fgetc rather than the same '\r' over and over).
> > >
> > > Here's a patch to deal with that. I'm not sure if it's worth doing or
> > > not.
> > 
> > I am not sure, either.  If this were to become stdio emulator over
> > random in-core data used throughout the system, perhaps.
> > 
> > But in its current form it is tied to the implementation of config.c
> > very strongly, so...
> 
> Yeah, that was my thinking, and why I have doubts. Maybe a comment would
> make more sense, like the patch below. I am also OK with just leaving
> it as-is.
> 
> -- >8 --
> Subject: [PATCH] config_buf_ungetc: document quirks in a comment

I think a comment would be fine as well. Both helps to quickly find the
cause why our ungetc() might not behave as the caller expects. But I
think one of both would be good so we document that this behavior is in
fact intentional.

Cheers Heiko
