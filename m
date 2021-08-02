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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B519CC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C9A661104
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhHBRaI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 13:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbhHBRaD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 13:30:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B65C061760
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 10:29:53 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c16so22330217wrp.13
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 10:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G75EU94H3VvMzOV2C8WaNF1CXSRXS5uIWoEJ+blAAaY=;
        b=dvveKO77VCaCc4kIlvTZ0ow6EFmc1ucMG7h7Mj+NJ7hdNciov15EdbTyboJo3uAk2O
         Y6Wmiouy+COLy1SzjpE5nHNT/1S5AL7kXgd2iXOdFmF4FzaU/oIPWbnb1YpKHLK4MlFh
         e68YSOkEX8vKNMHA+rM+UgrNVU77uFp3s/nv0i885DVOt9rNcmKFDnOjEdFsqtazedPF
         MDflMEe7MxYxssA5A79Wlm109TRp5UDx/vzoSsE/23s5dJohS0Ib9sn8TTzMtVKxuWZ8
         zHJC2yPOHtprwUtSRtzyZnpJse7ABsgJF/p20ZBOFOa8rmuJ8JQ+LP65DBmCbYZDj9ZT
         63Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G75EU94H3VvMzOV2C8WaNF1CXSRXS5uIWoEJ+blAAaY=;
        b=gv7gJ9hDkzJRNKTtuux4PEUEp2emWrR0Jf6qgKxLLTYEPvzMe/rExoXsjdE3oQvB2n
         HfNA2A+yezQ05DSOZXtLFq6Sv37Fw/lAe/FzyzvWA0iAqMkP3h+DswV9Zw5TLQ2oHcUS
         36TWqqUVobJduZHZrB7ghTw0GNKWpTu0egU3ta+jcCdRxTglxnWEIukceTou4CfvuDt9
         rsJfinZFmpM74Ak/HIYMgeYs7qp1wsYffqieNR1XM11sjr3b0KFEWjpZ15IeBI/Pbqpc
         o1FEs6l57IFHOyW47Iko7x7Vx/nK/Yg7shQKzfCMWbPDwJAt0QVuiPBH+E8yd6enEyMF
         2TzA==
X-Gm-Message-State: AOAM533bXRY30iYFAnu3ou3EqztJCgvuLoLlEGXytUqC9AwwRK7iyUT0
        Z7PI95WrSxnTOQrE0SzHZ8cRHkie2iY=
X-Google-Smtp-Source: ABdhPJz7xsXqhXJJEZp1RT5Lw9J0oGGPOuO5KBqk/cXlhu42wZt/bMqoVzBEMMbY1URfgp6iFDYA7Q==
X-Received: by 2002:a05:6000:12c3:: with SMTP id l3mr18499734wrx.314.1627925392563;
        Mon, 02 Aug 2021 10:29:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm12297928wrv.37.2021.08.02.10.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 10:29:52 -0700 (PDT)
Message-Id: <fea3d6d72b63c06138d8eeb61e45edb30abbd79d.1627925390.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1006.git.1627925390.gitgitgadget@gmail.com>
References: <pull.1006.git.1627925390.gitgitgadget@gmail.com>
From:   "Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 17:29:49 +0000
Subject: [PATCH 1/2] clone: update submodule.recurse in config when using
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

