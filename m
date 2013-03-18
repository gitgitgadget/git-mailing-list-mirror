From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/4] remote.c: simply a bit of code using git_config_string()
Date: Mon, 18 Mar 2013 18:46:12 +0530
Message-ID: <1363612575-7340-2-git-send-email-artagnon@gmail.com>
References: <1363612575-7340-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 18 14:15:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHZub-0003sO-JV
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 14:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222Ab3CRNPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 09:15:11 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:45552 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab3CRNPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 09:15:09 -0400
Received: by mail-da0-f46.google.com with SMTP id y19so12275dan.33
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 06:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Gr5LlsBAil0V4mNMJ/Xa7xEdA7z03SCUbgptvMXw5pM=;
        b=RIwsiTIo2zKxGVxgi+AMKlppHIq4gOwng7uWAeruHb90m0545SW8cxcZRytnjADrVk
         hTg0ZcKWby0Cr0GN/qPXEXKX2P81OqdAWh5L7TQfD29Y967j2eb4rGUMenDX/nAIdX9p
         dKCJ3iNVwCD/bdzHuMVp0E8GgXgGMG/jLL6zdo/t+FIK4Mh8UCGhgVr62GsU5uBPJnN3
         3sgNOjMl3Vl433+pIeETdCpYroge0kMby6Fh15+Qfq75fNbhVo08EDwJ/wmkcVBL1qoX
         UclTNUf9jNcFUofW9oE4O9j3OKVWfslT99YSH+ELFEo5dCX+7Z19tE8d9rR7ifuvwQVB
         HPdA==
X-Received: by 10.66.228.194 with SMTP id sk2mr10491677pac.51.1363612509104;
        Mon, 18 Mar 2013 06:15:09 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id y1sm20178280pbg.10.2013.03.18.06.15.06
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 06:15:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1363612575-7340-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218411>

A small segment where handle_config() parses the branch.remote
configuration variable can be simplified using git_config_string().

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 remote.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index e53a6eb..45b69d6 100644
--- a/remote.c
+++ b/remote.c
@@ -356,9 +356,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 			return 0;
 		branch = make_branch(name, subkey - name);
 		if (!strcmp(subkey, ".remote")) {
-			if (!value)
-				return config_error_nonbool(key);
-			branch->remote_name = xstrdup(value);
+			git_config_string(&branch->remote_name, key, value);
 			if (branch == current_branch) {
 				default_remote_name = branch->remote_name;
 				explicit_default_remote_name = 1;
-- 
1.8.2
