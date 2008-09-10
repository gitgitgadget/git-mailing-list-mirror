From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: [PATCH 2/2] separate build targets for man and html documentation
Date: Wed, 10 Sep 2008 10:19:34 +0200
Message-ID: <81ce09dd0ac69ee7e09731e3ad26ff7cd1ab0765.1221035620.git.michaeljgruber+gmane@fastmail.fm>
References: <cover.1221035620.git.michaeljgruber+gmane@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 10 11:06:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdLek-0001Rc-I0
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 11:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbYIJJF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 05:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbYIJJF1
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 05:05:27 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:33560 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751720AbYIJJFY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Sep 2008 05:05:24 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id B80A715FDF5
	for <git@vger.kernel.org>; Wed, 10 Sep 2008 05:05:23 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 10 Sep 2008 05:05:23 -0400
X-Sasl-enc: laDmvmgGNFu031FajRaMkk1TUy0ssNBNxMQMGSfAtlmW 1221037523
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 387EA25BCE
	for <git@vger.kernel.org>; Wed, 10 Sep 2008 05:05:23 -0400 (EDT)
X-Mailbox-Line: From 81ce09dd0ac69ee7e09731e3ad26ff7cd1ab0765 Mon Sep 17 00:00:00 2001
In-Reply-To: <cover.1221035620.git.michaeljgruber+gmane@fastmail.fm>
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95500>

This introduces new build targets "man" and "html" which allow building
the documentation in the respective formats separately. This helps
people with a partial documentation build chain: html pages can be built
without xmlto.

This is documented in INSTALL now, together with corrections: Before,
instructions in INSTALL would build man+html but install man only. Now
the instructions build and install both, and new and pre-existing
targets are explained.

Note that build targets "doc" and "man" correspond to install targets
"install-doc install-html" and "install-doc" respectively. This
inconsistency is not changed, in order to keep everyone's build scripts
from breaking.

Signed-off-by: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
---
 INSTALL  |   15 ++++++++++++---
 Makefile |    6 ++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/INSTALL b/INSTALL
index 7c13473..a40d77d 100644
--- a/INSTALL
+++ b/INSTALL
@@ -6,7 +6,7 @@ will install the git programs in your own ~/bin/ directory.  If you want
 to do a global install, you can do
 
 	$ make prefix=/usr all doc info ;# as yourself
-	# make prefix=/usr install install-doc install-info ;# as root
+	# make prefix=/usr install install-doc install-html install-info ;# as root
 
 (or prefix=/usr/local, of course).  Just like any program suite
 that uses $prefix, the built results have some paths encoded,
@@ -19,7 +19,7 @@ set up install paths (via config.mak.autogen), so you can write instead
 	$ make configure ;# as yourself
 	$ ./configure --prefix=/usr ;# as yourself
 	$ make all doc ;# as yourself
-	# make install install-doc ;# as root
+	# make install install-doc install-html;# as root
 
 
 Issues of note:
@@ -89,13 +89,22 @@ Issues of note:
    inclined to install the tools, the default build target
    ("make all") does _not_ build them.
 
+   "make doc" builds documentation in man and html formats; there are
+   also "make man", "make html" and "make info". Note that "make html"
+   requires asciidoc, but not xmlto. "make man" (and thus make doc)
+   requires both.
+
+   "make install-doc" installs documentation in man format only; there
+   are also "make install-man", "make install-html" and "make
+   install-info".
+
    Building and installing the info file additionally requires
    makeinfo and docbook2X.  Version 0.8.3 is known to work.
 
    The documentation is written for AsciiDoc 7, but "make
    ASCIIDOC8=YesPlease doc" will let you format with AsciiDoc 8.
 
-   Alternatively, pre-formatted documentation are available in
+   Alternatively, pre-formatted documentation is available in
    "html" and "man" branches of the git repository itself.  For
    example, you could:
 
diff --git a/Makefile b/Makefile
index eeaf6d4..66e1982 100644
--- a/Makefile
+++ b/Makefile
@@ -1265,6 +1265,12 @@ $(XDIFF_LIB): $(XDIFF_OBJS)
 doc:
 	$(MAKE) -C Documentation all
 
+man:
+	$(MAKE) -C Documentation man
+
+html:
+	$(MAKE) -C Documentation html
+
 info:
 	$(MAKE) -C Documentation info
 
-- 
1.6.0.1.285.g1070
