Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1923C3F2D2
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 21:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4882469F
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 21:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="swTWxWLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgB1VQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 16:16:20 -0500
Received: from forward501o.mail.yandex.net ([37.140.190.203]:35162 "EHLO
        forward501o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725886AbgB1VQT (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Feb 2020 16:16:19 -0500
X-Greylist: delayed 329 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Feb 2020 16:16:18 EST
Received: from mxback1j.mail.yandex.net (mxback1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10a])
        by forward501o.mail.yandex.net (Yandex) with ESMTP id B9AEC1E80029;
        Sat, 29 Feb 2020 00:10:45 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback1j.mail.yandex.net (mxback/Yandex) with ESMTP id HEA5WLYtEG-AhEiAsTZ;
        Sat, 29 Feb 2020 00:10:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1582924243;
        bh=uL94S6FZxTvKu67cj5cgSQTFdsw7CSXVdUG2dLt+I84=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=swTWxWLgbiTGIXd/QrYGvn3r1QsaqJfFypYIJ1M2ElNKqinG06bPvZ3pQV5axL03c
         6iRPsT8+O22+kYysvHJaVKG++akG+QYl5DNcsI3stNAc15JzVqtjBvoZ98iY/rNtIb
         R3CEU77PnTrvmP4cFQeGSQ/5S+GhBbAtvrJPHRjY=
Authentication-Results: mxback1j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva6-ab1cb434301d.qloud-c.yandex.net with HTTP;
        Sat, 29 Feb 2020 00:10:43 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
In-Reply-To: <xmqq8skmeabd.fsf@gitster-ct.c.googlers.com>
References: <CAHd499DC7pOB3kD7nAG79GrufKrV-8p4vSZ5ZEPQb5gdXrNakg@mail.gmail.com>
                <CABPp-BGrwNf9p6Ayu=A4CF9ydww8tQfvzFqFO1rNm-QG55yG6w@mail.gmail.com> <xmqq8skmeabd.fsf@gitster-ct.c.googlers.com>
Subject: Re: Why does `pull.rebase` default to `false`?
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 29 Feb 2020 00:10:43 +0300
Message-Id: <1320071582924243@iva6-ab1cb434301d.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



28.02.2020, 23:17, "Junio C Hamano" <gitster@pobox.com>:
> Elijah Newren <newren@gmail.com> writes:
>
>>  On Fri, Feb 28, 2020 at 10:17 AM Robert Dailey <rcdailey.lists@gmail.com> wrote:
>>>  ...
>>>  I'm sure there are edge cases that explain why the default is `false`,
>>>  but I'd argue that it is likely a case of the minority concerns
>>>  becoming an inconvenience for the majority of users.
>>>
>>>  Thanks in advance for any enlightenment!
>>
>>  The default of pull.rebase being false makes a lot of sense for Linus
>>  or any of his lieutenants, or any one else in an integrator-like
>>  workflow.
>>  ...
>>  We may want to do something similar with pull.rebase (only let it
>>  succeed if it's a fast-forward by default, otherwise require the user
>>  to set pull.rebase first?), but I don't want to have to think through
>>  the details or work on such a transition -- I'm just commenting with
>>  some thoughts that might help you understand the current state. And
>>  others probably have more details than me.
>
> While it is true that it would make no sense for integrators to
> rebase (in fact it would be a grave sin for them to do so), I do
> not think the choice of the default has much to do with it.
>
> Whether you keep your work on topic branches, or you only work on a
> single thing at a time and use master for it, an individual
> contributor who is working on a project (be it small or large) can
> do 'pull --rebase' on each topic branch to keep up with the updated
> upstream, but it quickly becomes unpleansant once the topics start
> to get interrelated. And at that point, leaving your 'master' clean
> and only run "pull --ff-only" there, and after doing it once,
> rebasing your multiple topics locally on top of the updated upstream
> (or your 'master', which is a clean copy of it), would start to make
> more sense. And once you start doing that, the only 'pull' you'd do
> would be 'pull --ff-only', and at that point the default value of
> pull.rebase no longer matters.
>
> Sarcastically put, setting pull.rebase=true may become a way to
> ensure that a newbie stays a newbie who does not learn to juggle
> multiple related branches, because only the simplest thing becomes
> easier with the setting.

In reality, newbies often end up doing chaotic merges caused by pull
instead of learning about rebase and branches. IMO, it would be better
to have pull.ff=only as a default.



-- 
Regards,
Konstantin

