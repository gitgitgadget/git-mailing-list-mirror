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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D16AC4332D
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 417B5225AC
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgLWBjK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 20:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbgLWBjG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 20:39:06 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17FFC0611CB
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:54 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t16so16990065wra.3
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nrf1B/mjDuKVtAiooF3Zhliy60HVigqM1yyq2cZrlwo=;
        b=PpMXw7jMnXCxVlkK95OyVw8QC/NzcNv+DAL+qy3Rq4IjNUDFAAfiWz3Ifhp1SBxiSL
         88FSLHi/Fe/NvYQiR17fcogkA2x47QMVtAYT9jICFJ764muOQYuT3my1e8nIoZWSBoHQ
         OYzL2l2xdgxq1avh3LU1rTWhIjaHKZevJ+8gM2zoE+pKzGVe3bWuKaY35e6roKgnN1nF
         9S5N8J3HAqDqCRhjRMuhbXyCdgxNacciVm+pJbJ22PFUOfr74Z480BoVZYY8Lw8b2DTY
         qZzbW8kNm4a7U6+p0bLecXA9zEuJk7aKJBAl+wip+IGnyU8HJaYprn2A+D0RCKVyZmGW
         7K4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nrf1B/mjDuKVtAiooF3Zhliy60HVigqM1yyq2cZrlwo=;
        b=lA5i6mUX17dFNghzllGEe5jqgy+dDpRJzh+38QIBHpu+40C+x3arInuoc6GMhROMGX
         kb30OUNQl0AtwZVRoXg1CYDRhX7jPy3zwz0Cpdjuj/+vHHpGEWVpwSTIvjXjvgFBg4+/
         JrbVERw6WmmLU+wxpbLZngf59gsTyhLuupf7lxRnUXrs0FfoJkf06Vbe48yBiNOTUNHg
         TVkcALP5inZMJMCpBOIbXtIZE6eN+bm9lMCn/AZJ6h+y5+r0eiWCIxgcwd3cF5w5cW0v
         /9futryppS1UUw5U9GNVSaQc8C9osqXi940/up5EsnoxScJPU8g+Qe0QKjf1FQiKnP75
         0CiQ==
X-Gm-Message-State: AOAM533bD6cpYipx96U9EnVQ7pMLQkhhD+uiKDrn6TF/VzDAMHTt5B7Q
        /M7WtdXSOo5YglPO4JDFaPSAvBzc//RktA==
X-Google-Smtp-Source: ABdhPJyJRO6sr5+e4U+Be29OX9ihMnoXg2/Wi+2lPXee5IpPk+HRLgzYIIkeMcxJnHIbEMUhR0/UFw==
X-Received: by 2002:a05:6000:1d1:: with SMTP id t17mr27657240wrx.164.1608687473326;
        Tue, 22 Dec 2020 17:37:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d191sm28492563wmd.24.2020.12.22.17.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 17:37:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 11/20] mktag: use default strbuf_read() hint
Date:   Wed, 23 Dec 2020 02:35:56 +0100
Message-Id: <20201223013606.7972-12-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201209200140.29425-1-avarab@gmail.com>
References: <20201209200140.29425-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the hardcoded hint of 2^12 to 0. The default strbuf hint is
perfectly fine here, and the only reason we were hardcoding it is
because it survived migration from a pre-strbuf fixed-sized buffer.

See fd17f5b5f77 (Replace all read_fd use with strbuf_read, and get rid
of it., 2007-09-10) for that migration.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/mktag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index 4982d3a93e..ff7ac8e0e5 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -161,7 +161,7 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 	if (argc != 1)
 		usage("git mktag");
 
-	if (strbuf_read(&buf, 0, 4096) < 0) {
+	if (strbuf_read(&buf, 0, 0) < 0) {
 		die_errno("could not read from stdin");
 	}
 
-- 
2.29.2.222.g5d2a92d10f8

