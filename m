From: Robert Shearman <robertshearman@gmail.com>
Subject: [PATCH 4/4] Documentation: Improve documentation for git-imap-send(1).
Date: Wed,  9 Jul 2008 22:29:02 +0100
Message-ID: <1215638942-25010-4-git-send-email-robertshearman@gmail.com>
Cc: Robert Shearman <robertshearman@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 23:30:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGhFF-0003R6-E7
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 23:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbYGIV31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 17:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbYGIV30
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 17:29:26 -0400
Received: from gv-out-0910.google.com ([216.239.58.190]:24535 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbYGIV3X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 17:29:23 -0400
Received: by gv-out-0910.google.com with SMTP id e6so582369gvc.37
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 14:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=KQaiyLo/el/Eu1OuuYZrPrsu3CYTyZw1JvbNA6/J7bU=;
        b=J5UcQKMbeFzv+k9UscCHniTlMhFJYoun+2SXeP4Fe9Cdpls6W1/YnHkNzoUlGyzAZA
         G8FivdHC4EJ5sykSJOg+zslRK/pKxfVaQ6I6a5FOoxLOvl2GPgANK6WpfVN6cju6GgAN
         Blk0GGLI9oe2fatdDcjiSV2L/enXOcrU4qpXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=jz/8001JRGc19qWPvuNYBK5PIpFJeClrmGrs/yCU752AtB1Nq6+YPw9YAYgf9tqVLJ
         GcnxqabXbWzkD5B4l8WSwRc7V2O8qXyc5QUul5wbm2h9oVNngvBCtjm8QCqAheVo2xIP
         eAVmWpVeVAq3UyeRAo07SGpojh65uBEY/KOe8=
Received: by 10.125.107.19 with SMTP id j19mr2177790mkm.91.1215638961653;
        Wed, 09 Jul 2008 14:29:21 -0700 (PDT)
Received: from localhost.localdomain ( [86.155.123.155])
        by mx.google.com with ESMTPS id 30sm5779287hue.55.2008.07.09.14.29.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Jul 2008 14:29:20 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.2.224.g26efb.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87919>

Change the description to be similar to that used for git-send-email(1) to give a better description of what the tool can be used for and sound more user-friendly.

Document the configuration variables used by git-imap-send, split the example into tunnel and direct examples. Rephrase other parts of the git-imap-send documentation to use better grammar and to be clearer.

Signed-off-by: Robert Shearman <robertshearman@gmail.com>
---
 Documentation/git-imap-send.txt |   77 +++++++++++++++++++++++++++++++++------
 1 files changed, 65 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 136c82b..f9e7288 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -3,7 +3,7 @@ git-imap-send(1)
 
 NAME
 ----
-git-imap-send - Dump a mailbox from stdin into an imap folder
+git-imap-send - Send a collection of patches from stdin to an IMAP folder
 
 
 SYNOPSIS
@@ -13,9 +13,9 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-This command uploads a mailbox generated with git-format-patch
-into an imap drafts folder.  This allows patches to be sent as
-other email is sent with mail clients that cannot read mailbox
+This command uploads a mailbox generated with git format-patch
+into an IMAP drafts folder.  This allows patches to be sent as
+other email is when using mail clients that cannot read mailbox
 files directly.
 
 Typical usage is something like:
@@ -26,21 +26,74 @@ git format-patch --signoff --stdout --attach origin | git imap-send
 CONFIGURATION
 -------------
 
-'git-imap-send' requires the following values in the repository
-configuration file (shown with examples):
+To use the tool imap.folder and either imap.tunnel or imap.host must be set
+to appropriate values.
+
+Variables
+~~~~~~~~~
+
+imap.folder::
+	The folder to drop the mails into, which is typically the Drafts
+	folder. For example: "INBOX.Drafts", "INBOX/Drafts" or
+	"[Gmail]/Drafts". Required to use imap-send.
+
+imap.tunnel::
+	Command used to setup a tunnel to the IMAP server through which
+	commands will be piped instead of using a direct network connection
+	to the server. Required when imap.host is not set to use imap-send.
+
+imap.host::
+	A URL identifying the server. Use a `imap://` prefix for non-secure
+	connections and a `imaps://` prefix for secure connections.
+	Ignored when imap.tunnel is set, but required to use imap-send
+	otherwise.
+
+imap.user::
+	The username to use when logging in to the server.
+
+imap.password::
+	The password to use when logging in to the server.
+ 
+imap.port::
+	An integer port number to connect to on the server.
+	Defaults to 143 for imap:// hosts and 993 for imaps:// hosts.
+	Ignored when imap.tunnel is set.
+
+imap.sslverify::
+	A boolean to enable/disable verification of the server certificate
+	used by the SSL/TLS connection. Default is `true`. Ignored when
+	imap.tunnel is set.
+
+Examples
+~~~~~~~~
+
+Using tunnel mode:
 
 ..........................
 [imap]
-    Folder = "INBOX.Drafts"
+    folder = "INBOX.Drafts"
+    tunnel = "ssh -q -C user@example.com /usr/bin/imapd ./Maildir 2> /dev/null"
+..........................
 
+Using direct mode:
+
+.........................
 [imap]
-    Tunnel = "ssh -q user@server.com /usr/bin/imapd ./Maildir 2> /dev/null"
+    folder = "INBOX.Drafts"
+    host = imap://imap.example.com
+    user = bob
+    pass = p4ssw0rd
+..........................
+
+Using direct mode with SSL:
 
+.........................
 [imap]
-    Host = imap://imap.example.com
-    User = bob
-    Pass = pwd
-    Port = 143
+    folder = "INBOX.Drafts"
+    host = imaps://imap.example.com
+    user = bob
+    pass = p4ssw0rd
+    port = 123
     sslverify = false
 ..........................
 
-- 
1.5.6.2.224.g26efb.dirty
