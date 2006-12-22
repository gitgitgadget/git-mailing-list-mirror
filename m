From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: [PATCH] Don't define _XOPEN_SOURCE on MacOSX and FreeBSD as it is too restricting
Date: Fri, 22 Dec 2006 14:14:52 +0100
Message-ID: <20061222131452.GB11274@fiberbit.xs4all.nl>
References: <7vodpy3vxi.fsf@assigned-by-dhcp.cox.net> <86vek6vyc7.fsf@blue.stonehenge.com> <caf068570612201735o776e01a8he2e9ab90fc2ee4f@mail.gmail.com> <20061221103938.GA7055@fiberbit.xs4all.nl> <20061221112835.GA7713@fiberbit.xs4all.nl> <7v64c492fv.fsf@assigned-by-dhcp.cox.net> <20061222075142.GA9595@fiberbit.xs4all.nl> <7v4pro5nsa.fsf@assigned-by-dhcp.cox.net> <20061222114722.GA11274@fiberbit.xs4all.nl> <20061222125505.GB3773@peter.daprodeges.fqdn.th-h.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-From: git-owner@vger.kernel.org Fri Dec 22 14:15:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxkEq-0006oU-Mp
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 14:15:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825AbWLVNPA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 08:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754832AbWLVNPA
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 08:15:00 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:54919 "EHLO
	fiberbit.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754825AbWLVNO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 08:14:59 -0500
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.63)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1GxkEe-0003Cx-US; Fri, 22 Dec 2006 14:14:52 +0100
To: Marco Roeland <marco.roeland@xs4all.nl>,
	Junio C Hamano <junkio@cox.net>,
	Terje Sten Bjerkseth <terje@bjerkseth.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20061222125505.GB3773@peter.daprodeges.fqdn.th-h.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35173>

On Friday December 22nd 2006 at 12:55 Rocco Rutte wrote:

> I'm still in favour of simply adding '!defined(__FreeBSD__)' to 
> git-compat-util.h as soon as possible to push out a maintaince release 
> that at least compiles (on FreeBSD)...

Agreed. It's the more practical thing to do and Just Works (TM).

Perhaps in the long run we could create platform specific header files
to deal with whatever excentricities these provide or need, and include
in git-compat-util.h things like for every candidate that needs it:

#ifdef __CrappIX__
#include "compat/crappix.h"
#endif

For the _XOPEN_SOURCE specific things it might also be better to reverse
the logic, so not exclude it for a number of platforms but only include
it for the specific platforms that seem to need it.

So, again on top of Terjes patch in "master":

diff --git a/git-compat-util.h b/git-compat-util.h
index 41fa7f6..c7930d2 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -11,7 +11,7 @@
 
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
 
-#ifndef __APPLE_CC__
+#if !defined(__APPLE__) && !defined(__FreeBSD__)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
-- 
Marco Roeland
