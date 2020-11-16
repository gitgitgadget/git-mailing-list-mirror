Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611F8C63798
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27FAD20729
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKLTo7E9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbgKPQIn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 11:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731696AbgKPQIm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 11:08:42 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAF9C0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 08:08:42 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id w24so24098786wmi.0
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 08:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9tX+jisZnF8QKIRir0GzdfsvhwQEBVAh2/i2Bt96TTA=;
        b=TKLTo7E98m+TxRmHL+8anhQKoWj/NJnv2qadJWLPYj/7oRmxbYu6S8Zrd2RNlDRHnj
         t6DIXQdmNvZjGnvEgezvW/CAOnsRMNQf1JtqdipebCgjl4yeuJaSFaPCNB0RHoEwbuYG
         BEJQLnvqYvHNSGqz79pJbctZ+v41GWh9BVjJPPfDQH9SmyqRQnJPh5hDqc0NnPrTgtnR
         uTX+GGE1I9B+UdFxuz+0hIiphDk44xx+oeNPl8KJX3hjzGEZG5hcq4SvxCldI8LodQ9U
         MkXLCJ3FQ45kV7TVsJDlzzrJvvT+h4ylbt7SAxHK9XI8TDbz1ttYBFrdMQ66Tzp809bM
         aGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9tX+jisZnF8QKIRir0GzdfsvhwQEBVAh2/i2Bt96TTA=;
        b=VTglABCrsOUEMNWACET9US0vhgOwzYFmlN9Tz2yMOYc3UTMwH54QxxguyBplxu29Ys
         ws3i+MMBBz9mW98DbjnlpQ6dRREpexQiMtp8jVYHMaTzZLXTZl/wZxHsffBJ6k0kg+RJ
         RtEZJPhe4wC8I5R1u2ydlmTGQCgPDQI2ZD2kUNTCtJ7rSioZpm7STR1X1YQWxmB59Q+h
         wyAp+qw1nNFnPMr9DNwrX6ss7+sGI4JDtrIl0dgzrOsQLuGNot+602zl39OF+JL+tZ9j
         cl88GHdRBb137k6m9u2QnEA+CjB7H+Fn6QqSg2CgMKNIWEt3Wbp06NT9zKkJHp3Nxfgo
         z5IQ==
X-Gm-Message-State: AOAM531nkQzFqPgzybMY/Oaqpvz4/FmPImncIn7a+FXJ9k9i4zyNijNj
        JcEpZM0+A1mz3kyjejjehJbaa0O2AQc=
X-Google-Smtp-Source: ABdhPJzYrpQigh68ZfYnyX4QmzQ0WL9VAYBp49XsrzOWmhSX3IW15iNQYLnZKQnNUGmeRzeDDrV/mg==
X-Received: by 2002:a1c:328a:: with SMTP id y132mr16012529wmy.134.1605542920953;
        Mon, 16 Nov 2020 08:08:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8sm23621235wrn.33.2020.11.16.08.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:08:40 -0800 (PST)
Message-Id: <168891f9f8b61f958b7a32ab2bb744563d086357.1605542912.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
References: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
        <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Nov 2020 16:08:29 +0000
Subject: [PATCH v3 08/11] add -i (built-in): use the same indentation as the
 Perl version
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When copying the spaces used to indent non-flat lists in `git add -i`,
one space was appended by mistake. This makes the output of the built-in
version of `git add -i` inconsistent with the Perl version. Let's adjust
the built-in version to produce the same output as the Perl version.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index 9126684348..c298a8b80f 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -1137,7 +1137,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 	print_file_item_data.color = data.color;
 	print_file_item_data.reset = data.reset;
 
-	strbuf_addstr(&header, "      ");
+	strbuf_addstr(&header, "     ");
 	strbuf_addf(&header, print_file_item_data.modified_fmt,
 		    _("staged"), _("unstaged"), _("path"));
 	opts.list_opts.header = header.buf;
-- 
gitgitgadget

