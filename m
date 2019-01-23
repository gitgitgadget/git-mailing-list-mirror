Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AF0C1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 20:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfAWUCP (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 15:02:15 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38942 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfAWUCO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 15:02:14 -0500
Received: by mail-qk1-f193.google.com with SMTP id c21so1843798qkl.6
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 12:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZeSj0pnjDG1nNoVBlbusgqLZGP37HrDI9Y00+d2zuBo=;
        b=SW4fdWr12X9ApHxva+hv2s8Mhs4w/US1/WTIWt3h21eKgZD7SefsWccZ+1OiUe+RdV
         uhufAXSTMyc5USHdXVLFh3SMXMEh5MSqJrn+Z2Z8LnwpmSeqa/I7iaE0kF36W6MbfORa
         QtmvQhV09Gc7PEl/En9sllRwhd45XacJ4PUCzQNjnPVDXP+tvPakrLSGi+4cRD6SdgVI
         tb5GN81V8qYf6Gn2LA74CpoZ+21vlxkgKsbkd8HVxoN0+xPHpPn3matrVOD3DQj8lfO7
         Azrzs8IF1nuIfPbOgWWUTPnUnugHHZutbUbN83GzZf36K0xrTEirJVSafIKPjmX99NCM
         r7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZeSj0pnjDG1nNoVBlbusgqLZGP37HrDI9Y00+d2zuBo=;
        b=bu61f9cQMYKOUYWy35XHz+uUZHezcacbCO6sFjUyyJNdS1UXReZ6IVGQWzhOUyQ8xN
         oD23xcqEMSnpAUUqKIJMry5jIbwD+v07z9I0hwT6HcE9p2HkgtuvBmFIQTVPAO691Imu
         xoylCIcBkic4OyhcdQumWWxT11Ylpuabi5F2Q10xFMEla14UB9wZ3E4Bj/Q8Jyn1swAC
         vExCJ0qgr2LU/KcPa4750P7wDOq+fF8KzuEUg0MGlaFo9dw0aG7yiUZl2JZtRPz6m7NA
         DfWUuLRxnl6J8CGGXibNA/c9oJynqaNjCtbus/lUx02ZJFyVtVoHonVDuuhczKSsSxSw
         jm0A==
X-Gm-Message-State: AJcUukdU985zQLsPICfcxH7VPvpSoVs2CJt0oMIN3RlFpD81MvWEIy/o
        3qJTGcd6BZpFkfisFmCQiY8hT0Rb8Yo=
X-Google-Smtp-Source: ALg8bN5WCu8ige7v7BQKblJi+0a7RyzBgUEwm/p7GGxTWMJzXreM0hxk6ypJ059YARClHNBk3NL2+Q==
X-Received: by 2002:ae9:f40b:: with SMTP id y11mr3012501qkl.228.1548273732482;
        Wed, 23 Jan 2019 12:02:12 -0800 (PST)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id o2sm55252042qtp.48.2019.01.23.12.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 12:02:11 -0800 (PST)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     asottile@umich.edu, benpeart@microsoft.com, gitster@pobox.com,
        pclouds@gmail.com, peartben@gmail.com
Subject: [PATCH v3 2/2] checkout: fix regression in checkout -b on intitial checkout
Date:   Wed, 23 Jan 2019 15:02:01 -0500
Message-Id: <20190123200201.7396-3-peartben@gmail.com>
X-Mailer: git-send-email 2.19.1.gvfs.1.16.g9d1374d
In-Reply-To: <20190123200201.7396-1-peartben@gmail.com>
References: <20190118185558.17688-1-peartben@gmail.com>
 <20190123200201.7396-1-peartben@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

When doing a 'checkout -b' do a full checkout including updating the working
tree when doing the initial checkout. As the new test involves an filesystem
access, do it later in the sequence to give chance to other cheaper tests to
leave early. This fixes the regression in behavior caused by fa655d8411
(checkout: optimize "git checkout -b <new_branch>", 2018-08-16).

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 builtin/checkout.c         | 8 ++++++++
 t/t2018-checkout-branch.sh | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6fadf412e8..9f8f3466f6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -592,6 +592,14 @@ static int skip_merge_working_tree(const struct checkout_opts *opts,
 	 * Remaining variables are not checkout options but used to track state
 	 */
 
+	 /*
+	  * Do the merge if this is the initial checkout. We cannot use
+	  * is_cache_unborn() here because the index hasn't been loaded yet
+	  * so cache_nr and timestamp.sec are always zero.
+	  */
+	if (!file_exists(get_index_file()))
+		return 0;
+
 	return 1;
 }
 
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 6da2d4e68f..c5014ad9a6 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -198,7 +198,7 @@ test_expect_success 'checkout -B to the current branch works' '
 	test_dirty_mergeable
 '
 
-test_expect_failure 'checkout -b after clone --no-checkout does a checkout of HEAD' '
+test_expect_success 'checkout -b after clone --no-checkout does a checkout of HEAD' '
 	git init src &&
 	test_commit -C src a &&
 	rev="$(git -C src rev-parse HEAD)" &&
-- 
2.19.1.gvfs.1.16.g9d1374d

