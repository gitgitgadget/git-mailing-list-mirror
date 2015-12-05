From: Stefan Naewe <stefan.naewe@gmail.com>
Subject: [PATCH v2] revision.c: fix possible null pointer access
Date: Sat,  5 Dec 2015 16:27:24 +0100
Message-ID: <1449329244-4585-1-git-send-email-stefan.naewe@gmail.com>
References: <xmqqlh9bthyb.fsf@gitster.mtv.corp.google.com>
Cc: Stefan Naewe <stefan.naewe@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 05 16:27:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5EkO-0000aV-5c
	for gcvg-git-2@plane.gmane.org; Sat, 05 Dec 2015 16:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbbLEP1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2015 10:27:35 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35883 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315AbbLEP1f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2015 10:27:35 -0500
Received: by wmww144 with SMTP id w144so94343753wmw.1
        for <git@vger.kernel.org>; Sat, 05 Dec 2015 07:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dDPKFcuCaxzbBMp5ZGg5UdaQi4zkTYFv7Wlpw+ANRcY=;
        b=qyBtRg7Pe6lZgpT6LnHKG6PqxstrlxBrZUiGVj+j3l1k67eIsdR9xv9KeOYKMoHF2W
         x2I3wvMAlHpa/weu6oom2QYQCUxL/hPP5Gcn6xcmE22nKwdB6EnpW/gltFbbLbe5zFCx
         1VRZ9QuNRMmaxTPIfXNwZStN8GSPT7qUjAaM4EoWWKsNdJ8j0k0eJtIBMxRqNs7B+IKL
         lI1xDzZuu2kvT7hI8mKSp8Tp32uZBX+US7oi7DJXLT+r91QTKGDB9Lb7VRneJ2lgcNAS
         ChlcMU1ob8aGeqyP34bgcCcPeDze82S7A8JosflD2fNnKGmxVPBNOcNwi8Iu9JZCfH18
         UAtQ==
X-Received: by 10.194.172.2 with SMTP id ay2mr20461322wjc.137.1449329253843;
        Sat, 05 Dec 2015 07:27:33 -0800 (PST)
Received: from localhost.localdomain (dslb-092-077-029-007.092.077.pools.vodafone-ip.de. [92.77.29.7])
        by smtp.gmail.com with ESMTPSA id an7sm16805256wjc.44.2015.12.05.07.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Dec 2015 07:27:33 -0800 (PST)
X-Mailer: git-send-email 2.6.3
In-Reply-To: <xmqqlh9bthyb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282035>

mark_tree_uninteresting dereferences a tree pointer before checking
if the pointer is valid. Fix that by doing the check first.

Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
---
 revision.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 0fbb684..8c569cc 100644
--- a/revision.c
+++ b/revision.c
@@ -135,10 +135,12 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
 
 void mark_tree_uninteresting(struct tree *tree)
 {
-	struct object *obj = &tree->object;
+	struct object *obj;
 
 	if (!tree)
 		return;
+
+	obj = &tree->object;
 	if (obj->flags & UNINTERESTING)
 		return;
 	obj->flags |= UNINTERESTING;
-- 
2.6.3
