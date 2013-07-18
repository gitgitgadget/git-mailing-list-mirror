From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 2/3] http-push.c, add_send_request: Do not initialize transfer_request.
Date: Thu, 18 Jul 2013 23:35:26 +0200
Message-ID: <1374183327-14939-2-git-send-email-stefanbeller@googlemail.com>
References: <1374183327-14939-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 23:36:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzvrm-0004oH-2n
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 23:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965397Ab3GRVfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 17:35:42 -0400
Received: from mail-wg0-f54.google.com ([74.125.82.54]:63284 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965383Ab3GRVfe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 17:35:34 -0400
Received: by mail-wg0-f54.google.com with SMTP id n11so3329162wgh.33
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 14:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=BQNGENcZr/RNT/PEywr1vZY1IuJGjlqX+mf4tISOwbQ=;
        b=1A+FV002uj598r21VHimWmYUD77S7LHY7dFe2hLE6qGe50X1Nzcq/OK1HQ6AJt9AdG
         cCYOlVcVKPnuCn3DyLb7JtBRXzB/wKCPE9WRC7P9UMoIw6kUuqPfHI15rYudWWwmgZPh
         tpgY0uVGRpIK4MyYK86VoZ+YAgS4HFgKxjG8GKbS2pcG1x+uMruERkqrLVwP1jlAE0AI
         Ctt/LWgjY3kfG9c0AiD1zuffLp0qQPeiBqAFsQfzNfk85kbY3E7FXo2JYTTgLycK62ZC
         3JLRuFGJJ83HkmT7Dvl1GGnE2NWh06O+unGUO+LjOdyWPDaJx63XDFD68NQeLjaAaSRj
         DKtg==
X-Received: by 10.180.21.209 with SMTP id x17mr9315142wie.47.1374183333253;
        Thu, 18 Jul 2013 14:35:33 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id fs8sm44632519wib.0.2013.07.18.14.35.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 14:35:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.754.g9c3c367.dirty
In-Reply-To: <1374183327-14939-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230750>

That pointer will be assigned to new memory via
request = xmalloc(sizeof(*request));
20 lines later unconditionally anyway, so it's safe to not assign it to an
arbitrary variable.

As this patch is a micro-optimization (for readability?) it would be nice
to have as little work with this patch, so maybe I need a feature to send
a patch without a symmetric number of lines around change-diff. For this
patch I'd be only interested in showing the next 20 lines, but nothing
really before the function declaration.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 http-push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http-push.c b/http-push.c
index 395a8cf..6dad188 100644
--- a/http-push.c
+++ b/http-push.c
@@ -663,7 +663,7 @@ static void add_fetch_request(struct object *obj)
 
 static int add_send_request(struct object *obj, struct remote_lock *lock)
 {
-	struct transfer_request *request = request_queue_head;
+	struct transfer_request *request;
 	struct packed_git *target;
 
 	/* Keep locks active */
-- 
1.8.3.3.754.g9c3c367.dirty
