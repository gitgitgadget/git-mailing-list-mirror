Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626A4C433FE
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 17:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiJHRrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Oct 2022 13:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiJHRq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2022 13:46:58 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35A53498A
        for <git@vger.kernel.org>; Sat,  8 Oct 2022 10:46:57 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4ED514E149;
        Sat,  8 Oct 2022 13:46:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vfK3hjV+lP4ev+L0NuysvYcN1aBUF5wvYvTwsz
        wTAqg=; b=GGgr+IpvyXwcd6YUMEesMU/9l44gUBICHxhGzRC7VWL63Gv9madVcB
        WD7LwdI2DH8QB82wnLfjAspoEfeLMpZxbnMwIpDZBbjpLglTtT5oaw08fNnVWEzm
        6CAp+w2FF4bPvViTT+Ymhb/8Pw69j70oM0mjS5Ssgj6Qe7uPtvPN4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D55514E148;
        Sat,  8 Oct 2022 13:46:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0A42814E147;
        Sat,  8 Oct 2022 13:46:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v4] branch: support for shortcuts like @{-1}, completed
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
        <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
        <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
        <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com>
        <CAPig+cSX9jSPc_fJc0tuiER1-AqnbFGOk0r1tXEkv9gycVH-CA@mail.gmail.com>
        <f24837e9-7873-c34c-bd78-8ae3be0fc97a@gmail.com>
        <CAPig+cSn29Fq4ywC9zXoJYRVG8KUEhHuDdwEUSioFMUVs+S-ow@mail.gmail.com>
        <a7aca891-dd37-7e5e-61fc-8012fec18ae9@gmail.com>
        <CAPig+cRxy5C+CqUOzmhe16j+hssxsygha3huVga8tLJ+imM4Hw@mail.gmail.com>
Date:   Sat, 08 Oct 2022 10:46:54 -0700
In-Reply-To: <CAPig+cRxy5C+CqUOzmhe16j+hssxsygha3huVga8tLJ+imM4Hw@mail.gmail.com>
        (Eric Sunshine's message of "Sat, 8 Oct 2022 13:10:59 -0400")
Message-ID: <xmqq1qrib435.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 337446C8-4731-11ED-ACCA-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> Yeah, I thought about that.  What convinced me to use "git stripspace" was
>> that maybe that '\n' tail could be removed sometime from the description
>> setting and this will be fine with that.  I haven't found any reason for
>> that '\n' and it bugs me a little seeing it in the config :-)
>
> That reasoning occurred to me, as well, and I'd have no objection to
> git-stripspace if that's the motivation for using it. I don't feel
> strongly one way or the other, and my previous email was intended
> primarily to point out the lightweight alternatives in case you hadn't
> considered them. Feel free to use git-stripspace if you feel it is the
> more appropriate choice.

I do not think I would agree with the line of reasoning.

It all depends on why we anticipate that the terminating LF may go
away someday, but if it is because we may do so by mistake and
without a good reason when making some unrelated changes to the
implementation of "git branch --edit-desc", we would want to know
about it, and such a loose check that would miss it is definitely
unwelcome.  It is very likely that not just "git merge" but people's
external scripts depend on the presence of final LF especially when
the description has only one line, so unless we are doing
deliberately so, we should prepare to catch such a change.

If it is because we may gain a consensus that the description string
(which by the way can well consist of multiple lines) is better
without the LF on its final line, and we are "fixing" the code to do
so very much on purpose, it would be good to have a test to protect
such a change from future unintended breakages.  Adding a loose test
that won't break across such a change today may be OK, but whoever
is making such a change in the future has to make sure there is a
test that is not loose to protect the change.  And it would very
likely to be done by adding a new test, instead of noticing that
this loosely written test can be tightened to serve the purpose.

So if we start with a tight test that expects the exact number of
LFs at the end, we would be better off in that case, too.
