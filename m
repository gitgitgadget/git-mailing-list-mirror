From: Jeff King <peff@peff.net>
Subject: Re: utf-8 filename woes
Date: Wed, 22 Apr 2015 16:19:37 -0400
Message-ID: <20150422201937.GA26917@peff.net>
References: <5537FB82.4000302@wizmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jeremy Harris <jgh@wizmail.org>
X-From: git-owner@vger.kernel.org Wed Apr 22 22:19:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl17b-00027R-V8
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 22:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbbDVUTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 16:19:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:48842 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752314AbbDVUTk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 16:19:40 -0400
Received: (qmail 15450 invoked by uid 102); 22 Apr 2015 20:19:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 15:19:40 -0500
Received: (qmail 13785 invoked by uid 107); 22 Apr 2015 20:20:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 16:20:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2015 16:19:37 -0400
Content-Disposition: inline
In-Reply-To: <5537FB82.4000302@wizmail.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267637>

On Wed, Apr 22, 2015 at 08:50:26PM +0100, Jeremy Harris wrote:

> Installing the git-debuginfo package gave no additional
> information.   The symptom does not show on a Fedora 21
> system with git 2.1.0 (and I note that gitk properly
> shows those filenames on f21, and does not on sl6).
> 
> Is this a known and fixed issue, or something my sl6
> system needs installing?

I'm not sure. v1.7.1 is 5 years old, and there have been a lot of fixes
since then.  I couldn't replicate your problem on v1.7.1 with a trivial
test. If you can reproduce it at will and you really want to know
where the fix is, you can try "reverse-bisecting":

  git clone git://git.kernel.org/pub/scm/git/git.git
  cd git
  git bisect start

  git checkout v1.7.1
  make
  [confirm that it shows the breakage]
  git bisect good

  git checkout v2.1.0
  make
  [confirm that it does not show the problem]
  git bisect bad

  ... follow the instructions, testing teach ...

Note that "good" and "bad" here are reversed of what you might expect.
"bisect" was designed for finding regressions, not fixes, and you have
to manually flip the two.

-Peff
