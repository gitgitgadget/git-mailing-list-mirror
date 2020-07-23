Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86F1C433E4
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7CA92071A
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="2TB0DkNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387545AbgGWBtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbgGWBtK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 21:49:10 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEE5C0619DC
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 18:49:10 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e7so3385959qti.1
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 18:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZICLeGvz8UZnLvIMCuBDtR6sPnwCgCu5fufpEMfmzyw=;
        b=2TB0DkNvd5yq5k67gtlQdp2zdOQ61IpUdTF82ePxME1waEFkkud37bVLCRfeNrkHVy
         w0drIkJ/VsGfjSB2K3q7woyClvpLjstqOXdkXurbeD8JugttqQu0UnZuUDeIrG+5ZPsQ
         aXfKrHK0yU5dwiOJyYYMrigtaqT7S3QgYAi0YLhztfHBjuIKIZbkw0qUrU2JZd4wCpMX
         xt04GkTYExrzQtQGHFprxiBelMXfO5kZkHkXtZUN8q6cUipBcPTYxFVRMkSmKZzWDYP5
         wksMv+g9Td8i7pNEKE8UlT4vCs4eYhXjuVwqn3uECMrLUVRJ9dDBlfd3Dj/yxUkQGlF3
         JJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZICLeGvz8UZnLvIMCuBDtR6sPnwCgCu5fufpEMfmzyw=;
        b=BFvhOaxApLwxNYDYpOTYmlRL2LiWUzUeM/iTtbkF2HhUD9TDHXvVq8fwfZEdtJXnOb
         VB+K0/hGZyUSwy2GKfPZcYtZJIQV8va2e/J46WlFaYpkuSPdMVLzcUUWQ4fVM33EzSm/
         uuzfcdaZb2aRnH2CjsjXbZjgiWhzQebRD3U3lUgkncogLMSxgSNYIleitJFABrk85ZtF
         ze6GNhfBdRoNj61Z4Sx9cGpAjOfwO0Wz857/8nuFRVUR3HLRgQAIMdC/lzlmFkfVQtLr
         2XoI91FewXfFkpe+G/azhL+SeOegti/3SOBsdVyYNpEaJxtkVhutm/AVmV2RfzSA8O/E
         3goQ==
X-Gm-Message-State: AOAM533Q1fIxXYktflzziMGqnnGztUf/ZrUNZR+Z/GmcIvSVTV99t4A+
        jy7/ObH1T4ctDdEPfS6CYPymjmf13Wc9CQ==
X-Google-Smtp-Source: ABdhPJxe4QKCJnSNTUjigH8NNSveklOI0km3+XGb1qWWoFfplI2aDeUW+toSv5QUAkm2prcRqvh+Hw==
X-Received: by 2002:ac8:4e03:: with SMTP id c3mr2247443qtw.82.1595468949270;
        Wed, 22 Jul 2020 18:49:09 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:351c:83f3:acec:de38])
        by smtp.gmail.com with ESMTPSA id x12sm1401923qta.67.2020.07.22.18.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 18:49:08 -0700 (PDT)
Date:   Wed, 22 Jul 2020 21:49:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: [PATCH v2 3/4] upload-pack.c: pass 'struct
 list_objects_filter_options *'
Message-ID: <550e4e13f16016b219445376fdcd75da87d60c65.1595468659.git.me@ttaylorr.com>
References: <cover.1595468657.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1595468657.git.me@ttaylorr.com>
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
index 61929977ab..48f10d21f6 100644
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
2.28.0.rc1.13.ge78abce653

