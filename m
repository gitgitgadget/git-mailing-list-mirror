Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ACCC4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 20:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51349207E8
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 20:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bakanov-su.20150623.gappssmtp.com header.i=@bakanov-su.20150623.gappssmtp.com header.b="vLZCIKv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372725AbgJ0UKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 16:10:14 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:40455 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372722AbgJ0UKM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 16:10:12 -0400
Received: by mail-io1-f46.google.com with SMTP id r9so2943581ioo.7
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 13:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bakanov-su.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=hYNa8Eak/lEgK1xjwfnryGyTzRdQOUhWVTlhypmBu2w=;
        b=vLZCIKv3AqCD5o8nw8SJG4EWtZePFPh9AOu39Kwk7cqSOXp1SKx9PowdNd97XC1Bgl
         iE/I1tYKt0mWwL6IP5S9T4IFxqZeW0kZ0k8eeQJUI9AtC02yQnbXFtLrNvnxkks8C/Ma
         VEKrur32ugRcUwFxhKtmyTnghDptlbTWH46z8nN0c+DrVqnmPPo5pre6+JkVZEhIITro
         K70qNuuSPYjHclHLw5Wc+ZldZU2G0f9AohIPxvIBBd40cxwCEvpTFLnXKF4H3/VREHsK
         z6ym8C7dEl48CCbm6A/sPzp5pvv9XVGFLOb/PzNnWdTqw+HOY7bYTqH6M0uI0Q7RcRis
         sqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hYNa8Eak/lEgK1xjwfnryGyTzRdQOUhWVTlhypmBu2w=;
        b=JR3S12US8xPv9aqu6krcOmybsxySrbeKbRpfVAi4u9YCk/DohGxwZVLBR8adYD4XNs
         bMaMTsjKZkIOdTRSltZNSVSkYP52jT/kDNSEdlvCcJp0ZRwFPSBJldROtKWbTH8WXH/a
         Wjb/HWMWYHAqBBBmYrPymJAnbXcB5PCyLJl8f6IBU+GeoRIcgI25SqXCm0Jlq9A1b7QM
         SJ/cvhOgXfKEmEigJ7JGkbf09L6XYywFcrWwzrw1k+QTLg8REmf5vm6glyVxsNcX0sNY
         Qf8F1l/sn/8ClK+xOZPv64wgunc2NwIGlUlH9Xfr1p7V0fOnF8VKN9j/8QVn2sCGKXX7
         JLSQ==
X-Gm-Message-State: AOAM532YHe5CbBFFOGVl6Jc20dlHHw/Zqeqw0TgAKBgonRTnN6db4KCb
        KCOc5RsTEU9X2ZblQoAUZngEtsz73RqzOhNceF2JMSu0Kdoa0IdX
X-Google-Smtp-Source: ABdhPJyILgi62G0L/IvWdy80xWZfd2K/2INRGW5ZV+aLdSMtejvFjyLQcQT6WhSyBaPrFA3oBocRSoDBR94m6NfBoB0=
X-Received: by 2002:a05:6638:1381:: with SMTP id w1mr4088913jad.79.1603829411612;
 Tue, 27 Oct 2020 13:10:11 -0700 (PDT)
MIME-Version: 1.0
From:   Filipp Bakanov <filipp@bakanov.su>
Date:   Tue, 27 Oct 2020 23:10:00 +0300
Message-ID: <CAAdniQ5pRHKUU77XVmZkZ_gUgfYYFpo9=Xt2T6EgzJ3hoT0YMg@mail.gmail.com>
Subject: Proposal: "unadd" command / alias.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi! I suggest to add "unadd" command, that will undo a git add command.

git unadd path/to/file

It will be an alias to:

git reset HEAD -- path/to/file

The motivation is that I always forget syntax and have to google each
time I want to undo accidentally added files. Unadd is just much
easier to remember and quite obvious.
