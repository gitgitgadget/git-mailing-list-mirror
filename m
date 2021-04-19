Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0965EC433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3C6F61157
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbhDSL3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbhDSL3T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 07:29:19 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C6CC06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:28:48 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a4so33635841wrr.2
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=KKCKfQTha55hU+so4A94f/K88Xfh/82MpWVZnZGMyL4=;
        b=B+whPVoow3FAR+IX18wTpi9PKAFqSsYYy0xPWKswa61xuXbpIEoWtUDFwn2AggegE5
         40sx4BmqADD72JhA5Fdi8E7a2DmVcX8uIfFgaxdiC88AF6XmZs32LiJ1c0niXFLaUWR/
         iNeWuM459IRvwhDJW2PCyJB+034chsqZPuU6um2gnrWh902oWvgLAXIYtwzdcxGsMqb2
         lgPnhxf0sIOu9IkztJdc9e61IroeO75V6ncOrS4Bopm1by0elC9S+ZvWi/M9nkisfHGw
         tvXu71DL8gVtQnpF6/KQnpOyGEIiFbSV3hxdRLdYzoW2NQOXoVmTGs1lynbo7sIGSDin
         rYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=KKCKfQTha55hU+so4A94f/K88Xfh/82MpWVZnZGMyL4=;
        b=Am/h/YX63X47gTn0PZkFtq11nQsF6BB4T2dXiRtG9gBsmqX67AaBuGsJZ9Xuu6H7ls
         1ltNAwsJcYsKCqlQbf2wZow1gSUZFDJFM67SSKh6UaInweaviGFiYbQ1y8YXIFIUnUQJ
         ISeBzZZUvN0PYTf7TO3TYcW8gLOox1BnnCCE4bAsuQ35Ff0ARAJaV1fYG25wUU7s2rXc
         06GLVdIhAK7/7abd4CIuZfOAmCfnMIY0aCwzFVKNXrSbTeecEZwsoVwTX5dEtvSWx1jk
         +XvO4PsZ6ylpJLCFLUUj3wBwEpvPL0mJWQmiBSbBlv8yOTU7Y6rxZxfQIV1Lg29mDgtu
         QnLw==
X-Gm-Message-State: AOAM532BJ85CRNrg45hDufKAUyYeV9vATjJyHOmUoiDjwlC+rpGECuN8
        ATy5nw6zEjgvF3L5r+rxre2U935b5X0=
X-Google-Smtp-Source: ABdhPJz2e5xtkZWhw/bqL1VxEfqdYbTnW3QamaleX7qWvc6v1VBYOmKiU67SafPOEJGOHLXWTuPQ0g==
X-Received: by 2002:a05:6000:184a:: with SMTP id c10mr12527136wri.237.1618831727117;
        Mon, 19 Apr 2021 04:28:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q126sm9515424wma.6.2021.04.19.04.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:28:46 -0700 (PDT)
Message-Id: <pull.935.git.1618831726.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 11:28:43 +0000
Subject: [PATCH 0/2] [GSOC] ref-filter: reuse output buffer
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 * Firstly, inlining show_ref_array_item().
 * Secondly, git for-each-ref reuse final buf for all refs output, the
   performance is slightly improved, this optimization is also applied to
   git tag -l and git branch -l.

Thanks.

ZheNing Hu (2):
  [GSOC] ref-filter: get rid of show_ref_array_item
  [GSOC] ref-filter: reuse output buffer

 builtin/branch.c       |  9 +++++----
 builtin/for-each-ref.c | 14 ++++++++++++--
 builtin/tag.c          | 14 ++++++++++++--
 ref-filter.c           | 25 ++++++++++---------------
 ref-filter.h           |  2 --
 5 files changed, 39 insertions(+), 25 deletions(-)


base-commit: 2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-935%2Fadlternative%2Fref-filter-opt-reuse-buf-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-935/adlternative/ref-filter-opt-reuse-buf-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/935
-- 
gitgitgadget
