Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABD6E1F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751121AbeACAqc (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:46:32 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:35129 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbeACAqb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:46:31 -0500
Received: by mail-io0-f195.google.com with SMTP id 14so529662iou.2
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2on/PEF+NAIfI4gnCBOetlcvBK3EGzDYO/XuSbbzrB0=;
        b=ElBwhYisuZw0EK6G2ifBv6tToJ/YMFzsXGKL0v5JHsDaNGusVgo6cMtCi5PIjqtj/j
         wW9O99c+cnlFnme0b++ygv9Ff80CsUgZMzIAdGAetKyRnW1niP3xqK5UHrkhEB9lY8Gm
         iZXYlg9vhcarpzxxvScCykFsWYKTb9/GkMQnkePKj2ZeIvmQ35ryAK5biIUHas6s18/T
         NVa6SYlxM8OXyQi96o7o5PCr6Q0asPBxnSGfv8R4fuo4fhVRaFxztJObj5UCKHLieW0c
         gfcPFUnx+xq85gn3zcjWnV2Y0uW8vArVZEW07SjL+4zKTIuGdUekJAe+Az6X8ulaWs3H
         ZexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2on/PEF+NAIfI4gnCBOetlcvBK3EGzDYO/XuSbbzrB0=;
        b=aEghsIfhmjX9cxF+rhXPDUA0zPAo4qLYIaEGw6l9RiQwuyggJmuqiQ7eEHJj9FHZJo
         1B9jJ4QqdP0NzynS1JeTIClzKuFLme4Dr6SKB1Cbetvif8PRuKiUiL76VTwlEl0EYV8i
         dR+882DusQnfdPqPJItTM5M3zsvA43jAHdFd2Ga5YZRU93KYZD2BEPtdrD/j0RhHvLmM
         zhtD8sxdQunRip5IuN6MHpzVTQkgCjnMZFQsgjqHXpLCtoKh9AfRd2/F/n6f5oUM3Gr1
         hshInkrWwrFBg6IFH08aq/8BfBM635SveapJxvOELULY7jpQpa4n2AOWYLx6JV8eS6t0
         4eEg==
X-Gm-Message-State: AKGB3mJCgdIvOgXh//VsuKY9n/dfBybItweAn0BRgoty6hGw34l9Owv4
        FUJ6bW0cvr3trmQdFWlW5rg65imTrvs=
X-Google-Smtp-Source: ACJfBovA0cecEHPLqeVGV0Q7KFt+v78xFUibtcX320D0RCzd400PFRdSnNlR/CNi97L2gdkrqNmtog==
X-Received: by 10.107.150.18 with SMTP id y18mr13274164iod.166.1514940390289;
        Tue, 02 Jan 2018 16:46:30 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id f207sm30239ita.26.2018.01.02.16.46.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 16:46:29 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/5] diff.h: Make pickaxe_opts an unsigned bit field
Date:   Tue,  2 Jan 2018 16:46:20 -0800
Message-Id: <20180103004624.222528-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103004624.222528-1-sbeller@google.com>
References: <20180103004624.222528-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This variable is used as a bit field[1], and as we are about to add more
fields, indicate its usage as a bit field by making it unsigned.

[1] containing the bits

    #define DIFF_PICKAXE_ALL	1
    #define DIFF_PICKAXE_REGEX	2
    #define DIFF_PICKAXE_KIND_S	4
    #define DIFF_PICKAXE_KIND_G	8

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.h b/diff.h
index 0fb18dd735..ea310f76fd 100644
--- a/diff.h
+++ b/diff.h
@@ -146,7 +146,7 @@ struct diff_options {
 	int skip_stat_unmatch;
 	int line_termination;
 	int output_format;
-	int pickaxe_opts;
+	unsigned pickaxe_opts;
 	int rename_score;
 	int rename_limit;
 	int needed_rename_limit;
-- 
2.15.1.620.gb9897f4670-goog

