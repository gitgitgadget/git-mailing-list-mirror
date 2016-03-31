From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 3/5] submodule--helper clone: remove double path checking
Date: Thu, 31 Mar 2016 14:04:38 -0700
Message-ID: <1459458280-17619-4-git-send-email-sbeller@google.com>
References: <1459458280-17619-1-git-send-email-sbeller@google.com>
Cc: sunshine@sunshineco.com, jacob.keller@gmail.com,
	norio.nomura@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 31 23:05:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aljly-0008U3-OV
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 23:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933245AbcCaVEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 17:04:52 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36798 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933082AbcCaVEs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 17:04:48 -0400
Received: by mail-pa0-f41.google.com with SMTP id tt10so74053737pab.3
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 14:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TxAqv1sD7OtpYYMmVnvzlApthB7yhTBWgSALLB4ATFU=;
        b=NxozwG8hbJXxiGk9RhJ06VfovaQ9Xn8THQaENkIl0z9NRI1mkDHwhEfD/Qg0I/S8Fq
         9irnqOVK8JOargwXWyWvX73EU04r0c3gnmvYBsVqmKt9YxzUbgWpHUWnjrLvQxObw9y6
         toWBUwvsMFEQYExwiI6fApluVuttd5/9euDu13GX8Z73/oISw4ZwosU7obYUi9r0a8k4
         b03H5IE+c4zaku27ptjDDntk10dsRWYn4Sa0T1m1ZlmT8zClqs64UhT3g5XMI5ef9MtK
         x7kMvPpMdaEV8esLpN+FXLezKpikW9sJd4XJ4lgiv13aVFeq0AUURIK9eEhxgezH/KCd
         +2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TxAqv1sD7OtpYYMmVnvzlApthB7yhTBWgSALLB4ATFU=;
        b=axkw6ZJX1wj1SWN/jMq5aKYKFERZBG/jbxXoxth3AwW77n6Lt30D4srziqiThxDJo7
         fC0yRUUosa/QqPPmDMisvV7LnqJAg2OpOnl5ZKlP6qypk07GB66Gt9iUkMHmedv56lJM
         3qsHgHAlxhuyYqWcs2NOXdiOccNRYdE40iMKoHp29TH9GKmbsknTcF/cTm5zSyWVgP/Z
         JQ4HC16h2GIN0u2+XAkgwaOMUjGRT1ZOMK/HZCEyCL6SDfpcrUYbJ6w4+7XMuKJjDuH3
         MIPd+8OdUZe1hZ0CrWLLLE4Q4YFp3jsINBdsPiavhQuw5clEahoAv3a+uvZhi9oJwu7p
         cKXQ==
X-Gm-Message-State: AD7BkJKdGT0wTHzDS095IpNgW+bJVB3bGQSaKaXkOjmHwXuup6f20Ou4oX46qOaNTvuGCOna
X-Received: by 10.66.122.66 with SMTP id lq2mr9730476pab.155.1459458287147;
        Thu, 31 Mar 2016 14:04:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:30b6:9b24:6e56:d07e])
        by smtp.gmail.com with ESMTPSA id w27sm15470330pfa.67.2016.03.31.14.04.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 31 Mar 2016 14:04:46 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g39f00fe
In-Reply-To: <1459458280-17619-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290468>

We make sure that the parent directory of path exists (or create it
otherwise) and then do the same for path + "/.git".

That is equivalent to just making sure that the parent directory of
path + "/.git" exists (or create it otherwise).

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4f0b002..0b9f546 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -215,11 +215,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	/* Write a .git file in the submodule to redirect to the superproject. */
-	if (safe_create_leading_directories_const(path) < 0)
-		die(_("could not create directory '%s'"), path);
-
 	strbuf_addf(&sb, "%s/.git", path);
-
 	if (safe_create_leading_directories_const(sb.buf) < 0)
 		die(_("could not create leading directories of '%s'"), sb.buf);
 	submodule_dot_git = fopen(sb.buf, "w");
-- 
2.5.0.264.g39f00fe
