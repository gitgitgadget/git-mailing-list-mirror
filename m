Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D52CD1FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 18:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933324AbdCaSAK (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 14:00:10 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35497 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933555AbdCaR7T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 13:59:19 -0400
Received: by mail-pg0-f42.google.com with SMTP id 81so77904051pgh.2
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 10:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6o5ZMp4JyTfi8hNuGVDCBp0l+b8kl7bGwySkEkzw9qk=;
        b=IfRaAO5xRzr5mxt+/EjrftyNcR5Nj7JBwjw7FmGhLLp3enmgZnVYbB68t6hecGwbXg
         c9LvwYkt0RJWxjQqN7kIDr/PJyXjQZ0WJP9BnHEQeuYiQzkcYJlx6/IB5zYbSCOshhkz
         sxKHWEOlnfwPTHAt36YSCylVxTvdoz9vpjv+UMVSYg11aNy7X89yvo2BO0mPUoN8cWYy
         eN5mOb2OzmzfJjd4Uf9OvOOhwodHEe/JLWfpQVhZ/aWqn7nE4qQ4cCxtTH7Ts9ulyqnW
         w8Zbtdr1h4K3hIIpWSdw2miVGPApi1kZFljdLUNfpqGUTOcZFBXL8nXapCCSKkJs0dAa
         EyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6o5ZMp4JyTfi8hNuGVDCBp0l+b8kl7bGwySkEkzw9qk=;
        b=cKcikVkJ0oGFZibr99jOBVWhelSaRhZ8zZKgb6mqq6dE9MjFaB6BuAdcG5S25GTyX5
         g7H0nKqr3oxe7IHFrCSXPKBQf3b8vyNRxJtUJ6Opkr8BHZtM/G5WLZ82d3ZsMln6llul
         8H49IXgtSd7cp1MGK7nNRd/DkNbCmBtYOshw7oJXcI8ANBwi1gvBefAUDo2fl0XeseaQ
         f7vaT2Yk4qFKawQyvO8r/ExA7AkHb1fgkJNm3U27eEW3kUUdLYbS6M1+MvK7kuwrIjeE
         f/wXhu9FXrnXoMrlVPYRNFxKUPAGI++MIk3TxTiuAIQfSEiRDaypeDKV/9jGJLXPeuF7
         +wGQ==
X-Gm-Message-State: AFeK/H0KqULjD0zBncRi1sdgB2uHHE/Wo0qLM8WGYXf+sOtyvdUQM3ByTlNNCsG55PRiPrcR
X-Received: by 10.84.209.133 with SMTP id y5mr4727800plh.25.1490983157898;
        Fri, 31 Mar 2017 10:59:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:240e:6326:bc58:48a9])
        by smtp.gmail.com with ESMTPSA id n4sm11814421pfg.73.2017.03.31.10.59.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 31 Mar 2017 10:59:17 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jacob.keller@gmail.com, daveparrish@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] failure with diff --submodule=diff with moved nested submodule HEAD
Date:   Fri, 31 Mar 2017 10:59:07 -0700
Message-Id: <20170331175907.17400-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.511.g2abb8caf66
In-Reply-To: <CA+P7+xoqWCpySc17104zggLgwx1mc0T+JXybrgd8sQxoQFP-PQ@mail.gmail.com>
References: <CA+P7+xoqWCpySc17104zggLgwx1mc0T+JXybrgd8sQxoQFP-PQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fails reliable for me.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t4060-diff-submodule-option-diff-format.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index 7e23b55ea4..89bced3484 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -746,4 +746,20 @@ test_expect_success 'diff --submodule=diff with .git file' '
 	test_cmp expected actual
 '
 
+test_expect_success 'setup nested submodule' '
+	git submodule add -f ./sm2 &&
+	git commit -a -m "add sm2" &&
+	git -C sm2 submodule add ../sm2 &&
+	git -C sm2 commit -a -m "nested sub"
+'
+
+test_expect_success 'move nested submodule HEAD' '
+	git -C sm2/sm2 commit --allow-empty -m "new HEAD"
+'
+
+test_expect_success 'diff --submodule=diff with moved nested submodule HEAD' '
+	git -C sm2 diff --submodule=diff >actual 2>err &&
+	test_must_be_empty err
+'
+
 test_done
-- 
2.12.2.511.g2abb8caf66

