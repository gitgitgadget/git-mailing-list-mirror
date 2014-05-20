From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] format-patch --signature-file <file>
Date: Tue, 20 May 2014 02:21:32 -0400
Message-ID: <20140520062132.GA5222@sigill.intra.peff.net>
References: <1400203881-2794-1-git-send-email-jmmahler@gmail.com>
 <1400203881-2794-2-git-send-email-jmmahler@gmail.com>
 <20140516081445.GA21468@sigill.intra.peff.net>
 <20140517072548.GA18239@hudson.localdomain>
 <20140517074224.GA16697@sigill.intra.peff.net>
 <20140517085911.GA18862@hudson.localdomain>
 <20140517100013.GA18087@sigill.intra.peff.net>
 <20140517153943.GB31912@hudson.localdomain>
 <xmqqd2f93e0m.fsf@gitster.dls.corp.google.com>
 <20140520054621.GA28317@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 10:42:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmdQg-0001SY-S2
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 08:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbaETGVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 02:21:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:55524 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750731AbaETGVe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 02:21:34 -0400
Received: (qmail 7837 invoked by uid 102); 20 May 2014 06:21:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 May 2014 01:21:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 May 2014 02:21:32 -0400
Content-Disposition: inline
In-Reply-To: <20140520054621.GA28317@hudson.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249654>

On Mon, May 19, 2014 at 10:46:21PM -0700, Jeremiah Mahler wrote:

> > Avoiding that is easy with an indirection, no?  Something like this
> > at the top:
> > 
> >   static const char *the_default_signature = git_version_string;
> >   static const char *signature = the_default_signature;
> > 
> > and comparing to see if signature points at the same address as
> > the_default_signature would give you what you want, I think.
> 
> I like your suggestion for a default signature variable.
> Unfortunately, C doesn't like it as much.
> 
> static const char *the_default_signature = git_version_string;
> static const char *signature = the_default_signature;  // ERROR
> // initializer element is not constant

You could do:

  #define DEFAULT_SIGNATURE git_version_string
  static const char *signature = DEFAULT_SIGNATURE;

  ...

  if (signature == DEFAULT_SIGNATURE)
     ...

but maybe that is getting a little unwieldy, considering the scope of
the original problem.

-Peff
