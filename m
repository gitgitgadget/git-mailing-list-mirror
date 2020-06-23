Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BD1C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 18:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35024207FB
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 18:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCxhq0ZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733075AbgFWSOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgFWSOk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 14:14:40 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89874C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 11:14:40 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i12so1820739pju.3
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 11:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=A6r5WVuVjveBOnOd9hP7NPouwVUBqJjPNXPr91koyCQ=;
        b=OCxhq0ZZLVD+MAv6VXKgeEBBzkk6aJMVoOvoxbB2rHJGYlF+I5OvKVTRVvPY5sGxy7
         i+Qi3an3DFzXVv2GmXq4HxslM2QyzBI/bOB6IT0nZPf1/0KkeBjRNIO37kIIz6Q3wKz1
         O6Nwtn5BDPFWzwrdTpUMu6ljOMcF3E+FSC/bArQbDUbidRVnvFdxVPcl1r/x/CN/mNsg
         wsmcuP85Cz4+AohjNCLu9dOu5MeVYm0aquqOBLE0VdVMeXD4cAPkrQOjtI2qqgaR/h7D
         NGzF7Tm+K7L0+zAVNaDfwaknWYAKA19EI28SHMLsJs7fy+GdVBKcHzoT9AqjkTCJbHr1
         ZhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=A6r5WVuVjveBOnOd9hP7NPouwVUBqJjPNXPr91koyCQ=;
        b=AK0MslRPLOTv+3FgCGhkjcbMU2BRFpqapUWQdqx1mhmDYVF3nPPP36bKf+rzwN3+wW
         JFvgMFKGB3q5bFSoxFqjn1fj13g7UOI33+675UlBZ/vYCMCItriypNnWmxMcmdaw9Otp
         OABOkvCWNl/4pRA1kqwScMDil7/anvEAEcZi7NMH+3A9RlVRb6NOA7ElmxQrn56mge6m
         hABDuS/862w7bWNG4EXruvNlNlUghPFCL5x95bn/ZmTxaGhA96Hor8FI6nRJ++MtfUg+
         Km23xFdDWMBvf0XmmXOTGZ0vLuKqH5utfY6HnslJ+sYHiR/M6CyctDJAxKEJNE1rvErV
         FfEA==
X-Gm-Message-State: AOAM531J+eNlxQ9lDnaXHhJNV0VWzW8fYP43v/i0b0MCFrFm49ar5gFn
        r4faWzTbLchSHgVEhvBH8xEAzHh8PYQ=
X-Google-Smtp-Source: ABdhPJxzShax8kiLC60DVh9ooYvYycEBvSAVhLEpCfIP3+yf280OfXSTGX6292vsSCTd+dbLHfbCqA==
X-Received: by 2002:a17:90a:b295:: with SMTP id c21mr16869538pjr.120.1592936079603;
        Tue, 23 Jun 2020 11:14:39 -0700 (PDT)
Received: from konoha ([45.127.46.97])
        by smtp.gmail.com with ESMTPSA id 25sm17483196pfi.7.2020.06.23.11.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 11:14:38 -0700 (PDT)
Date:   Tue, 23 Jun 2020 23:44:33 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     kaartic.sivaraam@gmail.com, gitster@pobox.com,
        christian.couder@gmail.com
Subject: [GSoC] Shourya's Blog
Message-ID: <20200623181433.GA18998@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all!

This is the seventh installation of my weekly blog covering what I have
learned in GSoC and other like stuff.
https://shouryashukla.blogspot.com/2020/06/gsoc-week-7.html

Feel free to comment!

Regards,
Shourya Shukla
