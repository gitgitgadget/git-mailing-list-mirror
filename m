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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C67C4320E
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 13:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBEBA61050
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 13:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhHBNqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 09:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbhHBNqn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 09:46:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5F7C06179B
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 06:46:33 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id x17so4203997wmc.5
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 06:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GQkDry9InACxMMU4eyG6NHpTJZS7r3kq8zr72Q3ImOM=;
        b=NdCvWnqGcpuGTDlWlKkBnGWVsW+okhgprxsKq0o77QsWwyGGn57NJBk5nBZB+ys+U6
         j6sDTJyqVIpYkQuPOIPNy8TkYb0LNxeHVcsfs/ZxozCxGgTR071jMa+roRZw8mSm2YZg
         pdY3OIMb/lVIcQHFjC/BQmAl+8M9jqWwt8twQr1zLbnM9vaKwt39qth1D7/EGmgSh84a
         IDYdATPhBZldWbfW/hApX/J47Td77n4xoENEwdfKJ7nUWL8DHGo9BWsXtW6PjSRP+g3b
         r+AQpyWagAJhxBd8jf3oehro27TQ8qKnxq1pgc3yZZngzHs18WdZj6BWEZapm+F/2vS4
         XN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GQkDry9InACxMMU4eyG6NHpTJZS7r3kq8zr72Q3ImOM=;
        b=iXq2oQFI35Ul4HZ9xZ/agkB2fkvCQE38gYudAkRI/KMuv47BGBoSO+LdzjlmwCzxk0
         YmGD6W5p7wWFHz7R20eMjNi3GXAMEAU0RDIarFXgZGAjDUqtzdpVDlpMSeb/i4G1R4AS
         vU2ucu+ocgNrSKb49X4e1RjMWIo1OtmUraquRBpoIWu7FeVYdWJ1lpAyG8Ay0Pp0xM8Z
         j/oDdzm/003oYofgpFIwk6+lrOa5G6bh+UTfDynJJkY5eq6xVmLlo6LHZR9P5q9trVwY
         GM4qZSwcnOTplEeaEf/GsT2VKXt6+7sqtq3Zc4O6fX/YhK0jmUZtdyC1nnfz9B5H5VVT
         qToQ==
X-Gm-Message-State: AOAM532moEgVf5k/CE6a//2vZoIygzwwhPodi+nxyjF5bHW9wxwMVz/Q
        rjs2di79w6zduluN1ncZPppzFycObSZgZQ==
X-Google-Smtp-Source: ABdhPJyGwDFtoXo6uj9SuEvv+EANr1rde+5rz+2VLzwYoqBvk50I3IsowyRSm8HhwK6SPhDFI3DpnQ==
X-Received: by 2002:a05:600c:1c1f:: with SMTP id j31mr16835792wms.132.1627911991464;
        Mon, 02 Aug 2021 06:46:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b14sm11549003wrm.43.2021.08.02.06.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 06:46:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Fabian Stelzer <fabian.stelzer@campoint.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/3] test-lib-functions.sh: rename test_must_fail_acceptable()
Date:   Mon,  2 Aug 2021 15:46:26 +0200
Message-Id: <patch-v2-1.3-739457b992f-20210802T134610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.1070.gec115ccd780
In-Reply-To: <cover-v2-0.3-00000000000-20210802T134610Z-avarab@gmail.com>
References: <patch-1.1-f81f3911d5-20210726T235452Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20210802T134610Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail_acceptable() is really a generic function that can
check if something is a real "git command", e.g. "git", "test-tool"
etc. Let's rename it in preparation for using it in another test
function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index e28411bb75a..37da7d9a99a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -895,7 +895,7 @@ list_contains () {
 # accepted by test_must_fail(). If the command is run with env, the env
 # and its corresponding variable settings will be stripped before we
 # test the command being run.
-test_must_fail_acceptable () {
+is_git_command_name () {
 	if test "$1" = "env"
 	then
 		shift
@@ -943,7 +943,7 @@ test_must_fail_acceptable () {
 #     (Don't use 'success', use 'test_might_fail' instead.)
 #
 # Do not use this to run anything but "git" and other specific testable
-# commands (see test_must_fail_acceptable()).  We are not in the
+# commands (see is_git_command_name()).  We are not in the
 # business of vetting system supplied commands -- in other words, this
 # is wrong:
 #
@@ -963,7 +963,7 @@ test_must_fail () {
 		_test_ok=
 		;;
 	esac
-	if ! test_must_fail_acceptable "$@"
+	if ! is_git_command_name "$@"
 	then
 		echo >&7 "test_must_fail: only 'git' is allowed: $*"
 		return 1
-- 
2.32.0.1070.gec115ccd780

