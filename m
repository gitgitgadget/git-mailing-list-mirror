Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A08C433EF
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 17:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiF2RQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 13:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiF2RQv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 13:16:51 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053143CFE2
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 10:16:51 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m184so9774448wme.1
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 10:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wjCmILB/HKIJ4tXoCkcUOKEjtCtrFVbs8e97DBfPpvs=;
        b=iVDWnLS5isX67MpXA4+qNTaTC9C3hFkIhLFd/eWlyMrXmsfK0JWayfDkfXJZeVcyh1
         j8KzsUbYhNQwXOhdPKoYhmqYHV6lt0A1z/9xGvvuqk1ugjomuGVsyS8q1Ky2lP0mAIM0
         AFLsLBtX54/qoTQjJ6kt3XHm/fG6eTp1zUHlW5COznlwGeiSN4ELJYW4wOdzbB3SO/1W
         32+JSAda6O70WMs2WhbhhNl5I+Z2PvdaQuc+7F8OhkF+aTE/DnxuJ7VmL8ByLpRBe2c5
         phFwM1nj9CoWCyI9ulgypLmmirLSxWmFY1RmEdZc/LrYfsk1IqkHeJjobsOb+O3LBzjC
         +0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wjCmILB/HKIJ4tXoCkcUOKEjtCtrFVbs8e97DBfPpvs=;
        b=A5b0crjcn5w2o4NM6qIscLwFDv67bxlJ0KAPxl3yiLj6LcGIvMJZ7sSbbzWSMQ3+gB
         LEHl9fBKGQaEwzvAE1BAZNMZkqpAPxsuhbVme7TsuJo4KBpC1YpegyOmOS4+L3TYxVHg
         sqgL90zX45ehIsWAJjRTFgpwR1y5v10AwYzcO2iYVGJL2fzBU7LP2+xSd4ZdgmFqVpR/
         TQoXimTmS0P8pWemZe3MSRGO6zLHsr5g6ckD+KdT+7VTOeRWId1TDPGTrbSMd98ZOtS6
         X4HXNyVpd3ftBWq2L4Aqetewa1k1UX0HggooIMzYaWkD0fdyARArXcbLP9jyO6b+Tsoj
         BT2g==
X-Gm-Message-State: AJIora8lWhd/e8TSL+5Rer7365EA+dSMTezG7SuiVYY2JWtzZh5/7Ef+
        rJntWHPeJE832HOCvi1cczngGW8X0DO3fltrn1s=
X-Google-Smtp-Source: AGRyM1sMOjc248HCeX1Z7fL88KI9fEezW7H3FSCgLbO2DXsjwl8YB3gyxXYoiO5gkYrMMzZwSK9x8pMSsZs/6wVxGHk=
X-Received: by 2002:a05:600c:4982:b0:39c:3c0d:437c with SMTP id
 h2-20020a05600c498200b0039c3c0d437cmr4964049wmp.38.1656523009594; Wed, 29 Jun
 2022 10:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAKQoGamCrRMqtzziuzi8mL6E7uA3SC1WXiMGT_4rpbk1jcu_OQ@mail.gmail.com>
 <YryF+vkosJOXf+mQ@nand.local>
In-Reply-To: <YryF+vkosJOXf+mQ@nand.local>
From:   Gregory Szorc <gregory.szorc@gmail.com>
Date:   Wed, 29 Jun 2022 10:16:38 -0700
Message-ID: <CAKQoGakSFaNm10ZeTKc8XtTcD0JW19CZP1OwA4j7W__iBQaJfg@mail.gmail.com>
Subject: Re: Race condition between repack and loose-objects maintenance task
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 29, 2022 at 10:03 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> Hi Greg,
>
> On Wed, Jun 29, 2022 at 09:55:54AM -0700, Gregory Szorc wrote:
> > 1. `git repack -A` creates loose objects
> > 2. `git maintenance`'s `loose-objects` task deletes those loose objects
> > 3. `git repack -A` fails to find the loose objects it just created and
> > aborts with `fatal: unable to add recent objects`
>
> This is a somewhat well-known race that occurs when one Git process
> decides unreachable objects are safe to be deleted, but an incoming push
> or reference update makes those to-be-deleted objects reachable before
> they are actually removed, leaving the repository in a corrupt state.
>
> I'm surprised that the loose-objects maintenance task deletes those
> objects, though, since it just runs `prune-packed` or (the equivalent
> of) `repack -d`, neither of which will actually delete objects from the
> repository.
>
> I see that Stolee is already on the CC list, so perhaps he could chime
> in on the above.
>
> In either case, my recommendation would be to keep those unreachable
> objects which haven't yet aged out of the repository around for longer,
> which will decrease the likelihood of seeing the race.

We had to lower gc.pruneExpire from its default of 1 hour because
otherwise this would result in the creation of thousands of loose
objects. This is normally acceptable. However, on NFS, the churn from
lots of file creation and deletion resulted in acceptable performance
degradation. We had to lower gc.pruneExpire to minimize the damage.

> If your
> repository has a lot of unreachable objects (such that storing each
> one of them individually as loose is impractical), I would recommend
> using cruft packs (e.g., by running either `git repack --cruft -d` or
> `git gc --cruft`) to collect those unreachable objects together into a
> single pack.
>
> See Documentation/technical/cruft-packs.txt for more information about
> cruft packs.

Yes, I saw this new feature in the Git release this week and am hoping
to roll it out to better mitigate this general problem! With cruft
packs, I anticipate being able to restore a longer gc.pruneExpire
value as they should mitigate the NFS performance badness we're
working around. Thank you for confirming it should help with the
problem.
