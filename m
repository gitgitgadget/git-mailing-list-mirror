Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6109201CF
	for <e@80x24.org>; Thu, 18 May 2017 16:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934311AbdERQ7A (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 12:59:00 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35933 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933350AbdERQ67 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 12:58:59 -0400
Received: by mail-pg0-f41.google.com with SMTP id x64so25486905pgd.3
        for <git@vger.kernel.org>; Thu, 18 May 2017 09:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E33x/W2zwEnShja1aJALiox1D4OZz8IjV36hwcvUlwo=;
        b=FuOGexHd7FzUjgCwbuM52YUkaZeqpqVaq2RkaqkBpiOPRn3YVOrLMWQaXHIi0JSYIJ
         P1BG3znrdODAjOZ6S2CWaAGVR2K615owYel8cd4cbWf+J2RGTYd35ReUZKLD11UPsIAr
         zsXxrLIBqe9d0SUVX3gVvG+HflfF3HX16JodrBOXvjiIXk1jDW6lDmVh/XgaLdGBRcxn
         QcibGTY9PVmNeJLheXSvVh7t5O87cnai1fDwkzM3teaOzTstO5RM5e8c25asNJBnU9Ye
         F4dRNlHeSsP3nm8zFMH9WiDCc11MuJw4yRxYSXamtvDXeZMbbgdWEtQbATrXLbAVfR+C
         aEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E33x/W2zwEnShja1aJALiox1D4OZz8IjV36hwcvUlwo=;
        b=Hn6ZLAa5K0xvIdo5l55ofMOUCjeQeE7CjLIaJQCm1BKAEyatMLw61wGW3nDTtyOOvz
         uA1IjtzsBk/B4fs7Qv7QNa0KCVTlKr0GPy4Lk7l9c02xI64SX6zghnWLg5C6v+t3TkVy
         PKEMFesxz0OyzSivB1nnq5Yj0ilazvSnZfXKwCPIxkL95je3wfY11hd21Eaqy2ailxp4
         Y8ntPTUQ+TPfAp8bkGCfLfe4bxwp+MlmN2G2C5Gz2iwNQUaZGFO0lWzXEelEwVXY+jjS
         5xUTiVqnVBM9VGkB9LPJqMAwdfhmWYGeseIV4g+eBKbpYVSJBKC//2gA4zKlpmQxWqUh
         UOkQ==
X-Gm-Message-State: AODbwcCUqDeHUL805Jaa4KvVoDxHYNNEgQm92yKtkdC58lGKz/mMauKV
        hZ9QjaQLs6kobxWKU7iUWl7gE5Buvm+l
X-Received: by 10.99.56.66 with SMTP id h2mr5704358pgn.40.1495126733431; Thu,
 18 May 2017 09:58:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Thu, 18 May 2017 09:58:53 -0700 (PDT)
In-Reply-To: <20170518011517.xklxkbmkkx6cppdf@sigill.intra.peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu> <eedc8f85c8237515bc66584649b1e3f3d547049c.1495014840.git.mhagger@alum.mit.edu>
 <CAGZ79kb65sv8g6XUQMcGTkZ0ubpY2LYpj7g2wv15knXuv7oKhw@mail.gmail.com> <20170518011517.xklxkbmkkx6cppdf@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 18 May 2017 09:58:53 -0700
Message-ID: <CAGZ79kZ+R_tm5Kv=t9tdXAJwKfevx1qnnNuK5vaXf=xRu1H4eg@mail.gmail.com>
Subject: Re: [PATCH 17/23] get_packed_ref_cache(): assume "packed-refs" won't
 change while locked
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 6:15 PM, Jeff King <peff@peff.net> wrote:
> On Wed, May 17, 2017 at 10:57:34AM -0700, Stefan Beller wrote:
>
>> On Wed, May 17, 2017 at 5:05 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> > If we've got the "packed-refs" file locked, then it can't change;
>> > there's no need to keep calling `stat_validity_check()` on it.
>>
>> This change will work in a world where all Git implementations
>> obey a lock. If there is at least one implementation that doesn't
>> care about the existence of lock files we may introduce a race
>> here.
>>
>> I am not sure if it is worth to be extra careful in the common case
>> though. But I could imagine some people using a git repo on an
>> NFS concurrently with different implementations and one of them
>> is an old / careless lock-ignoring implementation.
>>
>> My opinion is not strong enough that I'd veto such a patch
>> just food for thought.
>
> You're so unbelievably screwed if somebody is not respecting the lock
> that I don't think it's worth considering.
>
> This change just drops the stat_validity_check(), so you may fail to
> realize that somebody racily (without holding the lock!) changed the
> packed refs, and may omit a ref from your traversal if it moved from
> loose to packed. That _can_ have lasting corruption effects if your
> operation is something like "git prune" that is computing full
> reachability.
>
> But even without this change, somebody writing the packed-refs file
> without lock is likely to hose over simultaneous writes and lose ref
> updates (or even lose refs entirely). So anybody who doesn't respect the
> locks is broken, period, and needs to be fixed.

ok, in that case I see no objection for this patch.

Stefan
