Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E6B01F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 22:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754262AbcJKWuj (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 18:50:39 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34364 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752789AbcJKWui (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 18:50:38 -0400
Received: by mail-qk0-f180.google.com with SMTP id f128so9631171qkb.1
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 15:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ruZkaAI96g9nPdR5X0GRI1i6s6hlf4LnjKSoGTncaqk=;
        b=VLQTeEmiSDDiTR7Z2jvJe5iGiir4DT4JsTFGFO9NO1H2j3CJbKNNi5+7Ywu9gHySIG
         YkMFOgQhnfIws+/SAiV8JhB9uMTk4Df5ocxoZLVFpZ8P9O7qpHd4SMp+Wy2JHMx8l99l
         jlvIX1S21J3nYYur9PCtzVYaZKX6k5y7IOLTVZ+eyIFtFH07zl+c6VPNngO89qfxwVf9
         /ZlL+jQIqksf6ni/qSNXbq/HltOCrSN6dFtnlgswXFSGK/3cu2X1O6L9+EbM1c3EdmNi
         JHHfbeLkY0EEyNFp5ep+udF7dKDkz7EaFeNv5XqlJgZBIZ83tD2YIjFYTsAtv8FfnNSS
         BuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ruZkaAI96g9nPdR5X0GRI1i6s6hlf4LnjKSoGTncaqk=;
        b=CmhCPUdZzIb9M7ruoCWdCWzChJVC5nGv8UCrzD5PzCLoT5KaTAGs+8dH7zplgLq2IU
         DNEQYopi6M7XRmiN8dZ3ooVfKn6Rdpqj05Ae/HzlsK1/Sr0+FYmgcOEt/PUxtl9XQMJf
         vEwzPz0Sy0kJrOdtTfCb+O2Q4R2kKhboerLs1iXx18TeBVIa5zQgelDXOnG7rMYPggSn
         Vw1zWOQfeOwHdXsOEvM/uLqlABHuxOd6PFjR6gw+OqjvvcKEEfSZikgdlmne6jEdJYQm
         X0drtoHaHrwEB6nB4zGbQ7VDVbN7AMs5boxPFqN8WiCOobNX3GLdqGP4q9hPcO+vi32S
         KKhg==
X-Gm-Message-State: AA6/9RkkSRhrOGnVMSl9ykmuYvpK74xUDElzWCqIwaLHfF8GeNQE9YukAPsxHSG2CMinC5pws1vDSzbGH7x6yuEc
X-Received: by 10.55.56.11 with SMTP id f11mr5357627qka.255.1476226237144;
 Tue, 11 Oct 2016 15:50:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 11 Oct 2016 15:50:36 -0700 (PDT)
In-Reply-To: <xmqqa8ea7bsh.fsf@gitster.mtv.corp.google.com>
References: <CANXboVZvfPkTQ10PWop+LgPFpc2bD3-u-e5ix0itGawiwCxOuQ@mail.gmail.com>
 <CAGZ79kZmrYZqi4+bSkRykn+Upt7bEyZ0N8VhiQ-h8DhSMym-FA@mail.gmail.com> <xmqqa8ea7bsh.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Oct 2016 15:50:36 -0700
Message-ID: <CAGZ79kZNvTvk4uZa8xhxZABKtzS9A5HoumJ37AacuZnHaZ4+Xw@mail.gmail.com>
Subject: Re: Make `git fetch --all` parallel?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ram Rachum <ram@rachum.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 3:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> So I do think it would be much faster, but I also think patches for this would
>> require some thought and a lot of refactoring of the fetch code.
>> ...
>> During the negotiation phase a client would have to be able to change its
>> mind (add more "haves", or in case of the parallel fetching these become
>> "will-have-soons", although the remote figured out the client did not have it
>> earlier.)
>
> Even though a fancy optimization as you outlined might be ideal, I
> suspect that users would be happier if the network bandwidth is
> utilized to talk to multiple remotes at the same time even if they
> end up receiving the same recent objects from more than one place in
> the end.

I agree. Though even for implementing the "dumb" case of fetching
objects twice we'd have to take care of some racing issues, I would assume.

Why did you put a "sleep 2" below?
* a slow start to better spread load locally? (keep the workstation responsive?)
* a slow start to have different fetches in a different phase of the
fetch protocol?
* avoiding some subtle race?

At the very least we would need a similar thing as Jeff recently sent for the
push case with objects quarantined and then made available in one go?

>
> Is the order in which "git fetch --all" iterates over "all remotes"
> predictable and documented?

it is predictable, as it is just the same order as put by grep in
$ grep "\[remote " .git/config, i.e. in order of the file, which in my
case turns out to be sorted by importance/history quite naturally.
But reordering my config file would be not a big deal.

I dunno, if documented though.

> If so, listing the remotes from more
> powerful and well connected place to slower ones and then doing an
> equivalent of stupid
>
>         for remote in $list_of_remotes_ordered_in_such_a_way

list_of_remotes_ordered_in_such_a_way is roughly:
$(git config --get-regexp remote.*.url | tr '.' ' ' |awk '{print $2}')

>         do
>                 git fetch "$remote" &
>                 sleep 2
>         done
>
> might be fairly easy thing to bring happiness.

I would love to see the implementation though, as over time I accumulate
a lot or remotes. (Someone published patches on the mailing list and made
them available somewhere hosted? Grabbing them from their hosting site
is easier than applying patches for me, so I'd rather fetch them... so I have
some remotes now)
