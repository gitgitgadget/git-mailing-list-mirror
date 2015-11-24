From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2] send-email: die if CA path doesn't exist
Date: Tue, 24 Nov 2015 23:31:40 +0000
Message-ID: <554d29f019f52d18cf1d6c5835df0a3a098a1df4.1448407832.git.john@keeping.me.uk>
References: <27f354a4edb166e42006b0c1f778827a3dfd58ac.1447798206.git.john@keeping.me.uk>
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 00:32:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1N4C-0006kX-TK
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 00:32:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbbKXXcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 18:32:07 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:39970 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190AbbKXXcF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 18:32:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 28C24CDA582;
	Tue, 24 Nov 2015 23:32:04 +0000 (GMT)
X-Quarantine-ID: <bPYlJk8jRCMz>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bPYlJk8jRCMz; Tue, 24 Nov 2015 23:32:03 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 0D95CCDA563;
	Tue, 24 Nov 2015 23:31:55 +0000 (GMT)
X-Mailer: git-send-email 2.6.3.462.gbe2c914
In-Reply-To: <27f354a4edb166e42006b0c1f778827a3dfd58ac.1447798206.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281649>

If the CA path isn't found it's most likely to indicate a
misconfiguration, in which case accepting any certificate is unlikely to
be the correct thing to do.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
Changes since v1:
- add missing path to error message
- remove trailing '.' on error message since die appends "at
  /path/to/git-send-email line ..."

 git-send-email.perl | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 8e4c0e1..68c93fa 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1196,8 +1196,7 @@ sub ssl_verify_params {
 		return (SSL_verify_mode => SSL_VERIFY_PEER(),
 			SSL_ca_file => $smtp_ssl_cert_path);
 	} else {
-		print STDERR "Not using SSL_VERIFY_PEER because the CA path does not exist.\n";
-		return (SSL_verify_mode => SSL_VERIFY_NONE());
+		die "CA path \"$smtp_ssl_cert_path\" does not exist";
 	}
 }
 
-- 
2.6.3.462.gbe2c914
