Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4376BC433E0
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 20:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E5532088E
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 20:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Dn0nM0bW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgGBUGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGBUGj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 16:06:39 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94ADC08C5C1
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 13:06:39 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w34so2226679qte.1
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 13:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mEuDYfuT89zXW/cF6FPZo3KObUGTW86veuhPVxLmtjc=;
        b=Dn0nM0bWkh5M+o3vIorBX0Rb0/gcJuY7mL4kaXeCd97eibbOpNgSe1jw7UcWn5nhcC
         K2tFRWEVnT+LE8C3u5LixOzFx93XL5Hq3ifjtrQFvE4TL3aYR7ccZKxUF0sSkaGuJlCm
         67E+24KZmGkekO1oxsGu4AMM8defQsJADfptQmcm4/IpOWCFq/0B1HFtVH7YE+PWSvIV
         494wZb4hKBBSm1Y+PIMKx8TIDJHtUhcvyyDZD23Y508F+EWGJFUjwWEUt8mPOpaIS501
         /nUJViU1HS2O1KkyNqVxpjZSbRZYNf887RSOU5g6pTcV5EgY5E6dsx64nyPhOP/eJXu2
         Qe1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mEuDYfuT89zXW/cF6FPZo3KObUGTW86veuhPVxLmtjc=;
        b=iNjapDvCd8fBkru5CpzsFgvLIYzEMqQR2BIEI2tuB0rJT4PEh/uz4WVK6mUURRdRCB
         sE5u2noyJd8vrE26ja7XV0CPZBwV/hVJ7YEROTJ2wt9n1q4eaZTHDiWs0w+FIEH5FNmS
         S3JiEqe9u/zPCokDdUox/Pnz+1SU2jVx82TOj+lujK1MX5PmKvqgHVSsFQRhkae4TSRl
         HhkdHsyd1ouwNOLj1xVJkCc8ugISuOoOoQlEl333jIpmOCYFr8iSvG/qYgAa9649E+gc
         eFdH8Pw9shcDNiLHyxOhiDNVlvKQrALp/vj9Oa4BQn/gwANUA7t4lyjju8YWOxlI/x2q
         2CGw==
X-Gm-Message-State: AOAM532uOqscNmaGuHE0euh4RYfR/ycURRXL0x9qIimZWqcJlf9kmDbn
        OG4OIL6nSaD8hJNEdYfmAaMb5Zz6oKBBfQ==
X-Google-Smtp-Source: ABdhPJzbBWUnVGDHlREEjOaxLZqJuQ2cPZcKjBOvQxn052yVlSiyR0ZEeLdaX1BfX4FjzAletO+Oyg==
X-Received: by 2002:ac8:168d:: with SMTP id r13mr33139237qtj.207.1593720398621;
        Thu, 02 Jul 2020 13:06:38 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:650d:8c1a:48a0:61b2])
        by smtp.gmail.com with ESMTPSA id r188sm8799951qkf.128.2020.07.02.13.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 13:06:38 -0700 (PDT)
Date:   Thu, 2 Jul 2020 16:06:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org
Subject: [PATCH 3/4] upload-pack.c: pass 'struct list_objects_filter_options
 *'
Message-ID: <3434bd5979499899e24528c9a578288f1c8d2669.1593720075.git.me@ttaylorr.com>
References: <cover.1593720075.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1593720075.git.me@ttaylorr.com>
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
index a5f56d73cc..a014ae23a9 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -990,9 +990,9 @@ static int process_deepen_not(const char *line, struct string_list *deepen_not,
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
@@ -1006,7 +1006,7 @@ static struct list_objects_filter_options *banned_filter(
 {
 	size_t i;
 
-	if (!allows_filter_choice(data, opts->choice))
+	if (!allows_filter_choice(data, opts))
 		return opts;
 
 	if (opts->choice == LOFC_COMBINE)
-- 
2.27.0.225.g9fa765a71d

