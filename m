From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/2] DEFAULT_DOC_TARGET
Date: Thu, 3 Jan 2013 16:07:31 -0500
Message-ID: <20130103210731.GB11783@sigill.intra.peff.net>
References: <1357239920-2201-1-git-send-email-gitster@pobox.com>
 <20130103203222.GB4632@sigill.intra.peff.net>
 <20130103210541.GA11783@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 22:07:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tqs13-0002KT-Ed
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 22:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021Ab3ACVHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 16:07:34 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42321 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753731Ab3ACVHd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 16:07:33 -0500
Received: (qmail 10656 invoked by uid 107); 3 Jan 2013 21:08:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 03 Jan 2013 16:08:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jan 2013 16:07:31 -0500
Content-Disposition: inline
In-Reply-To: <20130103210541.GA11783@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212615>

On Thu, Jan 03, 2013 at 04:05:41PM -0500, Jeff King wrote:

> On Thu, Jan 03, 2013 at 03:32:22PM -0500, Jeff King wrote:
> 
> > I think the usefulness is that it can be set by default for a particular
> > uname, so people on Windows can just type "make install-doc" without
> > having to care about setting anything (though to be honest, I do not
> > even know what they build by default; maybe they do build manpages).
> > Except that in the original thread:
> > 
> > >   http://thread.gmane.org/gmane.comp.version-control.git/207193/focus=207201
> > 
> > it became clear that to do that we would also want to hoist the uname
> > automagic defaults into their own file that could be read from
> > Documentation/Makefile.
> 
> IOW, this (on the current master), which I think is a nice cleanup
> regardless of this series:
> 
> -- >8 --
> Subject: [PATCH] Makefile: hoist uname autodetection to config.mak.uname

Not surprising for such a large refactoring, but this has conflicts with
what's in next. Here's the patch to apply on top of the conflicted tree
you get from merging this with "next":

diff --cc Makefile
index 5e4ee47,f37fb24..0000000
--- a/Makefile
+++ b/Makefile
diff --git a/config.mak.uname b/config.mak.uname
index f9de18e..bea34f0 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -425,6 +425,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	# Added manually, see above.
 	NEEDS_SSL_WITH_CURL = YesPlease
 	HAVE_LIBCHARSET_H = YesPlease
+	HAVE_STRINGS_H = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NEEDS_LIBINTL_BEFORE_LIBICONV = YesPlease
 	NO_SYS_SELECT_H = UnfortunatelyYes
@@ -520,3 +521,19 @@ endif
 	NO_CURL = YesPlease
 endif
 endif
+ifeq ($(uname_S),QNX)
+	COMPAT_CFLAGS += -DSA_RESTART=0
+	HAVE_STRINGS_H = YesPlease
+	NEEDS_SOCKET = YesPlease
+	NO_FNMATCH_CASEFOLD = YesPlease
+	NO_GETPAGESIZE = YesPlease
+	NO_ICONV = YesPlease
+	NO_MEMMEM = YesPlease
+	NO_MKDTEMP = YesPlease
+	NO_MKSTEMPS = YesPlease
+	NO_NSEC = YesPlease
+	NO_PTHREADS = YesPlease
+	NO_R_TO_GCC_LINKER = YesPlease
+	NO_STRCASESTR = YesPlease
+	NO_STRLCPY = YesPlease
+endif
