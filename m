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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB92C49361
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A5A9611AC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbhFRS1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236267AbhFRS1m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:27:42 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E52C061768
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:29 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id d19so11490687oic.7
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PsbGwDkf3idFtPb96JeWlgNo04btzfemkzbKkJAjcoc=;
        b=r73eR/mZuijBKBk5InxGy/GowKHwZqVFFnSu9hAMC5L+6x7HZ8xdw9Kzp8GGj5qOU9
         GDUGcq4DHvzghlVx8RuOZzrMzC6mj9RsIq3UTCd3xIS1V56YaYcBOa0ED60iaDWV27UF
         jtiELqAZf2MeOsCd9uyTypEi3BXi0OygZ5eoh7vr9La5dkvp2YvGtY80s85/Drv2I0xY
         4SUogZQpPvZzHg7cW+2cT0DBJzDteWQbdt/rbj9CQ1pDiq5JIHp57Lvzv32Sz75a00P0
         I3H+eG6THFX1Ni+vWR6EliCcaC/dY5GH3bQsK7KPC9YaXVKzLDis70myldD51Fg4MSnS
         V2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PsbGwDkf3idFtPb96JeWlgNo04btzfemkzbKkJAjcoc=;
        b=Q1M158R3gHBhsAqZtJNCteevuCy5/h68BF8dNhz1lE5tUtHcp15XzFz/gEuyaieEtS
         75m1XBDnuIYbfqgVtWf43swEaGqwUABq8f1ra3IkWXAjzsr9FbmEm4vYNUf6VmU6iFf9
         7pA6Fw4UmcJypw+TrbtN6c2OKzaJOyhxAjLnDadREh8kX5fIoEn7tlte/w7jbkK+E2Wf
         htBEQo0hPSsnM4v8k0ufpeOUWgYa2o5knYuCo2lpXL+MxYcpZwJsok7Irr5ioQkNqNpQ
         peyO/bUGn0Eb2i0m1hReWg6R78kjiaG9Nfq7AMYtaDYnhiFNKEsaFScpjAZRKZzjXbzG
         UEug==
X-Gm-Message-State: AOAM531qRZQuKVcqM6uNRgo4TRQbhQXTbzI6DN0EIZbC6WO1FVV1jJZz
        TMG85vT4OsV9H3KZI+gq66sxRucgiEznvw==
X-Google-Smtp-Source: ABdhPJw0EIJIe5YV4msmKJj9UpYWHihqKNC4S7LnywE0cQeKKTgTHSgHF8OGby8kRQIPD/wsKYrPvg==
X-Received: by 2002:aca:2804:: with SMTP id 4mr8035054oix.141.1624040728472;
        Fri, 18 Jun 2021 11:25:28 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id x29sm2104809ott.68.2021.06.18.11.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:25:28 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 05/45] completion: bash: add correct suffix in variables
Date:   Fri, 18 Jun 2021 13:24:38 -0500
Message-Id: <20210618182518.697912-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
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
index 279d2d8b1e..943995689f 100644
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

