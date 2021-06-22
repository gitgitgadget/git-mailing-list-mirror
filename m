Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DEDC2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 03:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B72661164
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 03:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhFVDXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 23:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhFVDXS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 23:23:18 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE2AC061766
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 20:21:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f15so6390079wro.8
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 20:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tXZYwTixJrCp/6OccSE0YFubLSO48oX8RwgRwJSEzY8=;
        b=Pj99EbgRACFT8sYSGeyDSaSpUngPfvG8cPca6bEqGevlIItYmd1eYajmJSOwV9WaHa
         17tTC4liJckxYmSVkzuW/dPsyJtDodjX5+XBt6vj5JbnMcVVflGwqMr68xGb7/MMssjM
         N+yIJny2WnnqMCzsyCMcoEwTu+r3hiTlFxWC3NN6p1RXMzoPnili0/+Tt6NyJNH2PwOB
         JwSlRrBK/X1wtD7fBiAcZSIEGpdFpc6m0muqjzSKBxnbtoMDIV/PET7dqTsNCLf6OVYV
         R8yuOvt9pcWAYlRMbc7du43hgYDjiepMlegP4v+DW6IBShXaRUs3xt7t5Wyhj3xAPDi/
         +/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tXZYwTixJrCp/6OccSE0YFubLSO48oX8RwgRwJSEzY8=;
        b=EOxl7JGv41Ws1HBa0g+SFLMR+JKUkugYXWZ3WH4oyTmW7OU+wZn6I+j9b0pdMtDgdi
         x50dPJcQmURX8ExjMFzsgR47y+E1kEiW7K5g+4uI/wsCIh64zonqTrjJdECXIRj7+FXF
         IsbiOgKmSed1gUx62Qhu0gVkrtdKVHDEz7MNyyEN3zvIy+HznTuX7hFfR/Gs7tMad+lK
         hCZOh3CcuWkl5PhgiaxWjnMITlRa+DDlFLQqTSnCbPjpYY2W6Uc4Z/EedHBZbQyLK2Wa
         QsaaIL1u3YXe7pC/fuPbWGgE3X3QJW59kFRyrweh/fH0M+8U78ew0k1e9yg86QsLjh+Z
         Hukg==
X-Gm-Message-State: AOAM533Drb1kEIM96CPH46z9IcXgik10ImCaL1tyuOO53kXFYeb9wJRn
        U1jTZ4clSJ46pjzuUr2B4ZkK8cs/Fic=
X-Google-Smtp-Source: ABdhPJylsi53i39/+dFYYDSpTo/MVoQmohZ0eKsapLF8s6CDD4K5c1lWAICfP/BCoZKJKLbUXRpMAw==
X-Received: by 2002:adf:ef4d:: with SMTP id c13mr1884718wrp.220.1624332060756;
        Mon, 21 Jun 2021 20:21:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n18sm857971wmq.41.2021.06.21.20.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 20:21:00 -0700 (PDT)
Message-Id: <b0d9e139935f362817dd145df137e9ef33335e19.1624332055.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
References: <pull.980.v3.git.1624086181.gitgitgadget@gmail.com>
        <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Jun 2021 03:20:48 +0000
Subject: [PATCH v4 08/14] [GSOC] ref-filter: add cat_file_mode in struct
 ref_format
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
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Add `cat_file_mode` member in struct `ref_format`, when
`cat-file --batch` use ref-filter logic later, it can help
us reject atoms in verify_ref_format() which cat-file cannot
use, e.g. `%(refname)`, `%(push)`, `%(upstream)`...

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 11 +++++++++--
 ref-filter.h |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 22315d4809dc..f21f41df0d88 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1021,8 +1021,15 @@ int verify_ref_format(struct ref_format *format)
 		if (at < 0)
 			die("%s", err.buf);
 
-		if (used_atom[at].atom_type == ATOM_REST)
-			die("this command reject atom %%(%.*s)", (int)(ep - sp - 2), sp + 2);
+		if ((!format->cat_file_mode && used_atom[at].atom_type == ATOM_REST) ||
+		    (format->cat_file_mode && (used_atom[at].atom_type == ATOM_FLAG ||
+					       used_atom[at].atom_type == ATOM_HEAD ||
+					       used_atom[at].atom_type == ATOM_PUSH ||
+					       used_atom[at].atom_type == ATOM_REFNAME ||
+					       used_atom[at].atom_type == ATOM_SYMREF ||
+					       used_atom[at].atom_type == ATOM_UPSTREAM ||
+					       used_atom[at].atom_type == ATOM_WORKTREEPATH)))
+			die(_("this command reject atom %%(%.*s)"), (int)(ep - sp - 2), sp + 2);
 
 		if ((format->quote_style == QUOTE_PYTHON ||
 		     format->quote_style == QUOTE_SHELL ||
diff --git a/ref-filter.h b/ref-filter.h
index 44e6dc05ac2f..053980a6a426 100644
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

