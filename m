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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B66C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8326961108
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFHGDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 02:03:21 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:46033 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhFHGDT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 02:03:19 -0400
Received: by mail-oi1-f181.google.com with SMTP id w127so20477579oig.12
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 23:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y31lWlpplvd4owJMF1sOGObRVW/efTHEkQOeVeSM9JA=;
        b=EjQYiMk1HxudPZFl6AAKrFZl5zp2LNXiUjlq2S3yhhIiwXSP76s4z2bmVm6I/3nWQX
         g9o79lYKd7C/KcZC4AC9rBMp2yC2knD+PIJJ4dBbM42Zx+7rdUYtRFE1pn7VVb3hOSJx
         tiIWhL4mKvOL4Sc3kcywIQ3GnKLIsQU8Yh/FcbL5OKpB0uTht9fitqxKrVN4YDvZKzBs
         CM0KPNyico8Uw+t3EflV+r+7ky/fzR+ghk9B1ami6/AZIpa+a0KB07zBs7szBnRzbSsy
         M8oTOzbSLprDuEgsexnLiK8nyHLnajtO0BbSb6lC/xM/v74Ijney7C7Rwyk0mxF9KcWR
         Bfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y31lWlpplvd4owJMF1sOGObRVW/efTHEkQOeVeSM9JA=;
        b=MzhptRvNzhRiMFMfqzj8exX6FefpA13VTamRJ2maUhfM28U5W3o45/SRiAFCxNjDzr
         i5Pm62qfDC7ahMSyT+8vY0z1WBdPLvU7n6Di7bx/MsPjE64HbqkNuTILHjPSGP1qcej1
         4W6xaB7ATY1Ff9Gfg7ZGl8nda/GsNq9Pj9/WGz57GVuOMh2Yjpc1VhyD6j1RSdFygqVm
         1PwwCQI4a/89CEXc0REwP3QH3PL9UGXEkyY8HM5dhNzSDzOcdB0NN6NBUga1B0LxsYBo
         xJmMw9dO8wIl5RVMXKFpb5aFSC/SL1wgG6XqLSE7Tx0UXm2HuHQsA4/mSXzU2el9NEsJ
         BDSQ==
X-Gm-Message-State: AOAM533z3h2Q52GK9RXWsO/PK4PIVmkYmEZiH6PIBlx3Um4NW4xZHjzx
        hsdWp0QLNOx/d50UQUw61IHgCWL3pVja2A==
X-Google-Smtp-Source: ABdhPJy2XgVF9CG5CWtd6fm79pZq0NwnqTNegSK8jfrv4bfzwdds9PNIDf1QfFrGtEk/hbHp6CG6OA==
X-Received: by 2002:a54:448a:: with SMTP id v10mr1824807oiv.133.1623132025866;
        Mon, 07 Jun 2021 23:00:25 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id t26sm2930902oth.14.2021.06.07.23.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 23:00:25 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: [PATCH v3 4/4] completion: bash: add correct suffix in variables
Date:   Tue,  8 Jun 2021 01:00:10 -0500
Message-Id: <20210608060010.1676208-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
In-Reply-To: <20210608060010.1676208-1-felipe.contreras@gmail.com>
References: <20210606184726.1018460-1-felipe.contreras@gmail.com>
 <20210608060010.1676208-1-felipe.contreras@gmail.com>
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
2.32.0.2.g41be0a4e50

