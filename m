From: Jeff King <peff@peff.net>
Subject: [PATCH] Makefile: do not set NEEDS_LIBICONV for Solaris 8
Date: Fri, 3 Oct 2008 02:39:36 -0400
Message-ID: <20081003063936.GA15132@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 03 08:40:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KleLM-00084d-9B
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 08:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459AbYJCGjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 02:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753431AbYJCGjl
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 02:39:41 -0400
Received: from peff.net ([208.65.91.99]:3732 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753229AbYJCGjk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 02:39:40 -0400
Received: (qmail 4310 invoked by uid 111); 3 Oct 2008 06:39:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 03 Oct 2008 02:39:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Oct 2008 02:39:36 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97399>

This breaks my build on Solaris 8, as there is no separate
libiconv.

The history of this line is somewhat convoluted. In 2fd955c
(in November 2005), NEEDS_LIBICONV was turned on for all
Solaris builds, claiming to "fix an error in Solaris 10 by
setting NEEDS_LIBICONV".

Later, e15f545 (in February of 2006) claimed that "Solaris
9+ don't need iconv", and moved NEEDS_LIBICONV into a
section for Solaris 8.

Furthermore, Brandon Casey claims in

<5A1KxlhmUIHe8iXPxnXYuNXsq0Yjlbwkz2eBin3z7ELuL9nK-4tSpw@cipher.nrlssc.navy.mil>

that he does not set NEEDS_LIBICONV for Solaris 7.

So either one of those commits is totally wrong, or there is
some other magic going on where some Solaris installs need
it and others don't.

Given Brandon's statement and my problems on Solaris 8 with
NEEDS_LIBICONV, I am inclined to think the first commit was
bogus, and that NEEDS_LIBICONV shouldn't be set for Solaris
at all by default. If somebody wants to use iconv and has
installed it manually, they can set it in their config.mak.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 3abbb4e..308dc70 100644
--- a/Makefile
+++ b/Makefile
@@ -651,7 +651,6 @@ ifeq ($(uname_S),SunOS)
 	NO_MKDTEMP = YesPlease
 	OLD_ICONV = UnfortunatelyYes
 	ifeq ($(uname_R),5.8)
-		NEEDS_LIBICONV = YesPlease
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
 		NO_C99_FORMAT = YesPlease
-- 
1.6.0.2.624.g13e35
