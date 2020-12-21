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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C02C4332E
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 579E822D49
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgLUSFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgLUSFy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:05:54 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8683BC061793
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:05:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id h205so25816141lfd.5
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EP+cYVGUySztP3KkqPztNZQSEbau2EvM/WYubE9/QR4=;
        b=aNzKK7lDV4n9gTi9tyvTyLL/oXR96eKwM8gqn6QNEOS9gezDaYfCIt+HjSAAai8+fh
         qvNzugOgkpL83JeKMAqh9hoWzwR5krR2nVhT1gbRsvdgT6si22/PMd/tk2MXQN4m5oak
         CLfXgzZLdYBZG99hY7VEDk3y3fPdVApI8ZgGwnWK5Xd190kPmbd72mm3cn+/HkN+4TGt
         c5ZzeRptHIjiEZP2nmJBq3JYKaz80cOhm9UXXMmiyhIk4j4NGpG82+pnK+jYbZhrZ30q
         8vWTECAQM9DlpKAvZ8envS2dIcj3s6Ut3Vq75B3Aogl3RPMhQgAWuCQtqbdB4i75cq1T
         ojsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EP+cYVGUySztP3KkqPztNZQSEbau2EvM/WYubE9/QR4=;
        b=C9n4f4ZthSH8BqCc6mfasW50AyJQrwCYox051zdo+zD+51usc8mvwG/QOuwEpqw2On
         u5/XyFPQBxs3hMIIP5oEQHCRQXhCif3eFm2sxIprITBea9/xxeFwIcrNH/cKLflvOQQ6
         lw8uddha8XHjeKAWCjRwGbtSW0dZdgoBuBp7Gu7ANxtz4MseuoJq/u/eoepvy8SkW2lA
         O2yHsa70sV1LSEvT/Arjq2D6k4OyGs2QJJF8MCnF3axoBFGZw2Qh/0q+NRsH5Z00eij+
         MvhbWH/8EeKR5RDNWeJ6lsY7Shne9MKfKqEHwbTt6FhOxPe7M3qSpGQpCIsIXSbWAVP7
         LNCA==
X-Gm-Message-State: AOAM533bWqd8v2ch7smBXDE6ANA59/m0qXQZvWz8HkDxGwdV4wjQynHt
        1OmmHI3LmNVWetu4RmGmW1js918Pez4=
X-Google-Smtp-Source: ABdhPJwxfLxY/VM+0N12YqRoyAoEfUunUTkLeF58q1GVhz+rk+jl6uo0f6svSa88+cLHoFehkIQ+2g==
X-Received: by 2002:a2e:a414:: with SMTP id p20mr7678157ljn.98.1608564059682;
        Mon, 21 Dec 2020 07:20:59 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:20:58 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 23/32] diff-merges: implement new values for --diff-merges
Date:   Mon, 21 Dec 2020 18:19:51 +0300
Message-Id: <20201221152000.13134-24-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We first implement new options as exact synonyms for their original
counterparts, to get all the infrastructure right, and keep functional
improvements for later commits.

The following values are implemented:

--diff-merges=	        old equivalent
first|first-parent    = --first-parent (only format implications)
sep|separate          = -m
comb|combined         = -c
dense| dense-combined = --cc

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index e3c0190ebd95..4d22da179577 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -17,6 +17,12 @@ static void set_separate(struct rev_info *revs)
 	revs->separate_merges = 1;
 }
 
+static void set_first_parent(struct rev_info *revs)
+{
+	set_separate(revs);
+	revs->first_parent_merges = 1;
+}
+
 static void set_m(struct rev_info *revs)
 {
 	/*
@@ -44,11 +50,18 @@ static void set_dense_combined(struct rev_info *revs)
 
 static void set_diff_merges(struct rev_info *revs, const char *optarg)
 {
-	if (!strcmp(optarg, "off")) {
+	if (!strcmp(optarg, "off") || !strcmp(optarg, "none"))
 		suppress(revs);
-	} else {
+	else if (!strcmp(optarg, "first-parent"))
+		set_first_parent(revs);
+	else if (!strcmp(optarg, "separate"))
+		set_separate(revs);
+	else if (!strcmp(optarg, "combined"))
+		set_combined(revs);
+	else if (!strcmp(optarg, "dense-combined"))
+		set_dense_combined(revs);
+	else
 		die(_("unknown value for --diff-merges: %s"), optarg);
-	}
 }
 
 /*
-- 
2.25.1

