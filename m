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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFF8C11F66
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 12:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF1EF613BF
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 12:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239314AbhGNMNM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 08:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239279AbhGNMNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 08:13:09 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48F4C061762
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 05:10:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u1so2968762wrs.1
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 05:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7FukxlQtaBqwECK3twX9twcq8HmYFyQzGzIdCAeXQlY=;
        b=Iw3PRd98SE4UU7KgMN2Z/OBZ4RTwB5DiZebJTvARe8Jq8Aa2r00XatUXGf95M/Lo0+
         pjPUOi9vQpH+vCuaFev39JPa/eqm9H5p8ve/w+OU3RrV0x0dbBofc6H19P8+beWYDKB5
         NxouOyJZA4/pkoUzQOF+1t5wchZu2KPy8e1hOHWFVE0/RRRp3M3Aa4i1e2jUfAi1pTmj
         kTRwkOrnRAr+k4lVrtS9mn5TujzRmx/WwLvjYN40XtxdHcqvmR7KTMCzXacSqhtE37cy
         /V6WvK4LCZsENpwpzM2eAaO51JZgbrCeJX64r6ZQ6X8e85047yyqCoxTpgTrbVgfQuAM
         G0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7FukxlQtaBqwECK3twX9twcq8HmYFyQzGzIdCAeXQlY=;
        b=tyBWaW1ENP58JoUWt8w/3dDEyKcUa8dno/K+b85oY8qApprsCjbSmm2vjBGBFcsHzp
         aSM+Vu9cP+wqhut8VloxKLfUjRHZHY2m56CFaCUYYweqFstY08I/uW6Ik1zl47y+HVeS
         aeYFS1r9CazFBcFF6OKNL04i7yCRJSX6pBI/FcfYTKCFKlg8kQjI1flwr2oxOG1M7+cx
         Apit4IpRlODvBIJHOvGWSGHj6cSFaajD8nY3AyvQZoAtPZlSqK6E2ukAFmnBXJb0F6IG
         GoOgL8hG9sd55vldvF67B1PwFlvh2vRKdkUHbH0oZUPWN2wdwfTqUh/o4vyYhIdhxsjg
         /tqA==
X-Gm-Message-State: AOAM530/j8qW/hUsvCfhEcJew1iRqdXqpGyyDcgBG//je3E2jQ+BNELL
        kBGZUASMTJ+dfjrEAGooKebqOhrEUnk=
X-Google-Smtp-Source: ABdhPJxRgCUtFw5dqMejmtMgOYo5NXDUQJhpYDV3L6E2VDmij50kUSlyqUmApmyD16u1ro3TkfqFUw==
X-Received: by 2002:adf:cf07:: with SMTP id o7mr12616417wrj.216.1626264616472;
        Wed, 14 Jul 2021 05:10:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x1sm1918786wmc.31.2021.07.14.05.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 05:10:16 -0700 (PDT)
Message-Id: <b84b2812470ea45a85d624ec339f35bb0107493d.1626264613.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
References: <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
        <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
From:   "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 12:10:07 +0000
Subject: [PATCH v3 3/9] ssh signing: retrieve a default key from ssh-agent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Fabian Stelzer <fs@gigacodes.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fabian Stelzer <fs@gigacodes.de>

calls ssh-add -L and uses the first key

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 gpg-interface.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/gpg-interface.c b/gpg-interface.c
index 3c9a48c8e7e..c956ed87475 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -467,6 +467,23 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+/* Returns the first public key from an ssh-agent to use for signing */
+static char *get_default_ssh_signing_key(void) {
+	struct child_process ssh_add = CHILD_PROCESS_INIT;
+	int ret = -1;
+	struct strbuf key_stdout = STRBUF_INIT;
+	struct strbuf **keys;
+
+	strvec_pushl(&ssh_add.args, "ssh-add", "-L", NULL);
+	ret = pipe_command(&ssh_add, NULL, 0, &key_stdout, 0, NULL, 0);
+	if (!ret) {
+		keys = strbuf_split_max(&key_stdout, '\n', 2);
+		if (keys[0])
+			return strbuf_detach(keys[0], NULL);
+	}
+
+	return "";
+}
 const char *get_signing_key(void)
 {
 	if (configured_signing_key)
-- 
gitgitgadget

