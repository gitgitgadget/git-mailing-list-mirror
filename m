From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 13/13] remote-hg: push to the appropriate branch
Date: Thu,  4 Apr 2013 09:30:22 -0600
Message-ID: <1365089422-8250-14-git-send-email-felipe.contreras@gmail.com>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>, Dusty Phillips <dusty@linux.ca>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 04 17:33:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNm9k-0004ZS-JG
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 17:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762756Ab3DDPcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 11:32:04 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:40398 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762715Ab3DDPcB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 11:32:01 -0400
Received: by mail-oa0-f50.google.com with SMTP id n1so2858304oag.23
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 08:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=9SjPSNhZyf+IwOqjJUj3auhJfsyTdF2tl+f7LGg3lPk=;
        b=YPLMfFkl2opc9ERpNP7FL3ARHpilQXJ15KrEWTGpEKNq0e/vE2PZxNWNAAdUol6t8L
         w0dMgnzHseXMe3v7cIUwHwIoMb0b5Cs4jq6GA6W1doJMvGJ0k8WXKduGERPh4aw8cfgl
         ZTku+zFdVYvEYZUFqx8y+WsVccDDOecP/ygX9uYVVeirN2uAyZcy7Gp92KG/C2TyJTRZ
         NN4Pp52bfHXJZQzH9IWUKHq7dC2ldsJUeNNXn8eA5EiKLVRddGn6QSHbDvaP5pbz1pSd
         7HxfjbvNXJ40BMp2k+hrjLkIhRO0CSyEhIzc0vgB2ftZZxn1BlD1hSOXcAbv/SOqVMRT
         cEsw==
X-Received: by 10.182.72.5 with SMTP id z5mr4629075obu.24.1365089521364;
        Thu, 04 Apr 2013 08:32:01 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id d10sm7115632oeh.7.2013.04.04.08.31.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 08:32:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220015>

From: Dusty Phillips <dusty@linux.ca>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 56b3641..d82eb2d 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -625,6 +625,10 @@ def parse_commit(parser):
     if merge_mark:
         get_merge_files(repo, p1, p2, files)
 
+    # Check if the ref is supposed to be a named branch
+    if ref.startswith('refs/heads/branches/'):
+        extra['branch'] = ref.rpartition('/')[2]
+
     if mode == 'hg':
         i = data.find('\n--HG--\n')
         if i >= 0:
-- 
1.8.2
