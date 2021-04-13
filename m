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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE88C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 12:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE86613AE
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 12:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343606AbhDMMa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 08:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345919AbhDMM3G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 08:29:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBDFC06138C
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 05:28:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x7so16244999wrw.10
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 05:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MgJhi8+630j2HLWFbGvp1ibglJ/RuZF53Jk8QQ758YE=;
        b=cHfN98+B0ZglxMfzaJLXjjugQDd+2Roi5mrm/U26TM/okcrbdTZNR7GmXD83l3Vld3
         CahP8nTAseTLv5jhM4e4fASUlqM89ZmZw5dNKFGeJWiKWeBDybh7EinrdpOqIovutylu
         nszCRwGtI2C/B+gjNuYLPSozOkcS8oa/6wHabmQrEKoJrVr7YeSC48SuUSY8pPDXceXn
         t6X33JX0Dm6cMR/qLNZmixkJt7hnAVJLumK6irRsU5B6bX6CIC/SXmq+370xZFrkIyZP
         YkeUqKeLft9FewK9lAfo/DV1g9bHH9SFvq0rRAfJVHU3TPbePdKbc9ADLeM5ZG1P2tQl
         Yzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MgJhi8+630j2HLWFbGvp1ibglJ/RuZF53Jk8QQ758YE=;
        b=BFp//isDZvi9V4smPWKjZ2VFbtudUGIZ0Thv6H1HdJxdyHdW5xtmuf/4LnZt6G4+GZ
         eDtbcxIzB11RqknN1UXhRhgsWiwsRD/lN8fw4mS2i5lz7wlJVOW1Yghs/vz0b0ISGseP
         kitBQkMwekX4IQsOGV+Sn5i8mQp2qRS8Gff4sohcpo7DmZKQFonot5tXS9SiNtFzyCm8
         gSUsjIIV3ylHaeUu0kyMZ+fl64ilLQ8mwHTj09p6c/Y8HqhO9jKxkL4wu6mNq+2m05f2
         kS2LnWVikJbD6Oj3CLKvsXKBXIWJS/G6/T04G7gchsXvR55ZfdcWWwM96Ar9Ke37A/0f
         /zbQ==
X-Gm-Message-State: AOAM531LbXrXSym4DlICqFGv4YbUlvlVmwZ2uTv4iZ7gtOOXm3An73/P
        pQTXuISfdKueBbq036y/8js7xtKiXtj1Yw==
X-Google-Smtp-Source: ABdhPJxV+Fw0cxAy9GO2zrZ3szaVo/iP+Mgxa5T71+6e8vT3s5bircBetEhMoka/BV1Z8n1h0XWu2Q==
X-Received: by 2002:a5d:4d46:: with SMTP id a6mr937530wru.3.1618316924231;
        Tue, 13 Apr 2021 05:28:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 7sm19565445wry.60.2021.04.13.05.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 05:28:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] diff tests: remove redundant case statement
Date:   Tue, 13 Apr 2021 14:28:33 +0200
Message-Id: <patch-1.2-35e77153831-20210413T122645Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.646.g06d606cb9c7
In-Reply-To: <cover-0.2-00000000000-20210413T122645Z-avarab@gmail.com>
References: <patch-1.1-f0542cd902c-20210413T121930Z-avarab@gmail.com> <cover-0.2-00000000000-20210413T122645Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a case statement whose two arms executed the same code. This
was added for i18n testing in 6dd88832e77 (diffstat summary line
varies by locale: miscellany, 2012-03-13), and was changed from
test_i18ncmp in my 1108cea7f8e (tests: remove most uses of
test_i18ncmp, 2021-02-11).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4013-diff-various.sh | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 6cca8b84a6b..67f6411aff9 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -220,13 +220,7 @@ do
 		then
 			process_diffs "$actual" >actual &&
 			process_diffs "$expect" >expect &&
-			case $cmd in
-			*format-patch* | *-stat*)
-				test_cmp expect actual;;
-			*)
-				test_cmp expect actual;;
-			esac &&
-			rm -f "$actual" actual expect
+			test_cmp expect actual
 		else
 			# this is to help developing new tests.
 			cp "$actual" "$expect"
-- 
2.31.1.646.g06d606cb9c7

