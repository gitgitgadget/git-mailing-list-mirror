From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 01/10] submodule deinit test: fix broken && chain in subshell
Date: Fri, 29 Apr 2016 17:40:36 -0700
Message-ID: <1461976845-18228-2-git-send-email-sbeller@google.com>
References: <1461976845-18228-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 02:41:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awIy2-0006bS-Du
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 02:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923AbcD3AlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 20:41:01 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34446 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbcD3Ak4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 20:40:56 -0400
Received: by mail-pa0-f45.google.com with SMTP id r5so52501818pag.1
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 17:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yxzkABTUJX8gYgXOeuVSa6UbFgaZNgvhJ5mlXZaNNb8=;
        b=Pu0sJPrECyiu2Gho20LETTgezTmWSZ2Hv1sODp2ZWFEzTUv/hSr4QfJRcbvDMeJLDA
         BFwdVLQQHG2AbM2C7iU3fw7Z71pJThf1R9ORLzlAVL0BxWdskq4nwc022NbaEd9+7EDb
         ICas9HVH51L9JM6VSnxI5xx/+p0fyY0tg4L7RshUSyIUTSxH1f+avBpp3JjqWJ4E/EF/
         uy7v4xc4DEq6Sa7fuxxlsuxNmi/2yDTohiGI5niXrWRmcitT6ZKki2VzW0N3iHJKlH4X
         znfPLcIqPbJlCmjzTQ0WyTycdrEDkQz5mdlWkMvKBCMDegfZM+rwwrn1AiizDIuSFWqp
         QSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yxzkABTUJX8gYgXOeuVSa6UbFgaZNgvhJ5mlXZaNNb8=;
        b=Lxm+JYdQ0r5MHhxNwmgXTIFLY0WZhJh3H/w0MSjsOucpFk3zFbE4BA+iiVa4Pz3F6N
         2kFdXwyWPRY4cYSKYpu9T9B9TE/GQXB8pADgM4rLA8p001GAeVji7LL0L851PIO8kjrf
         4wHVtsmjqAn6B4c1ivT6HxwuWKvgHFATztvuHl3UEQ2x7Ne72WCnH9MRNbaCmzR4DPc8
         cvj1/M8p9X5i6OiKMGGLNmeqlYeTaEwUxVBNVYxc239vIHbV0/syZZykCKcOmPdEj5XP
         7JyHayOG9/8OxMY/AEzGVoQ83dZjwlKnzZ43AoT2k70NUmyGfbQishggE5pf3CH8ab0m
         71OA==
X-Gm-Message-State: AOPr4FU1YItnNQ9PjmsVDn3j2VW4BIx+jwH+WlPa4h72Wn6cy5UA2JcXYF/vLvr7wyRWv0QL
X-Received: by 10.66.72.137 with SMTP id d9mr22553867pav.151.1461976850632;
        Fri, 29 Apr 2016 17:40:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id 19sm26395161pfu.83.2016.04.29.17.40.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 17:40:50 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
In-Reply-To: <1461976845-18228-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293086>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7400-submodule-basic.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 814ee63..90d80d3 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -914,7 +914,7 @@ test_expect_success 'submodule deinit works on repository without submodules' '
 		git init &&
 		>file &&
 		git add file &&
-		git commit -m "repo should not be empty"
+		git commit -m "repo should not be empty" &&
 		git submodule deinit .
 	)
 '
-- 
2.8.0.32.g71f8beb.dirty
