From: Sun He <sunheehnus@gmail.com>
Subject: [PATCH] GSoC2014 microprojects #5 Change bundle.c:add_to_ref_list() to use hashcpy()
Date: Thu, 27 Feb 2014 22:58:47 +0800
Message-ID: <1393513127-32399-1-git-send-email-sunheehnus@gmail.com>
Cc: mhagger@alum.mit.edu, Sun He <sunheehnus@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 27 16:00:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ2Rg-0003dN-Vu
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 16:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbaB0PAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 10:00:13 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:63206 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbaB0PAM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 10:00:12 -0500
Received: by mail-pa0-f47.google.com with SMTP id lj1so809767pab.34
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 07:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=J0ia0j9z1599Ty7MKu271py5YSjGpFzp/pYACKgJdFI=;
        b=uUNXoSzq6KkE1Yx4SRdFvunLqjHonG0hVB7PW6yzwQPjhfmwI0sSS6y82D4zisneVL
         kKqvyVksMwXwz51eiKb41yxMUPJhpwtz02w4LKcpNVHyP+fF4Ch9A2bqwc14+1HnKCim
         dF0N6FU+/47Tq+QrUjC+W3zNU5cMhBTWVJR9nujzrluPVzG18oJjHxEMgXp8aNtAzCt7
         4ma8JyT5ILKCZbj7dbE21013l7Hc70wHpy87LUfn72W+oNknb8L87VhU3mVnCNAXSsPl
         vELdomdFfxshDIymIqeDMxkMvn4lPdjEi6qLq+PzO9PdU2Nwv9dDkGBaPuOm2bNbS16t
         0T1g==
X-Received: by 10.67.1.202 with SMTP id bi10mr15861992pad.68.1393513210152;
        Thu, 27 Feb 2014 07:00:10 -0800 (PST)
Received: from localhost.localdomain ([61.150.43.99])
        by mx.google.com with ESMTPSA id dc4sm14293203pbc.34.2014.02.27.07.00.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2014 07:00:09 -0800 (PST)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242828>


Signed-off-by: Sun He <sunheehnus@gmail.com>
---
 bundle.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bundle.c b/bundle.c
index e99065c..7809fbb 100644
--- a/bundle.c
+++ b/bundle.c
@@ -19,7 +19,7 @@ static void add_to_ref_list(const unsigned char *sha1, const char *name,
 		list->list = xrealloc(list->list,
 				list->alloc * sizeof(list->list[0]));
 	}
-	memcpy(list->list[list->nr].sha1, sha1, 20);
+	hashcpy(list->list[list->nr].sha1, sha1);
 	list->list[list->nr].name = xstrdup(name);
 	list->nr++;
 }
-- 
1.7.1

> See if you can find other places where hashcpy() should be used instead of memcpy()
grep.c:grep_source_init()
reflog-walk.c:read_one_reflog()
ppc/sha1.c:ppc_SHA1_Final()
refs.c:resolve_gitlink_packed_ref()

We can find those by the shell command:
$ find . | xargs grep "memcpy\(.*20.*\)


Cheers,
He Sun
