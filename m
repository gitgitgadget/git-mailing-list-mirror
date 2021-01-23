Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1D0C433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 13:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98C9222CB2
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 13:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbhAWNC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 08:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbhAWNCc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 08:02:32 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4040C0617AA
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 05:01:13 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c128so6707495wme.2
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 05:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dCv8Vm3E5bnMX9AUxXBz0tqO2Ex0WNF6fvpf+abNb3w=;
        b=vTtiDE+7Zpfv7RwMSSykw4JQavYNPYr9JVEpPku83pO5mpk1cIcwpTug8zwjJsYMXe
         xm7yKq25c8a4/yVRq4ru5Q4rTtnlcylZbKxhVivEsd7eZ7ZzLe2ZE+Mlrqt4XxWVV5bR
         2zsIqqrz083v01rJbxBbamrQGlQuUFZzUFUOLgAbl3tjZjSnyGl/Cp4XDAToMmgvUqCk
         kzFZGt3wFGFSb33q9knFqz661M6FdLpdCHeWIrlUYxD3iP/lqqUKAac9VrzdJ14S79+A
         HMOtpBrG49pc6ac+ZnWLzgkqSiTmkgYWgGapR1C4z3rQIb7+wCZ+0OzWFmMdaGSG450x
         HNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dCv8Vm3E5bnMX9AUxXBz0tqO2Ex0WNF6fvpf+abNb3w=;
        b=aJJz62nMbr4I6EPbpIHtZ6QuWI+QegdVeVK6VYrwi8XCBHzcMpdlOuqVV8Ubj2mmhG
         WIgpeK4YvGZODbvzUMlo4o7F/vaOq3krGnOaq/uPXyit/DIHbpSxXnJPinHBkenfMLe9
         awV3aJDVHW3fAGxZemF6hVGggBP7JIshYPKRpUGmANtO/YVnYzyqNKFofpZ8WAkoLtKV
         Qkl777oy7jSbNrZZUPXFDguSM4OEnRSEf1xUJPOgCHEGyFCnjJ0mkdtQLEKGyk6KHDlw
         fN+lfYdUF6O2Vx8gmEiAV5iEZqJxdT19c5t/Ah06OvIkFSoGfq2ewS6yj/pwh2yOJDGN
         4wHQ==
X-Gm-Message-State: AOAM533EjjjuoAFiztX9XlwzFGT9UKqk0JdP4aHPnY3BbWwU8qHnnlLQ
        GIbMgVfDODxL39178EVoud8hJ/gWohHh9w==
X-Google-Smtp-Source: ABdhPJyGHJvULOcmTw8jfmqKqCtgZyQEhlkqCp1wWNW1YjH4nv1lAsrOvijJUyMCUnsPeX6ADTnBng==
X-Received: by 2002:a7b:c210:: with SMTP id x16mr7912587wmi.105.1611406872480;
        Sat, 23 Jan 2021 05:01:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c7sm16750319wro.16.2021.01.23.05.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 05:01:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/10] archive tests: use a cheaper "zipinfo -h" invocation to get header
Date:   Sat, 23 Jan 2021 14:00:45 +0100
Message-Id: <20210123130046.21975-10-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <87sg6s6lrs.fsf@evledraar.gmail.com>
References: <87sg6s6lrs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change an invocation of zipinfo added in 19ee29401d (t5004: test ZIP
archives with many entries, 2015-08-22) to simply ask zipinfo for the
header info, rather than spewing out info about the entire archive and
race to kill it with SIGPIPE due to the downstream "head -2".

I ran across this because I'm adding a "set -o pipefail" test
mode. This won't be needed for the version of the mode that I'm
introducing (which currently relies on a patch to GNU bash), but I
think this is a good idea anyway.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5004-archive-corner-cases.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index 3e7b23cb32..2d32d0ed12 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -153,7 +153,8 @@ test_expect_success ZIPINFO 'zip archive with many entries' '
 
 	# check the number of entries in the ZIP file directory
 	expr 65536 + 256 >expect &&
-	"$ZIPINFO" many.zip | head -2 | sed -n "2s/.* //p" >actual &&
+	"$ZIPINFO" -h many.zip >zipinfo &&
+	sed -n "2s/.* //p" <zipinfo >actual &&
 	test_cmp expect actual
 '
 
-- 
2.29.2.222.g5d2a92d10f8

