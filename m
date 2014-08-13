From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 2/4] ll-merge.c: refactor `read_merge_config()` to use `git_config_string()`
Date: Wed, 13 Aug 2014 01:22:00 -0700
Message-ID: <1407918122-29973-2-git-send-email-tanayabh@gmail.com>
References: <1407918122-29973-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 10:22:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHTpf-0003T1-Em
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 10:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbaHMIWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 04:22:48 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:45795 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbaHMIWr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 04:22:47 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so14100665pdj.12
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 01:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZueE7byV/+znLKVI3WOhYcQYTQU4pdokSM4dtDJndqw=;
        b=gums6x1IKDe0aNs8D1EughnfLOrdybxEyUijeCSuCiYr+/EpJqybhsgNnIfiGN3VfV
         PIfsbtvo+VSxyAXKZqEfSBNisJSPd14qH+xnxXBRZmGVcRjx1y0u5FzKE5R/Tvn4foku
         GEUG6Jmlt7A+r4T8fNTbghH0vbVwQc5MoZhnI5lcIQE+wsmQ7afq+/FbRDqzu8jDEOUZ
         SGNIviKuvC8Q2jAfDItw1l3n3B0kzlPMozeHfT9yi/YPKnLzqchn0M0YxSwqViFdxLv0
         uhZFjSJSu8728XZUbWZ2hUI+CQl3I6q7qIZLGt5ltqTYUVIeVwH6mhW98KKLyL1dv7ty
         5Fxg==
X-Received: by 10.70.94.201 with SMTP id de9mr2643547pdb.103.1407918166750;
        Wed, 13 Aug 2014 01:22:46 -0700 (PDT)
Received: from localhost.localdomain ([117.254.222.211])
        by mx.google.com with ESMTPSA id fm12sm1919517pdb.46.2014.08.13.01.22.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Aug 2014 01:22:46 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407918122-29973-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255187>

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 ll-merge.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/ll-merge.c b/ll-merge.c
index fb61ea6..8ea03e5 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -225,11 +225,8 @@ static int read_merge_config(const char *var, const char *value, void *cb)
 	const char *key, *name;
 	int namelen;
 
-	if (!strcmp(var, "merge.default")) {
-		if (value)
-			default_ll_merge = xstrdup(value);
-		return 0;
-	}
+	if (!strcmp(var, "merge.default"))
+		return git_config_string(&default_ll_merge, var, value);
 
 	/*
 	 * We are not interested in anything but "merge.<name>.variable";
@@ -254,12 +251,8 @@ static int read_merge_config(const char *var, const char *value, void *cb)
 		ll_user_merge_tail = &(fn->next);
 	}
 
-	if (!strcmp("name", key)) {
-		if (!value)
-			return error("%s: lacks value", var);
-		fn->description = xstrdup(value);
-		return 0;
-	}
+	if (!strcmp("name", key))
+		return git_config_string(&fn->description, var, value);
 
 	if (!strcmp("driver", key)) {
 		if (!value)
@@ -285,12 +278,8 @@ static int read_merge_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (!strcmp("recursive", key)) {
-		if (!value)
-			return error("%s: lacks value", var);
-		fn->recursive = xstrdup(value);
-		return 0;
-	}
+	if (!strcmp("recursive", key))
+		return git_config_string(&fn->recursive, var, value);
 
 	return 0;
 }
-- 
1.9.0.GIT
