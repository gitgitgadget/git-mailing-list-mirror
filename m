Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19940C433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 22:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245197AbiAFWmV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 17:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245189AbiAFWmU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 17:42:20 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59454C061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 14:42:19 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id r139so4177369qke.9
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 14:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WIzXVJTYtZEHM8ruOV9M2H0B2fM1VugtZE8cb3RrU78=;
        b=gfohxTxFloWhiIQLADUJHVHh1PAzhBh7bPPUnAp99YVMlM2qDT7LVZmyt+03z5sKLk
         oe1LZhYI+aP2s9pw8rsyn48ZJjyYtMkScXf0yEFqgIE6e+Q3YGvT7n92gKkYdcFBHsEG
         ygLHfWYJco0b6sft5NnMT/iEqljH9Dg9c/qF0f6/7hl7uicvefy3mLI1HKBPl5UVmeTH
         on3hr1SzDpFx03kHznebFNON/nyT05OVpFRJma14+ELb6osDzFhS00rxI1qgprItsu/9
         6nVS3KpGJrJFpCMdZcfi6K3qqI0gj3WTqlYoYUUmXKtiP9Uu5dRsBwNPn6NVTsOhXwlY
         igBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WIzXVJTYtZEHM8ruOV9M2H0B2fM1VugtZE8cb3RrU78=;
        b=J1MUfmvCai/gPWVTKw+wlDlTvI0l0ZFRhmBQwdalm2OqJFSKG8C3YoasVqbI92xGxD
         SpUHQCx3p0wpIYmbpAkpKHMeZWsK2sBYBPlWupCjq4RNRVibUeUUwyJsToVrl67uyqpu
         EtN5RqdryQvARvu8P4Ri66dHyWWUsR5RDOQb+lSXeGT4lGjTx5tpWH6o23x4cEI+KIVh
         dQBQzGKTuHmiTzvMVcxJrLNdoAJEbOfTJQnOhqhDBxVUIU2rnkzPGb6f5gHa05HnyTLp
         pRAQAuFw75kdDLZI6P7yOI7S2sGvJNfUkR2SHopmDsIcPWHgAIWW65nmY5v+zw0RYGVM
         +NnA==
X-Gm-Message-State: AOAM533V8buq0E1txue3MzX4Zu814oOHRqhjmqkT6VL4R41qukNwLqUN
        WlERcRIMO7h/FN0hSUwbCNEHlRXzuiuvzA==
X-Google-Smtp-Source: ABdhPJy0hhPIAeIB9K3ng42efF+cc+KmOnOR/SRDjQ1Vnm4A+pm1xoIi/Q5UE06tM6QXiuohDpF+tQ==
X-Received: by 2002:a37:9343:: with SMTP id v64mr5102347qkd.490.1641508938392;
        Thu, 06 Jan 2022 14:42:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d4sm2154753qkn.79.2022.01.06.14.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 14:42:17 -0800 (PST)
Date:   Thu, 6 Jan 2022 17:42:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     l.s.r@web.de, gitster@pobox.com
Subject: [PATCH v2 0/2] grep: introduce and use grep_and_expr()
Message-ID: <cover.1641508884.git.me@ttaylorr.com>
References: <cover.1641498525.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1641498525.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This small reroll fixes an issue in the second patch where a stack
variable was left unused.

Taylor Blau (2):
  grep: extract grep_binexp() from grep_or_expr()
  grep: use grep_and_expr() in compile_pattern_and()

 grep.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  dae476d1bd grep: extract grep_binexp() from grep_or_expr()
1:  71bd2d1bcc ! 2:  f637e02422 grep: use grep_and_expr() in compile_pattern_and()
    @@ grep.c: static struct grep_expr *grep_or_expr(struct grep_expr *left, struct gre
      static struct grep_expr *compile_pattern_or(struct grep_pat **);
      static struct grep_expr *compile_pattern_atom(struct grep_pat **list)
      {
    +@@ grep.c: static struct grep_expr *compile_pattern_not(struct grep_pat **list)
    + static struct grep_expr *compile_pattern_and(struct grep_pat **list)
    + {
    + 	struct grep_pat *p;
    +-	struct grep_expr *x, *y, *z;
    ++	struct grep_expr *x, *y;
    +
    + 	x = compile_pattern_not(list);
    + 	p = *list;
     @@ grep.c: static struct grep_expr *compile_pattern_and(struct grep_pat **list)
      		y = compile_pattern_and(list);
      		if (!y)
--
2.34.1.455.gd6eb6fd089
