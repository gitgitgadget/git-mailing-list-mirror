Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82020C55185
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 23:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6223A20776
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 23:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="uSUzIrJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgDVXN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 19:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725839AbgDVXN1 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Apr 2020 19:13:27 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BFBC03C1AA
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 16:13:27 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t11so1897581pgg.2
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 16:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VS6zc4Di/do5IxU/khW4eZxYKw3AXDshI80+WQY1iEQ=;
        b=uSUzIrJlZmNWA9TGLfW8C9KxoJDWGzB9uzgm1e4mfYix1NPLLDWE+zJB0L81E5fkMF
         LoBE7sx8zJcj1srg1IQ0ruVplqtttsBlE7FjVYTdGOqLtjB4KNSoFlTP+3CNKA2udAWM
         S7HCGezlNWCSoxWoKv3MOV7RSyHSF5x2hA6+6Ev3sRgMjaOswNeSdOkiWu2xZ/bq12HL
         4uy7Rr8unbF5K6gsarCPiOsES2SMgS9aQcgGUSFGEI2AkTdk2Qv/+rSO7IzwqVKgkA1A
         yv95eVsq0fsf6epRqYu8u17kCHyECCh4BWDU+C7FKMDAsgb96GuYgGCNuZICnUxCnQyV
         2sLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VS6zc4Di/do5IxU/khW4eZxYKw3AXDshI80+WQY1iEQ=;
        b=BCC5MSIRraUILhcVX0zSCa5JwxZLJE9U+gTWQ4siDCr1GxShVkJ8UoL4Fpj5crBnFr
         erN2xft+WpDn81ktFxdFQRurDWSkY/IXInMJ29Yf+6ND9oAWzkEKpIzl99JR8P5koYRm
         QoQbNW1RjQ6xUfObxS7lrgTybx7mDHhRlTCi2J7IrgdAtaxKkXkMmLK2xqr2aiszTb4Q
         aBL5fK8Y4+Hxge+gyrkBgyxq31rb05BEfnlUb03zIg/nRYtoJy6RXORYHLudkmUCfrNW
         FHkydvdxHS+Fooiw/5c3tEI+36MTfk8TmbyFriWCy9w9tcRFU7EK+uHOiAZaljkDgNOX
         6fMQ==
X-Gm-Message-State: AGi0PuZjNmmcIQ06YtEEo1xiMSWU453Ps9sALAThE4Tf5bCkzuPYN8aa
        juIt0D3Korr957jR1uV0FPHKoEDRFcu/cA==
X-Google-Smtp-Source: APiQypINX7EUdIPI/kG2Sfq6ZT5vVvxYXmvfhksKTyQVZM66L16ODUg/xBLfPtlZqgs73H9jGTKnBw==
X-Received: by 2002:a63:615:: with SMTP id 21mr1334375pgg.22.1587597206174;
        Wed, 22 Apr 2020 16:13:26 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id d203sm571931pfd.79.2020.04.22.16.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 16:13:25 -0700 (PDT)
Date:   Wed, 22 Apr 2020 17:13:24 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org
Subject: [PATCH 1/4] list-objects-filter: treat NULL filter_options as
 "disabled"
Message-ID: <ccbcb2ff0e0fc2adf6695b3785aef9b74a0c4bda.1587597151.git.me@ttaylorr.com>
References: <cover.1587597151.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1587597151.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

In most callers, we have an actual list_objects_filter_options struct,
and if no filtering is desired its "choice" element will be
LOFC_DISABLED. However, some code may have only a pointer to such a
struct which may be NULL (because _their_ callers didn't care about
filtering, either). Rather than forcing them to handle this explicitly
like:

  if (filter_options)
          traverse_commit_list_filtered(filter_options, revs,
	                                show_commit, show_object,
					show_data, NULL);
  else
          traverse_commit_list(revs, show_commit, show_object,
	                             show_data);

let's just treat a NULL filter_options the same as LOFC_DISABLED. We
only need a small change, since that option struct is converted into a
real filter only in the "init" function.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 list-objects-filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index 1e8d4e763d..0a3ef3cab3 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -663,6 +663,9 @@ struct filter *list_objects_filter__init(
 
 	assert((sizeof(s_filters) / sizeof(s_filters[0])) == LOFC__COUNT);
 
+	if (!filter_options)
+		return NULL;
+
 	if (filter_options->choice >= LOFC__COUNT)
 		BUG("invalid list-objects filter choice: %d",
 		    filter_options->choice);
-- 
2.26.2.112.g65467a058e

