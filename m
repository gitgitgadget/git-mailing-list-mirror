Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688AFC2D0C6
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 10:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CC520CC7
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 10:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e9cOUH3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfL0KN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 05:13:59 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:40263 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfL0KN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 05:13:59 -0500
Received: by mail-ot1-f54.google.com with SMTP id w21so28058429otj.7
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 02:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=swelc3uQtlIOxRT9jMK/cJ4Se29AGxVN/Hnmxv9XSbs=;
        b=e9cOUH3pRN3s8630g9PGHvV09uawJdTHBdm1bp24dOUbn74MYxoRW7jon6SSCBSIAQ
         ZlsmmYK43QrH4OwGoxdTxv3Bjc409l/DmTO6P9+BDrLa5/wFthM9mwXCZBuxanBlIu6y
         sQPGme7Fd0DVqHrq9eww3mvulJ1+tcc4Iz+8isExXEl06270+JTayDBrfvWkTbS715fq
         APxPHMDSqElXu3Fjt0mCIhhDMMJZ7p8KP2AKTZj/pT9x0Hl70phfUgIhUX00MBRR2h43
         pmM86r/OFkROlgnRt5/hJ1xUmL2Zh2o+fQYAqBY6UWLedDWVfBOzOuBcwpEurutGNb4W
         uIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=swelc3uQtlIOxRT9jMK/cJ4Se29AGxVN/Hnmxv9XSbs=;
        b=pf5sSQ03jPN+8h2ZhXZrlbujk7Q10QVa9ekI253hu17qQbAhhgXB8nifSQtKdEJfha
         rvH/y6eWcZXS3c44V2+XDscG9hGOWY28wRJD08BeykDQgPgGbPywoMTW4gEZPt7OVDI4
         ekceJKnKVk0yMV4MmZj2S187RCCkcJ1jSgcTbkruaKDj+sDuH4m3kBiuIHtYwonZqphY
         c94qeT1goWp9l8pwj0fqXNgfQpuaX2NW9FYiOzX5APDU32rW3AZXCLcX23PoD1YmBk3M
         1VrMhDK3Wa3q/SF9PzHC+c7qzRWwFRmSJccmhyr93piYm7bdVjfRDMevGHwu9Ii2ey+Y
         BM5w==
X-Gm-Message-State: APjAAAXIBXuliNJ96dBmY+u/5SOyxoWEyz6k7rqbJw/ZgWAwTg75EJ++
        Hb+Yxy6GbEQdT9G4VnqOoJ5Czi+dDUJgW/haUpwAvg==
X-Google-Smtp-Source: APXvYqyHyKfi/3sO3lReMVTBZX50PbWQ1HltFjB4BZQ6KrbTtb9xv3eBbZp4qt+R1BPguWvdHJ0ZYKYS5hCRNBWOzd4=
X-Received: by 2002:a05:6830:4c2:: with SMTP id s2mr57972622otd.144.1577441638144;
 Fri, 27 Dec 2019 02:13:58 -0800 (PST)
MIME-Version: 1.0
References: <CAEsQYpNtgMgwjVSOYB9vn-YPvKyKPZ2yZ3NigAVe3PztTN4v8w@mail.gmail.com>
 <xmqq7e2l5ych.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7e2l5ych.fsf@gitster-ct.c.googlers.com>
From:   Gal Paikin <paiking@google.com>
Date:   Fri, 27 Dec 2019 11:13:47 +0100
Message-ID: <CAEsQYpMJGbw3L66vCd25Ht0bTBzvvt1yMRd2U3=u3U-BZukyzg@mail.gmail.com>
Subject: Re: Updating the commit message for reverts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Thanks for the reply!

So the idea of changing from "Revert Revert" to "Reland", "reapply"
has a big problem: sometimes Revert^2 actually means 'reverting
"Revert"' since "Revert" introduced a bug that wasn't in the original
change.

So to your question, I don't know what Revert^47 means since it
depends on each individual case. Sometimes it actually means "Revert"
and sometimes it means "Reland".

So do people actually use it? Yes! Many users reported to me that it
is not that unusual to get to "Revert^6", and it is very usual and
common to get to "Revert^2/3/4". It is also useful for the users to
know the number of the revert, according to the reports. Here is an
example:
https://android-review.googlesource.com/c/platform/art/+/352330
Feel free to also search for "Revert^2/3/4" to find many results.

Anyway, I am certain that "Revert^3" is better than "Revert revert
revert". There is definitely no clear way to solve this issue, but
perhaps "nth revert" would be a more "human language" solution?

Best,
Gal


On Tue, Dec 24, 2019 at 8:15 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Gal Paikin <paiking@google.com> writes:
>
> > I work on the Gerrit team and I would like to change the default
> > behavior for suggested commit messages for Reverts.
> > Currently, if the user is trying a change called '"Revert "change X"',
> > the suggested commit message would be 'Revert "Revert "Change X""'
> > which is silly, since sometimes users want to revert the same change
> > many times.
> >
> > The suggestion is to change the behavior to "Revert^N" instead of
> > multiple Reverts one after another.
> >
> > I'm happy to change those things in Gerrit, but it would also be nice
> > if it were changed inside of Git.
> >
> > What do you think?
>
> I do not _think_ anybody lets the exact phrase 'Revert ...' in the
> log message to be read by scripts to perform machannical action, so
> in that sense it may be OK to special-case the reversion of a revert
> and rephrase it in a more human friendly way.
>
> BUT
>
>  * what does "Revert^47" even mean?  Not just the proposed phrasing
>    looks horrible, it is not even clear what happened at the end.
>    Was the patch turned out to be OK after all these reversion war,
>    or got rejected for now?  It also misleads readers who know Git
>    can perform a merge with more than two parents that it may be
>    reverting the effect relative to 47th parent of the commit.
>
>    It _might_ be slightly more acceptable to flip the phrase between
>    "Revert X" and "Reinstate X" (or "Reapply X"), without saying
>    "this is the 47th round of our reversion war".  I dunno.
>
>  * how often does it happen in practice?  If a group of developers
>    find themselves reverting and reapplying the same commit more
>    than a few times, wouldn't they rather stop and think before
>    doing yet another round, which I expect to result in a better fix
>    implemented as a separate and brand new patch that takes
>    inspiration from a patch that was earlier reverted, and at that
>    point it won't be the 47th iteration of reversion war anyway.
>
> So, I am fairly negative on the change in the proposed form as-is.
