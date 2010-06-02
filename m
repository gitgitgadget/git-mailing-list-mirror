From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 3/3] git am: Remove stray error message from sed
Date: Wed,  2 Jun 2010 10:33:37 +0200
Message-ID: <1275467617-23065-4-git-send-email-artagnon@gmail.com>
References: <1275467617-23065-1-git-send-email-artagnon@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 02 10:40:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJjUY-0002jQ-8i
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 10:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441Ab0FBIj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 04:39:57 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:58327 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375Ab0FBIj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 04:39:56 -0400
Received: by ewy23 with SMTP id 23so553572ewy.1
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 01:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=X4WKMKRXjBqYg8vFCtwfbmPwk3aQGU8hRJYAfI8BFRk=;
        b=o8TuzC2CXtRHZeXQ/gTBsMnUIaiuX7fjsseQ4djXjc5EgIC5rW6KM1Ed5EZ8n5eYwt
         +6bG02e/OOagtwJEWdJKghwungl1FXB7r+jbtpjs6TGFY1JMW+tBgRvFfxUVllBR0o07
         wmw6xy1Bt5fYdosBZhQYilMJ41XPU94Bm8EPk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TntazHrbl+2gADcGtmn8I5JifgTYA0HpF5lrEtdiQ9828fHB8o7FZ64jXeYrQk2ut4
         4utLz0O2XtTCBDXZDRzTXagyJTRprf7KN5Uyn3aIsUhPYLkYQNuEOV4sXUP5vWz6vOf0
         9UucoIXAkaDwFOriCd5c325SkWckmWp1mbbYc=
Received: by 10.213.29.1 with SMTP id o1mr387335ebc.43.1275467543004;
        Wed, 02 Jun 2010 01:32:23 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 13sm4288233ewy.13.2010.06.02.01.32.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Jun 2010 01:32:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1275467617-23065-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148229>

When --continue is invoked without any changes, the following stray
error message appears- sed: can't read $dotest/final-commit: No such
file or directory. Remove this by making sure that the file actually
exists.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-am.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index a52c2b4..062b5a7 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -693,8 +693,13 @@ do
 	else
 	    action=yes
 	fi
-	FIRSTLINE=$(sed 1q "$dotest/final-commit")
+
+	if test -f "$dotest/final-commit"
+	then
+		FIRSTLINE=$(sed 1q "$dotest/final-commit")
+	else
+		FIRSTLINE=""
+	fi
 
 	if test $action = skip
 	then
-- 
1.7.1
