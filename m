From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC] gitweb: Go to DONE_REQUEST rather than DONE_GITWEB in die_error
Date: Thu, 25 Nov 2010 23:15:08 +0100
Message-ID: <1290723308-21685-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 25 23:17:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLk8J-0004cl-TD
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 23:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315Ab0KYWPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 17:15:34 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37006 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab0KYWPe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 17:15:34 -0500
Received: by fxm15 with SMTP id 15so241921fxm.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 14:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=lAIDhIbfWREESJF4tMFvmpOjhzDC877SRhA4nAfRL10=;
        b=edJtsr6P0QtHZrn7GX9ysMSnqCN5ZJFyZpGY+ldmwdJCfhz0Xmg8j0aeBLcYdkfP8d
         ADq+0e/7DoHlXzqDROyG6laoyQhtr7hqIXrxmWjinHI/0t7Ij/MvI4WWbRNCvQt2n8Ua
         1H0tcQ3kuKgKpYOMLBytYW0wRc7FRCvOjK4DQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=k4k1fCmELl3ITYKn9f3W6S//6PHyE2bOYLuHRK+xNq/5xUnHM7W1LvjQMQN/h5s5l8
         YUMIRVlB2Vsx+mZ+c6oSaVcQuKxeeM7QR3K3dLkNb5qCFrOF6ivBb4suvlLY5IMSlivl
         9tErJRQ+M6gbQqeWrMSD+XNU4jjLKT7WyD+Qs=
Received: by 10.223.72.202 with SMTP id n10mr1323727faj.74.1290723332874;
        Thu, 25 Nov 2010 14:15:32 -0800 (PST)
Received: from localhost.localdomain (abvd11.neoplus.adsl.tpnet.pl [83.8.201.11])
        by mx.google.com with ESMTPS id e17sm308973fak.10.2010.11.25.14.15.30
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 14:15:31 -0800 (PST)
X-Mailer: git-send-email 1.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162156>

End the request after die_error finishes, rather than exiting gitweb
instance (perhaps wrapped like in ModPerl::Registry or gitweb.psgi
case).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Should bring no differences except for running gitweb in persistent
environments natively, without wrapping; currently only FastCGI is
supported.

 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1d94718..bcd7c8a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1156,6 +1156,7 @@ sub run {
 
 		run_request();
 
+	DONE_REQUEST:
 		$post_dispatch_hook->()
 			if $post_dispatch_hook;
 		$first_request = 0;
@@ -3679,7 +3680,7 @@ EOF
 	print "</div>\n";
 
 	git_footer_html();
-	goto DONE_GITWEB
+	goto DONE_REQUEST
 		unless ($opts{'-error_handler'});
 }
 
-- 
1.7.3
