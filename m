From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/9] remote-curl: recognize text/plain with a charset
 parameter
Date: Thu, 22 May 2014 05:02:59 -0400
Message-ID: <20140522090259.GA29669@sigill.intra.peff.net>
References: <20140521102524.GA30301@sigill.intra.peff.net>
 <20140521103301.GG30464@sigill.intra.peff.net>
 <90CE006F-EE74-40D2-8847-507E37021D84@gmail.com>
 <20140522060516.GB16587@sigill.intra.peff.net>
 <21F11C1A-4C69-4633-9DC7-E9134D38856E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 11:03:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnOu5-0006GB-Ux
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 11:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081AbaEVJDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 05:03:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:57210 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751435AbaEVJDB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 05:03:01 -0400
Received: (qmail 9958 invoked by uid 102); 22 May 2014 09:03:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 May 2014 04:03:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2014 05:02:59 -0400
Content-Disposition: inline
In-Reply-To: <21F11C1A-4C69-4633-9DC7-E9134D38856E@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249882>

On Thu, May 22, 2014 at 12:27:38AM -0700, Kyle J. McKay wrote:

> Yeah I think so too.  It's probably enough though just to just strip all " "
> and "\t" characters at the same time the content type is lowercased.  While
> that would cause invalid content types such as "text / plain" to be
> recognized it would keep the rest of the code simpler.  Since a producer of
> an invalid content type shouldn't really be depending on any particular
> behavior by a receiver of an invalid content type it's probably not an
> issue.

I think you have to retain whitespace between parameters. Not that I
expect there to be multiple parameters in a text/plain, but it's
allowed.

I started doing this path of trying to produce a normalized version, but
found that it was just as much code as parsing at all (and it still
leaves the calling code to do its own parse). Instead, what I ended up
with was just doing the parsing in http.c into nice, normalized chunks,
and then the calling code can compare them with simple strcmps.

I'll post the patches in a few minutes.

-Peff
