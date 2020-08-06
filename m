Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1EFC433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 21:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6FC62173E
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 21:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Opd1adV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgHFVtd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 17:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHFVtd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 17:49:33 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD04C061574
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 14:49:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l4so51853141ejd.13
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 14:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=AdPYNRNTjnrVHKkRc/sKTpgJSHB57mHgvdfXtwWMwS4=;
        b=Opd1adV2s2swEkPsy4nJd6pBANSInQsJCutK4lp6SgJvT1jYIKW1LNi3ogm3QVaGss
         W3U7gqN5KuLVGCVIVEqkegzebkARnHS+BUrEGDdLbEE9t8ckv+E7vOdHoozdglz5q3nq
         kWOrht3+0qVkU4PGKHIDF+s8/8LPMjROmhxDCQ9XVWNZdZSYUCQgaACagHTUOL8kozx3
         Hv2c9CfdgweV+PLvQbPs2L3vzqtwjRAsRL3jD/3F0qR1EdHL+mKetzg778yYP19qxeGR
         H4TSchyJyMjl24odDhQq9OKzWziqfJWRvI2mCISgQCJ/lAFlv0fb1KyHYMevOMWBuZQj
         YUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=AdPYNRNTjnrVHKkRc/sKTpgJSHB57mHgvdfXtwWMwS4=;
        b=EUiY8RuEBNJQ7VYfYCj2l+J5n0Hqx/V4cioppEA0WkeyLpgbCPnUN68MvqBTrLv3/+
         2zzqVv7qbpNWYZ9PO+40kGtiHxQnvdi1vSmTvPSXszEffdjbEA5zOrhrBwODs1z8PaKz
         sSHnqEGcRdJ3IDuww4GKSPyjDTloaAwdertAAy9Y22NVNqN8dldmjTS6YG3zsyF6/hXu
         pgX5HfcWaroipAUXsHR9kZMswgv36OFUlEvvKP84VPc3H32vnIlNVXWqUNKMcQW+5M0h
         SiO2o/nJxuo0VQWotntcDiLL97wun6ssnjmnZ3rhD99t9nKBjVZPnGEI2N2WyYOGJCze
         Gjxw==
X-Gm-Message-State: AOAM531+LQSEE4/IwrV3LJUlyWUX7VmoofR0V/9i7H+v+/SI7N+ljkwS
        2ZHHrUtxNJ+VTWN7bFlRrm7evg1a
X-Google-Smtp-Source: ABdhPJw0tFB0zpY/14F3RcvO4+e++JSL8p6nQn4k2J7PTuaSczL2sOjekXEa7sjbIQWk/4hfZlIeag==
X-Received: by 2002:a17:906:a284:: with SMTP id i4mr6582296ejz.490.1596750571025;
        Thu, 06 Aug 2020 14:49:31 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:58ef:a849:7391:1aff])
        by smtp.gmail.com with ESMTPSA id w7sm4494590ejy.4.2020.08.06.14.49.29
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 14:49:30 -0700 (PDT)
Date:   Thu, 6 Aug 2020 23:49:29 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     GIT Mailing-list <git@vger.kernel.org>
Subject: gc docs: git gc --keep-base-pack ?
Message-ID: <20200806214929.22qgjg3o2noosjuo@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

In git-gc.1, in the part describing gc.bigPackThreshold
there is two references to an option '--keep-base-pack'
but there is no such option (and it doesn't seem to
correspond to '--keep-largest-pack').

Regards,
-- Luc
