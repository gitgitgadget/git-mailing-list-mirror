From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH] config.mak.in: remove unused definitions
Date: Sat, 02 Feb 2013 17:58:49 -0800
Message-ID: <7v1ucyb1k6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 02:59:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1orU-0005nX-NI
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 02:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681Ab3BCB6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2013 20:58:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37399 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501Ab3BCB6w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2013 20:58:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D81CCCF08;
	Sat,  2 Feb 2013 20:58:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=J
	akm9DnXmXY2DHypeGly1Dx0RWY=; b=x09R0MDehlbG6Kd31oCBDPrGMInBForwj
	Lg4oAMD1/MxGnlz9fDUGKGhK87srVj3NPq+mEpE3EWlBC7zbGyjVz+VLE83SXajO
	pJP5ktffyq2IbxuH6czx2PtaLGchQbcIjd69RbiNr4qtlQxzDLMyTjvMEMW74Sww
	sOAIU6XCmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=HQadOXpivoJ31JBZ7jHQ59NnT3Guptj3nIsfsEt6GWByhGELaQE9Dwl/
	sAKEyjdiax16pLmI38nDGq8BCOBTKEOSOv4ROkf7sBX61TM95VRAZWH79iiP7/5+
	xqJ0euRJnb5rgPR1kYFFD5tjhMzMPi6Jo5BP+hkIrArZDOuXgUI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD0EECF07;
	Sat,  2 Feb 2013 20:58:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E9DFCF06; Sat,  2 Feb 2013
 20:58:51 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41AB05A8-6DA5-11E2-884B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215296>

When 5566771 (autoconf: Use autoconf to write installation
directories to config.mak.autogen, 2006-07-03) introduced support
for autoconf generated config.mak file, it added a few "export",
in addition to definitions of srcdir and VPATH.

These "export" logically does not belong there.  The common make
variables like mandir, prefix, etc, should be exported to submakes
for people who use config.mak and people who use config.mak.autogen
the same way, so if we want to get these exported, that should be in
the main Makefile, no?

We do use mandir and htmldir in Documentation/Makefile, so let's
add export for them in the main Makefile instead.

We may eventually want to support VPATH, and srcdir may turn out to
be useful for that purpose, but right now nobody uses it, so it is
useless to define them in this file.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * As everybody knows, I do not use autoconf/configure, so this may
   be breaking things for those who do.  Comments, objectsions, and
   general education etc. are very much appreciated.

 Makefile      | 2 +-
 config.mak.in | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 731b6a8..e946402 100644
--- a/Makefile
+++ b/Makefile
@@ -384,7 +384,7 @@ lib = lib
 # DESTDIR =
 pathsep = :
 
-export prefix bindir sharedir sysconfdir gitwebdir localedir
+export prefix bindir sharedir mandir htmldir sysconfdir gitwebdir localedir
 
 CC = cc
 AR = ar
diff --git a/config.mak.in b/config.mak.in
index e8a9bb4..f87c18c 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -11,7 +11,6 @@ DIFF = @DIFF@
 #INSTALL = @INSTALL@		# needs install-sh or install.sh in sources
 
 prefix = @prefix@
-exec_prefix = @exec_prefix@
 bindir = @bindir@
 gitexecdir = @libexecdir@/git-core
 datarootdir = @datarootdir@
@@ -19,9 +18,3 @@ template_dir = @datadir@/git-core/templates
 sysconfdir = @sysconfdir@
 
 mandir = @mandir@
-
-srcdir = @srcdir@
-VPATH = @srcdir@
-
-export exec_prefix mandir
-export srcdir VPATH
