Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAEDC47088
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 11:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiLBLyJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiLBLxl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 06:53:41 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BADD9B0D
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 03:53:09 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id b2so10995627eja.7
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 03:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAiSUBKxQ3Bylc6B68UkXOP6jbmOaBhpyRPzluogRSE=;
        b=KzmJLZs9drny8zXyyFp1AJ7tWh+gRTOepnnuIuLa+AEQ+4QPMEDV6VO/bRQUvj4O07
         0i4AWh5wcNWWxZ0QlZhCItMKqy7vS9PF9L20OpB9Qjn3zEsmeQ28oBM0lrGvlK8OHHAr
         gCILL6+8/WyTQAsJ1BxgFyRdJqbNlP1p1hZEuQg4H6Gy7s3I7AnOzSD1StD5ZlCIi4aq
         uC3wUamEEbygRU3vSG09kEX/3joLXKaR1w4EJAutcYSsw9Tvla7Mw/UbessAwoii7xiD
         +03k9RXqXX5+SdyuCEFHxsSUZJr31imOal+qq+kuVDw+3kDo/Gy2JQgbF2ph/0zPtXFP
         l1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAiSUBKxQ3Bylc6B68UkXOP6jbmOaBhpyRPzluogRSE=;
        b=ssAzkytPZaYKX54pvsjQNLIKcp7YYgpy3qJDbGiAuQrZyrDKt6m53YtTkOu28D7wik
         qmfMWphDJiFn+L5jr+rkOmhcUMigSeOgyu8Bx88Q2BYk/wOCAepgAR3tysCnEXdbm234
         IjuJjODS3Y1iyBR68MxGhqKzrJHq0zOOZ7mwRBTR8ABe7gsLsRn4Urb+VI5kO9gDgN6t
         cXlVuLGyc6ggQbdWfIdjyWpw91tYSQ9mWrsmSAuz2nnKeUGkYtaxPD+AwS8CUTf/Id0q
         3Edp2J29BZwD6b3sunK+Jvl6BTMZ0+rRP9FK6Z3+YVvOfk6T/61KrvKPkHDWTzgEGB7y
         8Frg==
X-Gm-Message-State: ANoB5pmJyUI3sLtuElkMC2mPvsPo99nOXVkZrDrYFBdAQj1ipWdmOJpL
        DuSbxIrp1dtVxeKg67JwLKKPqn7b2i/gpA==
X-Google-Smtp-Source: AA0mqf5TB67wAQl9GhU/hA1/NwMU5SijF2f0xK+ZJ35EVXvMAT83QA22/HzTKMtiulbDIE/4CojAXg==
X-Received: by 2002:a17:906:3da2:b0:7ac:a2b7:6c96 with SMTP id y2-20020a1709063da200b007aca2b76c96mr57790504ejh.412.1669981988886;
        Fri, 02 Dec 2022 03:53:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q20-20020aa7da94000000b00458947539desm2833754eds.78.2022.12.02.03.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:53:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/8] t/lib-patch-mode.sh: fix ignored exit codes
Date:   Fri,  2 Dec 2022 12:52:37 +0100
Message-Id: <patch-v3-4.8-c080899dd5f-20221202T114733Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.981.gf846af54b4b
In-Reply-To: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix code added in b319ef70a94 (Add a small patch-mode testing library,
2009-08-13) to use &&-chaining and the newly added "test_cmp_cmd".
This avoids losing both the exit code of a "git" and the "cat"
processes.

This fixes cases where we'd have e.g. missed memory leaks under
SANITIZE=leak, this code doesn't leak now as far as I can tell, but I
discovered it while looking at leaks in related code.

The "cat _head >expect" here is redundant, we could simply give
"_head" to "test_cmp", but let's be consistent in using the "expect"
and "actual" names for clarity.

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
2.39.0.rc1.981.gf846af54b4b

