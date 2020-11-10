Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D816EC55ABD
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A0FB206F1
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYIodIQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbgKJVWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731912AbgKJVWL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:22:11 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3BDC0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:11 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id i18so154275ots.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=frUXtU19zgmRSJYaTvhzBs5XfOOvZgKr8wfiNO7CmE8=;
        b=VYIodIQQUYvLtioDsWPun2e5k43qsM5eBfbQdsfyLv9MH9fvt5lgLT6hM5RLp7dLg6
         Rg0RNQhi0D/UBadi6MW4j8B+IADeH3l+TB2XUh3cRSSIV4MLCoxRGWqMoqJs6ynX58GM
         eIqu6QBIUqqxBDJcvaPvbFGYdbZuNvpkdnXyAOai7/pcIcFJioU9IXyG22nDmf3UdZpM
         82pTreqd6k2ZzsbYsxsTWENXb/og/vf/bl4Q6f+FojfzXjDebYcOf0KMms0D9mzLVguT
         8HbrPj6jJfrnYPy+6dQ7u510PkQZYF8c4mYAF20A9iepf6jwFX0xezgeAJ6g1DXL8Pd5
         2szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=frUXtU19zgmRSJYaTvhzBs5XfOOvZgKr8wfiNO7CmE8=;
        b=hT2qGved88F8kX2rOtXQCvRZNPnFLxnal+GodRD9NhjI1FSqzdov4Mxj5gmOxhFhyh
         gNWKbS9te+y25loTxdgJJDckVTkKDicaGdGH476r4odmR9ZNvEfY1MC0EFociEZTJqI0
         sJaqLtXtae2T9QCWrC1naGw8xq+dTLb4NGTuFRw2sNpazbXJTXivDJ+ibkCgKpiAwwYF
         xEsWvpxrTnjlWCZ0dG8EB8L40DO1WnUPGEO8O/PIMe9XE0T0+ZpHLVIWKnl0cnuBZoEx
         2Fev/ZFHvJzZLmQIb/5QjCqz9sSnlXOW0QzB3t6N613A2hWdssBU3W4CyxCeQNHCKphj
         aAaA==
X-Gm-Message-State: AOAM533vDD2b/mZChLQ4AmkPfE7c8Nf5D9SdTNamvJsH0tVR5jILj+MX
        5koJoJUsJXXQVz6eb0aIqXoQco0hIvoxfw==
X-Google-Smtp-Source: ABdhPJzioz1DDkJp+hrBbb22Ir26T5plze0cdQT4Bns940g77ilNyArhhj/etQ+y126OUZ69DHDOnQ==
X-Received: by 2002:a9d:eeb:: with SMTP id 98mr462858otj.179.1605043330689;
        Tue, 10 Nov 2020 13:22:10 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id e127sm3376400oia.12.2020.11.10.13.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:22:10 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 16/26] completion: bash: simplify config_variable_name
Date:   Tue, 10 Nov 2020 15:21:26 -0600
Message-Id: <20201110212136.870769-17-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110212136.870769-1-felipe.contreras@gmail.com>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we can actually pass a suffix to __gitcomp function, and it
does the right thing, all the functions can receive the same suffix.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 594e41276e..56a66a375a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2547,7 +2547,7 @@ __git_complete_config_variable_value ()
 #                 subsections) instead of the default space.
 __git_complete_config_variable_name ()
 {
-	local cur_="$cur" sfx
+	local cur_="$cur" sfx=" "
 
 	while test $# != 0; do
 		case "$1" in
@@ -2569,7 +2569,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	guitool.*.*)
@@ -2603,7 +2603,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__git_compute_all_commands
-		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	remote.*.*)
@@ -2619,7 +2619,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl "pushDefault" "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl "pushDefault" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	url.*.*)
-- 
2.29.2

