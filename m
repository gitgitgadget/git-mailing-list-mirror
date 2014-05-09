From: Jeff King <peff@peff.net>
Subject: Re: [Bug] git-email: sendemail.bcc in config file overrides command
 line option "--bcc"
Date: Fri, 9 May 2014 11:45:09 -0400
Message-ID: <20140509154509.GE18197@sigill.intra.peff.net>
References: <20140509081331.GC3145@adam-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Adam Lee <adam.lee@canonical.com>
X-From: git-owner@vger.kernel.org Fri May 09 17:45:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wimz9-0005VL-8q
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 17:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756599AbaEIPpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 11:45:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:48318 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754063AbaEIPpL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 11:45:11 -0400
Received: (qmail 27615 invoked by uid 102); 9 May 2014 15:45:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 May 2014 10:45:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 May 2014 11:45:09 -0400
Content-Disposition: inline
In-Reply-To: <20140509081331.GC3145@adam-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248575>

On Fri, May 09, 2014 at 04:13:31PM +0800, Adam Lee wrote:

> BugLink: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=747068
> 
> "--bcc" should have higher priority than sendemail.bcc.
> 
> > --bcc=<address>
> >     Specify a "Bcc:" value for each email. Default is the value of sendemail.bcc.
> >
> >     The --bcc option must be repeated for each user you want on the bcc list.
> 
> Reproducing steps:
> 1, set sendemail.bcc in .gitconfig.
> 2, git send-email --bcc with another address.

Hrm, I cannot reproduce at all here:

  $ git config sendemail.bcc config-bcc@example.com
  $ git send-email --dry-run --to=to@example.com -1 origin
  (mbox) Adding cc: Junio C Hamano <gitster@pobox.com> from line 'From: Junio C Hamano <gitster@pobox.com>'
  Dry-OK. Log says:
  Sendmail: /usr/sbin/sendmail -i to@example.com gitster@pobox.com config-bcc@example.com
  > [...]

OK, so our configured bcc works. Now let's override it:

  $ git send-email --dry-run --to=to@example.com \
      --bcc=cmdline-bcc@example.com -1 origin
  (mbox) Adding cc: Junio C Hamano <gitster@pobox.com> from line 'From: Junio C Hamano <gitster@pobox.com>'
  Dry-OK. Log says:
  Sendmail: /usr/sbin/sendmail -i to@example.com gitster@pobox.com cmdline-bcc@example.com

That looks like it's working as expected. Can you show us similar
commands that demonstrate the failure?

-Peff
