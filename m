Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5642FC4332F
	for <git@archiver.kernel.org>; Sun,  6 Nov 2022 20:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiKFUmu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Nov 2022 15:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiKFUmt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2022 15:42:49 -0500
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E98D2FA
        for <git@vger.kernel.org>; Sun,  6 Nov 2022 12:42:48 -0800 (PST)
Received: by mail-io1-f41.google.com with SMTP id 63so7458240iov.8
        for <git@vger.kernel.org>; Sun, 06 Nov 2022 12:42:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FeagfpuZjhDHkvzbqGljuT3+kkbjyV+PAxrImFeSG/c=;
        b=3+/EChbqCpwdqDwzv6P2uY6xelqL8if/pc1JqAeurRrOCjAg/eEFQ209Fi3xoYZzwu
         B0keghwTEXmtx6kzqE2rfNX1y6dREbcjusGu2sSXy1iJAr7ffoHN3pmn1aVWcQZAWw3Z
         5GN3YOnm8PNQ86ft1AhlbhMWeOXfkq5/euPwB1e81IXh+faaRM72Ka3jPf9v7rf5cHZS
         nFIcOEXI/rSSGX7RxznjGKWZBY1pT4waVXd4xicp2CDjyYCaLrxySHC5Y+aviu9UPvmi
         EJ1jHTubv2b/OmkpghsfRSeOyAXzlFBQPdsEzBU+keaTzp5uhHt2XYjs+E96ezJ17lTc
         VN7g==
X-Gm-Message-State: ACrzQf3sbkVdqTSrjlKKYHL1fL6qE8ZWySew8NXGHCMbthdGX7wjEcXe
        4OFL2DGxwGaRhKkk2VYU4Pz2+O9dbQ2xPIi/VCc=
X-Google-Smtp-Source: AMsMyM7Vra/JH2LbmTc0738/GtprpaBK2ZHSGangyavmt9gXmoucfF0khwKFNLMBgyHDHIsEhgM+uh8azR/gci1KhY8=
X-Received: by 2002:a02:b10c:0:b0:375:8839:bd9a with SMTP id
 r12-20020a02b10c000000b003758839bd9amr12518100jah.177.1667767367476; Sun, 06
 Nov 2022 12:42:47 -0800 (PST)
MIME-Version: 1.0
References: <64b10e7e-2807-8ae5-88c7-3df7f6f1f3bd@opensuse.org> <15a2baf8-53f6-de75-a6bf-ecb4a83d78c4@opensuse.org>
In-Reply-To: <15a2baf8-53f6-de75-a6bf-ecb4a83d78c4@opensuse.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 6 Nov 2022 15:42:36 -0500
Message-ID: <CAPig+cQYL4wSwVLKGFW5fATDh8uw87EmZGZ-k_uJdmxBiaSsQg@mail.gmail.com>
Subject: Re: git can not be built for s390x since update to git-2.38.0
To:     Sarah Julia Kriesch <sarah.kriesch@opensuse.org>
Cc:     git@vger.kernel.org, andreas.stieger@gmx.de, tmz@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 6, 2022 at 2:18 PM Sarah Julia Kriesch
<sarah.kriesch@opensuse.org> wrote:
> We have also identified this week, that chainlint.pl --stats says "0
> tests". That can explain the empty output.
>
> ~/rpmbuild/BUILD/git-2.38.1/t> /usr/bin/perl chainlint.pl --stats
> --emit-all chainlinttmp/tests
> total: 0 workers, 0 scripts, 0 tests, 0 errors, 0.01s/0.01s (wall/user)

Was `--stats` added for debugging this issue, or is that somehow part
of your build process?

What is the content of the "chainlinttmp/tests" file? Is it empty?

It is quite curious that it reports 0 scripts. It should report 1
script even if chainlinttmp/file is empty. This might point a finger
at File::Glob::bsd_glob() returning an empty list for some reason, or
the problem could be a failure with Perl "ithreads".
