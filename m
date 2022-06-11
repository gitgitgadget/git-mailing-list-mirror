Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB24C433EF
	for <git@archiver.kernel.org>; Sat, 11 Jun 2022 08:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiFKI4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jun 2022 04:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiFKI4d (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jun 2022 04:56:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF601021
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 01:56:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id n28so1556713edb.9
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 01:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYrBL6ChgrUyJ9m30xspaVs79bC/wpr/7zgb95YnrU4=;
        b=GpT0z64Z0ZmHkczOAvX5eUcfcnGFi/FY5IQBK0p0KsXQ/X6dpbeNPXAfO71Elix6c5
         +Ec0uxxdY93Y64D/FPCYjr9VCdci0uPSvsc3WZHgcmIdGSFXLdkeuiEo1dqc3YR/E9zc
         X/JFcimtFKPvqs2uGu1LqfLPJCi1lDpxxSMqSRzcD0xxX8HfzILPRMShRjOC1pwgLKhJ
         7TIQe0NMoOfrNKTwvGKuCAhFpXaDX3m5KP7KE13S9qjvmegJtSQFI7+heykHvXV4k4CE
         KL2beJsEkmN/LHw6NDhqPhLV33arHGIqX/9otK2yw0OAuIutwtTDO4jrpo8j+7ZjWl1F
         3dyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYrBL6ChgrUyJ9m30xspaVs79bC/wpr/7zgb95YnrU4=;
        b=OIORg8vnyJZ1ewduzQyPyYOLyqzWkLa9OklvICwFwNIi9Z+tgc2TB4U7jls+qDeUww
         667UVFvMFaeqsc3EtbEQ0GyEBoHEQGzxujzVu3lQlO8l44sQe95A7n9ACawOlSWx75B9
         NYQUQFYD6zvbmLbmsiXT+x1yBlUJjZGWLs51ve4F+kESiCDn1ZJS6jEBJz7b/720flf/
         KR4AFFGvKDR7Xaa7zpHyZIM7mnFaLUErtwnTbNz/auy7cZyGmdnrDhdAvVTnaMIyWhdv
         AjKk1FGzXyIeFZP66WBgRCkttW2HrJDMx5ihfIE4FZ8yQrysh2QHQ3S6/rD+wR63Nfpx
         ghIQ==
X-Gm-Message-State: AOAM5334Q2oz4BgKiLb4uv/WVmCimpc/c5axycbGhaxM/mAhdyVe2a3q
        YU85t1cR6vG3abOK0YIMFFSO8fmOxnFjfLLifhJgyJL4
X-Google-Smtp-Source: ABdhPJxLF98IWDCeRoUKINiciqS1FtFX+KnW0S5Fq7hAXg4Ms2raSpkf+4rJ0koGj0fIFUFt3Fz/tpTRn9uYwK1WoRY=
X-Received: by 2002:a05:6402:4255:b0:431:34c3:6018 with SMTP id
 g21-20020a056402425500b0043134c36018mr40475214edb.146.1654937791075; Sat, 11
 Jun 2022 01:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <kl6lee006mle.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CABPp-BEW2WF5AJeKqCiL2zhcPwPH-u6p=myoX_GkU6tbV=+TZA@mail.gmail.com> <xmqqczfgfojb.fsf@gitster.g>
In-Reply-To: <xmqqczfgfojb.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 11 Jun 2022 01:56:19 -0700
Message-ID: <CABPp-BEXdfEw5jYn-WM_pyEyS5AHmYEJhVNS8GtHAd2BXCaB_A@mail.gmail.com>
Subject: Re: Bug in merge-ort (rename detection can have collisions?)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 10, 2022 at 9:53 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Tue, Jun 7, 2022 at 5:11 PM Glen Choo <chooglen@google.com> wrote:
> >>
> >> (I'm not 100% what the bug _is_, only that there is one.)
> >>
> >> = Report
> >>
> >> At $DAYJOB, there was a report that "git merge" was failing on certain
> >> branches. Fortunately, the repo is publicly accessible, so I can share
> >> the full reproduction recipe:
> >> ...
> > Thanks for the detailed report; very cool.  Interestingly, if you
> > reverse the direction of the merge (checkout origin/upstream-master
> > and merge origin/master) then you get a different error:
> > ...
> > Anyway, long story short...I don't have a fix yet, but just thought
> > I'd mention I saw the email and spent some hours digging in.
>
> Thanks for continued support for the ort strategy.  From the very
> beginning, I was hesitant to make our tools try to be too clever
> with excessive heuristics, but at least we are not making a silent
> mismerge in this case, so it is probably OK, especially with "-s
> recursive" still left as an escape hatch.

I'm pretty sure the bug would still trigger even if we removed all the
heuristic differences that the ort strategy has relative to the
recursive one; I don't think those are related to this problem at all.

In fact, the more general problem area here appears to affect the
recursive strategy as well.  I'm glad the specific testcase reported
works under recursive and gave Glen (or his user) a workaround, but
that feels like luck rather than design because my minimal
reproduction testcase not only triggers the same issue he saw with the
ort strategy, but also triggers a previously unknown fatal bug in the
recursive strategy too.
