Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8900C433E1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 14:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E3B61990
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 14:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhCWOxw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 10:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbhCWOxH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 10:53:07 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F97C061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 07:53:05 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j7so21090212wrd.1
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 07:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=WRjJQCiWyDYLtSjmI6SBeivNOng0hmAhvJehsEpDjw0=;
        b=uX9bZZrcilEfA0qrpftcS9o6iX4HcjxCoJ2PdZXj7ElSeDA2/huPZWi3hNn6wJvShO
         FaaHpKAMhClmiwtp55WeGwuvo90kk5aY6GGyXvI08yjoMS2HVChoXrC1MZnTlPaySyHD
         k04mbgUpOPxVCRm9W529gIScK8d8g2ZFh8MfDNx2SjWiSXZDPLzMql8mAmXVzgcBWCnM
         GQPznYa6VEtpSI73DQH1C+1m54asBoX+IIa7Uv6IIndmlnuuLMPyTyQBezupYSAHwRdT
         9yGVQOa1pYvuOooZJ9YwmtUPJpXPdmqkfcVG/pZ3WRxygEO/mIQ/Em9/NemKtjK4jYUu
         HP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WRjJQCiWyDYLtSjmI6SBeivNOng0hmAhvJehsEpDjw0=;
        b=O0/FSrtww3jUX1xRDkyPYRNQ7D/G1QrNfmZLAdUSf3UUYpPm3NHq1oq5yB+yQq/64y
         o/Zl1bfkFILtuZkHoJgUa7xtBqA/oWoBQgMB8KjhLfNQc4CU/QnikdPr3Xl4iYexgbRk
         BoPm3UXLhmn7gm1tn7SL/x8iWzmka6+CaVfBmK6HFRfmj4RNAPkwtYgje9ld+hm1EigN
         nj+O3EdEz/dwBLKaO6ffBQMj1Z3SKUzjr6D8CdRcIljW6Y8A3wwkCeuuAIUm/roWOGh5
         wP4yZ4L+h6RU2G3F/HbYDuPrVapue0rg478f22LifG9q48RHISb9N+GOF/3bElc7Q835
         GRtA==
X-Gm-Message-State: AOAM533+VjGOkz4nrFQhcVdGpJDec+MwG/foiRWDymU/rl+yG6lYDCxP
        9+4Q6T4rO9+Uv0Wm2jZRALIhdk+QvJI=
X-Google-Smtp-Source: ABdhPJz73+IseA2Ou/JdVBe4JkrDBuMwGsIt5+l7lM2U+AmmK8yyFPyfHiTvshVdFqctPVxtxiKtzw==
X-Received: by 2002:a5d:4fca:: with SMTP id h10mr4639391wrw.70.1616511183907;
        Tue, 23 Mar 2021 07:53:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8sm2671955wmm.46.2021.03.23.07.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 07:53:03 -0700 (PDT)
Message-Id: <pull.913.git.1616511182942.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Mar 2021 14:53:02 +0000
Subject: [PATCH] [GSOC]trailer: change $ARG to environment variable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

In the original implementation of `trailer.<token>.command`,
use `strbuf_replace` to replace `$ARG` in the <value> of the trailer,
but it have a problem:`strbuf_replace` replace the `$ARG` in command
only once, If the user's trailer command have used more then one `$ARG`,
error will occur.

So pass `$ARG` as an environment variable to the trailer command,
all `$ARG` in the command will be replaced, which will fix this problem.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] trailer: change $ARG to environment variable
    
    In https://lore.kernel.org/git/xmqqv99i4ck2.fsf@gitster.g/ Junio and
    Christian talked about the problem of using strbuf_replace() to replace
    $ARG.
    
    The current new solution is to pass $ARG as an environment variable into
    the command.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-913%2Fadlternative%2Ftrailer-pass-ARG-env-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-913/adlternative/trailer-pass-ARG-env-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/913

 Documentation/git-interpret-trailers.txt |  3 ++-
 t/t7513-interpret-trailers.sh            | 17 +++++++++++++++++
 trailer.c                                |  9 ++++++---
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 96ec6499f001..7cf7c032a0e9 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -242,7 +242,8 @@ line, where <value> is taken to be the standard output of the
 specified command with any leading and trailing whitespace trimmed
 off.
 +
-If the command contains the `$ARG` string, this string will be
+If the command contains the `$ARG` string (`$ARG` is an exported
+environment variable), this string will be
 replaced with the <value> part of an existing trailer with the same
 <token>, if any, before the command is launched.
 +
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 6602790b5f4c..d303cf0e4b36 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -1291,6 +1291,23 @@ test_expect_success 'with command using $ARG' '
 	test_cmp expected actual
 '
 
+test_expect_success 'with command using more than one $ARG' '
+	git config trailer.fix.ifExists "replace" &&
+	git config trailer.fix.command "test -n $ARG && git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG || true" &&
+	FIXED=$(git log -1 --oneline --format="%h (%s)" --abbrev-commit --abbrev=14 HEAD) &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-EOF &&
+		Fixes: $FIXED
+		Acked-by= Z
+		Reviewed-by:
+		Signed-off-by: Z
+		Signed-off-by: A U Thor <author@example.com>
+	EOF
+	git interpret-trailers --trailer "review:" --trailer "fix=HEAD" \
+		<complex_message >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'with failing command using $ARG' '
 	git config trailer.fix.ifExists "replace" &&
 	git config trailer.fix.command "false \$ARG" &&
diff --git a/trailer.c b/trailer.c
index be4e9726421c..42e3b818327a 100644
--- a/trailer.c
+++ b/trailer.c
@@ -44,7 +44,7 @@ static char *separators = ":";
 
 static int configured;
 
-#define TRAILER_ARG_STRING "$ARG"
+#define TRAILER_ARG_STRING "ARG"
 
 static const char *git_generated_prefixes[] = {
 	"Signed-off-by: ",
@@ -222,13 +222,16 @@ static char *apply_command(const char *command, const char *arg)
 	struct strbuf buf = STRBUF_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *result;
+	const char *const *var;
 
 	strbuf_addstr(&cmd, command);
+	for (var = local_repo_env; *var; var++)
+		strvec_push(&cp.env_array, *var);
 	if (arg)
-		strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
+		strvec_pushf(&cp.env_array, "%s=%s", TRAILER_ARG_STRING, arg);
 
 	strvec_push(&cp.args, cmd.buf);
-	cp.env = local_repo_env;
+
 	cp.no_stdin = 1;
 	cp.use_shell = 1;
 

base-commit: 142430338477d9d1bb25be66267225fb58498d92
-- 
gitgitgadget
