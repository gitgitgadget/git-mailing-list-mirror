X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Don't use Content-Encoding: header in git_snapshot
Date: Mon, 11 Dec 2006 18:09:58 +0100
Message-ID: <11658569982522-git-send-email-jnareb@gmail.com>
NNTP-Posting-Date: Mon, 11 Dec 2006 17:08:25 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=ItlHrYI4oNkWGxhlsnzybk2obWNp1sYQkjYBJIhL+5Au/t1+rWWGob/DC5v/cGb5ZM/MERIYAM7Sr0jexfw5bfDTJQ5UGMdvQwVoDml5BMqUQg3muQqg17sip7sah64nxafSq4W2ABmftJUguaP7tsEP5RzQW0oGAGNcSUCqKqU=
X-Mailer: git-send-email 1.4.4.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34018>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtodZ-0002ee-Ec for gcvg-git@gmane.org; Mon, 11 Dec
 2006 18:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762949AbWLKRIP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 12:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762959AbWLKRIO
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 12:08:14 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:48399 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762949AbWLKRIM (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 12:08:12 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1389916uga for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 09:08:12 -0800 (PST)
Received: by 10.67.26.7 with SMTP id d7mr10161545ugj.1165856891659; Mon, 11
 Dec 2006 09:08:11 -0800 (PST)
Received: from roke.D-201 ( [81.190.25.107]) by mx.google.com with ESMTP id
 28sm5777624ugc.2006.12.11.09.08.10; Mon, 11 Dec 2006 09:08:11 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kBBHAFbU027444; Mon, 11 Dec 2006 18:10:17 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kBBH9wn5027442; Mon, 11 Dec 2006 18:09:58 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Do not use Content-Encoding: HTTP header in git_snapshot, using
instead type according to the snapshot type (compression type).
Some of web browser take Content-Encoding: to be _transparent_
also for downloading, and store decompressed file (with incorrect
compression suffix) on download.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7d24c10..040ee71 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3489,8 +3489,7 @@ sub git_snapshot {
 	my $filename = basename($project) . "-$hash.tar.$suffix";
 
 	print $cgi->header(
-		-type => 'application/x-tar',
-		-content_encoding => $ctype,
+		-type => "application/$ctype",
 		-content_disposition => 'inline; filename="' . "$filename" . '"',
 		-status => '200 OK');
 
-- 
1.4.4.1
