Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8A1C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB7A522B3F
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="xtMz92yk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgGaU0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGaU0j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 16:26:39 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF69C061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 13:26:39 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 6so23983735qtt.0
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 13:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d0ZQ34NpC6OH8RzVlQ0NYyoQ5i5b0HhWQ9vPQ1ESBhw=;
        b=xtMz92ykSCNrD2i4PG21kuZ0fpqkyXH5U1b+sOlNwlPuuMBprgz3JgrEmB3NgonG0B
         59pbLYQ+DRTL+KCEa3gHhVnEzcP6nfeHbzANcY59GIOeRilkCX/fFvnC6CDXG5UL75vH
         k8i9zE/llfVc/08lCVsbGDJQRjLFB3k3P6OwnvkiwFkJ+gIBDMYl3c0xgc2tgQutq28Q
         hXrH/vfqtRt1rrDmw+2y2i8hUWNrrTUZ3vWpP4bqsPqP3Bi7/5nMsiN8Upkb81CQRjFY
         i4nHAdjG5dnJnS6jxXseaz/lhFFSbpQb2B9NwCX6tMpIu7q6ozVa3iWnhbBaQQCw82Gl
         yTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d0ZQ34NpC6OH8RzVlQ0NYyoQ5i5b0HhWQ9vPQ1ESBhw=;
        b=k4NNTSXuxcnevYlvhkn5l/8qlDNDMIooK22A5KXCVpMGSldY2Ft7M7/Qu+pPva3cSd
         MGO1TETkU9Je9AsDIh+PUomM5iTM4c9ij6xwVKh0X/FUTbkyOy+I2uWzywuR60wOs9HC
         w1QjMCVRfKTnobrtqi1KdNSMzBEBZHxg0P/YEs/d4wD/8gTXhKAQFms2KEcbTdpG0ffl
         uAkULvnv+Cc2dzhV7tbNXSruorLrEsCi/Kuq2UpAYmqEN7hEZjg3x08AT8LEF2pmTiJ3
         SzYDTFfn/+35p1lLtzjkNjGzxfGms6wJt8fylLYDtzQackTzBIwGGJILaRR54yeNsXwe
         PO0Q==
X-Gm-Message-State: AOAM532hKQOUI5/XoMeI0e6TZt9OZNjh0LYrGA7+AGBzSB8QN5PF7DRX
        3innF6y4pkSqtz9M3ICyMgZqhr4U+/nIEQ==
X-Google-Smtp-Source: ABdhPJz3oRcn3z3tv0zWeSgAb1POnVYYk9KDqtaY55nc54OV2xPLYiRmTpY7x/YxUaoiN1UCM93Xcg==
X-Received: by 2002:ac8:47cb:: with SMTP id d11mr3688142qtr.311.1596227197761;
        Fri, 31 Jul 2020 13:26:37 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1861:1305:b592:e057])
        by smtp.gmail.com with ESMTPSA id d46sm10655786qtk.37.2020.07.31.13.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 13:26:36 -0700 (PDT)
Date:   Fri, 31 Jul 2020 16:26:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 3/4] upload-pack.c: pass 'struct
 list_objects_filter_options *'
Message-ID: <ad3f0cce56bf205ae718b0f3be46b91ef0285492.1596227003.git.me@ttaylorr.com>
References: <cover.1595468657.git.me@ttaylorr.com>
 <cover.1596227003.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1596227003.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'allows_filter_choice' function used to take an 'enum
list_objects_filter_choice', but in a future commit it will be more
convenient for it to accept the whole 'struct
list_objects_filter_options', for e.g., to inspect the value of
'->tree_exclude_depth'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 upload-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index ed2098edd0..5fa22da31f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -991,9 +991,9 @@ static int process_deepen_not(const char *line, struct string_list *deepen_not,
 }
 
 static int allows_filter_choice(struct upload_pack_data *data,
-				enum list_objects_filter_choice c)
+				struct list_objects_filter_options *opts)
 {
-	const char *key = list_object_filter_config_name(c);
+	const char *key = list_object_filter_config_name(opts->choice);
 	struct string_list_item *item = string_list_lookup(&data->allowed_filters,
 							   key);
 	if (item)
@@ -1007,7 +1007,7 @@ static struct list_objects_filter_options *banned_filter(
 {
 	size_t i;
 
-	if (!allows_filter_choice(data, opts->choice))
+	if (!allows_filter_choice(data, opts))
 		return opts;
 
 	if (opts->choice == LOFC_COMBINE)
-- 
2.28.0.rc1.13.ge78abce653

