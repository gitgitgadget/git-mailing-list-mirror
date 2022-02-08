Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB885C433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 11:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376423AbiBHLcY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 06:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357061AbiBHLV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 06:21:59 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80074C03FECA
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 03:21:58 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id k18so30076147wrg.11
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 03:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=onCw496qxEGIYlKeL4ualhEcXJGdOJoVv6Y9YtBgwOU=;
        b=gSBJotl09AWyxCtvvt5zVOWQRZEUf4E+7yeP3OgRuqeLKjNHGgaRzNx3lnvrmteWMd
         k/qtgrls27h01aixEWBOl2FXPwIPQNUWZoqi5z7B3CC/Hh23cq1H7whJic2SgGKymCO8
         YgjQUHUt/wZY8EKC2jpTiwWdUrP+bmWpJuOv1MglIha2i2o6T7uhJk2ir0B2fFmpRIrq
         skjkxkilGdNq26fbQd7p+EONnCspX3OjDta1PTMd9beLcWjoEJEOjAKeBNyNqNly7FRO
         3Bw6+z/BmAMttqJnc3isEOlrqPCxY0T1XxiCBCyIwrGDuNzN0msYoxqPM2OWGBZjxOnO
         efgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=onCw496qxEGIYlKeL4ualhEcXJGdOJoVv6Y9YtBgwOU=;
        b=0DwRecUfqmq5EQYU8v7ANT4CD4z6i4dxFPPJgJ3k4TsGVXvDA2B7avdYcbkKzChPRa
         sM7jWD5vrPaO8DksL30QelAsxSAN3LF+yjxZIsZkZhWcrYJYY+zPWiNcdx4+c/BKvmNk
         F28AfvrgiOyjO5vZxG6V3q+fyebvupFVd8+8YLRQOvKALIfNJPhKotdqpj7zA7YB6OHM
         pqJnZhyNJvnQXFtpfxtd9K3IQ2cdnRroaUaJGtXbpTr0Bg/d8r4+cEQp07Zzd+N3wrt+
         2WDpfFM5VfpLGpUMD49EEujqw22dmG9rG6LqkZ36IuiGDK8wEVJdkDXPgKxJqpunNwn8
         4s6w==
X-Gm-Message-State: AOAM531T/VEJXwW6jzrI3iUl7BUym7aPorEiXWJkaXqE6Ygrm1DrcFOo
        vIX5Rcqe7VuA+STuX97vCZ0DRx6AGT8=
X-Google-Smtp-Source: ABdhPJxEsF1XwcltT6NyiXANh/SzoA6hnFYCaG7trt8lw7IODlKNhZyuRDVous1EHvhzh5UhnHvXJg==
X-Received: by 2002:a05:6000:3c1:: with SMTP id b1mr3188318wrg.14.1644319316949;
        Tue, 08 Feb 2022 03:21:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j15sm2255158wmq.19.2022.02.08.03.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 03:21:56 -0800 (PST)
Message-Id: <93df4a73dab44502eddfffd363622bf7016aaa4d.1644319314.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1139.v2.git.1644319314.gitgitgadget@gmail.com>
References: <pull.1139.git.1644277797.gitgitgadget@gmail.com>
        <pull.1139.v2.git.1644319314.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Feb 2022 11:21:54 +0000
Subject: [PATCH v2 2/2] t0012: verify that built-ins handle `-h` even without
 gitdir
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We just fixed a class of recently introduced bugs where calling, say,
`git fetch -h` outside a repository would not show the usage but instead
show an ugly `BUG` message.

Let's verify that this does not regress anymore.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0012-help.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 91b68c74a15..cbd725ccac8 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -139,13 +139,18 @@ test_expect_success 'git help --config-sections-for-completion' '
 '
 
 test_expect_success 'generate builtin list' '
+	mkdir -p sub &&
 	git --list-cmds=builtins >builtins
 '
 
 while read builtin
 do
 	test_expect_success "$builtin can handle -h" '
-		test_expect_code 129 git $builtin -h >output 2>&1 &&
+		(
+			GIT_CEILING_DIRECTORIES=$(pwd) &&
+			export GIT_CEILING_DIRECTORIES &&
+			test_expect_code 129 git -C sub $builtin -h >output 2>&1
+		) &&
 		test_i18ngrep usage output
 	'
 done <builtins
-- 
gitgitgadget
