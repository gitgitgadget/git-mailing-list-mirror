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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE0EC11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A609961414
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhGAQK4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbhGAQKv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 12:10:51 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D366C061764
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 09:08:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f14so8561875wrs.6
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 09:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FVbonolI94qKuU0xrFtaeBSooPbN2a6xB5ve3hV0wB4=;
        b=ivRswpo9X7ngDw1cJlPPXKATfFEnXSI8l9Ww/Yv/PLzfm8c8ipPctgru6CgFKogXY6
         fgNHiw6X5UTHCLlSmhjaV8UmVLs0gh5JKzWDEH8x978cSzcs2BICduWhYqTdF6qVyer4
         K+RP3SPtsqfS/AXQyf8s9KI2ejnRHdW0sbWMQ0h6B/Ok6eEzPzh3vnB1foZnHE9i6N0F
         ZW7VyZ6whwEswemD4Hs6q3KjtYBR6pj/zRpCi7uXGMfxC2tqop0QqFT3U2joQ0mg1c3r
         qDVYEGYeN1rCWI3wYqFTTA3dMWq+3vtZ4JSnZ15YVuRMAutH1GayV2PigZONicoSVnqm
         9rVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FVbonolI94qKuU0xrFtaeBSooPbN2a6xB5ve3hV0wB4=;
        b=rCe15KYh+zb+Eo5MqfP0R6+pp1rE/l3ujU4hYlPOvQ62/6GD0l6APK1iicKSH85xIQ
         gjHBd3EKvWq+qMvoBPL7epEddz7wjiLPXFKwy4UOP84zDry2pKGIbaHn4l7v4m1vXEka
         0+ffeSFa8iMYl3tK7RgdvO9rDHLNKmWdd1a5zjIt4BAb53OsSPxg2knQP4XhMfJYQGzR
         ye3zHud7ZNOKStIs9KZJvKu5xIdcAyEe61/8s99IAjv2Creq5/+p0SjFg4P31M1iHXHH
         lj5lfWocmao5NGih8VyxhJgw+2b3pxJ/vIpR+ydwMFUffyQoPL40RbBeBJhiY57Y/gc6
         EfmA==
X-Gm-Message-State: AOAM531dqfZ7/JJBTitGMSR/scbDMXA4FgoFoYYkveSn7ftpjRfNYyFp
        0opSAmoczk3UX2YF+A+lgWsiEuw9VN0=
X-Google-Smtp-Source: ABdhPJzkb6jMNYulPliXOcv+N1gAtonQduOZKqSSCuYwoozXYzAInweWgdGBDE1YvEULzbhnSmXzyA==
X-Received: by 2002:a5d:64ab:: with SMTP id m11mr516673wrp.336.1625155699735;
        Thu, 01 Jul 2021 09:08:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y8sm268904wrr.76.2021.07.01.09.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 09:08:19 -0700 (PDT)
Message-Id: <9568baf5dddcc0637c15f698aea24d230c4d01b2.1625155693.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.989.git.1625155693.gitgitgadget@gmail.com>
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 16:08:06 +0000
Subject: [PATCH 08/15] [GSOC] ref-filter: add cat_file_mode in struct
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

