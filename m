Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FED7C3A5A7
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 00:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiLBAHZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiLBAHV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 19:07:21 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A142C510B
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 16:07:20 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id b8so4429071edf.11
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 16:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiDj4plKWqRG0LssvoPX7cJ4xT5nzbpj7tZNNg16sAs=;
        b=IB5gEFRzWIfgjPjatweLiO/FZpjuh9fGIL44BiLYJH2Idq6cUF69rq1wZmAVZrnbeh
         traUz1QD65SaVXqq3LY1ZVM0+2x+wM/OIX2S4Hcw35Ca5L5JR5Q27RFLPE5FsrT8QDCC
         +XT63EjKsqJlWdxOlTtCsNxruCm/bYbbgFNQ1ZpXvFL6/CT6TR68sbFEdriU9DpS6aAC
         zAFgyylv6r327mfWnejlRpb1qUxGuP2SzL1VbrQ/nuzrflXCFxSEqRBUGbrnBhfUZ59i
         Yw7mY6kfKb246ya/lKbt5oXdDOgVsLtSfXOoybeERzaTnudFVEZ6ZYSuR9hEDfW2TQQD
         bOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiDj4plKWqRG0LssvoPX7cJ4xT5nzbpj7tZNNg16sAs=;
        b=Ne68DhzWybviXwkefhyfESIgGq6t28j1vXUm+YdHUZIaaxVRjP/Q07c5zee92v3Jh8
         MqAAI9WVmAiTqRiaq3u1hgVYaS4keZt4y9SNxb0J2gwaKwv/OZdMMJk+2JmjGRfz3msK
         u521I4ymydyzT9xIykLoSWcnLd6uVAZCDhC/bPeKXW4AUe36mTx33O1iRMV2dDx6Di1Y
         Gl0AK21RYOc1vq4cvBgDDsiD/SzHtPF7P8BR7O+MNy83pQbPkzCe7C+U3KPNE7UgV0qb
         UD2VBJNul3FaXwUNBnWVUag0I5AoRdVuEjQvTqFHgchOsKVYPB3jacAMWr2hsdWNpR7m
         2rwQ==
X-Gm-Message-State: ANoB5pkQ5W2gF3nrN/PDLJ4nUR1IEkWc1tDv9xkCuHBT1UgwINmW66gN
        6ZxFAhwuJhV9UZ5/38B3QGPnky3+UvHlow==
X-Google-Smtp-Source: AA0mqf6Pw3D7/6jP/HqTGNRjDRfe7lBjZRYQ0xeaZTHiUOkqSTB50jYAgpE+8hGcQKpP0PVESa+ReQ==
X-Received: by 2002:aa7:d912:0:b0:46b:2b37:ffa9 with SMTP id a18-20020aa7d912000000b0046b2b37ffa9mr19123502edr.79.1669939638836;
        Thu, 01 Dec 2022 16:07:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ex19-20020a170907955300b007be4d8a50d8sm2351576ejc.70.2022.12.01.16.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:07:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/8] log tests: don't use "exit 1" outside a sub-shell
Date:   Fri,  2 Dec 2022 01:06:27 +0100
Message-Id: <patch-v2-1.8-7c9f8d2830f-20221202T000227Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.980.g92d3d4579ad
In-Reply-To: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change an "exit 1" added in ac52d9410e5 (t4205: cover `git log
--reflog -z` blindspot, 2019-11-19) to use "return 1" instead, which
curiously was done in an adjacent test case added in the same commit.

Using "exit 1" outside a sub-shell will cause the test framework
itself to exit on failure, which isn't what we want to do here.

This issue was spotted with the in-flight
"GIT_TEST_PASSING_SANITIZE_LEAK=check" test mode[1]. This "git show"
invocation currently leaks memory, and we'd thus "exit 1". This change
was initially part of that topic[2] to demonstrate the correctness of
the "check" implementation.

1. https://lore.kernel.org/git/patch-07.10-0961df2ab6c-20220719T205710Z-avarab@gmail.com/
2. https://lore.kernel.org/git/patch-10.10-9cedf0cb0e2-20220719T205710Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index e448ef2928a..0404491d6ee 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -156,7 +156,7 @@ test_expect_success 'NUL termination with --reflog --pretty=oneline' '
 	for r in $revs
 	do
 		git show -s --pretty=oneline "$r" >raw &&
-		cat raw | lf_to_nul || exit 1
+		cat raw | lf_to_nul || return 1
 	done >expect &&
 	# the trailing NUL is already produced so we do not need to
 	# output another one
-- 
2.39.0.rc1.980.g92d3d4579ad

