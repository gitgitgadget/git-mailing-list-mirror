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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9AEC43461
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C1260FE4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbhCaTKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 15:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbhCaTJx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 15:09:53 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB6BC06175F
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:09:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c8so20713030wrq.11
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IbeiezXCwiFqenOnTA2j1h0VYSQ8VnkM0cCVB/AobBo=;
        b=apk59qvLJEhGOc/nSt2w6r+rydV4kmqMAcyUr5DVSdBzp8ri6ltp3pH6Top6D4r5rP
         26vVC6pym0kUd54xKLRibFcfC4qHP0B28rb6YDce+FzDOgY67pBBF0PawrHQqdOKOike
         ABHzoh4MNA1LSNR0pB9uCPCxKP0R2GbpiiI/kD0By6ulQbY/pESuInfpeb43RHU9zsx6
         DPeck97cR+f+LpzYVVV0yyqb0nZju+3GQy7Exw37F9Cu7QVhVBDs24ZjSjTvK6SVzSJt
         xKGfi5JqGgiBDp8FKu/PufEIFuk+pDSdwadmo93MPaJ85Bcu+SlIQXh2xd1Sm+QGvWAg
         ++8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IbeiezXCwiFqenOnTA2j1h0VYSQ8VnkM0cCVB/AobBo=;
        b=qH/b1jSkP3by9MzZkR0j3XlwMV3uIBM75Jbc6eVAh46kcEFyvhym+r0xRfxuSz3wHq
         1sOiIlvK04QkKuVtUQxncg9+A3952RnZsoSO+P60hLEr6KtEyssPpkoAdLj+oUJ65EkG
         nKC9fbHGs1UHmZDg61Rho0os7m/9K79oh4VzlY2l8pvgAafYMhLDM958Y7DOYI57Wt9f
         cbxCvXmftjuD6rTcS0MY0tYngDpaVd2Z5lAlWj6akyxXI8bRNEGWTYW0Y36mGWvnLcDt
         qu4CN14nlhVf5EuO7bttMmNYkwfHNr8h1r5xBZUxUB9UYyABCF5IONup4NtfpoNWk/pw
         R+GA==
X-Gm-Message-State: AOAM531Hvct6AJOXHlEcz7w14B7m37SNv9U1IHN6AB6Yhh1ROW9EBqWS
        vy+NPrlYy1mRVOfQ6qtq2RMa7aArD4wI8A==
X-Google-Smtp-Source: ABdhPJwvNyJzDp0KCxvtXQnVsFiBsVYm27EVQKoAlBfP08HQlnGPBFZyMlNhKo1R+G8EjbQD+l7x2w==
X-Received: by 2002:a5d:654a:: with SMTP id z10mr5425924wrv.335.1617217791558;
        Wed, 31 Mar 2021 12:09:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l8sm6019268wrx.83.2021.03.31.12.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 12:09:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 02/18] merge-ort: correct reference to test in 62fdec17a11
Date:   Wed, 31 Mar 2021 21:09:30 +0200
Message-Id: <patch-02.19-57092359bbb-20210331T190531Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.474.g72d45d12706
In-Reply-To: <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
References: <87o8fcqrg8.fsf@evledraar.gmail.com> <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
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
index ba35600d4e0..dd1f38e3c32 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1073,7 +1073,7 @@ static int handle_content_merge(struct merge_options *opt,
 		/*
 		 * FIXME: If opt->priv->call_depth && !clean, then we really
 		 * should not make result->mode match either a->mode or
-		 * b->mode; that causes t6036 "check conflicting mode for
+		 * b->mode; that causes t6416 "check conflicting modes for
 		 * regular file" to fail.  It would be best to use some other
 		 * mode, but we'll confuse all kinds of stuff if we use one
 		 * where S_ISREG(result->mode) isn't true, and if we use
-- 
2.31.1.474.g72d45d12706

