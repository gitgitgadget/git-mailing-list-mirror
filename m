From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] format-patch --signature-file <file>
Date: Sat, 17 May 2014 06:00:14 -0400
Message-ID: <20140517100013.GA18087@sigill.intra.peff.net>
References: <1400203881-2794-1-git-send-email-jmmahler@gmail.com>
 <1400203881-2794-2-git-send-email-jmmahler@gmail.com>
 <20140516081445.GA21468@sigill.intra.peff.net>
 <20140517072548.GA18239@hudson.localdomain>
 <20140517074224.GA16697@sigill.intra.peff.net>
 <20140517085911.GA18862@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 17 12:00:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlbPi-0003Rk-Hd
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 12:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbaEQKAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 06:00:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:53766 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932143AbaEQKAS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 06:00:18 -0400
Received: (qmail 24082 invoked by uid 102); 17 May 2014 10:00:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 17 May 2014 05:00:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 May 2014 06:00:14 -0400
Content-Disposition: inline
In-Reply-To: <20140517085911.GA18862@hudson.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249462>

On Sat, May 17, 2014 at 01:59:11AM -0700, Jeremiah Mahler wrote:

> >   if (signature) {
> > 	if (signature_file)
> > 		die("you cannot specify both a signature and a signature-file");
> > 	/* otherwise, we already have the value */
> >   } else if (signature_file) {
> > 	struct strbuf buf = STRBUF_INIT;
> > 	strbuf_read(&buf, signature_file, 128);
> > 	signature = strbuf_detach(&buf);
> >   } else
> > 	signature = git_version_string;
> > 
> 
> Before, --no-signature would clear the &signature.
> With this code it sees it as not being set and assigns
> the default version string.

Ah, you're right. Thanks for catching it.

If you wanted to know whether it was set, I guess you'd have to compare
it to the default, like:

  if (signature_file) {
	if (signature && signature != git_version_string)
		die("you cannot specify both a signature and a signature-file");
	... read signature file ...
  }

though it's a bit ugly that this code has to know what the default is.
Having signature-file take precedence is OK with me, but it feels
somewhat arbitrary to me from the user's perspective.

-Peff
