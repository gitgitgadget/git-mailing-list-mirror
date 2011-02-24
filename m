From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 1/8] compat: provide a fallback va_copy definition
Date: Thu, 24 Feb 2011 09:26:47 -0500
Message-ID: <20110224142647.GA15477@sigill.intra.peff.net>
References: <20110224142308.GA15356@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 15:26:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psc9e-0006Xm-Fz
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 15:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989Ab1BXO0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 09:26:49 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:57938 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754868Ab1BXO0s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 09:26:48 -0500
Received: (qmail 23254 invoked by uid 111); 24 Feb 2011 14:26:48 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Feb 2011 14:26:48 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 09:26:47 -0500
Content-Disposition: inline
In-Reply-To: <20110224142308.GA15356@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167811>

va_copy is C99. Prior to this, the usual procedure was to
simply copy the va_list by assignment.

Signed-off-by: Jeff King <peff@peff.net>
---
We have avoided using va_copy many times in the past, which has led to a
bunch of cut-and-paste. From everything I found searching the web,
implementations have historically either provided va_copy or just let
your code assume that simple assignment of worked. I couldn't find any
mention of any other alternatives.

So my guess is that this will be sufficient, but I we won't really know
for sure until somebody reports a problem. :(

 git-compat-util.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 9c23622..00d41e4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -535,6 +535,10 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 #define fstat_is_reliable() 1
 #endif
 
+#ifndef va_copy
+#define va_copy(dst,src) (dst) = (src)
+#endif
+
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
  * Always returns the return value of unlink(2).
-- 
1.7.2.5.25.g3bb93
