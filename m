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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22D5C433FB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E88261937
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhCUACW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhCUABk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:40 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BCAC061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:40 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e18so12870288wrt.6
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7LUcJ13H/qcIZYRm+ZvXiCsD5nVzWQ83tNt06VplU08=;
        b=m4uItT45RsGk1fbmHh6fSuJD9TShFZRUmOoL1LUerCmqYqBf5beAGvqBi/eFUJO8xV
         PC3z/0UdoPVsvVusrXzYsGShDuIBhiLRL/P9ZW9Ea5v4eLuLOJGZItXFh8+WAqayDGoN
         Gaslqt06sNigdEarjpWmcEwUfW3b0l2x+b8zu3Ai2t7ZHq/b+8KuY6zEvik1no0PQjpM
         xhO3xlWIG/mgBQ1wK7M92gHZ7u9Taae10BkmXDWV1RolVU/GVnkC7BJVG7K3qy62tsY1
         QNjCCZkF1zW6yWVEApM/j80kE1LBqKTzgsm5YsH3jfIlcdTUM4SHS7XaeKWvHufNAsG6
         RonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7LUcJ13H/qcIZYRm+ZvXiCsD5nVzWQ83tNt06VplU08=;
        b=npjsoVLr0S75aLms2FWWNzmrR3+IacsQ2hNYHWaUIc8CvB9Jax+npMZ7RHKls8Q4Hl
         4rEd5dtFRRNyZ6Q+Jjq4NW3ECRuAtYQ5Vpto6EWZBGgtdwGdnBHwpmGRprt8/+N72qrb
         Ooomn18Zp3NGgcJUxCEydcIfmOT7YfhEqDyCJFuzqXX/TcnK+3mT1tOPMo0HufBMz9El
         OEMgZoSBn95r8EzLD+a9wTHd24I2vDWzY6xXomepjFBlrNDqH4jha9jfEZ+wGOTEmYJh
         8BnTehOAExcvDnKput1fO/nV1E3p3eSLLXHoOHdG+sCfHRbbm6uiGghzYzvNHhjpvxPu
         M/Ww==
X-Gm-Message-State: AOAM530J4zB43h/IiL5XHEtjFBkW3rBBogx/zWLmetydFemj77mr7SYs
        sYgEh1Q7kgUzzxQSAkq4JORnz4sg0xby/g==
X-Google-Smtp-Source: ABdhPJwmLRGy3+UUKuH98sN8kTGrRtJOo+VKWp8ZqxpI9dxJhTkZ5a4ZB6Quu/EOMphCRL8G9GfSag==
X-Received: by 2002:adf:c3c8:: with SMTP id d8mr11159941wrg.167.1616284898621;
        Sat, 20 Mar 2021 17:01:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 16/29] merge-ort: correct reference to test in 62fdec17a11
Date:   Sun, 21 Mar 2021 01:00:49 +0100
Message-Id: <092472f3c8d92e7cd0195ab3068bd84eaabc9f9c.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a comment added in 62fdec17a11 (merge-ort: flesh out
implementation of handle_content_merge(), 2021-01-01).

The test being referred to here was moved from t6036 in
919df319555 (Collect merge-related tests to t64xx, 2020-08-10).

It has also had the plural of "mode" in the name ever since being
introduced in 5d1daf30cce (t6036: add a failed conflict detection
case: regular files, different modes, 2018-06-30).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 merge-ort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 052231efdb2..c9047e279c6 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1079,7 +1079,7 @@ static int handle_content_merge(struct merge_options *opt,
 		/*
 		 * FIXME: If opt->priv->call_depth && !clean, then we really
 		 * should not make result->mode match either a->mode or
-		 * b->mode; that causes t6036 "check conflicting mode for
+		 * b->mode; that causes t6416 "check conflicting modes for
 		 * regular file" to fail.  It would be best to use some other
 		 * mode, but we'll confuse all kinds of stuff if we use one
 		 * where S_ISREG(result->mode) isn't true, and if we use
-- 
2.31.0.286.gc175f2cb894

