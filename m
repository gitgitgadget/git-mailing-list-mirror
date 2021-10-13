Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B252C433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 05:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53D8360E8B
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 05:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbhJMFVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 01:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237699AbhJMFVD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 01:21:03 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B578AC061762
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 22:18:53 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 75so1201265pga.3
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 22:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Qh1a/wdPmwsVWdqNOWX0JbkE/w6lpaxZJwFH6/+zLs=;
        b=eboL/BusfPa3vuHrf17fTuASLrsAu32ZGu9tG2IdOvIW3n6drVbV62+Dn+bU2VKfM6
         SYCcoyovHMdRataZpqLA3Xn9uuOE5vKi6P1Kx9Kdfk3cc2Vjb0LnhR+e19YuQk3YNdW8
         YSRKZPv4a9ofDmyr6I/v7n5BIYXVt+BBNNqvYSqa0WXAQiSvLae79ERiWkYWdzki2FSP
         d3C1rtyEd77aNb2WF54b8rvn12u2ouD23chmQK30TK2aW7B6Exrh4s+0zHTHxCmUjhEb
         ph17uHW+hpAKSMlWKprovdqA5wpxRhgWdaUXHVtfP113n9cr4ufRf4Cjt5D0VQXZEGNg
         PRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Qh1a/wdPmwsVWdqNOWX0JbkE/w6lpaxZJwFH6/+zLs=;
        b=RcFaD1I/V8QE102QaRpfMdkkOxzyER/f4DxTBwvGA1OFgc8ZMMdbjP95g8LAbtW9wS
         lWqNDW2fLTpqSFy5aNtUlGydxtNVTecQ9oVGu1/6rV1Vwzwh2hzgh2i25s9pLCa2WSFL
         Ia+lvIeDvlK7RdGPiJVePMMyVCwB6DSO/MtEKsmAIafi18qgye4FVGvoQVoRydTwOPyE
         BmH3uTj5Bat4mfXTF97P3lisKph0Vdmb979TOLVyXXo72AA90jijj6KbFg8aXABk5zgO
         67CpWcRH2w8Wu1fwtpasT19TwYM40ihh1ZsJEy5zeOadAhPaB69T91IN5nvSkXhHTVLn
         RXXg==
X-Gm-Message-State: AOAM531sZl8nj4GecaL06EL0fxTzKAzDfkbw0Ub4G4fg8hsibNp0ZS9l
        MYpOiN9Y8yRcKVplmckQCBg=
X-Google-Smtp-Source: ABdhPJzV15R7jBswyk3Ke+hPognOCiVzt4NtCH2JnwW6OryQMPSCvtRoWrIrafxtTkFArs2q57EDzA==
X-Received: by 2002:a62:ce01:0:b0:44c:569c:5c3e with SMTP id y1-20020a62ce01000000b0044c569c5c3emr35926358pfg.77.1634102333320;
        Tue, 12 Oct 2021 22:18:53 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.111])
        by smtp.gmail.com with ESMTPSA id 12sm12481197pfz.133.2021.10.12.22.18.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Oct 2021 22:18:53 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: [PATCH v3 6/9] submodule--helper: run update using child process struct
Date:   Wed, 13 Oct 2021 10:48:02 +0530
Message-Id: <20211013051805.45662-7-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211013051805.45662-1-raykar.ath@gmail.com>
References: <20210916103241.62376-1-raykar.ath@gmail.com>
 <20211013051805.45662-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We switch to using the run-command API function that takes a
'struct child process', since we are using a lot of the options. This
will also make it simple to switch over to using 'capture_command()'
when we start handling the output of the command completely in C.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 74f084a9c9..640b3bd220 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2342,47 +2342,45 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
 
 static int run_update_command(struct update_data *ud, int subforce)
 {
-	struct strvec args = STRVEC_INIT;
-	struct strvec child_env = STRVEC_INIT;
+	struct child_process cp = CHILD_PROCESS_INIT;
 	char *oid = oid_to_hex(&ud->oid);
 	int must_die_on_failure = 0;
-	int git_cmd;
 
 	switch (ud->update_strategy.type) {
 	case SM_UPDATE_CHECKOUT:
-		git_cmd = 1;
-		strvec_pushl(&args, "checkout", "-q", NULL);
+		cp.git_cmd = 1;
+		strvec_pushl(&cp.args, "checkout", "-q", NULL);
 		if (subforce)
-			strvec_push(&args, "-f");
+			strvec_push(&cp.args, "-f");
 		break;
 	case SM_UPDATE_REBASE:
-		git_cmd = 1;
-		strvec_push(&args, "rebase");
+		cp.git_cmd = 1;
+		strvec_push(&cp.args, "rebase");
 		if (ud->quiet)
-			strvec_push(&args, "--quiet");
+			strvec_push(&cp.args, "--quiet");
 		must_die_on_failure = 1;
 		break;
 	case SM_UPDATE_MERGE:
-		git_cmd = 1;
-		strvec_push(&args, "merge");
+		cp.git_cmd = 1;
+		strvec_push(&cp.args, "merge");
 		if (ud->quiet)
-			strvec_push(&args, "--quiet");
+			strvec_push(&cp.args, "--quiet");
 		must_die_on_failure = 1;
 		break;
 	case SM_UPDATE_COMMAND:
-		git_cmd = 0;
-		strvec_push(&args, ud->update_strategy.command);
+		cp.use_shell = 1;
+		strvec_push(&cp.args, ud->update_strategy.command);
 		must_die_on_failure = 1;
 		break;
 	default:
 		BUG("unexpected update strategy type: %s",
 		    submodule_strategy_to_string(&ud->update_strategy));
 	}
-	strvec_push(&args, oid);
+	strvec_push(&cp.args, oid);
 
-	prepare_submodule_repo_env(&child_env);
-	if (run_command_v_opt_cd_env(args.v, git_cmd ? RUN_GIT_CMD : RUN_USING_SHELL,
-				     ud->sm_path, child_env.v)) {
+	cp.dir = xstrdup(ud->sm_path);
+	prepare_submodule_repo_env(&cp.env_array);
+	if (run_command(&cp)) {
 		switch (ud->update_strategy.type) {
 		case SM_UPDATE_CHECKOUT:
 			printf(_("Unable to checkout '%s' in submodule path '%s'"),
-- 
2.32.0

