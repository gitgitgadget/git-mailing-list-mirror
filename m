Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 046512055E
	for <e@80x24.org>; Sun, 29 Oct 2017 03:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbdJ2DNP (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 23:13:15 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:43029 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbdJ2DNO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 23:13:14 -0400
Received: by mail-qk0-f170.google.com with SMTP id w134so12543511qkb.0
        for <git@vger.kernel.org>; Sat, 28 Oct 2017 20:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WxumJFyeywjkg5YeXAOrSuAw1Nirdekr86IDCmIyyXU=;
        b=ZQaXXfuJWCRXfPkSOuRV2/MpAZNyvlwrtlVr02bgqrh3vlccBdiQvuQBzORjmdbwZ2
         8xZIJw3eqY2XBY6RqjWbvWj+ziA9CPPTQ57i3UJRbI3i22P9CkOouqIYNmbczTHf0xAP
         K1SdBnrMg5T4E+ARHdhKLkd1BFjFMg3NghEh+kDbeTxcE4xgd1xta/fKq1V3p0KUjbEG
         5+65XzcecQVLT1oAA8K/KHFqffNAVelQ9lX/mLBjsxFqCSItISz4qQZmmXNM0wSQB+Wm
         DFa0s44hnuyq25De1jla/EMTRNXExtmKqDCepmbcl0HZ4aKXFbcd3UQWq7snAtiD40N+
         ii2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WxumJFyeywjkg5YeXAOrSuAw1Nirdekr86IDCmIyyXU=;
        b=clmgS42m86NwXd7bw8uSqNSqSHxcHNJwL57osi8F01r+zHrxoFYKolVrbG2scewnOU
         yGRXXLMatkYWUjuvAuUgEOYbdjE9gpdeLhbxvtkGI6tZxShVgi6d7n1+kecLsDPDoZq1
         lxxPD85/SphF6/ik9zqzfzsKNV/aWFjeaCrjIpaxQkcEs41hPzkXasCl1xCWQKbVonMe
         /mSvnDdXp0RLLYv+E9oduK09s6BX24k7fP7sFNgePCRXLXRuax0uA94oBij/IH5TDNN9
         965DW4WgyHUq05YzyHi6aEmU+sTS5I5SVlMEv8kk4BMXVQgGvNaJpYjxLaiun+8sLOa7
         AmBg==
X-Gm-Message-State: AMCzsaV6l1lI8DqJ5CXCW9DYJX0JZMytQtn+t2+habdhweqiCgURShDi
        fHDagIEx3W4TFSnxDEJTDwmUfDOip/QRVbhomb5v2g==
X-Google-Smtp-Source: ABhQp+SFOdzQL1VY9dz0mgEsoUc41x/BW88xp3SbCkUx3/SPbcDoSimcss+Rn3j4s7rWX0NCFoIiUZpQ/8eRRiX4Dzk=
X-Received: by 10.55.111.3 with SMTP id k3mr7449208qkc.332.1509246793073; Sat,
 28 Oct 2017 20:13:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Sat, 28 Oct 2017 20:13:12 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1710281913060.6482@virtualbox>
References: <20171028004419.10139-1-sbeller@google.com> <20171028004506.10253-1-sbeller@google.com>
 <alpine.DEB.2.21.1.1710281913060.6482@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Sat, 28 Oct 2017 20:13:12 -0700
Message-ID: <CAGZ79kaYdgf809z=DebzuUzuWbxgc5RFwz96yeh5gQb2JV0LoQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] list-objects.c: factor out traverse_trees_and_blobs
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 28, 2017 at 10:15 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Stefan,
>
> [I was intrigued enough by your work to postpone to later this coming week
> reading the What's cooking email in favor of reviewing your patch series.]
>
> On Fri, 27 Oct 2017, Stefan Beller wrote:
>
>> With traverse_trees_and_blobs factored out of the main traverse function,
>> the next patch can introduce an in-order revision walking with ease.
>
> Makes sense.
>
>> diff --git a/list-objects.c b/list-objects.c
>> index b3931fa434..0ee0551604 100644
>> --- a/list-objects.c
>> +++ b/list-objects.c
>> @@ -183,25 +183,13 @@ static void add_pending_tree(struct rev_info *revs, struct tree *tree)
>>       add_pending_object(revs, &tree->object, "");
>>  }
>>
>> -void traverse_commit_list(struct rev_info *revs,
>> -                       show_commit_fn show_commit,
>> -                       show_object_fn show_object,
>> -                       void *data)
>> +static void traverse_trees_and_blobs(struct rev_info *revs,
>> +                                  struct strbuf *base,
>
> In the context of one function, it was obvious what `base` meant. Maybe we
> can call it `base_path` now?

I was intrigued to keep the base local to the factored out function, but that
would mean, we'd have to allocate memory for it in every call. That I wanted
to avoid, so the only reason to pass it in, is memory management.

base_path sounds good, will rename.

Thanks for the review!
Stefan

>
> Thanks,
> Dscho
