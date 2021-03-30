Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A8AC433E8
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD596619E1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhC3PE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbhC3PEH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 11:04:07 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A6DC061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:04:07 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g24so12112007qts.6
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dtJt3DvuOK3XM/npLCbaRG1X9CdZJ7yFJ6tZkoN+heo=;
        b=YbiTA3upvnB+OzYJdfd3/gDeGN7doKqtgZmLq8dp96BZhepXWYhaUlhWYdLcntseeg
         qnfSfPL8+4KiHtP3dllzSsTjdF4u1MQ10IzxkgvQq1akJwMPtlTAP4n/duMysnP3Dw47
         8Ln3Q4+Ouag7p9XUg6ySo/EBSXcqxrdNiG15Dwfryle0Y6tQph35kHv+PrWcMffgB+mU
         OICP2QSD0U5ftLvJB+1Q7M5I5pFbKFs3UZZji9SLdZS2W2dnF1y45BRWbipeUDW3HfuV
         aamAnWvmbWT1kubxw43vBXB+pIabkn3rqxAgBzQTnuU8wZJ7RdGLpNHK+5IQn1v9KSse
         AZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dtJt3DvuOK3XM/npLCbaRG1X9CdZJ7yFJ6tZkoN+heo=;
        b=YWh8QLBtbt/gj3mPAC2hnoVPF876eweaPUU1dltHYX8PVy8fWkO4vgFLEUcR2Ag461
         tOTwq/Oa/vjhxkDIHfc2VGvb/kHhuTxsQ4bNVArwBkI99+4CR4UHYevbZUKeZKWOB0EJ
         0Vnx3ERMN+8vgyo8wz8UCjb7vSxWGveLzB+EmSI2h5krz8lLlBSFhAD18FCahxVvwOGF
         nzuzuRyDqIuLCV4YkmlOKBv51wsLRJokHq2+xdb3Xf5MsaJ/ErDH2vXy8J5TjgSWmnjb
         uV36RV34AAkddOHpCt6NwC60Fk2P1YVxkZSuZLiBVbym5vVKqTVUiyokTNlfLHhRslDF
         8S2g==
X-Gm-Message-State: AOAM532SSXbjZIVWZDML9I45f1aavBNsN0RmkuysiNm7F3F0Xt/GFzWO
        VzT5aQBSt3/UNaaifiJEc6ssTmDXRU6U7g==
X-Google-Smtp-Source: ABdhPJz3PaD7tyShy/+OU247o1EOC0JIa7A2f+4x8BPK91TWghOxIFisVlCZ+BWTAH0McbjdApN8ag==
X-Received: by 2002:ac8:73cb:: with SMTP id v11mr17321042qtp.332.1617116646168;
        Tue, 30 Mar 2021 08:04:06 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7b00:4f79:8763:6261])
        by smtp.gmail.com with ESMTPSA id j13sm13107464qth.57.2021.03.30.08.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 08:04:05 -0700 (PDT)
Date:   Tue, 30 Mar 2021 11:04:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: [PATCH v4 06/16] builtin/multi-pack-index.c: display usage on
 unrecognized command
Message-ID: <604a02ce8549be870dc7af3109289fa0a4b1e60f.1617116623.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1617116623.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1617116623.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When given a sub-command that it doesn't understand, 'git
multi-pack-index' dies with the following message:

    $ git multi-pack-index bogus
    fatal: unrecognized subcommand: bogus

Instead of 'die()'-ing, we can display the usage text, which is much
more helpful:

    $ git.compile multi-pack-index bogus
    error: unrecognized subcommand: bogus
    usage: git multi-pack-index [<options>] write
       or: git multi-pack-index [<options>] verify
       or: git multi-pack-index [<options>] expire
       or: git multi-pack-index [<options>] repack [--batch-size=<size>]

        --object-dir <file>   object directory containing set of packfile and pack-index pairs
        --progress            force progress reporting

While we're at it, clean up some duplication between the "no sub-command"
and "unrecognized sub-command" conditionals.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/multi-pack-index.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index b590c4fc88..8711174fae 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -152,8 +152,7 @@ int cmd_multi_pack_index(int argc, const char **argv,
 		opts.object_dir = get_object_directory();
 
 	if (argc == 0)
-		usage_with_options(builtin_multi_pack_index_usage,
-				   builtin_multi_pack_index_options);
+		goto usage;
 
 	if (!strcmp(argv[0], "repack"))
 		return cmd_multi_pack_index_repack(argc, argv);
@@ -163,6 +162,10 @@ int cmd_multi_pack_index(int argc, const char **argv,
 		return cmd_multi_pack_index_verify(argc, argv);
 	else if (!strcmp(argv[0], "expire"))
 		return cmd_multi_pack_index_expire(argc, argv);
-	else
-		die(_("unrecognized subcommand: %s"), argv[0]);
+	else {
+usage:
+		error(_("unrecognized subcommand: %s"), argv[0]);
+		usage_with_options(builtin_multi_pack_index_usage,
+				   builtin_multi_pack_index_options);
+	}
 }
-- 
2.30.0.667.g81c0cbc6fd

