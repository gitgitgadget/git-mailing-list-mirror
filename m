Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C52A11F404
	for <e@80x24.org>; Sat, 21 Apr 2018 16:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbeDUQyd (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 12:54:33 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43159 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752935AbeDUQyb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 12:54:31 -0400
Received: by mail-lf0-f66.google.com with SMTP id v207-v6so9176888lfa.10
        for <git@vger.kernel.org>; Sat, 21 Apr 2018 09:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3qsaI1ZCIHOo9XPw1ppWG14r24ZmRFMHjllTJG4Pl7c=;
        b=IDxEfnUMFptllKMV/e0AedytVC4RCamUsDpIbvvTrqVZZSHmN/9RB/4egQ8BlvZlo6
         6EUIkAf9+XXAP3zCYR1G8xLgo6KaxYxdOU5c/t5AnE/N7jjJTsdgQtzbJHhKnCjs2lk7
         7doZS4C9R6Ht+q84dD3i9FFb8YiSrWI51Lnu4+8+dq30U7k61KY1LAgP470/Vy/okBi4
         oilQGx1AYV9hZeym55s5nZJDIIieLn3Wee//Baj2Tp/Rt4c52s/+AUWVdI4xfsXcFiPK
         3Tj1V4bAzHY8G8fFvj9dsbE4vLxiyT5o66IxPvYcTm0aiWpIf//eyePyyuFwcv5jbWjE
         LRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3qsaI1ZCIHOo9XPw1ppWG14r24ZmRFMHjllTJG4Pl7c=;
        b=KPTcHea6yAyYPgIidXnOqYKpmFLcD6qQbu5JlTut+PSnruyf5dviaV3GHkfvVxK1TZ
         IfOet3pPz8uER4WFoGntetOvjukC0FhZH+TBsGZ/uq7GeD2H9/a0xfM2yFze7G46mad4
         hE++yBBaRO3SHqZ9HTS58wXrsiAT7PyPNKYuH8WKpaEEKRkSEpLY5BLpJBc5V/+nRtLw
         gvIc8/e7UgjHdPFty4TFOdknnYChpv+CvhmQF0Z9FPhJ2TdfLEhfB0yaDMNjBkkCN9fD
         s0yU0mxnfuzoGT5AiFGRLUhPoA+SOoziPRwhH0f8c84rGbHKMihfSQPF6r4gIZGXs+ak
         l5Fw==
X-Gm-Message-State: ALQs6tAczgYEgOYQ1x/sMFjsWOd4lPzAr8M5BY8iGH4ZZpLyHZaSOGnM
        i7G7mdiBhAutF42Ucmehk4u50Q==
X-Google-Smtp-Source: AIpwx4/Ky64dA/b7EsF9iGU9vVotDWV/kwP08hHrPbj4M8JWN3Er1iCCnGFKw86ImvbypOBsSY00Bg==
X-Received: by 10.46.145.213 with SMTP id u21mr2865169ljg.0.1524329670419;
        Sat, 21 Apr 2018 09:54:30 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g81sm1526523ljb.12.2018.04.21.09.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Apr 2018 09:54:29 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, philipoakley@iee.org,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v3 1/6] git.c: convert --list-*builtins to --list-cmds=*
Date:   Sat, 21 Apr 2018 18:54:09 +0200
Message-Id: <20180421165414.30051-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180421165414.30051-1-pclouds@gmail.com>
References: <20180415164238.9107-1-pclouds@gmail.com>
 <20180421165414.30051-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even if these are hidden options, let's make them a bit more generic
since we're introducing more listing types shortly.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash |  2 +-
 git.c                                  | 12 +++++++-----
 t/t0012-help.sh                        |  2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a757073945..3556838759 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3049,7 +3049,7 @@ __git_complete_common () {
 __git_cmds_with_parseopt_helper=
 __git_support_parseopt_helper () {
 	test -n "$__git_cmds_with_parseopt_helper" ||
-		__git_cmds_with_parseopt_helper="$(__git --list-parseopt-builtins)"
+		__git_cmds_with_parseopt_helper="$(__git --list-cmds=parseopt)"
 
 	case " $__git_cmds_with_parseopt_helper " in
 	*" $1 "*)
diff --git a/git.c b/git.c
index 3a89893712..28bfa96d87 100644
--- a/git.c
+++ b/git.c
@@ -223,11 +223,13 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			}
 			(*argv)++;
 			(*argc)--;
-		} else if (!strcmp(cmd, "--list-builtins")) {
-			list_builtins(0, '\n');
-			exit(0);
-		} else if (!strcmp(cmd, "--list-parseopt-builtins")) {
-			list_builtins(NO_PARSEOPT, ' ');
+		} else if (skip_prefix(cmd, "--list-cmds=", &cmd)) {
+			if (!strcmp(cmd, "builtins"))
+				list_builtins(0, '\n');
+			else if (!strcmp(cmd, "parseopt"))
+				list_builtins(NO_PARSEOPT, ' ');
+			else
+				die("unsupported command listing type '%s'", cmd);
 			exit(0);
 		} else {
 			fprintf(stderr, _("unknown option: %s\n"), cmd);
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 487b92a5de..fd2a7f27dc 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -50,7 +50,7 @@ test_expect_success "--help does not work for guides" "
 "
 
 test_expect_success 'generate builtin list' '
-	git --list-builtins >builtins
+	git --list-cmds=builtins >builtins
 '
 
 while read builtin
-- 
2.17.0.367.g5dd2e386c3

