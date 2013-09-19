From: Jeff King <peff@peff.net>
Subject: Re: [PATCH jk/config-int-range-check] compat/mingw.h: define PRId64
Date: Thu, 19 Sep 2013 03:56:10 -0400
Message-ID: <20130919075610.GB29773@sigill.intra.peff.net>
References: <523AA4F3.6010406@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 19 09:56:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMZ67-0004yV-HQ
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 09:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813Ab3ISH4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 03:56:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:33295 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752784Ab3ISH4T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 03:56:19 -0400
Received: (qmail 27316 invoked by uid 102); 19 Sep 2013 07:56:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Sep 2013 02:56:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Sep 2013 03:56:10 -0400
Content-Disposition: inline
In-Reply-To: <523AA4F3.6010406@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235006>

On Thu, Sep 19, 2013 at 09:17:07AM +0200, Johannes Sixt wrote:

> From: Johannes Sixt <j6t@kdbg.org>
> 
> Provide PRId64 alongside PRIuMAX.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

Thanks. I had noticed this was the first use of PRId64, but I wasn't
sure what various implementations would want.

I notice that we also have a fallback PRIuMAX of "llu" in
git-compat-util.h, but I'm not sure which platforms need that, nor what
they would want for PRId64. By the explanation in 3efb1f3 and e326bce,
it looks like the strategy was to just use a "long long" and hope for
the best. So we might want:

diff --git a/git-compat-util.h b/git-compat-util.h
index 9549de6..4438e7c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -239,6 +239,10 @@ extern char *gitbasename(char *);
 #define PRIuMAX "llu"
 #endif
 
+#ifndef PRId64
+#define PRId64 "lld"
+#endif
+
 #ifndef PRIu32
 #define PRIu32 "u"
 #endif

as well, but I think I'd rather wait until somebody with an actual
system that needs it reports in (and tells us what the right value for
their system is) as opposed to just guessing.

-Peff
