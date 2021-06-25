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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9E2C49EA7
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B3861969
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhFYQFJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 12:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhFYQE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 12:04:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DFBC061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:02:34 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a13so11113866wrf.10
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LRrzoPDrZTa1LnGfka0ELt/RiqwZjnAMrZ6gEUn+wnY=;
        b=Ozhwy8eFcHcqatNqaTCziH/YffcJRJMo2+YtqaX2ykUsv9viT7BiouVpOs1JrCE/UL
         tYlCjqMYwfTsyo8FsNlwSVgFeriM5A0i+Nbv0jKdJav4w49brOVfu7bcZAUSaPR3nTyf
         Gekzr5hFqkJdyGUwVpchimtzlxS08p33C/Rl1QYw4Y+OQgQIZNB52WhtgQmJbI+mWAPm
         URZznwQFAbcEWkGYr8YH25rc+xLRYc5udlZYyljZmwEcdV7sX7xSFexXnKI5jHq7lb2S
         7nbrAb3u2PauAMS0JcyvUUgCKmqEtrMcVrPAoZTfdOW6XSRmU8+5ytzBTVVet10YHPEs
         rTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LRrzoPDrZTa1LnGfka0ELt/RiqwZjnAMrZ6gEUn+wnY=;
        b=C+QXDcDSslivx/i4qONNKYUaxK8uSNDhguoUuk/f+S2aEOF04GYfd5ndOldpVD0cm8
         7VGXlNx3/XXdEWNcCO1uXgAkjsQ+2WmOMq5kayezYYJoBY2F8wSkXVuvljJ/6Ud4IoQf
         rK662keaTBMODIQQdzAD+U7U/8lWzb6IgF2qHCEfXDa4Skh44Ey3A4ywOYhs70xkRAOZ
         /pk6gpv+uwu5pY5uVcQklaVG6RgA+m1Ikq4YgFHIzqAnhP6zXr+pkgst7uHXbMO+YZ+U
         OUNaG9OhBh5Nc8WWcGNn5bz4yU8aB8lWvbrfYJFJ2pIpIbx9hge27+fV53FzTTA2l37k
         FgFg==
X-Gm-Message-State: AOAM531gV5HEccUFBUqu6nemCC2vn/1T9kinksVJWYF8C+3wKBHBNlww
        +bVsv1UfQr1tiZlawBTEODqT5k4HDo8=
X-Google-Smtp-Source: ABdhPJwNZiHDwf8fmN3cB61Jqajgoz4ccXmPu6CELtSVbXyE1XGaWruA5WtwIznVp5uDY/B9iXdD6Q==
X-Received: by 2002:a5d:6a91:: with SMTP id s17mr12137299wru.364.1624636952715;
        Fri, 25 Jun 2021 09:02:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4sm6330493wry.74.2021.06.25.09.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 09:02:32 -0700 (PDT)
Message-Id: <be55005be75333e22d00ae63c8bd1fc69718b369.1624636945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
References: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
        <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Jun 2021 16:02:18 +0000
Subject: [PATCH v5 08/15] [GSOC] ref-filter: add cat_file_mode in struct
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
index 22315d4809d..f21f41df0d8 100644
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

