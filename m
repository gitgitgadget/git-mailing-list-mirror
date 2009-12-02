From: Alex Chiang <achiang@hp.com>
Subject: [StGit PATCH v2 2/6] stg mail: reorder __build_[message|cover] parameters
Date: Tue,  1 Dec 2009 17:46:11 -0700
Message-ID: <20091202004611.7737.85922.stgit@bob.kio>
References: <20091202003503.7737.51579.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Karl Wiberg <kha@treskal.com>
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Wed Dec 02 01:46:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFdMj-0005qg-0c
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 01:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754978AbZLBAqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 19:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754976AbZLBAqV
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 19:46:21 -0500
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:23380 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754972AbZLBAqU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 19:46:20 -0500
Received: from g5t0030.atlanta.hp.com (g5t0030.atlanta.hp.com [16.228.8.142])
	by g5t0007.atlanta.hp.com (Postfix) with ESMTP id 14D2214994;
	Wed,  2 Dec 2009 00:46:27 +0000 (UTC)
Received: from ldl (linux.corp.hp.com [15.11.146.101])
	by g5t0030.atlanta.hp.com (Postfix) with ESMTP id EF0B314107;
	Wed,  2 Dec 2009 00:46:11 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl (Postfix) with ESMTP id C1B2BCF000A;
	Tue,  1 Dec 2009 17:46:11 -0700 (MST)
Received: from ldl ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id odRLey+Yav7u; Tue,  1 Dec 2009 17:46:11 -0700 (MST)
Received: from eh.fc.hp.com (eh.fc.hp.com [15.11.146.105])
	by ldl (Postfix) with ESMTP id AD600CF0007;
	Tue,  1 Dec 2009 17:46:11 -0700 (MST)
Received: by eh.fc.hp.com (Postfix, from userid 17609)
	id 9BB0526160; Tue,  1 Dec 2009 17:46:11 -0700 (MST)
X-Mailer: git-send-email 1.6.5.2.74.g610f9
In-Reply-To: <20091202003503.7737.51579.stgit@bob.kio>
User-Agent: StGit/0.15-6-gc6f39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134275>

Reorder the argument lists for both __build_cover and __build_message.

This change will aid readability of a subsequent refactoring patch.

Cc: Karl Wiberg <kha@treskal.com>
Signed-off-by: Alex Chiang <achiang@hp.com>
---

 stgit/commands/mail.py |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index a38e3e6..35194a8 100644
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
