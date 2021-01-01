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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D582AC43332
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD25F207A3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbhAACRM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbhAACRM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:12 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E4BC06179B
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:31 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id j12so19271628ota.7
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qcg1CE5Jx10ZFsWOy1mHlElbaVXbcyA2T02KZ4aVUac=;
        b=Ne7buTtLngxKSvLhhfiMo+Ot0B8OofkQyOrnnTINAM8g+LJuWRQGhFuJjFynYjf+DN
         OQu8XqyCg7jXfL7y3LKUOgmr9SOAgMr32xfahdm8PkxOHnTGpAlZydWRu9P7rnXAk9mk
         fAD7H3Wka5mjxStbIbTkOb30asF55cqTmAVO51dQSQvOdmoFhrI6sdKGFPNWCTgmRQSK
         SzTMdvIOpLWazamCePGgQiWaulqIWRtvuUkeruYZAlRFLcgLzHHhEX3r5Ooe7+uplR2w
         IjXRhx6v7QBZOHlclv1IpbuNeY6OozbEqTrGHI3KtE6Z0ZpNM56dPI6nSz2RUAEbl5l+
         hANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qcg1CE5Jx10ZFsWOy1mHlElbaVXbcyA2T02KZ4aVUac=;
        b=YZQRRiYL3TfWAexphNojUSCPibqQgkb2a5skUnur+eNVTI3JObi//iE1TYThJgP+NU
         q0V4Ft5PLTXXLUV5ptKG17CI6n0svIhFJhflVbDMCPAI2qOZdCcmexbGXSD3rxvYyAB9
         qp5BTmk+edTEyJQG4I5ezD41epviu4qG5RTVsPwMQX6JNOXKiJxREoTqgQozfAoIdWxC
         3Ue0kUMSMmgzaX5MIh1NhuhUtOWx/rwMCuMDcMMMqzFGaquAbDDhsi+Zsn4qd12c9CcN
         52/8tzUd2/Qcxt6ZU8ZWV/TQ+J9Le8/xrykrOrucnlDouOa2CrfU5aSdVoNqSn2XUcpZ
         hQ1g==
X-Gm-Message-State: AOAM532PDMvgQE7j4s6bh563yjHFLvkF+znGy6I4AGU8V1YzotLO6jmc
        l0USluqdyLqPvBh/tY+Ha6t78ifpcmWOUQ==
X-Google-Smtp-Source: ABdhPJy2jkRRVTCcYKuftsBXmgz/tW6EzPNs0mucCOX7COy+vOrKtiqAAad+ENcF1cEcNt8Q/pdecA==
X-Received: by 2002:a9d:749a:: with SMTP id t26mr43953009otk.277.1609467391121;
        Thu, 31 Dec 2020 18:16:31 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id p25sm7994312oip.14.2020.12.31.18.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:16:30 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 04/47] completion: bash: add correct suffix in variables
Date:   Thu, 31 Dec 2020 20:15:39 -0600
Message-Id: <20210101021622.798041-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
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

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 64cf35ba04..926e9ceb56 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2636,7 +2636,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	guitool.*.*)
@@ -2670,7 +2670,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__git_compute_all_commands
-		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	remote.*.*)
@@ -2686,7 +2686,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "$sfx"
+		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "${sfx- }"
 		return
 		;;
 	url.*.*)
-- 
2.30.0

