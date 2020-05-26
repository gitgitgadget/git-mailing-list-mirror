Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF31C433DF
	for <git@archiver.kernel.org>; Tue, 26 May 2020 06:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 762D220776
	for <git@archiver.kernel.org>; Tue, 26 May 2020 06:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYCKdjQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgEZG2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 02:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgEZG2o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 02:28:44 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7873DC061A0E
        for <git@vger.kernel.org>; Mon, 25 May 2020 23:28:44 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id e11so8719680pfn.3
        for <git@vger.kernel.org>; Mon, 25 May 2020 23:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=mo6uU/rH1XFen6vNs8rgLeLRzTkQiBJ3+miBvTlgveA=;
        b=MYCKdjQFde7GVmpkJPUxx6e+6qOiVdj0miqy4FPqko5MgQza1PmxfZe3JyWMbh6TZw
         Pg85lcjs1NSG0sZKHQC+yqvYDGxzYtZ5P/yDSqFJn4iPy9ragkzEX4UYxNu0+lXC2Uxm
         9+QpC5FuwdB8PSkJLppGODRosKs7fyFfdm6Huqx98P2F+wNws2D/GLohAlJvjMdBK3JN
         PEVqVKI2embwm32DbyTSJxtz915YpNLt/2QiXJ0dYmnc0aKqVNBoXmie6mXLD507sp+r
         K9BO8fQr8JkhVC4hp6sDhMAXS3CradpK6R+FTWiWgQVA0f5JnjrVLIV+j06Q5Vdbd5hk
         30KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=mo6uU/rH1XFen6vNs8rgLeLRzTkQiBJ3+miBvTlgveA=;
        b=WAox9IOhcK1DGbSYCdPRporjGzpcLQ+pi67aRH510NxorHlH41JoAJJg79rUKSSABt
         qDye2UX0rwzpcqb3hvI98zQ0aNxkMZGr3+vhYqpx08w0Nwy+xLQxCSNL+IhsKNIISIk4
         5NtrgBAlrbiFe/lO8LNQlOjEq2dI3M394W63lYZ9mTNij/HVEjiq2ct0fy+FfbfrPM4E
         Ic/H9tyrrAT8JXMgkmHMuvAL1pCCSi0zmaKFYVf7yi9CYPXz3qCIAI4xozu1VR9xPo3p
         82wQTnMDe9y6etL7Lbee+Blmnu5IA1bTD+nUTnam8ynopVm35pHCpETlDS11gNoFRryT
         tQEQ==
X-Gm-Message-State: AOAM533wgdpspfc33Gjnp/mNbYO8aAvmNGkznHdfI5JwZHuWAiIJIKD1
        YEY7VBEmTpYm6jGS97s93GuSBYc=
X-Google-Smtp-Source: ABdhPJzURzY5UYduTAm+myqYiJAp4J+i5d6PSNTSe6F7Wdk1jvL6SEGL9Z/51bckRBzWiZzUlD1QFg==
X-Received: by 2002:a63:a36e:: with SMTP id v46mr29431805pgn.378.1590474521864;
        Mon, 25 May 2020 23:28:41 -0700 (PDT)
Received: from ?IPv6:::1? ([2001:19f0:7001:5397:5400:2ff:fec6:e36b])
        by smtp.gmail.com with ESMTPSA id x22sm30558pfn.26.2020.05.25.23.28.37
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 May 2020 23:28:41 -0700 (PDT)
From:   Xirui Zhao <zhaoxirui434@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Bug: "git restore --staged" on a newly created repository
Message-Id: <1F3FD418-38D2-4A10-A882-666D4327F993@gmail.com>
Date:   Tue, 26 May 2020 14:18:34 +0800
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tested on git version 2.27.0-rc1 (latest build from master branch on =
github) and 2.26.2
`git restore --staged file` on a newly created repository outputs error =
"fatal: could not resolve HEAD", but `git reset file` correctly unstages =
the file.=
