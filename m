Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F22C433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 23:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA6B206CD
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 23:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgHFX5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:57:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53345 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgHFX5R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 19:57:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id g8so203821wmk.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 16:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=f4mbME9MvBA9a/Wla45b6fC3YCt0zngdWVF9pw/pEGQ=;
        b=h3nLcuw8tezB6pIYeqYQ71kNx8nwnZx4QG4/0BF+lhIJI3NVg+WBJ3IM/kAmnqKk6r
         BMf/RpAwIb860IHLTeeAnw/Q/8ZQv1ULC0+VoRyUO0XRKAM9TUQ2a/p7EqwS6CY0kctT
         bkxStOTrkw5+fkAQtXvb/iTNySoTPGvZxcx7BvIThRXNSi4iXN4zHFTg2dO3Wx6MkIxH
         qHIHk/bWKf4W8D2wFS8wrlmluELENySWf615UABy12ehKWAQDheBAgST8xAZ275OJms1
         b7N1i5uArjsK1AROnDBPtPUVfGlZznDuAzhyfGGTDi5m8nrIPpyxylk3fcxK1/mDFQrD
         0a/w==
X-Gm-Message-State: AOAM533MjgZ5a8XY/0jqX0+SLBxlgYdE9VLEn7zDkplKAVutXylCISov
        lxmo+EhCd1y+Iu4rjc+bP1bgcXEY52opI1zQhIg=
X-Google-Smtp-Source: ABdhPJz6hiqaVXfwWxaxZKuV+Pk8eB4E9aTJ2TdawYMsX4CE4LbuTEdqrxVEeVNaHYiO0gYuEI2mEpul/UGb6vTAOgM=
X-Received: by 2002:a1c:7405:: with SMTP id p5mr9735036wmc.130.1596758235596;
 Thu, 06 Aug 2020 16:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.694.git.1596675905.gitgitgadget@gmail.com>
 <d15ed626de65c51ef2ba31020eeb2111fb8e091f.1596675905.git.gitgitgadget@gmail.com>
 <20200806020407.GR6540@camp.crustytoothpaste.net> <CAFMepcn-yWtke7eE006a5RGO6uaScWb2xZe4H5M8X4F_T4Rhbw@mail.gmail.com>
 <20200806235139.GB8085@camp.crustytoothpaste.net>
In-Reply-To: <20200806235139.GB8085@camp.crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 6 Aug 2020 19:57:04 -0400
Message-ID: <CAPig+cSAnwbRYAVB5B8XdBKso=kQt=8CBB-U_Z-Wc+Sp2s54Hw@mail.gmail.com>
Subject: Re: [PATCH 3/4] Fit to Plan 9's ANSI/POSIX compatibility layer
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kyohei Kadota <lufia@lufia.org>,
        lufia via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 6, 2020 at 7:52 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On 2020-08-06 at 13:49:43, Kyohei Kadota wrote:
> > I see. If I'd like to put those wrappers to the repository, is there
> > the best place for them?
>
> If you can stuff them in a shell function, then I'd just put those in a
> file like t/test-lib-wrappers.sh and conditionally source them from
> t/test-lib.sh.

There are already platform-specific shell functions in test-lib.sh[1]
and some larger compatibility functions in test-lib-functions.sh[2],
so those might be better locations for Plan9 compatibility wrappers
than creating a new file (or not?).

[1]: see the section commented:
    "Fix some commands on Windows, and other OS-specific things"
[2]: see, for instance, the mingw_test_cmp() function
