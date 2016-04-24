From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 60/83] apply: libify init_apply_state()
Date: Sun, 24 Apr 2016 15:34:00 +0200
Message-ID: <1461504863-15946-61-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:36:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKCw-0008Jg-3H
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbcDXNgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:36:14 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35145 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbcDXNgL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:11 -0400
Received: by mail-wm0-f48.google.com with SMTP id e201so60543411wme.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iyr/KdS1vUrJLGb82+aRxzc2Q8uo4C4BJ2efDuLTFjE=;
        b=FlNWUDklEqhZX6mwS2UBlxZZtsl2m6HHbnLzCjCsHGMEGxVm1bEB+3zt/NhwuK3pQi
         n6Qevr2ZqLgsEE+MgeZCzqU2kPwCQXPhajpC0YY1P+CABeoNSaONvDMM9zPtTXodCmzt
         4B8OzyfrgCXsKw0sgS7jYuQVFbolnYeCkfqGFzcWK27J9iNSxO1wu/9jdbpOFpLAlQR4
         25XDGmoYGttR4NgWbh7N5pTZ9Nd0mSNQR6GMv8witPfGtXTCN5ecGW5pD0a1CqnPU/ri
         TCNKtU9MO2drACEjFC5EWEet1/R7wg51c29el8FBgDQnJHmSj1M3oKmq7v5G/jTLxAVc
         DVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iyr/KdS1vUrJLGb82+aRxzc2Q8uo4C4BJ2efDuLTFjE=;
        b=lLJxVJCenz+HIgleP2WwVJlUClhWPzglpA4AjkhqQnnoiO0BjuZvVKfS4RXoTf2KBy
         I4NyOaHUV6fAAWfKoh4wsznOCawAgh7bT20kDy4XCncIA/9tpiEBEYh2CxQ19bHnbJT5
         D0NE3RTnIzSmJF6TfEmzxnbHXeqqHDfUZqt1cAA9zcO6U/Z+BFIw5zn20bFYrxzvNyGA
         BYdM3up22aHmzqZjiRITj/h0BwVtTM+CipftQzwYhjpOtNq+4mBcX8eeVwMMCcht/8F6
         FU6KSKDe+9wHvgM80PAtqDaSAW28nBhvxEPdSuqteajJqPq6p997eWgWX+MrRn+K6h0w
         TujQ==
X-Gm-Message-State: AOPr4FUY/jGnSR0hVo6010ulPTob/5asd8bV0y5h1JV8xem4w3Vd141B0uK6fkpfhaF9RA==
X-Received: by 10.28.7.211 with SMTP id 202mr7349718wmh.102.1461504970203;
        Sun, 24 Apr 2016 06:36:10 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:36:09 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292350>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c         | 7 ++++---
 apply.h         | 2 +-
 builtin/apply.c | 3 ++-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/apply.c b/apply.c
index 9c5f258..11bec48 100644
--- a/apply.c
+++ b/apply.c
@@ -56,7 +56,7 @@ int parse_ignorewhitespace_option(struct apply_state *state,
 	return error(_("unrecognized whitespace ignore option '%s'"), option);
 }
 
-void init_apply_state(struct apply_state *state, const char *prefix)
+int init_apply_state(struct apply_state *state, const char *prefix)
 {
 	memset(state, 0, sizeof(*state));
 	state->prefix = prefix;
@@ -73,8 +73,9 @@ void init_apply_state(struct apply_state *state, const char *prefix)
 
 	git_apply_config();
 	if (apply_default_whitespace && parse_whitespace_option(state, apply_default_whitespace))
-		exit(1);
+		return -1;
 	if (apply_default_ignorewhitespace && parse_ignorewhitespace_option(state, apply_default_ignorewhitespace))
-		exit(1);
+		return -1;
+	return 0;
 }
 
diff --git a/apply.h b/apply.h
index 70ab658..021e9e3 100644
--- a/apply.h
+++ b/apply.h
@@ -126,7 +126,7 @@ extern int parse_whitespace_option(struct apply_state *state,
 extern int parse_ignorewhitespace_option(struct apply_state *state,
 					 const char *option);
 
-extern void init_apply_state(struct apply_state *state, const char *prefix);
+extern int init_apply_state(struct apply_state *state, const char *prefix);
 
 
 #endif
diff --git a/builtin/apply.c b/builtin/apply.c
index 1d958fa..e3ee199 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4717,7 +4717,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	init_apply_state(&state, prefix);
+	if (init_apply_state(&state, prefix))
+		exit(1);
 
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
-- 
2.8.1.300.g5fed0c0
