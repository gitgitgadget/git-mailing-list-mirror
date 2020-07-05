Return-Path: <SRS0=5lEM=AQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0296C433E0
	for <git@archiver.kernel.org>; Sun,  5 Jul 2020 18:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD69C2070B
	for <git@archiver.kernel.org>; Sun,  5 Jul 2020 18:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNmlVlXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgGESi2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jul 2020 14:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgGESi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jul 2020 14:38:28 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7D9C061794
        for <git@vger.kernel.org>; Sun,  5 Jul 2020 11:38:28 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ch3so884317pjb.5
        for <git@vger.kernel.org>; Sun, 05 Jul 2020 11:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=07CfXpjaXSWK2oHbqS7PW5Uu3Z3++S/VmB4G5p48jUo=;
        b=WNmlVlXYq5T8UQJbDjtvJl4aUGhxHQMc6zG1mqLcW/qdZnfk95ItzkqdqspIxvACHf
         1AH39jGi3IRAKTp8LwvpzIFpXZ5gejJffwM/ZBrJ8d8HLRZ2B0GGGc4DPnyOasVW00TB
         m2PRZden7YdJjRPFX7Ha62d0girsj5sSEfaRKPwiG6L6MF9l2C96S6IHRpisICP8DB60
         pnnmDDifn6ZyPeMyfjqQQjqOVdJ/w9SB+avjqFtb09WeXPKTE/0Vtb1DJkeGt4DxtbBt
         aQeEucjFc9UWGTe5gfNpzac9Y9j/+CuV+nm5LOPGwW1rRpWqLGHDGTDSf2d2RXaj2oIM
         KbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=07CfXpjaXSWK2oHbqS7PW5Uu3Z3++S/VmB4G5p48jUo=;
        b=ooMCv6MtFhpXL06gkaSF0tcG6ywtqi01Fm2AKnDOZ2aJtrSyD8y53c3hUJzGbCEo3y
         8l1D1oGuzSFVd/ALaCV4U6gsd89sKhrk+rcraY87i+JUZgZak29BEOhlMdCLMaCLyiof
         tSFAxfCbmXI6K+xjXzcU2NU0hq6vm+pTK7UCq9VtwiKyDs7Dqh5WbGvifNJ+lW/cxWIf
         iiISNBmqVXbRsMbtbNENS6rdBubbjYuGta2Ti6Alnlg3cY/NTFCY4TWdzCAauK9mcoIA
         x/fyvOS9ZjvpxMqsFORdUVeSsPhDabk7IFE4RlbFKkw+Feiy5YToaT3QYuiDlGE7WVSn
         ecDw==
X-Gm-Message-State: AOAM530qYkkWQOulyiyvFKjOT64J/leTU492fmcC4ofNVmuraj0lWcvP
        2fXvy4WAVBk0cMLlB1WuKzwEP/w4gu4=
X-Google-Smtp-Source: ABdhPJxZxRedAOYpo3xyKOb5TmaAbSr5tK86xiQdArEXJjNIw8Gh9OFHyPD0t09VMqovLFKuq9aKJw==
X-Received: by 2002:a17:90a:17e4:: with SMTP id q91mr16708261pja.61.1593974307095;
        Sun, 05 Jul 2020 11:38:27 -0700 (PDT)
Received: from konoha ([45.127.46.118])
        by smtp.gmail.com with ESMTPSA id d6sm16394160pfn.47.2020.07.05.11.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 11:38:26 -0700 (PDT)
Date:   Mon, 6 Jul 2020 00:08:21 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, kaartic.sivaraam@gmail.com,
        gitster@pobox.com, Johannes.Schindelin@gmx.de,
        philipoakley@iee.email
Subject: [GSoC] Shourya's Blog
Message-ID: <20200705183821.GA31195@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all!

This is the ninth installation of my weekly blog covering what I have
learned in GSoC and other like stuff.
https://shouryashukla.blogspot.com/2020/07/gsoc-week-9.html

Feel free to comment!

Regards,
Shourya Shukla
