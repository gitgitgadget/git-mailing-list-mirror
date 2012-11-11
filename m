From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] send-email: refactor recipients_cmd()
Date: Sun, 11 Nov 2012 18:04:22 +0100
Message-ID: <1352653463-1923-2-git-send-email-felipe.contreras@gmail.com>
References: <1352653463-1923-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Joe Perches <joe@perches.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Pascal Obry <pascal@obry.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 18:04:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXaxq-0007TJ-R2
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 18:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273Ab2KKREi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 12:04:38 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52685 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab2KKREg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 12:04:36 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2084867bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 09:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=PGMU8EUA8d2IswY8qoSOxg3MQI4GCnRNhzOfXTCov48=;
        b=uDhRSICzbF3vIqSo2iWfcf4o8ZZhAQCBPe1VbsTHGu9OMP1cN11Vh8Jf6q3eOEkiv7
         DQKn2loH+tn/+Y07BFsBVzJaugU6cKcNAz7zAOzH6B4qu1LKPaVuM3yQRoRZbytrVzWE
         tg91IUbufjNvOc6x4xrm7+H904OsmPBbMIUUrhwR4EcvFXmMkppMQcnYtKbips/XsLX3
         gP4XBkr+akxUFDaLAvQ8gfW4NBYhj5JsIAjr+KZnIRxAI2abIy1WscekTZqV0yWRLc6H
         CEOB9gZWXHtfwBp6EYDLU7/4LjvKl3mz+rF2nxNBB9FqkrHpSm6k7eLhqP0+3loj+hbV
         +4zw==
Received: by 10.204.128.138 with SMTP id k10mr6249227bks.27.1352653476192;
        Sun, 11 Nov 2012 09:04:36 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id v14sm1640847bkv.10.2012.11.11.09.04.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 09:04:35 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352653463-1923-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209416>

If we pass the full command to run, we should be able to use it in more
extensible ways--see next patch.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-send-email.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index aea66a0..26d4477 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1373,11 +1373,11 @@ foreach my $t (@files) {
 # Execute a command (e.g. $to_cmd) to get a list of email addresses
 # and return a results array
 sub recipients_cmd {
-	my ($prefix, $what, $cmd, $file) = @_;
+	my ($prefix, $what, $cmd, @args) = @_;
 
 	my $sanitized_sender = sanitize_address($sender);
 	my @addresses = ();
-	open my $fh, "$cmd \Q$file\E |"
+	open my $fh, "-|", $cmd, @args
 	    or die "($prefix) Could not execute '$cmd'";
 	while (my $address = <$fh>) {
 		$address =~ s/^\s*//g;
-- 
1.8.0
