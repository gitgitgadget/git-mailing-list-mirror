From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Allow generating a non-default set of documentation
Date: Sun, 7 Oct 2012 19:01:02 -0400
Message-ID: <20121007230102.GB3490@sigill.intra.peff.net>
References: <7vzk3yow3f.fsf@alter.siamese.dyndns.org>
 <20121007214855.GB1743@sigill.intra.peff.net>
 <7v626lq5g4.fsf@alter.siamese.dyndns.org>
 <7vsj9poq8v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:01:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKzqc-00010h-F9
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 01:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070Ab2JGXBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 19:01:06 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44072 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709Ab2JGXBF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 19:01:05 -0400
Received: (qmail 19400 invoked by uid 107); 7 Oct 2012 23:01:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 07 Oct 2012 19:01:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Oct 2012 19:01:02 -0400
Content-Disposition: inline
In-Reply-To: <7vsj9poq8v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207212>

On Sun, Oct 07, 2012 at 03:45:52PM -0700, Junio C Hamano wrote:

> So here is a proposed update based on your idea, to be squashed on
> top (i.e. the change to the top-level Makefile in the posted patch
> is not reverted).
> 
> Does it make sense?

The change to Documentation/Makefile makes sense, but what then is the
point of the second half of this hunk from your original:

@@ -2468,10 +2476,10 @@ $(XDIFF_LIB): $(XDIFF_OBJS)
 $(VCSSVN_LIB): $(VCSSVN_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(VCSSVN_OBJS)
 
-export DEFAULT_EDITOR DEFAULT_PAGER
+export DEFAULT_EDITOR DEFAULT_PAGER DEFAULT_DOC_TARGET
 
 doc:
-	$(MAKE) -C Documentation all
+	$(MAKE) -C Documentation $(DEFAULT_DOC_TARGET)
 
 man:
 	$(MAKE) -C Documentation man

We know that "all" is simply a redirect to DEFAULT_DOC_TARGET internally
within the documentation Makefile, and we know that it is propagated by
the export line above.  I do not think it creates the wrong behavior,
but it is unnecessary, and omitting a target at all demonstrates to a
reader how they can get the same behavior from within Documentation
(namely by running just "make").

-Peff
