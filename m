Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08360C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F3360C3F
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhGLLuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 07:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhGLLt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 07:49:57 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2A2C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id f17so25204915wrt.6
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=O8zaUk8FAh+xl/dCNXsBFsviaNIALe9L5MtO/rYzfcU=;
        b=Cb0XieVXRRiiURAsNGETXnV/LtwuYz1jfdabtLBstGxMJPy0XDnl1ooA/rP5WrzAkq
         GObyfER63Sp1PlxRSeIM/7yowSPtGJF2XeQNIh/n4Nj2x/J4rEGYs1kvWXxDvCCI8nbh
         jP+e6YR3YfZUS7HgJ/CZ7Pycr491TKo37KgM0q271AbO0Ig3+SJinfs1t7ux96siTy2p
         3Ku04sW4NtWM/iNyVPX1U6Xj+8crjUsvVeVcPbJhgCwFvla9NIuzSVL0Qf+XBUlypAf3
         gG1AHVVsGgNWDxKjWcwU6/dnoREBg5KFckXGGtq/dSWrXafLFe/6QnsPucwtT4HIWHhR
         QCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=O8zaUk8FAh+xl/dCNXsBFsviaNIALe9L5MtO/rYzfcU=;
        b=tYXiyqLQSFJyjS6CRynMLF8euBNYqo6SvJbUD1yKlH1iec8gg2IG14hvI2caI9SZWC
         DJUvyzeguhvVN7SZ9lqFsQganxuMEUuJ+7EaIgXw93sryz4ni0asxPsf0Or/dlsYH62C
         7n+XlA8BdGpzF+llsBshrXWnlu7UTWpmTdewF4ccWYW+eVjX6tKmw+EDLTZWGqgbPUc9
         0q12vPFz9GxhoTP1tA/FUfOTbN6bR5eHFzy3BKEKh6wh4PYw+4reT07FXWNa8YA2piaf
         YuBO6sixkDf/vrtQhdfScn3bwmJXBBuI1IE7Yc3xnCl8t6tNPsy3EBhnkD7mBPf9hr8W
         i/UA==
X-Gm-Message-State: AOAM530I9jgL172TZ0BfeF/3ymkLKgLqCejr3XaDLSaH+fzPA0KFZLGn
        TYZwbnt1zO1ki64KNcB6MnNO0TOc0AI=
X-Google-Smtp-Source: ABdhPJyrKCqNRF9T6Wpzwq3K5eujkMBJVGoDV/9c33KClBHLE96bg39gwFQJKsNILqvv+QBRY8nULw==
X-Received: by 2002:adf:d235:: with SMTP id k21mr25935491wrh.222.1626090426645;
        Mon, 12 Jul 2021 04:47:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 19sm2382632wmu.17.2021.07.12.04.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 04:47:06 -0700 (PDT)
Message-Id: <b61d538d53d7342f503077ecaaec7ea358110049.1626090419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.git.1626090419.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 11:46:50 +0000
Subject: [PATCH 10/19] [GSOC] ref-filter: introduce reject_atom()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
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

Add `cat_file_mode` member in struct `ref_format` and introduce
the function `reject_atom()`, when `cat-file --batch` use ref-filter
logic later, it can help us reject atoms in verify_ref_format()
which cat-file cannot use, e.g. `%(refname)`, `%(push)`,
`%(upstream)`... or the atom `%(rest)` which for-each-ref family
cannot use.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 25 ++++++++++++++++++++++---
 ref-filter.h |  1 +
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 80b09fce1d5..27199ba40f5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1000,6 +1000,26 @@ static const char *find_next(const char *cp)
 	return NULL;
 }
 
+static int reject_atom(int cat_file_mode, enum atom_type atom_type)
+{
+	if (!cat_file_mode)
+		return atom_type == ATOM_REST;
+
+	/* cat_file_mode */
+	switch (atom_type) {
+	case ATOM_FLAG:
+	case ATOM_HEAD:
+	case ATOM_PUSH:
+	case ATOM_REFNAME:
+	case ATOM_SYMREF:
+	case ATOM_UPSTREAM:
+	case ATOM_WORKTREEPATH:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
 /*
  * Make sure the format string is well formed, and parse out
  * the used atoms.
@@ -1020,9 +1040,8 @@ int verify_ref_format(struct ref_format *format)
 		at = parse_ref_filter_atom(format, sp + 2, ep, &err);
 		if (at < 0)
 			die("%s", err.buf);
-
-		if (used_atom[at].atom_type == ATOM_REST)
-			die("this command reject atom %%(%.*s)", (int)(ep - sp - 2), sp + 2);
+		if (reject_atom(format->cat_file_mode, used_atom[at].atom_type))
+			die(_("this command reject atom %%(%.*s)"), (int)(ep - sp - 2), sp + 2);
 
 		if ((format->quote_style == QUOTE_PYTHON ||
 		     format->quote_style == QUOTE_SHELL ||
diff --git a/ref-filter.h b/ref-filter.h
index 44e6dc05ac2..053980a6a42 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -78,6 +78,7 @@ struct ref_format {
 	 */
 	const char *format;
 	const char *rest;
+	int cat_file_mode;
 	int quote_style;
 	int use_rest;
 	int use_color;
-- 
gitgitgadget

