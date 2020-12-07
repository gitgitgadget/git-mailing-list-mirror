Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56830C433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 08:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DABF225A9
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 08:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgLGIl2 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 7 Dec 2020 03:41:28 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34839 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgLGIl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 03:41:27 -0500
Received: by mail-ed1-f65.google.com with SMTP id u19so12817800edx.2
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 00:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rVNCBf7WQmFmDUuCCodsOYd5g5kJYYNdlK5X4Uc5jK0=;
        b=n9+IE+Z0roFX5T8pqinZIf4W956Ves21iESRS06muS5V7l1qxIZrbFEFME6T7olneJ
         CBMqjztzdu9BJCjfMOH47bRj9uqlPCPVFKDSee5is0ok9+M+nre3wmgmxKm87H3LB5bN
         KxWveu9SWAw3b+Hk8H36Xr07Da2otl5ZIiq7h4W7iWpgM7GFXNnpu2eCvabGwO7zNVhs
         aWAU/Hs4cfcBn+GPeYIe5eoDHRFiodrDtKAvYALjahPzve9w2IMlvhyqBe609xCniNTx
         ccLHiDIZ3+JLeOGQkp5wkLbWmtPqV//p0nEqjsr2EjG9QAbHZVY07CXjndFNUdOUYbbV
         LEBw==
X-Gm-Message-State: AOAM530+lW0Q4XOuJphyGe6LdgFpFeHPf2WsiZC8DHHRRiMQB048S6uD
        QDE9U1dDAhWwzs7UScuthyA+eNUe9VqzQ9D4H/Q=
X-Google-Smtp-Source: ABdhPJycavUpA1Tb2UxytnSJ7MKIDa3+G1j1flafGJjgJM2a7yEibL1fKtiCXB5cNBkvN4Rp5Lsv5xBOF1JcU9mEz9A=
X-Received: by 2002:a50:f0dc:: with SMTP id a28mr19110285edm.291.1607330445906;
 Mon, 07 Dec 2020 00:40:45 -0800 (PST)
MIME-Version: 1.0
References: <0b6a34a0-428e-5fc4-307d-1217b112659c@nokia.com>
 <1607095412-40109-1-git-send-email-peter.kaestle@nokia.com>
 <CAPig+cR69HJefRMfH_5-dHOMVY-VmVgbqQuWV90ednDEjrnExw@mail.gmail.com> <0deeeabe-9590-db7a-4a07-447d43df7a24@nokia.com>
In-Reply-To: <0deeeabe-9590-db7a-4a07-447d43df7a24@nokia.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 7 Dec 2020 03:40:34 -0500
Message-ID: <CAPig+cQ8VC2q4nuzgM9QxmddH4cMezbZdRZDxX1PqfW6XKcC_A@mail.gmail.com>
Subject: Re: [PATCH] submodules: fix of regression on fetching of non-init subsub-repo
To:     =?UTF-8?Q?Peter_K=C3=A4stle?= <peter.kaestle@nokia.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 7, 2020 at 3:29 AM Peter Kästle <peter.kaestle@nokia.com> wrote:
> On 04.12.20 19:06, Eric Sunshine wrote:
> > On Fri, Dec 4, 2020 at 10:25 AM Peter Kaestle <peter.kaestle@nokia.com> wrote:
> >> +       ! git -C main fetch --recurse-submodules |&
> >> +               grep -v -m1 "Fetching submodule sub$" &&
> >
> > We want the test scripts to be portable, thus avoid Bashisms such as `|&`.
> >      git -C main fetch --recurse-submodules >out 2>&1 &&
> >      ! grep -v -m1 "Fetching submodule sub$" &&
>
> In general I agree, but for this special test case, it's required to
> have the two commands connected by a pipe, as the grep needs to kill the
> git call in error case.  Otherwise for this regression git would go for
> an infinite recursion loop.
>
> Of course, we can go for a "git 2>&1 | grep" solution.

In that case, an in-code comment explaining why the output of `git`
must be piped to `grep` would be helpful since it is not uncommon for
people to "modernize" test code as they are working in the vicinity,
and removing such pipes is one of the modernizations often made. A
comment would help avoid such a change.
