From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Thu, 10 Jun 2010 04:29:16 -0400
Message-ID: <20100610082916.GA5559@coredump.intra.peff.net>
References: <20100608053507.GB15156@coredump.intra.peff.net>
 <AANLkTilvvpy4TBQF6g8boQL87FRB7kFDrVfYiHvOv6xu@mail.gmail.com>
 <4C0E5103.7030501@viscovery.net>
 <AANLkTilWg8hw5j20o-xGsVO-q_OeSmtKEKAO6O416qvH@mail.gmail.com>
 <4C0E6810.3070301@viscovery.net>
 <AANLkTinZSuXJEXzpvEavYNLSyqUlx8qzWlrbtIH6q6fx@mail.gmail.com>
 <4C0E932B.3010702@viscovery.net>
 <AANLkTinB_SBilMOfgnHtDrQS-NBOLF4yY5NaP7ZvN9rK@mail.gmail.com>
 <4C0EB741.9020905@op5.se>
 <AANLkTinAO5empFix9W_rbtU3Vv4O73OsJBtA1stb66DS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>,
	Dario Rodriguez <soft.d4rio@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	git <git@vger.kernel.org>
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Thu Jun 10 10:29:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMd8i-000747-Vg
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 10:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755572Ab0FJI3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 04:29:23 -0400
Received: from peff.net ([208.65.91.99]:51787 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752417Ab0FJI3W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 04:29:22 -0400
Received: (qmail 2026 invoked by uid 107); 10 Jun 2010 08:29:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 10 Jun 2010 04:29:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jun 2010 04:29:16 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinAO5empFix9W_rbtU3Vv4O73OsJBtA1stb66DS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148841>

On Wed, Jun 09, 2010 at 11:08:49AM +0200, Tor Arntsen wrote:

> If it's true that Git should demand 'less' to be installed before
> being usable out of the box.. well, that's just plain silly.

It depends on how you define "out of the box". The person compiling it
just needs to set DEFAULT_PAGER appropriately for their system. "less"
is a sane choice for most modern systems. But we can make it even easier
on AIX people with:

diff --git a/Makefile b/Makefile
index 34b7dd5..6ad0aca 100644
--- a/Makefile
+++ b/Makefile
@@ -930,6 +930,7 @@ ifeq ($(uname_S),NetBSD)
 	HAVE_PATHS_H = YesPlease
 endif
 ifeq ($(uname_S),AIX)
+	DEFAULT_PAGER = more
 	NO_STRCASESTR=YesPlease
 	NO_MEMMEM = YesPlease
 	NO_MKDTEMP = YesPlease

That won't do automagic run-time detection if you have "less" installed,
but given your claim that AIX's "more" actually doesn't suck, it's
probably a good default. People who care can set their PAGER environment
variable.

-Peff
