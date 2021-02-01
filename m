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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDD0C433E6
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 14:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35DC764E9A
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 14:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhBAOzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbhBAOuV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 09:50:21 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EC5C0613D6
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 06:49:39 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i9so13437906wmq.1
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 06:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lqDlHSm0e0UOvWCkPR6uSLexzOsbwTLELExwWbUFXpk=;
        b=aT4XaHpX/bxxuKjHtCENyJVDwEedTTLSsNSfiIRUbaH97cHKlYZa1hRSG87A8CAVqg
         yxa+RtjxbIB6z6OEorASXyRlp+0lUKQFHmbs5tES0rapXSixyadnfZkd0BkPZj1DzLvy
         26Fkdt8xazwrCj4foRIXSNm6FB1qyPg6xhU26ou5ueKqRiVPPm42KwPyusR8xaY43TB2
         y68/cycidOOvYZNl/gX+ypwBr/kahxpXWwhdB0Zl9G8QMaikaZgvOzdhu1KU3zLEwz1M
         0la8uYiqtApzqh7RVHtck4QkfglYPTE2s1DJNjNUP+mxHLCH73UyaN4v5n++wDo4nkI2
         BhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lqDlHSm0e0UOvWCkPR6uSLexzOsbwTLELExwWbUFXpk=;
        b=QWve/yWmnxwSj73W0I65DOnR+ujowQHHQWid3nZqdoLoATgpFX+BGoByHD2R2c1hrN
         gYpfLQUQnYhsywaYcFVjZyvmxRe1PzsvcT3FtUMD3CNzNrR4bWXfZBvhmsYeZt8JXTb8
         CZQQ9P5VP0gf0DD3iEexWZQteR/RLEsNZ0U72z2DsVMzxWNTz/9M/mzVah4wbnFAyqDH
         VOFoKSd2IPBcy2UdBTV+C8a8evk3TF8sP5+xz8joLtERbhfENeFy5n4ej7h8rnwI2YxD
         lun7rKRh5p3WnKD5bd8M6S3e3DdPEOIuqWbrYJGMBFGkkQb4T5SJM6/j5KinIU0TFGvH
         TZdA==
X-Gm-Message-State: AOAM532PLxmTcGvBcrSs+EgEaCp3xppXLPNdHZnXzNGB2tJ4omOg3lsR
        S3afstXHhi/tfO6tk8qaSOunhKj/rGIsCg==
X-Google-Smtp-Source: ABdhPJy3JNYl8IQdZjINgP7OYqmvD3KOPl9n5MVdVp9/PSAt58grXyUWZDN3XJVuokR5qDBD3QhZFg==
X-Received: by 2002:a1c:4b19:: with SMTP id y25mr15442028wma.44.1612190978335;
        Mon, 01 Feb 2021 06:49:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k4sm28799954wrm.53.2021.02.01.06.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:49:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vincent Lefevre <vincent@vinc17.net>,
        Chris Torek <chris.torek@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] pager: test for exit code
Date:   Mon,  1 Feb 2021 15:49:19 +0100
Message-Id: <20210201144921.8664-2-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87im7cng42.fsf@evledraar.gmail.com>
References: <87im7cng42.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for how git behaves when the pager itself exits with
non-zero, as well as for us exiting with 141 when we're killed with
SIGPIPE due to the pager not consuming its output.

There is some recent discussion[1] about these semantics, but aside
from what we want to do in the future, we should have a test for the
current behavior.

This test construct is stolen from 7559a1be8a0 (unblock and unignore
SIGPIPE, 2014-09-18).

1. https://lore.kernel.org/git/87o8h4omqa.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7006-pager.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index fdb450e446a..c60886f43e6 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -656,4 +656,31 @@ test_expect_success TTY 'git tag with auto-columns ' '
 	test_cmp expect actual
 '
 
+test_expect_success TTY,!MINGW 'git returns SIGPIPE on early pager exit' '
+	test_when_finished "rm pager-used" &&
+	test_config core.pager ">pager-used; head -n 1; exit 0" &&
+
+	OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
+	test_match_signal 13 "$OUT" &&
+	test_path_is_file pager-used
+'
+
+test_expect_success TTY,!MINGW 'git returns SIGPIPE on early pager non-zero exit' '
+	test_when_finished "rm pager-used" &&
+	test_config core.pager ">pager-used; head -n 1; exit 1" &&
+
+	OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
+	test_match_signal 13 "$OUT" &&
+	test_path_is_file pager-used
+'
+
+test_expect_success TTY,!MINGW 'git discards pager non-zero exit' '
+	test_when_finished "rm pager-used" &&
+	test_config core.pager "wc >pager-used; exit 1" &&
+
+	OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
+	test "$OUT" -eq 0 &&
+	test_path_is_file pager-used
+'
+
 test_done
-- 
2.30.0.284.gd98b1dd5eaa7

