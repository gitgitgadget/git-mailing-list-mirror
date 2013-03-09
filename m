From: Jeff King <peff@peff.net>
Subject: Re: Memory corruption when rebasing with git version 1.8.1.5 on arch
Date: Fri, 8 Mar 2013 23:48:50 -0500
Message-ID: <20130309044850.GB12167@sigill.intra.peff.net>
References: <5139D76D.80703@bernhard-posselt.com>
 <20130308212831.GA9217@sigill.intra.peff.net>
 <513A7D80.5000501@bernhard-posselt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Bernhard Posselt <mail@bernhard-posselt.com>
X-From: git-owner@vger.kernel.org Sat Mar 09 05:49:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEBim-0001J5-8F
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 05:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933431Ab3CIEsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 23:48:53 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41420 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760304Ab3CIEsx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 23:48:53 -0500
Received: (qmail 21685 invoked by uid 107); 9 Mar 2013 04:50:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Mar 2013 23:50:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Mar 2013 23:48:50 -0500
Content-Disposition: inline
In-Reply-To: <513A7D80.5000501@bernhard-posselt.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217700>

On Sat, Mar 09, 2013 at 01:08:32AM +0100, Bernhard Posselt wrote:

> >The problem is likely happening in a sub-command of git-pull, so
> >valgrind isn't reporting it. Can you try re-running with
> >"valgrind --trace-children=yes", or alternatively narrow down the
> >problematic command by setting GIT_TRACE=1 in the environment?
>
> Heres the output with GIT_TRACE=1, the valgrind log has 4000 lines.
> If you should still require the valgrind log, please tell me.

Hmm, the GIT_TRACE output was less clear than I had hoped; it's unclear
to me which git program is actually dying (my guess is "git apply", and
we are squelching stderr, which is where the GIT_TRACE output is going).

Can you try it once again with something like GIT_TRACE=/tmp/foo.out,
which will make sure we record the trace directly, even if stderr ends
up redirected?

Also, I can almost reproduce here, as PatrickHeller/core.git is public.
However, I suspect the problem is particular to your work built on top,
which looks like it is at commit 0525bbd73c9015499ba92d1ac654b980aaca35b2.
Is it possible for you to make that commit available on a temporary
branch?

-Peff
