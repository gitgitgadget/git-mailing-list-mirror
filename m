From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 01/12] cherry-pick: don't barf when there's nothing to do
Date: Wed, 23 Apr 2014 21:44:40 -0500
Message-ID: <1398307491-21314-2-git-send-email-felipe.contreras@gmail.com>
References: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 04:55:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd9p1-0007Op-EW
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 04:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbaDXCz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 22:55:26 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:52313 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbaDXCzW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 22:55:22 -0400
Received: by mail-oa0-f53.google.com with SMTP id j17so1980726oag.40
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 19:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lowD7fpgTEnWMwIUocx0F4mTpLGekL1phzymXcrBMyc=;
        b=rCJbBF6KrtzzHWYZ1i9KxNLixJ0dyFisbT6PddLlgmQaAUcBIEpoLDddbL+cixd9KG
         xt+t2aZa7K6KT3ASi73Tl0K5p+4sAak7xfMR2Yx55CB/gz1yRPEnrRm9qlQnv8py3eBD
         bk7QRPi8n/3KQRSh73n6o9C/Xv8NQNMF+BaP8Yt9aL9c5Loa9Lnbii7R6yYLR3XcAqVS
         /t9OohDW9ipNc4ehn90Rlz+yy1t+8kgX1NV9KZps72PSYcGfuqm5I1Gphl+pBb688OYZ
         henptJ3IPMHGn8J0lXX9Z/wS4lI1kLW6KGxFtFRzuCOqy6EiZcRi9Y6rDGn4HCGI6fAj
         qQzA==
X-Received: by 10.182.29.225 with SMTP id n1mr46173049obh.2.1398308121650;
        Wed, 23 Apr 2014 19:55:21 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c7sm11803703oek.12.2014.04.23.19.55.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 19:55:20 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246917>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sequencer.c                     | 2 +-
 t/t3510-cherry-pick-sequence.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 90cac7b..c94942a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -662,7 +662,7 @@ static void prepare_revs(struct replay_opts *opts)
 		die(_("revision walk setup failed"));
 
 	if (!opts->revs->commits)
-		die(_("empty commit set passed"));
+		error(_("empty commit set passed"));
 }
 
 static void read_and_refresh_cache(struct replay_opts *opts)
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 7b7a89d..33c5512 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -472,7 +472,7 @@ test_expect_success 'malformed instruction sheet 2' '
 
 test_expect_success 'empty commit set' '
 	pristine_detach initial &&
-	test_expect_code 128 git cherry-pick base..base
+	git cherry-pick base..base
 '
 
 test_expect_success 'malformed instruction sheet 3' '
-- 
1.9.2+fc1.2.gfbaae8c
