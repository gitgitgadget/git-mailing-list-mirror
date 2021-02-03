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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC05FC433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF18164F74
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhBCD3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbhBCD3i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:29:38 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E332CC061788
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:28:21 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l12so22586907wry.2
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2x+6fBGe6X4YeDVGOhgxbAWi+iNw2jGFwEwAGRWfI4M=;
        b=DGun0Si9JRwV30hJqiz809OuPOoMZwRaFWf2FOWBF8zmOqGkP+L55cDYlKOhkcarNf
         ghK++9GKMMiJUelt1qJTWKiFihwBOslOyjT4MdXyt653LJZyOpnA6FPpz6Qe/DssLftD
         38NI9PWJIQ3NvCg6eEUBEADjADyaEzMPCwhObJQD2LnucXxCsl3HZoxpZq8TunE300Ad
         RdnybaRESP+sWEhZ98ewpvPQcxUkQZErGpVgm+QXwjJ7tOB6R2TDfiTP/6FrujN7Dt75
         38G8eqmaLO+btl9PpMOtpMs1VKhqrB+PRUNrE5XbiV6XPHyifWw02mjWhphEp1dF9eKH
         dOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2x+6fBGe6X4YeDVGOhgxbAWi+iNw2jGFwEwAGRWfI4M=;
        b=p7cNt/x6ooTcaDJddyQRJMfINGwwe683cp+kf3yRWbcY/DDCk3FVWujp3nFe8v5po2
         oYwfkXKTH180LBkRBb0GtCmHnz4R2jtRAvO0HsCyGlLxqAOIAdsRO7pn8p2FcH38TiT8
         IBQ3X43VVJpFuBvths19RkPSTlzvCog0eEq3WQGocdSBggAFbpGWX6B28ZfUtFW3E5da
         h4ijcQszEwJG0E4HhNEMykspQxTDt8TzW5JiqfoxbWI45jJepDux5qS4t6P5SPkq0FGJ
         JFWwOPYEnsr4hLOZDQwVkMIbBJD8EyjH9ynchzuKUxcfp+Yf2p263MQ+LrkfDhyZOTRj
         ZuNQ==
X-Gm-Message-State: AOAM531auc7P5BBZAnGTk6bRDhLeb8qvB1cPJUrZIrbER7f9mk58IN8y
        MKjazjCqFicf8OUAAwgI6tQBdMs006or5g==
X-Google-Smtp-Source: ABdhPJwpBpgwcQWdostk6jsZOCb7IDHlrF9oFrZ21Gv+UANgNUtvicQ83OtEA7KneRMbByb02YKMcg==
X-Received: by 2002:a5d:6b45:: with SMTP id x5mr1000990wrw.415.1612322900475;
        Tue, 02 Feb 2021 19:28:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c5sm971089wrn.77.2021.02.02.19.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:28:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/25] grep/pcre2: correct reference to grep_init() in comment
Date:   Wed,  3 Feb 2021 04:27:50 +0100
Message-Id: <20210203032811.14979-5-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Correct a comment added in 513f2b0bbd4 (grep: make PCRE2 aware of
custom allocator, 2019-10-16). This comment was never correct in
git.git, but was consistent with an older version of the patch[1].

1. https://lore.kernel.org/git/20190806163658.66932-3-carenas@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index f27c5de7f5..b9adcd83e7 100644
--- a/grep.c
+++ b/grep.c
@@ -373,7 +373,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	int patinforet;
 	size_t jitsizearg;
 
-	/* pcre2_global_context is initialized in append_grep_pattern */
+	/* pcre2_global_context is initialized in grep_init */
 	if (opt->ignore_case) {
 		if (!opt->ignore_locale && has_non_ascii(p->pattern)) {
 			if (!pcre2_global_context)
-- 
2.30.0.284.gd98b1dd5eaa7

