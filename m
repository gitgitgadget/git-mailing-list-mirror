Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E3EC47E48
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 528DC613E9
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239285AbhGOPnd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 11:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239180AbhGOPn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 11:43:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C91C061762
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:35 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r11so8352522wro.9
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QNasbiGAZli473fXu4QgD2u/UTIEGvkgntmX6viQd9U=;
        b=puplOe3BsQJrK0XKegkTE4nSWRPQ9CdqUIhJQsmctXQWJrCY8P5yVvDrMK2kYvTN1M
         tX4nxy+hcsGdnQIF1G++BJLDFZfH/TmZTcC9YG212UgXTb6/ZOs0o54I0IONydtM/Ha2
         xUCAdKNb6r240bVBoTqF0q2Sz3U+eRsl0LXEi3Oan3cjskBIOE+mRiALUjJVuaXivnDd
         E97ngR859W7n7r5n4JKKqMVYvqn69RQkyB9Ykm1CxHTI11XA/uGF4YKZmnr6YV93WvJr
         PHC3Zy/GoLj9tiremKJOWKnTW8OqVDZc27TnihwX9OS9On093EJCEzpknAkVePHqfXMf
         Jj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QNasbiGAZli473fXu4QgD2u/UTIEGvkgntmX6viQd9U=;
        b=cyC3M+x+L/Q+O32NDkjPaj+xxtMK9BqxNoVlC7HVXoijfiVFtzt8l61d4cH5qMp88R
         WO1Wa6Nd3bwZBie0+qDzgfvDQOmpQuAJGmHGLO9cO3HLHJG+U7hiReshtR7f2pI3wAOl
         Vk212hTj99o20Xq4qbClAne/KL9bmGFR+TmFZRLgcTtieswfI5DrE9bfQXnbbFXGLjaS
         4i749sztSgf1GSL9hlhkcAa+ne+jIV6p04qA/bOSisMlzkaH/i63enQvEUGPcldFVosN
         vOefZ+xShoIVzxHZeseWbHVhn4vtW79aJ1Yrpf6v5g2a2KP7c+ZkHBJNKJG+DdH+FZB/
         wPwQ==
X-Gm-Message-State: AOAM531BxRhrvee70I3drRWdNpymC4Kr/hmQzEdLx6eDXJCb+7+a7fr2
        xCtxwuPHR0ieloJpU2fchs/mt0/ZNMU=
X-Google-Smtp-Source: ABdhPJxSBfFcaSyo9Tdu6Lwz2nIRFyBFcdXJo4OGjHmp68GSkYvQNTfLTzfoJvyZKNCp6Psj9nkx6g==
X-Received: by 2002:adf:e749:: with SMTP id c9mr6492567wrn.407.1626363634494;
        Thu, 15 Jul 2021 08:40:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j12sm7168189wrq.83.2021.07.15.08.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 08:40:34 -0700 (PDT)
Message-Id: <3af0def894c44cecd9f621daf8708a232bc0a143.1626363626.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
        <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 15:40:18 +0000
Subject: [PATCH v2 10/17] [GSOC] cat-file: add has_object_file() check
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Use `has_object_file()` in `batch_one_object()` to check
whether the input object exists. This can help us reject
the missing oid when we let `cat-file --batch` use ref-filter
logic later.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/cat-file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 243fe6844bc..59a86412fd0 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -428,6 +428,13 @@ static void batch_one_object(const char *obj_name,
 		return;
 	}
 
+	if (!has_object_file(&data->oid)) {
+		printf("%s missing\n",
+		       obj_name ? obj_name : oid_to_hex(&data->oid));
+		fflush(stdout);
+		return;
+	}
+
 	batch_object_write(obj_name, scratch, opt, data);
 }
 
-- 
gitgitgadget

