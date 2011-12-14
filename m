From: Jeff King <peff@peff.net>
Subject: Re: [BUG] in rev-parse
Date: Wed, 14 Dec 2011 16:01:57 -0500
Message-ID: <20111214210157.GA8990@sigill.intra.peff.net>
References: <20111214184926.GB18335@llunet.cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: nathan.panike@gmail.com
X-From: git-owner@vger.kernel.org Wed Dec 14 22:02:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ravxm-0000s8-CJ
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 22:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757872Ab1LNVCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 16:02:00 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50206
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755364Ab1LNVB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 16:01:59 -0500
Received: (qmail 1704 invoked by uid 107); 14 Dec 2011 21:08:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Dec 2011 16:08:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2011 16:01:57 -0500
Content-Disposition: inline
In-Reply-To: <20111214184926.GB18335@llunet.cs.wisc.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187165>

On Wed, Dec 14, 2011 at 12:49:27PM -0600, nathan.panike@gmail.com wrote:

> In my local git.git:
> 
> $ git rev-parse 73c6b3575bc638b7096ec913bd91193707e2265d^@
> 57526fde5df201a99afa6d122c3266b3a1c5673a
> 942e6baa92846e5628752c65a22bc4957d8de4d0
> 
> $ git rev-parse --short 73c6b3575bc638b7096ec913bd91193707e2265d^@
> 57526fd
> 942e6ba
> fatal: Needed a single revision
> 
> ^^^ I don't believe this "fatal" message should be here

It looks like "--short" implies "--verify", and you cannot "--verify"
multiple sha1s.

But the documentation for "--short" says only:

  --short::
  --short=number::
          Instead of outputting the full SHA1 values of object names try to
          abbreviate them to a shorter unique name. When no length is specified
          7 is used. The minimum length is 4.

which would imply to me that not only should your example work, but this
should, too:

  $ git rev-parse HEAD HEAD^
  803b1a83b0ec5f04dfb770e83e11211e0015630f
  28c2058b6048d32abc0a23b827ab0b26a0332b9b

  $ git rev-parse --short HEAD HEAD^
  fatal: Needed a single revision

On the other hand, it has been like this since it was introduced in
2006, and I wonder if scripts rely on the --verify side effect.

As a work-around, you can get what you want with:

  git rev-list --no-walk --abbrev-commit $sha1^@

-Peff
