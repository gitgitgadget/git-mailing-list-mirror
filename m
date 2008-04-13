From: Fredrik Noring <noring@nocrew.org>
Subject: [PATCH] cvsserver: Removing leading and trailing newlines for "cvs log"
Date: Sun, 13 Apr 2008 12:54:54 +0200
Message-ID: <CC1E4EF8-9A0A-4463-8704-18849457DC69@nocrew.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: multipart/mixed; boundary=Apple-Mail-48--3855942
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 13 12:56:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkzsZ-0003p5-TJ
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 12:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755126AbYDMKzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 06:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755173AbYDMKzA
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 06:55:00 -0400
Received: from mail.visit.se ([85.194.0.110]:42332 "EHLO mail.visit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755100AbYDMKy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 06:54:59 -0400
Received: by mail.visit.se (Postfix, from userid 503)
	id 5F22936E01AF; Sun, 13 Apr 2008 12:55:10 +0200 (CEST)
Received: from [10.0.1.2] (cust.dsl-fiber-lan.snet.lk.85.194.37.51.visit.se [85.194.37.51])
	by mail.visit.se (Postfix) with ESMTP id 8A7CB36E01AE;
	Sun, 13 Apr 2008 12:55:06 +0200 (CEST)
X-Mailer: Apple Mail (2.919.2)
X-Spam-Checker-Version: SpamAssassin 3.0.6 (2005-12-07) on mail.visit.se
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79404>


--Apple-Mail-48--3855942
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Hi all,

Attached patch removes the leading and trailing newlines that the  
cvsserver command adds to commit messages for "cvs log".

  git-cvsserver.perl |    4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

Another note: For every commit, cvsserver claims lines changed are "+2  
-3" as hard-coded values no matter what, but that's a fix for another  
day. ;)

Thanks,
Fredrik


--Apple-Mail-48--3855942
Content-Disposition: attachment;
	filename=cvsserver-tighter-log.patch
Content-Type: application/octet-stream;
	x-unix-mode=0664;
	name="cvsserver-tighter-log.patch"
Content-Transfer-Encoding: 7bit

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 59a1609..1927c1c 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -3049,7 +3049,9 @@ sub commitmessage
 
     my @lines = safe_pipe_capture("git-cat-file", "commit", $commithash);
     shift @lines while ( $lines[0] =~ /\S/ );
-    $message = join("",@lines);
+    shift @lines;
+    map(s/\n$//s, @lines);
+    $message = join("\n", @lines);
     $message .= " " if ( $message =~ /\n$/ );
     return $message;
 }

--Apple-Mail-48--3855942
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit



--Apple-Mail-48--3855942--
