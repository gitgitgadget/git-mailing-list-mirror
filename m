Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85645C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D61E2245B
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3F3ybG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfKTAvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:51:07 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38787 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfKTAvH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 19:51:07 -0500
Received: by mail-pj1-f67.google.com with SMTP id f7so3402717pjw.5
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 16:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kiok8ouLNcp2yuA0MyolPLQOoL8aiYTORTCD1GZLpeg=;
        b=i3F3ybG9vZkoKM6D6Uzpn/yaUhB+vImbItW10pfdZpsNveiu6wy7F4h+O69ssUrEO2
         iuP89vKFx1ObaSZnJHhStgaMKOGOHNHhwnSFH8A938ZtRDdC9THdYbmbciWg0lVEBXP9
         ohzfqoLFEaqDIUrx3c4Xk6Pt6nwlG93tvv/6/3mVUnaxCb81T+TZ1GNM7gPiue/8tk29
         dyasoQas5saq5GWn0e89WOw3zW68sYEdSXFjxcgWSo9gVqCA0ZDa2lmEdf1o7tUHmHxy
         U1Noqs1LufcPAoIw3NrPGbAjniNLxkacw9r10aOgUTmicTjZE85hfz/tv8k1fZDfG9U3
         12eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kiok8ouLNcp2yuA0MyolPLQOoL8aiYTORTCD1GZLpeg=;
        b=OTlt9UT7TeRe3f/SFpKmoAgVQcPgDJx/5NXJoVwOZ6Z4BtFyG1sa/zQHHMue9d9zhk
         qpIV0DDik5eCoXgkzX/Fs1waVclRtlxi4LQxnO4iJe9VAjFdHKVnOCr07+kJoFMTX0Q8
         esGaSWWXw76LjLnAq1B78NcIDe1PBw+qzjKZdoCnHborEa2Ln/g8Nlb5OVMAHC4J3iLe
         yQahjhmguRjQW2ZJOeYXx5Z1GDnuQy3qwTwmVtgLO1t6T36Wa5xGBL2cgQt9554ivUW6
         uuxllMQhHqGuwDidT78xmKhWcYAyDKhiYAoL0aN24RNtLx8zJlU21leE7/bpUTBoc18S
         tGVA==
X-Gm-Message-State: APjAAAWf2LmMhahcoF2dyp1MJJ3exlS+Ew6IVMy9vMFd9BSEAVhwjRcK
        /qtCYIjD5mssm6Tkealqr4l3lTug
X-Google-Smtp-Source: APXvYqy5bW6yl/rraUxpnNR1rjqxC1WZLjbUQGHyEXgailxPE93+Se2D1GL+yd9Gu1uM9lHUPN68CQ==
X-Received: by 2002:a17:90a:f013:: with SMTP id bt19mr549123pjb.16.1574211066030;
        Tue, 19 Nov 2019 16:51:06 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id y8sm26166822pfl.8.2019.11.19.16.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 16:51:05 -0800 (PST)
Date:   Tue, 19 Nov 2019 16:51:03 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v5 01/11] SubmittingPatches: use generic terms for hash
Message-ID: <616cda0b4db9d95bfdef9f6546ca014b901bbaf2.1574211027.git.liu.denton@gmail.com>
References: <cover.1574122784.git.liu.denton@gmail.com>
 <cover.1574211027.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574211027.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since Git is planning on upgrading from SHA-1 to be more hash-agnostic,
replace specific references to SHA-1 with more generic terminology.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 6d589e118c..5a00329d5a 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -142,7 +142,7 @@ archive, summarize the relevant points of the discussion.
 
 [[commit-reference]]
 If you want to reference a previous commit in the history of a stable
-branch, use the format "abbreviated sha1 (subject, date)",
+branch, use the format "abbreviated hash (subject, date)",
 with the subject enclosed in a pair of double-quotes, like this:
 
 ....
-- 
2.24.0.420.g9ac4901264

