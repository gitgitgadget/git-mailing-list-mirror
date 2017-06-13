Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 681601FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 16:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbdFMQVH (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 12:21:07 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36210 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbdFMQVG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 12:21:06 -0400
Received: by mail-pg0-f50.google.com with SMTP id a70so62803451pge.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 09:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3cFYu1exvVmzHcOP0HAD8HDmKRSuU1VAI7afCKebWLQ=;
        b=R1CKyp3jrIWUzreBIu0f8ef9ZtilaZZ1IR7SefaqbmaPTXEqWiQS9aBD/Q9Y+YBLmk
         7yhHLC1GZn5gEC/ru8DnB5yyjzslXX2aquhukKWBBOpNhXseu0HamKyR2juiAeU8kgzc
         +F13zpHtulVXEwX7ja5JQJPI4PhZ/K2N0eHVMkvS4JD9DkysnZAUxcdQqe9eHwG0Mht7
         UlX7cFj63aY98UnAoRk7UndGv3uVwCL3pUn+A7h3JYniazTetSOHfQjVZGR2z/flWcrT
         YLa4GqN46YLdvSogKciyTQPyZTNkmF9Ba0lf4FfwkumnAOcTeDGyW+FZcI1nEPzgLSDe
         pQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3cFYu1exvVmzHcOP0HAD8HDmKRSuU1VAI7afCKebWLQ=;
        b=tFwyrQqaYORJbRNr1H9+IiIpV0en31jAme2IrbKNXyQcgI9T8gf1hwyK6Eyjoatw9M
         5T3MW44XykIr8Xy26BoAsxkN12Uqqqso8lSlyDkYyXkV5T3LP3u1wYAY52blXYDWngPm
         djVR+in28HIBqJ8p9NYItGU3NMdglNikaL/ENMthMCpp+xN6bpAGHKGAEPP5xdICZw5/
         nE/Jc5RrPi6D9TGStWehZ6GouQ+8QUCiyVooDaoIVMpqKdCajUP9IBe0fAik1PYPDjCE
         R/rHvLKRh6Wc12ZvE0LoZ9TLn4/ta4QqYPZkxv4MmMmB0qkv2JMCkvnmjvuJHBiVjgHG
         hT7g==
X-Gm-Message-State: AKS2vOzepZi9NFk4RNqsYKi0tt8a8bwo8E3ksdxzqVng4bisTao3uZOq
        agiMd0VVJyoQDgJ8koqzDcDzIUXihp88JY89SQ==
X-Received: by 10.99.160.82 with SMTP id u18mr477144pgn.176.1497370865077;
 Tue, 13 Jun 2017 09:21:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Tue, 13 Jun 2017 09:21:04 -0700 (PDT)
In-Reply-To: <xmqqvanz9afq.fsf@gitster.mtv.corp.google.com>
References: <20170613023151.9688-1-sbeller@google.com> <xmqqvanz9afq.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Jun 2017 09:21:04 -0700
Message-ID: <CAGZ79kYR+qh1X-dQixdpDbcr5z-DJ2mkdncaVn_8y90kNco9tw@mail.gmail.com>
Subject: Re: [RFC/PATCH] builtin/blame: darken redundant line information
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 8:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> When using git-blame lots of lines contain redundant information, for
>> example in hunks that consist of multiple lines, the metadata (commit name,
>> author, timezone) are repeated. A reader may not be interested in those,
>> so darken them. The darkening is not just based on hunk, but actually
>> takes the previous lines content for that field to compare to.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> Not about "blame", but I was trying the --color-moved stuff on
> Brandon's "create config.h" patch and found its behaviour somewhat
> different from what I recall we discussed.

We discussed several things and we did not come to an agreement,
what is best, so I implemented different things there.

> I thought that the
> adjacentbounds mode was invented to dim (i.e. not attract undue
> attention) to most of the moved lines, but highlight only the
> boundary of moved blocks,

I agree up to this part. And when you use the standard color scheme,
the new/old moved is dimmed according to my perception of colors.

If you use an individual setup for colors, you need to adjust the four
color.diff.{old, new}Moved[Alternative] slots.

> so I expected most of the new and old
> lines in that patch would be shown in the "context" color,

So instead of a special color in this mode you expected "context"
for color.diff.{old, new}Moved and "highlighted" for the alternative slots.

> except
> for the boundary between two blocks of removed lines that have gone
> to different location (and similarly two blocks of new lines that
> have come from different location) would be painted in oldmoved and
> newmoved colors and their alternatives.  Instead I see all old and
> new lines that are moved painted in these colors, without any
> dimming.

http://i.imgur.com/36DMRBl.png is what I see (regular colors,
"git show --color-moved f2f1da5348ff2f297b43b") and
that is what I would expect.

>
> Is my expectation off?

Maybe? It sounds as if you expected 'context' color to be used
in the adjacentbounds.

* Do you expect 'context' to be used in other modes as well?

* Do you expect this as code/algorithm change or would rather
  a change of default colors (default {old/new}Moved = 'context')
  be sufficient to meet that expectation?

* As you have an individual color setup, maybe you can fix this
  for you by setting the appropriate slots to your perception of
  dimmed?

Thanks,
Stefan
