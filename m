Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99CEC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE693206EB
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Bucnsh+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgEDXM1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 19:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgEDXM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 19:12:26 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF57C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 16:12:25 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 145so6335520pfw.13
        for <git@vger.kernel.org>; Mon, 04 May 2020 16:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=cjyhBuX3m7cDAzP6ekmZAej+6bfj4rg+wXyoHgu3QQE=;
        b=Bucnsh+cU4G8D737ajEGcvsXR7CBwB3ZSbAKOKAjZVRDxJq7v3AtgSzUPgVxTXODmu
         Aphax/xFB0ZfTHODk+cP84e4skIvSXBs3WZaUE99ePIExqeS0mVWPIAKnDLauFWxbf61
         S9JDJl2W0ztyfvyZdUALIWtONBrN8fIkmmxV3uvdTJaWjGfC22zZX0F/5uZXEsp10IHg
         +5S3uirpm6z5ly7AYM34gpeuLICsSAEYy9B5+3kUMDqUnMhSyi3X3NVc2dDUq6k/2YM8
         SL6iEL10S5NZ42JhJRs7QmMeNE+hhvTgtNPcY/2DI6M2+eIWiFSM6khtt9jPDnphsg3u
         D0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=cjyhBuX3m7cDAzP6ekmZAej+6bfj4rg+wXyoHgu3QQE=;
        b=FOutdgSUABivyOkHsuyMgbascf30fWph5AYeVWJOqGRUQeaR2Yk9iK7hP6FBdvSW1+
         7FsM9VWP3WVrO9ZyuiheQmOtG9FtC8+6hEIVN0k92A2HfYg3wpmyVFWrRyQEPPUEpZA+
         6pCw32oSpAAcrQJyPZ8HFmhQfh5fhyxrLiqly2j+o3cRFSW4FRCNODA5qyW7q6y6d3of
         GTG34JR3CxiR+dmZXwFTFy8Nbc2wnN6z91XUx96LvVoC5ZeUJ8TfFZUBL9+DWLaRBxFV
         Z6yHAeXDeDsC2+V3GK1/vb2gP+eKnozZ7kTxE3/ZF/hXA+raV3vrECbykmHZbUDbLNh6
         EtBg==
X-Gm-Message-State: AGi0PuZLkBXRMusx814e9tRMPVXs+iueGu2zDgeIxUIUoJg7xnfJlwHG
        Pq4oe+gAcie4xCt2mP5E39F/e0/28eW6FQ==
X-Google-Smtp-Source: APiQypKYdwrg0dbHAXbIabqL3OAvgd1wIC7r/shMPWHt9k6YNXFrf21DLdj/dpOzRd3uuOZXDpFvfg==
X-Received: by 2002:a62:7cc1:: with SMTP id x184mr274992pfc.282.1588633944672;
        Mon, 04 May 2020 16:12:24 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id r78sm164583pfr.10.2020.05.04.16.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 16:12:23 -0700 (PDT)
Date:   Mon, 4 May 2020 17:12:22 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org
Subject: [PATCH 0/4] pack-bitmap: use bitmaps for traversals with
 '--filter=tree:0'
Message-ID: <cover.1588633810.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This is a re-submission of mine and Peff's series in [1] to get some
more eyes on it. The intent of this series is to take advantage of
the type bitmaps when using '--filter=tree:0'.

We have been running these patches at GitHub for a couple of months now
to power fetches with '--filter=tree:0' (but no other values of N,
patches to come later to address this).

The content of the patches attached are the same as in
their original submission; the only change on my part has been to
rebase them over the latest from master.

Thanks in advance for your review.

[1]: https://lore.kernel.org/git/cover.1587597151.git.me@ttaylorr.com/

Jeff King (2):
  list-objects-filter: treat NULL filter_options as "disabled"
  pack-bitmap: pass object filter to fill-in traversal

Taylor Blau (2):
  pack-bitmap.c: make object filtering functions generic
  pack-bitmap.c: support 'tree:0' filtering

 list-objects-filter.c              |  3 ++
 pack-bitmap.c                      | 72 +++++++++++++++++++++++-------
 t/perf/p5310-pack-bitmaps.sh       | 10 +++++
 t/t6113-rev-list-bitmap-filters.sh | 21 +++++++++
 4 files changed, 90 insertions(+), 16 deletions(-)

--
2.26.0.113.ge9739cdccc
