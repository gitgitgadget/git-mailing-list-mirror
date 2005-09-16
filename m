From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [patch 04/11] Fix "mail" command when description contains "From" lines
Date: Fri, 16 Sep 2005 21:35:16 +0200
Message-ID: <20050916193516.18681.83723.stgit@zion.home.lan>
References: <20050916193511.18681.24189.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 21:39:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGM2U-0005pe-Om
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 21:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965306AbVIPTiU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 15:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965305AbVIPTiU
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 15:38:20 -0400
Received: from ppp-62-11-79-165.dialup.tiscali.it ([62.11.79.165]:26507 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965306AbVIPTiU
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 15:38:20 -0400
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id 7A55728542;
	Fri, 16 Sep 2005 21:35:16 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20050916193511.18681.24189.stgit@zion.home.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8711>

For kernel patches, the "From" line from the email is often preserved in
the patch itself, and the one from the email is sometimes lost, so I add an
explicit one. And mail barfes on this.
Fix it up.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 stgit/commands/mail.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -122,7 +122,7 @@ def __parse_addresses(string):
         elif re.match('(to|cc|bcc):\s+', line, re.I):
             to_addr_list += __addr_list(line)
 
-    if len(from_addr_list) != 1:
+    if len(from_addr_list) == 0:
         raise CmdException, 'No "From" address'
     if len(to_addr_list) == 0:
         raise CmdException, 'No "To/Cc/Bcc" addresses'
