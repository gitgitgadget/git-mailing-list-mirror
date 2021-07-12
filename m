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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807C5C07E9C
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B453610E6
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhGLLuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 07:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhGLLt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 07:49:57 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC6EC0613E5
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d12so24560878wre.13
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QNasbiGAZli473fXu4QgD2u/UTIEGvkgntmX6viQd9U=;
        b=IQK3Cl1VH98NOml/JwjA+MDB3BNs+jVcndE1MQ8qmsWmgxwnrIeOt9B9Ll2gVbqd6x
         PfjJGSfEhqlTlG30suSmx7cJKv1VXhZ32SMTtIJN6RB9/AO618IhbXrwPog+psRIaRxd
         jWrNsEUGM1wtI/mL9wAAcPkUHkq81vbZAc8Oh/DwQYl9vnYC3soPd31tW1qpek+1Ubx4
         feY8VBIUyq85VsCKP3v6laoHQ7SIMhxUTQDtibsKsli3dc8CQR9KIssusYBclZlR6wAw
         p8fplC6/WlYXRZKs46sjM1tgUhs0zOYW5RHnGLU05gggl6ifXTliuSz4N5tKqiNJUMXj
         bBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QNasbiGAZli473fXu4QgD2u/UTIEGvkgntmX6viQd9U=;
        b=iJZb/QC7u3SUp60AzOi7ohXFxwUptUjQzJSc1b5B8sL5lqGegisu5hIYeLurA7kLF0
         E9gXcuk6vgMati5tuI8L8dVqoBt2hrV6MoSrARtVkJUo/yE3EVb+afYi4Y+OBg0aXeDr
         a+tYs7hktwOEasqdVs1Bo6Q3rLJV9dxh9Y0MRiPudIG0+uXNjjhjbowVk9FxEL7IParU
         uNjoQydIC1EUW83I01WiC6x62YHyFNNe0HSvYJWNa+7JykcFd/6btXgz9tqZJ9rtP1qs
         ZsI67yn4EpoCR/iv6Ws/T4GZlYvQ1HNFftY50OPlEA7R//xaJDGa6u2z2140HBgIgWWZ
         XmOA==
X-Gm-Message-State: AOAM532y8ozimiDD5NX9tLM/dDFD6lNzzan7buhu+eemhFEwlyv5ifLd
        kDW5JvX0qAyJUc9xXkKIDwIuZFKEZ0E=
X-Google-Smtp-Source: ABdhPJyC4IF18luIlMp9CoAerTMdHfNTnqmGFBSiq1QqASHjXro02fnzC7x1okFbDS66B4HHwanXGg==
X-Received: by 2002:a05:6000:180b:: with SMTP id m11mr40650262wrh.6.1626090427736;
        Mon, 12 Jul 2021 04:47:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m5sm19073321wmq.2.2021.07.12.04.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 04:47:07 -0700 (PDT)
Message-Id: <fca49379025048f3ed458b673483dcdf7f2dd10f.1626090419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.git.1626090419.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 11:46:52 +0000
Subject: [PATCH 12/19] [GSOC] cat-file: add has_object_file() check
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

