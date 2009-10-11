From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-add--interactive: never skip files included in
 index
Date: Sun, 11 Oct 2009 15:14:40 -0400
Message-ID: <20091011191440.GA2532@coredump.intra.peff.net>
References: <1255189906-16049-1-git-send-email-pav@iki.fi>
 <7viqelwyp1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pauli Virtanen <pav@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 21:16:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx3uF-0003Lv-6T
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 21:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbZJKTPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 15:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbZJKTPR
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 15:15:17 -0400
Received: from peff.net ([208.65.91.99]:35614 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943AbZJKTPR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 15:15:17 -0400
Received: (qmail 31189 invoked by uid 107); 11 Oct 2009 19:18:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 11 Oct 2009 15:18:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Oct 2009 15:14:40 -0400
Content-Disposition: inline
In-Reply-To: <7viqelwyp1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129947>

On Sun, Oct 11, 2009 at 11:52:10AM -0700, Junio C Hamano wrote:

> Thanks.
> 
> The change looks innocent enough and I do not expect to see any unexpected
> regressions from it, but it is a bit too late for 1.6.5 cycle, so let's
> queue this fix and aim for 1.6.5.1.

I think this patch is good to apply, as there is no conceivable reason
to even look at excludes when listing modified files.

But this triggered my spider sense; shouldn't --exclude-standard simply
be a no-op for ls-files when we are not listing untracked files? And
bisecting, it seems that it is a very old regression caused by 63d285c
(per-directory-exclude: lazily read .gitignore files, 2007-11-29).

I don't know if it is worth fixing now or not. It does seem a bit
inconsistent to me (since everything else is very clear that .gitignore
is only about untracked files), but nobody seems to have been
complaining for the last two years (and they may have, in fact, been
coding to the new behavior).

-Peff
