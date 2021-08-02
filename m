Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB26C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 22:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22E2760560
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 22:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbhHBWiu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 18:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbhHBWis (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 18:38:48 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBF0C061764
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 15:38:37 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso445714wmg.4
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 15:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G75EU94H3VvMzOV2C8WaNF1CXSRXS5uIWoEJ+blAAaY=;
        b=Jv1slNRVnRjrlGFqpP4GYMZnA2VW/afoadHc0nIwTnlgq8N1oaPIcUZeV+OpLPr1Iy
         ctasrCB6aBGKc8iX3s80wf6uLsYhqhHnxCqVLHnWmbA4NXEC3qss6cqYujvlphdG6yuQ
         jsN3tonpiJ9tIE2X4GUgEoFAntQzuPo0TEZwnNLfq1tG9RQx8+G7ZzTjP6ojOY04jlPO
         0k/OepWsjR3TsSoTwP50cEHnX7YYpgDyJn7l1oFtkBbPhsokl77kTIX/P1eHroxzPfq0
         W0XqVfFx7ZJ3W2MH3gAQFFLKQymqNq0cKrE4M7gqhS7DVErVwFcxlL6JlplPAOAcfutO
         KU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G75EU94H3VvMzOV2C8WaNF1CXSRXS5uIWoEJ+blAAaY=;
        b=e59omV/dAY0yyHNpCPgzetNi03LTNyJuwoFFtjl+ZOyHomNiczjLQ1KsAg1rAYmD0f
         tlvqUARUi1NzBCDBPXLdI1x8N/WHy5hWzuKLhYhFyIWXwm/Dfhbqxjy6i/4i787f/1Af
         fETPUbI6A6Zz3tSjh53We+AqcQDrQ38SK3wKhA4sBxHbdeeeqYIMngOBlWarnxKBqr2r
         7TgWodkqAWC6lk2pQ38nxYRbp9oYmzjFFy12xOZmBUHaYqn2NkTCcALKWtX3zjsdPD51
         zU5whrh8IaqM1cJ7P3DTmX/OO3Mst2PccIwhY2uJNH9PNWblsvgn0DyijyjAXyNwDCAk
         IWag==
X-Gm-Message-State: AOAM533vzokwaXjy7jD5yyambU5nAQdb8bZRcoAfXfDWl9n1r+An9a10
        tCDAlxEIYNTosmjxyInnS+IpZsn2VRM=
X-Google-Smtp-Source: ABdhPJyS+RV9RV0hNJV2DTQBUOmjNE2JXQjg8W0HojHJzCo2OJ4FMwglKi2B7Bbo73Bg3yhX9HX/Aw==
X-Received: by 2002:a7b:cc16:: with SMTP id f22mr1042983wmh.99.1627943915930;
        Mon, 02 Aug 2021 15:38:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w10sm10765835wrr.23.2021.08.02.15.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 15:38:35 -0700 (PDT)
Message-Id: <fea3d6d72b63c06138d8eeb61e45edb30abbd79d.1627943914.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1006.v2.git.1627943914.gitgitgadget@gmail.com>
References: <pull.1006.git.1627925390.gitgitgadget@gmail.com>
        <pull.1006.v2.git.1627943914.gitgitgadget@gmail.com>
From:   "Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 22:38:32 +0000
Subject: [PATCH v2 1/3] clone: update submodule.recurse in config when using
 --recurse-submodule
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Mahi Kolla <mahikolla@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Mahi Kolla <mahikolla@google.com>

When running 'git clone --recurse-submodules', developers expect various other commands such as 'pull' and 'checkout' to also run recursively into submodules.The submitted code updates the 'submodule.recurse' config value to true when 'git clone' is run with the '--recurse-submodules' option.

Signed-off-by: Mahi Kolla <mahikolla@google.com>
---
 builtin/clone.c          | 1 +
 t/t5606-clone-options.sh | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 66fe66679c8..f41fd1afb66 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1130,6 +1130,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 					   strbuf_detach(&sb, NULL));
 		}
 
+                string_list_append(&option_config, "submodule.recurse=true");
 		if (option_required_reference.nr &&
 		    option_optional_reference.nr)
 			die(_("clone --recursive is not compatible with "
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 3a595c0f82c..3daef8c941f 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -16,6 +16,13 @@ test_expect_success 'setup' '
 
 '
 
+test_expect_success 'clone --recurse-submodules sets submodule.recurse=true' '
+
+        git clone --recurse-submodules parent clone-rec-submodule &&
+        test_config_global submodule.recurse true 
+
+'
+
 test_expect_success 'clone -o' '
 
 	git clone -o foo parent clone-o &&
-- 
gitgitgadget

