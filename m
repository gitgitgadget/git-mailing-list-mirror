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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5CAC433E6
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5689664ECE
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhBBCAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 21:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhBBCAv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 21:00:51 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6691C061756
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 18:00:10 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o5so982483wmq.2
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 18:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R3kD/EzUeu/fddC2hA4m1E6jDB/3uXoxSeVW6gj6Dt4=;
        b=mY4wLbMhNu6GPZZzGtBCr2YqGN8BxqONyUYa2ti7ZtGf8cIZn/EIS5XAzi8nun0dll
         ou3zvJEOkzioGoLrZzPohHspqFM0qTEIcVc9oQWaEGVVGEkDVszJA2RKBnyPCuEpDdyR
         qTrKS59vloBj+5WHa/rJjFBQGqbForYhygCVFUUHiZZPf9qmEbUME1D0GGKXRi0f6A6p
         LyZY+1Iv8u3vm1LVva8pO0ItCS34eUn+f3LG3S7AkS6dfiU41G35Ltxi4pJ7FJ4WXZ7n
         8K0FpntaZdVyR7wdVNk6wJ+7ZP84U0VTMyAmCHbWONQpsw7okihAZIpUKj2ax5FVXfMb
         T0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R3kD/EzUeu/fddC2hA4m1E6jDB/3uXoxSeVW6gj6Dt4=;
        b=apnZWWbdPLtf5EEWHzX6MqNjXuoXgR8+/5dkYQOnDeVtz9QA0eu1wCMyE/zm5y39OF
         GmldeqZ4njGc2k19IwqcWFuz1spFG9rhWz1rx4Loo/R5THDC4YNdsMocx90+NHzaq5p6
         chFXrnUEPmSml1VmSpftReCaT60ZR98C3V16bSYfpFx16kdRavGWUrSVb8GEXAXwAzHr
         HLJRxI+v7KiTQKe1iUlnpY4ONSGwaClthZmL2AK3GD4Vsk/QBrktRXRKIlFtV0KCDw6j
         E5vjzr45K3qHfvRJX2AqHq53a5VKCkKbEDpeh1Alz3XEQ1P/6gu+HWTdYKehWuhMb/Uf
         Kvxw==
X-Gm-Message-State: AOAM532VhSaQA6gaxrscT6urRJBIa/y5sFcxEqyyykXpQEv/0Rfs5Eq9
        UqWyqQv5/zkzLJtfFhHx0g/ZOf91AJe/4A==
X-Google-Smtp-Source: ABdhPJxYslo9JDsfCADSCzhtxyMsxM6vG6+JoKKHx0X0D/85UgP1dS3K4juHxjOXiVNLHo0tVkoQdQ==
X-Received: by 2002:a05:600c:2888:: with SMTP id g8mr1347948wmd.169.1612231209284;
        Mon, 01 Feb 2021 18:00:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y24sm986175wmi.47.2021.02.01.18.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 18:00:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vincent Lefevre <vincent@vinc17.net>,
        Chris Torek <chris.torek@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/5] pager: test for exit code with and without SIGPIPE
Date:   Tue,  2 Feb 2021 02:59:58 +0100
Message-Id: <20210202020001.31601-3-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210201144921.8664-1-avarab@gmail.com>
References: <20210201144921.8664-1-avarab@gmail.com>
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
SIGPIPE, 2014-09-18). The reason not to make the test itself depend on
the MINGW prerequisite is to make a subsequent commit easier to read.

1. https://lore.kernel.org/git/87o8h4omqa.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7006-pager.sh | 82 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index fdb450e446a..0aa030962b1 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -656,4 +656,86 @@ test_expect_success TTY 'git tag with auto-columns ' '
 	test_cmp expect actual
 '
 
+test_expect_success TTY 'git returns SIGPIPE on early pager exit' '
+	test_when_finished "rm pager-used" &&
+	test_config core.pager ">pager-used; head -n 1; exit 0" &&
+
+	if test_have_prereq !MINGW
+	then
+		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
+		test_match_signal 13 "$OUT"
+	else
+		test_terminal git log
+	fi &&
+	test_path_is_file pager-used
+'
+
+test_expect_success TTY 'git returns SIGPIPE on early pager non-zero exit' '
+	test_when_finished "rm pager-used" &&
+	test_config core.pager ">pager-used; head -n 1; exit 1" &&
+
+	if test_have_prereq !MINGW
+	then
+		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
+		test_match_signal 13 "$OUT"
+	else
+		test_terminal git log
+	fi &&
+	test_path_is_file pager-used
+'
+
+test_expect_success TTY 'git discards pager non-zero exit without SIGPIPE' '
+	test_when_finished "rm pager-used" &&
+	test_config core.pager "wc >pager-used; exit 1" &&
+
+	if test_have_prereq !MINGW
+	then
+		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
+		test "$OUT" -eq 0
+	else
+		test_terminal git log
+	fi &&
+	test_path_is_file pager-used
+'
+
+test_expect_success TTY 'git discards nonexisting pager without SIGPIPE' '
+	test_when_finished "rm pager-used" &&
+	test_config core.pager "wc >pager-used; does-not-exist" &&
+
+	if test_have_prereq !MINGW
+	then
+		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
+		test "$OUT" -eq 0
+	else
+		test_terminal git log
+	fi &&
+	test_path_is_file pager-used
+'
+
+test_expect_success TTY 'git attempts to page to nonexisting pager command, gets SIGPIPE' '
+	test_config core.pager "does-not-exist" &&
+
+	if test_have_prereq !MINGW
+	then
+		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
+		test_match_signal 13 "$OUT"
+	else
+		test_terminal git log
+	fi
+'
+
+test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
+	test_when_finished "rm pager-used" &&
+	test_config core.pager ">pager-used; test-tool sigchain" &&
+
+	if test_have_prereq !MINGW
+	then
+		OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
+		test_match_signal 13 "$OUT"
+	else
+		test_terminal git log
+	fi &&
+	test_path_is_file pager-used
+'
+
 test_done
-- 
2.30.0.284.gd98b1dd5eaa7

