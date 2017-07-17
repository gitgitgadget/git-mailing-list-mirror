Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20EE420357
	for <e@80x24.org>; Mon, 17 Jul 2017 19:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbdGQTE5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 15:04:57 -0400
Received: from mail-ua0-f173.google.com ([209.85.217.173]:35538 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbdGQTE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 15:04:56 -0400
Received: by mail-ua0-f173.google.com with SMTP id 64so28696360uae.2
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 12:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Jl4WNkQFCkoIWzKAOYk8Dj7UKaZ1xijrzTeddRLTp1Y=;
        b=N4bRsOref5yOYBF9+jfYHsIA9vIoyg/m96ppMvROHQm2W7rVw8BzXwEneQdQZGHqr5
         5xnkS9n3HYq0vjFuyO0EKaND+S3RF54OYNo5pv+cTr0a7xIEsAjwI7tDsmrZ13cDCBMk
         hwgaAdXpzEx8chOG/2RnmfEXNYDjYfWtWDbd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Jl4WNkQFCkoIWzKAOYk8Dj7UKaZ1xijrzTeddRLTp1Y=;
        b=D6thOAZvfp5uUylVKdXCGXjSc1OgJgZGAuD7kbb8HTQweEnNt+b5fYLJv904A9zQ3/
         Pp928IX3K0ugvuBRJH/0k8uowye+BScd2uweaijqSjEmIf5eITQ5bWmddpclZub64zXY
         BN+nGSkisjm8h//gO3Ssv+w/QWisGd0vO/C8e+9c4n0e2LtZbXGkVDgJaMt/sSDWOrHs
         PcUJVVHZNqlYozDEoAvToqAzPPeZBi3G0wSM5hrw6DX6T78i+xTW63MK7ZPJOkz4OVQt
         x711voupKbEUSu02mb+53eedrkiDQpw7UlgJ3Ck9yNZGuBu3KjALHoxmossJ3HZCU4R6
         81vA==
X-Gm-Message-State: AIVw112SdYH9vk9i6YwV0zrYCe+MK+z2stoxEjKBfpzYFNJOjC+ts9Jv
        MUSFFMuXeNj9dBDkzi6DHJAQKVwVFJVj
X-Received: by 10.176.27.81 with SMTP id n17mr13964137uai.58.1500318294934;
 Mon, 17 Jul 2017 12:04:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.137.4 with HTTP; Mon, 17 Jul 2017 12:04:34 -0700 (PDT)
In-Reply-To: <CAGZ79kaFmxRSp1YBXc=6YEeDGUO-VLBF0yk+Bb0np7x80z_Vog@mail.gmail.com>
References: <CAJo=hJtTp2eA3z9wW9cHo-nA7kK40vVThqh6inXpbCcqfdMP9g@mail.gmail.com>
 <CAGZ79kaFmxRSp1YBXc=6YEeDGUO-VLBF0yk+Bb0np7x80z_Vog@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Mon, 17 Jul 2017 12:04:34 -0700
Message-ID: <CAJo=hJuHsKY5YkmoBqCNvv2tvRdJFtD02JrnUko7iJbpSJWHgQ@mail.gmail.com>
Subject: Re: reftable [v2]: new ref storage format
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 17, 2017 at 11:53 AM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Jul 17, 2017 at 8:01 AM, Shawn Pearce <spearce@spearce.org> wrote:
>
>> A ref block is written as:
>>
>>     'r'
>>     uint24 ( block_len )
>>     ref_record*
>>     uint32( restart_offset )*
>>     uint16( number_of_restarts )
>>     padding?
>>
> ...
>>
>> The 2-byte `number_of_restarts + 1` stores the number of entries in
>> the `restart_offset` list.
>
> This means uint16( number_of_restarts ) cannot be 0, but has to be 1
> to indicate no restarts?

A block must have at least one restart in it, the first ref_record
must be a restart. So number_of_restarts in the tail of the block can
be 0, which implies 1 restart (number_of_restarts + 1), and the first
restart is required at the first ref_record. :)

> When starting to write a block, we need to know exactly how large
> the ref_records* and restart offsets need to be to put the
> number_of_restarts at the position as promised via block_len.
> This sounds complicated unless I missed the obvious.

Correct. The writer needs to compute the block size before it writes
the block. It does so by buffering the block contents until its
approximately full, then fixes block_len, and flushes the block.

> Going by this, would it rather make sense to omit the block_len
> and then scan backwards from *block_size-1 to find the first non-NUL
> and that will be the number_of_restarts?

Not quite. On small reftable files the "physical" block may be shared
with a log block ('g'). We need to be able to reliably find the of the
ref block ('r'), without padding between the two blocks.

> Or we could allow additional padding between ref_record and
> restart_offsets, such that the writer implementation has wiggle room
> for the restarting logic.

I had that in an older format description, and removed it. Placing the
padding at the end of the block was simpler for the reader and writer
implementation to handle.


>> Log record keys are structured as:
>>
>>     ref_name '\0' reverse_int32( time_sec )
>>
>> where `time_sec` is the update time in seconds since the epoch.
>
> The epoch ends 2038, which is in 21 years. (Did you just volunteer
> to fixup the time issues in 20 years?)
> If possible I'd prefer a date to be encoded with more range available.

Good point. However, I think in 20 years we'll see 2 more hash
functions for Git, and we can bump reftable to v2 and expand the field
to 8 bytes.

> The ref names itself are compressed, would we also want to compress
> the timing information?

The time field is also prefix compressed as part of the ref name's
prefix compression. So there is no need to move to the complexity of a
varint or anything else.


>> ### Update transactions
>>
>> Although reftables are immutable, mutations are supported by writing a
>> new reftable and atomically appending it to the stack:
>>
>> 1. Atomically create `stack.lock`
>> 2. Copy current stack to `stack.lock`.
>> 3. Prepare new reftable in temp file `.refXXXXXXX`.
>>    Include log entries.
>> 4. Rename (3) to `${sha1}.ref`.
>> 5. Append `${sha1}.ref` to `stack.lock`
>> 6. Atomically rename `stack.lock` to `stack`.
>
> In case 3.+4. becomes time consuming, it can be prepared outside
> the lock, such that inside the lock we'd only need to check
> for contention of refs? For example if I'd want to update one ref and
> another write wants to update another refs, we'd both be preparing
> the a new refstable containing one ref and log, then one of us obtains
> the lock and writes. The second writer would then need to inspect
> the delta of the stack and see if any ref that they want to change
> was touched.

Excellent point, it reduces the contention window for non-conflicting
writes. I will update this section with your input, thank you Stefan.
