From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v5] Improve remote-helpers documentation
Date: Mon, 22 Mar 2010 22:24:07 +0530
Message-ID: <f3271551003220954s38ed80f2vde1a287d05ef4ad5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 22 17:54:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntktd-0001Q7-S4
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 17:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755301Ab0CVQy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 12:54:28 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64621 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755283Ab0CVQy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 12:54:28 -0400
Received: by gyg8 with SMTP id 8so2763892gyg.19
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 09:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:cc:content-type;
        bh=//1vU/dmXHJMPRk0svhFnD6MXraF93/oFV1xuoyH1eU=;
        b=ID02Dyf+Pi7AwJw3fLnIGsFZxS9b2oQBqdqNttETskBO5qF8wDdbbjyvVRtZzLOclQ
         8LYtPW4vlGovHMB7r8urvAhLsUcD3o7EySAyc3Gwp2kljWvrk7UYxXex1XfMyfKMIJmu
         4k7ucTDSTHmSt/TVZAhwAkGQ8I2uNmpkQEU50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=GQBtUYT8qblHsKJ7vUluKviZL55TqnBUOya/ebRIlfkQDA1Yxdi8VH1xu+vMIM+1ea
         1622lx9XVkGkwYMLEUUxSndgdrnNvvuaTy6ilQatDlN4OJKoXaRBWGcyHzCU/N+Mz72i
         IdRXOfdFHdeqElTPS61qI3PLCEKO7UVb0nUD4=
Received: by 10.90.237.16 with SMTP id k16mr4521639agh.14.1269276867098; Mon, 
	22 Mar 2010 09:54:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142947>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
Cosmetic change since v4: The capabilities fetch, option, push,
connect, and import are presented in a more elegant manner.

 Documentation/git-remote-helpers.txt |   35 +++++++++++++++++++--------------
 1 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt
b/Documentation/git-remote-helpers.txt
index 1b5f61a..990d302 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -3,7 +3,7 @@ git-remote-helpers(1)

 NAME
 ----
-git-remote-helpers - Helper programs for interoperation with remote git
+git-remote-helpers - Helper programs for interacting with remote repositories

 SYNOPSIS
 --------
@@ -13,10 +13,23 @@ DESCRIPTION
 -----------

 These programs are normally not used directly by end users, but are
-invoked by various git programs that interact with remote repositories
-when the repository they would operate on will be accessed using
-transport code not linked into the main git binary. Various particular
-helper programs will behave as documented here.
+invoked by various git programs that interact with remote
+repositories.  For a program to qualify as a remote helper, it must
+implement a subset of the capabilities documented here, and conform to
+the remote helper protocol. Remote helpers are spawned as binaries by
+the main git programs and interact using text streams, without
+linking.
+
+The curl helper is one such program. It is invoked via
+'git-remote-http', 'git-remote-https', 'git-remote-ftp', or
+'git-remote-ftps', and implments the capabilities 'fetch', 'option',
+and 'push'. The curl helper essentially helps in transporting native
+git objects.
+
+As opposed to native git objects, remote helpers can also provide a
+fast-import stream through the 'import' capability. This makes them
+especially useful when native interoperability with a foreign
+versioning system is desired.

 COMMANDS
 --------
@@ -119,16 +132,11 @@ CAPABILITIES
 ------------

 'fetch'::
-	This helper supports the 'fetch' command.
-
 'option'::
-	This helper supports the option command.
-
 'push'::
-	This helper supports the 'push' command.
-
+'connect'::
 'import'::
-	This helper supports the 'import' command.
+	This helper supports the corresponding command with the same name.

 'refspec' 'spec'::
 	When using the import command, expect the source ref to have
@@ -140,9 +148,6 @@ CAPABILITIES
 	all, it must cover all refs reported by the list command; if
 	it is not used, it is effectively "*:*"

-'connect'::
-	This helper supports the 'connect' command.
-
 REF LIST ATTRIBUTES
 -------------------

-- 
1.7.0.2
