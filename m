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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9412C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 09:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5E5961B5D
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 09:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbhHPJLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 05:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbhHPJLF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 05:11:05 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24107C0613C1
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 02:10:34 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id u13-20020a9d4d8d0000b02905177c9e0a4aso9549498otk.3
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 02:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nJdQToOZUIYvgkQyrKL3Sl89UqLtkGhjc2qvxbmVIOw=;
        b=Z3gBOeMY6uwYwHo2IHmSF/dYDSBL40aNwcgIXB63Qj5P2cZ0vtT5MH1u1X6/4d7Wrm
         yGb/WeDSGjPoHMm/9IeCAIwaI1btUDqH8GWXGCpVyyk7y6TiFtzzp3b+gL9nPggHQ/Yf
         4WA2Uz7MJ5YutjEaOP/ihqhT8ITjsxUamtsgxBqXiueeDkHsybQrKU8UVtgV+YYZLfIT
         jmeU+dr3ELMLs7VzHutMizzpzoopScmmfTzRc1dINJ/Vg4UGbBCuXyJWFtJgReM1u0UN
         3hCtMjpM3sGeJ+PCs/qT/Mb70+mQmWH2r5PVbk/tvwh6aUczNglVvuxsXn05Uf8zJFVQ
         L5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nJdQToOZUIYvgkQyrKL3Sl89UqLtkGhjc2qvxbmVIOw=;
        b=J+7HqJuIqNOSSGq0m7KiNQF8RmcX29wCHOHO8ey8hKqX3/S17QuNQAag+KRlnNYIke
         m1KNJbqgsS+EEwD7FG0yN1+9ECzAli0MesFcwZhc9AmcJsac3h2GYn/ar2HJrh/FC0BN
         dUqA3agLMjlDPMByieSYU9pgjoiS/o3AznOoih1B+l/Tqj0AJSD63I8u9e34SjlFfiDa
         5MLuKW0zYdovZ4vcPHERr1mAGMcmmmkUpPiczOl9Lq2kzGWyh902WguzxOYOlrpD7uaA
         Y7o/qAPc718KvN9oUok8YtI9GRHULfl1D7nvcn8Xcw3TWK+EI9i1MVxmC0+EoGWENrLT
         fwDA==
X-Gm-Message-State: AOAM531Hqwl0VjO7RR0MfTCyTisPfsAr/yuuk6XxDGklElOSvJ8t8Bj/
        hcg1kWTaIEaL33FRpH9mj6WyJeh4I8M=
X-Google-Smtp-Source: ABdhPJyBU4y4d6fnEZjQdpxCFAQnZyUbuXOLu9LR0cmpUzdkEs9wmtRihOrHPLaLiR9BLdkjX8yxbw==
X-Received: by 2002:a05:6830:1f55:: with SMTP id u21mr11801207oth.4.1629105033349;
        Mon, 16 Aug 2021 02:10:33 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id s24sm826714otp.37.2021.08.16.02.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 02:10:33 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 try4 4/4] completion: bash: add correct suffix in variables
Date:   Mon, 16 Aug 2021 04:10:25 -0500
Message-Id: <20210816091025.548095-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.48.g096519100f
In-Reply-To: <20210816091025.548095-1-felipe.contreras@gmail.com>
References: <20210816091025.548095-1-felipe.contreras@gmail.com>
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
index b7988f0485..8108eda1e8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2653,7 +2653,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	guitool.*.*)
@@ -2687,7 +2687,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__git_compute_all_commands
-		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	remote.*.*)
@@ -2703,7 +2703,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	url.*.*)
-- 
2.32.0.48.g096519100f

