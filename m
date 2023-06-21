Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9216EB64D8
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 10:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjFUKnx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 06:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjFUKnP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 06:43:15 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122B030C2
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 03:40:53 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f904dcc1e2so48201655e9.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 03:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687344050; x=1689936050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVI2weu13Baojcrm2DyM6EdANC0mEWnHu1uQ5ptbTUk=;
        b=mwaZ/Z7nmajtNE+I8ZzNKSprYn1HD9pTPPXPx9kGZPyoXaTCM4XI2oyswf+RXkJim0
         aDV9SSuZ3hxmuiTjP2qBSlHiIVBB0NjRdUpRdJAn8S5eByTpEvWx4pFL29lnIloBCNg/
         BZBoH1B1pUHVfCcWaKpT3wbG78EpY/FxNb2wowaDiRhiRfloh/D+tWc9A7pB7px9Xh6u
         HPBKtbGPsJbXgZXmqKTUohYWhYEr9l5GY9tdZJs93ChdgiZ3GAo4xRHzxaUandEqO+ed
         VM7dc8QjRh/CxD6ROtpmH/+t6GlmIXElxdtxL37lb8khh1XvwCKyg1CQm5hsIz4R7aVd
         BHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687344050; x=1689936050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVI2weu13Baojcrm2DyM6EdANC0mEWnHu1uQ5ptbTUk=;
        b=f8/SI+egtvhfYBCBWpjYNxw/QviyFTFdRkwbabjDqjnQF3W+ni/43qnj3nidRqnkKt
         4E2D9wnYG3+uIOA6j4+oEG/y772BTCkxIp6/okviM3g/STULilveJyNLjoB4ojwkQVBR
         j3YHb7zpQVCMgqdpvjM/qggtz13Had7y3RBIptK5bvJzDxZIxmoHaytNYJll932nEvAW
         MMHSmcXMQtORm6TVMVjF8Iql2bz+kBYj+0/aOhVOi/F/a81sTkcfRgkJSTKNaBno8F8H
         LILoLJvDAwbKuE6dXlWxtrHK9pUwib4zMXD4TG+0aM3QI+gYdVbB2MbK2dj4bvjE59sg
         FPqA==
X-Gm-Message-State: AC+VfDx/04T1S5iCwPGX9pZIU/1jIrDlGt/ApYCiq5kCq8MBmxzF2PiA
        9x+fOj0uTlmOjtlPMaazNbia7HZ6WXqFJzPVPiY=
X-Google-Smtp-Source: ACHHUZ7AtuaZlnMU89dqELElnoX8hRvU2Enu3hG2AeHMcQZG826QaBJPr1Bn+58fwmyMkiZcTHVW8XyTNDxxF7JUfR0=
X-Received: by 2002:a05:600c:28d:b0:3f9:92d:a021 with SMTP id
 13-20020a05600c028d00b003f9092da021mr8375411wmk.26.1687344049990; Wed, 21 Jun
 2023 03:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230614192541.1599256-4-christian.couder@gmail.com> <xmqq1qicuwrw.fsf@gitster.g>
In-Reply-To: <xmqq1qicuwrw.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 21 Jun 2023 12:40:38 +0200
Message-ID: <CAP8UFD0GSTHJcagxhkKXZ5Lx7QMzpn3ve2XvvHDt6N=caM1DrQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] t/helper: add 'find-pack' test-tool
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2023 at 1:32=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > In a following commit, we will make it possible to separate objects in
> > different packfiles depending on a filter.
> >
> > To make sure that the right objects are in the right packs, let's add a
> > new test-tool that can display which packfile(s) a given object is in.
>
> This tool would be serviceable if we only are interested in checking
> just a few objects, but if we were to check many objects, I have to
> wonder if it would be more efficient to use show-index to dump the
> list of objects per pack, which should be sorted by object name, so
> it should be trivial to run "comm" with the list of objects you want
> to check.

I agree that this new tool is for checking just a few objects.

> Or if you only are checking about a dozen or so, taking one or more
> arguments from the command line and looping over them may also be
> OK.  The output format of course may have to be changed, if we were
> to go that route, though.
>
> It really depends on the granularity at which this test helper wants
> to work at, I think.

Yeah, in the previous commit implementing --print-filtered, we check
that all the objects that should be printed to stdout are indeed
printed. So later when git repack --filter=3D... is implemented by using
git pack-objects --print-filtered and piping the printed objects to a
regular git pack-objects command, I don't think it's necessary to test
a lot of objects, as hopefully both pack-objects command are supposed
to work well at that point.
