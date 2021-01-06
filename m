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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F0FC433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 11:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 686FF23118
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 11:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbhAFLwB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 06:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbhAFLwA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 06:52:00 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EF6C061357
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 03:51:19 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a12so2154592wrv.8
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 03:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7wUYCjY6HLCDFFkTJJc82bjyYxhoKIu+P1XQrUMaiAo=;
        b=pld7VfGnhIHHRSYyPvZQGPs923uxfLyJqowb5Fgg99qa0Pw+mxnTLqDF5EqNawTGWP
         B0SdXxqjOgJGpwLOwv0W8YKIyvSk0seGIpHy+pm6tcqHzR0P5RD4mnqhq1A9ihNNoH+h
         JV7Wnee1hxgo5nrLYg+Lvgv7P9nEEK04ZMk4/5/blHy9TZ97tYKCbfwGfwmTCmnh/Y3Z
         eaZCQF8TUJOHGGBooyPu4QSs4YBH7Iqk5G1NKBeYub+QGoPStTf0h5liEnifBMMqOfkf
         clz6we5RGst7if0LeVTDW3UBd8UOYkgovb6QLE0DlA3FVzxs8RGYKiNELnL+e9MsG1AP
         epBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7wUYCjY6HLCDFFkTJJc82bjyYxhoKIu+P1XQrUMaiAo=;
        b=czl9xsw7JKsfNOWea1CtNtghaaEGAls6rbTQbfWaxP8yzYbB5djFpxuMJki72FSnVQ
         G6udGfErCdoR+TQUHSLFgxv2M2LlPek/qHqTL+A28gsMvQYx5uhLLJdNKqHEyrfl0Q3c
         D2Kaa+hcPXg/tE8nyj04zoXY/13VsA+0umXvhRC0xUvM9OqSVURHMcjjQIxTKyzOk8+t
         caHaPc2Ld/W7r0KGi8rRYz+cCl61z5/xs1WIcELbp2UCeOxtdP9A1zy/dDcRYqCDp5xs
         E9c5WaQl+wANzpyJ8SaOH0MWhtXerOyCxdMu/bRlrqx6z7eCQV82IS35cgDWaautdGCe
         C3nQ==
X-Gm-Message-State: AOAM533URcs4hl1f4xNz0+3E7aj8+Wzpy1Gn6GQM5PBre/Pnmd741LJk
        NRf/i+Z8gnOx7STjPkqLSr6sQ0Icjpk=
X-Google-Smtp-Source: ABdhPJy7UMyH5Tp+4HIsiq4tmnm/ZWzpSiFO9WeYGfdB7vpCf15xeHiTrdGr9maP/sQCnUfVViIJmg==
X-Received: by 2002:a5d:61ca:: with SMTP id q10mr4015280wrv.124.1609933878394;
        Wed, 06 Jan 2021 03:51:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s13sm2947382wra.53.2021.01.06.03.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 03:51:17 -0800 (PST)
Message-Id: <c5f01b0eab1dd13d46ac344e362cd13e7bc365fc.1609933875.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.822.v2.git.1609933875.gitgitgadget@gmail.com>
References: <pull.822.git.1609232114080.gitgitgadget@gmail.com>
        <pull.822.v2.git.1609933875.gitgitgadget@gmail.com>
From:   "Junio C Hamano via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Jan 2021 11:51:15 +0000
Subject: [PATCH v2 2/2] parse-options: format argh like error messages
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

"Keep it homogeneous across the repository" is in general a
guideline that can be used to converge to a good practice, but
we can be a bit more prescriptive in this case.  Just like the
messages we give die(_("...")) are formatted without the final
full stop and without the initial capitalization, most of the
argument help text are already formatted that way, and we want
to encourage that as the house style.

Noticed-by: ZheNing Hu <adlternative@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 parse-options.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index 7030d8f3da6..ff6506a5047 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -82,9 +82,9 @@ typedef enum parse_opt_result parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
  *   stores pointers to the values to be filled.
  *
  * `argh`::
- *   token to explain the kind of argument this option wants. Keep it
- *   homogeneous across the repository. Should be wrapped by N_() for
- *   translation.
+ *   token to explain the kind of argument this option wants. Does not
+ *   begin in capital letter, and does not end with a full stop.
+ *   Should be wrapped by N_() for translation.
  *
  * `help`::
  *   the short help associated to what the option does.
-- 
gitgitgadget
