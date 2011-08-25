From: Jeff King <peff@peff.net>
Subject: Re: git diff annoyance / feature request
Date: Thu, 25 Aug 2011 16:00:01 -0400
Message-ID: <20110825200001.GA6165@sigill.intra.peff.net>
References: <4E569F10.8060808@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git discussion list <git@vger.kernel.org>
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Thu Aug 25 22:00:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwg60-0007En-9B
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 22:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280Ab1HYUAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 16:00:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51006
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753216Ab1HYUAE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 16:00:04 -0400
Received: (qmail 18469 invoked by uid 107); 25 Aug 2011 20:00:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Aug 2011 16:00:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Aug 2011 16:00:01 -0400
Content-Disposition: inline
In-Reply-To: <4E569F10.8060808@panasas.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180107>

On Thu, Aug 25, 2011 at 12:14:24PM -0700, Boaz Harrosh wrote:

> git diff has this very annoying miss-fixture where it will state
> as hunk header the closest label instead of the function name.
> [...]
>
> I bet all this was just inherited from diff. Would it be accepted if
> I send a patch to fix it? What you guys think a goto label makes any
> sense at all?

Unless you tell git what type of content is in your file, it uses the same
basic heuristics for finding a hunk-header line that diff does. Namely,
the most recent line that starts with an alphabetic character,
underscore, or dollar sign.

If you want language-specific hunk headers, you can use gitattributes to
tell git what's in your files. We already have a builtin C driver that
will do what you want. You just need to do[1]:

  echo '*.c diff=cpp' >.gitattributes

Note that it handles both C and C++, hence the name. See "git help
gitattributes" for details (the section "Defining a custom hunk-header"
is what you want).

If your upstream (which looks like linux-2.6) doesn't want
.gitattributes files in the repository, you can also put the entry into
.git/info/attributes.

-Peff

[1] Since we have builtin funcname patterns for many types, we arguably
could also have a builtin mapping of common extensions to diff drivers.
