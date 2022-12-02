Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82ABC3A5A7
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 00:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiLBAHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiLBAHX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 19:07:23 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5983C5131
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 16:07:22 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id vp12so8007905ejc.8
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 16:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPI0sif6GzBdqYmgsWbjnVcekwkTGNvkhzObfJYnMJM=;
        b=kF7SfbIaN1rR4WsV1G9smVh37wFdRojzIFjuP+h2JStoN6Qd5WPb0KolZTx0C7D7SC
         w5R0RBlrQpoAVQ1inrur2WAZR0C9bmVMw6Azb7KTGy2Su/5OBEqM8II3TVVlTBqqqOHJ
         V66JhKzgPt0ppI0BZ09SuY9OMXEVTT0EAqU+GnZrx3tnrvQ/5+wgJOzEf6qCSaDKUejW
         P42+QEjbO0gLvbUy+831YjivdkoQBt1Se3lWTkEAb+dXZPhBwNnhxlWLCcP59P1PFvBn
         xoydKWjbHb+DUEeQyT5QWx9BdBK45wRjdLHSQWDtAOoWRq3pD5xqFCzoHR7kyBCIYYg8
         ttLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPI0sif6GzBdqYmgsWbjnVcekwkTGNvkhzObfJYnMJM=;
        b=SC3r3SFI9ZFt2xIBtNqwJq9nJ27BR2MQa34RiQQ2VFihfDoRfGe8WcZnTxa2j1+6vK
         In8xpGtJWxU1B5fGaQ5rjrvLeqbnN0IkgmQrD+DDC9+6BdewQU2OxMc4bIvw6LDc4vO8
         /P0zQlIL4wThW0YXebzpsmaIP3VxpLX0MG2BLpHXNnK/BarItv+oV0h4VRomooP8xLj4
         BVE6G+W0w+1yGyxQdP1Ifg8tCyHAvvKI3ciFZts4AmPV4I1HDnR/KoUFthWGdiZ6vP0q
         AWUxtfE1p4rGDay63Nt/sDykOFrySZDgHiVyEJD0b5oLykVM88N01Eoiq5LrcR5E/f7n
         5TXA==
X-Gm-Message-State: ANoB5pkRVD54EmrL+8Fj03F3DGDSwbgDpOuCKSNxEOZEq/DXll4j7MwU
        lGdWxlU5wZsvXbkwoz8MXQUArwduX7C7Sg==
X-Google-Smtp-Source: AA0mqf7UTM3tm3Qu1aKRkbYGQo/dVvgJYdH1OgJdGv0pTz0MYcJQ2E+mOlS0PLwJEkNOKMBcYa+mgw==
X-Received: by 2002:a17:906:6dd7:b0:7a1:1c24:e564 with SMTP id j23-20020a1709066dd700b007a11c24e564mr46133698ejt.629.1669939640936;
        Thu, 01 Dec 2022 16:07:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ex19-20020a170907955300b007be4d8a50d8sm2351576ejc.70.2022.12.01.16.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:07:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/8] diff tests: fix ignored exit codes in t4023
Date:   Fri,  2 Dec 2022 01:06:29 +0100
Message-Id: <patch-v2-3.8-c5feef1c808-20221202T000227Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.980.g92d3d4579ad
In-Reply-To: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a "git diff-tree" command to be &&-chained so that we won't
ignore its exit code, see the ea05fd5fbf7 (Merge branch
'ab/keep-git-exit-codes-in-tests', 2022-03-16) topic for prior art.

This fixes code added in b45563a229f (rename: Break filepairs with
different types., 2007-11-30). Due to hiding the exit code we hid a
memory leak under SANITIZE=leak.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4023-diff-rename-typechange.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t4023-diff-rename-typechange.sh b/t/t4023-diff-rename-typechange.sh
index 7cb99092938..25c31b0cb1b 100755
--- a/t/t4023-diff-rename-typechange.sh
+++ b/t/t4023-diff-rename-typechange.sh
@@ -52,8 +52,8 @@ test_expect_success setup '
 '
 
 test_expect_success 'cross renames to be detected for regular files' '
-
-	git diff-tree five six -r --name-status -B -M | sort >actual &&
+	git diff-tree five six -r --name-status -B -M >out &&
+	sort <out >actual &&
 	{
 		echo "R100	foo	bar" &&
 		echo "R100	bar	foo"
@@ -63,8 +63,8 @@ test_expect_success 'cross renames to be detected for regular files' '
 '
 
 test_expect_success 'cross renames to be detected for typechange' '
-
-	git diff-tree one two -r --name-status -B -M | sort >actual &&
+	git diff-tree one two -r --name-status -B -M >out &&
+	sort <out >actual &&
 	{
 		echo "R100	foo	bar" &&
 		echo "R100	bar	foo"
@@ -74,8 +74,8 @@ test_expect_success 'cross renames to be detected for typechange' '
 '
 
 test_expect_success 'moves and renames' '
-
-	git diff-tree three four -r --name-status -B -M | sort >actual &&
+	git diff-tree three four -r --name-status -B -M >out &&
+	sort <out >actual &&
 	{
 		# see -B -M (#6) in t4008
 		echo "C100	foo	bar" &&
-- 
2.39.0.rc1.980.g92d3d4579ad

