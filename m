From: Jeff King <peff@peff.net>
Subject: Re: "git check-attr" lists macros as being "set" -- feature or bug?
Date: Tue, 26 Jul 2011 12:47:56 -0600
Message-ID: <20110726184756.GA520@sigill.intra.peff.net>
References: <4E2EAEA3.8000307@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 26 20:48:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlmfl-0001NY-OG
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 20:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016Ab1GZSsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 14:48:00 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34024
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083Ab1GZSr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 14:47:59 -0400
Received: (qmail 21366 invoked by uid 107); 26 Jul 2011 18:48:29 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Jul 2011 14:48:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Jul 2011 12:47:56 -0600
Content-Disposition: inline
In-Reply-To: <4E2EAEA3.8000307@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177895>

On Tue, Jul 26, 2011 at 02:10:11PM +0200, Michael Haggerty wrote:

> I am doing some work on git-check-attr, and I noticed something funny:
> If a macro is used to set or clear attributes on a file in
> .gitattributes, then the name of the macro itself is listed as an
> attribute on that file.  Example:
> 
> $ git init
> Initialized empty Git repository in /tmp/foo/.git/
> $ echo '[attr]notest !test' > .gitattributes
> $ echo 'no notest' >> .gitattributes
> 
> # This is expected:
> $ git check-attr test -- no
> no: test: unspecified
> 
> # This I found surprising:
> $ git check-attr notest -- no
> no: notest: set
> 
> I don't see the correct behavior documented anywhere.  If this is
> considered a bug, then I offer to fix it.  If it is considered a
> feature, then I offer to document it.

I don't know the original rationale, but it seems like the only sane
behavior to me. If you care about the attributes that the macro is
setting, then you will test for those attributes, not caring whether
they came from a macro or not. The only time you will ask about the
macro itself is if you care whether the macro itself is set (though the
point of macros is that you don't care about them, but only the
well-known names of underlying attributes. So I think you would only
want to see this if you were doing some maintenance on your
gitattributes files themselves, rather than simply reading their
values).

But maybe I'm missing something.  Can you describe a use case where you
would want "notest" to be listed as "unspecified" in your example?

-Peff
