From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Add support reading default options from conf file
Date: Thu, 9 Jun 2005 03:00:56 +0200
Message-ID: <20050609010056.GA9084@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Jun 09 02:58:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgBMe-00058T-No
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 02:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262199AbVFIBBg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 21:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVFIBBf
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 21:01:35 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:37589 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S262199AbVFIBA7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 21:00:59 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 864CD6E1419; Thu,  9 Jun 2005 03:00:10 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 47C636DFEEB; Thu,  9 Jun 2005 03:00:10 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 0730D61FE0; Thu,  9 Jun 2005 03:00:56 +0200 (CEST)
To: Dan Holmsand <holmsand@gmail.com>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Reply-To: 
In-Reply-To: <42A754D5.10705@gmail.com>

Dan Holmsand <holmsand@gmail.com> wrote Wed, Jun 08, 2005:
> - Automatic color if the COGITO_AUTO_COLOR environment variable is set.

[ This has been discussed before. Default arguments. The 'new' cg
  wrapper makes this very easy. Not as smart as your env variable
  handling tho'. ]

The default options are read only for Cogito calls going through the new
cg wrapper which makes it trivial to 'overwrite' them by just calling
cg-COMMAMD.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 Documentation/make-cogito-asciidoc |   12 ++++++++++++
 cg                                 |    6 +++++-
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/Documentation/make-cogito-asciidoc b/Documentation/make-cogito-asciidoc
--- a/Documentation/make-cogito-asciidoc
+++ b/Documentation/make-cogito-asciidoc
@@ -140,6 +140,18 @@ FILE::
 	Indicates an already existing filename - always relative to the root
 	of the repository.
 
+FILES
+-----
+~/.cogito.conf::
+	This file is read when running the \`cg\` wrapper program and
+	contains information about default options. Each line consists
+	of a command name and a list of options. Empty lines and lines
+	starting with '#' are ignored. To always have \`cg log\` and
+	\`cg diff\` output colored put the following in ~/.cogito.conf:
+
+		log -c
+		diff -c
+
 COPYRIGHT
 ---------
 Copyright (C) Petr Baudis, 2005.
diff --git a/cg b/cg
--- a/cg
+++ b/cg
@@ -3,5 +3,9 @@
 cmd="$1"; shift
 [ x"$cmd" = x"--help" ] && cmd="help"
 
+if [ -e "$HOME/.cogito.conf" ]; then
+	defaults="$(grep "^$cmd" "$HOME/.cogito.conf" | sed "s/^$cmd //")"
+fi
+
 exe="cg-$cmd"
-exec $exe "$@"
+exec $exe "$defaults" "$@"

-- 
Jonas Fonseca
