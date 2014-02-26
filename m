From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [RFC 3/3] reset: Change the default behavior to use "--merge" during a merge
Date: Wed, 26 Feb 2014 13:06:25 -0500
Message-ID: <1393437985-31401-4-git-send-email-andrew.kw.w@gmail.com>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 26 19:06:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIisX-0004U4-7Y
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 19:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbaBZSGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 13:06:41 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:65077 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbaBZSGj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 13:06:39 -0500
Received: by mail-ie0-f173.google.com with SMTP id lx4so1001673iec.18
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 10:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hp+ZlhLlWbAqcOCmYKujsYQ2JS9HWPIFq48DAyzXsFs=;
        b=kwA6Vp5bCUaBD73c7/PI1nzNTPInsZrmLfWTGoSB059kJf9w0gmtgFjWplmTTj7pMi
         9ZBVqK6KLgNjzLSYThQwF4u3iWxd2Lz3tknBOtw3PeHHsIvBXzCcxJPseasTLLjnF8OM
         6t2tJ2Kgpf8dJbDNX7tpwfupsjS7yqQ7LGIIUWWH2tRzDqDdBfkgrUKt5VaT9nO5AvB5
         3tatcBWvHmqJ5boNoO2MEq+mONkdjWG5nVXc01IEfPHikUB+FPpKXwA1W6EBlLwoJj3l
         lz3DCiBS5trlk/aJO+usCLhOX+JlL0kUVt3lxEaXB1yvheajuXJd5Qkh9Op/7uScEU/N
         uu5Q==
X-Received: by 10.42.119.134 with SMTP id b6mr679211icr.31.1393437999577;
        Wed, 26 Feb 2014 10:06:39 -0800 (PST)
Received: from dresden.sidefx.com (nat.sidefx.com. [38.104.156.10])
        by mx.google.com with ESMTPSA id kb5sm1968331igb.1.2014.02.26.10.06.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Feb 2014 10:06:38 -0800 (PST)
X-Mailer: git-send-email 1.9.0.7.g53f6706
In-Reply-To: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242742>

If the user wants to do "git reset" during a merge, the user most likely
wants to do a "git reset --merge". This is especially true during a
merge conflict and the user had local changes, because "git reset" would
leave the merged changes mixed in with the local changes. This makes
"git reset" a little more user-friendly during a merge.

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 builtin/reset.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 6004803..740263d 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -318,7 +318,12 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 					_(reset_type_names[reset_type]));
 	}
 	if (reset_type == NONE)
-		reset_type = MIXED; /* by default */
+	{
+		if(is_merge())
+			reset_type = MERGE;
+		else
+			reset_type = MIXED;
+	}
 
 	if (reset_type != SOFT && reset_type != MIXED)
 		setup_work_tree();
-- 
1.9.0.6.g16e5f9a
