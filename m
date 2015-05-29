From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] Makefile: silence perl/PM.stamp recipe
Date: Fri, 29 May 2015 03:26:48 -0400
Message-ID: <20150529072648.GC9670@peff.net>
References: <20150529072119.GA5415@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 09:26:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyEgx-000580-Ho
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 09:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbbE2H0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 03:26:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:37509 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932240AbbE2H0v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 03:26:51 -0400
Received: (qmail 8433 invoked by uid 102); 29 May 2015 07:26:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 May 2015 02:26:51 -0500
Received: (qmail 23555 invoked by uid 107); 29 May 2015 07:26:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 May 2015 03:26:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 May 2015 03:26:48 -0400
Content-Disposition: inline
In-Reply-To: <20150529072119.GA5415@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270213>

Every time we run "make", we update perl/PM.stamp, which
contains a list of all of the perl module files (if it's
updated, we need to rebuild perl/perl.mak, since the
Makefile will not otherwise know about the new files).

This means that every time "make" is run, we see:

      GEN perl/PM.stamp

in the output, even though it is not likely to have changed.
Let's make this recipe completely silent, as we do for other
auto-generated dependency files (e.g., GIT-CFLAGS).

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6b4fbeb..6b0dd47 100644
--- a/Makefile
+++ b/Makefile
@@ -1747,7 +1747,7 @@ $(SCRIPT_PERL_GEN): perl/perl.mak
 perl/perl.mak: perl/PM.stamp
 
 perl/PM.stamp: FORCE
-	$(QUIET_GEN)$(FIND) perl -type f -name '*.pm' | sort >$@+ && \
+	@$(FIND) perl -type f -name '*.pm' | sort >$@+ && \
 	{ cmp $@+ $@ >/dev/null 2>/dev/null || mv $@+ $@; } && \
 	$(RM) $@+
 
-- 
2.4.2.668.gc3b1ade.dirty
