Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFA6C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 07:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbiCAHKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 02:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiCAHKB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 02:10:01 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A7D37A1A
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 23:09:21 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id l10so6403302vki.9
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 23:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Raos3jM0+dqgNXil3EEHBQteqsztJDfH4kXARktafBw=;
        b=POoSKT8uh4fXM9rREr8qzH1prR+6dOJoUIchrbNBrsgxAo/xewvX51oHbR0qRl7PKD
         KghENJ/H2Z/bnuLnnJMaptXDsh4OHDJiaKQWykd/3tYquNEXK9VHdCh7XqhVwljSQ+5R
         P/a1TRj3rWiixYhp2izULxOCax2hrHK7gLW7Hbrq2z4saBcHTMH72g4oExPvSZZUl3Oi
         Jg6cxheU5OdJb39YugrlWBLyQX1p4+5aYJ6T1AntKbgpfO0xAaZ+lK+a1RDuVRUKu82H
         5lu2/Tcu+/tjvHkZwiy0crZZZTFNLrHrApGjUykxyGJWbRm4KKnFOelSUYD4rgOtBrO5
         c4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Raos3jM0+dqgNXil3EEHBQteqsztJDfH4kXARktafBw=;
        b=joYosoV4Y30pUe3jVRMjoGAek+p8XUOazX9vdMhsTtTgDdhD1c9Ao2qbYgwnn5WLmD
         Qb13yhLbIXA3WogW8bTMWfYgL/+0aOjVCbdWVL3ODtT0ot85cNrsmF5FBCHY3fYVY6e7
         CnJraEOMOkDF4Xe8IFbRntre+jJBy04yMtB6I5QqMOPP+Tn+dcEwfZ4qerlu3u/w1TWg
         jlJ1IUGRBUT/m6wOoCd1+KrrlibdP4E+/ZBQCCCFJ0NljTkS217EUl3SZ14gziPqUx8M
         +G9m4InkR7aTdM119nlsyG5KF8EUSYM0vY1cuSE2n2uo0tp065mExtbQLyGomjZ6DKxH
         kP7w==
X-Gm-Message-State: AOAM532AA0PqRdcWTfsX23k2K8Df82COditWw7eYkPCgmZnqiXqdF1C2
        ++8hyu2XPRmx4X/mOie+jexqNtGucvx9dSpEgeU=
X-Google-Smtp-Source: ABdhPJxo2eH55t8cSastr00drGEGT5TWLx4SL678tEWcKmyPYYcC3VxmvZtHWaNjw73k6WwCO0U/40vSrP4ALLXjf1s=
X-Received: by 2002:a05:6122:88a:b0:332:6860:7b1f with SMTP id
 10-20020a056122088a00b0033268607b1fmr9781402vkf.25.1646118560197; Mon, 28 Feb
 2022 23:09:20 -0800 (PST)
MIME-Version: 1.0
References: <20220228215025.325904-1-jacob.e.keller@intel.com>
 <20220228215025.325904-3-jacob.e.keller@intel.com> <xmqqpmn6wg98.fsf@gitster.g>
 <CA+P7+xoECs-rXb4vpRrw40Q-oRvfu97kMig9zu0rEE6KagAyiw@mail.gmail.com>
In-Reply-To: <CA+P7+xoECs-rXb4vpRrw40Q-oRvfu97kMig9zu0rEE6KagAyiw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 28 Feb 2022 23:09:09 -0800
Message-ID: <CA+P7+xr=_TfCQ4LcvkJ4EEhqMvefFGEkPFW95bOPB_yDhyj7hA@mail.gmail.com>
Subject: Re: [PATCH] name-rev: use generation numbers if available
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 28, 2022 at 11:08 PM Jacob Keller <jacob.keller@gmail.com> wrote:
>
> On Mon, Feb 28, 2022 at 6:36 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Jacob Keller <jacob.e.keller@intel.com> writes:
> >
> > > +test_expect_success 'name-rev without commitGraph does not handle non-monotonic timestamps' '
> > > +     test_config -C non-monotonic core.commitGraph false &&
> > > +     (
> > > +             cd non-monotonic &&
> > > +
> > > +             rm -rf .git/info/commit-graph* &&
> > > +
> > > +             echo "main~3 undefined" >expect &&
> > > +             git name-rev --tags main~3 >actual &&
> > > +
> > > +             test_cmp expect actual
> > > +     )
> > > +'
> >
> > I doubt it is wise to "test" that a program does _not_ produce a
> > correct output, or even worse, it produces a particular wrong
> > output.  This test, for example, casts in stone that any future
> > optimization that does not depend on the commit-graph is forever
> > prohibited.
> >
> > Just dropping the test would be fine, I would think.
>
> Stolee mentioned it. We could also convert it to a
> "test_expect_failure" with the expected output too... But that makes
> it look like something we'll fix

I'm happy to drop this test though

Thanks,
Jake
