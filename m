Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43C3C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 22:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjBFWot (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 17:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjBFWor (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 17:44:47 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB6F1A0
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 14:44:46 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so1468260wmb.5
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 14:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHzhfLFD5LQhaL6AdqGJMIaxpTSPwxTQbNXTWUYDmj0=;
        b=HXdn3EopiUq6R3oD4CHYWLwalowb/sQzug/+U6W7NDJY9XKuFyxP4ddO42BAj9xB4D
         2aStRCzB4bi7QJbvkMiUO1mJiErY3TqCSQaHT9lg6Z5Ut5sxrfj01ODJoK+qB4uI5jty
         qSM6EAvqfXLt7qycdSETF30RhBmBEMBcdYnEHTFp43ZRIIl4uN7anIn7ZgZ+2CDUgECD
         F8DSUj4wSWBG8cKSohgWrPHu4/uy48hlQHkpp5+26KpLpPxCAa7YXjcjUSm3Uinf68Ql
         CoNj6PGPaq2s7lDZUYo0lGSakUmd19w3a5YEdIzkN2RbLu6JWDs84Any25oJK3QeC11j
         cyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHzhfLFD5LQhaL6AdqGJMIaxpTSPwxTQbNXTWUYDmj0=;
        b=6A+aYJJlBcVc7FXo8NyE/gR0KZlVvGV/Lv2FoxwAKMPzTzb7R8JHWSQrAuV4dgivBK
         fhNYDYECnLxIAe9W3UpgQOOrgDlSKXd+AsdGIADmTtpJBYwV6ztWvSRzYmRc11X6iaTT
         RFWSjeKQx/5hswp5IxtKphH07UUTUaz1X1aYcy4IxiejxhTgr5dhq0eIYT5Dx7tbIJF6
         zDkFRm6EBCVPyF123kHAdjvZOKVXOu1tYyFAyHnmFKZwTG9W3EhYkf3eWYondeIIHIjf
         bVRbXw6pLIgUuVggJFkgYM0YE82MzArXOYti0C0hVqQl6uWECbnSLqMu0pbmi8frIuUe
         HX0Q==
X-Gm-Message-State: AO0yUKV3i7Cz6HtOe3UitSbuG54s0iVOaUVv3WrXoW5fEo3XMJU4xuPK
        X53VLLfmJIdvFlqeoMDnlha/S9tGrqasXHrC
X-Google-Smtp-Source: AK7set9Xrxf5zdybu1aBpRwROty2IF2GbdNfr2ELwOvfFK5ls/GAwv/IMc2KAcmhSKvzgnMjAKgGOw==
X-Received: by 2002:a05:600c:44c9:b0:3df:f9e9:7600 with SMTP id f9-20020a05600c44c900b003dff9e97600mr1176919wmo.25.1675723484454;
        Mon, 06 Feb 2023 14:44:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f7-20020a056000128700b002c3df9279f5sm6657643wrx.48.2023.02.06.14.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 14:44:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 2/6] t/lib-patch-mode.sh: fix ignored exit codes
Date:   Mon,  6 Feb 2023 23:44:29 +0100
Message-Id: <patch-v5-2.6-97f8b6a7b86-20230206T224200Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v5-0.6-00000000000-20230206T224200Z-avarab@gmail.com>
References: <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com> <cover-v5-0.6-00000000000-20230206T224200Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix code added in b319ef70a94 (Add a small patch-mode testing library,
2009-08-13) to use &&-chaining.

This avoids losing both the exit code of a "git" and the "cat"
processes.

This fixes cases where we'd have e.g. missed memory leaks under
SANITIZE=leak, this code doesn't leak now as far as I can tell, but I
discovered it while looking at leaks in related code.

For "verify_saved_head()" we could make use of "test_cmp_rev" with
some changes, but it uses "git rev-parse --verify", and this existing
test does not. I think it could safely use it, but let's avoid the
while-at-it change, and narrowly fix the exit code problem.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-patch-mode.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/t/lib-patch-mode.sh b/t/lib-patch-mode.sh
index cfd76bf987b..89ca1f78055 100644
--- a/t/lib-patch-mode.sh
+++ b/t/lib-patch-mode.sh
@@ -29,8 +29,12 @@ set_and_save_state () {
 
 # verify_state <path> <expected-worktree-content> <expected-index-content>
 verify_state () {
-	test "$(cat "$1")" = "$2" &&
-	test "$(git show :"$1")" = "$3"
+	echo "$2" >expect &&
+	test_cmp expect "$1" &&
+
+	echo "$3" >expect &&
+	git show :"$1" >actual &&
+	test_cmp expect actual
 }
 
 # verify_saved_state <path>
@@ -46,5 +50,6 @@ save_head () {
 }
 
 verify_saved_head () {
-	test "$(cat _head)" = "$(git rev-parse HEAD)"
+	git rev-parse HEAD >actual &&
+	test_cmp _head actual
 }
-- 
2.39.1.1425.gac85d95d48c

