Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C492C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 07:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E74C20734
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 07:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHQNuY0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgFPHVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgFPHVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 03:21:16 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCEBC05BD43
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 00:21:15 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h22so1132681pjf.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 00:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=zRHK1V9SkTi0a7wjGNqs5ae4k4njQb5xhq4wr1C/mvo=;
        b=VHQNuY0VwpO6FQ5yg29VEuJG7bcsQxC/tw0KeMEJTWwhGnKUHykDbfI6VKm9mkrqC7
         RjqXYv+wtKprQgYta8TYmtSPK4mcIKsqBw2HeGNkyziknNsFquOs6G98zGDSyv3KA+xx
         5uWmEOZeeAcppChxwfIySEiLaR8D3LajOSGfgKnOBAEjlGQxgfVvaS/Xa6VixaIgqBFe
         19bICKrIlT53FD20WZX/Kg09HdhVn/ZvMUuzpACJU0vw05QXURJnvvv7gKMNusgOPHdn
         BhWEH/KJlkNB4KVc/kEtoNwpCi/zAhKPYJv8Up6bneS2IYn/JYXUHiB8CmkFGCqPzK88
         x+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zRHK1V9SkTi0a7wjGNqs5ae4k4njQb5xhq4wr1C/mvo=;
        b=Nq1WNZCbvAVJ0aI/5UsCrPRFvQ/IzFGFJrM87ScGPg7UZQDrC8UNn9mfhVz3ZEFHS1
         diyJj0HqGkEuqsko/VxYrWMzGsF3wHMQlXdjF1qJwQPsGmopKBMeJmFGNitg4dEHGvDW
         ppJ9DZgkTbNZoXpVxjfxWTss0DAJWhtrYC8XXDk6S5/0hwvf+4CStYtopk9/gC//w3Gp
         BMhfGtHxPu3yUnR5wRiZY0w27JPO0gvU762K+wRccqRzgoiyWgm8rqgyRjyGOKu2dBvk
         vPZHeiASkHmhCdXF55lk+HUR9TieWAaqDvGu0ztrWiC8sU9eivGKX8nIKLGtIyrWEtyM
         NGHQ==
X-Gm-Message-State: AOAM5320oOCUR293UU7FhsI+HrFszYFSGj9qEuTdX8Nq0uuxwvx09Eal
        8aZ9Fp1Bk4itCgDvc4V9nIlEAgPp6Xs=
X-Google-Smtp-Source: ABdhPJzqV9nVhsSMkRRPMLXxrjGou9TlvosDvNDmo2BAIWIVD8s8qW7k0eo0OG4HYYt/tCB/gV1exA==
X-Received: by 2002:a17:90a:a616:: with SMTP id c22mr1684524pjq.14.1592292074583;
        Tue, 16 Jun 2020 00:21:14 -0700 (PDT)
Received: from konoha ([103.37.201.177])
        by smtp.gmail.com with ESMTPSA id v28sm8836939pgn.81.2020.06.16.00.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:21:13 -0700 (PDT)
Date:   Tue, 16 Jun 2020 12:51:08 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     kaartic.sivaraam@gmail.com, gitster@pobox.com,
        christian.couder@gmail.com
Subject: [GSoC] Shourya's Blog
Message-ID: <20200616072108.GA10273@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all!

This is the sixth installation of my weekly blog covering what I have
learned in GSoC and other like stuff.
https://shouryashukla.blogspot.com/2020/06/gsoc-week-55.html

Feel free to comment!

Regards,
Shourya Shukla
