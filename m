Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7B3C4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 11:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbiLBLx5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiLBLxk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 06:53:40 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ADDD9B09
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 03:53:09 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id vv4so10987678ejc.2
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 03:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mE2Y8Pmxn9TUaxmcHXv+COuBIuBjuU2xHLH8+BlXkks=;
        b=E4EUyeqV/chBm4FFPP43haUB81LiCZz77Ru67HvXRGdQlFUT3XEmDNVhPKADnMFDEi
         Lx900cr2Z4MkDvqgLvplxa4pZ8LM5hdU5xSWyikulhms2dtzZkj68Q1l4pYWap1grh6z
         vYOO0ALPLZIxAf1LxAcjCgCH1gK5AoR0xfGRdNOHf10ZOrHCutYUy++T0q3H2vrOU5BT
         XOFIEyagqVy5w0yNEMoQoPshbvHv4xh4iK6qpRZtMQrWexKfNhGTOaUE32mOTFXYCvQH
         TZJXlsZwlPOH32/M256ipxGWxXTj98kRMz1Axy5qGGj7T9xPs7FFgqH0UwfT6ErCaWxK
         SV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mE2Y8Pmxn9TUaxmcHXv+COuBIuBjuU2xHLH8+BlXkks=;
        b=DZCKedqnntlHdMBufFY0WNZ53ui+RqXNCIcHwR7ZGzoeOkume92WOUONDYj8tQpy8i
         bMz9JYqjpGVSLU6jzV12xMW0Y9I+KE8QjWIJegOjqpk9HPy3jlLQ+rpftcQGbAI9hgjt
         w3zGTaRb5xn4ZiiPvUoz+WBUYeyTtET9OvbnZVRoVL2wODk0zp4NxziUyUttzMy8Nuna
         9olrtbBLA8yogGL7qfz9JmuDLAyPEpjQ+hoiBMT34gtnGB6W/LY9xkXGQ3Ho0itEXYaX
         /dyyEULA8AI4Fh8cCgAkIG8RvE7SvpA3yybps4aJ2zwox2denNYyT8aMIwlz3bMTZ0B7
         np2w==
X-Gm-Message-State: ANoB5plweJzcboEk365+nzxTCA7xQvn+RbBdlrGV2ZLvvQTgQ+7cRz3f
        U44Dcrxniqtp+WummHEqQr1O0oO6Z2YuJg==
X-Google-Smtp-Source: AA0mqf4pZY5YhOzaEPOzer+6AnZ37xWf/Xz1QW5RSLcOMbasNBR7DIODMqPetyve1jq1DLu+nOk8ag==
X-Received: by 2002:a17:906:6c87:b0:7c0:cf94:4dd6 with SMTP id s7-20020a1709066c8700b007c0cf944dd6mr315737ejr.95.1669981987834;
        Fri, 02 Dec 2022 03:53:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q20-20020aa7da94000000b00458947539desm2833754eds.78.2022.12.02.03.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:53:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/8] diff tests: fix ignored exit codes in t4023
Date:   Fri,  2 Dec 2022 12:52:36 +0100
Message-Id: <patch-v3-3.8-4ec075689f6-20221202T114733Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.981.gf846af54b4b
In-Reply-To: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
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
2.39.0.rc1.981.gf846af54b4b

