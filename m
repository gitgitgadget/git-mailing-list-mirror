From: Hannes Eder <hannes@hanneseder.net>
Subject: [STGIT][PATCH] new: translate non word characters in patch name to '-'
Date: Sat, 27 Dec 2008 13:37:20 +0100
Message-ID: <49562413.0437560a.287d.5133@mx.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 27 13:53:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGYfo-0004cL-0D
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 13:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603AbYL0MsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2008 07:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753509AbYL0MsW
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 07:48:22 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:25506 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480AbYL0MsV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 07:48:21 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1485250fgg.17
        for <git@vger.kernel.org>; Sat, 27 Dec 2008 04:48:20 -0800 (PST)
Received: by 10.86.29.8 with SMTP id c8mr6923754fgc.19.1230382100191;
        Sat, 27 Dec 2008 04:48:20 -0800 (PST)
Received: from vmbox.hanneseder.net (p549E620B.dip.t-dialin.net [84.158.98.11])
        by mx.google.com with ESMTPS id d4sm24477125fga.31.2008.12.27.04.48.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Dec 2008 04:48:19 -0800 (PST)
Received: by vmbox.hanneseder.net (sSMTP sendmail emulation); Sat, 27 Dec 2008 13:48:15 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104002>

This allows following usage:

$ stg new full/path/file-fix-foobar
Now at patch "full-path-file-fix-foobar"

Signed-off-by: Hannes Eder <hannes@hanneseder.net>
---

I ran into as a '/' in a patch messed up stgit.

I find this useful as 'stg uncommit' does the same translation.

 stgit/commands/new.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/new.py b/stgit/commands/new.py
index 151cfe9..ab09476 100644
--- a/stgit/commands/new.py
+++ b/stgit/commands/new.py
@@ -58,7 +58,7 @@ def func(parser, options, args):
     if len(args) == 0:
         name = None
     elif len(args) == 1:
-        name = args[0]
+        name = utils.patch_name_from_msg(args[0])
         if stack.patches.exists(name):
             raise common.CmdException('%s: patch already exists' % name)
     else:
