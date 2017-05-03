Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63398207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753321AbdECKTR (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:19:17 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33025 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753301AbdECKTN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:19:13 -0400
Received: by mail-pg0-f66.google.com with SMTP id s62so16005297pgc.0
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iHH1ZY37E5plcICyNqYjjcagnyn4h5XjS39ngCkbOVo=;
        b=utIOIOD3bqjVSHEgi8owAkSuPoEPG/Ba35+gWX9X0qUenh5mJw8Tnf/j9DuvmZaJsp
         GDe2Xob/imw4l9SAE/aC5Lm4YTYTJxBCi/Y3aGit4/2GsJaeUbKvwLf8CF3EUE2YJt5k
         IFsvky3lHzPAW9+VQP0iTYCIDJu8HYzI9yeOikkDrf7eWPlOtQ54EQjaiC9fgLK9OHHa
         VvDY9OB/JwUo1oGrb9ONR8Glbqiu47ZXwIoq9762IneNWAHwjh4RxVuWU/pI1rfCB1o9
         Gp7zZoxupcjN7VLtQv/KfD4JJBMYP+0nNOrg7l4yUhXqlX+g62eCP9r8DkSsEO7SbUK/
         48cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iHH1ZY37E5plcICyNqYjjcagnyn4h5XjS39ngCkbOVo=;
        b=DS2QLelWQ2ly9zubuTeDsAnoEqiPe4J8ERjCGNNg3jdsf9D3GfM5ONqE40iXQjAo4h
         CQQZvC+68FFiYkOFAZPNkTBudMC2998e+F5TG42TXkB7a27E5qDqfpL+sJOEM1PlEg3F
         KCS9C69EEAyKro7Wusjol6mmbb+ThTIcetsx/4jNtv9hYueODe6T6mfRagj8aJbHxqEQ
         5u6z3pGRJhhmIH8fgVsDJNX3+ZGkErSGHR1AUuGGui890r8P3tX50yLmSv6N3qqbnhyG
         syqF/ekM9P8WpLnwOH3ZjoB/iuUCqUYUNNMsfmNoMqvUEINwnRo38qmx5WAoJ13CQ2pv
         Ee9g==
X-Gm-Message-State: AN3rC/74ytapw9ICcXyAhQeqXNNvziN1KNUBwzWMSqVbqnBD80HYd9hX
        yThj8OwS+nIMmgxi
X-Received: by 10.84.224.10 with SMTP id r10mr24217415plj.25.1493806752438;
        Wed, 03 May 2017 03:19:12 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id n126sm32524638pgn.32.2017.05.03.03.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 03:19:11 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 May 2017 17:19:07 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 13/21] remote.c: report error on failure to fopen()
Date:   Wed,  3 May 2017 17:16:58 +0700
Message-Id: <20170503101706.9223-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170503101706.9223-1-pclouds@gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com>
 <20170503101706.9223-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's plenty of error() in this code to safely assume --quiet is not a
concern.

t5512 needs update because if we check the path 'refs*master' (i.e. the
asterisk is part of the path) then we'll get an EINVAL error.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 remote.c             |  4 ++--
 t/t5512-ls-remote.sh | 13 ++++++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index 801137c72e..1f2453d0f6 100644
--- a/remote.c
+++ b/remote.c
@@ -251,7 +251,7 @@ static const char *skip_spaces(const char *s)
 static void read_remotes_file(struct remote *remote)
 {
 	struct strbuf buf = STRBUF_INIT;
-	FILE *f = fopen(git_path("remotes/%s", remote->name), "r");
+	FILE *f = fopen_or_warn(git_path("remotes/%s", remote->name), "r");
 
 	if (!f)
 		return;
@@ -277,7 +277,7 @@ static void read_branches_file(struct remote *remote)
 {
 	char *frag;
 	struct strbuf buf = STRBUF_INIT;
-	FILE *f = fopen(git_path("branches/%s", remote->name), "r");
+	FILE *f = fopen_or_warn(git_path("branches/%s", remote->name), "r");
 
 	if (!f)
 		return;
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 94fc9be9ce..02106c9226 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -85,8 +85,15 @@ test_expect_success 'use branch.<name>.remote if possible' '
 '
 
 test_expect_success 'confuses pattern as remote when no remote specified' '
-	cat >exp <<-\EOF &&
-	fatal: '\''refs*master'\'' does not appear to be a git repository
+	if test_have_prereq MINGW
+	then
+		# Windows does not like asterisks in pathname
+		does_not_exist=master
+	else
+		does_not_exist="refs*master"
+	fi &&
+	cat >exp <<-EOF &&
+	fatal: '\''$does_not_exist'\'' does not appear to be a git repository
 	fatal: Could not read from remote repository.
 
 	Please make sure you have the correct access rights
@@ -98,7 +105,7 @@ test_expect_success 'confuses pattern as remote when no remote specified' '
 	# fetch <branch>.
 	# We could just as easily have used "master"; the "*" emphasizes its
 	# role as a pattern.
-	test_must_fail git ls-remote refs*master >actual 2>&1 &&
+	test_must_fail git ls-remote "$does_not_exist" >actual 2>&1 &&
 	test_i18ncmp exp actual
 '
 
-- 
2.11.0.157.gd943d85

