From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Add DEST Makefile variable
Date: Thu, 21 Apr 2005 19:37:04 -0400
Message-ID: <1114126624.17161.19.camel@dv>
References: <20050421123904.9F2EB7F8AD@smurf.noris.de>
	 <7vr7h3d9cu.fsf@assigned-by-dhcp.cox.net>
	 <20050421230732.GA13311@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junio@siamese.dyndns.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 01:33:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOlAE-000639-Q0
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 01:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVDUXhS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 19:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVDUXhS
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 19:37:18 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:6299 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261528AbVDUXhF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 19:37:05 -0400
Received: by localhost.localdomain (Postfix, from userid 500)
	id 6D5A0EFF81; Thu, 21 Apr 2005 19:37:04 -0400 (EDT)
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <20050421230732.GA13311@kiste.smurf.noris.de>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

On Fri, 2005-04-22 at 01:07 +0200, Matthias Urlichs wrote:
> Hi,
> 
> Junio C Hamano:
> > I sent essentially the same some time ago and got a comment to
> > follow established naming convention.
> > 
> Well, for a Makefile which installs in basically one directory, that
> seems to be overkill.
> 
> >     # DESTDIR=
> >     BINDIR=$(HOME)/bin
> >             install foobar $(DESTDIR)$(BINDIR)/
> > 
> That doesn't make sense; if you set DESTDIR, you are not going to
> install in $HOME.

It makes sense to stick with conventions.  DESTDIR is almost always set
by a script for making a package, and that script will likely set prefix
to /usr.

prefix is set to $HOME temporarily.  It should be changed to /usr/local
some day.  It's not uncommon for $HOME to be shared between systems with
different architectures, so ideally no binaries should be installed
there.  I guess $HOME is used to save typing "su" or redefining prefix
in a project that changes every 10 minutes or so.  But once git
stabilizes, there will be no excuse.

By the way, we need to change prefix and bindir to be lowercase for
compatibility with GNU standards.  Also, ifdef is not needed - command
line trumps even unconditional variable assignments.  Another thing to
fix - DESTDIR is not used when bindir is created.

Signed-off-by: Pavel Roskin <proski@gnu.org>

--- a/Makefile
+++ b/Makefile
@@ -14,12 +14,10 @@
 # (my ext3 doesn't).
 CFLAGS=-g -O2 -Wall
 
-ifndef PREFIX
-PREFIX=$(HOME)
-endif
-ifndef BINDIR
-BINDIR=$(PREFIX)/bin
-endif
+# Should be changed to /usr/local
+prefix=$(HOME)
+
+bindir=$(prefix)/bin
 
 CC=gcc
 AR=ar
@@ -81,8 +79,8 @@ gitversion.sh: $(VERSION)
 
 
 install: $(PROG) $(GEN_SCRIPT)
-	install -m755 -d $(BINDIR)
-	install $(PROG) $(SCRIPT) $(GEN_SCRIPT) $(DESTDIR)$(BINDIR)
+	install -m755 -d $(DESTDIR)$(bindir)
+	install $(PROG) $(SCRIPT) $(GEN_SCRIPT) $(DESTDIR)$(bindir)
 
 clean:
 	rm -f *.o mozilla-sha1/*.o $(PROG) $(GEN_SCRIPT) $(LIB_FILE)


-- 
Regards,
Pavel Roskin

