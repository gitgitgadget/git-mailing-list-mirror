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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99E9C49EB7
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 12:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABEE361C58
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 12:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhF0Mi2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 08:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhF0MiW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 08:38:22 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911E6C061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 05:35:58 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso8974217wmj.4
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 05:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FVbonolI94qKuU0xrFtaeBSooPbN2a6xB5ve3hV0wB4=;
        b=AOsbFiq6g0NvrTeu4rHVFJ4SP9IN0EUXUCjzvJudaojqQaovi2G7wVhzhP9q1GvLei
         DJ69gVpb6jf50e52QDjxu44fYmNHzwKBG4fFup2IQr+CuyO6WECOegHb9PYxS0JsPgx0
         4soowxlzgm5UycH+WTFMTJfgTHTng69tBl5mGj08gw0fQtK7zXMC/ZbEBZc16AXGkT6Q
         08+58QqsZwNayyLIBOIhMg1rjyYm4+qx6cEBhmo5a/woRpiRxQKhQ7a7UuMsh9rGvVKH
         DNILREx6PZoxMZD9WFTWk/XfsnsJx5Xvjh44Q0UYkOmD8q9JbYPaumGujZi3REtLw1sB
         iUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FVbonolI94qKuU0xrFtaeBSooPbN2a6xB5ve3hV0wB4=;
        b=eQVQYw3HOugBWjK/Q3to26cGvOfwK590k1ISUFZswkjJNRiI0SXamQQiNfLuwp4Fbb
         ZaddwejjedPKYf4iHUyvfIQSs9fZuwZ8nfqvZnz91nkEkyvuAodlXIILAmK4IXErmfU5
         Nk2F+aDzqlBtEJyYzPT37mkPPOOZHpDCjlieICqoSbQrVVlwj0ad/R7U8wdIRggVpZHq
         Q/PlJT0mhIL4ZVdJgIeKbYq1WCg+vLigh/MEukf7oCe8bJqkjO5B3+pJ5YlQsoMd37is
         Ns2iw/tfgT5VBtd+cc0JqcgtYYriQb9qAgszlX8+6CuAQMQwBXQZI0/gcPCG0CpB1ZBy
         bw+g==
X-Gm-Message-State: AOAM530gV8ygKChLsPwgz5S3V+vg+zEksmmimXaMRkSf+EIp6UZALKiD
        r9uOq2KOSItGs9xONzFkqCnbOObr88Q=
X-Google-Smtp-Source: ABdhPJzRJqMn8UOzPTlUhTJ/CwKONsWyfQDcNyKrTZxxToWeVhvdVvOd5x3Huaa4dKpwpMBxsVx/oA==
X-Received: by 2002:a1c:7c0b:: with SMTP id x11mr20709907wmc.183.1624797357263;
        Sun, 27 Jun 2021 05:35:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm11488139wrv.39.2021.06.27.05.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 05:35:56 -0700 (PDT)
Message-Id: <b6e7757de4cf93cf2cfc267b33b72874ce4cada4.1624797351.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v6.git.1624797350.gitgitgadget@gmail.com>
References: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
        <pull.980.v6.git.1624797350.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Jun 2021 12:35:43 +0000
Subject: [PATCH v6 08/15] [GSOC] ref-filter: add cat_file_mode in struct
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
index 731e596eaa6..45122959eef 100644
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

