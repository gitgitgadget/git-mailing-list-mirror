From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Makefile checks for DarwinPorts / Fink
Date: Sun, 23 Jul 2006 01:45:31 -0400
Message-ID: <20060723054531.GA12559@spearce.org>
References: <f3d7535d0607210758m4410cddfw16329ce473404fd8@mail.gmail.com> <7vhd19itu2.fsf@assigned-by-dhcp.cox.net> <20060722161914.GA10754@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Pfetzing <stefan.pfetzing@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 23 07:45:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4Wmk-0006eg-CB
	for gcvg-git@gmane.org; Sun, 23 Jul 2006 07:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWGWFpi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Jul 2006 01:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWGWFpi
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Jul 2006 01:45:38 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:7326 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750860AbWGWFph (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jul 2006 01:45:37 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G4WmT-0003E4-Du; Sun, 23 Jul 2006 01:45:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2BF7E20FB77; Sun, 23 Jul 2006 01:45:31 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060722161914.GA10754@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24085>

This is a slightly cleaner version of my prior patch.  :-)

-->8--
Disable linking with Fink or DarwinPorts.

It may be desirable for the compiler to disable linking against Fink
or DarwinPorts, especially if both are installed on the system and
the user wants GIT to be linked specifically to only one of them.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Makefile |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index a1666e2..99a84cc 100644
--- a/Makefile
+++ b/Makefile
@@ -267,15 +267,17 @@ ifeq ($(uname_S),Darwin)
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_STRLCPY = YesPlease
-	## fink
-	ifeq ($(shell test -d /sw/lib && echo y),y)
-		BASIC_CFLAGS += -I/sw/include
-		BASIC_LDFLAGS += -L/sw/lib
+	ifndef NO_FINK
+		ifeq ($(shell test -d /sw/lib && echo y),y)
+			BASIC_CFLAGS += -I/sw/include
+			BASIC_LDFLAGS += -L/sw/lib
+		endif
 	endif
-	## darwinports
-	ifeq ($(shell test -d /opt/local/lib && echo y),y)
-		BASIC_CFLAGS += -I/opt/local/include
-		BASIC_LDFLAGS += -L/opt/local/lib
+	ifndef NO_DARWIN_PORTS
+		ifeq ($(shell test -d /opt/local/lib && echo y),y)
+			BASIC_CFLAGS += -I/opt/local/include
+			BASIC_LDFLAGS += -L/opt/local/lib
+		endif
 	endif
 endif
 ifeq ($(uname_S),SunOS)
-- 
1.4.2.rc1.ge711
