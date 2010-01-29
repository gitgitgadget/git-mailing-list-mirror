From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] add shebang line to git-mergetool--lib.sh
Date: Fri, 29 Jan 2010 05:37:23 -0500
Message-ID: <20100129103723.GC6025@coredump.intra.peff.net>
References: <20100129102518.GA5875@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 11:37:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaoEH-0007IB-DX
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 11:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022Ab0A2Kh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 05:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752172Ab0A2Kh1
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 05:37:27 -0500
Received: from peff.net ([208.65.91.99]:53886 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303Ab0A2Kh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 05:37:26 -0500
Received: (qmail 4039 invoked by uid 107); 29 Jan 2010 10:37:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 29 Jan 2010 05:37:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jan 2010 05:37:23 -0500
Content-Disposition: inline
In-Reply-To: <20100129102518.GA5875@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138310>

Even though this script is expected to be sourced instead of
executed on its own, the #!/bin/sh line provides simple
documentation about what format the file is in.

In particular, the lack of such a line was confusing the
valgrind support of our test scripts, which assumed that any
executable without a #!-line should be intercepted and run
through valgrind. So during valgrind-enabled tests, any
script sourcing this file actually sourced the valgrind
interception script instead.

Signed-off-by: Jeff King <peff@peff.net>
---
The valgrind script could perhaps be a bit smarter instead, but checking
#!-lines is nice and simple, and this change makes other programs like
"file" happier, too.

This problem has been around since 21d0ba7 (difftool/mergetool: refactor
commands to use git-mergetool--lib, 2009-04-08), released in v1.6.3. But
since it is only about our internal tests, and even then only about
running them with valgrind enabled, I don't know if it is worth a fix on
'maint'.

 git-mergetool--lib.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 5b62785..51dd0d6 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 # git-mergetool--lib is a library for common merge tool functions
 diff_mode() {
 	test "$TOOL_MODE" = diff
-- 
1.7.0.rc0.41.g538720
