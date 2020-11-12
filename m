Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB50C56201
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 16:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7847D21D7F
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 16:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgKLQoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 11:44:13 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45380 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbgKLQoK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 11:44:10 -0500
Received: by mail-ed1-f67.google.com with SMTP id q3so7027924edr.12
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 08:44:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eWI7DI2AtxQfXK7NM+A8FLELaTEtwq/IHPt1fGUmEW8=;
        b=s3wKWHoslsonsM8m39H1cQFW+Ikzb6mPwjV60SG/azVCt0+M9ZjfJDC9/Xmt7rFe0n
         13kauUCZwwAOqsQdyjDgPeupwWvtvWt0158r3CDFJxqw1ppNCxDJHEFaUApwatVZFTmL
         FAbvv1+2zTRyCsEONVSCpgwnwKt5tDyyV2ltByn6VPEzo3hs76roNYsFhiV+xgXYVmD7
         uDCpKXpcGuNU1REjqHB2SGd9eE3h5HPhjIqQOCOGMZ7Pq97QO6lJN2kS4oSJ5QWADGbJ
         RAJ739cuRQeItCA8E7w3wA+I7eiTV4SWoYE8+ftZo4zOdzYrKo3SdIQWx8Pz65T+YrEM
         6BAg==
X-Gm-Message-State: AOAM533lBVYUTOOMk/QTAGRjL7SUYLryNHPeD1h3ABZC0JcT/ehfoe/P
        lLRSIQwcjH0rI0pGuavz1ZNLXEBHoYiZwMQMx9s=
X-Google-Smtp-Source: ABdhPJzTWojckeOfZE/NWwqxtvXVqtm9zlxjTJjkqcyQmHDYXUUtvNgF3+lOwgOjZdjs28ecF9y4pdum2qxBoBlU38o=
X-Received: by 2002:aa7:cc0e:: with SMTP id q14mr656535edt.181.1605199448069;
 Thu, 12 Nov 2020 08:44:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.776.git.1604412196.gitgitgadget@gmail.com>
 <pull.776.v2.git.1604520368.gitgitgadget@gmail.com> <0fafd75d100f343f7cff6471772ed9b12793f81e.1604520368.git.gitgitgadget@gmail.com>
 <CAPig+cT=DytbMH6KkC6ipD3jbWNa7jgW9G0Q76rwJoEsLGn_ow@mail.gmail.com> <5e0307b8-8e63-f82d-b417-7007d4a3a5b3@gmail.com>
In-Reply-To: <5e0307b8-8e63-f82d-b417-7007d4a3a5b3@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 12 Nov 2020 11:43:57 -0500
Message-ID: <CAPig+cQzp_nyp9BNc+WZuBWmXnArMGp8iCB4pHM+Fw+XJ8+eCw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] maintenance: use launchctl on macOS
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 12, 2020 at 8:43 AM Derrick Stolee <stolee@gmail.com> wrote:
> On 11/11/2020 3:12 AM, Eric Sunshine wrote:
> > On Wed, Nov 4, 2020 at 3:06 PM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >> +               xmllint "$PLIST" >/dev/null &&
> >
> > Do we really need to suppress xmllint's stdout?
>
> It outputs the XML itself. Maybe there is a command to stop that from
> happening, but nulling stdout keeps the test log clean.

xmllint's --noout option should do the trick.
