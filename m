From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/RFC 1/6] modified asciidoc macros for dashless git doc
Date: Fri, 12 Sep 2008 12:55:20 +0200
Message-ID: <1221216926-20435-2-git-send-email-git@drmicha.warpmail.net>
References: <1221216926-20435-1-git-send-email-git@drmicha.warpmail.net>
Cc: Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 12:57:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke6L1-0003pN-S9
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 12:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000AbYILKzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 06:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752984AbYILKzn
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 06:55:43 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55402 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752712AbYILKzm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2008 06:55:42 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 345CD160EB2
	for <git@vger.kernel.org>; Fri, 12 Sep 2008 06:55:42 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 12 Sep 2008 06:55:42 -0400
X-Sasl-enc: QeKQKJHKjD5p7ZUFU2Y39GqtDIeLHLOzKhkMGpWoMBY1 1221216941
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 83C2127D9D;
	Fri, 12 Sep 2008 06:55:41 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.308.gede4c
In-Reply-To: <1221216926-20435-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95702>

This introduces a new macro "link-git" which prepends "git-" or "git "
to the link target, depending on the backend. We keep the dash for the
docbook backend because some man viewers depend on it. There are no
dashes for the html backend.

This patch also renames the existing "linkgit" macro to "linkgitasis", in
preparation for the upcoming changes. This makes it easier to split the
changes into parts: dashed form for server type programmes, dashless
form for all other commands.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/asciidoc.conf |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 40d43b7..efc8bd3 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -1,11 +1,15 @@
-## linkgit: macro
+## linkgitasis: macro
 #
-# Usage: linkgit:command[manpage-section]
+# Usage: linkgitasis:command[manpage-section]
 #
 # Note, {0} is the manpage section, while {target} is the command.
 #
 # Show GIT link as: <command>(<section>); if section is defined, else just show
 # the command.
+#
+## link-git: macro
+#
+# Like linkgitasis, but prepends "git " or "git -" to the target, depending on the backend.
 
 [attributes]
 asterisk=&#42;
@@ -16,11 +20,16 @@ endsb=&#93;
 tilde=&#126;
 
 ifdef::backend-docbook[]
-[linkgit-inlinemacro]
+[linkgitasis-inlinemacro]
 {0%{target}}
 {0#<citerefentry>}
 {0#<refentrytitle>{target}</refentrytitle><manvolnum>{0}</manvolnum>}
 {0#</citerefentry>}
+[link-git-inlinemacro]
+{0%{target}}
+{0#<citerefentry>}
+{0#<refentrytitle>git-{target}</refentrytitle><manvolnum>{0}</manvolnum>}
+{0#</citerefentry>}
 endif::backend-docbook[]
 
 ifdef::backend-docbook[]
@@ -62,6 +71,8 @@ endif::backend-docbook[]
 endif::doctype-manpage[]
 
 ifdef::backend-xhtml11[]
-[linkgit-inlinemacro]
+[linkgitasis-inlinemacro]
 <a href="{target}.html">{target}{0?({0})}</a>
+[link-git-inlinemacro]
+<a href="{target}.html">git {target}{0?({0})}</a>
 endif::backend-xhtml11[]
-- 
1.6.0.1.308.gede4c
