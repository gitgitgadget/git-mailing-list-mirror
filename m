From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] merge: default to @{upstream}
Date: Fri, 28 Jan 2011 18:17:37 +0200
Message-ID: <1296231457-18780-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 28 17:18:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pir1O-0005ad-Ey
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 17:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199Ab1A1QR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 11:17:57 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42833 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755130Ab1A1QR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 11:17:56 -0500
Received: by fxm20 with SMTP id 20so3505653fxm.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 08:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=+V60Kn1XJytpWffexZsg9O52LmwXK1R4ajva4dN+GTM=;
        b=GJRFcfM2a3eXgnEMRLbZ5lUJKquCfw3R3P7oD9+HzyoiyBiiVvcyMM7daFCf2jR6uh
         PV9I0b5nghDYbor3Up4wMxjvkcdW1IXhQP1F4KFaxCyfiRNGVP+F2kIoSzb+mNVVDeua
         FNN4aIsHYAnOCk1X1PLjWFz03WsBqI7WY+fU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=pAMMkM0qbM+7K5yeUDoTeWTbUvbBSvubko2+HxcbPMqeqy1cGzcHMTegSI+Nb+mY8i
         Pp36/SJhSd2SflEiYRK/DbBt7Yxl2hD8VEAKxzXRX2y/eM6Yt6g1y4eUsErF9VAh+s7E
         bmEw+mgH5xuUPwhrQGxi0dyqyuP5Hoz5FkuHg=
Received: by 10.223.101.140 with SMTP id c12mr2546655fao.16.1296231474841;
        Fri, 28 Jan 2011 08:17:54 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id f24sm6493534fak.24.2011.01.28.08.17.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Jan 2011 08:17:41 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165623>

So 'git merge' is 'git merge @{upstream}' instead of 'git merge -h';
it's better to do something useful.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/merge.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 42fff38..f23d669 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -983,9 +983,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (!allow_fast_forward && fast_forward_only)
 		die("You cannot combine --no-ff with --ff-only.");
 
-	if (!argc)
-		usage_with_options(builtin_merge_usage,
-			builtin_merge_options);
+	if (!argc) {
+		/* argv[argc] should be NULL, so we can hijack it */
+		argv[0] = "@{u}";
+		argc = 1;
+	}
 
 	/*
 	 * This could be traditional "merge <msg> HEAD <commit>..."  and
-- 
1.7.4.rc3
