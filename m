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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F0DC432BE
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 22:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22CF4608FE
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 22:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhGXV03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jul 2021 17:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhGXV01 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jul 2021 17:26:27 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDA1C061575
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 15:06:58 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n12so2778388wrr.2
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 15:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4sbo9L3WyEzpnZVRXoNExIO8xlbAV5n42dZGsSUqv5Y=;
        b=YLbiozst+Dx+hxrDjL9MgQeZ5M7XdbzhO5+2LVrhLvg6HZWVGnwQSSZAZxC6McqKpa
         NEVOu/P0PA7d4thoNrGGg0+wIpifPwVqanstpa/HEZm8Kk+tTychmuvUy+jM2fNwiQGj
         S3lmd097QwJdHPkJNMWbSGznpjL+KAh88iNAruqEKykIHvxuVJ3w6QiWbTmwTaoHnEZ3
         raW5BMgg/z/beASZTdBuDbdvn8MCyISn/lp/y55uH2kCi/Vzp6yuXutZ+fEqAJoaesNg
         blmi1Gber0fGrmDGi4lFg6Wp57+m73r2j3+5jjR+m8wwCNGrNKwUGt+ZPTb655d6tRi7
         rq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4sbo9L3WyEzpnZVRXoNExIO8xlbAV5n42dZGsSUqv5Y=;
        b=JrRopYLrjYJOM1DtxsPmx4jKQZJ+jAFQqvWhK6BA3sfXW0PVpkxGZMrRhdpdl9nHVX
         r09XnVLCK+XTZ9VTzDsO05nX0LUUlK9B2n5A5Wfs3aCYXjFwA5GVPn1VqsRwPLNQEKt5
         Iv+8q4JivTBFsfwGrAa+pLtdgm3qlueqIB7o6GOoHWtWtm7quTAfN1YKnqy/uDiGsu9c
         MMr/DhdWtKe8d9XI/glYR2DBpSsT69nBc7QIjKpVBkvXuzuw1mIodlEtLy8qxvaRVay4
         NOCv/b+GxzFqBplottgpHTI5BGaDWGZZv3u/42IdZ7vnVMSJ3mKYcklQwEXbT4nIWwlf
         26zA==
X-Gm-Message-State: AOAM533yJ/IBORDKYfWYgb0wysLaf9JkuQw1mbHG2GH0TkAERusgJa8a
        SCV1u2Jx2/R3f/UvMSIZUrzUbORcyug=
X-Google-Smtp-Source: ABdhPJzf9RZbb+f7wpAXS9a21Yn68tEC3PPnV4awiS3pDErpYy9faMESncA/WFj+saVXayag/DdlKQ==
X-Received: by 2002:adf:f50e:: with SMTP id q14mr11509582wro.183.1627164417399;
        Sat, 24 Jul 2021 15:06:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s24sm39397781wra.33.2021.07.24.15.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 15:06:57 -0700 (PDT)
Message-Id: <7b79ba66dd0d43f2565d2cbba268f01d3d36d052.1627164413.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.66.v3.git.1627164413.gitgitgadget@gmail.com>
References: <pull.66.v2.git.1625155388.gitgitgadget@gmail.com>
        <pull.66.v3.git.1627164413.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 24 Jul 2021 22:06:51 +0000
Subject: [PATCH v3 3/5] expand_user_path(): clarify the role of the
 `real_home` parameter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `real_home` parameter only has an effect when expanding paths
starting with `~/`, not when expanding paths starting with `~<user>/`.
Let's make that clear.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/path.c b/path.c
index 3318ad24336..bf329e535cf 100644
--- a/path.c
+++ b/path.c
@@ -722,7 +722,7 @@ static struct passwd *getpw_str(const char *username, size_t len)
  * Return a string with ~ and ~user expanded via getpw*. Returns NULL on getpw
  * failure or if path is NULL.
  *
- * If real_home is true, strbuf_realpath($HOME) is used in the expansion.
+ * If real_home is true, strbuf_realpath($HOME) is used in the `~/` expansion.
  */
 char *expand_user_path(const char *path, int real_home)
 {
-- 
gitgitgadget

