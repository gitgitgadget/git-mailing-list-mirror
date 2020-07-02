Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A09BC433DF
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 20:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC212088E
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 20:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="0bNkmfQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgGBUGT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGBUGS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 16:06:18 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E83C08C5C1
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 13:06:18 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id e13so26871470qkg.5
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 13:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=KISVEs6yeyZYkm3WmktVzjgohoo2D0lPQZ6dlgIcRzo=;
        b=0bNkmfQb8y8Sq2LoasF89d2VMNvxIGFu3nnxQdinhJVRdnfBNTEbCDVaAdKSDsFPOV
         /h1fzbXGrihkUw7Jzz0SY0UiE96G/GNwROtqPjF3A0prU+OFkHQ8icCOJyoWp/I8ijJE
         Pn1g+OYDoBpBmx+m9IYjr2lmwY7GyH5zEalPrsxIGwcn770til9gMjORnLfaLV8nzcSc
         1zdbaivRsbLYP7WxeZCgYtybUSBlyP1AgdlFzLU0eOAwkBIX5C6iHhrbANUd8R5v/A0t
         2dvkNaO4lm2gVYcEDdjSoe08n6KeeMEcaJTZG/ksruKmZg9e+WU6gviSIw6sGNoRhw7x
         idmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=KISVEs6yeyZYkm3WmktVzjgohoo2D0lPQZ6dlgIcRzo=;
        b=TtWpBMz31lakwtpvQ4fSl8MurgIDT/LXm/Cyb4V45Nw+T3yjJ2Syt4yRYQjbA/Wc9x
         buyTNkiD4SmMOCvtsYXHR+D7VA04xULHOxGJlLpqN25abJES2petaxGMftMk9wY9BZQF
         mAyQ92dBe5KW7O/actqGHyAz2gpnfBgzQFcPJUAojTwUPa3dYjlEwZUq3Vs+GiAPVoNB
         8UtEhWkC8JZElLMe0l5KmPbLC5AKIDDEEWQSzQrJpYymqlJAMGPpeBavSzG5qMcPT8dd
         WIo7RaYEyYU2p+2NPjwDE3uESryEt9WW7BIuFvhJtPHUg9C0hH2WhfVWC0mMh/ZK2r3c
         97dg==
X-Gm-Message-State: AOAM532nS9P5/kPdDNm1WaIRROHs+dqCog2B2oG+6sAjCLMkrJ5nRzHM
        AK1C1sPjDCtog242IlR9fL3z9a+OQ86AZg==
X-Google-Smtp-Source: ABdhPJzy78DH++sCwZ7xCt1u/uo+BSi/PKX3PGCc+OGfLId+t/WFn5WrLu2T3dpIpSL5cpA+1Ul7Sg==
X-Received: by 2002:a37:bcb:: with SMTP id 194mr33039990qkl.103.1593720377064;
        Thu, 02 Jul 2020 13:06:17 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:650d:8c1a:48a0:61b2])
        by smtp.gmail.com with ESMTPSA id i35sm9150418qtd.96.2020.07.02.13.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 13:06:16 -0700 (PDT)
Date:   Thu, 2 Jul 2020 16:06:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org
Subject: [PATCH 0/4] upload-pack: custom allowed object filters
Message-ID: <cover.1593720075.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here are some patches that I sent a while ago [1] as an RFC, but are now
ready for an actual review. Not much has changed from the original
patches, but a few things have. Namely:

  - the 'uploadpack.filter.tree.maxDepth' configuration is new,

  - they are rebased forward on top of Christian's various upload-pack
    clean-ups, so they should apply cleanly to 'master' (in fact, they
    were rebased to the tip of master, not just Christian's various
    series), and

  - the patches have been substantially cleaned up and now have
    Signed-off-by trailer

As a reminder, these are the patches that we have been using at GitHub
to allow only certain kinds of object filters when serving partial
clones. If it is of interest, our configuration looks something like the
following:

  [uploadpack]
  	allowAnySHA1InWant = true
  	allowFilter = true
  [uploadpack "filter"]
  	allow = false
  [uploadpack "filter.blob:limit"]
  	allow = true
  [uploadpack "filter.blob:none"]
  	allow = true
  [uploadpack "filter.tree"]
  	allow = true
  	maxDepth = 0

Thanks in advance for your review (and thanks also to Peff, Christian,
Eric, and Junio for their help and discussion already).

[1]: https://lore.kernel.org/git/cover.1584477196.git.me@ttaylorr.com/

Thanks,
Taylor

Taylor Blau (4):
  list_objects_filter_options: introduce 'list_object_filter_config_name'
  upload-pack.c: allow banning certain object filter(s)
  upload-pack.c: pass 'struct list_objects_filter_options *'
  upload-pack.c: introduce 'uploadpack.filter.tree.maxDepth'

 Documentation/config/uploadpack.txt |  22 ++++++
 list-objects-filter-options.c       |  23 ++++++
 list-objects-filter-options.h       |   6 ++
 t/t5616-partial-clone.sh            |  34 +++++++++
 upload-pack.c                       | 104 ++++++++++++++++++++++++++++
 5 files changed, 189 insertions(+)

--
2.27.0.225.g9fa765a71d
