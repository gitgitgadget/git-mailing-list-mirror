Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BE5C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B07060F6E
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbhJHTKI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240698AbhJHTJt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:09:49 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E88C061755
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 12:07:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v25so32599886wra.2
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 12:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CmOxadZbZ0sC489o1MBTBZNEh32GbZbNl624BQgYl5o=;
        b=Lmt8/wb2br4KjdBLh6Nl62COhWShibGqNq/UOZ0tWMouuCESVOsQedFJZhSYuBn0vV
         T3GTVNefIHSZapbjsrfFWkQ1UFn7mEkg0cWU9Z9e0/95WmPa9yiNCrdGGYgGllLQhbaY
         nOPlO6hGqtkjtdQFV0idTfEQfgQ/7xjR7sncFQlAub+fcyrGq9TAgJ4dW+CYwvZey98E
         7DUB2TF7mYqNa8lmF5xU6YZLOJFnrFH4ltCtgYWB1eIErY4llZC8dNCDMb9GRtdQd+Qi
         6a5G5yIcE3cCkT+5LLz2YQGGtpHiygzrFecmMgRn07b56FI9ymZGL7H0emR7XwQWhS4H
         SR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CmOxadZbZ0sC489o1MBTBZNEh32GbZbNl624BQgYl5o=;
        b=xwhyTvHbV428iSwBkRsfx/fGXsWvc7adAGVnL74iOSNVOtVjY4x3c+5PDvnF40lPr1
         /dlbacPr6uYBDR8s3Q8SH3JDG/FjAmAQuFkCMFzq6ezORWcOgO8TQdg5guisiU/9BsxP
         wnw3Akfb2V5SbKBFtFEeAaTdnthu1ocE5nDKYbTQcN0LCDeA1T21dZ97IQmTFpAqXGcj
         2oAI2pB8YkovAoHz/mMlVQPXkSRySSrK2Fx9lUn7cEEZJzuohEc8FtHK34YGLF3PZcBi
         ECwXsaIO7ZBHRAO4pLn2MWCq70Za8bWEFtIM6syHF3DG7xElcy8//mET7F5nOGy5eUjj
         sk3w==
X-Gm-Message-State: AOAM532GN1KcJbgltHVWxRwdchdzvBPp+4mleOcpRx+Ytcjzvlxldq6j
        t428zzDRTr9w9bH0Ta7QiR6VwWKqa0nn5w==
X-Google-Smtp-Source: ABdhPJyPvwzVeD9jTsFxlJSHtvMGFSOi74Ofb8OxoY491My7KvAy4rMPAYwk8263GZfLdcdbMf0Ahw==
X-Received: by 2002:a5d:4882:: with SMTP id g2mr6235697wrq.399.1633720071474;
        Fri, 08 Oct 2021 12:07:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x17sm169882wrc.51.2021.10.08.12.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:07:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/10] parse-options.c: use exhaustive "case" arms for "enum parse_opt_result"
Date:   Fri,  8 Oct 2021 21:07:40 +0200
Message-Id: <patch-v3-04.10-bebf3448c49-20211008T190536Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1446.g6af949f83bd
In-Reply-To: <cover-v3-00.10-00000000000-20211008T190536Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211008T190536Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "default" case in parse_options() that handles the return
value of parse_options_step() to simply have a "case" arm for
PARSE_OPT_UNKNOWN, instead of leaving it to a comment. This means the
compiler can warn us about any missing case arms.

This adjusts code added in ff43ec3e2d2 (parse-opt: create
parse_options_step., 2008-06-23), given its age it may pre-date the
existence (or widespread use) of this coding style, which we've since
adopted more widely.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index f718242096c..e33700d6e71 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -866,7 +866,7 @@ enum parse_opt_result parse_options(int argc, const char **argv,
 	case PARSE_OPT_NON_OPTION:
 	case PARSE_OPT_DONE:
 		break;
-	default: /* PARSE_OPT_UNKNOWN */
+	case PARSE_OPT_UNKNOWN:
 		if (ctx.argv[0][1] == '-') {
 			error(_("unknown option `%s'"), ctx.argv[0] + 2);
 		} else if (isascii(*ctx.opt)) {
-- 
2.33.0.1446.g6af949f83bd

