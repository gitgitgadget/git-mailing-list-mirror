From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] make get_short_ref a public function
Date: Thu, 9 Apr 2009 04:18:58 -0400
Message-ID: <20090409081857.GC17221@coredump.intra.peff.net>
References: <20090407070254.GA2870@coredump.intra.peff.net> <20090407071420.GD2924@coredump.intra.peff.net> <36ca99e90904070039m15869c34jc9e12d5ccc48d82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 10:20:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrpUz-0003Ge-Ny
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 10:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757095AbZDIITE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 04:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756434AbZDIITE
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 04:19:04 -0400
Received: from peff.net ([208.65.91.99]:50992 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755636AbZDIITB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 04:19:01 -0400
Received: (qmail 14427 invoked by uid 107); 9 Apr 2009 08:19:01 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.0.130)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 09 Apr 2009 04:19:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Apr 2009 04:18:58 -0400
Content-Disposition: inline
In-Reply-To: <36ca99e90904070039m15869c34jc9e12d5ccc48d82@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116147>

On Tue, Apr 07, 2009 at 09:39:58AM +0200, Bert Wesarg wrote:

> > Actually, I am not quite sure that this function is "more correct". It
> > looks at the rev-parsing rules as a hierarchy, so if you have
> > "refs/remotes/foo" and "refs/heads/foo", then it will abbreviate the
> > first to "remotes/foo" (as expected) and the latter to just "foo".
> >
> > This is technically correct, as "refs/heads/foo" will be selected by
> > "foo", but it will warn about ambiguity. Should we actually try to avoid
> > reporting refs which would be ambiguous?
> Back than, there was the idea that the core.warnAmbiguousRefs config
> could be used for this.

I'm not quite sure what you mean. Using this function, we may shorten an
unambiguous name to one that will complain if core.warnAmbiguousRefs is
set. So what I'm wondering is if it should use a different algorithm
that produces a shortened ref which will not cause a warning.

E.g., right now if we have:

  refs/heads/master
  refs/remotes/master

showing %(refname:short) gets you:

  master
  remotes/master

but "git show master" will warn about the ambiguous ref (but still show
you the one you want). An alternative would be to show:

  heads/master
  remotes/master

in this case.

-Peff
