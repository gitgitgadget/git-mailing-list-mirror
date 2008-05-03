From: Tim Harper <timcharper@gmail.com>
Subject: [PATCH] "not uptodate" changed to "has local changes"
Date: Sat,  3 May 2008 10:59:32 -0600
Message-ID: <1209833972-12256-1-git-send-email-timcharper@gmail.com>
Cc: Tim Harper <timcharper@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 19:00:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsL60-0006yM-LD
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 19:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760264AbYECQ7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 12:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760840AbYECQ7h
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 12:59:37 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:56065 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760259AbYECQ7g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 12:59:36 -0400
Received: by wf-out-1314.google.com with SMTP id 27so449864wfd.4
        for <git@vger.kernel.org>; Sat, 03 May 2008 09:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=5clLrQzsxQDX3cTzDuc9EMcl2cEB15XITxlyEFyfTkk=;
        b=XQdvLRVjqIyh2VBS77bzwRSlT1MOz+EoODmp8MYJujuRCoPjDQN9D/Caxzzs7w1/FC7aEZVTyyv2L786WqDFqBFddwqb2ILD4yV5CVF3X0tdN5oEX4Y6PA189VEUUBQ+ZAQkVTHTlcdaOvm+DbBkwpgNB8ktHHVHXundieUohC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=knfZTAUD+IUT5+UcfrrzoAOgDW0W7B1TUBfDB6tdFqnepFIbx0TNMBrFKCzU2WpxP6L8Hu8oLmPTm/0UUDIZdODYLqSecx1xyIcgyNANw6KpBLRZ2a7jsc1cv1RAT4yeluONREeEEqk3IjidLhwwdFLNggf6TNnAWMIvXUPkwsA=
Received: by 10.142.68.18 with SMTP id q18mr1752959wfa.310.1209833976288;
        Sat, 03 May 2008 09:59:36 -0700 (PDT)
Received: from localhost ( [66.29.163.1])
        by mx.google.com with ESMTPS id 9sm11211058wfc.6.2008.05.03.09.59.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 May 2008 09:59:34 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81100>

When doing a merge, the message says "file.txt: needs update", or "file.txt: not uptodate, cannot merge".   While internally 'uptodate' makes sense, from the outside it's a mystery.

This patch will make git a little more human friendly, reporting "file.txt: has local changes".
---
 read-cache.c   |    2 +-
 unpack-trees.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index a92b25b..e890b27 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -999,7 +999,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 			}
 			if (quiet)
 				continue;
-			printf("%s: needs update\n", ce->name);
+			printf("%s: has local changes\n", ce->name);
 			has_errors = 1;
 			continue;
 		}
diff --git a/unpack-trees.c b/unpack-trees.c
index a59f475..1d67e08 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -427,7 +427,7 @@ static int verify_uptodate(struct cache_entry *ce,
 	if (errno == ENOENT)
 		return 0;
 	return o->gently ? -1 :
-		error("Entry '%s' not uptodate. Cannot merge.", ce->name);
+		error("Entry '%s' has local changes. Cannot merge.", ce->name);
 }
 
 static void invalidate_ce_path(struct cache_entry *ce, struct unpack_trees_options *o)
-- 
1.5.5.1
