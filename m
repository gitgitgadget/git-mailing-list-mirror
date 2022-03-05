Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6239C433EF
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 00:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiCEAQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 19:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiCEAQN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 19:16:13 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A770E27C78C
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 16:15:15 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id v4-20020a63f844000000b003745fd0919aso5287863pgj.20
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 16:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6LHfocVCl0x5QxdLkS1NpmZZntUa5PvWBsf0u+hjqLM=;
        b=FJMNIjjptwKhdPvnWIgtwk5wYY5tbTCf7M/9QblXbW0BmxFM9rBSfs5VTlw59Z/PTR
         GThd/VEu0sbLGZT6byHi28BGoOctl4FvZaToqn5bjGMKqpdb0KJz4gaQiZ0ZjUkNtEG4
         +ni5bIbDHP3kex+86kvqOniwd9s7r83TkvLkznUc5rKfnkmIMyticXxg1TCntLNkspnW
         yuphL54yPLt5a72RsqJ4+yjkmiayb3TgzgrXOVK8PmmE/x6dmLFI0UL8mXFQaOhbX+qf
         TuvGq1meYs/TvbRLTqLluzsVubk/pJntCBwMBqZODGG1mimdx3sS0P5cnH6/96XGBTeM
         p7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6LHfocVCl0x5QxdLkS1NpmZZntUa5PvWBsf0u+hjqLM=;
        b=CNF0geW1isIsqYNQsm/+dgQRQRH9U3Sna8UgDsQesNvMLvVmgBqBVS5NKQyJam9hnd
         Btna/A2LG/W/gWeIHX97VMvXCS+QdgxEhtph93pe9XM7VFU6wWN0R8ouy1pUIJIPm/ST
         stwfcR/A0KwlqGbsQZ/Bw9yhSKbz4vugLp/cXkkXQx22tgmuN5uXHu7Jfvj4taGc6QAc
         WrPBZJluKrqNJtisutVyUkbFhRKNmkDs+5vBplP0wNioM40Lh2tvUUsNQejrJmVMmY0i
         dHwR1Fb6d3MJs27jdMWqKFIGZD9vPyYbam9C1AnD4q5hstPhXinsaypY0JUtTW8yc/rk
         aoRg==
X-Gm-Message-State: AOAM5334MST7OyHXmUtJZnt9PO1pOYLGto95J8rZFapZ4HgSTiAewqkt
        ia0ULoil5Bwx2VjXpPMfRGvXPrUjLG4XlM/6tvbXdIVPZdSFL0BVV2gbprjl4UxZL9R/JdjBZFP
        9MpqMRuR+UjbIeR+VvgGCrOFmka3EUVVruUcwmnB5aBEAsiTPniGHMR/HjK8//9M=
X-Google-Smtp-Source: ABdhPJy7g1PDvJITIoP3lvbz/BKxi35wjLbDf4DcIrU78GFXNPL5EBIa/qla7pR2SjKXhxji2yIlQaITEehTyQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:8e85:b0:1bc:429b:513d with SMTP
 id f5-20020a17090a8e8500b001bc429b513dmr13203970pjo.11.1646439315143; Fri, 04
 Mar 2022 16:15:15 -0800 (PST)
Date:   Fri,  4 Mar 2022 16:14:00 -0800
In-Reply-To: <20220305001401.20888-1-chooglen@google.com>
Message-Id: <20220305001401.20888-13-chooglen@google.com>
Mime-Version: 1.0
References: <20220303005727.69270-1-chooglen@google.com> <20220305001401.20888-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v4 12/13] submodule update: add tests for --filter
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test the "--filter" option to make sure we don't break anything while
refactoring "git submodule update".

Signed-off-by: Glen Choo <chooglen@google.com>
---
 t/t7406-submodule-update.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 7764c1c3cb..000e055811 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1071,4 +1071,16 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
 	)
 '
 
+test_expect_success 'submodule update --filter requires --init' '
+	test_expect_code 129 git -C super submodule update --filter blob:none
+'
+
+test_expect_success 'submodule update --filter sets partial clone settings' '
+	test_when_finished "rm -rf super-filter" &&
+	git clone cloned super-filter &&
+	git -C super-filter submodule update --init --filter blob:none &&
+	test_cmp_config -C super-filter/submodule true remote.origin.promisor &&
+	test_cmp_config -C super-filter/submodule blob:none remote.origin.partialclonefilter
+'
+
 test_done
-- 
2.33.GIT

