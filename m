From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] send-email: Use setlocale in addition to $ENV{LC_ALL} to set locale
Date: Wed, 21 Jun 2006 11:12:43 +0200
Message-ID: <11508811631669-git-send-email-jnareb@gmail.com>
References: <7v3bdy5178.fsf@assigned-by-dhcp.cox.net>
Reply-To: Jakub Narebski <jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 21 11:12:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsylY-0005sM-1m
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 11:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWFUJMs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 05:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWFUJMs
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 05:12:48 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:29375 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1751436AbWFUJMs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 05:12:48 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k5L9CMpK008012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 21 Jun 2006 11:12:22 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k5L9Ch64006819;
	Wed, 21 Jun 2006 11:12:43 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k5L9ChD3006818;
	Wed, 21 Jun 2006 11:12:43 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <7v3bdy5178.fsf@assigned-by-dhcp.cox.net>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22244>

$ENV{LC_ALL} = 'C'; does not change locale used by strftime.
Use setlocale( LC_ALL, 'C' ); instead.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>

---

 git-send-email.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

7c796152570e28d3f95c17e93864c6abc8edef24
diff --git a/git-send-email.perl b/git-send-email.perl
index 7b1cca7..56949dd 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -24,7 +24,8 @@ use Data::Dumper;
 
 # most mail servers generate the Date: header, but not all...
 $ENV{LC_ALL} = 'C';
-use POSIX qw/strftime/;
+use POSIX qw/strftime setlocale LC_ALL/;
+setlocale( &LC_ALL, 'C' );
 
 my $have_email_valid = eval { require Email::Valid; 1 };
 my $smtp;
-- 
1.3.0
