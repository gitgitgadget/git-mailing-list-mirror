From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] send-email: only 'require' instead of 'use' Net::SMTP
Date: Thu, 1 Jun 2006 00:55:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606010054420.3617@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jun 01 00:56:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlZbT-00055v-H8
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 00:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965226AbWEaWzt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 18:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965212AbWEaWzt
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 18:55:49 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:11983 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965226AbWEaWzs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 18:55:48 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 374E9E61;
	Thu,  1 Jun 2006 00:55:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 29737E48;
	Thu,  1 Jun 2006 00:55:47 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 00DA9E3D;
	Thu,  1 Jun 2006 00:55:46 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net,
	Eric Wong <normalperson@yhbt.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21097>


This was proposed by Eric Wong and fixes the test. (Of course, git-send-email
does not work, if there is no Net::SMTP here, but it will say what is wrong
when you actually try to use send-email.)

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 0e368ff..ed1d89b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -21,7 +21,6 @@ use warnings;
 use Term::ReadLine;
 use Getopt::Long;
 use Data::Dumper;
-use Net::SMTP;
 
 # most mail servers generate the Date: header, but not all...
 $ENV{LC_ALL} = 'C';
@@ -394,6 +393,7 @@ X-Mailer: git-send-email $gitversion
 		print $sm "$header\n$message";
 		close $sm or die $?;
 	} else {
+		require Net::SMTP;
 		$smtp ||= Net::SMTP->new( $smtp_server );
 		$smtp->mail( $from ) or die $smtp->message;
 		$smtp->to( @recipients ) or die $smtp->message;
-- 
1.3.3.gc46d3-dirty
