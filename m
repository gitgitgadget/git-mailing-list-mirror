Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2603CC433FE
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 19:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06A28610D0
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 19:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbhJVTio (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 15:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbhJVTii (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 15:38:38 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2ABCC061348
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 12:36:20 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id b189-20020a1c1bc6000000b0030da052dd4fso3277940wmb.3
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 12:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t65+C4evg6aB4+tR0LidQLSIjC4AnEo2Zfu5UMwO3gQ=;
        b=AajWMQlGN60vTwqUhEtODnbpFFcpZZevWeWJzCX7RjFLuj6YNuDOtZiCdd3RwGcwFk
         eiBo2TkONbU5BzYdgBY7o/cfNKj1vLyWef7/gGNRk3l4c5F2Sk8LIT6cVtUY1l02XVZG
         tBDpscglgW8YP6AfbtTeDrA4tzDmQ9ESnfEi6CujYk96NaayExxgx4xHsNJwCTvlEeAL
         g6Z5ANkwP4kM8baCxE0b0XR++1fde7DVYZrR1mRWDRmbi+FTRwKiBhW9P6MpygQm3lqo
         n3XNZUgYvDyjMsNPgcSbCx7PeeiWxHkEAIoGXAwtLPqc7EVPCFsi4WsAdkSsiConbWHA
         v0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t65+C4evg6aB4+tR0LidQLSIjC4AnEo2Zfu5UMwO3gQ=;
        b=dlX4vl2E+26cF1Oqpxu1SwKie8K8U3ubFNLzwTTCQG6qM4AGguvELiM65JRwRTcHH3
         o0/1ami3O10Xst6v4rZCzzjlXXdOAxlIWVOvBR7ITWbegvWfUhSgsnu4hOfzl+sIzhmU
         czmJm0HTxWXTdkxMF/I82Bzk+RHzJs+EfE1+28A5f/HkAvKlvkqyN1UYoJrgSs5WCCWi
         gybtLc/h0wmqhEoiizH5eA7PSVz4YJXM+poTdMraDjKHYRkY/SaD31I5grGzJDaXqiDw
         reXHwY3mS+JiavCVDA3RXlqLTsgLkpKj4JUAof3sCZkbrEGn7ZkW9+QKUv58a6Y+95Iy
         uPyQ==
X-Gm-Message-State: AOAM532xu/FTJkgIVcnIj5Rc5rQY9ihgIZEZz1YRBI+y6e1w87R6JoYM
        RNdhp1HQXmomKaQqLW0Vr444mWo/ec0TbQ==
X-Google-Smtp-Source: ABdhPJzLgUnuoqOV6fdVuyCAKg4nqT+lWXKjLEjkq2AG1PyM5uZDKYNZCMV8X1VVBrmxWJDKmC3Muw==
X-Received: by 2002:a7b:c199:: with SMTP id y25mr1784213wmi.55.1634931379283;
        Fri, 22 Oct 2021 12:36:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7sm8871814wrs.73.2021.10.22.12.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 12:36:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/10] generate-cmdlist.sh: spawn fewer processes
Date:   Fri, 22 Oct 2021 21:36:07 +0200
Message-Id: <patch-v2-03.10-6b4de6a6088-20211022T193027Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1505.g075a284c562
In-Reply-To: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Sixt <j6t@kdbg.org>

The function get_categories() is invoked in a loop over all commands.
As it runs several processes, this takes an awful lot of time on
Windows. To reduce the number of processes, move the process that
filters empty lines to the other invoker of the function, where it is
needed. The invocation of get_categories() in the loop does not need
the empty line filtered away because the result is word-split by the
shell, which eliminates the empty line automatically.

Furthermore, use sort -u instead of sort | uniq to remove yet another
process.

[Ævar: on Linux this seems to speed things up a bit, although with
hyperfine(1) the results are fuzzy enough to land within the
confidence interval]:

$ git show HEAD~:generate-cmdlist.sh >generate-cmdlist.sh.old
$ hyperfine --warmup 1 -L s ,.old -p 'make clean' 'sh generate-cmdlist.sh{s} command-list.txt'
Benchmark #1: sh generate-cmdlist.sh command-list.txt
  Time (mean ± σ):     371.3 ms ±  64.2 ms    [User: 430.4 ms, System: 72.5 ms]
  Range (min … max):   320.5 ms … 517.7 ms    10 runs

Benchmark #2: sh generate-cmdlist.sh.old command-list.txt
  Time (mean ± σ):     489.9 ms ± 185.4 ms    [User: 724.7 ms, System: 141.3 ms]
  Range (min … max):   346.0 ms … 885.3 ms    10 runs

Summary
  'sh generate-cmdlist.sh command-list.txt' ran
    1.32 ± 0.55 times faster than 'sh generate-cmdlist.sh.old command-list.txt'

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 generate-cmdlist.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 5114f46680a..27367915611 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -11,15 +11,14 @@ command_list () {
 
 get_categories () {
 	tr ' ' '\012' |
-	grep -v '^$' |
-	sort |
-	uniq
+	LC_ALL=C sort -u
 }
 
 category_list () {
 	command_list "$1" |
 	cut -c 40- |
-	get_categories
+	get_categories |
+	grep -v '^$'
 }
 
 get_synopsis () {
-- 
2.33.1.1505.g075a284c562

