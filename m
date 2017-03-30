Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F0541FAFB
	for <e@80x24.org>; Thu, 30 Mar 2017 08:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755159AbdC3IlH (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 04:41:07 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34801 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754908AbdC3Ikk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 04:40:40 -0400
Received: by mail-lf0-f45.google.com with SMTP id z15so21500003lfd.1
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 01:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sJyQfI8iHe41gEIOYGaumzOQ8r3gzGWNjBnEFWmSIrU=;
        b=SF51in3H7JNdV+eguszrHMpNvlEfLTahYiLhcOQV8GiNtY+Ifd9WwNZawX8jX+s4dK
         6JDVqPar5td5j9+U2MoeWpuJ/uhqKq2f/Sc3HNrggIWfa1isoAxBYL9IPk373jGBdD46
         KIMBsEGx0+hqNA9qM/2EgI3OkzmX8eqysQTFhi+XGkswV3l8IGNC7z3PJOy3dIFTcHKU
         jmT7PAuME15X9lSAftGCPACRdnmT3Aau67EUN0C9IFPmJUtGHZNfvq6xIxJ+blCSSkue
         hyRh3K+fbRrNIdgjjvRIflXSyJgaNXTm37IGY6hQ6GwWz87gnST5Y8FHt5WwKNKLoTtd
         yTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sJyQfI8iHe41gEIOYGaumzOQ8r3gzGWNjBnEFWmSIrU=;
        b=k3pubjYakHOaZRQW5p8G0ek7GJAVQKm6wiUQ0ISfmljo7OTmTqa6qSr1/eBsrmpQUp
         uMK0fudZYSLEksDETExRE2T8Vx8bRuJN11LZ4nA1tBO9HcNwil6JGMAuanoLW8yeY+u2
         K144Pz/uyZtvN3qFwdhTIr78iJzNvZLHxjfEz2emAGSa3lyWo0ZdWk9NH5R2yg6L6SHD
         lOwDr2SlyEWk/8pgmhB+bZYzU71stBXxabhdQBTQdvu5RBAcXQjSJJNwUrR02jwmXqSE
         2egEPkoM21MMxA4Q83zdJQqVTFp2mmpceDbdWni/54PrmZzaLuhdBCsj+Pai3uApZhnf
         xtTg==
X-Gm-Message-State: AFeK/H2Z80Qz1t1w5B7VKdhEQOXdoBL7qKIDvZr6omFCP9V4jNLNJ5xAjU/aziw4/pTSTaaXz8yolv26jMwJjw==
X-Received: by 10.46.75.25 with SMTP id y25mr1800946lja.60.1490863238542; Thu,
 30 Mar 2017 01:40:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.150.10 with HTTP; Thu, 30 Mar 2017 01:40:38 -0700 (PDT)
In-Reply-To: <20170329175614.uecvtvmzoj2wfle3@sigill.intra.peff.net>
References: <20170329080820.8084-1-chriscool@tuxfamily.org>
 <xmqqfuhwau6r.fsf@gitster.mtv.corp.google.com> <20170329175614.uecvtvmzoj2wfle3@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 30 Mar 2017 10:40:38 +0200
Message-ID: <CAP8UFD29xWU5bHwewUSq26pVTwK-gy3uSVG2aGTCrDak3620=A@mail.gmail.com>
Subject: Re: [PATCH] read-cache: avoid git_path() race in freshen_shared_index()
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2017 at 7:56 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 29, 2017 at 10:06:52AM -0700, Junio C Hamano wrote:
>
>> > This shows that we should be careful not to use git_path() in
>> > freshen_shared_index(). It is using a shared buffer that can
>> > too easily lead to races.
>>
>> The impression I get from the symptom is that after git_path() is
>> called here, before check_and_freshen_file() uses that result, it
>> (or functions it calls) uses git_path(), and the number of times it
>> does so has changed since cc/split-index-config was written on the
>> mainline, and the rotating 4-element buffer get_pathname() gives is
>> now exhausted, leading to the failure you observed.  By the way,
>> that does not sound a race to me.
>>
>> In any case, that explains why bisect says the merge is the first
>> bad one, and cures the confused reader ;-) The use of git_path() on
>> the topic was still safe; it was a timebomb waiting to go off.  The
>> mainline started using more calls and the merge result was unsafe.
>
> Yeah, it looks like that is what happened. I see that Christian bisected
> the rebase to find the commit in the series that introduces the problem.
> I'm mildly curious which commit upstream created the problem[1].

I bisected it to 18633e1a22 (rebase -i: use the rebase--helper
builtin, 2017-02-09).
This commit is indeed changing how the interactive rebase works, but
it is not easy to see how it impact git_path() usage.

> There's a reasonable chance it's some innocent-looking cleanup (possibly
> one of my recent "stop using a fixed buffer" ones).
>
> But in the end it doesn't really matter. I think code like:
>
>   const char *filename = git_path(...);
>
> or
>
>   nontrivial_function(git_path(...));
>
> is an anti-pattern. It _might_ be safe, but it's really hard to tell
> without following the complete lifetime of the return value. I've been
> tempted to suggest we should abolish git_path() entirely. But it's so
> darn useful for things like unlink(git_path(...)), or other direct
> system calls.

Yeah, I am very tempted to just rewrite the commit message like this:

------------

When performing an interactive rebase in split-index mode,
the commit message that one should rework when squashing commits
can contain some garbage instead of the usual concatenation of
both of the commit messages.

Bisecting shows that c3a0082502 (read-cache: use
freshen_shared_index() in read_index_from(), 2017-03-06) is involved,
which points to the unsafe use of git_path() in
freshen_shared_index().

------------

and change the subject to "read-cache: avoid using git_path() in
freshen_shared_index()".
