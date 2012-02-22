From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/4] remote: refactor code into alloc_delete_ref()
Date: Thu, 23 Feb 2012 00:43:40 +0200
Message-ID: <1329950621-21165-4-git-send-email-felipe.contreras@gmail.com>
References: <1329950621-21165-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 23:45:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Kvu-0006f5-Nv
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 23:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282Ab2BVWo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 17:44:58 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:51615 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752235Ab2BVWo4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 17:44:56 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id u2so658933lag.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 14:44:56 -0800 (PST)
Received-SPF: pass (google.com: domain of felipe.contreras@gmail.com designates 10.152.128.230 as permitted sender) client-ip=10.152.128.230;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of felipe.contreras@gmail.com designates 10.152.128.230 as permitted sender) smtp.mail=felipe.contreras@gmail.com; dkim=pass header.i=felipe.contreras@gmail.com
Received: from mr.google.com ([10.152.128.230])
        by 10.152.128.230 with SMTP id nr6mr24154454lab.27.1329950696002 (num_hops = 1);
        Wed, 22 Feb 2012 14:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=08DZk0ylug+3PGLQVkyQF6wONCcXZuoX82b5+r1VyCg=;
        b=K3ZT4YOMGaF4hYy4W2zE/UUsFHZnTbm3tSqnf/Urrg5HDCMQkvIlC0v3g9+77kr1/W
         JrU8F93J5kmS35fJVoFbSkZeADoS7ROTA8Cr5cf0uEdN0YreUPJIrMgoUJenUtQJ9z6p
         A3H95/fs0f//INDsq/lpZP/kfywF51XZ9D10s=
Received: by 10.152.128.230 with SMTP id nr6mr20263980lab.27.1329950695941;
        Wed, 22 Feb 2012 14:44:55 -0800 (PST)
Received: from localhost (a88-113-3-26.elisa-laajakaista.fi. [88.113.3.26])
        by mx.google.com with ESMTPS id fl2sm33527026lbb.4.2012.02.22.14.44.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Feb 2012 14:44:55 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1329950621-21165-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191305>

Will be useful in next patches. No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 remote.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index 9d29acc..4709e20 100644
--- a/remote.c
+++ b/remote.c
@@ -978,16 +978,20 @@ static void tail_link_ref(struct ref *ref, struct ref ***tail)
 	*tail = &ref->next;
 }
 
+static struct ref *alloc_delete_ref(void)
+{
+	struct ref *ref = alloc_ref("(delete)");
+	hashclr(ref->new_sha1);
+	return ref;
+}
+
 static struct ref *try_explicit_object_name(const char *name)
 {
 	unsigned char sha1[20];
 	struct ref *ref;
 
-	if (!*name) {
-		ref = alloc_ref("(delete)");
-		hashclr(ref->new_sha1);
-		return ref;
-	}
+	if (!*name)
+		return alloc_delete_ref();
 	if (get_sha1(name, sha1))
 		return NULL;
 	ref = alloc_ref(name);
-- 
1.7.9.1
