From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: [PATCH] Reset terminal attributes when terminating git send-email
Date: Fri, 17 Aug 2007 17:38:25 -0400
Message-ID: <11873867051589-git-send-email-seanlkml@sympatico.ca>
References: <11873867051906-git-send-email-seanlkml@sympatico.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 23:39:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM9XM-0001Bj-7f
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 23:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbXHQVjO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 17:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753694AbXHQVjN
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 17:39:13 -0400
Received: from bay0-omc2-s29.bay0.hotmail.com ([65.54.246.165]:32863 "EHLO
	bay0-omc2-s29.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753291AbXHQVjM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Aug 2007 17:39:12 -0400
Received: from BAYC1-PASMTP11.bayc1.hotmail.com ([65.54.191.184]) by bay0-omc2-s29.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Fri, 17 Aug 2007 14:39:12 -0700
X-Originating-IP: [64.231.205.174]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([64.231.205.174]) by BAYC1-PASMTP11.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Fri, 17 Aug 2007 14:40:11 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with esmtp (Exim 4.43)
	id 1IM9XC-0008Tm-Gl
	for git@vger.kernel.org; Fri, 17 Aug 2007 17:39:10 -0400
Received: from sean by guru.attic.local with local (Exim 4.67)
	(envelope-from <sean@guru.attic.local>)
	id 1IM9WT-00081Y-VQ
	for git@vger.kernel.org; Fri, 17 Aug 2007 17:38:25 -0400
X-Mailer: git-send-email 1.5.3.rc5.18.gcb57
In-Reply-To: <11873867051906-git-send-email-seanlkml@sympatico.ca>
X-OriginalArrivalTime: 17 Aug 2007 21:40:11.0781 (UTC) FILETIME=[30841B50:01C7E117]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56088>

If you break out of the prompts presented to you by git send-email
your terminal can be left in an inconsistent state.  Here we trap
the interrupt signal and reset the terminal before exiting.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
---
 git-send-email.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 69559b2..f1a8855 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -21,8 +21,11 @@ use warnings;
 use Term::ReadLine;
 use Getopt::Long;
 use Data::Dumper;
+use Term::ANSIColor;
 use Git;
 
+$SIG{INT} = sub { print color("reset"), "\n"; exit };
+
 package FakeTerm;
 sub new {
 	my ($class, $reason) = @_;
-- 
1.5.3.rc5.18.gcb57
