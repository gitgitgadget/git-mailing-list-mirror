Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F18C433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 02:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB99622B51
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 02:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbhAXCOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 21:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbhAXCNe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 21:13:34 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B396C061788
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 18:12:54 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r9so2143387wro.9
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 18:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uTPn9q3Vmv00nzaGRt1pGDNiQdNZu7+0/RJKBPNfn1U=;
        b=cj/aCPwXr/gtHW6bCTLb4iKTjldppN5ET/9kuv0keipnNikFZ3lHU/HNC+hxD7sx66
         vDWzX20wqWwrpDaNJI+1+6xSfNBIiZBlaTnK9qSJGeYBygpW5X2ohRunbtOwjWR2Jm4w
         tUVZpWX8R1ApcLJn3irULC9MCIFP9tOgmZW0B+g88v61pmRUaz9xTPOTpxk2YztblOfe
         ZoXPUtNh8Bgxcml08Layf0ZhhjUFE2OgqozuV3ivfmOQ5q7hfm49t7INz8TqBtAdYXXF
         QIKm4vWG6VkH3FALxxY1ZxliXeTm/KpRG4Dk9QUyXLXgAhP7F5oOH+K2cS+3LogfStT1
         qJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uTPn9q3Vmv00nzaGRt1pGDNiQdNZu7+0/RJKBPNfn1U=;
        b=UGAgCNDyjmyqHXA8PfD01aPwQSoxPGxYXZ6KMSblU8yDIWnXSAYsNfcnwaR0kejlE8
         l55zEeeUocacZBP23r6PctFI814RhfDZiryfdidAnyzAsBolHJ2tKcdXdNipl3FYJRFd
         DtWO2Uv1MA3kC5ivoD6tkUinUivQzZ/BUcLNrogMeSc9AyQcfBBy/Ga4HoqbxKPZiyGX
         zn5M+PZA8zc7f5yC7/MBiBFwzMc08IGMeNLP4quL3aOqCJtwubZUgGZY5ZjUmwNjf8Ey
         AQbyvFDsCYRMwHaULcmpe0moIMEIdnppsyLg5LXJFdw1+6O5ZYxRt/TgV8a4XU7lfkjJ
         EUMw==
X-Gm-Message-State: AOAM531KeCmRs4DSBf3vtQz6XeXYYFZDC/41OF+aXaiPM8S86RAv7c7N
        KDsxuRBeHMQUGg0N5XqeLQG/cAVHxCcwSg==
X-Google-Smtp-Source: ABdhPJzGa+Mbuwlx3g3mnmosmg/3bTdJa+SlPwdp0pL5H4WQv6m80lVjtG4ufjRsZd8g8UVlaSCaew==
X-Received: by 2002:a05:6000:185:: with SMTP id p5mr10833867wrx.403.1611454372818;
        Sat, 23 Jan 2021 18:12:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z184sm17380129wmg.7.2021.01.23.18.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 18:12:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/4] grep/pcre2: simplify boolean spaghetti
Date:   Sun, 24 Jan 2021 03:12:27 +0100
Message-Id: <20210124021229.25987-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20190726150818.6373-9-avarab@gmail.com>
References: <20190726150818.6373-9-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify an expression I added in 870eea8166 (grep: do not enter
PCRE2_UTF mode on fixed matching, 2019-07-26) by using a simple
application of De Morgan's laws[1]. I.e.:

    NOT(A && B) is Equivalent to (NOT(A) OR NOT(B))

1. https://en.wikipedia.org/wiki/De_Morgan%27s_laws

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index efeb6dc58d..0bb772f727 100644
--- a/grep.c
+++ b/grep.c
@@ -491,7 +491,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		options |= PCRE2_CASELESS;
 	}
 	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern) &&
-	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
+	    (opt->ignore_case || !(p->fixed || p->is_fixed)))
 		options |= PCRE2_UTF;
 
 	p->pcre2_pattern = pcre2_compile((PCRE2_SPTR)p->pattern,
-- 
2.29.2.222.g5d2a92d10f8

