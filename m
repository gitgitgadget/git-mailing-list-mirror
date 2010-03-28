From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v7 1/2] Documentation/remote-helpers: Rewrite description
Date: Sun, 28 Mar 2010 23:33:50 +0530
Message-ID: <f3271551003281103x68812b3cj806d6235965f0a32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 20:04:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvwqY-0001zs-DM
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 20:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903Ab0C1SEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 14:04:12 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45882 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874Ab0C1SEK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 14:04:10 -0400
Received: by gwaa18 with SMTP id a18so3601409gwa.19
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 11:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:cc:content-type;
        bh=i3LqKBcyytzi/UsPCq8JEq0Dus4jj2YJ5z8Shr2y/fs=;
        b=mhE/ovRxplhVA/e36k/nQFjfRMi5/RdZLCgwCje7r/3hwCXBL203D/Jf+LZJyQUY7T
         0NZ4G04bKVTxSWb5iPN+ydYq0HMaqenuNlr6oiE2UYY0dFgVT9AZOEbkuLbYg+dsCtru
         VEk02Rt2AZmYXI36op1CgSibpKUOc3+sfoXbY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=tPFI/lTkeJxRDAXN8CHsmqCxHlIRHFFrunTqsyI3gi60xv0xjR7AViG6Xxf3DoclBi
         RFaacCWRJU2GnEFeRQahzyYwsZ4Jc5qsSw2L5L/QePKUzI5IV9kwNRHS+3HnU3grbBys
         EqtFV/Oa3gIBKT4YYkB57O2dTJgtWnkADaJ7U=
Received: by 10.90.69.14 with HTTP; Sun, 28 Mar 2010 11:03:50 -0700 (PDT)
Received: by 10.90.60.3 with SMTP id i3mr2815562aga.103.1269799450136; Sun, 28 
	Mar 2010 11:04:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143412>

Rewrite the description section to describe what exactly remote
helpers are and the need for them. Also mention the curl family of
remote helpers as an example.
---
 The previous version got corrupted and didn't apply cleanly for some reason.
 Additionally split it into two parts now.

 Documentation/git-remote-helpers.txt |   32 ++++++++++++++++++++++++++------
 1 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt
b/Documentation/git-remote-helpers.txt
index 1b5f61a..1304813 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -3,7 +3,7 @@ git-remote-helpers(1)

 NAME
 ----
-git-remote-helpers - Helper programs for interoperation with remote git
+git-remote-helpers - Helper programs to interact with remote repositories

 SYNOPSIS
 --------
@@ -12,11 +12,31 @@ SYNOPSIS
 DESCRIPTION
 -----------

-These programs are normally not used directly by end users, but are
-invoked by various git programs that interact with remote repositories
-when the repository they would operate on will be accessed using
-transport code not linked into the main git binary. Various particular
-helper programs will behave as documented here.
+Remote helper programs are normally not used directly by end users,
+but are invoked by git when it needs to interact with remote
+repositories. They implement a subset of the capabilities documented
+here, and conform to the "remote helper protocol". When git needs
+needs to interact with a repository served by a remote helper, it
+spawns the helper as an independent process and interacts with it over
+the specified protocol. Essentially, git sends commands to the helper
+over standard input, and receives the result written to standard
+output by the helper over a pipe. Also, since remote helpers often
+need to link to the libraries required to interact with the remote
+repository, they avoid linking to the main git programs to evade
+licensing issues.
+
+All the capabilities of remote helpers have to do with discovering and
+updating remote refs, transporting objects between local and remote,
+and updating the local object store. Using the 'fetch' capability,
+they can discover refs on the remote, transfer objects from the remote
+reachable via those refs to local, and update the local object
+store. Using the 'push' capability, they can transfer objects from
+local to remote, and update the corresponding refs as necessary.
+
+Git comes with a "curl" family of remote helpers, specifically
+'git-remote-http', 'git-remote-https', 'git-remote-ftp' and
+'git-remote-ftps'. They implement the capabilities 'fetch', 'option',
+and 'push'.

 COMMANDS
 --------
-- 
1.7.0.3
