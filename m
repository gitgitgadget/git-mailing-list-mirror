Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4545C388F7
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7621B208C3
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlpmiLPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgJ1XnB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731284AbgJ1Xm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 19:42:57 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6D4C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:42:57 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id f6so677533ybr.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bL9A0ctwM0NOOtDJnh0ADyDBe3oEvtROJugj/TC5yiA=;
        b=NlpmiLPWAkZOU1Ax4dSxCX0G5E6iE6A1aOByPxAJ0Y9y2mnhbbFZyx3mvllgcOyMz0
         RHN7OZ3Iqp7R4T97HsDHyZAsFPMXAB/pKvUTyHO9itu0HKX8zlz/5qJmrsdZVbtQhHFG
         mHN5ok47Ms64SQgI9NC64gWNZPw5FOVmYDqhR02so0gvMVdALZizBXIvselfq2TFV9OF
         7jCID0WjUtrf5+VcoTpzXKIAgiZe3oaPLBSsTvFqeevK9FDtXNETN4jU9bF5iahVhoS8
         WjCL13ubtMDEIMOz59OPf99h0myqBck83hXWN6wIUpnam+cHeAZ/vSptag0gS3MsOEdO
         2VgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bL9A0ctwM0NOOtDJnh0ADyDBe3oEvtROJugj/TC5yiA=;
        b=g0z9K1IEQqW5fAZkJYLXEr3bEFEnpSQZe87yhVqZHD6Y+dl2H4g6xWKB38bRaEJC4c
         opTN532+IROv+HHpLWteXocLHVoaHWlLwU/Ei+4rRl0C4nVWic4T4BtH9uPZydKBsgoS
         jLSYQW8+lEeJnsiDUKR6y2ZkzQm8iBL7KUgVDW8zolBDWwFPLUb/+krvrIDce1zOKd44
         gCu2Qpb0NQhh2kTm5DQnqsvahThot9+ouT/evD6OtX7zUTNpDLL2AgmEwxqPBKueD45d
         qnYpN97DAziKrtznCA0rNe3FBP1TPtEc8zxMwXD/nvUzbj7RPBGWih5SzCyuPGo/9C+g
         ojEQ==
X-Gm-Message-State: AOAM531LWhPFHkKtuAV0/1rqu6nhTbAQ4tOUCZ66stURP8UCVBgCkenS
        3G4hhHta2yh6rN9+/fHrMuc2RfO5DTnWmbaJ
X-Google-Smtp-Source: ABdhPJw7ZIcVl3bkC7HZ3h73jAXqKLhbomA+zwJwOZh+l1V5E1QkoR5ztLZnBMixVfzsN+5cs1iWYg==
X-Received: by 2002:a9d:6d19:: with SMTP id o25mr3618857otp.85.1603850846154;
        Tue, 27 Oct 2020 19:07:26 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id y8sm2341762oon.16.2020.10.27.19.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:25 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 07/29] completion: prompt: fix color for Zsh
Date:   Tue, 27 Oct 2020 20:06:50 -0600
Message-Id: <20201028020712.442623-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't need PROMPT_COMMAND in Zsh; we are already using %F{color} %f,
which in turn use %{ and %}, which are the equivalent of Bash's
\[ and \].

We can use as many colors as we want and output directly into PS1
(or RPS1) without the risk of buffer wrapping issues.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-prompt.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 16260bab73..54e123d632 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -97,7 +97,8 @@
 # If you would like a colored hint about the current dirty state, set
 # GIT_PS1_SHOWCOLORHINTS to a nonempty value. The colors are based on
 # the colored output of "git status -sb" and are available only when
-# using __git_ps1 for PROMPT_COMMAND or precmd.
+# using __git_ps1 for PROMPT_COMMAND or precmd in Bash,
+# but always available in Zsh.
 #
 # If you would like __git_ps1 to do nothing in the case when the current
 # directory is set up to be ignored by git, then set
@@ -553,9 +554,11 @@ __git_ps1 ()
 
 	local z="${GIT_PS1_STATESEPARATOR-" "}"
 
-	# NO color option unless in PROMPT_COMMAND mode
-	if [ $pcmode = yes ] && [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
-		__git_ps1_colorize_gitstring
+	# NO color option unless in PROMPT_COMMAND mode or it's Zsh
+	if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
+		if [ $pcmode = yes ] || [ -n "${ZSH_VERSION-}" ]; then
+			__git_ps1_colorize_gitstring
+		fi
 	fi
 
 	b=${b##refs/heads/}
-- 
2.29.1

