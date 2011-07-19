From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] diff-lib: simplify do_diff_cache()
Date: Tue, 19 Jul 2011 16:14:00 -0400
Message-ID: <20110719201400.GA2938@sigill.intra.peff.net>
References: <7vzkkh2yfu.fsf@alter.siamese.dyndns.org>
 <1311099186-16482-1-git-send-email-gitster@pobox.com>
 <1311099186-16482-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 22:14:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjGgD-0004yW-Ak
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 22:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477Ab1GSUOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 16:14:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52257
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403Ab1GSUOC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 16:14:02 -0400
Received: (qmail 1723 invoked by uid 107); 19 Jul 2011 20:14:30 -0000
Received: from m-0-33.docsis.hbci.com (HELO sigill.intra.peff.net) (64.213.220.33)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Jul 2011 16:14:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jul 2011 16:14:00 -0400
Content-Disposition: inline
In-Reply-To: <1311099186-16482-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177501>

On Tue, Jul 19, 2011 at 11:13:05AM -0700, Junio C Hamano wrote:

> Since 34110cd (Make 'unpack_trees()' have a separate source and
> destination index, 2008-03-06), we can run unpack_trees() without munging
> the index at all, but do_diff_cache() tried ever so carefully to work
> around the old behaviour of the function.
> 
> We can just tell unpack_trees() not to touch the original index and there
> is no need to clean-up whatever the previous round has done.

Can we drop the calls to discard_cache in reset.c now?

$ git grep -B1 discard_cache builtin/reset.c
builtin/reset.c-        /* do_diff_cache() mangled the index */
builtin/reset.c:        discard_cache();
--
builtin/reset.c-                /* The index is still clobbered from do_diff_cache() */
builtin/reset.c:                discard_cache();

-Peff
