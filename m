From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [patch 11/11] Detect description in quilt patches
Date: Fri, 16 Sep 2005 21:35:25 +0200
Message-ID: <20050916193525.18681.4203.stgit@zion.home.lan>
References: <20050916193511.18681.24189.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 21:39:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGM2E-0005id-B2
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 21:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965298AbVIPTiI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 15:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbVIPTiI
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 15:38:08 -0400
Received: from ppp-62-11-79-165.dialup.tiscali.it ([62.11.79.165]:24715 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965298AbVIPTiH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 15:38:07 -0400
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id 313A62873D;
	Fri, 16 Sep 2005 21:35:25 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20050916193511.18681.24189.stgit@zion.home.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8713>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The current logic imports the whole quilt patch as description - the changes
themselves are correctly applied, luckily, but the description must be fixed up
by hand.
So, detect "Index: " lines as patch start. I've heard rumors that also
Subversion generates this format, so we become compatible with it, too.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 stgit/commands/imprt.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/imprt.py b/stgit/commands/imprt.py
--- a/stgit/commands/imprt.py
+++ b/stgit/commands/imprt.py
@@ -96,7 +96,8 @@ def __parse_mail(filename = None):
 
     # the rest of the patch description
     for line in f:
-        if re.match('---\s*$', line) or re.match('diff -', line):
+        if re.match('---\s*$', line) or re.match('diff -', line) or \
+                re.match('^Index: ', line):
             break
         else:
             descr += line
