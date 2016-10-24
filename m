Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B935320193
	for <e@80x24.org>; Mon, 24 Oct 2016 19:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933023AbcJXTcg (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 15:32:36 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35686 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbcJXTce (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 15:32:34 -0400
Received: by mail-qk0-f182.google.com with SMTP id z190so245885140qkc.2
        for <git@vger.kernel.org>; Mon, 24 Oct 2016 12:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JprpkpiCnDrwEg/3m+snx37Hxq6l3x9Q1j7eodE2bCM=;
        b=ZqMgO3A45iHlud0/9rdxXNklbmEj9c+Bu3hOXJ5KOcOrDonIH6YtjU/8xa91fygx8z
         msCDYsWYVxfhZzh0WHfyrKhCpv/+3S0KpfFxxflO/vBgdkiXT7Tr/xGG23/jjhhkQD9H
         JOtLw5en1r6exricnBaDovhei7thUbbNlgm7kq1UG+YEFhAQ/lCSJkOUJbKV8NCPhzCV
         tqVixwRRE6p2Scd8ipzueHA82ak5Tl68Syh0xC6A6TNq5dQxA2SgkpxbWhTnV4g8qqeX
         xCWUhMt/crT3OAeIwXQXdjCgbR2oVejIIeJ8fsnAmVPzHfDJ0G02lA6iLzmjaRjANTc0
         mOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JprpkpiCnDrwEg/3m+snx37Hxq6l3x9Q1j7eodE2bCM=;
        b=KckdTR6bkGiV1+178dNSlsfyETX5lnqUEqnX10WqoeGaCEVBQRIqp9/D66LKT0A5i/
         AHIbjjBqWNXU1ocp5bK3wgNckYHpXvdXniZSV9w6Q1ND/ZpwH3tWYgGLyWdSzTP4rQUJ
         VLlufXkpyfbVNLS2UM7kQ8LzFJSWLF/wOas/wGvzngBZrI2A+AjxRV85nBn+dfocp/8n
         Sk5TR90lfUJZiSP7WqYfHQ2dWvMFwwh8NGW73b3CIo82ano7UMo8KgUX/RtywjqnbK65
         982naivCt9TH99WVz+512ap1o28puSsGitypE6n3UtePaDJGwrllKjHHaYp2hVfpFjIh
         tgeQ==
X-Gm-Message-State: ABUngvcFjGC6MuULzRG2MxGO83Tz41OnX1MA9GdleE6FCiIb6BvTcbr0URO+3ERnXRT5jXNdBcGfeLIAnmB/+7go
X-Received: by 10.55.142.130 with SMTP id q124mr15357383qkd.220.1477337553438;
 Mon, 24 Oct 2016 12:32:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Mon, 24 Oct 2016 12:32:32 -0700 (PDT)
In-Reply-To: <xmqqmvht5zwx.fsf@gitster.mtv.corp.google.com>
References: <20161022233225.8883-1-sbeller@google.com> <20161022233225.8883-29-sbeller@google.com>
 <xmqqmvht5zwx.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Oct 2016 12:32:32 -0700
Message-ID: <CAGZ79kZ_7eG4uCXwyg0F=-hjmuT1dCAATSRnY293qkNC6siM5Q@mail.gmail.com>
Subject: Re: [PATCH 28/36] attr: keep attr stack for each check
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 24, 2016 at 12:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Instead of having a global attr stack, attach the stack to each check.
>
> Two threads may be working on "git checkout", one "git_attr_check"
> in convert.c may be used by them to learn the EOL conversion for
> each path, and these threads are working in different parts of
> worktree in parallel.  The set of .gitattributes files each of these
> threads wants to be cached at one time is tied to where in the
> directory hierarchy the thread is working in.
>
> The view by API users would not have to change from the point on
> since 27/36 or so, but I think attr_stack needs to become per
> <check, thread> tuple when we are fully thread-ready for the above
> reason.

I looked for a platform independent way to get a thread id as a natural
number, i.e. I want to get 1,2,3,... such that I could have just added
list/array of attr stacks to each check, which would be the
<check, thread> tuple you envision.

However I think we do not really need it to be per check.  If we had
an easy portable way of getting such a thread id, I would have implemented
a list of stacks per thread first. (Because each thread only looks at one
check at a time.)

So this is not a baby step because I did not want to do it all at once, but
because I did not find a suitable API to use.

>
> But we need to start somewhere to move away from the current "one
> single attr stack" to "there are multiple attr stacks", and this
> "two checks may and do use different attr stacks" is probably a
> reasonable first step.  It may give a single-threaded API users
> immediate benefit if the "read and keep only the entries relevant
> to the query" optimization is done with this step alone, without
> making the cache per <check, thread> pair.
>
>> This allows to use the attr in a multithreaded way.
>
> With manipulation of attr stack protected with a single Big
> Attributes Lock, this should be safe.  It may not perform very well
> when used by multiple threads, though ;-)

I agree. So maybe it is not really a good fit for general consumption yet.
