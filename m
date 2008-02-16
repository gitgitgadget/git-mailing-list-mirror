From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] config: add 'git_config_string' to refactor string
	config variables.
Date: Sat, 16 Feb 2008 13:33:13 -0500
Message-ID: <20080216183312.GA20777@sigill.intra.peff.net>
References: <20080216060024.385fa360.chriscool@tuxfamily.org> <20080216115310.GA11318@sigill.intra.peff.net> <200802161921.43346.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio Hamano <junkio@cox.net>,
	Pierre Habouzit <madcoder@debian.org>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Feb 16 19:33:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQRrE-0003QD-5P
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 19:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754904AbYBPSdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 13:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753142AbYBPSdR
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 13:33:17 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3873 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754218AbYBPSdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 13:33:16 -0500
Received: (qmail 12457 invoked by uid 111); 16 Feb 2008 18:33:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 16 Feb 2008 13:33:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Feb 2008 13:33:13 -0500
Content-Disposition: inline
In-Reply-To: <200802161921.43346.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74055>

On Sat, Feb 16, 2008 at 07:21:42PM +0100, Christian Couder wrote:

> Well, in many places where this function could be used the dest string is 
> a "const char *" and in many other places it's a "char *", but it feels 
> safer to try to promote the latter into the former (like I did in the 
> following patches) rather than the other way around.

Hrm. I suppose that is true if you are talking about removing the
'const' from existing variables (which although pointing to non-const
allocated space in this instance, may in other code paths point to
actual const space).

But this is really a matter of C handling this poorly, because we have
to pass in a pointer rather than using the return value. So I think the
method that best reflects the desired behavior would be to actually cast
"const char *" to "char *" at the callsite. But unfortunately casts in C
are error-prone themselves, and make the code a little harder to read.

So perhaps your solution is a reasonable compromise.

-Peff
