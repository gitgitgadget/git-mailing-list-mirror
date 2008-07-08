From: Robert Shearman <robertshearman@gmail.com>
Subject: [PATCH 4/4] Documentation: Improve documentation for git-imap-send(1).
Date: Tue,  8 Jul 2008 23:18:16 +0100
Message-ID: <1215555496-21335-4-git-send-email-robertshearman@gmail.com>
Cc: Robert Shearman <robertshearman@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 00:19:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGLXK-0000dv-MQ
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 00:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636AbYGHWSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 18:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754466AbYGHWSl
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 18:18:41 -0400
Received: from gv-out-0910.google.com ([216.239.58.191]:9558 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754217AbYGHWSi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 18:18:38 -0400
Received: by gv-out-0910.google.com with SMTP id e6so474296gvc.37
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 15:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=0+D31uxPmHCY10VoE3IhMbMkEziPwjZiO6r4OuBl/gM=;
        b=KiLR0/Fbz8oT0mfeM/SYKm9TF2ZokBSOgUM4sKH02qRTL9V474tJS++2OlnfZtb5Ri
         0ojW8UrMLClGHf96Cim+T5Ap9YZTgbD9I21RGuDUND4/Ah8Gkx4OOksvaT6Q63pZRCWl
         Si3n8FlxzBRzZb8n7va9A4EsYr5R58kIAdTvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=BQFYRYqJ3xFQzOZHLQlUYSYosw5EFy5Za/ylgcBcmYCztdFWj3CpWf8HvMOONFynYL
         A7QPKfBytwmllpXYuFb12zzOy3RYB/tBvh+efTDUYawZDLXHPn7wMHgI/rWABqfn1rhQ
         X6Os3ZRKodjcPDcrt7670RbzNO8GD1PyzCbg4=
Received: by 10.125.89.5 with SMTP id r5mr1618206mkl.137.1215555514791;
        Tue, 08 Jul 2008 15:18:34 -0700 (PDT)
Received: from localhost.localdomain ( [86.155.123.155])
        by mx.google.com with ESMTPS id p9sm12934768fkb.5.2008.07.08.15.18.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jul 2008 15:18:33 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.2.224.g26efb.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87804>

Change the description to be similar to that used for git-send-email(1) to give a better description of what the tool can be used for and sound more user-friendly.

Document the configuration variables used by git-imap-send, split the example into tunnel and direct examples. Rephrase other parts of the git-imap-send documentation to use better grammar and to be clearer.
---
 Documentation/git-imap-send.txt |   65 +++++++++++++++++++++++++++++++--------
 1 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index e4a5873..4429e06 100644
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
@@ -26,21 +26,60 @@ git format-patch --signoff --stdout --attach origin | git imap-send
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
+	folder. For example: "INBOX.Drafts". Required to use imap-send.
+
+imap.tunnel::
+	Command used to setup a tunnel to the IMAP server through which
+	commands will be piped instead of using a direct network connection
+	to the server. Required when imap.host is not set to use imap-send.
+
+imap.host::
+	A URL identifying the server. Use a `imap://` prefix for non-secure
+	connections and a `imaps://` prefix for secure connections.
+	Required when imap.tunnel is not set to use imap-send.
+
+imap.user::
+	The username to use when logging in to the server.
+
+imap.password::
+	The password to use when logging in to the server.
+ 
+imap.port::
+	An integer port number to connect to on the server.
+	Defaults to 143 for imap:// and 993 for imaps://.
+
+imap.sslverify::
+	A boolean to enable/disable verification of the server certificate
+	used by the SSL/TLS connection. Default is `true`.
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
 
-[imap]
-    Tunnel = "ssh -q user@server.com /usr/bin/imapd ./Maildir 2> /dev/null"
+Using direct mode:
 
+.........................
 [imap]
-    Host = imaps://imap.example.com
-    User = bob
-    Pass = pwd
-    Port = 993
+    folder = "[Gmail]/Drafts"
+    host = imaps://imap.example.com
+    user = bob
+    pass = p4ssw0rd
+    port = 123
     sslverify = false
 ..........................
 
-- 
1.5.6.GIT
