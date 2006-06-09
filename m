From: "Post, Mark K" <mark.post@eds.com>
Subject: RE: Git-daemon messing up permissions for gitweb
Date: Fri, 9 Jun 2006 16:29:17 -0400
Message-ID: <5A14AF34CFF8AD44A44891F7C9FF410507957889@usahm236.amer.corp.eds.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Junio C Hamano" <junkio@cox.net>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 09 22:29:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FonbZ-0002vI-7e
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 22:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWFIU3N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 16:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWFIU3M
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 16:29:12 -0400
Received: from ahmler2.mail.eds.com ([192.85.154.72]:38791 "EHLO
	ahmler2.mail.eds.com") by vger.kernel.org with ESMTP
	id S932257AbWFIU3K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 16:29:10 -0400
Received: from ahmlir1.mail.eds.com (ahmlir1-2.mail.eds.com [192.85.154.131])
	by ahmler2.mail.eds.com (8.13.6/8.12.10) with ESMTP id k59KT243022397;
	Fri, 9 Jun 2006 16:29:04 -0400
Received: from ahmlir1.mail.eds.com (localhost [127.0.0.1])
	by ahmlir1.mail.eds.com (8.13.6/8.12.10) with ESMTP id k59KSkgo006226;
	Fri, 9 Jun 2006 16:28:46 -0400
Received: from USAHM013.amer.corp.eds.com ([130.175.214.154])
	by ahmlir1.mail.eds.com (8.13.6/8.12.10) with ESMTP id k59KSkZR006216;
	Fri, 9 Jun 2006 16:28:46 -0400
Received: from usahm236.amer.corp.eds.com ([130.175.214.169]) by USAHM013.amer.corp.eds.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 9 Jun 2006 16:29:17 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Git-daemon messing up permissions for gitweb
Thread-Index: AcaMArf6G3bvNHBeSZaHyvTv9gm7kQAAGCAQ
To: "Linus Torvalds" <torvalds@osdl.org>
X-OriginalArrivalTime: 09 Jun 2006 20:29:17.0903 (UTC) FILETIME=[61BA55F0:01C68C03]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21550>

I'm not a C programmer, so I'm not sure exactly how to do what you want.
Is this right (it compiles)?
--- shell.c.orig        2006-05-15 16:01:37.000000000 -0400
+++ shell.c     2006-06-09 16:26:24.619808905 -0400
@@ -31,7 +31,7 @@
 {
        char *prog;
        struct commands *cmd;
-
+       umask(0022);
        /* We want to see "-c cmd args", and nothing else */
        if (argc != 3 || strcmp(argv[1], "-c"))
                die("What do you think I am? A shell?"); 

I won't be able to report success or failure today.  Martin's in Germany
and I think he has a life.


Mark Post

-----Original Message-----
From: Linus Torvalds [mailto:torvalds@osdl.org] 
Sent: Friday, June 09, 2006 4:22 PM
To: Post, Mark K
Cc: Junio C Hamano; git@vger.kernel.org
Subject: RE: Git-daemon messing up permissions for gitweb



On Fri, 9 Jun 2006, Post, Mark K wrote:
>
> Martin is using git over SSH.  I have git-shell in /etc/passwd for his
> account.

Ahh. git-shell doesn't read .bashrc or anything like that.

Does adding a "umask(0022)" to the beginning of main() in shell.c fix it

for you?

		Linus
