Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D13C433E8
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 09:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DB1D206F5
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 09:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="din5fDQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgG1JYr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgG1JYr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 05:24:47 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60834C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 02:24:47 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t1so416492plq.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 02:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=37gHgUaOLb7fgwhcQqa1jfClfu0pNuvj4p9fwiiVKkE=;
        b=din5fDQqM4xosFerX/6/fYgnPUUY4hWo6n4KswwN3x3STaPdfFB5JBiS3LPMXP4i5c
         c/50jyGJMMNW+IuJL82dp8oTHGl2Z3So3EsScUh04MHENtikmZYJrwPV9JQ62BzwOjKq
         A2FT+mcERUn55X/l7fW1VOroK5zDuFfqgKV+lWEOJFp47bDiqHolXc6Qe+gmZE5z2dUh
         z2lIH8lEnK5f5bbKbo64K8dWkZifvsLyYS0ohR61VHByjZI/ptZcstiepUtYzQgvjbvg
         kOZHcDfCM7yQ3WkJR2n6CoqYm8e4qCEiFgzvMJ095AdRT15VsrKxbdtHJa0dv6h2cMe3
         tLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=37gHgUaOLb7fgwhcQqa1jfClfu0pNuvj4p9fwiiVKkE=;
        b=Y0g4qfxVWHVPndnu558K1B9Ivs+kGYwIoqeQvVz2wQ0+ux7w6jD/F8nRDnWREostFr
         BmhocLi7Y5uCl8X6R7Ru+o6s+ml0RaPBhcOMp0To2nAddo/JQx70jtlWMMUFLma6HyBK
         t5hW7TUCWdSxsWvs6smappq1B89pB7koduy/cnlVy4T5VACfx2ZPTdGwpZBMdC2H03Ai
         ot0D9rqIGrXMinVHGEgVtRGzuaHRe62IQibEwBfgjMK685TCqa4qsB8uCZ1OPqzz1X6H
         31ixax894g5r6BEaW0tCelw44Ckf8wyUfzeVcBPaWnmdpTp1DaBBKO1/ghLo7rirGRtB
         dZsQ==
X-Gm-Message-State: AOAM533QiKNT8PBEZAPeAvCPgQbFk7qi/54jVqT4whd8GtPrNA6SMjX1
        gM9D9nfxdWRefKS6TRnh3aM5U3i4c74=
X-Google-Smtp-Source: ABdhPJz001ak5YtAp2JRplH2Zw6hxG+z8ZHzT2D9/wht+FFODjhHnt8osp2G6yTaiEDmr0WoIsYrlQ==
X-Received: by 2002:a17:902:c181:: with SMTP id d1mr22061748pld.176.1595928286651;
        Tue, 28 Jul 2020 02:24:46 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:813:2f37:ef51:2630:8740:8aae])
        by smtp.gmail.com with ESMTPSA id m140sm17972093pfd.195.2020.07.28.02.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 02:24:46 -0700 (PDT)
Date:   Tue, 28 Jul 2020 14:52:41 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, stolee@gmail.com
Subject: [GSoC] Blog about week 8
Message-ID: <20200728092241.GA19267@Abhishek-Arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone!

After a long wait, I have submitted generation number v2 pull request to
the mailing list [1]. I have spent most of last week running around and
fixing bugs, gaining a deeper understanding of how topo walk is
implemeneted.

Squashing "return 64-bit number" and "implement corrected commit dates"
seems to fail tests for t9807-git-p4-submit.sh (which is pretty
unexpected). I still have some changes to work on, and you can expect a
second version of patch series soon.

I look forward to everyone's reviews!

Thanks
- Abhishek

[1]: https://lore.kernel.org/git/pull.676.git.1595927632.gitgitgadget@gmail.com/
[2]: https://abhishekkumar2718.github.io/gsoc/2020/07/26/gsoc-week-8.html
