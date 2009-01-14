From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RESEND PATCH] fast-import: Cleanup mode setting.
Date: Wed, 14 Jan 2009 03:37:07 +0200
Message-ID: <1231897027-16197-1-git-send-email-felipe.contreras@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 02:38:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMuiV-0008Ik-Lb
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 02:38:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbZANBhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 20:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbZANBhX
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 20:37:23 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:41263 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbZANBhW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 20:37:22 -0500
Received: by bwz14 with SMTP id 14so1041548bwz.13
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 17:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=6y9ITTQy7jmeQ7VZ39IlKoFD4kJGP4OAFzZSO/HBltw=;
        b=b31FAakO32kzk3Ncz23UDUfnwVhDaZd3cQWrINrNc0aLbyZIqZRD9GRbHbT7CuXMku
         jpZ9m3k+ZVn9YPhsrsZk5jrklf8CBE0yF0o5aj29imJbcyQHcZF838ezo3HANHbbFdJP
         tXSsafuIPOABo5GHw47DW5D09Lm/GAjws1ug8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=S+KyqqLA10zUP2bEJc+mW6DgGRp6CN4zRI3LWyUViOGpUS3usNMQKMKm108PteX3DA
         4C8ijCfYTkfpNBp7R7FV5CjJ2kbXDMdowoxV/F+uQJvmzBrHttdaP94LCl6WDcWJhx57
         QFYJiTvRgm5yoobOA+BAvWuuLmavXMpTREPew=
Received: by 10.223.110.4 with SMTP id l4mr21037047fap.47.1231897035046;
        Tue, 13 Jan 2009 17:37:15 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id b17sm28766288fka.35.2009.01.13.17.37.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jan 2009 17:37:08 -0800 (PST)
X-Mailer: git-send-email 1.6.0.6.5.ga66c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105571>

"S_IFREG | mode" probably is only required for 0644 and 0755.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 fast-import.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index a6bce66..f0e08ac 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1872,12 +1872,13 @@ static void file_change_m(struct branch *b)
 	if (!p)
 		die("Corrupt mode: %s", command_buf.buf);
 	switch (mode) {
+	case 0644:
+	case 0755:
+		mode |= S_IFREG;
 	case S_IFREG | 0644:
 	case S_IFREG | 0755:
 	case S_IFLNK:
 	case S_IFGITLINK:
-	case 0644:
-	case 0755:
 		/* ok */
 		break;
 	default:
@@ -1944,7 +1945,7 @@ static void file_change_m(struct branch *b)
 			    typename(type), command_buf.buf);
 	}
 
-	tree_content_set(&b->branch_tree, p, sha1, S_IFREG | mode, NULL);
+	tree_content_set(&b->branch_tree, p, sha1, mode, NULL);
 }
 
 static void file_change_d(struct branch *b)
-- 
1.6.0.6.5.ga66c
