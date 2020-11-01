Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879E9C2D0A3
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F61E208B6
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6QFQ+fL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgKATeX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 14:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgKATeR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 14:34:17 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B39C061A04
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 11:34:17 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id m16so12662889ljo.6
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 11:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6uBk7wgI2yeVqsDY6kvr2F6GiNd8dhXM9z7GG2OcM+k=;
        b=P6QFQ+fLAo07ui3/8vvNTTjbGx/yQRY4fHh1B+r0zlMwEKbkp0Kc9ud6XyXGPEL+M6
         tfiLv+4fCt0F3CcOARuiLfYvvlqGkkyaczPBOjjZCIXH/XsfmYDwH1z7XTrsIphdTkjw
         pb7JTFJvy1fdFhWVmZajQ+jZm9fynyZjpLO/JRUZBEcjEQ1IdfDbGlB6M/pdMrU1LccF
         D4mvEwsiRcWR+E/2HrG3IAOYJVhu4y6hz18jZmhQG96mFBpjK7K9L92RcxjsQZ+cwcMA
         WHRiPWW/JC2/UWGtkj0iTsI2zZxtkpR77gMWWLm5dDKQlOsHWF/2wu6cMuLyY3LZ4oiP
         ni9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6uBk7wgI2yeVqsDY6kvr2F6GiNd8dhXM9z7GG2OcM+k=;
        b=WQ1uLoLtDDzBiLPC+kYBWSvM6C+mgc7C9KQR4U73HEqTmkko6G1VV0O6pcMfSHMRtD
         u0Wl/PPpfEZN3pcvIvWtPaO3Ml+JD/WO+O4cQH0qJJb7FLjxp8K7DKW8MB4/+zVt93ql
         iqjVPtVfmPslMNBppHHbTTXKI6+ZOcPqbV8n3esPaxdBOSUiIE9Yi5fvTjhCwqWu5GH8
         bzcUh4yJW8Gu/6n0mXmx36hdXkql7Y7Xwi+0dDtke/RUz3GewWZi4ieolTK5Wy9SGCPi
         593kYGORxXJleyj97SYu/cR5ueff8ggD7hFF/8g2DIpN+TlXsiQj3W85WPTzL55wSCv/
         /ZOg==
X-Gm-Message-State: AOAM532lPDRa1RN3hCMksJh++ZJBWBJ5Kw2++9yzvO3ZTVOKZiwzNTLi
        It60uO4hqpQRJ8cYI6EdGQI=
X-Google-Smtp-Source: ABdhPJxLikUfOJjp+YEibDOqkTeq96FfSj2xhyGUepfSbhdM5g9fkeGakklb/dOKqAvFN0oYAjlABQ==
X-Received: by 2002:a05:651c:1311:: with SMTP id u17mr5399327lja.177.1604259255589;
        Sun, 01 Nov 2020 11:34:15 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m12sm1766526ljc.88.2020.11.01.11.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 11:34:15 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 13/26] diff-merges: revise revs->diff flag handling
Date:   Sun,  1 Nov 2020 22:33:17 +0300
Message-Id: <20201101193330.24775-14-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
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
 diff-merges.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 63912ddedc76..a30c730a457f 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -37,16 +37,13 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
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
@@ -94,4 +91,6 @@ void diff_merges_setup_revs(struct rev_info *revs)
 		revs->ignore_merges = 1;
 	if (revs->combined_all_paths && !revs->combine_merges)
 		die("--combined-all-paths makes no sense without -c or --cc");
+	if (revs->combine_merges)
+		revs->diff = 1;
 }
-- 
2.25.1

