From: Jeff King <peff@peff.net>
Subject: Re: Bug Report: git add
Date: Fri, 8 Apr 2011 15:46:51 -0400
Message-ID: <20110408194650.GA15804@sigill.intra.peff.net>
References: <4D9BA35E.6040204@dcook.org>
 <20110407005750.GC28813@sigill.intra.peff.net>
 <7vbp0ihnou.fsf@alter.siamese.dyndns.org>
 <20110407014819.GA12730@sigill.intra.peff.net>
 <7vlizmfrl1.fsf@alter.siamese.dyndns.org>
 <20110408191554.GA6516@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Darren Cook <darren@dcook.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 21:47:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8Hdz-0001ia-QQ
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 21:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757824Ab1DHTqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 15:46:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53391
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757687Ab1DHTqy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 15:46:54 -0400
Received: (qmail 4247 invoked by uid 107); 8 Apr 2011 19:47:42 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Apr 2011 15:47:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Apr 2011 15:46:51 -0400
Content-Disposition: inline
In-Reply-To: <20110408191554.GA6516@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171151>

On Fri, Apr 08, 2011 at 03:15:54PM -0400, Jeff King wrote:

> > This only checks "does the directory have .git in it?".
> 
> Yeah. I was trying to keep the test as inexpensive as possible, since
> this is a very frequently called codepath. But really, doing a more
> elaborate test shouldn't matter. The common case will be that the stat
> fails, and we do nothing else.
> 
> I do worry about adding an extra lstat for each directory having
> noticeable overhead. Maybe it doesn't matter because of the stat
> caching, but I didn't measure.

I just did some measurements on linux-2.6 (which is a fair bit more
directory-heavy than something like git.git). The difference is
measurable, but not significant.

The average for "git add ." (on a clean, warm-cache repository) over
many trials with the extra lstats is about 2-3% slower.  But the error
margin between trials is something like 3-4%. IOW, even though the
average was worse, the best trial for the new code was still faster than
the worst trial for the old.

This is on Linux, though. It would probably be worse on an OS with a
slower stat.

-Peff
