From: Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru>
Subject: [PATCH] Added get sendmail from .mailrc
Date: Sat, 25 Jan 2014 13:46:50 +0400
Message-ID: <1390643210-5748-1-git-send-email-brilliantov@inbox.ru>
Cc: Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 25 10:47:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6zq3-0005am-JE
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jan 2014 10:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbaAYJrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jan 2014 04:47:21 -0500
Received: from fallback3.mail.ru ([94.100.176.58]:46131 "EHLO
	fallback3.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbaAYJrU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jan 2014 04:47:20 -0500
Received: from smtp22.mail.ru (smtp22.mail.ru [94.100.176.175])
	by fallback3.mail.ru (mPOP.Fallback_MX) with ESMTP id 5520F10A25180
	for <git@vger.kernel.org>; Sat, 25 Jan 2014 13:47:17 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail;
	h=Message-Id:Date:Subject:Cc:To:From; bh=OCJXlbSPlqGgb0ZEcAgGizjSzup+U+6fAPS7/verur4=;
	b=QiWubf4n7fK2uw3syQfvI4Ga5V70h3mxmy4fdnI3+jekTaxqCi7F0yPiQComxsmxw8p8m+RGtRiBNOlmiVU6Xfq8853qIwMsgC7XhqNlDKFUYLym5yHl5vm8rYQi3S989N392qR88N1Hnv2nHImzlBxUYfhN4xc2T2EW2/scf+Q=;
Received: from [176.195.48.55] (port=33760 helo=kirill.netbynet.ru)
	by smtp22.mail.ru with esmtpa (envelope-from <brilliantov@inbox.ru>)
	id 1W6zpQ-0002sk-CB; Sat, 25 Jan 2014 13:47:04 +0400
X-Mailer: git-send-email 1.8.5.2
X-Spam: Not detected
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241065>

Signed-off-by: Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru>
---
 git-send-email.perl | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 2016d9c..5345fdb 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -28,6 +28,7 @@ use File::Temp qw/ tempdir tempfile /;
 use File::Spec::Functions qw(catfile);
 use Error qw(:try);
 use Git;
+use File::HomeDir;
 
 Getopt::Long::Configure qw/ pass_through /;
 
@@ -804,6 +805,23 @@ if (!defined $smtp_server) {
 			last;
 		}
 	}
+
+	if (!defined $smtp_server) {
+		my $mailrc = File::HomeDir->my_home . "/.mailrc";
+		if (-e $mailrc) {
+			open FILE, $mailrc or die "Failed open $mailrc: $!";
+			while (<FILE>) {
+			    chomp;
+			    if (/set sendmail=.*/) {
+				my @data = split '"';
+				$smtp_server = $data[1];
+				last;
+			    }
+			}
+			close FILE;
+		}
+	}
+
 	$smtp_server ||= 'localhost'; # could be 127.0.0.1, too... *shrug*
 }
 
-- 
1.8.5.2
