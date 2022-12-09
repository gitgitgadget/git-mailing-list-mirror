Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB46C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 04:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiLIE7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 23:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLIE7W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 23:59:22 -0500
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C4E8F728
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 20:59:20 -0800 (PST)
Received: by mail-pl1-f170.google.com with SMTP id m4so3734770pls.4
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 20:59:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XgvR5UHGUhQYWW0KgpSVnGC/dG5c7Fx9emVQpPwO0bE=;
        b=petILnmaPNACmt88EneHuGgZDqBtUNaD9wnygFALoQpsRwhmdUPesUT5l/ylpg95jC
         cdbhhvjAGBSkPludzDhhRGvB09iraTv13GDo7to4H+JkXLWqcwNyKxBfh4jPFTPp5j9C
         KT6XX8f2dVWyQliXZiAcUTQpv5JcT0KGv4vjBLOBTsk0zbH0qpdfwmBDwaCi4WyojWns
         c4pHDwFkJkQhxQSY4B+aLem7MgSZKxZ0i8FsvTQ2GSBjGcdySePaJq81QhaAqkOnytfe
         YWtWElrfQzaUnpTm2AmBakhU3mcyCg1D+rM80UXAvs4z3XfzsrnQJlVIPuemruHeIBaS
         ZkKA==
X-Gm-Message-State: ANoB5pkr/5dLdWQX3tuBgzqH1WeF8ba9y1/2yeYDeq++KItulI3JJAcY
        rPNoWbsiVaYK0hM0ipYNDtYS6K1Ud6Q/9RhI9/0=
X-Google-Smtp-Source: AA0mqf5mEDYvsUkC1Lz12C4ddMFq4fxZMyMSX3hSTOEuApx2sZyCsjgtFpDBk8BmSfMoI06iQ5d9WjGnSmlHeBe7J+g=
X-Received: by 2002:a17:90a:5d81:b0:212:cf2e:2b0b with SMTP id
 t1-20020a17090a5d8100b00212cf2e2b0bmr109261113pji.169.1670561960399; Thu, 08
 Dec 2022 20:59:20 -0800 (PST)
MIME-Version: 1.0
References: <pull.1425.git.1668999621.gitgitgadget@gmail.com>
 <CAPig+cT6z5kzM8suwqxJ0wrzHjnj9ChROVBiQO3AR1rJ11pkNw@mail.gmail.com> <96178n12-4255-q093-qo51-r37n5o569s6p@tzk.qr>
In-Reply-To: <96178n12-4255-q093-qo51-r37n5o569s6p@tzk.qr>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 8 Dec 2022 23:59:09 -0500
Message-ID: <CAPig+cRDrX_3C6hzy=7NEVpKG8AtutQthge-AhyFm-xj6FKTqw@mail.gmail.com>
Subject: Re: [PATCH 0/3] fix t1509-root-work-tree failure
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 8, 2022 at 7:10 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Mon, 5 Dec 2022, Eric Sunshine wrote:
> > On Sun, Nov 20, 2022 at 10:00 PM Eric Sunshine via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > > The t1509-root-work-tree script started failing earlier this year but went
> > > unnoticed because the script is rarely run since it requires setting up a
> > > chroot environment or a sacrificial virtual machine. This patch series fixes
> > > the failure and makes it a bit easier to run the script repeatedly without
> > > it tripping over itself.
> >
> > Ping?
>
> Thank you for the ping. I did not have much time for the Git mailing list
> as of late (too much Git for Windows stuff going on).
>
> The patch series looks good to me, with or without the `test_atexit`
> change I suggested.

Thanks for looking over the series. Taking downstream discussion[1][2]
into account regarding test_atexit(), I think I'll let the series
stand as-is.

In the long run, t1509 may need an overhaul, but the current series is
intended to be the minimal possible change (patch [1/3]) to get the
script working again, plus very minor "fixes" (patches [2/3] and
[3/3]) to make it a bit friendlier for the next person who has to
debug a failure in the script.

[1]: https://lore.kernel.org/git/221208.86fsdq6nci.gmgdl@evledraar.gmail.com/
[2]: https://lore.kernel.org/git/xmqq5yel18xf.fsf@gitster.g/
