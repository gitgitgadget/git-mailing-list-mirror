From: Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH 2/2] clone.c: don't leak memory in cmd_clone
Date: Sun, 10 Aug 2014 15:57:56 +0200
Message-ID: <1407679076-20300-2-git-send-email-stefanbeller@gmail.com>
References: <1407679076-20300-1-git-send-email-stefanbeller@gmail.com>
Cc: Stefan Beller <stefanbeller@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 10 15:58:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGTdc-0001Gz-Dx
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 15:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbaHJN6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2014 09:58:04 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:60389 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbaHJN6D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2014 09:58:03 -0400
Received: by mail-wi0-f179.google.com with SMTP id f8so3033554wiw.0
        for <git@vger.kernel.org>; Sun, 10 Aug 2014 06:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RrE3VPUv+ivnQN6kv5wzwsLehH41Bq1cMoN8rc8PTEA=;
        b=MsM+usTUwcYZI38n4g1amQgIwRIubkW5C0Wd1hFep3ZT+zBurp1z7+G9fpSP9ZYVId
         DzPRJGpUSFGjsQ7HrzRLO6SaK5gUhoxmJQBmO3IQP3ElSmca8tzzO8kcRUj3nClWChYc
         Btj0+iPQGiOtZrgq/VN1RF89ewWvUbyweksvMtkcdbkWJEbFXu6eI6pS4/6JFa72RL8H
         E0Zm169xPtv8ZiBPFtRX8NPFUv+pwCQNYZrdOO+ExuFz1RTOp+lBctC0A5SaTl6aQHsa
         EDSrREuZ82yoIJiwujiXYz0cOvlkZEn+67vajo7abQSpK8oKX4zjmQptQGz+zwSbhfV0
         7tTg==
X-Received: by 10.180.38.84 with SMTP id e20mr12456680wik.43.1407679081993;
        Sun, 10 Aug 2014 06:58:01 -0700 (PDT)
Received: from localhost (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id wi9sm32270111wjc.23.2014.08.10.06.58.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 10 Aug 2014 06:58:01 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.rc2
In-Reply-To: <1407679076-20300-1-git-send-email-stefanbeller@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255091>

Free the refspec.
Found by scan.coverity.com (Id: 1127806)

Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
---
 builtin/clone.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index bbd169c..dd4092b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1004,5 +1004,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&key);
 	strbuf_release(&value);
 	junk_mode = JUNK_LEAVE_ALL;
+
+	free(refspec);
 	return err;
 }
-- 
2.1.0.rc2
