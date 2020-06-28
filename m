Return-Path: <SRS0=levB=AJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE88AC433E0
	for <git@archiver.kernel.org>; Sun, 28 Jun 2020 09:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A679120771
	for <git@archiver.kernel.org>; Sun, 28 Jun 2020 09:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbjiZCub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgF1Jja (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Jun 2020 05:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgF1Jj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jun 2020 05:39:28 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A83EC061794
        for <git@vger.kernel.org>; Sun, 28 Jun 2020 02:39:28 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u8so6503033pje.4
        for <git@vger.kernel.org>; Sun, 28 Jun 2020 02:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=LdAYHKKdi0ddg1Hf2wITfG0RUagK4dMuOsXbI1fAgAs=;
        b=pbjiZCub1PJA2ibJpHYLT3mDgE7NVNWVEArmdPsR+Vz9VH137jK+WmsPRJzEU2nKAq
         6EDxFSqvWEKZEbEc/v917rGJ0+xXgxC43n3DyIv3S6+Av5mrxTk3253bxT4+Y5x/GM5L
         EdoHn88z5GFS/1PKGLPDbpPgmEhEyMdxy6Kjp+QtabAzxyq4iebveLBdklQIB/VgQGbK
         eJJOPF5YxPA6p0YU5ZLorPMbYIEWlFPXAgPulKKPR7zjUkPX1KW5fNfFpllXAzM+TniP
         s83/ob3AibB7L5q3HQiQMlPXXuD/AIY0ZMDQxACIZu3fjVFvxg8X5kBTxazAHTlgvo83
         95Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=LdAYHKKdi0ddg1Hf2wITfG0RUagK4dMuOsXbI1fAgAs=;
        b=H5leV+1sw4Hr+tK7YITZ8i8nc+vlzR8WnHIXgg47kLHHO3YV8FjR4xt6vSCMq6Z857
         dOeOm7T4O69vjOLxuIY64oOoTgVoAH66VSWymD/vjy4Mx0g1gBS98YMkjrBJd7aiOpuh
         U6asauiAb34j4Fqthr6aNqhtci0u3OoXk15GCzuBRVkBf8WYL9CiKq7cYPc7X8HepcLM
         mkmI7zGOdqRj3pyHZWZdzWFnFu4MB3R0hxHppNEsm8tN6rOnunvQeVPoLdjKG3w9/sKX
         u7nrM3GQUYWbQdPQyOEw/1GOm80/I2+px0F9XzqDywbDRCdCUI2Jp3vA2Y6RNgZ6BYEC
         Tnsg==
X-Gm-Message-State: AOAM533RH47F0AxSpbJbIwa+2X/e+KqgUGRijGlRGi1hPnoW5uO0PMCm
        mwiS1nN/bMcN0TWJ/EkGqi3W7Bo/g0M=
X-Google-Smtp-Source: ABdhPJzxKzB8wTJxLGNvyx3xX2Nh+ZOJaNCXSnRF/phH9Lkfv6YkPRG7LQnUeLfyDM+umL/55/ihBA==
X-Received: by 2002:a17:90a:1996:: with SMTP id 22mr12389463pji.171.1593337167028;
        Sun, 28 Jun 2020 02:39:27 -0700 (PDT)
Received: from konoha ([45.127.46.122])
        by smtp.gmail.com with ESMTPSA id y27sm7396714pgc.56.2020.06.28.02.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 02:39:26 -0700 (PDT)
Date:   Sun, 28 Jun 2020 15:09:20 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, kaartic.sivaraam@gmail.com,
        gitster@pobox.com, dstolee@microsoft.com
Subject: [GSoC] Shourya's Blog
Message-ID: <20200628093920.GA148913@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all!

This is the eighth installation of my weekly blog covering what I have
learned in GSoC and other like stuff.
https://shouryashukla.blogspot.com/2020/06/gsoc-week-8.html

Feel free to comment!

Regards,
Shourya Shukla
