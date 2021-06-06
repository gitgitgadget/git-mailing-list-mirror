Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B872C4743D
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 18:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FECE61408
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 18:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhFFSus (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 14:50:48 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:34357 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhFFSup (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 14:50:45 -0400
Received: by mail-oi1-f175.google.com with SMTP id u11so15803505oiv.1
        for <git@vger.kernel.org>; Sun, 06 Jun 2021 11:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dQIVsqKg+XLtHZjqC+8SFiZMkY1JC8Xa6SEjMM6JtYs=;
        b=fbQdFE8G+G1VqAzExo3KHPFThWMxm1eyV6BJBmfph/JS7Nuv/3G1yQqoaVU/w47Mvn
         +o10ERDLIPn3qUoZCttWLBwWoFlBo8Kl57ksv6Kpk5k5w0tgI+S0AX9hv/2hWnNe7XTn
         vsThqcpHCf6drN9D0XPWS9KAGTBZYPujhGsbNsFhu/MocQF/fAQyAFbpO+xldlt0kq5T
         Oy3RTymP9H6inKDqDzok8HJ9ImpTMoWn4r3ZdKyEjQzmM7nX60FXr0ZDKFanfrGhZ6u7
         NQusqESB0xI1HMb4tgGV2iGYn+NaUxBoFZbRNSK+5FVxiqLHbRXtE3JPOv4xsQrXX7Ye
         /oxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dQIVsqKg+XLtHZjqC+8SFiZMkY1JC8Xa6SEjMM6JtYs=;
        b=kIU7trknNE0Fv1OKcT15Qnmzysf8Dvtx2l3p036ALcst2XWS68ShwFHa2tQfv5O7P7
         eSs+HiNLBS8QnClsvsm2Lvzl2eFIuN5Y5triZtc4lvi2c6ccAeOBUJacVESj/DYJFj2q
         9YY3KwCH56K4rJnSZJmOy/fosv7QTAlAf/MJ2/gxwIu6sG4wyhbCoXsvETWnwX2bNuYV
         DND8zXSEcTIbei1vMYroed2AfGA/CgGhzvoAGGV/kTxF7mYQwG0//gGp6Ajm/R0M7pCc
         CoUT5/3rWoH9QFii1FkCZdSaU1IRsJCYQaNqAQfEdRItVnUiJE06Vct/96tgiiXdjYXE
         aZeA==
X-Gm-Message-State: AOAM5311/cXc86fiMBrtvVud7DC4m2T+tg5ISOtMdjlfaTaXErSe+1KP
        TaDfU+c/cfTZKtRBC//Rs1DMemaTniw24w==
X-Google-Smtp-Source: ABdhPJxQs1bcxYgCcQcFlzRdd09ETWOSGpAnBlHv8tZcoL4+H4PN23kwscLKZs8KPetEFPvSTOyq7w==
X-Received: by 2002:aca:be8a:: with SMTP id o132mr16704718oif.3.1623005265275;
        Sun, 06 Jun 2021 11:47:45 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id z15sm1893311otp.20.2021.06.06.11.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 11:47:44 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 try2 4/4] completion: bash: add correct suffix in variables
Date:   Sun,  6 Jun 2021 13:47:26 -0500
Message-Id: <20210606184726.1018460-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1.2.g0532ba4bf6
In-Reply-To: <20210606184726.1018460-1-felipe.contreras@gmail.com>
References: <20210606184726.1018460-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

__gitcomp automatically adds a suffix, but __gitcomp_nl and others
don't, we need to specify a space by default.

Can be tested with:

  git config branch.autoSetupMe<tab>

This fix only works for versions of bash greater than 4.0, before that
"local sfx" creates an empty string, therefore the unset expansion
doesn't work. The same happens in zsh.

Therefore we don't add the test for that for now.

The correct fix for all shells requires semantic changes in __gitcomp,
but that can be done later.

Cc: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1feb2ee108..c72b5465f9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2652,7 +2652,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	guitool.*.*)
@@ -2686,7 +2686,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__git_compute_all_commands
-		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	remote.*.*)
@@ -2702,7 +2702,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	url.*.*)
-- 
2.31.1.2.g0532ba4bf6

