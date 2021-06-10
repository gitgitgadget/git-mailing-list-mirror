Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F231C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 17:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A0DA613E9
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 17:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhFJRjC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 13:39:02 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:63135 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFJRjB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 13:39:01 -0400
Received: by mail-pj1-f73.google.com with SMTP id on11-20020a17090b1d0bb029016bba777f5fso4224740pjb.7
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 10:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+DntY3mGg8ZHetqUmUaAm8s2ntVKR1QED6xkd2ix26o=;
        b=jpx4VHqH5jUpa+P+DTamrpwmLZgynA1dCepUWDpAPDI3jK2Z+V55WmZH16plkqq+ko
         1LCr8Sw3MvHUYtHHUEDxSnTRIk+A8+PnKh2nPMgGUeKFnK4UYo4eBtuVqs4Cx+slhliE
         jsS6pQYfEXJ4UxbiroJNauSyZFUq4hX4WWi+0xGj2qVFc9TsT3RuKILF8zYVreNnmzSw
         VP+Hojf2LrNnPjjKndTr1txtsJAo9jS79zOtPXKpdsCQZY65xthVWh0IZH59xB2rRi6S
         UYqOkdBNatn9Ri8ELMw7gt1cpd7AsD/wvwrz/tjgahHfO3jL6t/QNLeXk820z+uESX6e
         NCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+DntY3mGg8ZHetqUmUaAm8s2ntVKR1QED6xkd2ix26o=;
        b=WBYficJ4MrA1eCoQUvr3fQj7X8VelrZyucDgGRCAnQVk3CQ+8CIopBKkDh1baBNus/
         Wn8QlvslagEfVwQkDkyqcFZlsRTVbVWjQnlhS1oQwj/SAPLWBJZDwNmjrTSG/8fbQIG1
         hIKzB6qIYgsENVPjMccgE8o/cYT1q3/xKD9zDK4H7GmiX/Y9OmcyBon6R/XJ6DfSS2ba
         om8QDa7CJz8gSX+TCJ96Ad/RrMpyvJTehgeXtbBrPJchOaJc684Gn9gz0FrWJdTB6aI8
         KSEx4qyirso3mlVkfTcHOgyvdoY5Rzw0YpxrhWj3mlbdzXPJl3v1osGs+Pfnno0hF0WC
         oPwQ==
X-Gm-Message-State: AOAM530JDnUnLJtTm9CI6OadnaRJIquBV21oUzcF8XDzCV5nBt32xMt1
        YoW48ekAKOJpn6AtXuqFZmbhSGVcV47nV20B/lJf8Xi+TC2gv3GECmDOO3zf+EBipgoTiG9HwcS
        41IAmp2C6x3xNOsLWbn+jDMBuGqVqshhE9aZqf8zvqpB5hgytEnhN3eehbzSSByWfuBMbaOkAok
        nS
X-Google-Smtp-Source: ABdhPJyLKpk0jr7o2ZnMlr/cY8NcmNs1RIsWYRyKjNKKfgiix+winAJYQT4ceWpxbpzTsuqvAM694k/80UwuGPV48TNB
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:1789:b029:2f4:cb41:ec1d
 with SMTP id s9-20020a056a001789b02902f4cb41ec1dmr4089804pfg.3.1623346551282;
 Thu, 10 Jun 2021 10:35:51 -0700 (PDT)
Date:   Thu, 10 Jun 2021 10:35:41 -0700
In-Reply-To: <cover.1623345496.git.jonathantanmy@google.com>
Message-Id: <e1a40108f42addf8a589c1d0ac4ed76fb525be9b.1623345496.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com> <cover.1623345496.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v3 3/5] submodule: refrain from filtering GIT_CONFIG_COUNT
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, me@ttaylorr.com,
        newren@gmail.com, emilyshaffer@google.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

14111fc492 ("git: submodule honor -c credential.* from command line",
2016-03-01) taught Git to pass through the GIT_CONFIG_PARAMETERS
environment variable when invoking a subprocess on behalf of a
submodule. But when d8d77153ea ("config: allow specifying config entries
via envvar pairs", 2021-01-15) introduced support for GIT_CONFIG_COUNT
(and its associated GIT_CONFIG_KEY_? and GIT_CONFIG_VALUE_?), the
subprocess mechanism wasn't updated to also pass through these
variables.

Since they are conceptually the same (d8d77153ea was written to address
a shortcoming of GIT_CONFIG_PARAMETERS), update the submodule subprocess
mechanism to also pass through GIT_CONFIG_COUNT.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 submodule.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 0b1d9c1dde..f09031e397 100644
--- a/submodule.c
+++ b/submodule.c
@@ -489,7 +489,8 @@ static void prepare_submodule_repo_env_no_git_dir(struct strvec *out)
 	const char * const *var;
 
 	for (var = local_repo_env; *var; var++) {
-		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
+		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT) &&
+		    strcmp(*var, CONFIG_COUNT_ENVIRONMENT))
 			strvec_push(out, *var);
 	}
 }
-- 
2.32.0.rc1.229.g3e70b5a671-goog

