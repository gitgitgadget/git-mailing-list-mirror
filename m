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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F30C4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 01:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B93EC6115A
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 01:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240892AbhHUBhd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 21:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhHUBhd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 21:37:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90384C061756
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 18:36:54 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h1so2632321pjs.2
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 18:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WaKs5cipp52D71rz4cxLz4xNsEwfpPUnsH5X51TKPG0=;
        b=QMGhKJjGcK1JEk9mfPLHPYr5W5LiWLeSfywpbvBl6dAHaF+6sZmLHHd75BTAs9fBG1
         xw7BdiRNHyuyvDMLsxf/yyT3qYwNTQjFJkSwBoDTKPvqqYCFDSiy4fzOHLccFiQl5mVQ
         d6tkfOtm+8iZL++PuVauCo/ngGuuCXFQTP4lzf4GdGwcUWzdHblBn00kLpv1MmqXn2qW
         ZvAlBxnpZhVRoSx6eTOGJV27RjzOqNHEsHVfsK31+wWT6eHqOgJIVlvB6GNa6GSv0rgZ
         Z0cjMABMBRkZEJ0P95UWQft0wKCTrc8nK7hRYl8332I4BMBNBy6XRN3R6lyw0LKFcsd/
         uN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WaKs5cipp52D71rz4cxLz4xNsEwfpPUnsH5X51TKPG0=;
        b=LuznxLRKS5z+b4qa5WiFZLG4FTEVfVMaimlSG3qcSxkFtKFgt63g081jZFpwSxciQp
         o9AYd7WSpPswflvumS45tTQJKEYRALQUPKTYZ9gl9sVqeJVbe/VrFJtTCYmuYTiaUwIc
         X/u4B+S9zjUVHecLareYBtizDEw3ciY6/3NSD1qXvgjtFLMMKqxFP0ECFg0Fh5trtJJt
         JRvhhx4gJ3jjIw4Bo6B0+XzSseMoiO+EU3QdtdqGF4T81oC7E7HGPcLQHnu68/EMHLoV
         TZ9IxdwfeGjc69ba1kcu6HYvGWUKi46h2fHd1bhDOqxgd6uFn5aaF8HA2AIkLzxV9j/M
         ju+w==
X-Gm-Message-State: AOAM533HHrQTZ7lGIQ/Kq7XOnKwwy2x9E2UrXIXBxYACGRamSP+NborL
        g7P4KVfOZ6rFa0HNdz7ZCiQrYUJGEdUjXA==
X-Google-Smtp-Source: ABdhPJyeRwY6DbSBy7xC2uqamiH+xRo3qc0nHqy8QrRyDFBfxX2GPZIK0ZHMPGF6g3a5tgTquVwWtQ==
X-Received: by 2002:a17:90a:6f03:: with SMTP id d3mr7476157pjk.93.1629509813950;
        Fri, 20 Aug 2021 18:36:53 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:63b8:c1e5:7ba1:cab2:978b:f7f6])
        by smtp.gmail.com with ESMTPSA id j7sm4132257pjf.39.2021.08.20.18.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 18:36:53 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/2] t6300: check for cat-file exit status code
Date:   Sat, 21 Aug 2021 08:36:34 +0700
Message-Id: <83d532528bce7cb475833a504a244aa945fe048d.1629509531.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.33.0.254.g68ee769121
In-Reply-To: <cover.1629509530.git.congdanhqx@gmail.com>
References: <bcbde2e7364865ac16702447b863b8a725670428.1629200841.git.congdanhqx@gmail.com> <cover.1629509530.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In test_atom(), we're piping the output of cat-file to tail(1),
thus, losing its exit status.

Let's use a temporary file to preserve git exit status code.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---

 Junio wrote:

 > It is not wrong per-se, but do we need a redirect '<' here?  "tail"
 > takes filename(s) on the command line, but is there a reason to feed
 > the contents from the standard input?

 Well, no reason. In v1, I replaced the left hand side of pipe with <out,
 then in v2, I moved it to the end of command.

 Changed to not use shell redirection.

 t/t6300-for-each-ref.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 93126341b3..80679d5e12 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -66,7 +66,9 @@ test_atom() {
 			case $type in
 			tag)
 				# We cannot use $3 as it expects sanitize_pgp to run
-				expect=$(git cat-file tag $ref | tail -n +6 | wc -c) ;;
+				git cat-file tag $ref >out &&
+				expect=$(tail -n +6 out | wc -c) &&
+				rm -f out ;;
 			tree | blob)
 				expect="" ;;
 			commit)
-- 
2.33.0.254.g68ee769121

