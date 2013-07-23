From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] rm: do not set a variable twice without intermediate reading.
Date: Tue, 23 Jul 2013 11:19:22 +0200
Message-ID: <1374571162-22881-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 23 11:19:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1YkU-0008Cc-VF
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 11:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755827Ab3GWJTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 05:19:11 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:41274 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab3GWJTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 05:19:09 -0400
Received: by mail-wg0-f51.google.com with SMTP id e11so6724817wgh.18
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 02:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=4xJv/yfrmc02odo/sYHYW+sJIf10lNi6ZyK+a00LpHE=;
        b=OzXo42s8ucGVk1gQBCNSglpYcN8ztLn99Zh9QB0z6RInqHcNSseQvYTJpQXDx7GGBe
         8qy603DeLfCbV/x9LoReTFgTmMJ7k9s5XMkkMaTZRKiEF9Ztmq0WSAhDx+w6F1zaeVKl
         OWpobCLbzpMSfftE14Ich+6EWzWEWsE7pSIcjjfa4Q4F+EEVHNkiwBknrAgU8dGGu02F
         h0EWe04b+GU6wUCx3ZiWtHx2ke/81xU8r940U9a+jxD8MdIDUig5gYng0vqhQsmn/v5F
         E8xVJcQ85E6SbRWQLGvkCjN22sDu9ZusWdGX1RFfN5MAPPCjXwEDqsatxQI6DUUYISCF
         pSVg==
X-Received: by 10.194.91.194 with SMTP id cg2mr22998542wjb.53.1374571148450;
        Tue, 23 Jul 2013 02:19:08 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id d8sm4498017wiz.0.2013.07.23.02.19.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jul 2013 02:19:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.1135.ge2c9e63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231032>

Just the next line assigns a non-null value to seen.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/rm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 5b63d3f..df85f98 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -316,7 +316,6 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD, prefix, argv);
 	refresh_index(&the_index, REFRESH_QUIET, &pathspec, NULL, NULL);
 
-	seen = NULL;
 	seen = xcalloc(pathspec.nr, 1);
 
 	for (i = 0; i < active_nr; i++) {
-- 
1.8.3.3.1135.ge2c9e63
