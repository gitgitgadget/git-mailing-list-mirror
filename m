From: John Keeping <john@keeping.me.uk>
Subject: [RFC/PATCH] send-email: die if CA path doesn't exist
Date: Tue, 17 Nov 2015 22:12:07 +0000
Message-ID: <27f354a4edb166e42006b0c1f778827a3dfd58ac.1447798206.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 18 03:24:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZysPm-0001Rl-Sc
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 03:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbbKRCYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 21:24:00 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:33413 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbbKRCX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 21:23:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 1491F9624C9;
	Wed, 18 Nov 2015 00:14:02 +0000 (GMT)
X-Quarantine-ID: <CDbRDkIpvzCB>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CDbRDkIpvzCB; Wed, 18 Nov 2015 00:14:00 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 5D00E86A292;
	Tue, 17 Nov 2015 22:12:20 +0000 (GMT)
X-Mailer: git-send-email 2.6.3.462.gbe2c914
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281438>

If the CA path isn't found it's most likely to indicate a
misconfiguration, in which case accepting any certificate is unlikely to
be the correct thing to do.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-send-email.perl | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 8e4c0e1..e057051 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1196,8 +1196,7 @@ sub ssl_verify_params {
 		return (SSL_verify_mode => SSL_VERIFY_PEER(),
 			SSL_ca_file => $smtp_ssl_cert_path);
 	} else {
-		print STDERR "Not using SSL_VERIFY_PEER because the CA path does not exist.\n";
-		return (SSL_verify_mode => SSL_VERIFY_NONE());
+		die "CA path does not exist.";
 	}
 }
 
-- 
2.6.3.462.gbe2c914
