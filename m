From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 1/5] engine.pl: Fix i18n -o option in msvc buildsystem generator
Date: Wed, 24 Dec 2014 10:47:10 +0000
Message-ID: <1419418034-6276-2-git-send-email-philipoakley@iee.org>
References: <1419418034-6276-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Msysgit <msysgit@googlegroups.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 24 11:47:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3jTW-0004aY-KB
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 11:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbaLXKrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2014 05:47:17 -0500
Received: from b216.a.smtp2go.com ([216.22.18.216]:35832 "EHLO
	b216.a.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbaLXKrP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2014 05:47:15 -0500
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1419418034-6276-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261803>

The i18n 5e9637c (i18n: add infrastructure for translating
Git with gettext, 2011-11-18) introduced an extra '-o' option
into the make file, which broke engine.pl code for extracting
the git.sln for msvc gui-IDE.

Add tests to remove these non linker options, in same vein as
74cf9bd (engine.pl: Fix a recent breakage of the buildsystem
generator, 2010-01-22).

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 contrib/buildsystems/engine.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 23da787..f48c28a 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -140,6 +140,12 @@ sub parseMakeOutput
             next;
         }
 
+        if ($text =~ /^(mkdir|msgfmt) /) {
+            # options to the Portable Object translations
+            # the line "mkdir ... && msgfmt ..." contains no linker options
+            next;
+        }
+
         if($text =~ / -c /) {
             # compilation
             handleCompileLine($text, $line);
-- 
2.1.0
