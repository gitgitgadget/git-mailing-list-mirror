From: sean <seanlkml@sympatico.ca>
Subject: annotate.perl triggers rpm bug
Date: Fri, 10 Mar 2006 16:23:20 -0500
Message-ID: <BAYC1-PASMTP0815EFABBF5266FB641C65AEED0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 10 22:25:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHp72-0003q1-4n
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 22:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWCJVZZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 16:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWCJVZZ
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 16:25:25 -0500
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]:53089 "EHLO
	BAYC1-PASMTP08.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932328AbWCJVZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 16:25:25 -0500
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP08.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 10 Mar 2006 13:28:27 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id E472D644C28;
	Fri, 10 Mar 2006 16:25:22 -0500 (EST)
To: Ryan Anderson <ryan@michonline.com>
Message-Id: <20060310162320.0a98352b.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.13; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 10 Mar 2006 21:28:28.0187 (UTC) FILETIME=[92456EB0:01C64489]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Ryan

Commit 87475f4 exposes a problem in the creation of rpms (at least
on Fedora boxes).   RPM automatically creates a dependency for any
perl "use" lines, and the above commit fools it into creating a false 
dependecy for the nonexistent perl package "revs" because of this
portion of the diff:

+       -S, --rev-file revs-file
+                       use revs from revs-file instead of calling git-rev-list
                        ^^ fools rpm

Obviously this creates a problem when someone goes to install the git-core
rpm.  Any chance we could get a small change to work around this bug in rpm?

Thanks,
Sean


diff --git a/git-annotate.perl b/git-annotate.perl
index feea0a2..6805b8b 100755
--- a/git-annotate.perl
+++ b/git-annotate.perl
@@ -20,7 +20,7 @@ sub usage() {
        -r, --rename
                        Follow renames (Defaults on).
        -S, --rev-file revs-file
-                       use revs from revs-file instead of calling git-rev-list
+                       uses revs from revs-file instead of calling git-rev-list
        -h, --help
                        This message.
 ';
