From: Jeff King <peff@peff.net>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Mon, 7 Feb 2011 14:50:35 -0500
Message-ID: <20110207195035.GA13461@sigill.intra.peff.net>
References: <4D4DEDC4.4080708@hartwork.org>
 <20110206051333.GA3458@sigill.intra.peff.net>
 <4D4EF7E4.7050303@hartwork.org>
 <vpq1v3kopn3.fsf@bauges.imag.fr>
 <7vwrlcv1ea.fsf@alter.siamese.dyndns.org>
 <20110207055314.GA5511@sigill.intra.peff.net>
 <7vhbcguytf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 20:50:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmX6j-0003Km-7a
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 20:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853Ab1BGTuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 14:50:40 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:47690 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827Ab1BGTuj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 14:50:39 -0500
Received: (qmail 29651 invoked by uid 111); 7 Feb 2011 19:50:38 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 07 Feb 2011 19:50:38 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Feb 2011 14:50:35 -0500
Content-Disposition: inline
In-Reply-To: <7vhbcguytf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166276>

On Sun, Feb 06, 2011 at 10:46:20PM -0800, Junio C Hamano wrote:

> I actually do not mind too much myself if all commands that can take
> pathspecs consistently defaulted to "full-tree" pathspec given no
> pathspec.  But if we were to go that route, everybody should join their
> voice to defend that decision when outside people say "in 1.8.0 'git grep'
> run from a subdirectory shows matches from all the irrelevant parts of the
> tree; with all the cruft its output is unreadable". I won't be the sole
> champion of such a behaviour when I do not fully believe in it.

The problem is that I don't feel comfortable writing an RFC that says
"in 1.8.0 we will default to full-tree because it is somehow better".
Because I don't think it is better; it is simply a different way of
thinking about it, and different people will have different preferences.

I think even the same people may different preferences from project to
project. For most of my projects, the scope of the repo is well-defined,
and I want full-tree semantics (e.g., I hack on a bug, go into t/ to
tweak and run the tests, and then want to "git add -u" the whole thing
when everything looks good). But I also recently worked on a gigantic
project that was split into several sub-components. I would cd 3 or 4
levels deep into the sub-component that I was working on, and I would
prefer my "git add -u" to stay in that sub-component, and my "git grep"
to look only in that sub-component.

Which implies to me that the "relative" or "full-tree" view should be a
per-repo configurable thing. But that introduces its own set of
headaches, as people may script around things like "git add", and it
would become predictable to do so only from the top-level of the working
tree.

-Peff
