From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/6] remote.c: simplify a bit of code using git_config_string()
Date: Fri, 22 Mar 2013 13:22:31 +0530
Message-ID: <1363938756-13722-2-git-send-email-artagnon@gmail.com>
References: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 22 08:52:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIwlc-0002Ky-SB
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 08:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518Ab3CVHva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 03:51:30 -0400
Received: from mail-da0-f51.google.com ([209.85.210.51]:46464 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463Ab3CVHv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 03:51:29 -0400
Received: by mail-da0-f51.google.com with SMTP id g27so2031291dan.38
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 00:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=q3TIXjCOZTUzzKK85abxkxEktxolVf9L16M5/Z+g/mc=;
        b=evNB4XeTN+RZty8noytuWFMhLondH6CosOfAve99Lf98/n6xYpb9AYTGHTkjd9eiwJ
         h3e5ZrTi/PkEmBs56XuYzWr9XXaZX+uczC4lOZeXX1V6RerDyLjvaN1lNED24T7pO3f3
         iUh7hgjBe83j5GiSQl9hC4daTBvlf41WPYzNTk4yDnzAc050QSeI/l+ta08NBQ/hbET3
         H/oCXE6gxkPUVpK62nZeMh+ZvkorKFwpBoyNQkr8scCr879+gdpE0g5JgKUQHl/fH4IU
         x1rMhFapWwAerXBZjxFBZp1tBrzIuIyJ1P2YQczXmcQnQJxEXKLNyniuX2l34tQtGcSh
         aS7A==
X-Received: by 10.66.152.129 with SMTP id uy1mr1895536pab.36.1363938688721;
        Fri, 22 Mar 2013 00:51:28 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id fh1sm2025227pac.1.2013.03.22.00.51.26
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 00:51:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.62.ga35d936.dirty
In-Reply-To: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218780>

A small segment where handle_config() parses the branch.remote
configuration variable can be simplified using git_config_string().

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 remote.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index e53a6eb..5bd59bb 100644
--- a/remote.c
+++ b/remote.c
@@ -356,9 +356,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 			return 0;
 		branch = make_branch(name, subkey - name);
 		if (!strcmp(subkey, ".remote")) {
-			if (!value)
-				return config_error_nonbool(key);
-			branch->remote_name = xstrdup(value);
+			if (git_config_string(&branch->remote_name, key, value))
+				return -1;
 			if (branch == current_branch) {
 				default_remote_name = branch->remote_name;
 				explicit_default_remote_name = 1;
-- 
1.8.2.62.ga35d936.dirty
