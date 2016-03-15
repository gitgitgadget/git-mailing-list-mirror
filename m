From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] submodule-config: use hashmap_iter_init()
Date: Wed, 16 Mar 2016 00:25:30 +0600
Message-ID: <1458066330-5107-1-git-send-email-kuleshovmail@gmail.com>
Cc: Git <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 19:25:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aftf8-0004tk-64
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 19:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965586AbcCOSZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 14:25:42 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35103 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965508AbcCOSZk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 14:25:40 -0400
Received: by mail-lf0-f53.google.com with SMTP id l202so2021695lfl.2
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 11:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Ago7ChsgbSd5kreNnMV8gkCh//Xs0sxytNGIRqwgzO8=;
        b=Zgzb4OeiQ3P4Uyf+6fzR3ajtH/z3sUeKNc8Vdi7fhJwlQTqnjsglPeD7KPy1q4Xbjv
         6eb1WsJGbG9pcwV+j7ufG6uvePApxvsbe8MEEh9DhgNGpI6B3RrK8sIQHDU+V01Xhl7e
         iEi0zj2AJ2h2gaOvVzGwy4CT1JrsnSA2GJO4XhJf3RkxkBGjViZUw859wNIIO6aNYmWP
         /tXthwjgAoFmmgg5dRgQ1txT0bGbJZ1qcPc2sER9aYKP/3VIG4USFZt/KOO/F4IMdPjY
         O7nicdrN0gRboDsuv/C8CERSoLCg/z36pwk77YeDhuAhWIgzjIk9+NQpmvU5tK3p498t
         GTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ago7ChsgbSd5kreNnMV8gkCh//Xs0sxytNGIRqwgzO8=;
        b=Bfy8nM9ntzC1f/ZCo0QDUPVIsvXBn8igSwWeowelQ6UpdvBmCPd/LDEBFzbkvxKwHW
         30m8oFgIuR4EqggRZU2Zs3Dah6Vgip6+it8DjeIp48mWAuFNxU2YgGahqJehuHPlMilk
         b9fRIYYP3GAR8uta0S6gdWgtr17Oz5c4xov2NpEJdDFkUd55Cni9tbC6uzKIaDDD1VtI
         NflDIaA/9iXqY8a5DO2QGtNfTbOzHXtX0b4kRmjYR76AvjelA6G5SopsgorQNRbp1nP8
         ihsm9gpqZ7ixcFiJqZHgamzH8CoZsAiu+z0zC14gpzUhn0w+GmQd4zWjqn4tg0LNgj5S
         bYTw==
X-Gm-Message-State: AD7BkJLBzkq6KmU8c4dXGIoiyl11nfjby+kjezuvEQ/4zwR/DwEmk0BLBojGQiC6xVYlxQ==
X-Received: by 10.25.213.134 with SMTP id m128mr10479709lfg.87.1458066338676;
        Tue, 15 Mar 2016 11:25:38 -0700 (PDT)
Received: from localhost.localhost ([2.135.251.45])
        by smtp.gmail.com with ESMTPSA id aa9sm4459877lbc.16.2016.03.15.11.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Mar 2016 11:25:37 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc2.216.g1477fb2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288888>

from the <hashmap.h> for simplification.
---
 submodule-config.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index b82d1fb..8ac5031 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -405,8 +405,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 		struct hashmap_iter iter;
 		struct submodule_entry *entry;
 
-		hashmap_iter_init(&cache->for_name, &iter);
-		entry = hashmap_iter_next(&iter);
+		entry = hashmap_iter_first(&cache->for_name, &iter);
 		if (!entry)
 			return NULL;
 		return entry->config;
-- 
2.8.0.rc2.216.g1477fb2.dirty
