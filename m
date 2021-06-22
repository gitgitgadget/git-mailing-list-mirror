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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91DBC48BDF
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 10:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8925C60FF1
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 10:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhFVKtP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 06:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhFVKtI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 06:49:08 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEC9C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 03:46:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a13so1281305wrf.10
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 03:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vIeIF0qHxLNDgPxorIEshxmN1AEe+RnTQl5xNdj1ASs=;
        b=fF4NkPvuhHUdRcj6GjeRa4F3Z1n9DpDXA0jRIuh7LNG4nElkiowp58RyBrMGgi5sGf
         KVaCaM+HDsH5VL9KS1kWXAY/UuUvxqJ6tcVCkxekiYLtSa1u6jDUQd1xw6o4/6blcp6a
         KSXHQ4wDHrVeZcuiCQ6nOte1qaOP57Adg2Tl2jLFvfvgW3a4Dh2JqKlQpjXTSJ2l0ACW
         DnQzIyoXiWtLcqcRJBmDDyjZg4fax3S5PcJoRhThxIm0WBb02yVYbKHp9+0HO2MudhtU
         +ge40RO5lxGv+xV6i2/zs0Aa48mrm5jsI9KXDLI4MiuwzlljOvjj/7uG3dRGe9ve8sQ2
         7MCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vIeIF0qHxLNDgPxorIEshxmN1AEe+RnTQl5xNdj1ASs=;
        b=W9O2S0oegky9RO2uhf2iWdb3veLOfdGtvS+2jAKwipqfmClTTvMrmoBGYZk//C1VnA
         0Fq+JSZoxgXBvWHsL7bQSMuAJEyjzHT5fQScs+X9/5VvCjTmLabZ0xyFKFQTDMj3Xyxw
         k2U+BSgg5dOrO82sqT/rCcSco6JYzHTMotLmsMkrsgf3HuvQCJyQyDSuFkWUrfzwvg2S
         pvIzgDwcvR80VJs5+jYvI9faRXOUQi7TeMQnJ+yCoZ0GCMPUsXCDohdB/pKUQS55lRCs
         TR+UWF5tnD84NnLP/5tvgXNctznQHP3hDpxJqX/zGQ9Mc7yYzYqMSJbUY0sF7nNgBG7G
         JA0w==
X-Gm-Message-State: AOAM532ctrfBlbxSMXX3vEiMlE8twU8OoVCzWQFiXv5+H0WkAOHrKvmT
        +4kUr6zN0UdYAbQA+HviMlJL0+iCEjQ=
X-Google-Smtp-Source: ABdhPJzRCRw2VlZtbMaiUxScG38wBvuL3kSqGohre/vHykwPsQuI1c7QsKE+QhTMc/WoHy5VfJUueQ==
X-Received: by 2002:adf:d0c4:: with SMTP id z4mr3910539wrh.309.1624358811760;
        Tue, 22 Jun 2021 03:46:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c12sm2304796wmr.27.2021.06.22.03.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 03:46:51 -0700 (PDT)
Message-Id: <01aa77d9acbbdbaf90937e14f276e981e77568c3.1624358809.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.984.git.1624358809.gitgitgadget@gmail.com>
References: <pull.984.git.1624358809.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Jun 2021 10:46:48 +0000
Subject: [PATCH 3/3] config: normalize the path of the system gitconfig
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Git for Windows is compiled with a runtime prefix, and that runtime
prefix is typically `C:/Program Files/Git/mingw64`. As we want the
system gitconfig to live in the sibling directory `etc`, we define the
relative path as `../etc/gitconfig`.

However, as reported by Philip Oakley, the output of `git config
--show-origin --system -l` looks rather ugly, as it shows the path as
`file:C:/Program Files/Git/mingw64/../etc/gitconfig`, i.e. with the
`mingw64/../` part.

By normalizing the path, we get a prettier path.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index f9c400ad3062..3cd10aeb9028 100644
--- a/config.c
+++ b/config.c
@@ -1833,9 +1833,10 @@ static int git_config_from_blob_ref(config_fn_t fn,
 char *git_system_config(void)
 {
 	char *system_config = xstrdup_or_null(getenv("GIT_CONFIG_SYSTEM"));
-	if (system_config)
-		return system_config;
-	return system_path(ETC_GITCONFIG);
+	if (!system_config)
+		system_config = system_path(ETC_GITCONFIG);
+	normalize_path_copy(system_config, system_config);
+	return system_config;
 }
 
 void git_global_config(char **user_out, char **xdg_out)
-- 
gitgitgadget
