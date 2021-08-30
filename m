Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582F9C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 16:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23F9F60E90
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 16:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237708AbhH3QqO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 30 Aug 2021 12:46:14 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:35674 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbhH3QqO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 12:46:14 -0400
Received: by mail-lf1-f51.google.com with SMTP id l2so24392322lfp.2
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 09:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TzyOWNuiKAolZjWlClUUFD7itXXmDpETBIPFE4GbihM=;
        b=gj/VlCMDIaJ5TOL1KUzsM5FitT+gNgd02P5yYBGsHO8SWILYknHqCitjaTksWq12eM
         aBasgCPmXikg+vMDQHMrID2hrBVEGxpAAkV3J/bpfYYiNCXWDYWjej924SwwcpPTwOW5
         al5KGwiAPIEKgkSbMGjdEg7AJiGB++qyAOnr/+eOFnM1+OqnbNcx+NCLOsNaKIGl9X7z
         UK/zplIjVRCGXZwSmevu+Tc1sLX9XwkpHCCFb6czcpyt64JtEeXeefz2dNLmaIUp4UJG
         8zqkmqm4KJ/zgocgcjiVLpmZQ6x09HaDw9f+zHQkoYAt/uO/wuwfjWGAg62VT0a3FGh+
         r6UA==
X-Gm-Message-State: AOAM532hEBbhLa4kXPCu9K3RryZH2zhkkZtZqoyw2TtpBk9akx/QVM6T
        vWac1te103AoM/OR7YnflvhGFPvxknYkhkrgWDSvjgS6
X-Google-Smtp-Source: ABdhPJwynwOhKJKvuvSBHB09rI7AJUPOCxFm2tJfHHiPpwrLCIigrSPWvoce6hb3mgZJQjPrLmKTRi6QlqfQHGrUcJ8=
X-Received: by 2002:ac2:4e45:: with SMTP id f5mr18243331lfr.628.1630341919378;
 Mon, 30 Aug 2021 09:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210830072118.91921-1-sunshine@sunshineco.com> <RFC-cover-v2-0.2-00000000000-20210830T103913Z-avarab@gmail.com>
In-Reply-To: <RFC-cover-v2-0.2-00000000000-20210830T103913Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 30 Aug 2021 12:45:07 -0400
Message-ID: <CAPig+cRFCtVPoBfMswiO1i6bMw_BUess9q2pto_v4dzHp9X2RA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] suppress trailing whitespace on empty "notes" lines
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 6:47 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Side note:
>
>     I'm generally trying to see if just sending a "proposed vX" is
>     more productive for everyone than patch feedback effectively
>     describing it in prose. I don't mean for this thing to be picked
>     up as-is by Junio without the consent of the submitter, and don't
>     have any desire to "pick up" the series myself.
>
> I really like the end goal of
> <20210830072118.91921-1-sunshine@sunshineco.com> series, but this
> seems like a more straightforward way to get to that goal.
>
> I.e. the original 1/3 and 2/3 starts out by making the tests
> whitespace-independent. If we just skip that 1/3, and then in 3/3
> tweak the relevant failing tests for the code change we won't even
> need a new test, all the existing tests previously made
> whitespace-independent in 1/3 will assert this new behavior.

It probably won't surprise you that this fix to `notes` started out as
a single patch which made the change to `notes.c` and adjusted the
existing tests to account for it. In particular, my original changes
to t3301 were exactly the same changes you made (i.e. merely dropping
the empty-line `${indent}` from the few necessary places). I wasn't
happy about the additional complexity I had to add to t3303 and t9301
to continue plucking the notes out of the default git-log output, thus
simplified by making those tests less brittle. That, of course,
deserved its own patch. I wavered quite a bit about whether to make
t3301 less brittle too, or to simply apply the minimal changes which I
had already made (and which you made independently). Eventually, I
decided to split that out as a brittle-fixing patch, as well, to
better future-proof it, but perhaps that's terribly important.

I don't have strong feelings between my v1 and your v2 of this series,
and would be happy to see Junio pick up either version.
