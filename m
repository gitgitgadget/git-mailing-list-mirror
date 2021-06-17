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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24522C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 14:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A60C61405
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 14:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhFQOhq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 10:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbhFQOho (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 10:37:44 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7621C06175F
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 07:35:36 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso6305081oto.12
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 07:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xt88Sy5Ry8SFkmg/EQSfciNYdk0rwBHLDh7nPEHF6nU=;
        b=VFnixkG9bU6ODhehLzlR0YvYLicLMJjXOcqavfLvgi/0eXsp+cmk5BL7mC9IRaFViG
         XpagrWlo9q6+wqyEzOyPt1fUijpgaxLoIYvtSPY0aCaAlF6pEdK2FH16AiPg/2faTc/i
         HUtYWtx8GuwVHzPt6wLSsXkyVw4fHEdaw1e2HmUcnmkDbEKc9AXI5f/m2NquYTUp+kue
         q4KDQZEbufxBIC2l26Vs5cz0+ShSdvrkGBfMcokaCk+fZ+rqjEMS3mef1gK+OT3xhT+1
         9vNj4ekuOkiqrndiV2ECHa/XDM3yZ/K5i5Rm0xkan56entWCw27Lhqy18bP1oXrVcj3d
         eoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xt88Sy5Ry8SFkmg/EQSfciNYdk0rwBHLDh7nPEHF6nU=;
        b=Z18MeXp4MtEVeb41vacc3PqmVC7WrOmlXINjfRAecKt5HHdrJMYZJzYH5q7sGuUWju
         kaIOjQ8Y/AJREWnSJZEoXVD7/f9Lzo51yFK6/6n2PRAI3YU7qS4JZZTR+GaotpLdRUvf
         kl3phON9eVnmvf57YIYjGIT68qBpcAl7He1zixtDAz7D/bXDTOcH2/Uv1ZyZT7IAGosn
         eyKn9nyeiy0U0NvRtxuJYDpqVP9FLAf4ppXJPpy+WndRnZRLW1CDzy/6c6ornYl7AHHS
         IDQygZvCk5Zk5gRWOuDBgINjUih7UtK81vh9k4SlQqpA0RmazHCoOwF0YTiGZg5jAvqY
         Zz6A==
X-Gm-Message-State: AOAM533pps5jl5CO3+j3Fq3AQHHsk97Ik86oUHqEyCez7Lh2DuexYCgT
        8R1h2a7b0mawRbt+7FC4bZIXTZ2MytAoug==
X-Google-Smtp-Source: ABdhPJy2VGcgZWysjVElzhLP6eP1XQMEJZIJaHNbCPE0t74bJxKb4aa9uJ03RaUPTKc//zZasnmncA==
X-Received: by 2002:a9d:6291:: with SMTP id x17mr4818295otk.326.1623940536044;
        Thu, 17 Jun 2021 07:35:36 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id q26sm434562ota.20.2021.06.17.07.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 07:35:35 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: [PATCH v4 4/4] completion: bash: add correct suffix in variables
Date:   Thu, 17 Jun 2021 09:35:27 -0500
Message-Id: <20210617143527.77329-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617143527.77329-1-felipe.contreras@gmail.com>
References: <20210617143527.77329-1-felipe.contreras@gmail.com>
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
Tested-by: David Aguilar <davvid@gmail.com>
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
2.32.0

