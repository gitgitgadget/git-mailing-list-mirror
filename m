From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Check git pull remote before defaulting to 'origin'
Date: Tue, 09 Jan 2007 02:20:05 -0500
Message-ID: <1168327205.7890.2.camel@dv>
References: <1165657360.2816.61.camel@portland.localdomain>
	 <b0943d9e0612100841h7d064c7cs37f882f91e3eddf8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 08:20:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4BHm-0007l6-2W
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 08:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbXAIHUK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 02:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbXAIHUK
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 02:20:10 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:48344 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbXAIHUI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 02:20:08 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1H4BGl-0006RO-CW
	for git@vger.kernel.org; Tue, 09 Jan 2007 02:19:39 -0500
Received: from proski by gnu.org with local (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1H4BHB-0004eg-Jt; Tue, 09 Jan 2007 02:20:05 -0500
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <b0943d9e0612100841h7d064c7cs37f882f91e3eddf8@mail.gmail.com>
X-Mailer: Evolution 2.8.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36322>

Check git pull remote before defaulting to 'origin'

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 stgit/commands/pull.py |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 227249e..7c5db22 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -50,10 +50,16 @@ def func(parser, options, args):
     if len(args) > 2:
         parser.error('incorrect number of arguments')
 
-    repository = 'origin'
-    refspec = None
     if len(args) >= 1:
         repository = args[0]
+    else:
+        section = 'branch "%s"' % git.get_head_file()
+        if config.has_option(section, 'remote'):
+            repository = config.get(section, 'remote')
+        else:
+            repository = 'origin'
+
+    refspec = None
     if len(args) == 2:
         refspec = args[1]
 

-- 
Regards,
Pavel Roskin
