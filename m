Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9451EC48BDF
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 01:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7375661264
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 01:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbhFSBdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 21:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbhFSBdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 21:33:25 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3DFC061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 18:31:13 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h12so5581462plf.4
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 18:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XDwr1GdawLNTFcUEyzHTFt6+zuezsk+dZghuLX7RIYA=;
        b=Fr5v7nhaRIOL5uYdNs/yV9Obqo7J/u5QeTSab427KQziqfl7Bi13lby78+S/guZhL9
         jaIWK9arFm4yFr0rGZL6q6o1k65S/c4sUCQNX3ijqQ0oN1KW+iaxteuLh+0UgyFIXfgd
         d7/+xfEJ9a6c30raEGz030JKZ1tvwjRsFMYIaH9UdOksPrRpHtaGi+kjbr8VZEI+AYGC
         RbJCElnXpmwbK/HqZflmnuc5UsuI43vIcmU39K8LUOk3uCMouXS80uCaW8/ZXaQPqodL
         6yWlpytDiCSW88WuIr120cHTweFwdgijYhTRSvF4Uh0CQ7aygFvB5cU1K2N3XdcNKojh
         aaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XDwr1GdawLNTFcUEyzHTFt6+zuezsk+dZghuLX7RIYA=;
        b=T2Ew5/DMYnRTRP/bGJAijth7TTT9v6ZuY1oQWs6yv/TzxeF2kqO8ox+60BuiyRifOD
         dKdh75lIWxR0xt7F+Jf7hvszYYsyftmxhMtQO+Fk4QR5DD5QSTN2DsqTPs8GwZDwxA11
         QEKfx/MFYO1vHKYGUX7CZnSAkrhs3mm1OVz6hKtS4dyLu5dMDMphPh+UaCJZFem/01w8
         5tlqX5Auz7QdSwP+7iRbMYULHxD+eFCrCp9XgqDbXVWemwVEQdmjb0Wl+4bJmn2DLVLl
         k2kOd7D7qygwm5UerNKTMw/m4iK+GUQIjyTiVAIQt/mg14RQYUTkj/qB/P56aK1keusc
         hFlg==
X-Gm-Message-State: AOAM530J7/XNny5n5nqJ2tyG/WLSfQhaNJk4Vt4VISTtj87ebA51ZwHF
        FYxT5JpZdow6yZ6TJ737tDMPAW8nHKw=
X-Google-Smtp-Source: ABdhPJw7N2ln2+XVLMPBnXYch2PJYixvivY1FXzSwhzdZqhWV3ciOQ0RCbRDNRcjBqLhlOYzL6o1CQ==
X-Received: by 2002:a17:902:b218:b029:11a:bf7b:1a80 with SMTP id t24-20020a170902b218b029011abf7b1a80mr7348171plr.82.1624066273353;
        Fri, 18 Jun 2021 18:31:13 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:a3d1:fb64:d06b:ab01:2de4])
        by smtp.gmail.com with ESMTPSA id s123sm8733427pfb.78.2021.06.18.18.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 18:31:13 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 3/4] t6400: use test_line_count_cmd to count # of lines in stdout
Date:   Sat, 19 Jun 2021 08:30:34 +0700
Message-Id: <20210619013035.26313-4-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.278.gd42b80f139
In-Reply-To: <20210615172038.28917-1-congdanhqx@gmail.com>
References: <20210615172038.28917-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t6400-merge-df.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t6400-merge-df.sh b/t/t6400-merge-df.sh
index 38700d29b5..e5e9e473fe 100755
--- a/t/t6400-merge-df.sh
+++ b/t/t6400-merge-df.sh
@@ -82,13 +82,13 @@ test_expect_success 'modify/delete + directory/file conflict' '
 	git checkout delete^0 &&
 	test_must_fail git merge modify &&
 
-	test 5 -eq $(git ls-files -s | wc -l) &&
-	test 4 -eq $(git ls-files -u | wc -l) &&
+	test_line_count_cmd = 5 git ls-files -s &&
+	test_line_count_cmd = 4 git ls-files -u &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 0 -eq $(git ls-files -o | wc -l)
+		test_line_count_cmd = 0 git ls-files -o
 	else
-		test 1 -eq $(git ls-files -o | wc -l)
+		test_line_count_cmd = 1 git ls-files -o
 	fi &&
 
 	test_path_is_file letters/file &&
@@ -103,13 +103,13 @@ test_expect_success 'modify/delete + directory/file conflict; other way' '
 
 	test_must_fail git merge delete &&
 
-	test 5 -eq $(git ls-files -s | wc -l) &&
-	test 4 -eq $(git ls-files -u | wc -l) &&
+	test_line_count_cmd = 5 git ls-files -s &&
+	test_line_count_cmd = 4 git ls-files -u &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 0 -eq $(git ls-files -o | wc -l)
+		test_line_count_cmd = 0 git ls-files -o
 	else
-		test 1 -eq $(git ls-files -o | wc -l)
+		test_line_count_cmd = 1 git ls-files -o
 	fi &&
 
 	test_path_is_file letters/file &&
-- 
2.32.0.278.gd42b80f139

