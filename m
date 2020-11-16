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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1E1C4742C
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30E1020729
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQWBBcdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbgKPQIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 11:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731658AbgKPQIh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 11:08:37 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D86C0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 08:08:37 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h21so3329094wmb.2
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 08:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dpll76Bt0FuWoTL59TONqXQ0KGL2T+WUdIsjig1jOUg=;
        b=FQWBBcdwKCARAq/cLY0Ed5g/F+XkhkMo/bNDPJgxX4md/xpgy/bAaEbWb0q83NhySV
         cc8euxmPgvefEPfYPgxK6Vih1WlyIKblfUneB77HfM7MEd7B2Tym2GxWK5rPF+aAozPj
         Riff2Tn+RclBJLT9ixAbRqUyw8JTUf9FLJMJX/9tMmouv6XBnmCVfIf8W0a99o2jqaTO
         JAl0Cu7GMgpKEIve28IGLuq7swJbCi6s22KhtSuE56F04OTEAPDCaqPj4FCHwEJdJQIG
         wh4OVFynccDyqzC6IYrG/uUFXnoBbEiOZPerbkyVVa4bKNGNRMFjTYy1NhT7qh5ruPHr
         Xf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dpll76Bt0FuWoTL59TONqXQ0KGL2T+WUdIsjig1jOUg=;
        b=UdCamG5OjvQ744bvrhfs8kzKiFKc1LXnFEC1baxCqJ69SlQTyi+Iqj8pD63Rz3ameb
         UpUlCKtSbZ3C2mh3p6QAwQ+5qJ9co0x9fkzMtmEuyhHUXhVhuPcvvJomMzxCMkLTKmej
         x8m0hlbcaQ9ehz7ex3h37znr4hEJWxjguvA1LH18qmmCPsR9TQGj56CdaatTSHgM90Qf
         f4X9PFqguVroM69JNdRHzP+++dbvsBefW2kuoiAKlwXYbkCMU8G1fnP9pngLzz13madE
         QC/51hU1XGVzrnhYVfougVmBJLSjV5lGQgHaOm+Xr5v3NCTL80rDKm6eTeR4lslfyLb2
         UCow==
X-Gm-Message-State: AOAM530iB0Z4zdJZei/aK8O7wQn3sbvPb0ZhF8LfQXQczdSPj1H/Hx2y
        1u7lM9CmkbHCndr9RsOphbx+GTkmIic=
X-Google-Smtp-Source: ABdhPJwL5ANPWD4SMNw26Z5WriL9Y7TEd9ZhWQqZu3cS9ilWZ/X0tgXNZ8KRjWkyIngJsog3+K36uw==
X-Received: by 2002:a1c:93:: with SMTP id 141mr3353897wma.52.1605542915617;
        Mon, 16 Nov 2020 08:08:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18sm9747811wru.42.2020.11.16.08.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:08:35 -0800 (PST)
Message-Id: <068813912b9e5133f9d9bbacb239f7954788bf53.1605542912.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
References: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
        <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Nov 2020 16:08:23 +0000
Subject: [PATCH v3 02/11] add -i (built-in): send error messages to stderr
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

The Perl version of that command already does that since a301973641f
(add -p: print errors in separate color, 2009-02-05). The built-in
version's development started by reimplementing the initial version from
5cde71d64af (git-add --interactive, 2006-12-10) for simplicity, though,
which still printed error messages to stdout.

Let's fix that by imitating the Perl version's behavior in the built-in
version of that command.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index 8ca503d803..0f24992ca4 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -365,7 +365,7 @@ static ssize_t list_and_choose(struct add_i_state *s,
 
 			if (from < 0 || from >= items->items.nr ||
 			    (singleton && from + 1 != to)) {
-				color_fprintf_ln(stdout, s->error_color,
+				color_fprintf_ln(stderr, s->error_color,
 						 _("Huh (%s)?"), p);
 				break;
 			} else if (singleton) {
-- 
gitgitgadget

