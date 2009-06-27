From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb/README: fix AliasMatch in example
Date: Sat, 27 Jun 2009 18:24:11 +0200
Message-ID: <1246119851-22154-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 27 18:24:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKahQ-0003YS-7i
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 18:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754578AbZF0QYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 12:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754327AbZF0QYG
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 12:24:06 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:41136 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986AbZF0QYE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 12:24:04 -0400
Received: by bwz9 with SMTP id 9so2528530bwz.37
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 09:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=yv4Ydg/Sx9wqtF15p+0pz6dbSgdBdnF8kgjNBkgjKDo=;
        b=NprIk9Mkatb6NMCoW6sisKWzfu5RZWcgjrVcSnhjbD+gRj5SPwH8OAi0hLMpi7tGvq
         n+atLgmWtgEfbuwVaVV23OFEiQEvUUYeoG1HoTeTXgSi+J+I6unRNWSrYdit030ypAXK
         QVMYSrnKI00oq3/YXYwA+XVYSZq4X6XzZtRtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DP6xRRvYnXRdy9pp0CJ4UCdDGhnBPNC+r0i6aZpa4wPXSy+X9S/FQCMi8+5WVAttFX
         eOTFPxl+N6JetUGg8DYsjZyGTMklnze0SRUBk8H2+pVSelWeaLvWPatieEze3YUf8JxP
         fB/Vy+F7DxGVBd78+GRcOdPIwm2DRg7htBjc8=
Received: by 10.204.115.139 with SMTP id i11mr4935460bkq.199.1246119846250;
        Sat, 27 Jun 2009 09:24:06 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-5-93.clienti.tiscali.it [94.37.5.93])
        by mx.google.com with ESMTPS id 21sm7999618fks.9.2009.06.27.09.24.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Jun 2009 09:24:05 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122375>

When combining "dumb client" and human-friendly access by using the
'.git' extension to switch between the two, make sure the AliasMatch
covers the entire request. Without a full match, a request for

http://git.example.com/project/shortlog/branch..gitsomething

would result in a 404 because the server would try to access the
the project 'project/shortlog/branch.'

The solution is still not bulletproof, so document the possible failing
case.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/README |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

I got bitten by this myself, hence the quick patch.

diff --git a/gitweb/README b/gitweb/README
index ccda890..9056d1e 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -377,7 +377,7 @@ named without a .git extension (e.g. /pub/git/project instead of
 
 	DocumentRoot /var/www/gitweb
 
-	AliasMatch ^(/.*?)(\.git)(/.*)? /pub/git$1$3
+	AliasMatch ^(/.*?)(\.git)(/.*)?$ /pub/git$1$3
 	<Directory /var/www/gitweb>
 		Options ExecCGI
 		AddHandler cgi-script cgi
@@ -402,6 +402,14 @@ http://git.example.com/project
 
 will provide human-friendly gitweb access.
 
+This solution is not 100% bulletproof, in the sense that if some project
+has a named ref (branch, tag) starting with 'git/', then paths such as
+
+http://git.example.com/project/command/abranch..git/abranch
+
+will fail with a 404 error.
+
+
 
 Originally written by:
   Kay Sievers <kay.sievers@vrfy.org>
-- 
1.6.3.rc1.192.gdbfcb
