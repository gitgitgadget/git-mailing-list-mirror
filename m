From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] fast-import: Cleanup mode setting.
Date: Mon, 22 Dec 2008 04:19:37 +0200
Message-ID: <1229912377-3566-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 22 03:21:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEaPs-0007bf-L1
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 03:21:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbYLVCTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 21:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbYLVCTm
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 21:19:42 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:48747 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbYLVCTl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 21:19:41 -0500
Received: by bwz14 with SMTP id 14so7304470bwz.13
        for <git@vger.kernel.org>; Sun, 21 Dec 2008 18:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=6y9ITTQy7jmeQ7VZ39IlKoFD4kJGP4OAFzZSO/HBltw=;
        b=MtoQnHKQ2d1HdO6JFSrXmcdXuU/fUbL/nMdO3/VO1QKZsajZXG1DzHAMh8JVH7l+ag
         +mrrjCVWbTfoN4EWvljb65rII/BNWsXZ2ihtBpXfhrSblLMlazMdhnAvV2VWXUtnzg47
         qhJG7xcM+KAQd9oHMpR93+a21EiZJm6rwi3pE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Lvvdd3gpFkbwknXggRaXCZp3YVhMmiu04MZjWDaSUYoe7QAfQYyh1mRZQyrGVlPhbO
         rCkRkTaY+5EM/1p/c/FiBYvA9atlWsFIFmv0kTcc9FPrVdZjAOPW+9RNZ1Gk1sgiQW8+
         MFF18MKjDoQTSaHXMhrNjCDOUO93RAhTGubUo=
Received: by 10.180.204.10 with SMTP id b10mr2122303bkg.201.1229912379700;
        Sun, 21 Dec 2008 18:19:39 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id c28sm11095892fka.16.2008.12.21.18.19.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Dec 2008 18:19:39 -0800 (PST)
X-Mailer: git-send-email 1.6.0.6.5.ga66c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103738>

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
