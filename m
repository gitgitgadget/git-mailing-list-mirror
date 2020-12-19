Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350CEC3526C
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 14:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F37CC23B27
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 14:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgLSOHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 09:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgLSOHI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 09:07:08 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A016C061285
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 06:06:27 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id w124so6224828oia.6
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 06:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sIDgN7oHqGz/AzzIT3+iobobJUXMQWjNumpX/cXRyqs=;
        b=rs+XMtJh5e9XzTi12AfUkdqHw/vW8I14nMsaW6mJg5Xa7WSEPpl9WBq1eYejFFCfZ6
         vrqRv1G0glovDM8bDiAIOv6//R4MVA4Mfl/Tq44F5oOTzkWbTDu3hjlW41nFyFb8O36I
         BbE1QEPFvC09eKk5e/PPmwoNw1nNltuTNwVzZExCxQIZdajlmWhywv6VEYbtP13B5a5F
         voim6ihZAejdzvM4jprdQS1y7qfLoo3QctSCx7RkTkPi0NAQTqk9N2n3wyMFwMG3aQfl
         F8YNICAjAD/okv2eCJ8ItftLmA3/Nlkhz5kRrAqO5ErELE8Poid6WO/NmkEo1fIOOoQy
         InsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sIDgN7oHqGz/AzzIT3+iobobJUXMQWjNumpX/cXRyqs=;
        b=AKcCBBQBcMysnpwCR+kHKMQ2DxQAPugt4QTRN0WODB//JWFGgPHJFo6YOMWxK55z7G
         iijYJPoNj43JxpGq0d7+Sf6CfYQYeexo/mOLV/8bdlif8EGQSJmq3vOnYkVN9NcwkDTn
         VhdhJDpayglgoJF0GJvjOVnvSMYh8PI4BqqzWC3dzzaTuGQ+l0fyIDs48VqynXldrEZy
         E1pw+2QFeVQ85gCR1lSRzMIOD0/JvtYh5lEsER5TExEH9xoSx97o0nwpEa0T4zn7cDhH
         b96U/huYJ3D5W7rYJ+1HEEY4o7OV1NHVgpm516EDJestwyEX9Hn63bw4t6brm5Z92XGJ
         V4hg==
X-Gm-Message-State: AOAM533xOStUMz6Widl3IxbLv2Z34jRq0kxgjH34ezt37WsXCldCXqWb
        C66YYBnWa63weCeJ/Hqha7zODYGyYOKNCg==
X-Google-Smtp-Source: ABdhPJycR9rwZP7brBpjUrID9srx/yb7I5fuzkVsIZ3IjLoKS3ZyEq2CrWHFmAQtfDW33+BveJTt3w==
X-Received: by 2002:aca:b3c3:: with SMTP id c186mr5696644oif.39.1608386787172;
        Sat, 19 Dec 2020 06:06:27 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id u3sm2572683otk.31.2020.12.19.06.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 06:06:26 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 2/4] completion: bash: add correct suffix in variables
Date:   Sat, 19 Dec 2020 08:06:19 -0600
Message-Id: <20201219140621.1961760-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
In-Reply-To: <20201219140621.1961760-1-felipe.contreras@gmail.com>
References: <20201219140621.1961760-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

__gitcomp automatically adds a suffix, but __gitcomp_nl and others
don't, we need to specify a space by default.

Can be tested with:

  git config branch.autoSetupMe<tab>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +++---
 t/t9902-completion.sh                  | 7 +++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b866b68b3c..bbdb46d87e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2618,7 +2618,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	guitool.*.*)
@@ -2652,7 +2652,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__git_compute_all_commands
-		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	remote.*.*)
@@ -2668,7 +2668,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	url.*.*)
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2be9190425..4a3d3d1597 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2293,6 +2293,13 @@ test_expect_success 'git config - value' '
 	EOF
 '
 
+test_expect_success 'git config - direct completions' '
+	test_completion "git config branch.autoSetup" <<-\EOF
+	branch.autoSetupMerge Z
+	branch.autoSetupRebase Z
+	EOF
+'
+
 test_expect_success 'git -c - section' '
 	test_completion "git -c br" <<-\EOF
 	branch.Z
-- 
2.30.0.rc0

