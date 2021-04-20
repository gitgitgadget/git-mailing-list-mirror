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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B2AC433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AD74613D1
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhDTNBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbhDTNBI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 09:01:08 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A62CC06138E
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:00:36 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g9so21492460wrx.0
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1RZq7YhNOmJijP7yS1J95TR3J/DmRVyE9fPLI6DpIMc=;
        b=PToe7cwa/o2HEkvsCOLN872jYCo3JDm8exhsq2ergeJwaoOjVyJ4eGb+4lw2ydbO39
         uQ4cw6enInSvlDdpVvz3FD8jo2EYH89O5PZyNrdbfWC25iHw4pZxc6TvH/ApbKrYRW2i
         4ZJH5AvU4+3eFL0Qj2BLLSofyy9zReeK4XiEgJkRNyWtjlUssiJn8J59MVgByGmL3NNP
         c9ULv9QA4RPC9/62P+a9QqwmbU7y1DLt3/UbSjkBV1tXgWkjF0dJN4gj4zoi/F9Uv75I
         HYO0VAWzquKzzezAtFmd9jqkdHybbHSdNkvvSpVe6Zo25juXe0Wgcw+dvdYAfns0EAer
         I1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1RZq7YhNOmJijP7yS1J95TR3J/DmRVyE9fPLI6DpIMc=;
        b=OgMg4be5yhmIsXMNFID3v3eIX2ym6iSi7bH4tSZ7Sz5mAxQIoRO+6TLQNEH4ljPsve
         EfV9NRhBNnCbpTJ/8SvtZk0dn65Gh5UxQMsF7ZNauFof/QxqV1o3n3MccVY7OY4tlwPW
         4+5p8SXBRsN+S4pE55eN5ZbLRA5cpaZp7rPDW2+0WLTqmvrNM0Sm2QbgWQi6m2TEzYEU
         0XUye6nbNaOvxEPMQayVWR4f1CLIs8lzyw1IcHSGxCHKej2bWxhD5VTKbCmeysqMnMVY
         x0ZRwcJ3JjqQfajNODkt0RObVG14x/x1nzoFfe2FrykEQVg4YbsglHyirQifqlLKdEuB
         JPLw==
X-Gm-Message-State: AOAM533U39N+yr4vB4+BPyuDwoNRnfsnBXINvPTmOGWHwYTa1c99pOIK
        4jM9TH9wLvcizZWNzMJTQ135XjS0W0eptQ==
X-Google-Smtp-Source: ABdhPJxCCLOp57hOeF6pU5wm8tFCia7g9ywKNaq8FqDIH5hKcaQ96bEvn2/thsccQT4E5bIjp0sWQQ==
X-Received: by 2002:a5d:6c62:: with SMTP id r2mr20708158wrz.37.1618923635065;
        Tue, 20 Apr 2021 06:00:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w7sm24452523wrt.74.2021.04.20.06.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:00:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/10] hash-object: refactor nested else/if/if into else if/else if
Date:   Tue, 20 Apr 2021 15:00:14 +0200
Message-Id: <patch-08.10-7bf04edc74-20210420T125416Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-00.10-0000000000-20210420T125415Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com> <cover-00.10-0000000000-20210420T125415Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor code that was changed to this form in 4a3d85dcf67 (add
--no-filters option to git hash-object, 2008-08-03), seemingly for no
good reason.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/hash-object.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 4d3b8c49d2..4b337e0d25 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -130,12 +130,10 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 			errstr = "Can't specify files with --stdin-paths";
 		else if (vpath)
 			errstr = "Can't use --stdin-paths with --path";
-	}
-	else {
-		if (hashstdin > 1)
-			errstr = "Multiple --stdin arguments are not supported";
-		if (vpath && no_filters)
-			errstr = "Can't use --path with --no-filters";
+	} else if (hashstdin > 1) {
+		errstr = "Multiple --stdin arguments are not supported";
+	} else if (vpath && no_filters) {
+		errstr = "Can't use --path with --no-filters";
 	}
 
 	if (errstr) {
-- 
2.31.1.723.ga5d7868e4a

