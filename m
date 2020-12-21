Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D7CC433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47CF122ADF
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgLUTQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 14:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLUTQW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 14:16:22 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE9BC0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 11:15:41 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o17so26327818lfg.4
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 11:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5GEYkQBVS1MSou2/MhE82uy49/ATzqXjRlMbDbpvqtM=;
        b=XhY1HwP7IDVuAAgU3iS9dWoGVLXcHDOJG3M9OogAOTd/PSx3J2d6XCoKvGPI8O+lYI
         rn9kbzfqfOEcuBhdw7jMtVcSQnvbrYhsuk7qvrsgJbvmaOD/y3GMxnPhLYWU5Qst36WR
         Hy6wOvSYv0WMvvHufG+LoM4pDv+K/Y0ks5US2b/oLtGxhbGQbqwNCfYww5U+xDPzQ/bJ
         OFCtp245zEsoSHEDoSmtzM4Sd68KpXw05FDRCPM6l7axtNUJ5m14Vl9tbscDMKiGYT2E
         IxouZD5RmsXpc0K3b9QUONTsQmzDmCzW9SCFXfcq5OrpHDp5Fkm6Ud/6sNak1EggVEHl
         UTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5GEYkQBVS1MSou2/MhE82uy49/ATzqXjRlMbDbpvqtM=;
        b=b7+vNBUfWZ1SsjB/jRhQZVYPnm5AoNnYs/oJWPYx5mHWLN/9KnN+T/B8YcVw5NUVoj
         80rhFmtpUH7jys1TsLybppUCEUu7Wwfb9+MpHoGMK5ndYE7gOPAPKa3YsuL+/9syu7Wj
         mfvWRXHcipyse+2C2ks0U+CBjPsmr0me9i13ana8ZGQBHZZ0ClSLCGME9r1AOHn8nQtb
         jy2UcAXz+CRFl8rJ9ZJsH5jvHy5XKZlW0+sykT1pGDlr15voTlk8SvIAeZu+XGzPCkHZ
         pXB6dfBZdBtDaY4QBUXHV6i/gPpSLAAtJCV/SRe+zLG1ajmidiDQQEse+q7PiDN0lIID
         pM0g==
X-Gm-Message-State: AOAM533rTMGul+Z8/iawqt4r3roGodTbideRJoeghVGpPcuYQbeyFJmP
        ZPwJEzaglvQm2atY2Ny789Cds9f9lf0=
X-Google-Smtp-Source: ABdhPJw0Egc5PKfNVwMBVI0SLy3WSvXRD7SSoiBVqKYhL4yu4ww509cj0fih8fBl4JWzNKTj9shNQQ==
X-Received: by 2002:a2e:3503:: with SMTP id z3mr7955464ljz.74.1608564049844;
        Mon, 21 Dec 2020 07:20:49 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:20:49 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 14/32] diff-merges: revise revs->diff flag handling
Date:   Mon, 21 Dec 2020 18:19:42 +0300
Message-Id: <20201221152000.13134-15-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do not set revs->diff when we encounter an option that needs it, as
it'd be impossible to undo later. Besides, some other options than
what we handle here set this flag as well, and we'd interfere with
them trying to clear this flag later.

Rather set revs->diff, if finally needed, in diff_merges_setup_revs().

As an additional bonus, this also makes our code shorter.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index c48a65f8de64..225edd293b43 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -41,16 +41,13 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 		revs->ignore_merges = 0;
 		revs->match_missing = 1;
 	} else if (!strcmp(arg, "-c")) {
-		revs->diff = 1;
 		revs->dense_combined_merges = 0;
 		revs->combine_merges = 1;
 	} else if (!strcmp(arg, "--cc")) {
-		revs->diff = 1;
 		set_dense_combined(revs);
 	} else if (!strcmp(arg, "--no-diff-merges")) {
 		suppress(revs);
 	} else if (!strcmp(arg, "--combined-all-paths")) {
-		revs->diff = 1;
 		revs->combined_all_paths = 1;
 	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
 		if (!strcmp(optarg, "off")) {
@@ -103,6 +100,7 @@ void diff_merges_setup_revs(struct rev_info *revs)
 	if (revs->combined_all_paths && !revs->combine_merges)
 		die("--combined-all-paths makes no sense without -c or --cc");
 	if (revs->combine_merges) {
+		revs->diff = 1;
 		/* Turn --cc/-c into -p --cc/-c when -p was not given */
 		if (!revs->diffopt.output_format)
 			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
-- 
2.25.1

