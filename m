From: Max Horn <max@quendi.de>
Subject: [PATCH v2 5/6] git-remote-helpers.txt: clarify command <-> capability correspondences
Date: Wed, 28 Nov 2012 00:03:25 +0100
Message-ID: <1354057407-83151-6-git-send-email-max@quendi.de>
References: <1354057407-83151-1-git-send-email-max@quendi.de>
Cc: Max Horn <max@quendi.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 00:04:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdUCS-0005AE-D9
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 00:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755764Ab2K0XDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 18:03:48 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:53659 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754355Ab2K0XDr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2012 18:03:47 -0500
Received: from ip-178-200-227-112.unitymediagroup.de ([178.200.227.112] helo=localhost.localdomain); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1TdUBt-0001yU-HL; Wed, 28 Nov 2012 00:03:45 +0100
X-Mailer: git-send-email 1.8.0.393.gcc9701d
In-Reply-To: <1354057407-83151-1-git-send-email-max@quendi.de>
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1354057427;a49318a8;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210614>

In particular, document 'list for-push' separately from 'list', as
the former needs only be supported for the push/export
capabilities, and the latter only for fetch/import. Indeed, a
hypothetically 'push-only' helper would only need to support the
former, not the latter.

Signed-off-by: Max Horn <max@quendi.de>
---
 Documentation/git-remote-helpers.txt | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 7ac1461..023dcca 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -216,6 +216,8 @@ Commands are given by the caller on the helper's standard input, one per line.
 	which marks them mandatory for git versions using the remote
 	helper to understand. Any unknown mandatory capability is a
 	fatal error.
++
+Support for this command is mandatory.
 
 'list'::
 	Lists the refs, one per line, in the format "<value> <name>
@@ -225,9 +227,18 @@ Commands are given by the caller on the helper's standard input, one per line.
 	the name; unrecognized attributes are ignored. The list ends
 	with a blank line.
 +
-If 'push' is supported this may be called as 'list for-push'
-to obtain the current refs prior to sending one or more 'push'
-commands to the helper.
+Supported if the helper has the "fetch" or "import" capability.
+
+'list for-push'::
+	Similar to 'list', except that it is used if and only if
+	the caller wants to the resulting ref list to prepare
+	push commands.
+	A helper supporting both push and fetch can use this
+	to distinguish for which operation the output of 'list'
+	is going to be used, possibly reducing the amount
+	of work that needs to be performed.
++
+Supported if the helper has the "push" or "export" capability.
 
 'option' <name> <value>::
 	Sets the transport helper option <name> to <value>.  Outputs a
@@ -306,7 +317,7 @@ sequence has to be buffered before starting to send data to fast-import
 to prevent mixing of commands and fast-import responses on the helper's
 stdin.
 +
-Supported if the helper has the 'import' capability.
+Supported if the helper has the "import" capability.
 
 'export'::
 	Instructs the remote helper that any subsequent input is
@@ -322,7 +333,7 @@ fast-export', which then will load/store a table of marks for
 local objects. This can be used to implement for incremental
 operations.
 +
-Supported if the helper has the 'export' capability.
+Supported if the helper has the "export" capability.
 
 'connect' <service>::
 	Connects to given service. Standard input and standard output
-- 
1.8.0.393.gcc9701d
