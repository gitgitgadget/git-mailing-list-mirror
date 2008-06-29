From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 01/15] Move split_cmdline() to alias.c
Date: Sun, 29 Jun 2008 15:43:54 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806291542070.9925@racer>
References: <cover.1214581610.git.vmiklos@frugalware.org> <58b2c36de6a6f51a562da303695482bea567f4bf.1214581610.git.vmiklos@frugalware.org> <486796C3.7040304@free.fr> <alpine.DEB.1.00.0806291513450.9925@racer> <48679C44.30702@free.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-453453725-1214750637=:9925"
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Olivier Marin <dkr@freesurf.fr>
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Sun Jun 29 16:46:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCyB3-0002kA-9s
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 16:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760406AbYF2Opy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 10:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760383AbYF2Opy
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 10:45:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:53224 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760269AbYF2Opx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 10:45:53 -0400
Received: (qmail invoked by alias); 29 Jun 2008 14:45:51 -0000
Received: from 87.113.36.200.plusnet.pte-ag1.dyn.plus.net (EHLO racer.local) [87.113.36.200]
  by mail.gmx.net (mp038) with SMTP; 29 Jun 2008 16:45:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18CNSleyiECocq8ibCIjTRyVk5YkZ5ygM5Gy2nKMd
	VBvdeLeoNNQtxj
X-X-Sender: gene099@racer
In-Reply-To: <48679C44.30702@free.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86808>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-453453725-1214750637=:9925
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 29 Jun 2008, Olivier Marin wrote:

> Johannes Schindelin a écrit :
> > 
> > As the string comes either from the config (where it is trimmed), or 
> > from the command line (where the user can be stup^W^Wask for 
> > whitespace explicitely), I do not see much merit in this patch.
> 
> You are right, today it is not a problem because the usage is really 
> limited but Miklos's intention seems to make the function usable by 
> everyone. As we do not know how it will be used in the future, I think 
> it is safer with my patch.

I am generally not a fan of crossing bridges miles before you reach them.

But if you want to keep running with this, you should add at least a few 
tests to show what you patch solves, and that it solves it.  Preferably 
with a "test_expect_failure" patch, and then a patch fixing it and 
changing that _failure to _success.

Here's a starter:

-- snipsnap --
diff --git a/Makefile b/Makefile
index d3e339a..83a9a30 100644
--- a/Makefile
+++ b/Makefile
@@ -1229,7 +1229,7 @@ endif
 
 ### Testing rules
 
-TEST_PROGRAMS = test-chmtime$X test-genrandom$X test-date$X test-delta$X test-sha1$X test-match-trees$X test-absolute-path$X test-parse-options$X test-strbuf$X
+TEST_PROGRAMS = test-chmtime$X test-genrandom$X test-date$X test-delta$X test-sha1$X test-match-trees$X test-absolute-path$X test-parse-options$X test-strbuf$X test-cmdline$X
 
 all:: $(TEST_PROGRAMS)
 
diff --git a/test-cmdline.c b/test-cmdline.c
new file mode 100644
index 0000000..2f6d9eb
--- /dev/null
+++ b/test-cmdline.c
@@ -0,0 +1,15 @@
+#include "cache.h"
+
+int main(int argc, char **argv)
+{
+	int i = 0;
+	const char **new_argv;
+
+	if (argc < 2 || (argc = split_cmdline(argv[1], &new_argv)) < 0)
+		return 1;
+
+	while (i < argc)
+		printf("arg %d: '%s'\n", i++, *new_argv++);
+
+	return 0;
+}
--8323329-453453725-1214750637=:9925--
