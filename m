Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5769DC433FE
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 01:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E127611F2
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 01:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhKJBqt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 20:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhKJBqp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 20:46:45 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1BAC061766
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 17:43:58 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x15so4062588edv.1
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 17:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mqRMt6KaGEScXIBjp+/xKo1c8g5Yjh+NMPSRiI+phhw=;
        b=AWgvMKIOPx+3cs8/yenz+1r1n5hTyoN3/N9eaH55HMwpudDc7cTrgAyknf2gRyH2Od
         kjPH3DQuMihXoKaoSYKCYNGCRV/+0brAbN3Mvurz3LiTXjziLHbduqqGFqjvYdMhrXix
         Si5rvIkCYZR3V/ihHapnUxrZfkEA0n6nD4JKPppzhYz+f3ohudZdMhcL6cD0w3FbmFkq
         /AHzNyD/GfAQPvU6xvu80AWZQqygulxa5Mmk23w3pvcmOog4jtwSdtkvhuGFwLMJWJ4H
         vepOG64R2UinXn0BQD2fJQPu16qMjV+i+nSjiZ3f5qTgCL+tkE5+OkB9ZlVCpVal4FHV
         duEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mqRMt6KaGEScXIBjp+/xKo1c8g5Yjh+NMPSRiI+phhw=;
        b=eGLTMbn1GvY5jTAsWxK7dPtpH6JEipyryo0PXS8J1poZSX628tqogOSYl4sAQX9TSo
         +ITWbqAzkL/9SFE4fon3WuYR7kyHhVQl994NuscnAdkhzFGQHOHYPX01jlF+PKcoTIIn
         P9uA3uvwdhWx/mJXRzcSKGSoa4jIi6M4xEvupxcyUMej1uRuMZQSFEUH89qacWYAYZBk
         i69M3Bpm1WQDLPirMFVTdVBZ1qHwW7xPlDikQqt0btvNwORwRuJUSKhW2qpwSPwGbzM9
         frvhUsN8KM41SZ58pHmr9KYuK8994wD81qqVcy++2UfKMl34WscaE9BHZnpCWb/xbmqH
         fVRg==
X-Gm-Message-State: AOAM531g+ZvOVzt2Tu4gdvB0RRbYYtMIfWut9TgzpTHyO9Hh4BeGYaBu
        MRlxqsSGhIqeGOel5jheB1+jw7lahbcQQg==
X-Google-Smtp-Source: ABdhPJwDC1VprpJiL/1CFvE121eWDC1kOsj+19y7fjrNcKHZg0P1Lfzee6DpE+IpYZSWU4Yn2ldJdg==
X-Received: by 2002:a17:907:8a1a:: with SMTP id sc26mr15824519ejc.402.1636508636605;
        Tue, 09 Nov 2021 17:43:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id qf8sm9369252ejc.8.2021.11.09.17.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 17:43:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/8] log tests: check if grep_config() is called by "log"-like cmds
Date:   Wed, 10 Nov 2021 02:43:45 +0100
Message-Id: <patch-v2-3.8-41e38ebb32c-20211110T013632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.791.gdbfcf909579
In-Reply-To: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the tests added in my 9df46763ef1 (log: add exhaustive tests
for pattern style options & config, 2017-05-20) to check not only
whether "git log" handles "grep.patternType", but also "git show"
etc.

It's sufficient to check whether a PCRE regex matches for the purposes
of this test, we otherwise assume that it's running the same code as
"git log", whose behavior is tested more exhaustively by test added in
9df46763ef1e.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4202-log.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 7884e3d46b3..a114c49ef27 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -449,6 +449,22 @@ test_expect_success !FAIL_PREREQS 'log with various grep.patternType configurati
 	)
 '
 
+for cmd in show whatchanged reflog format-patch
+do
+	myarg=
+	if test "$cmd" = "format-patch"
+	then
+		myarg="HEAD~.."
+	fi
+
+	test_expect_success PCRE "$cmd: understands grep.patternType=perl, like 'log'" '
+		git -c grep.patternType=fixed -C pattern-type $cmd --grep="1(?=\|2)" $myarg >actual &&
+		test_must_be_empty actual &&
+		git -c grep.patternType=perl -C pattern-type $cmd --grep="1(?=\|2)" $myarg >actual &&
+		test_file_not_empty actual
+	'
+done
+
 test_expect_success 'log --author' '
 	cat >expect <<-\EOF &&
 	Author: <BOLD;RED>A U<RESET> Thor <author@example.com>
-- 
2.34.0.rc1.741.gab7bfd97031

