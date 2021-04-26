Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61188C43462
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28CB46105A
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbhDZQTO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbhDZQTN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:19:13 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7FFC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:18:32 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id r3so3564341oic.1
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ZXxkWPxz+Oilj7lF7mHPf1MEs79yaEDB4yyEpC1xvA=;
        b=FFExhWrn8E0OJXdpH+uZd3ou2KUVE2KzOZZqEtcwljUonQXH/Ma1pSrvm6n9DIzrni
         XhegQYl7YQZf7pX4ZpOkXNOQeSb4MvM7rRWe8XL8oUilCuieYz5Nxz13dW1FpX/Dcbca
         5ftCO0CqWtoaZ9xkGF7CRvckzxSvrdZdyuJg/0mlBnrXMqU8cVEc9GSHxiug3uXmGIOb
         Ss11MoL2hwdhldwFthoz/K9i9Ivw4Z9k56U9jzkiRROPxhMrXj+OaYPwe9O/RSATtn0N
         mf88uR/9dZ41b22Li7MJNVoqe2iQmaYNlbAS8aPX26ZVmEYDb9UUbqC9kgdNSXfqleQy
         50lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ZXxkWPxz+Oilj7lF7mHPf1MEs79yaEDB4yyEpC1xvA=;
        b=BV9F/qlmSRjig0gGdHfW/LK5ArRBzWtiD4o2dfhsWZb80yEnujSd+9fPeBfyI8A9LI
         zRSkoYtKS5ysnPCagKd74AEORc5woen/uPmkkDlNeJRZYQzYeEF/YQ4o/ebqTKzRuRtn
         avNcbvr90igurgdaoodpUYGidWB+jB0phjUpYGHO+dR9AbSddQosbbpZCob4Q+bKrVgJ
         Sq3WhPyetGXSqcdhCdmJLKkNc0QWyMYUeMeNjpXUQWtqmd38r8YkQAVsV1DE5OkppvGB
         fC41wa8SE50ym7qOJprXGKwBxFN2U9krXXjKMRyILxucuZS0YIYVdl6Y0CvjI/dhEA1U
         QP7w==
X-Gm-Message-State: AOAM531bfOulFm9y4ga2VQICFbMPV167gr+YByGWK395ZLeZ6tOXdoi6
        oU7C6mEwgCsX5LxdFOgVm9skolVpizyv5g==
X-Google-Smtp-Source: ABdhPJyqT/M+4COWKabt6Advz3tbYLDSQzYNbQgPkTS0WJqLl1pVofR0VUEzZBJF60Zz0VyJFU4PeA==
X-Received: by 2002:aca:4056:: with SMTP id n83mr13949599oia.47.1619453911514;
        Mon, 26 Apr 2021 09:18:31 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id d62sm3115859oia.37.2021.04.26.09.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:18:31 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 26/43] completion: bash: simplify config_variable_name
Date:   Mon, 26 Apr 2021 11:14:41 -0500
Message-Id: <20210426161458.49860-27-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
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
index 096aa7b6e9..14882297c6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2580,7 +2580,7 @@ __git_complete_config_variable_value ()
 #                 subsections) instead of the default space.
 __git_complete_config_variable_name ()
 {
-	local cur_="$cur" sfx
+	local cur_="$cur" sfx=" "
 
 	while test $# != 0; do
 		case "$1" in
@@ -2602,7 +2602,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	guitool.*.*)
@@ -2636,7 +2636,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__git_compute_all_commands
-		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	remote.*.*)
@@ -2652,7 +2652,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl "pushDefault" "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl "pushDefault" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	url.*.*)
-- 
2.31.0

