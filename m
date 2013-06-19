From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/6] push: remove dead code in setup_push_upstream()
Date: Wed, 19 Jun 2013 16:41:42 +0530
Message-ID: <1371640304-26019-5-git-send-email-artagnon@gmail.com>
References: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 19 13:15:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpGM6-0003RE-JF
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 13:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934420Ab3FSLPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 07:15:09 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:43029 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933666Ab3FSLPC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 07:15:02 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so5060596pab.11
        for <git@vger.kernel.org>; Wed, 19 Jun 2013 04:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ldKc1mq3aC2mn5I64PCgNxqachTnPSLR11lp/Ia/xy0=;
        b=MNiNjCceNO5KPmEjvCNlEZ92B1Q2vifTtMvwjZ0ijaRdrlAwLllz4O3N8rQYt2WwbX
         5kXSEC7AoXTvDsoIpr7QzxxPMsWqVT4WcGLPf8kS1EpvvttT2piIGi7yOyeIYKumth5F
         u5WQWrt3/LlxBwFjNjQgfTXHns2JN5aYVi+x79Zw9WQDFcWTZf9rj/Pe/7ZhReOUk3pV
         FYB4jlCukulka4hwNElE5KzEb6OxAcEIY7kJqdqx8NHSt527DkoUfnhmMNmO7zi9IqpK
         mzhCVt1TNLhUOIlglC1xu5vcZVLX5pNnmJfS6TP8f5NPg1ZGG8ILKRW/DHLAnBgmTIah
         yRqA==
X-Received: by 10.67.12.175 with SMTP id er15mr6194541pad.31.1371640501594;
        Wed, 19 Jun 2013 04:15:01 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id iq2sm22746579pbb.19.2013.06.19.04.14.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 04:15:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.454.gff6ba36
In-Reply-To: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228387>

Now that simple has been decoupled from upstream in setup_push_simple(),
remove the dead code in setup_push_upstream().

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/push.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index d8d27d9..783bacf 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -139,7 +139,7 @@ end:
 	add_refspec(branch->name);
 }
 
-static void setup_push_upstream(struct remote *remote, int simple)
+static void setup_push_upstream(struct remote *remote)
 {
 	struct strbuf refspec = STRBUF_INIT;
 	struct branch *branch = branch_get(NULL);
@@ -161,8 +161,6 @@ static void setup_push_upstream(struct remote *remote, int simple)
 		      "your current branch '%s', without telling me what to push\n"
 		      "to update which remote branch."),
 		    remote->name, branch->name);
-	if (simple && strcmp(branch->refname, branch->merge[0]->src))
-		die_push_simple(branch, remote);
 
 	strbuf_addf(&refspec, "%s:%s", branch->name, branch->merge[0]->src);
 	add_refspec(refspec.buf);
@@ -211,7 +209,7 @@ static void setup_default_push_refspecs(struct remote *remote)
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
-		setup_push_upstream(remote, 0);
+		setup_push_upstream(remote);
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
-- 
1.8.3.1.454.g30263f3.dirty
