From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/5] Documentation/remote-helpers: Rewrite description
Date: Sun, 18 Apr 2010 06:22:52 +0530
Message-ID: <1271551934-sup-1118@kytes>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 18 02:55:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3Imu-0003pc-G0
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 02:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756101Ab0DRAy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 20:54:58 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33551 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756067Ab0DRAy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 20:54:58 -0400
Received: by gyg13 with SMTP id 13so2018837gyg.19
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 17:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:content-type:cc:subject:from
         :to:date:message-id:user-agent:content-transfer-encoding;
        bh=LpTjfHHXEzrFSX2iectm11M64+oV7doW8v/9CRsP6Xo=;
        b=INWV76Yd6pra8bWujduIkQW1bsfAHUrjwRGufA5axGAgkEcgZfbYV17/pKs6Cre+Cw
         4aEhbvBEZTi/7eLEHa6GZ0t1bWUyY5r58tTQfTbQFGHhX3XnJF9j3xyt27zHW1Zfy5g9
         GhqXQbs3rHIA/MqJ+Zfa059wyydGNjxcw7ucU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:cc:subject:from:to:date:message-id:user-agent
         :content-transfer-encoding;
        b=wbRy4QhgkwhS1aNSRk96eRdgrybH2CtKR3704baydvmqKIeQf4svXUKNY0zbIlCYFA
         7PLkIHkLdus6BF67q4UEWfrSWm/r64y5AgWjFjsNzssWPwJcHYjjBEFk4QNLVb77WrxJ
         kCYJv4UuDDWxE16h3sVleqMueXTSPvHHq/JYs=
Received: by 10.90.171.4 with SMTP id t4mr1965527age.76.1271552097142;
        Sat, 17 Apr 2010 17:54:57 -0700 (PDT)
Received: from localhost ([203.110.240.41])
        by mx.google.com with ESMTPS id 20sm3326176iwn.9.2010.04.17.17.54.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 17:54:56 -0700 (PDT)
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145195>

Rewrite the description section to describe what exactly remote
helpers are and the need for them. Also mention the curl family of
remote helpers as an example.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-remote-helpers.txt |   32 ++++++++++++++++++++++++++------
 1 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 1b5f61a..15214ae 100644
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
+the specified protocol. git sends commands to the helper
+over standard input, and receives the result written to standard
+output by the helper over a pipe. Because a remote helper runs as
+an independent process to interact with remote repositories, there
+is no need to re-link git when adding a new helper nor need to link
+the helper with the implementation of git.
+
+All the capabilities of remote helpers have to do with discovering and
+updating remote refs, transporting objects between local and remote,
+and updating the local object store. Using the 'fetch' capability,
+they can discover refs on the remote, transfer objects from the remote
+reachable via those refs to local, and update the local object
+store. Using the 'push' capability, they can transfer objects from
+local to remote, and update the corresponding refs as necessary.
+
+Git comes with a "curl" family of remote helpers, that handle various
+transport protocols, such as 'git-remote-http', 'git-remote-https',
+'git-remote-ftp' and 'git-remote-ftps'. They implement the capabilities
+'fetch', 'option', and 'push'.
 
 COMMANDS
 --------
-- 
1.7.0.4
