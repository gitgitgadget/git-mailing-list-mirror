From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tests: sanitize more git environment variables
Date: Wed, 26 Jan 2011 19:31:36 -0500
Message-ID: <20110127003136.GA5394@sigill.intra.peff.net>
References: <20110126203331.GA27478@sigill.intra.peff.net>
 <7v39ofl7ki.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 27 01:31:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiFm0-00023B-PL
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 01:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754531Ab1A0Abg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 19:31:36 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:56416 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754478Ab1A0Abf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 19:31:35 -0500
Received: (qmail 10971 invoked by uid 111); 27 Jan 2011 00:31:34 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 27 Jan 2011 00:31:34 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Jan 2011 19:31:36 -0500
Content-Disposition: inline
In-Reply-To: <7v39ofl7ki.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165566>

On Wed, Jan 26, 2011 at 12:43:25PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > These variables should generally not be set in one's
> > environment, but they do get set by rebase, which means
> > doing an interactive rebase like:
> >
> >   pick abcd1234 foo
> >   exec make test
> >
> > will cause false negatives in the test suite.
> 
> Cute.  Thanks.

BTW, for anyone interested, I am using this with the following script:

-- >8 --
#!/bin/sh
upstream=`git rev-parse --symbolic-full-name "$1@{u}" >/dev/null 2>&1`
GIT_EDITOR='sed -i "/^pick .*/aexec make -j8 test"' \
	git rebase -i "${upstream:-origin}" $1
-- 8< --

which is a convenient way of testing each commit in a patch series
before submitting it upstream (and it stops on test failure so you can
fix up that commit).

You can drop it in your PATH as "git-test" and run "git test" or "git
test <branch>".

-Peff
