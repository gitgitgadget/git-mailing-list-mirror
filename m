Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7CAC433E1
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 22:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3544520658
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 22:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1zGvsTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgGNWKt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 18:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgGNWKs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 18:10:48 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51CDC061755
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 15:10:48 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id 72so7659068ple.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 15:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=HhvkG5BQl3RIdwU8nXS9cK0dK/+XLKF4vgfgIHl3wNE=;
        b=o1zGvsTXOqsEVOThNSO6j4k5gIKLxBvYbL8SOcqMxedC3GcP9xy7rbm1yzklgiGPa1
         7Y5C+yJHPiM6+tMG2VkOfDr5WPRg8TIXqtMB3/yZIi3PBG3z2FKThTdpQguyMczCKqh9
         xBWkLCVVtSHBCEchjh8uAsIWmDMbTj+Iy+pW1Y3s81eYdXBNXvNrGtr+37YPcXBURIud
         ragsKlZ1zbtgvwXuK0s/VfBBnZn9tnQ6yoEa/ipYg6cqLIesoay2ILTSaixCffZpf2NY
         3FHjG7a/V7TvPSRRaQKGqiD8hYuqB300hkw4/+3R9nYed4vc5XKZ51ROx2lub7pQLlQa
         GAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HhvkG5BQl3RIdwU8nXS9cK0dK/+XLKF4vgfgIHl3wNE=;
        b=LRf6W+pumNen1clHF5Okw3ruiKVDpz3QLIfyKrkRkUUzZHr6i4g2xDADtMmTBI87sG
         UvVfvT7FCFymUiE4HQBFxvMoSw9ip8Y2KOSTZQmOEuNcUr/Uwz62h8YSEAtQ2Fo9aqcx
         +r80WjWofpZY+1FztlSukdgLBF9RZw6Gc6MiAXKWtNM/DZ+PEKAl8YKklJlj51GtROqY
         yl+rD2MFmugvZjBJysJ2xI0JKVbKpuZ/pSHOj0wxOY6H3snRtHv+WPCGjqr/pBtFAyBJ
         Eup8gruuUhQybg4AM4XGgk0oeehJRAwz0glM4MCaZwuoLqaBZ4WmUwgFgSSUcB22bb61
         0QYA==
X-Gm-Message-State: AOAM532UcLNIp7qry+6ISD7RdDRo9qwXCD9LKa6uBVA8OAPNDX/yvix+
        qjBO4mwhMAaZuXGPk3x+WmUjZI+gCtM=
X-Google-Smtp-Source: ABdhPJxZ12kv9HbSIDbWC0HXeXWdTZXjM4ne9sPxrW6FDn+dbNTg1KRc8vwMVYqKT/wXRpbm4ygXSA==
X-Received: by 2002:a17:902:547:: with SMTP id 65mr5476173plf.191.1594764647845;
        Tue, 14 Jul 2020 15:10:47 -0700 (PDT)
Received: from konoha ([45.127.46.137])
        by smtp.gmail.com with ESMTPSA id d22sm139777pfd.105.2020.07.14.15.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 15:10:47 -0700 (PDT)
Date:   Wed, 15 Jul 2020 03:40:41 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, Johannes.Schindelin@gmx.de
Subject: [GSoC] Shourya's Blog
Message-ID: <20200714221041.GA130922@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all!

This is the tenth installation of my weekly blog covering what I have
learned in GSoC and other like stuff.
https://shouryashukla.blogspot.com/2020/07/gsoc-week-10.html

Feel free to comment!

Regards,
Shourya Shukla
