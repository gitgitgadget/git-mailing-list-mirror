From: Alex Chiang <achiang@hp.com>
Subject: [PATCH 2/6] stg mail: reorder __build_[message|cover] parameters
Date: Sat, 28 Nov 2009 12:50:21 -0700
Message-ID: <20091128195021.949.83804.stgit@bob.kio>
References: <20091128194056.949.88791.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Karl Wiberg <kha@treskal.com>
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sat Nov 28 20:50:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NETJM-0000Fa-LD
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 20:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881AbZK1TuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 14:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753815AbZK1TuQ
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 14:50:16 -0500
Received: from g4t0016.houston.hp.com ([15.201.24.19]:41756 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621AbZK1TuP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 14:50:15 -0500
Received: from g4t0018.houston.hp.com (g4t0018.houston.hp.com [16.234.32.27])
	by g4t0016.houston.hp.com (Postfix) with ESMTP id 1E575140AB;
	Sat, 28 Nov 2009 19:50:22 +0000 (UTC)
Received: from ldl (linux.corp.hp.com [15.11.146.101])
	by g4t0018.houston.hp.com (Postfix) with ESMTP id 0F93410055;
	Sat, 28 Nov 2009 19:50:22 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl (Postfix) with ESMTP id E3FE4CF0009;
	Sat, 28 Nov 2009 12:50:21 -0700 (MST)
Received: from ldl ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vqi8Dml7FdcU; Sat, 28 Nov 2009 12:50:21 -0700 (MST)
Received: from eh.fc.hp.com (eh.fc.hp.com [15.11.146.105])
	by ldl (Postfix) with ESMTP id CDF46CF0007;
	Sat, 28 Nov 2009 12:50:21 -0700 (MST)
Received: by eh.fc.hp.com (Postfix, from userid 17609)
	id B8BFF26172; Sat, 28 Nov 2009 12:50:21 -0700 (MST)
X-Mailer: git-send-email 1.6.5.2.74.g610f9
In-Reply-To: <20091128194056.949.88791.stgit@bob.kio>
User-Agent: StGit/0.15-6-g435b-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133975>

Reorder the argument lists for both __build_cover and __build_message.

This change will aid readability of a subsequent refactoring patch.

Cc: Karl Wiberg <kha@treskal.com>
Signed-off-by: Alex Chiang <achiang@hp.com>
---

 stgit/commands/mail.py |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 3978f5e..b6fc3d9 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -370,7 +370,7 @@ def __edit_message(msg):
 
     return msg
 
-def __build_cover(tmpl, patches, msg_id, options):
+def __build_cover(tmpl, msg_id, options, patches):
     """Build the cover message (series description) to be sent via SMTP
     """
     sender = __get_sender()
@@ -439,7 +439,7 @@ def __build_cover(tmpl, patches, msg_id, options):
 
     return msg
 
-def __build_message(tmpl, patch, patch_nr, total_nr, msg_id, ref_id, options):
+def __build_message(tmpl, msg_id, options, patch, patch_nr, total_nr, ref_id):
     """Build the message to be sent via SMTP
     """
     p = crt_series.get_patch(patch)
@@ -600,7 +600,7 @@ def func(parser, options, args):
                 raise CmdException, 'No cover message template file found'
 
         msg_id = email.Utils.make_msgid('stgit')
-        msg = __build_cover(tmpl, patches, msg_id, options)
+        msg = __build_cover(tmpl, msg_id, options, patches)
         from_addr, to_addr_list = __parse_addresses(msg)
 
         msg_string = msg.as_string(options.mbox)
@@ -630,8 +630,8 @@ def func(parser, options, args):
 
     for (p, patch_nr) in zip(patches, range(1, total_nr + 1)):
         msg_id = email.Utils.make_msgid('stgit')
-        msg = __build_message(tmpl, p, patch_nr, total_nr, msg_id, ref_id,
-                              options)
+        msg = __build_message(tmpl, msg_id, options, p, patch_nr, total_nr,
+                              ref_id)
         from_addr, to_addr_list = __parse_addresses(msg)
 
         msg_string = msg.as_string(options.mbox)
